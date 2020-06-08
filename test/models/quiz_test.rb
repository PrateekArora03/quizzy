require 'test_helper'

class QuizTest < ActiveSupport::TestCase

  def setup
    @user = User.create!(first_name: "Example", last_name: "User", email: "user@example.com", password: "welcome", password_confirmation: "welcome")
    @quiz = @user.quizzes.build(name: "Example");
  end

  test "should be valid" do
    assert @quiz.valid?
  end

  test "name should be present" do
    @quiz.name = " " * 5
    assert_not @quiz.valid?
    assert_equal "Name can't be blank", @quiz.errors.full_messages[0]
  end

  test "name should have a valid length" do
    @quiz.name = "a" * 3
    assert_not @quiz.valid?
    assert_equal ["Name is too short (minimum is 4 characters)"], @quiz.errors.full_messages
  end

  test "user id should be present" do
    @quiz = Quiz.create({ name: "interview" })
    assert_not @quiz.valid?
    assert_equal ["User must exist"], @quiz.errors.full_messages
  end
end
