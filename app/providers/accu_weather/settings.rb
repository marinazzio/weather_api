class AccuWeather::Settings
  BASE_URL = "http://dataservice.accuweather.com"
  CURRENT_CONDITIONS_ENDPOINT = "/currentconditions/v1/%{location_key}"
  HISTORY_ENDPOINT = "/historical/v1/%{location_key}/historical/24"
  DEFAULT_LOCATION_KEY = "287676"

  def self.api_key
    ENV["ACCU_WEATHER_API_KEY"] || raise("ACCU_WEATHER_API_KEY is not set")
  end

  def self.location_key
    ENV["ACCU_WEATHER_LOCATION_KEY"] || DEFAULT_LOCATION_KEY
  end

  def self.base_url
    BASE_URL
  end

  def self.current_endpoint
    CURRENT_CONDITIONS_ENDPOINT
  end

  def self.historical_endpoint
    HISTORY_ENDPOINT
  end
end
