class CheckoutsController < ApplicationController
  def show
    @order = Order.new
  end
end
