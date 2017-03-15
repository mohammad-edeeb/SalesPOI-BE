class SalesMan < ApplicationRecord

	class << self
		def permitted_attrs
			[:username, :password]
		end
	end
end
