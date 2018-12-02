class Api::V1::Items::SearchController < ApplicationController

  def show
    unless look_up_params.empty?
      render json: ItemSerializer.new(Item.find_by(look_up_params))
    else
      render json: ItemSerializer.new(Item.find_random)
    end
  end

  def index
    render json: ItemSerializer.new(Item.where(look_up_params))
  end

private
  def look_up_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
