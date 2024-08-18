class Weather::V1::Historical < Grape::API
  resource :historical do
    desc "Returns the maximum temperature for the last 24h" do
      produces [ "application/json" ]
    end
    get :max do
      { temperature: Measure.maximum(:temperature) }
    end
  end
end
