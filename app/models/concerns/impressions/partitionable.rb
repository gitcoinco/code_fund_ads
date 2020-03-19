module Impressions
  module Partitionable
    extend ActiveSupport::Concern

    # a value of 1 retains the current month and the previous month as attached partitions
    MIN_MONTHS_RETAINED = 1

    module ClassMethods
      # Returns the names of all tables attached as a partition of the impressions table
      def attached_table_names
        result = connection.execute <<~SQL
          SELECT child.relname child
          FROM pg_inherits
          JOIN pg_class child ON pg_inherits.inhrelid = child.oid
          JOIN pg_class parent ON pg_inherits.inhparent = parent.oid
          WHERE parent.relname = 'impressions'
          ORDER BY child
        SQL
        result.values.flatten
      end

      # Returns the names of all tables attached as a partition of the impressions table
      # that are old enough to be detached
      def old_attached_table_names(months_retained: MIN_MONTHS_RETAINED)
        months_retained = MIN_MONTHS_RETAINED if months_retained < MIN_MONTHS_RETAINED
        attached_table_names.select do |attached_table_name|
          _, year, month, _, _ = attached_table_name.split("_")
          next unless year && month
          Date.new(year.to_i, month.to_i, 1).advance(months: months_retained) < Date.current.beginning_of_month
        end
      end

      # Returns the names of all tables detached and not acting as a partition of the impressions table
      def detached_table_names
        result = connection.execute <<~SQL
          SELECT table_name
          FROM information_schema.tables
          WHERE table_name ~ '^impressions_.*_advertiser_'
          ORDER BY table_name
        SQL
        table_names = result.values.flatten
        table_names - attached_table_names
      end

      # Attaches the list of table names as a parition of the impressions table
      def attach_tables(*detached_table_names)
        detached_table_names.each do |detached_table_name|
          _, year, month, _, advertiser_id = detached_table_name.split("_")
          displayed_at_date = Date.new(year.to_i, month.to_i)
          range_start = displayed_at_date.beginning_of_month
          range_end = range_start.end_of_month
          connection.execute <<~SQL
            ALTER TABLE impressions
            ATTACH PARTITION #{connection.quote_table_name detached_table_name}
            FOR VALUES FROM (#{advertiser_id}, '#{range_start.iso8601}') TO (#{advertiser_id}, '#{range_end.iso8601}');
          SQL
        end
      end

      # Detaches the list of table names as a parition of the impressions table
      def detach_tables(*attached_table_names)
        attached_table_names.each do |partitioned_table_name|
          connection.execute <<~SQL
            ALTER TABLE impressions DETACH PARTITION #{connection.quote_table_name partitioned_table_name};
          SQL
        end
      end

      # Detaches old partitions of the impressions table
      def detach_old_tables(months_retained: MIN_MONTHS_RETAINED)
        months_retained = MIN_MONTHS_RETAINED if months_retained < MIN_MONTHS_RETAINED
        detach_tables(*old_attached_table_names(months_retained: months_retained))
      end
    end

    included do
      before_create :assure_partition_table!

      scope :partitioned, ->(advertiser, start_date, end_date = nil) {
        advertiser_id = advertiser.is_a?(User) ? advertiser.id : advertiser
        where(advertiser_id: advertiser_id).between(start_date, end_date || start_date)
      }
    end

    def partition_table_name
      return "impressions_default" unless advertiser_id && displayed_at_date
      [
        "impressions",
        displayed_at_date.to_s("yyyy_mm"),
        "advertiser",
        advertiser_id.to_i
      ].join("_")
    end

    def partition_table_exists?
      query = Impression.sanitize_sql_array(["SELECT to_regclass(?)", partition_table_name])
      result = Impression.connection.execute(query)
      !!result.first["to_regclass"]
    end

    def assure_partition_table!
      Impression.transaction do
        unless partition_table_exists?
          range_start = displayed_at_date.beginning_of_month
          range_end = range_start.advance(months: 1)
          Impression.connection.execute <<~QUERY
            CREATE TABLE public.#{partition_table_name} PARTITION OF public.impressions
            FOR VALUES FROM (#{advertiser_id}, '#{range_start.iso8601}') TO (#{advertiser_id}, '#{range_end.iso8601}');
          QUERY
        end
      end
    end
  end
end
