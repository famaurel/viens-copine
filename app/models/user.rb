class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :bookings
  has_many :trips, through: :bookings
  has_many :reviews, through: :bookings
  has_many :my_reviews, source: :reviews


  mount_uploader :photo, PhotoUploader
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
  after_create :split_name
  after_create :create_session_id


  def create_session_id
    require "opentok"
    opentok = OpenTok::OpenTok.new('46278222', 'd3a9a4c0cc104cdae7dd05881ee18115d487fc5e')
    session = opentok.create_session
    self.update(session_id: session.session_id)
    self.save
  end

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end

  def average_rating
    ratings = []
    if self.reviews[0] != nil
    reviews = self.reviews
    reviews.each do |review|
      ratings << review.rating
    end
    ratings.sum / ratings.length
  else
    0
  end
  end

  def split_name
    if self.name != nil
      arr = []
      arr = self.name.split
      self.update(first_name: arr.first, last_name: arr.last)
    end
  end
end
