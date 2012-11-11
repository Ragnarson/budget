require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    sign_in users(:user3)
  end

  def after
    DatabaseCleaner.clean
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:user)
  end

  test "should be form on page" do
    get :new
    assert_select 'form' do
      assert_select 'input#user_email'
      assert_select 'input[TYPE=submit]'
    end
  end

  test "should create user" do
    post :create, :user => {:email => 'craven@o2.pl'}
    user = User.new(@request.params[:user])
  end

  test "should error when email is empty" do
    post :create, :user => {:email => ''}
    assert_tag :tag => 'span', :content => "can't be blank"
    assert_template :new
  end
end
