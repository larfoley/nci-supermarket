require_relative '../../lib/subject'

class ProductsController < ApplicationController
  before_action :initialize_subject

  def index
    search_term = params[:search_term]
    @products = search_term ? Product.search(search_term) : Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :img)
  end

  def initialize_subject
    @subject = Subject.new
  end

end
