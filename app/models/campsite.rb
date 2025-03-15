class Campsite < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true


  def self.ransackable_attributes(auth_object = nil)
    ["name", "address"]
  end
end
