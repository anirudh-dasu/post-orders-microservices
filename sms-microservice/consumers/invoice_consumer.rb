require 'json'

class InvoiceConsumer < Bunny::Consumer
  def cancelled?
    @cancelled
  end

  def handle_cancellation(_)
    @cancelled = true
  end

  def self.consume_load(delivery_info, properties, payload)
    payload_hash = JSON.parse(payload).to_h
    if !payload_hash['invoice'].nil?
      #Invoice successfully generated
      #Send an sms with order info and invoice content
      puts "Sms with invoice sent"
    else
      #No invoice present
      #Send an sms only with order info
      puts "Sms without invoice sent"
    end

  end

end