# frozen_string_literal: true

class AccuWeather::APIResponse
  def self.success(message: nil, payload: "{}")
    new(
      status: :success,
      message:,
      payload:
    )
  end

  def self.failure(message:, payload: "{}")
    new(
      status: :failure,
      message:,
      payload:
    )
  end

  attr_reader :status, :message, :payload

  def initialize(status:, message:, payload:)
    @status = status
    @message = message
    @payload = JSON.parse(payload)
  end

  def to_h
    @payload.map do |item|
      {
        timestamp: item["LocalObservationDateTime"],
        temperature: item.dig("Temperature", "Metric", "Value")
      }
    end
  end

  private

  def failure?
    status == :failure
  end
end
