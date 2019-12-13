require "test_helper"

class CreateNewPropertyNotificationJobTest < ActiveJob::TestCase
  setup do
    @property = properties(:website)
  end

  test "job is properly enqueued" do
    CreateSlackNotificationJob.stubs(perform_later: true)
    PropertiesMailer.any_instance.stubs(deliver_later: true)

    assert_enqueued_with(job: CreateNewPropertyNotificationJob) do
      CreateNewPropertyNotificationJob.perform_later(@property)
    end
  end

  test "job enques two more jobs" do
    Sidekiq::Testing.inline! do
      assert_enqueued_jobs 2 do
        CreateNewPropertyNotificationJob.perform_now(@property)
      end
    end
  end
end
