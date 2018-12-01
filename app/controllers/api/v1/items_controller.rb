class Api::V1::ItemsController < ApplicationController

  def index
    unless look_up_params.empty?
      render json: ItemSerializer.new(Item.where(look_up_params))
    else
      render json: ItemSerializer.new(Item.all)
    end
  end

  def show
   render json: ItemSerializer.new(Item.find(params[:id]))
  end

private
  def look_up_params
    params.permit(:merchant_id)
  end
end
