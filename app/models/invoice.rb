class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  validates_presence_of :status

#GET /api/v1/merchants/revenue?date=x returns the total revenue for date x across all merchants
  def total_revenue_by_date
    Invoice.select("SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue").joins(:invoice_items, :transactions).merge(Transaction.unscoped.successful).group("invoice_items.id").where("cast(invoices.created_at AS text) Like '2012-03-16%'").pluck("SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue").sum
  end

#GET /api/v1/items/:id/best_day returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, return the most recent day
  def
    Invoice.select("invoices.created_at, sum(invoice_items.quantity) AS units").joins(:invoice_items).where("invoice_items.item_id = 1099").group("invoices.id").order("units desc, invoices.created_at desc").limit(1)
  end
end
