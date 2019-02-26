# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Review.destroy_all
Booking.destroy_all
Trip.destroy_all

user1 = User.create!(
  first_name: 'Kathy',
  last_name: 'Doe',
  address: '107 cours Balguerie Stuttenberg 33300 Bordeaux',
  category: 'fêtarde'
  email: 'kathy@kathy.com'
  password: 'topsecret'
  )

user2 = User.create!(
  first_name: 'Claudia',
  last_name: 'Doedoe',
  address: '102 cours Balguerie Stuttenberg 33300 Bordeaux',
  category: 'arsouille'
  email: 'claudia@claudia.com'
  password: 'topsecret'
  )
