class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :trip
  has_many :reviews
  #validates :user_id, uniqueness: true
  enum progress: {stand_by: 0, leaved: 1, arrived: 2}
  enum state: {pending: 0, approved: 1}
end
