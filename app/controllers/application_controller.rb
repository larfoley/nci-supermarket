require_relative '../../lib/activity-logger'
require 'shopping_cart_session'

class ApplicationController < ActionController::Base
  include ShoppingCartSession
  before_action :authenticate_user!
  before_action :set_up_cart
  before_action :set_up_activity_logger

  def set_up_cart
    @cart = Cart.new(session)
  end

  def set_up_activity_logger
    ActivityLogger.instance.log_page_request(request)
  end

end
