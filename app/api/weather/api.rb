# require "grape"
# require "grape-swagger"

class Weather::API < Grape::API
  format :json
  prefix "api/weather"

  mount Weather::V1::Base

  add_swagger_documentation(
    api_version: "v1",
    hide_documentation_path: false,
    mount_path: "/swagger_doc",
    hide_format: true
  )
end
