class Api::SalesMen::ActionsController < ApplicationController
	include Api::AuthenticationHelper

	skip_before_action :verify_authenticity_token

	def near_customers
		current_salesman = find_salesman_by_token
		if(!current_salesman.present?)
			return unauthorized
		end
		user_long = params[:long]
		user_lat = params[:lat]
		puts user_lat
		puts user_long
		@near_customers = Customer.find_near_customers(user_lat, user_long)
		respond_to do |format|
			format.json { render json: @near_customers, status: :ok }
		end
	end

	def destroy
		current_salesman = find_salesman_by_token
		if(!current_salesman.present?)
			return unauthorized
		end
		current_salesman.regenerate_auth_token
		respond_to do |format|
			format.json { render json: {message: "logged out"}, status: :ok }
		end
	end

end
