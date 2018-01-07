class Invoice < Sequel::Model(DB)
	many_to_one :order
end