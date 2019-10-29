require "test_helper"

class DateTest < ActiveSupport::TestCase
  test "cache key 1 same day" do
    time = Time.parse("2019-01-01T00:00:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/015"
    travel_back
  end

  test "cache key 1 day past" do
    time = Time.parse("2019-01-02T00:00:00Z")
    travel_to time
    assert Date.parse("2019-01-01").cache_key == "2019-01-01/015"
    travel_back
  end

  test "cache key 2 days past" do
    time = Time.parse("2019-01-03T00:00:00Z")
    travel_to time
    assert Date.parse("2019-01-01").cache_key == "2019-01-01"
    travel_back
  end

  test "cache key 3 days past" do
    time = Time.parse("2019-01-04T00:00:00Z")
    travel_to time
    assert Date.parse("2019-01-01").cache_key == "2019-01-01"
    travel_back
  end

  test "cache key at 0 mins" do
    time = Time.parse("2019-01-01T00:00:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/015"
    travel_back
  end

  test "cache key at 1 mins" do
    time = Time.parse("2019-01-01T00:01:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0150"
    travel_back
  end

  test "cache key at 2 mins" do
    time = Time.parse("2019-01-01T00:02:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0150"
    travel_back
  end

  test "cache key at 3 mins" do
    time = Time.parse("2019-01-01T00:03:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0150"
    travel_back
  end

  test "cache key at 4 mins" do
    time = Time.parse("2019-01-01T00:04:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0150"
    travel_back
  end

  test "cache key at 5 mins" do
    time = Time.parse("2019-01-01T00:05:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0150"
    travel_back
  end

  test "cache key at 6 mins" do
    time = Time.parse("2019-01-01T00:06:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0150"
    travel_back
  end

  test "cache key at 7 mins" do
    time = Time.parse("2019-01-01T00:07:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0150"
    travel_back
  end

  test "cache key at 8 mins" do
    time = Time.parse("2019-01-01T00:08:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0150"
    travel_back
  end

  test "cache key at 9 mins" do
    time = Time.parse("2019-01-01T00:09:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0150"
    travel_back
  end

  test "cache key at 10 mins" do
    time = Time.parse("2019-01-01T00:10:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0150"
    travel_back
  end

  test "cache key at 11 mins" do
    time = Time.parse("2019-01-01T00:11:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0150"
    travel_back
  end

  test "cache key at 15 mins" do
    time = Time.parse("2019-01-01T00:15:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0150"
    travel_back
  end

  test "cache key at 20 mins" do
    time = Time.parse("2019-01-01T00:20:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0151"
    travel_back
  end

  test "cache key at 25 mins" do
    time = Time.parse("2019-01-01T00:25:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0151"
    travel_back
  end

  test "cache key at 30 mins" do
    time = Time.parse("2019-01-01T00:30:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0151"
    travel_back
  end

  test "cache key at 35 mins" do
    time = Time.parse("2019-01-01T00:35:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0152"
    travel_back
  end

  test "cache key at 40 mins" do
    time = Time.parse("2019-01-01T00:40:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0152"
    travel_back
  end

  test "cache key at 45 mins" do
    time = Time.parse("2019-01-01T00:45:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0152"
    travel_back
  end

  test "cache key at 50 mins" do
    time = Time.parse("2019-01-01T00:50:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0153"
    travel_back
  end

  test "cache key at 55 mins" do
    time = Time.parse("2019-01-01T00:55:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0153"
    travel_back
  end

  test "cache key at 59 mins" do
    time = Time.parse("2019-01-01T00:59:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0153"
    travel_back
  end

  test "coerce with nil" do
    assert Date.coerce(nil) == Date.current
  end

  test "coerce with garbage" do
    assert Date.coerce("f dkaj4.32d") == Date.current
  end

  test "coerce with valid string" do
    assert Date.coerce("2020-07-19") == Date.parse("2020-07-19")
  end

  test "coerce with min" do
    assert Date.coerce(30.days.ago, min: 5.days.ago) == 5.days.ago.to_date
  end

  test "coerce with max" do
    assert Date.coerce(30.days.from_now, max: 5.days.from_now) == 5.days.from_now.to_date
  end

  test "coerce with min/max and legal values" do
    assert Date.coerce(30.days.ago, min: 30.days.ago, max: 5.days.from_now) == 30.days.ago.to_date
    assert Date.coerce(5.days.from_now, min: 30.days.ago, max: 5.days.from_now) == 5.days.from_now.to_date
    assert Date.coerce(15.days.ago, min: 30.days.ago, max: 5.days.from_now) == 15.days.ago.to_date
  end
end
