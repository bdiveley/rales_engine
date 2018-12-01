class Api::V1::Merchants::SearchController < ApplicationController

  def show
    unless look_up_params.empty?
      render json: MerchantSerializer.new(Merchant.find_by(look_up_params))
    else
      binding.pry
      render json: MerchantSerializer.new(Merchant.find_random)
    end
  end

  def index
    render json: MerchantSerializer.new(Merchant.where(look_up_params))
  end

private
  def look_up_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
