require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
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
    get orders_url

    assert_response :success
  end

  test "should show an order" do
    get order_url(@order)

    assert_response :success
  end

end
