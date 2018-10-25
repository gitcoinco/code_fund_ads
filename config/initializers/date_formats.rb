# frozen_string_literal: true

date_formats = {
  "mm/dd/yyyy" => "%m/%d/%Y",
  "Mon, dd YYYY" => "%b, %d %Y",
}

Date::DATE_FORMATS.merge! date_formats
Time::DATE_FORMATS.merge! date_formats
DateTime::DATE_FORMATS.merge! date_formats
