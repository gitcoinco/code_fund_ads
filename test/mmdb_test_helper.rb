require "mmdb"

def us_maxminddb_result
  MaxMindDB::Result.new(
    {"city" => {"geoname_id" => 5392171, "names" => {"de" => "San José", "en" => "San Jose", "es" => "San José", "fr" => "San José", "ja" => "サンノゼ", "pt-BR" => "San José", "ru" => "Сан-Хосе"}},
     "continent" => {"code" => "NA", "geoname_id" => 6255149, "names" => {"de" => "Nordamerika", "en" => "North America", "es" => "Norteamérica", "fr" => "Amérique du Nord", "ja" => "北アメリカ", "pt-BR" => "América do Norte", "ru" => "Северная Америка", "zh-CN" => "北美洲"}},
     "country" => {"geoname_id" => 6252001, "iso_code" => "US", "names" => {"de" => "USA", "en" => "United States", "es" => "Estados Unidos", "fr" => "États-Unis", "ja" => "アメリカ合衆国", "pt-BR" => "Estados Unidos", "ru" => "США", "zh-CN" => "美国"}},
     "location" => {"accuracy_radius" => 1000, "latitude" => 37.3388, "longitude" => -121.8914, "metro_code" => 807, "time_zone" => "America/Los_Angeles"},
     "postal" => {"code" => "95141"},
     "registered_country" => {"geoname_id" => 6252001, "iso_code" => "US", "names" => {"de" => "USA", "en" => "United States", "es" => "Estados Unidos", "fr" => "États-Unis", "ja" => "アメリカ合衆国", "pt-BR" => "Estados Unidos", "ru" => "США", "zh-CN" => "美国"}},
     "subdivisions" => [{"geoname_id" => 5332921, "iso_code" => "CA", "names" => {"de" => "Kalifornien", "en" => "California", "es" => "California", "fr" => "Californie", "ja" => "カリフォルニア州", "pt-BR" => "Califórnia", "ru" => "Калифорния", "zh-CN" => "加利福尼亚州"}}],
     "network" => "54.183.128.0/18"}
  )
end

def Mmdb.lookup(ip_address)
  return us_maxminddb_result if ip_address == "192.168.0.100" && Rails.env.test?
  return MaxMindDB::Result.new({}) unless mmdb
  mmdb.lookup ip_address
end
