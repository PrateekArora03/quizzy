require 'test_helper'

class QuestionTest < ActiveSupport::TestCase

  def setup
    @user = User.create!(first_name: "Example", last_name: "User", email: "user@example.com", password: "welcome", password_confirmation: "welcome")
    @quiz = @user.quizzes.build(name: "Example");
    @quiz.save!
    @question = @quiz.questions.build(description: "Example question", options:["option 1","option 2"], correct_answer: 2);
  end

  test "should be valid" do
    assert @question.valid?
  end

  test "description should be present" do
    @question.description = "" * 8
    assert_not @question.valid?
    assert_equal "Description can't be blank", @question.errors.full_messages[0]
  end

  test "description should have a valid length" do
    @question.description = "a" * 6
    assert_not @question.valid?
    assert_equal "Description is too short (minimum is 7 characters)", @question.errors.full_messages[0]
  end

  test "options should be present" do
    @question.options = ""
    assert_not @question.valid?
    assert_equal "Options can't be blank", @question.errors.full_messages[0]
  end

  test "options should have some value on each index" do
    @question.options = ["option1", ""]
    assert_not @question.valid?
    assert_equal "Options can't be blank", @question.errors.full_messages[0]
  end

  test "options should have atleast 2 values" do
    @question.options = ["option1"]
    assert_not @question.valid?
    assert_equal "Options should have atleast 2 values", @question.errors.full_messages[0]
  end

  test "options should not have more than 4 values" do
    @question.options = ["option1","option2","option3","option4", "option5"]
    assert_not @question.valid?
    assert_equal "Options should not have more than 4 values", @question.errors.full_messages[0]
  end

  test "correct answer should be present" do
    @question.correct_answer = ""
    assert_not @question.valid?
    assert_equal "Correct answer can't be blank", @question.errors.full_messages[0]
  end

  test "correct answer should be between 1 to 4" do
    @question.correct_answer = 5
    assert_not @question.valid?
    assert_equal "Correct answer is not included in the list", @question.errors.full_messages[0]
  end
end
