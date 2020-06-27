require 'test_helper'

class JobTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(first_name: "Example", last_name: "User", email: "user@example.com", password: "welcome", password_confirmation: "welcome")
    @job = @user.jobs.build(job_id: "djdjf45456fjh", filename: "/public/csv/filename", status: "done")
  end

  test "should be valid" do
    assert @job.valid?
  end

  test "job_id should be present" do
    @job.job_id = " " * 5
    assert_not @job.valid?
    assert_equal "Job can't be blank", @job.errors.full_messages[0]
  end

  test "filename should be present" do
    @job.filename = " " * 5
    assert_not @job.valid?
    assert_equal "Filename can't be blank", @job.errors.full_messages[0]
  end

  test "status should be present" do
    @job.status = " " * 5
    assert_not @job.valid?
    assert_equal "Status can't be blank", @job.errors.full_messages[0]
  end

  test "user id should be present" do
    @job = Job.create(job_id: "djdjf45456fjh", filename: "/public/csv/filename", status: "done")
    assert_not @job.valid?
    assert_equal ["User must exist"], @job.errors.full_messages
  end
end
