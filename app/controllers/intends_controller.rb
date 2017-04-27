class IntendsController < ApplicationController
  def process(params)
    response = AlexaRubykit::Response.new
    response.add_speech("It's on!")
    render json: response
  end
end
