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
    when 'AddLineItem'
      beverage = intent_request.intent.fetch('slots').fetch('beverage')

      case beverage
      when 'Bier'
        beverage_type = 'beer'
      when 'Wasser'
        beverage_type = 'water'
      end

      amount = intent_request.intent.fetch('slots').fetch('amount').to_i

      session.login_user
      amount.times do
        session.send("put_#{beverage_type}_in_cart")
      end
      intent_response.add_speech("Ich habe #{amount} Kästen #{beverage} zu deinem Warenkorb hinzugefügt")

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
