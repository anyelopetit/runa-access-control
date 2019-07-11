require 'test_helper'

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get employees_new_url
    assert_response :success
  end

  test "should get create" do
    get employees_create_url
    assert_response :success
  end

  test "should get edit" do
    get employees_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get employees_destroy_url
    assert_response :success
  end

  test "should get check" do
    get employees_check_url
    assert_response :success
  end

end
