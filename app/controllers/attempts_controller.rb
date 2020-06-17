class AttemptsController < ApplicationController
  skip_before_action :ensure_user_logged_in, only: [:new]
  
  def new
    render html: "Welcome"
  end
end
