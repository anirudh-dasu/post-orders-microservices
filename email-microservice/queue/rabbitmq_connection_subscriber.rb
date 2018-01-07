require "bunny"
require_relative '../consumers/invoice_consumer'

module QueueConnectionSubscriber
  @exchange = nil
  @queue    = nil

  def self.get_exchange
    connection = Bunny.new("amqp://guest:guest@localhost:5672")
    connection.start
    channel    = connection.create_channel
    @exchange  = channel.direct("microservice", durable: true)
    @queue     = channel.queue("invoices_email", :durable => true).bind(@exchange)
  end

  def self.subscribe
    @queue = @queue || get_exchange
    @queue.subscribe(:block => true) do |delivery_info, properties, payload|
      InvoiceConsumer.consume_load(delivery_info,properties,payload)
    end
  end

 
end