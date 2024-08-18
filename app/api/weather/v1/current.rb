class Weather::V1::Current < Grape::API
  resource :current do
    desc "Returns the current temperature" do
      produces [ "application/json" ]
    end

    get do
      timestamp = Time.zone.now
      measure = Measure.find_by!(timestamp: timestamp.all_day)

      { temperature: measure.temperature }
    end
  end
end
