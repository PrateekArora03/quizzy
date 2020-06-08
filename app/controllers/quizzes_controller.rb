class QuizzesController < ApplicationController

  def index
    render
  end

  def new
    render
  end

  def create
    @quiz = current_user.quizzes.build(quiz_params)
    if @quiz.save
      flash[:success] = "Successfully created the quiz!"
      render status: :created, json: { message: "Successfully created the quiz!" }
    else
      render status: :unprocessable_entity, json: { errors: @quiz.errors.full_messages }
    end
  end

  private
    def quiz_params
      params.require(:quiz).permit(:name)
    end
end
