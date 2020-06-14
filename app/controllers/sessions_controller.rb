class SessionsController < ApplicationController
  before_action :ensure_user_not_logged_in, except: [:destroy]
  skip_before_action :ensure_user_logged_in, except: [:destroy]

  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user
      if user.role != "administrator"
        flash[:danger] = 'Unauthorized user!'
        redirect_to new_sessions_path
      else user.authenticate(params[:password])
        log_in user
        flash[:success] = "Successfully logged in!"
        redirect_to root_path
      end
    else
      flash[:danger] = 'Invalid email/password combination'
      redirect_to new_sessions_path
    end
  end

  def destroy
    log_out
    respond_to do |format|
      format.html do
        flash[:warning] = "Logged out!"
        redirect_to new_sessions_path
      end
      format.json { render status: :ok, json: { message: "Successfully logged out!" } }
    end
  end
end
