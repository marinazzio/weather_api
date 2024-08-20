class MeasureRepository
  TIMESTAMP_TOLERANCE = 1.hour

  class << self
    def find_by_timestamp(timestamp:)
      measures =
        Rails.cache.fetch("measures_#{rounded_timestamp(timestamp)}", expires_in: cache_ttl(timestamp)) do
          Measure.where(timestamp: timerange_with_tolerance(timestamp))
        end

      closest_measure = measures.min_by { |measure| (measure.timestamp - timestamp).abs }
      closest_measure.temperature
    rescue NoMethodError
      raise ActiveRecord::RecordNotFound
    end

    def all_within_interval(interval:)
      Rails.cache.fetch("measures_last_#{interval_length(interval)}_hours", expires_in: 1.hour) do
        Measure.where(timestamp: timestamp_range(interval))
      end
    end

    def find_current
      find_by_timestamp(timestamp: Time.zone.now)
    end

    def max_within_interval(interval:)
      all_within_interval(interval:)
        .maximum(:temperature)
    end

    def min_within_interval(interval:)
      all_within_interval(interval:)
        .minimum(:temperature)
    end

    def avg_within_interval(interval:)
      all_within_interval(interval:)
        .average(:temperature)
    end

    def last_24h
      all_within_interval(interval: 24.hours)
    end

    def save_measure(attributes)
      Measure.create(attributes)
    end

    private

    def timerange_with_tolerance(timestamp)
      timestamp - TIMESTAMP_TOLERANCE..timestamp + TIMESTAMP_TOLERANCE
    end

    def timestamp_range(interval)
      now = Time.zone.now
      (now - interval)..now
    end

    def cache_ttl(timestamp)
      return 5.minutes if timestamp >= 1.hour.ago

      timestamp >= 24.hours.ago ? 1.hour : 1.day
    end

    def rounded_timestamp(timestamp)
      timestamp.change(min: 0, sec: 0, use: 0).to_i
    end

    def interval_length(interval)
      interval.in_hours.floor
    end
  end
end
