class Merchant < ApplicationRecord

  def self.find_random
    Merchant.limit(1).order("RANDOM()").first
  end
end
