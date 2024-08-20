require "rails_helper"

RSpec.describe Weather::V1::ByTime do
  describe "GET /api/weather/v1/by_time", :vcr do
    let(:timestamp) { 1621823790 }

    context "without matching measures", :vcr do
      it "returns 404" do
        get "/api/weather/v1/by_time?timestamp=#{timestamp}"

        expect(response).to have_http_status(404)
      end
    end

    context "with matching measures", :vcr do
      before do
        create(:measure, timestamp: Time.zone.at(timestamp - 59.minutes.seconds.to_i), temperature: 1)
      end

      it "returns the closest measure by passed time in Unix format" do
        get "/api/weather/v1/by_time?timestamp=#{timestamp}"

        expect(response).to have_http_status(200)
        expect(response.body).to eq({ temperature: "1.0" }.to_json)
      end
    end
  end
end
