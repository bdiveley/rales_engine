class Api::V1::Transactions::SearchController < ApplicationController

  def show
    unless look_up_params.empty?
      render json: TransactionSerializer.new(Transaction.find_by(look_up_params))
    else
      render json: TransactionSerializer.new(Transaction.find_random)
    end
  end

  def index
    render json: TransactionSerializer.new(Transaction.where(look_up_params))
  end

private
  def look_up_params
    params.permit(:id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at)
  end
end
