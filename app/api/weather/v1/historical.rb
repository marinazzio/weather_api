class Weather::V1::Historical < Grape::API
  resource :historical do
    desc "Returns the maximum temperature for the last 24h" do
      produces [ "application/json" ]
    end
    get :max do
      { temperature: MeasureRepository.max_within_interval(interval: 24.hours) }
    end

    desc "Returns the minimum temperature for the last 24h" do
      produces [ "application/json" ]
    end
    get :min do
      { temperature: MeasureRepository.min_within_interval(interval: 24.hours) }
    end

    desc "Returns the average temperature for the last 24h" do
      produces [ "application/json" ]
    end
    get :avg do
      { temperature: MeasureRepository.avg_within_interval(interval: 24.hours) }
    end

    desc "Returns hourly measures for the last 24h" do
      produces [ "application/json" ]
    end
    get do
      MeasureRepository
        .last_24h
        .map { |measure| { timestamp: measure.timestamp, temperature: measure.temperature } }
    end
  end
end
