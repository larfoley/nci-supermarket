require 'test_helper'

class Admin::ProductsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = User.create(
      email: 'admin@nci-supermarket.com',
      password: 'letmein123',
      password_confirmation: 'letmein123',
      admin: true
    )

    sign_in @user

    @product = products(:bread)
  end

  test "should get all products" do
    get admin_products_url

    assert_response :success
  end

  test "searching for a product that exists" do
    get admin_products_url

    @result = Product.search("Bread")
    assert_equal 1, @result.count
  end

  test "searching for a product that does not exist" do
    get admin_products_url

    @result = Product.search("Toilet Roll")
    assert_equal 0, @result.count
  end

  test "should show a product" do
    get product_url(@product)

    assert_response :success
  end

  test "should show a product to edit" do
    get edit_admin_product_url(@product)

    assert_response :success
  end

  test "should show a new product to create" do
    get new_admin_product_url

    assert_response :success
  end

  test "should create a product" do

    assert_difference('Product.count') do
      post admin_products_url, params: {
        product: {
          name: "Fish",
          price: 5.99,
          stock: 1
        }
      }
    end

    assert_redirected_to admin_product_path(Product.last)
    assert_equal 'Product was successfully created', flash[:notice]
  end

  test "should update a product" do

    patch admin_product_url(@product), params: {
      product: { name: "Brenan's Bread" }
    }

    assert_redirected_to admin_product_path(@product)

    assert_equal 'Product was successfully updated', flash[:notice]

    @product.reload

    assert_equal "Brenan's Bread", @product.name
  end


  test "should destroy product" do

    assert_difference('Product.count', -1) do
      delete admin_product_url(@product)
    end

    assert_redirected_to admin_products_path

    assert_equal 'Product was successfully deleted', flash[:notice]
  end

end
