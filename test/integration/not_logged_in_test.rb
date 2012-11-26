require 'test_helper'

class NotLoggedInTest < ActionDispatch::IntegrationTest

  test "should get homepage with login button in english" do
    get "/en"
    assert_select "a.btn", I18n.t('home.login')
  end
  
  test "should get homepage with login button in polish" do
    get "/pl"
    assert_select "a.btn", I18n.t('home.login')
  end

  test "should respond with success when non-logged in user is accessing english homepage" do
    get "/en/"
    assert_response :success 
  end

  test "should respond with success when non-logged in user is accessing polish homepage" do
    get "/pl/"
    assert_response :success 
  end

  test "should show error 404 site if page doesn't exists" do
    get "/pl/siema"
    assert_template "404"
  end

end
