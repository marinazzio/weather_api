require 'rails_helper'

RSpec.describe AccuWeather::Settings do
  subject { described_class }

  it { is_expected.to respond_to(:api_key) }
  it { is_expected.to respond_to(:location_key) }

  describe '.base_url' do
    it 'returns the base URL' do
      expect(subject.base_url).to eq('http://dataservice.accuweather.com')
    end
  end

  describe '.current_endpoint' do
    it 'returns the current endpoint' do
      expect(subject.current_endpoint).to eq('/currentconditions/v1/%{location_key}')
    end
  end

  describe '.historical_endpoint' do
    it 'returns the historical endpoint' do
      expect(subject.historical_endpoint).to eq('/historical/v1/%{location_key}/historical/24')
    end
  end
end
