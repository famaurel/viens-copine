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
 category: 'calme',
 email: 'claudia@claudia.com',
 password: 'topsecret'
 )

address1 = Address.create!(
 latitude: 44.855684373859944,
 longitude: -0.5744621157646179,
 title: "Adresse 1",
 state: 0
)


address2 = Address.create!(
   title: "Adresse 2",
   latitude: 44.8543439,
   longitude: -0.5723652,
   state: 1
 )

address3 = Address.create!(
   title: "Adresse 3",
   latitude: 44.8543439,
   longitude: -0.57236,
   state: 0
 )

address4 = Address.create!(
   title: "Adresse 4",
   latitude: 44.85,
   longitude: -0.572,
   state: 1
 )

trip1 = Trip.create!(
   transport: 0,
   start_time: Time.now + 15*60,
   start_address: address1,
   end_address: address2
 )

trip2 = Trip.create!(
   transport: 1,
   start_time: Time.now + 30*60,
    start_address: address3,
   end_address: address4
 )

trip3 = Trip.create!(
   transport: 2,
   start_time: Time.now + 15*60,
    start_address: address1,
   end_address: address4

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
   user: user2,
   trip: trip3,
   creator: false,
   progress: 0,
   state: 0
)

review1 = Review.create!(
  user: user1,
  booking: booking1,
  rating: 1,
  content: 'topissime'
)

review2 = Review.create!(
 user: user2,
 booking: booking2,
 rating: 5,
 content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec luctus tempus sapien, non accumsan turpis.'
 )

review3 = Review.create!(
 user: user2,
 booking: booking2,
 rating: 3,
 content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec luctus tempus sapien, non accumsan turpis.'
 )


