require 'sinatra'
require 'json'
require 'alexa_rubykit'


post '/' do
  json_params = JSON.parse(request.body.read)

  intent_request = AlexaRubykit::build_request(json_params)

  content_type :json

  response = AlexaRubykit::Response.new
  response.add_speech("Du möchtest eine Bestellung aufgeben")
  response.build_response
end
