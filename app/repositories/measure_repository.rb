class MeasureRepository
  class << self
    def find_by_timestamp(timestamp:)
      Measure
        .where("timestamp <= ?", timestamp)
        .order(timestamp: :desc)
        .first
        .temperature
    rescue NoMethodError
      raise ActiveRecord::RecordNotFound
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

    def timestamp_range(interval)
      (Time.zone.now - interval)..Time.zone.now
    end
  end
end
