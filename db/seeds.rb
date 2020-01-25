# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
# movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# Character.create(name: 'Luke', movie: movies.first)
require 'pry'
Product.destroy_all
Review.destroy_all
User.destroy_all
User.create!(:email => 'admin@admin.com', :password => '123', :password_confirmation => '123', :admin => true, :username => 'Admin Man')

uniquer = 1;
20.times do |index|
  name_a = Faker::Creature::Cat.name.downcase
  name_b = Faker::Hipster.word
  fullname = (name_a + " " + name_b + "#{uniquer}").titleize
  email = "#{name_a}@#{name_b}#{uniquer}.com"

  user_params = {
    :email => email,
    :password => '123',
    :password_confirmation => '123',
    :admin => false,
    :username => fullname
  }

  User.create!(user_params)
  uniquer += 1
end

users = User.all

50.times do |index|
  cost = rand(500)
  product = Product.create!(name: (Faker::Games::Pokemon.name.titleize + " " + name_b = Faker::Appliance.equipment), cost: cost, country_of_origin: Faker::Games::HalfLife.location)

  users.each do |user|
    rating = rand(5)
    Review.create!(
      author: user.username,
      rating: rating,
      content_body: (Faker::ChuckNorris.fact + ".... Ham hock short loin tail porchetta beef."),
      product_id: product.id,
      user_id: user.id)
  end
end

product = Product.create!(name: "The Mega-Juicer", cost: 200, country_of_origin: "USA")
users.each do |user|
  rating = rand(5)
  Review.create!(
    author: user.username,
    rating: rating,
    content_body: (Faker::ChuckNorris.fact + ".... Ham hock short loin tail porchetta beef."),
    product_id: product.id,
    user_id: user.id)
end


p "Created #{Product.count} Products"
p "Created #{Review.count} reviews"
p "Created #{User.count} users"
