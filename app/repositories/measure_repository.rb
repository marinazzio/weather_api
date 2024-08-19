class MeasureRepository
  TIMESTAMP_TOLERANCE = 1.hour

  class << self
    def find_by_timestamp(timestamp:)
      measures = Measure.where(timestamp: timerange_with_tolerance(timestamp))
      closest_measure = measures.min_by { |measure| (measure.timestamp - timestamp).abs }
      closest_measure.temperature
    rescue NoMethodError
      raise ActiveRecord::RecordNotFound
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

    def all_within_interval(interval:)
      Measure.where(timestamp: timestamp_range(interval))
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
  end
end
