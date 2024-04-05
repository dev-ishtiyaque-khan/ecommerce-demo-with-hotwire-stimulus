module CartsHelper
  def subtotal(cart_item)
    (cart_item.quantity * item_product(cart_item.product_id).price).round(2)
  end

  def total(cart_items)
    total = 0
    cart_items.each do |cart_item|
      total += subtotal(cart_item)
    end
    total.round(2)
  end

  private

  def item_product(product_id)
    Product.find_by(id: product_id)
  end
end
