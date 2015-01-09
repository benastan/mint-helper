require 'timeout'
require 'capybara-webkit'
require 'selenium-webdriver'
require 'capybara'
require 'capybara/dsl'
require 'launchy'
require "pry"
require 'fileutils'

module Mint
  module Helper
    class Scraper
      include Capybara::DSL

      def perform
        Capybara.current_driver = :webkit
        Capybara.app_host = 'http://wwws.mint.com'
  
        visit '/transaction.event'
        log 'Logging In'
        wait_for { page.current_path == '/login.event' }
        fill_in 'Email', with: Email
        fill_in 'Password', with: Password
        first('#submit').click
        wait_for { page.current_path == '/transaction.event' }
        log 'Downloading Transactions'
        find('#transactionExport').click
        log 'Saving Transactions'
        wait_for { page.current_path == '/transactionDownload.event' }
        write(page.html)
        log 'Done!'
      rescue Timeout::Error
        save_and_open_page
      end

      private

      def write(data)
        FileUtils.mkdir_p(DataDirectory)
        file = File.open(DataDirectory.join(filename), 'wb+')
        file.write(data)
        file.close
      end

      def filename
        '%s.csv' % Time.new.strftime('%FT%T')
      end

      def log(message)
        now = Time.new - (3600 * 8)
        pst = Time.new(now.year, now.month, now.day, now.hour, now.min, now.sec, '-08:00')
        print("%s: %s\n" % [ pst.strftime('%FT%T'), message ])
      end

      def wait_for
        Timeout::timeout(60) { sleep 0.1 while !yield }
      end
    end
  end
end
