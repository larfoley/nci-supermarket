class Admin::OrdersController < AdminController
  def index
    @orders = Order.all
  end

  def edit
    @order = Order.find(params[:id])
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(status: params[:order][:status])
      redirect_to admin_order_path
      flash.notice = "Order was successfully updated"
    else
      redirect_to edit_admin_order_path
    end
  end

end
