require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    sign_in users(:user_without_wallet)
  end

  def after
    DatabaseCleaner.clean
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:user)
  end

  test "should get edit_profile" do
    get :edit_profile
    assert_response :success
    assert_not_nil assigns(:user)
  end

  test "should be form on 'new' page" do
    get :new
    assert_select 'form' do
      assert_select 'input#user_email'
      assert_select 'input[TYPE=submit]'
    end
  end

  test "should be form to choose language on edit_profile" do
    get :edit_profile
    assert_select 'form' do
      assert_select 'select#user_locale'
      assert_select 'input[TYPE=submit]'
    end
  end

  test "should be selected 'en' value in select on form" do
    sign_in users(:user_with_locale_en)
    get :edit_profile
    assert_select 'select#user_locale' do
      assert_select 'option[VALUE=pl]'
      assert_select 'option[VALUE=en][SELECTED=selected]'
    end
  end
  
  test "should be selected 'pl' value in select on form" do
    sign_in users(:user_with_locale_pl)
    get :edit_profile
    assert_select 'select#user_locale' do
      assert_select 'option[VALUE=pl][SELECTED=selected]'
      assert_select 'option[VALUE=en]'
    end
  end

  test "should edit user language and show a success notice" do
    sign_in users(:user_with_locale_en)
    put :update, id: users(:user_with_locale_en), user: {locale: 'pl'}
    assert_equal users(:user_with_locale_en).reload.locale, 'pl'
    assert_equal I18n.t('flash.update_one'), flash[:notice]  
  end

  test "should not edit user with wrong language" do
    sign_in users(:user_with_locale_en)
    put :update, id: users(:user_with_locale_en), user: {locale: 'japonski'}
    assert_equal I18n.t('flash.fail_changes'), flash[:error]  
  end

  test "should create user" do
    post :create, user: {email: 'craven@o2.pl'}
    user = User.new(@request.params[:user])
  end

  test "should show error when email is empty" do
    post :create, user: {email: ''}
    assert_tag tag: 'span', content: I18n.t('errors.messages.blank')
    assert_template :new
  end
end
