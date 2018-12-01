class Api::V1::InvoicesController < ApplicationController

  def index
    render json: InvoiceSerializer.new(Invoice.where(look_up_params))
  end

private
  def look_up_params
    params.permit(:merchant_id, :customer_id)
  end
end
