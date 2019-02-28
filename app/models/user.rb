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

  def self.new_with_session(params, session)
    super.tap do |user|
      if data == session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
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
