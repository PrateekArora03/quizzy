class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :ensure_user_logged_out

  private
    def ensure_user_logged_in
      if logged_in?
        redirect_to root_path
      end
    end

    def ensure_user_logged_out
      unless logged_in?
        respond_to do |format|
          format.html do
            flash[:danger] = "Please Log In"
            redirect_to new_sessions_path
          end
          format.json { render status: :unauthorized, json: { errors: "You need to login" } }
        end
      end
    end

    def load_quiz
      @quiz = current_user.quizzes.find(params[:quiz_id] || params[:id]);
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

    def load_question
      @question = @quiz.questions.find(params[:id]);
      rescue ActiveRecord::RecordNotFound => errors
        respond_to do |format|
          format.html do
            flash[:warning] = "Question not found!"
            redirect_to quizzes_path
          end
          format.json { render status: :not_found, json: {errors: ["Question not found!"] }
        }
      end
    end
end
