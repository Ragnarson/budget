require 'test_helper'

class WalletsControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wallet)
  end

  test "should be form on page" do
    get :index
    assert_select 'form' do
      assert_select 'input#wallet_name'
      assert_select 'input[TYPE=submit]'
    end
  end

  test "should create budget and redirect to index with notice" do
    post :create, :wallet => { :name=> 'Some title'}
    assert_redirected_to :new_budget
    assert_equal 'Your budget was added successfully', flash[:notice]
  end

  test "should redirect to index with error" do
    post :create, :wallet => { :name=> ''}
    assert_redirected_to :new_budget
    assert_equal 'Budget could not be empty', flash[:error]
  end
end
