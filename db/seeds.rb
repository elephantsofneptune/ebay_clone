require 'faker'
require 'bcrypt'

images = Dir.entries(File.open(File.join(Rails.root, "app/assets/images/sample_images/"))) - [".", ".."]

10.times do
  user = User.find_or_create_by(username: Faker::Lorem.word,
                                email: Faker::Internet.email,
                                password_hash: BCrypt::Password.create("1234password"))

  item = user.listings.find_or_create_by(name: Faker::Lorem.word,
                         description: Faker::Lorem.paragraph,
                         starting_bid_price: Faker::Number.number(2),
                         buy_it_now_price: Faker::Number.number(3))

  item.image.store!(File.open(File.join(Rails.root, File.join("app/assets/images/sample_images/", images.sample))))
  item.save
end
