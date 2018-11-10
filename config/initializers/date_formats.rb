# frozen_string_literal: true

date_formats = {
  "mm/dd/yyyy" => "%m/%d/%Y",
  "yyyy_mm" => "%Y_%m",
}

Date::DATE_FORMATS.merge! date_formats
Time::DATE_FORMATS.merge! date_formats
DateTime::DATE_FORMATS.merge! date_formats
