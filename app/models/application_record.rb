class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.find_random
    limit(1).order("RANDOM()").first
  end

  def self.find_by_invoice_item(inv_item_id)
    joins(:invoice_items).where("invoice_items.id = #{inv_item_id}").first
  end

  def self.find_by_invoice(inv_id)
    joins(:invoices).where("invoices.id = #{inv_id}").first
  end
end
