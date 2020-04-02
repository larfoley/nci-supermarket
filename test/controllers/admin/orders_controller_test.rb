require 'test_helper'

class Admin::OrdersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = User.create(
      email: 'admin@nci-supermarket.com',
      password: 'letmein123',
      password_confirmation: 'letmein123',
      admin: true
    )

    sign_in @user

    @order = orders(:one)
  end

  test "should get all orders" do
    get admin_orders_url

    assert_response :success
  end

  test "should show an order" do
    get admin_order_url(@order)

    assert_response :success
  end

  test "should show order to edit" do
    get edit_admin_order_url(@order)

    assert_response :success
  end

  test "should update an order" do

    patch admin_order_url(@order), params: {
      order: { status: 'delivered' }
    }

    assert_redirected_to admin_order_path

    assert_equal 'Order was successfully updated', flash[:notice]

    @order.reload

    assert_equal "delivered", @order.status
  end
end
