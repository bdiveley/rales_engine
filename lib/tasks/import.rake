require 'csv'

namespace :import do
  task :data => :environment do
    CSV.foreach('db/csv/merchants.csv', :headers => true, header_converters: :symbol) do |row|
      # Merchant.create(row.to_hash)
      id = row[0].to_i
      name = row[1]
      created_at = Time.parse(row[2])
      updated_at = Time.parse(row[3])
      Merchant.create(id: id, name: name, created_at: created_at, updated_at: updated_at)
    end
    CSV.foreach('db/csv/customers.csv', :headers => true, header_converters: :symbol) do |row|
      Customer.create(row.to_hash)
    end
  end
end
