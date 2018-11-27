class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    if params[:id] == 'random'
      render json: MerchantSerializer.new(Merchant.find_random)
    else
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    end
  end
end
