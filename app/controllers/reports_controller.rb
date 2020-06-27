class ReportsController < ApplicationController

  def create
    job_id = CreateReportWorker.perform_async(current_user.id)
    render status: :ok, json: { processing: true, notice: "Processing", job_id: job_id }
  end

  def show
    @quizzes = current_user.quizzes.published
    respond_to do |format|
      format.html
      format.csv do
        if params[:job_id]
          current_job = current_user.jobs.find_by(job_id: params[:job_id])
          if current_job && current_job[:status] == "done"
            return send_file current_job.filename, type: "application/csv"
          end
          render status: :ok, json: { processing: true, notice: "Processing", job_id: current_job }
        end
      end
    end
  end
end
