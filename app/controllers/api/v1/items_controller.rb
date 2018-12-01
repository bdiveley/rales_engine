class Api::V1::ItemsController < ApplicationController

  def index
    if params[:merchant_id]
      render json: ItemSerializer.new(Item.where(merchant_id: params[:merchant_id]))
    elsif params[:invoice_id]
      render json: ItemSerializer.new(Item.items_by_invoice(params[:invoice_id]))
    else
      render json: ItemSerializer.new(Item.all)
    end
  end

  def show
    if params[:invoice_item_id]
      render json:ItemSerializer.new(Item.find_by_invoice_item(params[:invoice_item_id]))
    else
      render json: ItemSerializer.new(Item.find(params[:id]))
    end
  end

end
