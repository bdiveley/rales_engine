class Api::V1::Merchants::SearchController < ApplicationController

  def show
    # render json: Merchant.find_by(name: params["name"])
    #the below is returning an array instead of the object itself
    render json: Merchant.where("lower(name) = ?", params["name"].downcase)
  end
end
