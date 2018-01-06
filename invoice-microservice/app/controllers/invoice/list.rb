require 'hanami/controller'

class Invoice < Sequel::Model(DB)

	class List 

    include ::Hanami::Action

    def call(params)
    	invoices = DB[:invoices].all
    	self.body = invoices.to_json
    end

	end

end