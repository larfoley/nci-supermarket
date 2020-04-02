require 'test_helper'

class Admin::ActivityControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  def setup
    @user = User.create(
      email: 'admin@nci-supermarket.com',
      password: 'letmein123',
      password_confirmation: 'letmein123',
    )

    sign_in @user
  end

  test "should get index" do
    get admin_activity_index_url

    assert_response :success
  end
end
