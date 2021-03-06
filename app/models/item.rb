class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name, :description, :unit_price

  def self.items_by_invoice(inv_id)
    joins(:invoice_items, :invoices).where("invoices.id = #{inv_id}").group(:id)
  end

  def self.top_items_by_total_revenue(num_items)
    Item.select("items.*, sum(invoice_items.quantity*invoice_items.unit_price) AS revenue").joins(:invoice_items).joins("JOIN invoices ON invoice_items.invoice_id = invoices.id").joins("JOIN transactions ON transactions.invoice_id = invoices.id").merge(Transaction.successful).group(:id).order("revenue DESC").limit(num_items)
  end

  def self.top_items_by_items_sold(num_items)
    Item.select("items.*, sum(invoice_items.quantity) AS revenue").joins(:invoice_items).joins("JOIN invoices ON invoice_items.invoice_id = invoices.id").joins("JOIN transactions ON transactions.invoice_id = invoices.id").merge(Transaction.successful).group(:id).order("revenue DESC").limit(num_items)
  end
end
