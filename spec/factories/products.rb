# frozen_string_literal: true

FactoryBot.define do
  factory :product, class: 'Product' do
    name { Faker::Commerce.product_name }
    description { Faker::Commerce.department(max: 3, fixed_amount: true) }
    price { Faker::Commerce.price }
    stock { Faker::Number.number(digits: 2) }
    discount { Faker::Number.number(digits: 1) }
    association :category
  end
end
