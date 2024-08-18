class Weather::V1::Historical < Grape::API
  resource :historical do
    desc "Returns the maximum temperature for the last 24h" do
      produces [ "application/json" ]
    end
    get :max do
      { temperature: Measure.maximum(:temperature) }
    end

    desc "Returns the minimum temperature for the last 24h" do
      produces [ "application/json" ]
    end
    get :min do
      { temperature: Measure.minimum(:temperature) }
    end

    desc "Returns the average temperature for the last 24h" do
      produces [ "application/json" ]
    end
    get :avg do
      { temperature: Measure.average(:temperature) }
    end

    desc "Returns hourly measures for the last 24h" do
      produces [ "application/json" ]
    end
    get do
      Measure.where(timestamp: 24.hours.ago..Time.zone.now)
    end
  end
end
