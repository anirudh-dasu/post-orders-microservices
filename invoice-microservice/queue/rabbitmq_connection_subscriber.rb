require "bunny"
require_relative '../consumers/order_consumer'

module QueueConnectionSubscriber
  @exchange = nil
  @queue    = nil

  def self.connect_to_rabbitmq
    connection = Bunny.new("amqp://#{RABBIT_CONFIG['host']}:#{RABBIT_CONFIG['port']}")
    connection.start
    connection
  end

  def self.get_exchange
    channel    = connect_to_rabbitmq.create_channel
    @exchange  = channel.direct(RABBIT_CONFIG['exchange'], durable: true)
    @queue     = channel.queue(RABBIT_CONFIG['queue_sub'], :durable => true).bind(@exchange)
  end

  def self.subscribe
    @queue = @queue || get_exchange
    @queue.subscribe(:block => true) do |delivery_info, properties, payload|
      OrderConsumer.consume_load(delivery_info,properties,payload)
    end
  end

 
end