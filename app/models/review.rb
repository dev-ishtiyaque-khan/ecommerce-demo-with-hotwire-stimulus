class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :title, length: { minimum: 5, maximum: 60 }
  validates :comment, length: { minimum: 50 }
  validates :rating, presence: true

  enum rating: { poor: 1, avg: 2, good: 3, very_good: 4, excellent: 5 }
end
