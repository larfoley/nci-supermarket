require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test 'valid order' do
    order = Order.new(
      delivery_address: "123"
    )
    order.user_id = users(:one).id
  end
end
