require "bunny"

module QueueConnectionPublisher
  @exchange = nil
  @sms_queue = nil
  @email_queue = nil

  def self.connect_to_rabbitmq
    connection = Bunny.new("amqp://#{RABBIT_CONFIG['host']}:#{RABBIT_CONFIG['port']}")
    connection.start
    connection
  end

  def self.get_exchange
    channel    = connect_to_rabbitmq.create_channel
    @exchange  = channel.direct(RABBIT_CONFIG['exchange'], durable: true)
    @sms_queue = channel.queue(RABBIT_CONFIG['queue_pub_sms'],:durable => true).bind(@exchange)
    @email_queue  = channel.queue(RABBIT_CONFIG['queue_pub_email'], :durable => true).bind(@exchange)
  end

  def self.publish(message)
    @exchange = @exchange || get_exchange
    @sms_queue.publish(message)
    @email_queue.publish(message)
  end
end