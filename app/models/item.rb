class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name, :description, :unit_price

#GET /api/v1/items/most_revenue?quantity=x returns the top x items ranked by total revenue generated
  def top_items_by_total_revenue
    Item.select("items*, sum(invoice_items.quantity*invoice_items.unit_price) AS revenue").joins(:invoice_items).joins("JOIN invoices ON invoice_items.item_id = invoices.id").joins("JOIN transactions ON transactions.invoice_id = invoices.id").where("transactions.result = ?", 'success').group(:id).order("revenue DESC").limit(1)
  end

#GET /api/v1/items/most_items?quantity=x returns the top x item instances ranked by total number sold
  def top_items_by_items_sold
    Item.select("items.*, sum(invoice_items.quantity) AS revenue").joins(:invoice_items).joins("JOIN invoices ON invoice_items.item_id = invoices.id").joins("JOIN transactions ON transactions.invoice_id = invoices.id").where("transactions.result = ?", 'success').group(:id).order("revenue DESC").limit(1)
  end
end
