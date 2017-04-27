module FlaschenpostGhost
  class FlaschenpostSession
    DRINK_TYPES = [
      { url: "bier/pils", type: "beer"},
      { url: "mineralwasser/medium", type: "water"}
    ]

    def initialize
      @base_path = "http://dev.flaschenpost.de/"
      options = {js_errors: false}
      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(app, options)
      end
      @session = Capybara::Session.new(:poltergeist)
      @session.visit "#{@base_path}?plz=48147"
    end

    def login_user
      @session.find(".login").trigger('click')
      @session.fill_in 'inpLoginEmail', with: ENV['FLASCHENPOST_USER']
      @session.fill_in 'inpLoginPass', with: ENV['FLASCHENPOST_PASSWORD']
      @session.find('#btnLogin').trigger('click')
      @session.visit "#{@base_path}meinegetraenke"
      @session.has_content? "Meine Getränke"
    end

    def order_cart
      @session.find('#btnOrder').trigger('click')
      @session.find('#btnOrderC2').trigger('click')
      @session.has_content? "Ihre Bestellung macht sich nun auf den Weg."
    end

    DRINK_TYPES.each do |drink_type|
      define_method "put_#{drink_type[:type]}_in_cart" do
        @session.visit "#{@base_path}#{drink_type[:url]}"
        @session.find('.pl71 .pl1 .pl3 .pl5 .pl55 .c2').trigger('click')
      end
    end
  end

  def example_walk_through
    session = FlaschenpostSession.new
    session.login_user
    session.put_beer_in_cart
    session.put_beer_in_cart
    puts "order done" if session.order_cart
  end
end

