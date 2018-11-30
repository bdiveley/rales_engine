class Api::V1::Merchants::ItemsController < ApplicationController

  def show
    render json: Merchant.find(params[:id])
  end
end
