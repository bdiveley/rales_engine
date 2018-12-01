class Api::V1::InvoiceItemsController < ApplicationController

  def index
    unless look_up_params.empty?
      render json: Invoice_ItemSerializer.new(InvoiceItem.where(look_up_params))
    else
      render json: Invoice_ItemSerializer.new(InvoiceItem.all)
    end
  end

  def show
    render json: Invoice_ItemSerializer.new(InvoiceItem.find(params[:id]))
  end

private
  def look_up_params
    params.permit(:item_id, :invoice_id)
  end
end
