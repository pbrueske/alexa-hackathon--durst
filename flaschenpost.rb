require 'sinatra'
require 'json'
require 'alexa_rubykit'


post '/' do
  json_params = JSON.parse(request.body.read)

  intent_request = AlexaRubykit::build_request(json_params)

  case intent_request.type
  when 'INTENT_REQUEST'
    case intent_request.intent.fetch('name')
    when 'ExpressOrder'
      intent_response.add_speech("Du möchtest eine Bestellung aufgeben")
    else
      intent_response.add_speech("Mit dieser Anfrage kann ich leider nichts anfangen")
    end
  when 'LAUNCH_REQUEST'
    intent_response.add_speech("Du hast eine Session gestartet")
  else
    intent_response.add_speech("Unbekannte Art von Intent")
  end

  content_type :json

  response = AlexaRubykit::Response.new
  response.add_speech("Du möchtest eine Bestellung aufgeben")
  response.build_response
end
