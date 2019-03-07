class Trip < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :users, through: :bookings
  enum transport: { walk: 0, bike: 1, bus: 2 }

  belongs_to :start_address, :class_name => 'Address'
  belongs_to :end_address, :class_name => 'Address'

  def creator
    self.bookings.find_by(creator: true).user
  end
end
