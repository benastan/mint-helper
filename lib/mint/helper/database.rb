require 'sequel'

module Mint
  module Helper
    Database = Sequel.connect(ENV['DATABASE_URL'])
  end
end