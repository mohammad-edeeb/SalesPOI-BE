require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
  end

  test "should get index" do
    get customers_url
    assert_response :success
  end

  test "should get new" do
    get new_customer_url
    assert_response :success
  end

  test "should create customer" do
    assert_difference('Customer.count') do
      post customers_url, params: { customer: { extra1: @customer.extra1, extra2: @customer.extra2, extra3: @customer.extra3, id: @customer.id, last_invoice_at: @customer.last_invoice_at, last_trx_amount: @customer.last_trx_amount, last_visited_at: @customer.last_visited_at, lat: @customer.lat, long: @customer.long, name: @customer.name, salesman_name: @customer.salesman_name, status: @customer.status, zone_name: @customer.zone_name } }
    end

    assert_redirected_to customer_url(Customer.last)
  end

  test "should show customer" do
    get customer_url(@customer)
    assert_response :success
  end

  test "should get edit" do
    get edit_customer_url(@customer)
    assert_response :success
  end

  test "should update customer" do
    patch customer_url(@customer), params: { customer: { extra1: @customer.extra1, extra2: @customer.extra2, extra3: @customer.extra3, id: @customer.id, last_invoice_at: @customer.last_invoice_at, last_trx_amount: @customer.last_trx_amount, last_visited_at: @customer.last_visited_at, lat: @customer.lat, long: @customer.long, name: @customer.name, salesman_name: @customer.salesman_name, status: @customer.status, zone_name: @customer.zone_name } }
    assert_redirected_to customer_url(@customer)
  end

  test "should destroy customer" do
    assert_difference('Customer.count', -1) do
      delete customer_url(@customer)
    end

    assert_redirected_to customers_url
  end
end
