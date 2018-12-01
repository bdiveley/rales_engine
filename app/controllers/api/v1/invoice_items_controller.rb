class Api::V1::InvoiceItemsController < ApplicationController

  def index
    render json: Invoice_ItemSerializer.new(InvoiceItem.all)
  end

  def show
    render json: Invoice_ItemSerializer.new(InvoiceItem.find(params[:id]))
  end
end
