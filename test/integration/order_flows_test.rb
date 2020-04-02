require 'test_helper'

class OrderFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in User.create(
      email: 'admin@nci-supermarket.com',
      password: 'letmein123',
      password_confirmation: 'letmein123',
      admin: true
    )
  end

  test "can see the orders page" do
    get orders_url
    
    assert_response :success
  end
  
  test "can place an order" do
    order = orders(:one)
    product = products(:bread)
    
    get products_url(product)
    
    assert_response :success
  
    put add_to_shopping_cart_url(product)
  
    assert_response :redirect
    
    assert_equal 'Product has been added to cart', flash[:notice]
    
    follow_redirect!
    
    assert_response :success
    
    get shopping_cart_url
    
    assert_response :success
    
    assert_select ".order__item-product .media__body strong", product.name
    
    post orders_path(order)
    
    assert_response :redirect
    
    follow_redirect!
    
    assert_equal 'Order has been placed', flash.notice
    
    assert_select "h1", "Order ##{order.id + 1}"

  end

end
