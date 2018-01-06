require 'json'
require_relative '../queue/rabbitmq_connection_pusher'

class OrderConsumer < Bunny::Consumer
  def cancelled?
    @cancelled
  end

  def handle_cancellation(_)
    @cancelled = true
  end

  def self.consume_load(delivery_info, properties, payload)
    payload_hash = JSON.parse(payload).to_h
    payload_hash.delete('id')
    invoice = Invoice.new(payload_hash)
    if invoice.save 
      QueueConnectionPusher.publish(invoice.to_json)
    else
      halt 422
    end
  end

end