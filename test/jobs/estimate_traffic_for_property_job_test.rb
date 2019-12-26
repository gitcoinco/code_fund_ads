require "test_helper"

class EstimateTrafficForPropertyJobTest < ActiveJob::TestCase
  test "str_to_number with currency" do
    subject = EstimateTrafficForPropertyJob.new
    assert subject.str_to_number("$1,234.56") == 1234.56
    assert subject.str_to_number("2,448,420") == 2448420
    assert subject.str_to_number("-50.390%") == -50.39
    assert subject.str_to_number("+60%") == 60
    assert subject.str_to_number("-15903") == -15903
  end

  test "property traffic is estimated" do
    property = properties(:website)
    assert property.id

    stub_request(:get, /endpoint\.sitetrafficapi\.com/)
      .to_return(status: 200, body: example_payload.to_json, headers: {"Content-Type" => "application/json; charset=utf-8"})

    EstimateTrafficForPropertyJob.perform_now(property.id)

    estimate = property.property_traffic_estimates.first

    assert estimate.property_id = property.id
    assert estimate.site_worth.format == "$4,897.00"
    assert estimate.visitors_daily == 4293
    assert estimate.visitors_monthly == 128790
    assert estimate.visitors_yearly == 1566945
    assert estimate.pageviews_daily == 6708
    assert estimate.pageviews_monthly == 201240
    assert estimate.pageviews_yearly == 2448420
    assert estimate.revenue_daily.format == "$7.00"
    assert estimate.revenue_monthly.format == "$201.00"
    assert estimate.revenue_yearly.format == "$2,448.00"
    assert estimate.alexa_rank_3_months == 139130
    assert estimate.alexa_rank_1_month == 191055
    assert estimate.alexa_rank_7_days == 153927
    assert estimate.alexa_rank_1_day == 286961
    assert estimate.alexa_rank_delta_3_months == -12650
    assert estimate.alexa_rank_delta_1_month == 88806
    assert estimate.alexa_rank_delta_7_days == -87568
    assert estimate.alexa_rank_delta_1_day == -104154
    assert estimate.alexa_reach_3_months == 125548
    assert estimate.alexa_reach_1_month == 174111
    assert estimate.alexa_reach_7_days == 126952
    assert estimate.alexa_reach_1_day == 237510
    assert estimate.alexa_reach_delta_3_months == -15903
    assert estimate.alexa_reach_delta_1_month == +86511
    assert estimate.alexa_reach_delta_7_days == -106500
    assert estimate.alexa_reach_delta_1_day == -84447
    assert estimate.alexa_pageviews_3_months == 0.24
    assert estimate.alexa_pageviews_1_month == 0.16
    assert estimate.alexa_pageviews_7_days == 0.17
    assert estimate.alexa_pageviews_1_day == 0.08
    assert estimate.alexa_pageviews_delta_3_months == 0.05
    assert estimate.alexa_pageviews_delta_1_month == -0.5039
    assert estimate.alexa_pageviews_delta_7_days == 0.3
    assert estimate.alexa_pageviews_delta_1_day == 0.6
  end

  private

  def example_payload
    {"data" =>
      {"estimations" =>
        {"site_worth" => "$4,897",
         "visitors" => {"daily" => "4,293", "monthly" => "128,790", "yearly" => "1,566,945"},
         "pageviews" => {"daily" => "6,708", "monthly" => "201,240", "yearly" => "2,448,420"},
         "revenue" => {"daily" => "$7", "monthly" => "$201", "yearly" => "$2,448"},},
       "alexa" =>
        {"rank" => {"3_months" => "139130", "1_month" => "191055", "7_days" => "153927", "1_day" => "286961"},
         "rank_delta" => {"3_months" => "-12650", "1_month" => "+88806", "7_days" => "-87568", "1_day" => "-104154"},
         "reach" => {"3_months" => "125548", "1_month" => "174111", "7_days" => "126952", "1_day" => "237510"},
         "reach_delta" => {"3_months" => "-15903", "1_month" => "+86511", "7_days" => "-106500", "1_day" => "-84447"},
         "pageviews" => {"3_months" => "0.24", "1_month" => "0.16", "7_days" => "0.17", "1_day" => "0.08"},
         "pageviews_delta" => {"3_months" => "+5%", "1_month" => "-50.390%", "7_days" => "+30%", "1_day" => "+60%"},},},
     "queries_remained" => 45,
     "elapsed_time" => "1.86",}
  end
end
