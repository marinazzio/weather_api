class FetchDailyWeatherDataJob < ApplicationJob
  queue_as :default

  def perform(*args)
    response = AccuWeather::DataFetcher.fetch_historical

    if response.success?
      response.payload.each do |data|
        MeasureRepository.create(data)
      end
    end
  rescue => each
    Rails.logger.error("Error fetching daily weather data: #{e.message}")
  end
end
