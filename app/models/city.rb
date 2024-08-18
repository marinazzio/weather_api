class City < ApplicationRecord
  validates :location_key, presence: true
end
