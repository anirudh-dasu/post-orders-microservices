class Order < Sequel::Model(DB)
	one_to_one :invoice


	def generate_invoice_text
		## Generation of invoice from order information
		'Test invoice text'
	end

end