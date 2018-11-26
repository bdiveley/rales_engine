require "csv"

namespace :import do
  task "customers": :environment do
    CSV.foreach('db/csv/customers.csv') do |row|
      Customer.create(row.to_hash)
    end
  end
end 
