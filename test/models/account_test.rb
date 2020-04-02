require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test 'valid account' do
    account = Account.new(delivery_address: '123')
    account.user_id = users(:one).id
    assert account.valid?
  end
end
