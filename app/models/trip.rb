class Trip < ApplicationRecord
  has_many :bookings
  belongs_to :user
  enum transport: { bike: 0, walk: 1, bus: 2 }
end
