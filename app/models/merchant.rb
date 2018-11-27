class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  validates_presence_of :name

  def self.find_random
    Merchant.limit(1).order("RANDOM()").first
  end
end
