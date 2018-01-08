require "bunny"

module QueueConnectionPublisher
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
    @queue     = channel.queue(RABBIT_CONFIG['queue'], :durable => true).bind(@exchange)
  end

  def self.publish(message)
    @exchange = @exchange || get_exchange
    @exchange.publish(message, routing_key: @queue.name)
  end
end