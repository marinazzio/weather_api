# app/api/weather/v1/base.rb
class Weather::V1::Base < Grape::API
  version "v1", using: :path

  mount Weather::V1::ByTime
  mount Weather::V1::Health
  mount Weather::V1::Historical
end
