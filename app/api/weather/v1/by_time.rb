class Weather::V1::ByTime < Grape::API
  resource :by_time do
    desc "Returns the closest measure by passed timestamp" do
      produces [ "application/json" ]
    end

    params do
      requires :timestamp, type: Integer, desc: "Unix timestamp"
    end

    get do
      timestamp = Time.zone.at(params[:timestamp])
      temperature = MeasureRepository.find_by_timestamp(timestamp:)

      { temperature: }
    end
  end
end
