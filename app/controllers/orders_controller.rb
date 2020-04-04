class OrdersController < ApplicationController
  def create
    ordered_products = []

    for cart_item in @cart.items do
      begin
        product = Product.find(cart_item["id"])
        order_qunantity = cart_item["amount"].to_i
        available_stock = product[:stock]

        if available_stock < 1 then
          @cart.remove(cart_item)
          flash.alert = "Sorry, #{cart_item["name"]} is currently out of stock and has been removed from your cart"

          redirect_to shopping_cart_url

        elsif (available_stock - order_qunantity) < 0

          for i in 1..order_qunantity - available_stock
            @cart.remove(cart_item)
          end

          redirect_to shopping_cart_url

          flash.alert = "Sorry, #{cart_item["name"]} there the Quantity you order is no longer available"
        else

          product.stock -= cart_item["amount"].to_i
          begin
            product.save
          rescue StandardError => e
            puts e.message
            puts e.backtrace.inspect
          end
          ordered_products.push(product)
        end

      rescue
        @cart.remove(cart_item)
        redirect_to shopping_cart_url

        flash.alert = "Sorry, #{cart_item["name"]} is no longer available and has been removed from your cart"
      end
    end

    if !ordered_products.empty? then

      order = Order.create(
        user_id: current_user.id,
        total: @cart.total_price,
        delivery_address: "Raheny, Dublin 5, Ireland"
      )

      order.products << ordered_products
      order.save
      @cart.empty
      redirect_to(order)
      flash.notice = 'Order has been placed'
    end
  end

  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:delivery_address, :total_price, :status)
  end

end
