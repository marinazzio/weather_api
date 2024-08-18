# app/api/weather/v1/base.rb
class Weather::V1::Base < Grape::API
  version "v1", using: :path

  mount Weather::V1::Health
  mount Weather::V1::Historical

  # resource :weather do
  #   desc 'Get historical maximum temperature'
  #   get '/historical/max' do
  #     max_temp = Measure.maximum(:temperature)
  #     { temperature: max_temp }
  #   end
  # end
end
