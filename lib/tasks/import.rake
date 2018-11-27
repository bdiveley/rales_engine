require 'csv'

namespace :import do
  task :data => :environment do
    CSV.foreach('db/csv/merchants.csv', :headers => true, header_converters: :symbol) do |row|
      Merchant.create(row.to_hash)
    end
  end
end
