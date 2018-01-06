class OrderConsumer < Bunny::Consumer
  def cancelled?
    @cancelled
  end

  def handle_cancellation(_)
    @cancelled = true
  end

  def self.consume_load(delivery_info, properties, payload)
  	puts "Delivery info is #{delivery_info}"
  	puts "Payload is #{payload}"
  end

end