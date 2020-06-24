class AttemptsController < ApplicationController
  skip_before_action :ensure_user_logged_in
  before_action :load_quiz
  before_action :load_attempt, only: [:edit, :update, :show]
  
  def new
  end

  def create
    ActiveRecord::Base.transaction do
      @user = User.where(email: user_params[:email]).first_or_initialize(user_params)
      @user.password = "welcome_regular_user"
      @user.save!
      @attempt = @user.attempts.where(quiz_id: @quiz.id).first_or_initialize
      @attempt.save!
    end
    if @attempt
      render status: :created, json: { attempt_id: @attempt.id }
    else
      render status: :unprocessable_entity, json: { errors: @attempt.errors.full_messages }
    end
  end

  def edit
    if @attempt.submitted
      flash[:warning] = "This quiz has already attempted by the user."
      redirect_to public_attempt_path
    else
      render
    end
  end

  def update
    @questions = @quiz.questions
    attempt_params[:options].each_with_index do |option, index|
      @attempt_answer = @attempt.attempt_answers.build({submitted_option: option, question_id: @questions[index].id})
      if @questions[index].correct_answer == option
        @attempt.increment!(:correct_answers_count)
      else
        @attempt.increment!(:incorrect_answers_count)
      end
      if !@attempt_answer.save
        render status: :unprocessable_entity, json: { errors: @attempt_answer.errors.full_messages }
      end
    end
    @attempt.submitted = true
    if @attempt.save
      render status: :created, json: { messages: "Attempt submitted!" }
    else
      render status: :unprocessable_entity, json: { errors: @attempt_answer.errors.full_messages }
    end
  end

  def show
    @attempt_answer = @attempt.attempt_answers.as_json(include: :question)
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end

    def attempt_params
      params.require(:attempts).permit(options: [])
    end

    def load_quiz
      @quiz = Quiz.find_by_slug(params[:public_id]);
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

    def load_attempt
      @attempt = Attempt.find(params[:id]);
      rescue ActiveRecord::RecordNotFound => errors
        respond_to do |format|
          format.html do
            flash[:warning] = "Attempt not found!"
            redirect_to quizzes_path
          end
          format.json { render status: :not_found, json: { errors: ["Attempt not found!"] }
        }
      end
    end
end
