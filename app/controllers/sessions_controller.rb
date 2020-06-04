class SessionsController < ApplicationController
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
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    render status: :ok, json: { message: "Successfully logged out!" }
  end
end
