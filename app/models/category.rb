class Category < ApplicationRecord
  has_many :products
  has_many_attached :images

  validates :name, presence: true, uniqueness: true

  def primary_image
    images.first
  end
end
