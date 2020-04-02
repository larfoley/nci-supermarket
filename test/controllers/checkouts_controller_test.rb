require 'test_helper'

class CheckoutsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = User.create(
      email: 'admin@nci-supermarket.com',
      password: 'letmein123',
      password_confirmation: 'letmein123',
    )

    sign_in @user
  end

  test "should show new order" do
    get checkout_url

    assert :success
  end
end
