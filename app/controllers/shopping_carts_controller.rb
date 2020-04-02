class ShoppingCartsController < ApplicationController
  def show
    @products = []

    for cart_item in @cart.items do
      begin
        product = Product.find(cart_item["id"])

        if product[:stock] < 1 then
          @cart.remove(cart_item)
          flash.alert = "Sorry, #{cart_item["name"]} is currently out of stock and has been removed from your cart"
        else
          @products.push(product)
        end

      rescue
        flash.alert = "Sorry, #{cart_item["name"]} is no longer available and has been removed from your cart"
        @cart.remove(cart_item)
      end
    end

    @cart_items = []

    for p in @products do
      amount = @cart.items.find { |i| i["id"] == p[:id].to_s }["amount"]
      @cart_items.push({:product => p, :amount => amount})
    end

  end

  def add
    @product = Product.find(params[:product_id])

    if @product[:stock] > 0
      @cart.add(@product)
      @product[:stock] -= 1
      redirect_to shopping_cart_path(@product)
      flash.now[:notice] = "Product has been added to cart"
    else
      flash.now[:notice] = "This product is currently not available"
    end
  end

  def remove
    @cart.remove(Product.find(params[:product_id]))
    redirect_to shopping_cart_path(@product)
    flash.now[:notice] = "Product was removed form cart"
  end

end
