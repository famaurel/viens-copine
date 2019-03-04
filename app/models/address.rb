class Address < ApplicationRecord
  has_one :trip

  geocoded_by :title
  after_validation :geocode
end
