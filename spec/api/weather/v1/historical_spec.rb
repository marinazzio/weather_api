require "rails_helper"

RSpec.describe Weather::API do
  before do
    create(:measure, temperature: 1)
    create(:measure, temperature: 2)
    create(:measure, temperature: 3)
    create(:measure, temperature: 4)
    create(:measure, temperature: 5)
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
    it "returns hourly measures for the last 24h" do
      get "/api/weather/v1/historical"

      expect(response).to have_http_status(200)
      expect(response.body).to eq(Measure.all.to_json)
    end
  end
end
