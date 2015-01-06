require "bundler/gem_tasks"
require 'mint/helper'

desc 'Scrape your mint account'
task :scrape do
  Mint::Helper::Scraper.new.perform
  print "succeeded"
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
task :notify do
  Mint::Helper::Notifier.new.send
end

task default: [:scrape, :migrate, :import, :notify]