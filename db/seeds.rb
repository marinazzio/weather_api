# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
city = City.find_or_create_by!(name: "Cheboksary", location_key: "287676")

Measure.find_or_create_by!(city:, timestamp: "2024-08-17T13:22:00+03:00", temperature: 23.2)
Measure.find_or_create_by!(city:, timestamp: "2024-08-17T14:22:00+03:00", temperature: 25.9)
