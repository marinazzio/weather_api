require "grape"
require "grape-swagger"

class Weather::API < Grape::API
  format :json

  resource :health do
    desc "Returns ok with status 200" do
      produces [ "application/json" ]
    end
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
