require "test_helper"

class DateTest < ActiveSupport::TestCase
  test "cache key 1 same day" do
    time = Time.parse("2019-01-01T00:00:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/010"
    travel_back
  end

  test "cache key 1 day past" do
    time = Time.parse("2019-01-02T00:00:00Z")
    travel_to time
    assert Date.parse("2019-01-01").cache_key == "2019-01-01/010"
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
    assert time.to_date.cache_key == "2019-01-01/010"
    travel_back
  end

  test "cache key at 1 mins" do
    time = Time.parse("2019-01-01T00:01:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0100"
    travel_back
  end

  test "cache key at 2 mins" do
    time = Time.parse("2019-01-01T00:02:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0100"
    travel_back
  end

  test "cache key at 3 mins" do
    time = Time.parse("2019-01-01T00:03:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0100"
    travel_back
  end

  test "cache key at 4 mins" do
    time = Time.parse("2019-01-01T00:04:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0100"
    travel_back
  end

  test "cache key at 5 mins" do
    time = Time.parse("2019-01-01T00:05:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0100"
    travel_back
  end

  test "cache key at 6 mins" do
    time = Time.parse("2019-01-01T00:06:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0100"
    travel_back
  end

  test "cache key at 7 mins" do
    time = Time.parse("2019-01-01T00:07:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0100"
    travel_back
  end

  test "cache key at 8 mins" do
    time = Time.parse("2019-01-01T00:08:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0100"
    travel_back
  end

  test "cache key at 9 mins" do
    time = Time.parse("2019-01-01T00:09:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0100"
    travel_back
  end

  test "cache key at 10 mins" do
    time = Time.parse("2019-01-01T00:10:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0100"
    travel_back
  end

  test "cache key at 11 mins" do
    time = Time.parse("2019-01-01T00:11:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0101"
    travel_back
  end

  test "cache key at 15 mins" do
    time = Time.parse("2019-01-01T00:15:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0101"
    travel_back
  end

  test "cache key at 20 mins" do
    time = Time.parse("2019-01-01T00:20:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0101"
    travel_back
  end

  test "cache key at 25 mins" do
    time = Time.parse("2019-01-01T00:25:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0102"
    travel_back
  end

  test "cache key at 30 mins" do
    time = Time.parse("2019-01-01T00:30:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0102"
    travel_back
  end

  test "cache key at 35 mins" do
    time = Time.parse("2019-01-01T00:35:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0103"
    travel_back
  end

  test "cache key at 40 mins" do
    time = Time.parse("2019-01-01T00:40:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0103"
    travel_back
  end

  test "cache key at 45 mins" do
    time = Time.parse("2019-01-01T00:45:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0104"
    travel_back
  end

  test "cache key at 50 mins" do
    time = Time.parse("2019-01-01T00:50:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0104"
    travel_back
  end

  test "cache key at 55 mins" do
    time = Time.parse("2019-01-01T00:55:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0105"
    travel_back
  end

  test "cache key at 59 mins" do
    time = Time.parse("2019-01-01T00:59:00Z")
    travel_to time
    assert time.to_date.cache_key == "2019-01-01/0105"
    travel_back
  end
end
