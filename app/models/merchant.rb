class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  validates_presence_of :name

  def self.merchant_by_item(item_id)
    joins(:items).where("items.id = #{item_id}").first
  end
  
#GET /api/v1/merchants/most_items?quantity=x returns the top x merchants ranked by total number of items sold
  def self.top_merchants_by_items_sold(num_merchants)
    Merchant.select("merchants.*, sum(invoice_items.quantity) AS items_sold").joins(:invoices).joins("JOIN invoice_items ON invoice_items.invoice_id = invoices.id").joins("JOIN transactions ON transactions.invoice_id = invoices.id").merge(Transaction.successful).group("merchants.id").order("items_sold DESC").limit(num_merchants)
  end

  def self.top_merchants_by_total_revenue(num_merchants)
    Merchant.select("merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) AS revenue").joins(:invoices).joins("JOIN invoice_items ON invoice_items.invoice_id = invoices.id").joins("JOIN transactions ON transactions.invoice_id = invoices.id").merge(Transaction.successful).group("merchants.id").order("revenue DESC").limit(num_merchants)
  end

#GET /api/v1/customers/:id/favorite_merchant returns a merchant where the customer has conducted the most successful transactions
  def self.favorite_merchant(customer_id)
    Merchant.select("merchants.*, count(transactions.id) AS total").joins(:invoices).joins("JOIN transactions ON transactions.invoice_id = invoices.id").group(:id).where("invoices.customer_id = #{customer_id}").merge(Transaction.successful).order("total desc").limit(1)
  end

end
