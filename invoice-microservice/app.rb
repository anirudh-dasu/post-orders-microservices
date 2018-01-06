require 'hanami/router'

class App
  def self.router
    Hanami::Router.new do
      get '/',        to: ->(env) { [200, {}, ['<h1>Invoice microservice</h1>']] }
      get '/list',   to: Invoice::List
    end
  end
end