require 'rails_helper'

RSpec.describe Weather::API do
  context 'GET /health' do
    it 'returns ok with status 200' do
      get '/health'
      expect(response).to have_http_status(200)
      expect(response.body).to eq({ status: 'ok' }.to_json)
    end
  end
end
