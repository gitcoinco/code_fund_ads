require "test_helper"

class ScheduleOrganizationReportJobTest < ActiveJob::TestCase
  test "first report is scheduled immediately if start date < now" do
    campaign = campaigns(:premium)

    scheduled_report = create(:scheduled_organization_report, organization: campaign.organization)

    freeze_time do
      expected_args = ->(job_args) do
        assert job_args.first[:id] == scheduled_report.id
        assert job_args.first[:deliver_at] == Time.current
      end

      assert_enqueued_with(job: ScheduleOrganizationReportJob, args: expected_args) do
        ScheduleOrganizationReportJob.perform_now(id: scheduled_report.id, deliver_at: nil)
      end
    end
  end

  test "first report is scheduled in the future if start date > now" do
    campaign = campaigns(:premium)
    start_date = 1.month.from_now.to_date
    end_date = 2.months.from_now.to_date

    scheduled_report = create(:scheduled_organization_report, start_date: start_date, end_date: end_date,
                                                              organization: campaign.organization)

    freeze_time do
      expected_args = ->(job_args) do
        assert job_args.first[:id] == scheduled_report.id
        assert job_args.first[:deliver_at] == start_date.midnight
      end

      assert_enqueued_with(job: ScheduleOrganizationReportJob, args: expected_args) do
        ScheduleOrganizationReportJob.perform_now(id: scheduled_report.id, deliver_at: nil)
      end
    end
  end

  test "first report is not scheduled when scheduled report is expired" do
    campaign = campaigns(:premium)
    start_date = 2.months.ago.to_date
    end_date = 1.month.ago.to_date
    scheduled_report = create(:scheduled_organization_report, start_date: start_date, end_date: end_date,
                                                              organization: campaign.organization)

    assert_no_enqueued_jobs do
      ScheduleOrganizationReportJob.perform_now(id: scheduled_report.id, deliver_at: Time.now)
    end
  end

  test "report is generated when provided timestamp" do
    campaign = campaigns(:premium)
    start_date = 1.month.ago.to_date
    end_date = 2.months.from_now.to_date

    scheduled_report = create(:scheduled_organization_report,
      start_date: start_date,
      end_date: end_date,
      organization: campaign.organization,
      dataset: "past_7_days")

    freeze_time do
      expected_args = ->(job_args) do
        assert job_args.first[:id].present?
        assert_match %r{\/organization\/\d+\/reports\/\d+}, job_args.first[:report_url]
        assert_equal job_args.first[:recipients], scheduled_report.recipients
      end

      assert_enqueued_with(job: GenerateOrganizationReportJob, args: expected_args) do
        ScheduleOrganizationReportJob.perform_now(id: scheduled_report.id, deliver_at: Time.now)
        report = campaign.organization.organization_reports.first
        assert_equal report.campaign_ids.sort, campaign.organization.campaigns.map(&:id).sort
        assert_equal 8.days.ago.to_date, report.start_date
        assert_equal Date.yesterday.to_date, report.end_date
      end
    end
  end
end
