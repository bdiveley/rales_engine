class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  validates_presence_of :status

  def self.find_by_transaction(trans_id)
    joins(:transactions).where("transactions.id = #{trans_id}").first
  end

#GET /api/v1/items/:id/best_day returns the date with the most sales for the given item using the invoice date.
  def self.best_day(id_of_item)
    Invoice.select("invoices.created_at, sum(invoice_items.quantity) AS best_day").joins(:invoice_items).where("invoice_items.item_id = #{id_of_item}").group("invoices.id").order("best_day desc, invoices.created_at desc").limit(1).first
  end

  def self.total_revenue_by_merchant(merch_id)
    Invoice.select("sum(invoice_items.quantity*invoice_items.unit_price) AS revenue").joins(:invoice_items, :transactions).group("invoice_items.id").merge(Transaction.successful).where("invoices.merchant_id = ?", "#{merch_id}").pluck("sum(invoice_items.quantity*invoice_items.unit_price) AS revenue").sum
  end

  def self.total_revenue_by_date(date)
    Invoice.select("SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue").joins(:invoice_items, :transactions).group("invoice_items.id").merge(Transaction.successful).where("cast(invoices.created_at AS text) Like '#{date}%'").pluck("SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue").sum
  end

  def self.total_revenue_per_merchant_by_date(merch_id, date)
    Invoice.select("SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue").joins(:invoice_items, :transactions).group("invoices.id, invoices.merchant_id").merge(Transaction.successful).where("cast(invoices.created_at AS text) Like '#{date}%'").where("invoices.merchant_id = ?", merch_id).first.revenue
  end
end
