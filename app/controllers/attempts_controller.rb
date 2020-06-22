class AttemptsController < ApplicationController
  skip_before_action :ensure_user_logged_in
  before_action :load_quiz
  before_action :load_attempt, only: [:edit, :update, :show]
  
  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      p @attempt = @user.attempts.build({ quiz_id: @quiz.id, submitted: false })
      if @attempt.save
        render status: :created, json: { attempt_id: @attempt.id }
      else
        render status: :unprocessable_entity, json: { errors: @attempt.errors.full_messages }
      end
    else
      render status: :unprocessable_entity, json: { errors: @user.errors.full_messages }
    end
  end

  def edit
    if @attempt.submitted
      flash[:warning] = "This attempt has already submitted!"
      redirect_to quizzes_path
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
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
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
      p "========="
      p @attempt = Attempt.find(params[:id]);
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
