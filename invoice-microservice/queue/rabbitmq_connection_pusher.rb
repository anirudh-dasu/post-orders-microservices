require "bunny"

module QueueConnectionPusher
  @exchange = nil
  @sms_queue = nil
  @email_queue = nil

  def self.get_exchange
    connection = Bunny.new("amqp://guest:guest@localhost:5672")
    connection.start
    channel    = connection.create_channel
    @exchange  = channel.direct("microservice", durable: true)
    @sms_queue = channel.queue("invoices_sms",:durable => true).bind(@exchange)
    @email_queue  = channel.queue("invoices_email", :durable => true).bind(@exchange)
  end

  def self.publish(message)
    @exchange = @exchange || get_exchange
    @sms_queue.publish(message)
    @email_queue.publish(message)
  end
end