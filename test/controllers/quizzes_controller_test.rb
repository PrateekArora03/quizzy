require 'test_helper'

class QuizzesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.new(first_name: "Prateek", last_name: "Arora", email: "prateek@gmail.com", password: "welcome", password_confirmation: "welcome")
    @user.save!
  end

  test "should redirect index when not logged in" do
    get root_path

    assert_equal "index", @controller.action_name
    assert_redirected_to new_sessions_path
  end
end
