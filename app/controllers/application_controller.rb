class ApplicationController < ActionController::API

  def price_conversion(price)
    (price.to_f * 100).round
  end
end
