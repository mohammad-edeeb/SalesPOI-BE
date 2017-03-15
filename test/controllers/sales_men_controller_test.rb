require 'test_helper'

class SalesMenControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sales_man = sales_men(:one)
  end

  test "should get index" do
    get sales_men_url
    assert_response :success
  end

  test "should get new" do
    get new_sales_man_url
    assert_response :success
  end

  test "should create sales_man" do
    assert_difference('SalesMan.count') do
      post sales_men_url, params: { sales_man: { password: @sales_man.password, username: @sales_man.username } }
    end

    assert_redirected_to sales_man_url(SalesMan.last)
  end

  test "should show sales_man" do
    get sales_man_url(@sales_man)
    assert_response :success
  end

  test "should get edit" do
    get edit_sales_man_url(@sales_man)
    assert_response :success
  end

  test "should update sales_man" do
    patch sales_man_url(@sales_man), params: { sales_man: { password: @sales_man.password, username: @sales_man.username } }
    assert_redirected_to sales_man_url(@sales_man)
  end

  test "should destroy sales_man" do
    assert_difference('SalesMan.count', -1) do
      delete sales_man_url(@sales_man)
    end

    assert_redirected_to sales_men_url
  end
end
