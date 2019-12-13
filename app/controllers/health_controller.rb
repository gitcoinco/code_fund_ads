class HealthController < ApplicationController
  def index
    checklist = Easymon::Repository.all
    checklist.check

    @results = []
    checklist.results.each do |key, value|
      @results << OpenStruct.new(name: key.titleize, success: value.success, message: value.message)
    end
  end
end
