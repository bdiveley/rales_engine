class Api::V1::Merchants::SearchController < ApplicationController

  def show
    render json: MerchantSerializer.new(Merchant.find_by("lower(name) = ?", params["name"].downcase)) if params[:name]
    render json: MerchantSerializer.new(Merchant.find_by(created_at: params[:created_at])) if params[:created_at]
    render json: MerchantSerializer.new(Merchant.find_by(updated_at: params[:updated_at])) if params[:updated_at]
    render json: MerchantSerializer.new(Merchant.find_by(id: params[:id].to_i)) if params[:id]
  end

  def index
    render json: MerchantSerializer.new(Merchant.where("lower(name) = ?", params["name"].downcase)) if params[:name]
    render json: MerchantSerializer.new(Merchant.where(created_at: params[:created_at])) if params[:created_at]
    render json: MerchantSerializer.new(Merchant.where(updated_at: params[:updated_at])) if params[:updated_at]
    render json: MerchantSerializer.new(Merchant.where(id: params[:id].to_i)) if params[:id]
  end
end
