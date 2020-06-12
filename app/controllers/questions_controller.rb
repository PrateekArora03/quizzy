class QuestionsController < ApplicationController
  before_action :load_quiz, only: [:new, :create]

  def new
    render
  end

  def create
    @question = @quiz.questions.build(question_params)
    if @question.save
      flash[:success] = "Successfully created the question!"
      render status: :created, json: { message: "Successfully created the question!" }
    else
      render status: :unprocessable_entity, json: { errors: @question.errors.full_messages }
    end
  end

  private
    def question_params
      params.require(:question).permit(:description, :correct_answer, options: [])
    end
end
