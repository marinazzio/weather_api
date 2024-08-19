# spec/repositories/measure_repository_spec.rb
require 'rails_helper'

RSpec.describe MeasureRepository do
  let(:current_time) { Time.zone.now }
  let(:interval) { 24.hours }

  before do
    create(:measure, temperature: 10.2, timestamp: current_time - 1.hour)
    create(:measure, temperature: -15.5, timestamp: current_time - 10.hours)
    create(:measure, temperature: 17.6, timestamp: current_time - 20.hours)
    create(:measure, temperature: 9.0, timestamp: current_time - 30.hours)
    create(:measure, temperature: -6, timestamp: current_time - 40.hours)
  end

  describe '.find_by_timestamp' do
    subject(:result) { described_class.find_by_timestamp(timestamp:) }

    let(:timestamp) { current_time - 20.minutes }

    it 'returns the closest measure by passed timestamp' do
      expect(result).to eq(10.2)
    end
  end

  describe ".max_within_interval" do
    subject(:max) { described_class.max_within_interval(interval:) }

    it "returns the maximum temperature within the interval" do
      expect(max).to eq(17.6)
    end
  end

  describe ".min_within_interval" do
    subject(:min) { described_class.min_within_interval(interval:) }

    it "returns the minimum temperature within the interval" do
      expect(min).to eq(-15.5)
    end
  end

  describe ".avg_within_interval" do
    subject(:avg) { described_class.avg_within_interval(interval:) }

    it "returns the average temperature within the interval" do
      expect(avg).to eq(4.1)
    end
  end

  describe ".all_within_interval" do
    subject(:measures) { described_class.all_within_interval(interval:) }

    let(:interval) { 35.hours }

    it "returns hourly measures for the last 24h" do
      expect(measures.size).to eq(4)
    end
  end

  describe ".last_24h" do
    subject(:measures) { described_class.last_24h }

    it "returns hourly measures for the last 24h" do
      expect(measures.size).to eq(3)
    end
  end

  describe '.save_measure' do
    let(:city) { create(:city) }
    let(:attributes) { { temperature: 30, timestamp: Time.now, city: city } }

    it 'saves a new measure' do
      measure = MeasureRepository.save_measure(attributes)

      expect(measure).to be_persisted
      expect(measure.temperature).to eq(30.0)
    end
  end
end
