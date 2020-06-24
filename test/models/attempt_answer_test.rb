require 'test_helper'

class AttemptAnswerTest < ActiveSupport::TestCase

  def setup
    @user = User.create!(first_name: "Example", last_name: "User", email: "user@example.com", password: "welcome", password_confirmation: "welcome")
    @quiz = @user.quizzes.build(name: "Example");
    @quiz.save!
    @question = @quiz.questions.build(description: "demo question", options: ["user1", "user2"], correct_answer: 2)
    @question.save!
    @attempt = @user.attempts.build(quiz_id: @quiz.id)
    @attempt.save!
    @attempt_answer = @attempt.attempt_answers.build(question_id: @question.id, submitted_option: 1)
  end

  test "should be valid" do
    assert @attempt_answer.valid?
  end

  test "question id should be present" do
    @attempt_answer.question_id = nil
    assert_not @attempt_answer.valid?
    assert_equal ["Question must exist"], @attempt_answer.errors.full_messages
  end

  test "submitted_option should be present" do
    @attempt_answer.submitted_option = nil
    assert_not @attempt.valid?
    assert_equal ["Attempt answers is invalid"], @attempt.errors.full_messages
  end
end
