class Listing < ApplicationRecord
  belongs_to :user
  has_many :bookings
  mount_uploaders :images, ImageUploader

  paginates_per 5
end
