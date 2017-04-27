class IntendsController < ApplicationController
  def process(foo)
    request = AlexaRubykit::build_request(params)

    response = AlexaRubykit::Response.new
    case request.type
    when 'INTENT_REQUEST'
      case request.intent.fetch('name')
      when 'ExpressOrder'
        response.add_speech("Du möchtest eine Bestellung aufgeben")
      else
        response.add_speech("Mit dieser Anfrage kann ich leider nichts anfangen")
      end
    when 'LAUNCH_REQUEST'
      response.add_speech("Du hast eine Session gestartet")
    end

    render json: response
  end
end
