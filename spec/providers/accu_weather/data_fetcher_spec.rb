require 'rails_helper'

RSpec.describe AccuWeather::DataFetcher do
  let(:location_key) { '287676' }
  let(:api_key) { ENV['ACCU_WEATHER_API_KEY'] }

  describe '.current', :vcr do
    subject(:current_weather) { described_class.fetch_current.to_h }

    it 'fetches the current weather data' do
      expect(current_weather).to include(
        {
          timestamp: '2024-08-20T11:52:00+03:00',
          temperature: 18.9
        }
      )
    end
  end

  describe '.historical', :vcr do
    subject(:historical_weather) { described_class.fetch_historical.to_h }

    it 'fetches the historical weather data' do
      aggregate_failures do
        expect(historical_weather).to be_an_instance_of(Array)
        expect(historical_weather.size).to eq(24)
        expect(historical_weather).to include(
          {
            temperature: 21.1,
            timestamp: '2024-08-20T09:57:00+03:00'
          },
          {
            temperature: 22.8,
            timestamp: '2024-08-19T14:57:00+03:00'
          }
        )
      end
    end
  end
end
