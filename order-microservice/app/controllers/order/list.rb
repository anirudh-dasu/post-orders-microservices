require 'hanami/controller'

class Order < Sequel::Model(DB)

	class List 

    include ::Hanami::Action

    def call(params)
    	orders = DB[:orders].all
    	self.body = orders.to_json
    end

	end

end