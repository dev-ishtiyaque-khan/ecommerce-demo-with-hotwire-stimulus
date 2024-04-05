# frozen_string_literal: true

FactoryBot.define do
  factory :review, class: 'Review' do
    rating { Faker::Number.between(from: 1, to: 5) }
    comment { Faker::Lorem.sentence }
  end
end
