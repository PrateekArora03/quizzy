require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.new(first_name: "Prateek", last_name: "Arora", email: "prateek@gmail.com", password: "welcome", password_confirmation: "welcome")
    @user.save!
  end

  test "should get new" do
    get login_url

    assert_equal "new", @controller.action_name
    assert_response :success
  end

  test "should redirect new if logged in" do
    login_user(@user)
    get login_url

    assert_equal "new", @controller.action_name
    assert_redirected_to dashboard_path
  end

  test "should redirect create on successful login" do
    login_user(@user)

    assert_equal "create", @controller.action_name
    assert_not_nil session[:user_id]
    assert_equal "Successfully logged in!", flash[:success]
    assert_redirected_to dashboard_path
  end

  test "should display a message on failed login" do
    @user.email = "example@example.com"
    login_user(@user)

    assert_equal "create", @controller.action_name
    assert_equal "Invalid email/password combination.", flash[:danger]
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    delete "/sessions/+#{@user.id}"

    assert_equal "destroy", @controller.action_name
    assert_redirected_to login_url
  end

  test "should logout and redirect" do
    login_user(@user)
    delete "/sessions/+#{@user.id}"

    assert_equal "destroy", @controller.action_name
    assert_nil session[:user_id]
    assert_equal "Logged out!", flash[:warning]
    assert_redirected_to login_url
  end
end
