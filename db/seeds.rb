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
  category: 'fêtarde',
  email: 'kathy@kathy.com',
  password: 'topsecret'
  )

user2 = User.create!(
  first_name: 'Claudia',
  last_name: 'Doedoe',
  address: '102 cours Balguerie Stuttenberg 33300 Bordeaux',
  category: 'arsouille',
  email: 'claudia@claudia.com',
  password: 'topsecret'
  )


 trip1 = Trip.create!(
    transport: 0,
    start_time: 15,
    start_lat: 48.862725,
    start_long: 2.287592000000018,
    end_address: "54 Rue de New York, Bordeaux, Nouvelle-Aquitaine, France",
    end_lat: 44.8699,
    end_long: -0.5508519999999635,
  )

trip2 = Trip.create!(
    transport: 1,
    start_time: 30,
    start_lat: 44.852,
    start_long: -0.5725869999999986,
    end_address: "Cours de la Martinique, 33000 Bordeaux, France",
    end_lat: 44.8543439,
    end_long: -0.5723652
  )

trip3 = Trip.create!(
    transport: 2,
    start_time: 15,
    start_lat: 44.855684373859944,
    start_long: -0.5744621157646179,
    end_address: "47 Rue Minvielle, Bordeaux, Nouvelle-Aquitaine, France",
    end_lat: 44.8543439,
    end_long: -0.5723652
  )

booking1 = Booking.create!(
    user: user1,
    trip: trip1,
    creator: false,
    progress: 0,
    state: 0
)

booking2 = Booking.create!(
    user: user2,
    trip: trip2,
    creator: false,
    progress: 0,
    state: 0
)

booking2 = Booking.create!(
    user: user3,
    trip: trip3,
    creator: false,
    progress:0,
    state: 0
)

