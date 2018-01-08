require 'json'
require_relative '../queue/rabbitmq_connection_publisher'

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
    order = Order.create(payload_hash)
    #Perform whatever validations are needed for invoice generation. Save in db if successful, don't if it isn't.
    ## Saving to db is optional and not necessary. For better performance, skip saving to db.
    invoice = Invoice.new(order_id: order.id, content: order.generate_invoice_text)
    invoice.save
    QueueConnectionPublisher.publish(order.to_json(include: :invoice))
    puts "Published order with invoice"
  end

end