require 'hanami/controller'
require 'hanami/validations'
require_relative '../../../queue/rabbitmq_connection_publisher'

class Order < Sequel::Model(DB)

	class Create 

    	include ::Hanami::Action

        params do
            required(:product_name).filled(:str?)
            required(:quantity).filled(:str?)
            required(:address).filled(:str?)
            required(:email).filled(:str?)
            required(:phone).filled(:str?)

        end

    	def call(params)
            halt 400 unless params.valid?
    		order = Order.new(params.to_h)
    		if order.save
    			self.body = order.to_json
    			QueueConnectionPublisher.publish(order.to_json)
    		else
    			halt 422
    		end
    	end

	end

end