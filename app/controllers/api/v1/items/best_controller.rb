class Api::V1::Items::BestController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.top_items_by_items_sold(params[:quantity]))
  end

  def show
    result = Invoice.best_day(params[:id]).created_at
    render json: DaySerializer.new(Day.new(result))
  end
end
