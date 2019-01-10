require 'csv'

namespace :import do
  task :data => :environment do
    CSV.foreach('db/csv/merchants.csv', :headers => true, header_converters: :symbol) do |row|
      Merchant.create(row.to_hash)
    end
    CSV.foreach('db/csv/customers.csv', :headers => true, header_converters: :symbol) do |row|
      Customer.create(row.to_hash)
    end
    CSV.foreach('db/csv/items.csv', :headers => true, header_converters: :symbol) do |row|
      Item.create(row.to_hash)
    end
    CSV.foreach('db/csv/invoices.csv', :headers => true, header_converters: :symbol) do |row|
      Invoice.create(row.to_hash)
    end
    CSV.foreach('db/csv/invoice_items.csv', :headers => true, header_converters: :symbol) do |row|
      InvoiceItem.create(row.to_hash)
    end
    CSV.foreach('db/csv/transactions.csv', :headers => true, header_converters: :symbol) do |row|
      Transaction.create(row.to_hash)
    end
  end
end
