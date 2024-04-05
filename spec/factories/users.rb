# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: 'User' do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
  end
end
