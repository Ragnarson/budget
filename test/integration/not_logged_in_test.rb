require 'test_helper'

class NotLoggedInTest < ActionDispatch::IntegrationTest
  
  test "should respond with success when non-logged in user is accessing english homepage" do
    get "/en/"
    assert_response :success 
  end

  test "should respond with success when non-logged in user is accessing polish homepage" do
    get "/pl/"
    assert_response :success 
  end

end
