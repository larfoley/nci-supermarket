require 'test_helper'

class ShoppingCartsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = User.create(
      email: 'admin@nci-supermarket.com',
      password: 'letmein123',
      password_confirmation: 'letmein123',
    )

    sign_in @user
  end

  test "should get show" do
    get shopping_carts_show_url
    assert_response :success
  end

  test "should put add to shopping cart" do
    product = Product.first

    put add_to_shopping_cart_url(product), params: {
      product_id: product.id
    }

    assert_redirected_to shopping_cart_path(product)

    assert_equal 'Product has been added to cart', flash[:notice]
  end

  test "should put remove from shopping cart" do
    product = Product.first

    put remove_from_shopping_cart_url(product), params: {
      product_id: product.id
    }

    assert :success

    assert_equal "Product was removed form cart", flash[:notice]
  end


end
