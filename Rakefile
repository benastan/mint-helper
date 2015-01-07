require "bundler/gem_tasks"
require 'mint/helper'

desc 'Scrape your mint account'
task :scrape, :retries do |task, args|
  args[:tries] ||= 3

  Retriable.retriable(tries: args[:tries]) do  
    Mint::Helper::Scraper.new.perform
    print "succeeded"
  end
end

desc 'Migrate the database'
task :migrate do
  `sequel -m ./migrate #{ENV['DATABASE_URL']}`
end

desc 'Import to the database from csv data'
task :import do
  query = %q(COPY transactions FROM '%s' DELIMITER ',' CSV HEADER) % Mint::Helper.latest_csv_path
  Mint::Helper::Database.execute('TRUNCATE transactions')
  Mint::Helper::Database.execute(query)
end

desc 'Send notification email'
task :notify, :template do |task, args|
  Mint::Helper::Notifier.new(args[:template]).send
end

task setup: [ :scrape, :migrate, :import ]
task default: [ :setup, :notify ]
