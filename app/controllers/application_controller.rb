class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :ensure_user_logged_out

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
end
