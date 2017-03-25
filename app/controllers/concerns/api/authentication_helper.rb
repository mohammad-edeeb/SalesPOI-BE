module Api::AuthenticationHelper
  extend ActiveSupport::Concern

  def find_salesman_by_token
    token = nil
    sales_man = nil
    if request.headers["Authorization"].present?
      token = request.headers["Authorization"]
    end
    if token.present?
      sales_man = SalesMan.find_by(auth_token: token)
    end
    return sales_man
  end

  def unauthorized
    respond_to do |format|
      format.json {render json: {message: "unauthorized"}, status: :unauthorized}
    end
  end

end
