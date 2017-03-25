class Customer < ApplicationRecord
	DEFAULT_DISTANCE = 100

	validates :last_trx_amount, numericality: true, allow_blank: true
	validates_presence_of :customer_id, :name
	validates :status, inclusion: {in: [1, 2, 3], message: "must be 1 or 2 or 3"}
	validates :lat, inclusion: {in: -90..90, message: "must be between -90 to 90"}
	validates :long, inclusion: {in: -180..180, message: "must be between -180 to 180"}

	attr_accessor :distance

	class << self
		def permitted_attrs
			[:customer_id, :name, :lat, :long, :zone_name, :salesman_name, :status,
				:last_visited_at, :last_invoice_at, :last_trx_amount, :extra1, :extra2, :extra3]
		end

		def find_near_customers(lat, long)
			distance_setting = Setting.first
			min_distance = distance_setting.present? ? distance_setting.value.to_f : DEFAULT_DISTANCE
			near_customers = []
			Customer.all.each do |c|
				distance = Geocoder::Calculations::distance_between([c.lat, c.long], [lat, long], units: :km)
				if((distance * 1000) < min_distance)
					c.distance = distance
					near_customers.push(c)
				end
			end
			near_customers.sort! do
				|x, y| x.distance <=> y.distance
			end
			near_customers
		end
	end
end
