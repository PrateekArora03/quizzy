class QuestionsController < ApplicationController

  def new
    @quiz = current_user.quizzes.find(params[:quiz_id]);
    render
  end
end
