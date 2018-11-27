class Api::V1::Merchants::SearchController < ApplicationController

  def show
    render json: Merchant.find_merchant(params)
    # render json: Merchant.find_by("lower(name) = ?", params["name"].downcase) if params[:name]
    # render json: Merchant.find_by(created_at: params[:created_at]) if params[:created_at]
    # render json: Merchant.find_by(updated_at: params[:updated_at]) if params[:updated_at]
    # render json: Merchant.find_by(id: params[:id].to_i) if params[:id]
  end

  def index
    render json: Merchant.where("lower(name) = ?", params["name"].downcase) if params[:name]
    render json: Merchant.where(created_at: params[:created_at]) if params[:created_at]
    render json: Merchant.where(updated_at: params[:updated_at]) if params[:updated_at]
    render json: Merchant.where(id: params[:id].to_i) if params[:id]
  end
end
