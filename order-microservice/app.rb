require 'hanami/router'

class App
  def self.router
    Hanami::Router.new do
      get '/',        to: ->(env) { [200, {}, ['<h1>Orders microservice</h1>']] }
      get '/list',   to: Order::List
      post '/order', to: Order::Create
    end
  end
end