class Api::V1::InvoiceItems::SearchController < ApplicationController

  def show
    if params[:unit_price]
      pennies = params[:unit_price].to_f / 100
      render json: Invoice_ItemSerializer.new(InvoiceItem.find_by(unit_price: pennies))
    elsif !look_up_params.empty?
      render json: Invoice_ItemSerializer.new(InvoiceItem.find_by(look_up_params))
    else
      render json: Invoice_ItemSerializer.new(InvoiceItem.find_random)
    end
  end

  def index
    if params[:unit_price]
      pennies = params[:unit_price].to_f / 100
      render json: Invoice_ItemSerializer.new(InvoiceItem.where(unit_price: pennies))
    else
      render json: Invoice_ItemSerializer.new(InvoiceItem.where(look_up_params))
    end
  end

private
  def look_up_params
    params.permit(:id, :quantity, :unit_price, :item_id, :invoice_id, :created_at, :updated_at)
  end
end
