require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = User.create(
      email: 'admin@nci-supermarket.com',
      password: 'letmein123',
      password_confirmation: 'letmein123',
      admin: false
    )
    sign_in @user
  end

  test "should get index" do
    get products_url

    assert_response :success
  end

  test "should search for a product that exists" do
    get products_url

    @result = Product.search("Bread")
    assert_equal 1, @result.count
  end

  test "should search for a product that does not exist" do
    get products_url

    @result = Product.search("Toilet Roll")
    assert_equal 0, @result.count
  end

  test "should show a product" do
    get product_url(Product.first)

    assert_response :success
  end

end
