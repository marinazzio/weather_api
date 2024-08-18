class Measure < ApplicationRecord
  belongs_to :city

  validates :timestamp, presence: true
  validates :temperature, presence: true
end
