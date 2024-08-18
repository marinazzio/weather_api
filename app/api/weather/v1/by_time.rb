class Weather::V1::ByTime < Grape::API
  resource :by_time do
    desc "Returns the closest measure by passed timestamp" do
      produces [ "application/json" ]
    end

    params do
      requires :timestamp, type: Integer, desc: "Unix timestamp"
    end

    get do
      timestamp = Time.at(params[:timestamp])

      measure =
        Measure
          .where(timestamp: timestamp.all_day)
          .order(timestamp: :desc)
          .first

      if measure
        { temperature: measure.temperature }
      else
        error!({ error: "Not found" }, 404)
      end
    end
  end
end
