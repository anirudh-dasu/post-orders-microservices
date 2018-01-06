require 'hanami/controller'

class Order < Sequel::Model(DB)

	class Create 

    	include ::Hanami::Action

    	def call(params)
    		order = Order.new(params.to_h)
    		if order.save
    			self.body = order.to_json
    		else
    			halt 422
    		end
    	end

	end

end