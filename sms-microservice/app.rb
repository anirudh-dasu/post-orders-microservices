require 'hanami/router'

class App
  def self.router
    Hanami::Router.new do
      get '/',        to: ->(env) { [200, {}, ['<h1>Email microservice</h1>']] }
    end
  end
end