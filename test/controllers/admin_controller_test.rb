require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @admin_user = User.create(
      email: 'admin@nci-supermarket.com',
      password: 'letmein123',
      password_confirmation: 'letmein123',
      admin: true
    )

    @user = User.create(
      email: 'admin@nci-supermarket.com',
      password: 'letmein123',
      password_confirmation: 'letmein123',
    )
  end

  test "index should redirect to products" do
    sign_in @admin_user

    get admin_url

    assert_redirected_to admin_products_path
  end

  test "should not allow non admin users access" do
    sign_in @user

    get admin_url

    assert_redirected_to root_path
  end
end
