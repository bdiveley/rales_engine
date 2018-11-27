class Merchant < ApplicationRecord

  def self.find_random
    Merchant.limit(1).order("RANDOM()").first
  end

  def self.find_merchant(params)
    binding.pry
  end
end
