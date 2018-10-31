# frozen_string_literal: true

class PropertySearchesController < ApplicationController
  def create
    session[:property_search] = PropertySearch.new(property_search_params).to_gid_param
    redirect_to properties_path
  end

  def destroy
    session[:property_search] = PropertySearch.new.to_gid_param
    redirect_to properties_path
  end

  private

    def property_search_params
      params.require(:property_search).permit(
        :name,
        :user,
        languages: [],
        programming_languages: [],
        property_types: [],
        statuses: [],
        templates: [],
        topic_categories: [],
      )
    end
end
