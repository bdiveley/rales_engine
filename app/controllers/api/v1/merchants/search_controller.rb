class Api::V1::Merchants::SearchController < ApplicationController

  def show
    if params[:name]
      render json: Merchant.find_by("lower(name) = ?", params["name"].downcase)
    elsif params[:id]
      render json: Merchant.find_by(id: params[:id].to_i)
    elsif params[:created_at]
      render json: Merchant.find_by(created_at: params[:created_at])
    elsif params[:updated_at]
      render json: Merchant.find_by(updated_at: params[:updated_at])
    end
  end
end
