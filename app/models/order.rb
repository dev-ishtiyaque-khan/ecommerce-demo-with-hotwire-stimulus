class Order < ApplicationRecord
  belongs_to :user

  validates :status, presence: true

  enum status: { placed: 0, dispatched: 1, transit: 2, delivered: 3 }
end
