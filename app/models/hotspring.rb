class Hotspring < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
end
