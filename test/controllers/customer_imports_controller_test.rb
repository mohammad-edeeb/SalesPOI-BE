require 'test_helper'

class CustomerImportsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get customer_imports_new_url
    assert_response :success
  end

end
