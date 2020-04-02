class Order < ApplicationRecord
  has_many :product_orders
  has_many :products, :through => :product_orders

  belongs_to :user

  validates :delivery_address, presence: true

  before_save :default_values

  enum status: [ :ordered, :delivered ]

  def default_values
    self.status = 'ordered' if self.status.nil?
    self.delivery_address = '' if self.delivery_address.nil?
  end

end
