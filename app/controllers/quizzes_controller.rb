class QuizzesController < ApplicationController
  before_action :load_quiz, only: [:show, :edit, :update, :destroy]

  def index
    @quizzes = current_user.quizzes.as_json(only: [:id, :name])
  end

  def new
    render
  end

  def show
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

  def edit
    render
  end

  def update
    if @quiz.update(quiz_params)
      flash[:success] = "Quiz updated!"
    else
      render status: :unprocessable_entity, json: { errors: @quiz.errors.full_messages }
    end
  end

  def destroy
    if @quiz.destroy
      flash[:success] = "Quiz deleted!"
    else
      render status: :unprocessable_entity, json: { errors: @quiz.errors.full_messages }
    end
  end

  private
    def quiz_params
      params.require(:quiz).permit(:name)
    end

    def load_quiz
    @quiz = current_user.quizzes.find(params[:id])
      rescue ActiveRecord::RecordNotFound => errors
        respond_to do |format|
          format.html do
            flash[:warning] = "Quiz not found!"
            redirect_to quizzes_path
          end
          format.json { render status: :not_found, json: {errors: ["Quiz not found!"] }
        }
        end
    end
end
