date_formats = {
  "mm/dd/yyyy" => "%m/%d/%Y",
  "mm/dd" => "%m/%d",
  "yyyy_mm" => "%Y_%m",
  "yyyymmdd" => "%Y%m%d",
  "abdy" => "%a, %b %-d, %Y",
  "bd" => "%b %-d",
  "bdy" => "%b %-d, %Y",
}

Date::DATE_FORMATS.merge! date_formats
Time::DATE_FORMATS.merge! date_formats
DateTime::DATE_FORMATS.merge! date_formats
