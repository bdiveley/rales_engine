class Api::V1::InvoicesController < ApplicationController

  def index
    unless look_up_params.empty?
      render json: InvoiceSerializer.new(Invoice.where(look_up_params))
    else
      render json: InvoiceSerializer.new(Invoice.all)
    end
  end

  def show
    if params[:invoice_item_id]
      render json: InvoiceSerializer.new(Invoice.find_by_invoice_item(params[:invoice_item_id]))
    elsif params[:transaction_id]
      render json: InvoiceSerializer.new(Invoice.find_by_transaction(params[:transaction_id]))
    else
      render json: InvoiceSerializer.new(Invoice.find(params[:id]))
    end
  end

private
  def look_up_params
    params.permit(:merchant_id, :customer_id)
  end
end
