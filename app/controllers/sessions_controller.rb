class SessionsController < ApplicationController
  before_action :logged_in_user, except: [:destroy]
  skip_before_action :logged_out_user, except: [:destroy]

  def new
    render
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      log_in user
      flash[:success] = "Successfully logged in!"
      redirect_to dashboard_path
    else
      flash.now[:danger] = 'Invalid email/password combination.'
      redirect_to login_url
    end
  end

  def destroy
    log_out
    respond_to do |format|
      format.html do
        flash[:warning] = "Logged out!"
        redirect_to login_url
      end
      format.json { render status: :ok, json: { message: "Successfully logged out!" } }
    end
  end
end
