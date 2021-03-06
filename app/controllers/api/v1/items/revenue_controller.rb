class Api::V1::Items::RevenueController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.top_items_by_total_revenue(params[:quantity]))
  end
end
