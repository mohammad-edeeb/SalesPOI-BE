class Customer < ApplicationRecord

	validates :last_trx_amount, :long, :lat, numericality: true, allow_blank: true
	# validates_numericality_of :last_trx_amount, :long, :lat

	class << self
		def permitted_attrs
			[:customer_id, :name, :lat, :long, :zone_name, :salesman_name, :status,
				:last_visited_at, :last_invoice_at, :last_trx_amount, :extra1, :extra2, :extra3]
		end
	end
end
