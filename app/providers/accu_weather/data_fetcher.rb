class AccuWeather::DataFetcher
  class << self
    def fetch_current
      perform_request(current_url)
    end

    def fetch_historical
      perform_request(historical_url)
    end

    private

    def perform_request(url)
      AccuWeather::APIResponse.success(payload: RestClient.get(url).body)
    rescue RestClient::ExceptionWithResponse => e
      AccuWeather::APIResponse.failure(message: e.message)
    end

    def current_url
      AccuWeather::Settings.base_url + AccuWeather::Settings.current_endpoint % { location_key: location_key }
    end

    def historical_url
      AccuWeather::Settings.base_url + AccuWeather::Settings.historical_endpoint % { location_key: location_key }
    end

    def location_key
      AccuWeather::Settings.location_key
    end
  end
end
