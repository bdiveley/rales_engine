class Transaction < ApplicationRecord
  belongs_to :invoice
  validates_presence_of :credit_card_number, :result

  scope :successful, -> { where(result: "success")}

  def self.trans_by_customer(cust_id)
    joins(:invoice).where("invoices.customer_id = #{cust_id}")
  end
end
