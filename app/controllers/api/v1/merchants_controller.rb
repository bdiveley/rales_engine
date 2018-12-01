class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    if params[:item_id]
      render json: MerchantSerializer.new(Merchant.merchant_by_item(params[:item_id]))
    elsif params[:invoice_id]
      render json: MerchantSerializer.new(Merchant.find_by_invoice(params[:invoice_id]))
    else
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    end
  end


end
