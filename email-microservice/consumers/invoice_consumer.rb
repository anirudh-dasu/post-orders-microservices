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
      #Send an email with order info and invoice content
      puts "Email with invoice id #{payload_hash['invoice']['id']} sent"
    else
      #No invoice present
      #Send an email only with order info
      puts "Email without invoice sent"
    end

  end

end