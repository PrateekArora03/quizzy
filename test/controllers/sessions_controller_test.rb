require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.new(first_name: "Prateek", last_name: "Arora", email: "prateek@gmail.com", password: "welcome", password_confirmation: "welcome", role: "administrator")
    @user.save!
  end

  test "should get new" do
    get new_sessions_path

    assert_equal "new", @controller.action_name
    assert_response :success
  end

  test "should redirect new if logged in" do
    login_user(@user)
    get new_sessions_path

    assert_equal "new", @controller.action_name
    assert_redirected_to root_path
  end

  test "should redirect create on successful login" do
    login_user(@user)

    assert_equal "create", @controller.action_name
    assert_not_nil session[:user_id]
    assert_equal "Successfully logged in!", flash[:success]
    assert_redirected_to root_path
  end

  test "should display a message on failed login" do
    @user.email = "example@example.com"
    login_user(@user)

    assert_equal "create", @controller.action_name
    assert_equal "Invalid email/password combination", flash[:danger]
    assert_redirected_to new_sessions_path
  end

  test "should redirect destroy when not logged in" do
    delete sessions_path

    assert_equal "destroy", @controller.action_name
    assert_redirected_to new_sessions_path
  end

  test "should logout and redirect" do
    login_user(@user)
    delete sessions_path

    assert_equal "destroy", @controller.action_name
    assert_nil session[:user_id]
    assert_equal "Logged out!", flash[:warning]
    assert_redirected_to new_sessions_path
  end
end
