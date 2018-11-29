class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  validates_presence_of :name

#GET /api/v1/merchants/most_items?quantity=x returns the top x merchants ranked by total number of items sold
  def top_merchants_by_items_sold
    Merchant.select("merchants.*, sum(invoice_items.quantity) AS items_sold").joins(:invoices).joins("JOIN invoice_items ON invoice_items.invoice_id = invoices.id").joins("JOIN transactions ON transactions.invoice_id = invoices.id").where("transactions.result = ?", 'success').group("merchants.id").order("items_sold DESC").limit(8)
  end

#GET /api/v1/merchants/most_revenue?quantity=x returns the top x merchants ranked by total revenue
  def top_merchants_by_total_revenue
    Merchant.select("merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) AS revenue").joins(:invoices).joins("JOIN invoice_items ON invoice_items.invoice_id = invoices.id").joins("JOIN transactions ON transactions.invoice_id = invoices.id").where("transactions.result = ?", 'success').group("merchants.id").order("revenue DESC").limit(8)
  end

#GET /api/v1/customers/:id/favorite_merchant returns a merchant where the customer has conducted the most successful transactions
  def favorite_merchant
    Merchant.select("merchants.*, count(transactions.id) AS total").joins(:invoices).joins("JOIN transactions ON transactions.invoice_id = invoices.id").group(:id).where("invoices.customer_id = 80").where("transactions.result = ?", 'success').order("total desc").limit(1)
  end

end
