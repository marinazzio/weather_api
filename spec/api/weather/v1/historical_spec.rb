require "rails_helper"

RSpec.describe Weather::API do
  before do
    create(:measure, temperature: 1)
    create(:measure, temperature: 2)
    create(:measure, temperature: 3)
    create(:measure, temperature: 4)
    create(:measure, temperature: 5)
    create(:measure, timestamp: 3.days.ago, temperature: 35.2)
    create(:measure, timestamp: 7.days.ago, temperature: -10.6)
  end

  context "GET /api/weather/v1//historical/max" do
    let(:expected_response) { { temperature: "5.0" }.to_json }

    it "returns the maximum temperature" do
      get "/api/weather/v1/historical/max"

      expect(response).to have_http_status(200)
      expect(response.body).to eq(expected_response)
    end
  end

  context "GET /api/weather/v1/historical/min" do
    let(:expected_response) { { temperature: "1.0" }.to_json }

    it "returns the minimum temperature" do
      get "/api/weather/v1/historical/min"

      expect(response).to have_http_status(200)
      expect(response.body).to eq(expected_response)
    end
  end

  context "GET /api/weather/v1/historical/avg" do
    let(:expected_response) { { temperature: "3.0" }.to_json }

    it "returns the average temperature" do
      get "/api/weather/v1/historical/avg"

      expect(response).to have_http_status(200)
      expect(response.body).to eq(expected_response)
    end
  end

  context "GET /api/weather/v1/historical" do
    let(:expected_response) do
      [
        { "temperature" => "1.0" },
        { "temperature" => "2.0" },
        { "temperature" => "3.0" },
        { "temperature" => "4.0" },
        { "temperature" => "5.0" }
    ]
    end

    it "returns hourly measures for the last 24h" do
      get "/api/weather/v1/historical"

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).map { _1.slice("temperature") }).to eq(expected_response)
    end
  end
end
