class Api::V1::Merchants::AllMerchRevenueController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.top_merchants_by_total_revenue(params[:quantity]))
  end

  def show
    result = Invoice.total_revenue_by_date(params[:date])
    revenue = Revenue.new(result)
    render json: TotalRevenueSerializer.new(revenue)
  end
end
