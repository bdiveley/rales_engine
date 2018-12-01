class Api::V1::InvoicesController < ApplicationController

  def index
    unless look_up_params.empty?
      render json: InvoiceSerializer.new(Invoice.where(look_up_params))
    else
      render json: InvoiceSerializer.new(Invoice.all)
    end
  end

  def show
    render json: InvoiceSerializer.new(Invoice.find(params[:id]))
  end

private
  def look_up_params
    params.permit(:merchant_id, :customer_id)
  end
end
