class Product < ApplicationRecord
  has_one_attached :img
  has_many :product_orders,dependent: :destroy
  has_many :orders, through: :product_orders
  validates :name, presence: true
  validates :description, length: { maximum: 300 }
  validates :stock, numericality: { only_integer: true, greater_than: -1 }
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 1000000 }

  def self.search(search_term)
    if search_term.empty? then
      Product.all
    else
      Product.where("name ILIKE ? ","%#{search_term.strip.downcase}%")
    end
  end
end
