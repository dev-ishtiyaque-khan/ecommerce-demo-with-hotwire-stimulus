require 'net/http'
require 'json'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
if Rails.env.development?
  AdminUser.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

  FAKE_IMAGE_LIST = URI('https://picsum.photos/v2/list?page=2&limit=200')

  # image download helper
  def download_image(image_url)
    image_source = URI.parse(image_url)
    filename = File.basename(image_source.path)

    # TODO: this is a security vulnerability
    file = URI.open(image_source)
    [file, filename]
  end

  def random_product_image
    @download_urls ||= begin
      response = Net::HTTP.get(FAKE_IMAGE_LIST)
      data = JSON.parse(response)
      data.map { |item| item['download_url'] }
    end
    download_image(@download_urls.sample)
  end

  # User
  if User.count < 5
    5.times do
      user = User.create!(email: Faker::Internet.email, name: Faker::Name.name, password: 'password')
      user_avatar = download_image(Faker::Avatar.image)
      user.avatar.attach(io: user_avatar.first, filename: user_avatar.last)
    end
  end

  # Categories
  Dir[Rails.root.join('db', 'seed_data', 'images', 'categories', '*.jpg')].each do |image_path|
    file_name = File.basename(image_path)
    category = Category.create(name: file_name.gsub('.jpg', ''))
    category.images.attach(io: File.open(image_path), filename: file_name)
  end

  # Products
  rand(1000..2000).times do
    category = Category.all.sample
    product = category.products.create(
      name: Faker::Commerce.product_name,
      price: Faker::Commerce.price,
      discount: rand(10..20),
      stock: rand(20..50),
      description: Faker::Lorem.paragraph(sentence_count: 3),
    )
    image, file_name = random_product_image
    product.images.attach(io: image, filename: file_name)
  end

  # Reviews
  product_ids = Product.pluck(:id)
  user_ids = User.pluck(:id)
  reviews_data = 5000.times.map do
    {
      title: Faker::Games::DnD.title_name,
      rating: Random.rand(1..5), comment:
      Faker::Lorem.paragraph(sentence_count: 10),
      product_id: product_ids.sample,
      user_id: user_ids.sample,
      created_at: Faker::Date.between(from: 1.year.ago, to: Date.today)
    }
  end
  Review.insert_all(reviews_data)
end
