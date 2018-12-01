class Api::V1::TransactionsController < ApplicationController

  def index
    render json: TransactionSerializer.new(Transaction.trans_by_customer(params[:customer_id]))
  end

end
