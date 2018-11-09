# frozen_string_literal: true

date_formats = {
  "mm/dd/yyyy" => "%m/%d/%Y",
  "yyyy-mm" => "%Y-%m",
}

Date::DATE_FORMATS.merge! date_formats
Time::DATE_FORMATS.merge! date_formats
DateTime::DATE_FORMATS.merge! date_formats
