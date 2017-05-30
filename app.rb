require 'sinatra/base'
require 'sinatra/reloader'
require './lib/autocomplete'
require 'json'

class App < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  get '/demo' do
    content_type :json
    { name: 'Demo', value: 'It works!' }.to_json
  end

  get '/autocomplete' do
    content_type :json
    { suggestions: ::Autocomplete.suggestions }.to_json
  end
end
