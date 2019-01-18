if Rails.env.development?
  namespace :code_fund do
    namespace :provinces do
      desc <<~DESC
        Builds the file at: db/provinces.json
        Uses open data from The United Nations Economic Commission for Europe http://www.unece.org
      DESC
      task build: :environment do
        rows = []
        Mechanize.new.get("http://www.unece.org/cefact/locode/subdivisions.html") do |page|
          page.links_with(href: /fileadmin/).each do |link|
            rows.concat build_province_data(link.text, link.href)
          end
        end

        File.open Rails.root.join("db/provinces.json"), "w" do |f|
          f.write JSON.pretty_generate(rows)
        end
      end

      private

      def build_province_data(country_name, url)
        @count ||= 0
        rows = []
        Mechanize.new.get("http://www.unece.org" + url) do |page|
          page.search("table").each do |table|
            @ok = false
            table.search("tr").each.with_index do |tr, index|
              @ok ||= begin
                content = tr.search("td").map(&:text).join
                index.zero? && content.include?("Country") && content.include?("Subdivision") && content.include?("Name") && content.include?("Level")
              end
              next unless @ok
              next if index.zero?
              print ", #{@count += 1}"
              tds = tr.search("td")
              rows << {
                country_name: country_name.delete(" ").strip,
                country_code: (begin
                                 tds[0].text
                               rescue
                                 ""
                               end).delete(" ").strip,
                province_name: (begin
                                  tds[2].text
                                rescue
                                  ""
                                end).delete(" ").sub(/(\[|\().*(\]|\))/, "").strip,
                subdivision: (begin
                                tds[1].text
                              rescue
                                ""
                              end).delete(" ").strip,
              }
            end
          end
        end
        rows
      end
    end
  end
end
