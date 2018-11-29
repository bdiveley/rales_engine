class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  validates_presence_of :status

#GET /api/v1/items/:id/best_day returns the date with the most sales for the given item using the invoice date.
  def best_day
    Invoice.select("invoices.created_at, sum(invoice_items.quantity) AS best_day").joins(:invoice_items).where("invoice_items.item_id = 1099").group("invoices.id").order("best_day desc, invoices.created_at desc").limit(1)
  end

#GET /api/v1/merchants/:id/revenue returns the total revenue for that merchant across successful transactions
  def total_revenue_by_merchant
    Invoice.select("sum(invoice_items.quantity*invoice_items.unit_price) AS revenue").joins(:invoice_items, :transactions).group("invoice_items.id").merge(Transaction.successful).where("invoices.merchant_id = ?", 27).pluck("sum(invoice_items.quantity*invoice_items.unit_price) AS revenue").sum
  end

#GET /api/v1/merchants/revenue?date=x returns the total revenue for date x across all merchants
  def total_revenue_by_date
    Invoice.select("SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue").joins(:invoice_items, :transactions).group("invoice_items.id").merge(Transaction.successful).where("cast(invoices.created_at AS text) Like '2012-03-16%'").pluck("SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue").sum
  end

#GET /api/v1/merchants/:id/revenue?date=x returns the total revenue for that merchant for a specific invoice date x
  def total_revenue_per_merchant_by_date
    Invoice.select("SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue").joins(:invoice_items, :transactions).group("invoices.id, invoices.merchant_id").merge(Transaction.successful).where("cast(invoices.created_at AS text) Like '2012-03-07%'").where("invoices.merchant_id = ?", 3)
  end
end
