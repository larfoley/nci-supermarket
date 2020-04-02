class HomeController < ApplicationController
  layout 'landing_page'

  def index
    @products = Product.limit(5)
  end

end
