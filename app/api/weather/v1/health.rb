class Weather::V1::Health < Grape::API
  resource :health do
    desc "Returns ok with status 200" do
      produces [ "application/json" ]
    end
    get do
      { status: "ok" }
    end
  end
end
