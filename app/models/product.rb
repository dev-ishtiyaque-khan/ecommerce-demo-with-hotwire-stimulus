class Product < ApplicationRecord
  has_many_attached :images
  has_many :reviews
  belongs_to :category

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :with_attached_images, -> { includes("images_attachments": :blob) }


  def primary_image
    images.first
  end
end
