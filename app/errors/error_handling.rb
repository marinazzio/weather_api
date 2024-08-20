module ErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from :all do |e|
      if Rails.env.development?
        raise e
      else
        error!({ error: "Internal server error", message: e.message }, 500)
      end
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      error!({ message: "Resource not found" }, 404)
    end
  end
end
