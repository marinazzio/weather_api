require "grape"
require "grape-swagger"

class Weather::API < Grape::API
  format :json

  resource :health do
    get do
      { status: "ok" }
    end
  end

  add_swagger_documentation(
    api_version: "v1",
    hide_documentation_path: false,
    mount_path: "/swagger_doc",
    hide_format: true
  )
end
