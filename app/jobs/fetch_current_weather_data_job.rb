class FetchCurrentWeatherDataJob < ApplicationJob
  queue_as :default

  def perform(*args)
    response = AccuWeather::DataFetcher.fetch_current

    MeasureRepository.create(response.payload) if response.success?
  rescue => e
    Rails.logger.error("Error fetching current weather data: #{e.message}")
  end
end
