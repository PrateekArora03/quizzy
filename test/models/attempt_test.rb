require 'test_helper'

class AttemptTest < ActiveSupport::TestCase

  def setup
    @user = User.create!(first_name: "Example", last_name: "User", email: "user@example.com", password: "welcome", password_confirmation: "welcome")
    @quiz = @user.quizzes.build(name: "Example");
    @quiz.save!
    @attempt = @user.attempts.build(quiz_id: @quiz.id)
  end

  test "attempt should be valid" do
    assert @attempt.valid?
  end

  test "quiz id should be present" do
    @attempt.quiz_id = nil
    assert_not @attempt.valid?
    assert_equal ["Quiz must exist"], @attempt.errors.full_messages
  end

  test "correct answers count should be present" do
    @attempt.correct_answers_count = nil
    assert_not @attempt.valid?
    assert_equal ["Correct answers count can't be blank"], @attempt.errors.full_messages
  end

  test "incorrect answers count should be present" do
    @attempt.incorrect_answers_count = nil
    assert_not @attempt.valid?
    assert_equal ["Incorrect answers count can't be blank"], @attempt.errors.full_messages
  end
end
