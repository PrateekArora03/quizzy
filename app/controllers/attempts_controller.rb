class AttemptsController < ApplicationController
  skip_before_action :ensure_user_logged_in, only: [:new]
  before_action :load_quiz, only: [:new]
  
  def new
  end

  private
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
end
