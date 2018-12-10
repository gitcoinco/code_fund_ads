module Properties
  module Presentable
    extend ActiveSupport::Concern

    def scoped_name
      [user.scoped_name, name].compact.join "・"
    end

    def display_url
      url.gsub(/https?:\/\//, "")
    end

    def impressions_by_day(start_date, end_date)
      # TODO: Nate

      # sql = <<~SQL
      #   SELECT COUNT(*), displayed_at_date
      #     FROM impressions
      #   WHERE displayed_at_date >= '#{start_date.to_date.iso8601}'
      #     AND displayed_at_date <= '#{end_date.to_date.iso8601}'
      #     AND property_id = #{self.id}
      #   GROUP BY displayed_at_date
      # SQL

      # results = self.class.connection.exec_query(sql)

      [1, 2, 3]
    end
  end
end
