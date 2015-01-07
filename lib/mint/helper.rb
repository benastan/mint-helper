require 'pathname'
require 'retriable'
require "active_support/core_ext/date"
require "active_support/core_ext/time"
require "active_support/core_ext/integer"
require "mint/helper/version"
require "mint/helper/scraper"
require "mint/helper/database"
require "mint/helper/transaction"
require "mint/helper/notifier"

module Mint
  Email = ENV['MINT_EMAIL']
  Password = ENV['MINT_PASSWORD']

  module Helper
    DataDirectory = Pathname('./data')

    def self.latest_csv_path
      Dir.glob(DataDirectory.expand_path.join('*.csv')).last
    end
  end
end
