class Api::V1::TransactionsController < ApplicationController

  def index
    if params[:customer_id]
      render json: TransactionSerializer.new(Transaction.trans_by_customer(params[:customer_id]))
    elsif params[:invoice_id]
      render json: TransactionSerializer.new(Transaction.where(invoice_id: params[:invoice_id]))
    else
      render json: TransactionSerializer.new(Transaction.all)
    end
  end

  def show
    render json: TransactionSerializer.new(Transaction.find(params[:id]))
  end

  private
    def look_up_params
      params.permit(:customer_id, :invoice_id)
    end
end
