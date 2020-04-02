require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = User.create(
      email: 'admin@nci-supermarket.com',
      password: 'letmein123',
      password_confirmation: 'letmein123',
    )

    sign_in @user

    @account = accounts(:one)
  end

  test "should show account" do
    get account_url

    assert_response :success
  end

  test "should update account" do

    patch account_url(@account), params: {
      account: {
        delivery_address: "123"
      }
    }

    assert_redirected_to account_path
  end

end
