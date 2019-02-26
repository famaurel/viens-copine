class Trip < ApplicationRecord
  has_many :bookings
  enum transport: { bike: 0, walk: 1, bus: 2 }
end
