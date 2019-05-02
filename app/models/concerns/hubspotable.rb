module Hubspotable
  extend ActiveSupport::Concern

  ADVERTISER_DEAL_PIPELINE_STAGE_LABELS = [
    "Interested",
    "Invited to Discuss",
    "Appointment Scheduled",
    "Presentation Made",
    "Decision Maker Bought-In",
    "Contract Sent",
    "Payment Received",
    "Campaign Created",
    "Campaign Launched",
    "Closed Lost",
    "Closed Not Qualified",
  ].freeze

  PUBLISHER_DEAL_PIPELINE_STAGE_LABELS = [
    "Interested",
    "Invited",
    "Accepted",
    "Integrated",
    "Activated",
    "Paid",
    "Lost",
    "Not Qualified",
  ].freeze

  module ClassMethods
    def hubspot_advertiser_deal_pipeline
      @hubspot_advertiser_deal_pipeline ||= Hubspot::DealPipeline.find(ENV["HUBSPOT_ADVERTISER_DEAL_PIPELINE"])
    end

    def hubspot_advertiser_deal_pipeline_stage(label)
      hubspot_advertiser_deal_pipeline.stages.find { |stage| label == stage["label"] }
    end

    def hubspot_publisher_deal_pipeline
      @hubspot_publisher_deal_pipeline ||= Hubspot::DealPipeline.find(ENV["HUBSPOT_PUBLISHER_DEAL_PIPELINE"])
    end

    def hubspot_publisher_deal_pipeline_stage(label)
      hubspot_publisher_deal_pipeline.stages.find { |stage| label == stage["label"] }
    end
  end

  delegate :hubspot_advertiser_deal_pipeline, to: "self.class"
  delegate :hubspot_publisher_deal_pipeline, to: "self.class"

  included do
    after_update_commit :update_hubspot_deal_stage
  end

  def hubspot_company_vid?
    hubspot_company_vid.present?
  end

  def hubspot_contact_vid?
    hubspot_contact_vid.present?
  end

  def hubspot_deal_vid?
    hubspot_deal_vid.present?
  end

  def hubspot_company
    @hubspot_company ||= Hubspot::Company.find_by_id(hubspot_company_vid) if hubspot_company_vid?
  end

  def hubspot_contact
    @hubspot_contact ||= Hubspot::Contact.find_by_id(hubspot_contact_vid) if hubspot_contact_vid?
  end

  def hubspot_deals
    @hubspot_deals ||= hubspot_contact ? Hubspot::Deal.find_by_contact(hubspot_contact) : []
  end

  def hubspot_advertiser_deals
    hubspot_deals.select { |deal| deal["pipeline"] == ENV["HUBSPOT_ADVERTISER_DEAL_PIPELINE"] }
  end

  def hubspot_advertiser_deal
    hubspot_advertiser_deals.first
  end

  def hubspot_advertiser_deal_stage
    return nil unless hubspot_advertiser_deal
    hubspot_advertiser_deal_pipeline.stages.find { |stage| hubspot_advertiser_deal["dealstage"] == stage["stageId"] }
  end

  def hubspot_publisher_deals
    hubspot_deals.select { |deal| deal["pipeline"] == ENV["HUBSPOT_PUBLISHER_DEAL_PIPELINE"] }
  end

  def hubspot_publisher_deal
    hubspot_publisher_deals.first
  end

  def hubspot_publisher_deal_stage
    return nil unless hubspot_publisher_deal
    hubspot_publisher_deal_pipeline.stages.find { |stage| hubspot_publisher_deal["dealstage"] == stage["stageId"] }
  end

  private

  def invitation_accepted_on_preceding_save?
    invitation_accepted_at_previously_changed? &&
      invitation_accepted_at_previous_change.first.nil? &&
      invitation_accepted_at_previous_change.last.present?
  end

  def update_hubspot_deal_stage
    if publisher? && invitation_accepted_on_preceding_save?
      UpdateHubspotPublisherDealStageFromInvitedToAcceptedJob.perform_later self
    end
  end
end
