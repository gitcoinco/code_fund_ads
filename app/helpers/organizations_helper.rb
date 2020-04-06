module OrganizationsHelper
  def missing_image_formats
    @missing_image_formats ||= begin
      if Current.organization.images.exists?
        CreativeImage::STANDARD_FORMATS.select { |f| f unless Current.organization.send("#{f}_images?") }.to_sentence
      else
        CreativeImage::STANDARD_FORMATS.to_sentence
      end
    end
  end

  def missing_image_formats?
    !missing_image_formats&.empty?
  end

  def missing_active_creatives?
    !Current.organization.creatives.active.any?
  end

  def missing_campaign_resources_alert
    return missing_creatives_and_images_alert if missing_active_creatives? && missing_image_formats?
    return missing_image_formats_alert if missing_image_formats?
    return missing_creatives_alert if missing_active_creatives?
    false
  end

  def missing_creatives_and_images_alert
    {
      heading: I18n.t("organizations.alert.missing_creatives_and_images.heading"),
      body: I18n.t("organizations.alert.missing_creatives_and_images.body", missing_image_formats: missing_image_formats),
      cta: link_to("Upload Images", new_image_path(Current.organization.to_gid_param), class: "btn btn-danger text-nowrap")
    }
  end

  def missing_image_formats_alert
    {
      heading: I18n.t("organizations.alert.missing_images.heading"),
      body: I18n.t("organizations.alert.missing_images.body", missing_image_formats: missing_image_formats),
      cta: link_to("Upload Images", new_image_path(Current.organization.to_gid_param), class: "btn btn-danger text-nowrap")
    }
  end

  def missing_creatives_alert
    {
      heading: I18n.t("organizations.alert.missing_creatives.heading"),
      body: I18n.t("organizations.alert.missing_creatives.body", missing_image_formats: missing_image_formats),
      cta: link_to("Create Creative", new_creative_path, class: "btn btn-danger text-nowrap")
    }
  end
end
