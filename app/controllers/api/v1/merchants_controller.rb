class Api::V1::MerchantsController < ApplicationController

  def index
    render json: Merchant.all
  end

  def show
    if params[:id] == 'random'
      render json: Merchant.find_random
    else
      render json: Merchant.find(params[:id])
    end
  end
end
