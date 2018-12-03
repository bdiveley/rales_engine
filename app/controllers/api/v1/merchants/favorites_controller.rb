class Api::V1::Merchants::FavoritesController < ApplicationController

  def show
    if params[:merchant_id]
      render json: CustomerSerializer.new(Customer.favorite_customer(params[:merchant_id]))
    else
      render json: MerchantSerializer.new(Merchant.favorite_merchant(params[:customer_id]))
    end
  end

end
