class Api::V1::Merchants::OneMerchRevenueController < ApplicationController

  def show
    if params[:date]
      result = Invoice.total_revenue_per_merchant_by_date(params[:id], params[:date])
    else
      result = Invoice.total_revenue_by_merchant(params[:id])
    end
    revenue = Revenue.new(result)
    render json: RevenueSerializer.new(revenue)
  end
end
