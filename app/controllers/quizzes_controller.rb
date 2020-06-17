class QuizzesController < ApplicationController
  before_action :load_quiz, only: [:show, :edit, :update, :destroy]

  def index
    @quizzes = current_user.quizzes.as_json(only: [:id, :name])
  end

  def new
    render
  end

  def show
    @questions = @quiz.questions.all
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
    if params[:publish]
      @quiz.generate_slug
      @quiz.save!
      return render status: :ok, json: { slug: @quiz.slug }
    elsif @quiz.update(quiz_params)
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
end
