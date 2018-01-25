# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

User.create!(
  email: 'admin@gmail.com',
  password: 'helloworld',
  role: :admin
)

User.create!(
  email: 'standard@gmail.com',
  password: 'helloworld',
)

User.create!(
  email: 'premium@gmail.com',
  password: 'helloworld',
  role: :premium
)

5.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
end

users = User.all

50.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph(5),
    private: [true, false].sample,
    user: users.sample
  )
end

puts "Seed finished"
puts "#{Wiki.count} wikis"
puts "#{User.count} users"
