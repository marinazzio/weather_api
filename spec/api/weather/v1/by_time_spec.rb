require "rails_helper"

RSpec.describe Weather::V1::ByTime do
  context "GET /api/weather/v1/by_time" do
    let(:timestamp) { 1621823790 }

    context "without matching measures" do
      it "returns 404" do
        get "/api/weather/v1/by_time?timestamp=#{timestamp}"

        expect(response).to have_http_status(404)
      end
    end

    context "with matching measures" do
      before do
        create(:measure, timestamp: "2021-05-24T08:00:00+07:00", temperature: 1)
      end

      it "returns the closest measure by passed time in Unix format" do
        get "/api/weather/v1/by_time?timestamp=#{timestamp}"

        expect(response).to have_http_status(200)
        expect(response.body).to eq({ temperature: "1.0" }.to_json)
      end
    end
  end
end
