require 'test_helper'

class ProductFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in User.create(
      email: 'admin@nci-supermarket.com',
      password: 'letmein123',
      password_confirmation: 'letmein123',
      admin: true
    )
  end

  test "can see the products page" do
    get "/products"
    assert_response :success
  end

  test "can create a product" do
    get new_admin_product_url
    assert_response :success

    post admin_products_url, params: {
      product: {
        name: "Chilli Flakes",
        price: 1.99,
        stock: 10,
        description: ""
      }
    }

    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal 'Product was successfully created', flash[:notice]
    assert_select "h2", "Chilli Flakes"
  end

  test "should show validation errors" do
    get new_admin_product_url
    assert_response :success

    post admin_products_url, params: {
      product: {
        name: "Chilli Flakes"
      }
    }

    assert_response :success
    assert_select ".alert__title", "You must fix the following validations errors"
  end

  test "can edit a product" do
    product = products(:bread)

    get edit_admin_product_url(product)
    assert_response :success

    put admin_product_url(product), params: {
      product: {
        name: "Apple",
      }
    }

    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal 'Product was successfully updated', flash[:notice]
    assert_select "h2", "Apple"
  end

end
