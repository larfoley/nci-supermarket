require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test 'valid product' do
    product = Product.new(name: 'bread', stock: 1, price: 1.50)
    assert product.valid?
  end

  test 'product is invalid without name' do
    product = Product.new(stock: 1, price: 1.50)
    assert_not product.valid?
  end

  test 'product is invalid without price' do
    product = Product.new(stock: 1, name: 'bread')
    assert_not product.valid?
  end

  test 'product is invalid without stock' do
    product = Product.new(name: 'bread', price: 1.50)
    assert_not product.valid?
  end

  test 'product description is invalid when description has more than 300 chars' do
    max_chars = 300
    description = ""

    for i in 1..max_chars + 1 do
      description += i.to_s
    end

    assert description.length > max_chars

    product = Product.new(
      name: 'bread',
      stock: 1,
      price: 1.50,
      description: description
    )

    assert_not product.valid?
  end

  test 'stock must be an integer' do
    product = Product.new(name: 'bread', stock: 1.1, price: 1.50)

    assert_not product.valid?

    product[:stock] = true

    assert_not product.valid?

    product[:stock] = 1

    assert product.valid?
  end

end
