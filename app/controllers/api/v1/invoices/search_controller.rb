class Api::V1::Invoices::SearchController < ApplicationController

  def show
    unless look_up_params.empty?
      render json: InvoiceSerializer.new(Invoice.find_by(look_up_params))
    else
      render json: InvoiceSerializer.new(Invoice.find_random)
    end
  end

  def index
    render json: InvoiceSerializer.new(Invoice.where(look_up_params))
  end

private
  def look_up_params
    params.permit(:id, :name, :status, :created_at, :updated_at)
  end
end
