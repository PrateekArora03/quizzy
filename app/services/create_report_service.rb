class CreateReportService < ApplicationService
  HEADER_ROW_NAME = ["Quiz name", "User name", "Email", "Correct answers", "Incorrect answers"]

  def initialize(user_id, job_id)
    @user_id = user_id
    @job_id = job_id
  end

  def call
    current_user = User.find(@user_id)
    quizzes = current_user.quizzes.published
    file_name = "report_"+Time.now.strftime("%Y-%m-%d_%H-%M-%S")+".csv"
    file_path = "#{Rails.root}/public/csv/#{file_name}"
    CSV.open(file_path, "wb") do |csv|
      csv << HEADER_ROW_NAME
      quizzes.each do |quiz|
        quiz.attempts.submitted_attempts.each do |attempt|
          csv << [quiz.name,
                attempt.user.first_name + " " + attempt.user.last_name,
                attempt.user.email,
                attempt.correct_answers_count,
                attempt.incorrect_answers_count]
        end
      end
    end
    job = current_user.jobs.build(job_id: @job_id, filename: file_path, status: "done")
    job.save!
  end
end
