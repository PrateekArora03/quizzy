class ReportsController < ApplicationController

  def show
    @quizzes = current_user.quizzes.published
  end
end
