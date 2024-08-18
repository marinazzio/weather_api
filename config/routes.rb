Rails.application.routes.draw do
  mount GrapeSwaggerRails::Engine => '/swagger'
  mount Weather::API, at: '/'
end
