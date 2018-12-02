class Api::V1::Items::SearchController < ApplicationController

  def show
    if params[:unit_price]
      pennies = price_conversion(params[:unit_price])
      render json: ItemSerializer.new(Item.find_by(unit_price: pennies))
    elsif !look_up_params.empty?
      render json: ItemSerializer.new(Item.find_by(look_up_params))
    else
      render json: ItemSerializer.new(Item.find_random)
    end
  end

  def index
    if params[:unit_price]
      pennies = price_conversion(params[:unit_price])
      render json: ItemSerializer.new(Item.where(unit_price: pennies))
    else
      render json: ItemSerializer.new(Item.where(look_up_params))
    end
  end

private
  def look_up_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
