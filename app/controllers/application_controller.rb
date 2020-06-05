class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :logged_out_user

  def logged_in_user
    if logged_in?
      redirect_to dashboard_path
    end
  end

  def logged_out_user
    unless logged_in?
      respond_to do |format|
        format.html do
          flash[:danger] = "Please Log In"
          redirect_to login_path
        end
        format.json { render status: :unauthorized, json: { errors: "You need to login" } }
      end
    end
  end
end
