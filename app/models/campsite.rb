class Campsite < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["address", "name"]
  end
end
