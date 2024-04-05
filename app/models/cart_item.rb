class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :product_id, uniqueness: { scope: :cart_id }

  delegate :name, :stock, :price, :primary_image, to: :product, prefix: true
  delegate :category, to: :product
end
