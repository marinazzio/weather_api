require_relative '../app/api/base'

Rails.application.routes.draw do
  mount GrapeSwaggerRails::Engine => '/swagger'
  mount API::Base, at: '/'
end
