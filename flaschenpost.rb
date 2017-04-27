require 'sinatra'
require 'json'
require 'alexa_rubykit'
require './flaschenpost_ghost.rb'

post '/' do
  json_params = JSON.parse(request.body.read)
  intent_request = AlexaRubykit::build_request(json_params)

  session = FlaschenpostGhost::FlaschenpostSession.new

  intent_response = AlexaRubykit::Response.new
  case intent_request.type
  when 'INTENT_REQUEST'
    case intent_request.intent.fetch('name')
    when 'ExpressOrder'

     session.login_user
     session.put_beer_in_cart
     session.put_beer_in_cart
     session.order_cart

     intent_response.add_speech("Deine Getränke sind auf dem Weg")
    else
      intent_response.add_speech("Mit dieser Anfrage kann ich leider nichts anfangen")
    end
  when 'LAUNCH_REQUEST'
    intent_response.add_speech("Du hast eine Session gestartet")
  else
    intent_response.add_speech("Unbekannte Art von Intent")
  end

  content_type :json

  intent_response.build_response
end
