module ProductsHelper
  def category_selected?(query, category_id)
    return false unless query && query[:category_id_in]

    query[:category_id_in].first.include?(category_id.to_s)
  end

  def sort_product_option_list
    [
      ['Default', ''],
      ['Price low to high', 'price asc'],
      ['Price high to low', 'price desc'],
      ['Latest products', 'created_at desc']
    ]
  end

  def discounted_price(price, discount)
    (price - (price * (discount / 100)))&.round(2)
  end

  def average_rating(product)
    product.reviews.average(:rating)&.floor
  end

  def out_of_stock?(product)
    return false unless cart_item = current_user_cart&.cart_items&.find_by(product_id: product.id)

    cart_item.quantity >= product.stock
  end
end
