class Campsite < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["name", "address"]
  end
end
