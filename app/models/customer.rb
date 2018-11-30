class Customer < ApplicationRecord
  has_many :invoices
  validates_presence_of :first_name, :last_name

#GET /api/v1/merchants/:id/favorite_customer returns the customer who has conducted the most total number of successful transactions.
  def self.favorite_customer(merch_id)
    Customer.select("customers.*, count(transactions.id) AS total").joins(:invoices).joins("JOIN transactions ON transactions.invoice_id = invoices.id").group(:id).where("invoices.merchant_id = #{merch_id}").merge(Transaction.successful).order("total desc").limit(1)
  end
end
