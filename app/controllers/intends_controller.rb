class IntendsController < ApplicationController
  def process(foo)
    request = AlexaRubykit::build_request(params)
    
    response = AlexaRubykit::Response.new
    response.add_speech("It's on!")
    render json: response
  end
end
