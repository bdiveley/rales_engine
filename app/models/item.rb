class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name, :description, :unit_price

#GET /api/v1/items/most_revenue?quantity=x returns the top x items ranked by total revenue generated
  def top_items_by_total_revenue
  end

#GET /api/v1/items/most_items?quantity=x returns the top x item instances ranked by total number sold
  def top_items_by_items_sold
  end


end
