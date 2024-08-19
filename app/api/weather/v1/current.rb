class Weather::V1::Current < Grape::API
  resource :current do
    desc "Returns the current temperature" do
      produces [ "application/json" ]
    end

    get do
      timestamp = Time.zone.now
      temperature = MeasureRepository.find_by_timestamp(timestamp:)

      { temperature: }
    end
  end
end
