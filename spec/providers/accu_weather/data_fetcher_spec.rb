require 'rails_helper'

RSpec.describe AccuWeather::DataFetcher do
  let(:location_key) { '12345' }
  let(:api_key) { 'some_fake_api_key' }

  before do
    allow(AccuWeather::Settings).to receive(:location_key).and_return(location_key)
    allow(AccuWeather::Settings).to receive(:api_key).and_return(api_key)
  end

  describe '.current' do
    subject(:current_weather) { described_class.fetch_current.to_h }

    before do
      stub_request(
        :get,
        "#{AccuWeather::Settings.base_url}#{AccuWeather::Settings.current_endpoint % { location_key: }}?apikey=#{api_key}"
      ).to_return(
        status: 200,
        body: File.read(Rails.root.join('spec', 'fixtures', 'current_endpoint_response.json'))
      )
    end

    it 'fetches the current weather data' do
      expect(current_weather).to include(
        {
          timestamp: '2024-08-17T13:22:00+03:00',
          temperature: 17.8
        }
      )
    end
  end

  describe '.historical' do
    subject(:historical_weather) { described_class.fetch_historical.to_h }

    before do
      stub_request(
        :get,
        "#{AccuWeather::Settings.base_url}#{AccuWeather::Settings.historical_endpoint % { location_key: }}?apikey=#{api_key}"
      ).to_return(
        status: 200,
        body: File.read(Rails.root.join('spec', 'fixtures', 'historical_endpoint_response.json'))
      )
    end

    it 'fetches the historical weather data' do
      aggregate_failures do
        expect(historical_weather).to be_an_instance_of(Array)
        expect(historical_weather.size).to eq(24)
        expect(historical_weather).to include(
          {
            temperature: 13.9,
            timestamp: '2024-08-18T01:57:00+03:00'
          },
          {
            temperature: 17.2,
            timestamp: '2024-08-17T11:57:00+03:00'
          }
        )
      end
    end
  end
end
