require 'test_helper'

class ErrorsControllerTest < ActionController::TestCase

  test "should render 404 error page and return 404 status" do
    get :routing
    assert_template "404"
    assert_response :missing
  end

end
