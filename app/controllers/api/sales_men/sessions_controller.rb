class Api::SalesMen::SessionsController < Devise::SessionsController
	include Api::AuthenticationHelper

	skip_before_action :verify_authenticity_token
	skip_before_action :verify_signed_out_user


	def create
		@salesman = SalesMan.find_for_database_authentication(:username => params[:api_sales_man][:username])
		if @salesman.present? and @salesman.valid_password?(params[:api_sales_man][:password])
			respond_to do |format|
				format.json {render json: {:auth_token => @salesman.auth_token}, status: :ok}
			end
		else
			respond_to do |format|
				format.json {render json: {:error => "Invalid login"}, status: :unauthorized}
			end
		end
	end

	def destroy
		current_salesman = find_salesman_by_token
		if(!current_salesman.present?)
			return unauthorized
		end
		respond_to do |format|
			format.json { render json: {message: "logged out"}, status: :ok }
		end
	end

end
