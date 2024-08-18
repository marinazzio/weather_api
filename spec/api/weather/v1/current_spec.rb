require "rails_helper"

RSpec.describe Weather::V1::Current do
  context "GET /api/weather/v1/current" do
    context "without current measure" do
      it "returns 404" do
        get "/api/weather/v1/current"

        expect(response).to have_http_status(404)
      end
    end

    context "with current measure" do
      before do
        create(:measure, timestamp: Time.zone.now, temperature: 15.7)
      end

      it "returns the current measure" do
        get "/api/weather/v1/current"

        expect(response).to have_http_status(200)
        expect(response.body).to eq({ temperature: "15.7" }.to_json)
      end
    end
  end
end
