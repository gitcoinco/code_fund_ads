class HubspotPublishersController < ApplicationController
  skip_before_action :verify_authenticity_token
  # before_action :authenticate_hubspot_request!

  # SEE: https://developers.hubspot.com/docs/methods/workflows/webhook_information
  # Example Request data:
  # {
  #   "vid": 71,
  #   "canonical-vid": 71,
  #   "portal-id": 62515,
  #   "profile-token": "AO_T-mMZs-n9xi4QD7dSSPBnLcWSFuLlza0RH7r5EI12UMul8pXi1bhuR71bsusug6f31W9KKfOntz1jUCfrS2QE18gCk_74Dkip4GUsgxKyk7A0uNGtrCYmRm4ZhR0ThUONh2PglE8R",
  #   "profile-url": "https://app.hubspot.com/contacts/62515/lists/public/contact/_AO_T-mMZs-n9xi4QD7dSSPBnLcWSFuLlza0RH7r5EI12UMul8pXi1bhuR71bsusug6f31W9KKfOntz1jUCfrS2QE18gCk_74Dkip4GUsgxKyk7A0uNGtrCYmRm4ZhR0ThUONh2PglE8R/",
  #   "properties": {
  #     "hs_social_linkedin_clicks": {
  #       "value": "0",
  #       "versions": [
  #         {
  #           "value": "0",
  #           "source-type": "ANALYTICS",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1345568681004,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "first_conversion_event_name": {
  #       "value": "testform: testform",
  #       "versions": [
  #         {
  #           "value": "testform: testform",
  #           "source-type": "CALCULATED",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 0,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "hs_social_num_broadcast_clicks": {
  #       "value": "0",
  #       "versions": [
  #         {
  #           "value": "0",
  #           "source-type": "ANALYTICS",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1348921921004,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "hs_social_facebook_clicks": {
  #       "value": "0",
  #       "versions": [
  #         {
  #           "value": "0",
  #           "source-type": "ANALYTICS",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1345568681004,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "createdate": {
  #       "value": "1325634178632",
  #       "versions": [
  #         {
  #           "value": "1325634178632",
  #           "source-type": "MIGRATION",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1325634621005,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "hs_analytics_revenue": {
  #       "value": "0.0",
  #       "versions": [
  #         {
  #           "value": "0.0",
  #           "source-type": "ANALYTICS",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1364105130004,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "lastname": {
  #       "value": "perf_user_970",
  #       "versions": [
  #         {
  #           "value": "perf_user_970",
  #           "source-type": "MIGRATION",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1325634621005,
  #           "selected": false
  #         },
  #         {
  #           "value": "perf_user_970",
  #           "source-type": "FORM",
  #           "source-id": "2e137f47a86e48798322d47f6f529a93",
  #           "source-label": "LastName",
  #           "timestamp": 1325633423003,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "hs_analytics_first_url": {
  #       "value": "",
  #       "versions": [
  #         {
  #           "value": "",
  #           "source-type": "ANALYTICS",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1345568681004,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "ipaddress": {
  #       "value": "unknown",
  #       "versions": [
  #         {
  #           "value": "unknown",
  #           "source-type": "MIGRATION",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1325634621005,
  #           "selected": false
  #         },
  #         {
  #           "value": "unknown",
  #           "source-type": "FORM",
  #           "source-id": "2e137f47a86e48798322d47f6f529a93",
  #           "source-label": "IPAddress",
  #           "timestamp": 1325633423003,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "lastmodifieddate": {
  #       "value": "1366074891080",
  #       "versions": [
  #         {
  #           "value": "1366074891080",
  #           "source-type": "CALCULATED",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1366074891013,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "hs_analytics_num_event_completions": {
  #       "value": "0",
  #       "versions": [
  #         {
  #           "value": "0",
  #           "source-type": "ANALYTICS",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1348921921004,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "hs_analytics_first_referrer": {
  #       "value": "",
  #       "versions": [
  #         {
  #           "value": "",
  #           "source-type": "ANALYTICS",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1345568681004,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "hs_analytics_source": {
  #       "value": "DIRECT_TRAFFIC",
  #       "versions": [
  #         {
  #           "value": "DIRECT_TRAFFIC",
  #           "source-type": "ANALYTICS",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1354416847004,
  #           "selected": false
  #         },
  #         {
  #           "value": "OFFLINE",
  #           "source-type": "ANALYTICS",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1345568681004,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "hs_social_google_plus_clicks": {
  #       "value": "0",
  #       "versions": [
  #         {
  #           "value": "0",
  #           "source-type": "ANALYTICS",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1348921921004,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "hs_analytics_num_page_views": {
  #       "value": "0",
  #       "versions": [
  #         {
  #           "value": "0",
  #           "source-type": "ANALYTICS",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1345568681004,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "hs_analytics_last_timestamp": {
  #       "value": "0",
  #       "versions": [
  #         {
  #           "value": "0",
  #           "source-type": "ANALYTICS",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1364105130004,
  #           "selected": false
  #         },
  #         {
  #           "value": "1325633423000",
  #           "source-type": "ANALYTICS",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1348921921004,
  #           "selected": false
  #         },
  #         {
  #           "value": "1325634178632",
  #           "source-type": "ANALYTICS",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1345568681004,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "hs_analytics_first_timestamp": {
  #       "value": "1325633423000",
  #       "versions": [
  #         {
  #           "value": "1325633423000",
  #           "source-type": "ANALYTICS",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1345568681004,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "num_conversion_events": {
  #       "value": "1",
  #       "versions": [
  #         {
  #           "value": "1",
  #           "source-type": "CALCULATED",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 0,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "hs_analytics_source_data_2": {
  #       "value": "",
  #       "versions": [
  #         {
  #           "value": "",
  #           "source-type": "ANALYTICS",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1345568681004,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "hs_analytics_source_data_1": {
  #       "value": "",
  #       "versions": [
  #         {
  #           "value": "",
  #           "source-type": "ANALYTICS",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1345568681004,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "hs_analytics_last_visit_timestamp": {
  #       "value": "1325633423000",
  #       "versions": [
  #         {
  #           "value": "1325633423000",
  #           "source-type": "ANALYTICS",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1348921921004,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "hs_analytics_num_visits": {
  #       "value": "0",
  #       "versions": [
  #         {
  #           "value": "0",
  #           "source-type": "ANALYTICS",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1345568681004,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "hs_analytics_last_referrer": {
  #       "value": "",
  #       "versions": [
  #         {
  #           "value": "",
  #           "source-type": "ANALYTICS",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1345568681004,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "hs_analytics_last_url": {
  #       "value": "",
  #       "versions": [
  #         {
  #           "value": "",
  #           "source-type": "ANALYTICS",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1345568681004,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "recent_conversion_event_name": {
  #       "value": "testform: testform",
  #       "versions": [
  #         {
  #           "value": "testform: testform",
  #           "source-type": "CALCULATED",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 0,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "first_conversion_date": {
  #       "value": "1325633423000",
  #       "versions": [
  #         {
  #           "value": "1325633423000",
  #           "source-type": "CALCULATED",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 0,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "hs_social_twitter_clicks": {
  #       "value": "0",
  #       "versions": [
  #         {
  #           "value": "0",
  #           "source-type": "ANALYTICS",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1345568681004,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "firstname": {
  #       "value": "perf_user_970",
  #       "versions": [
  #         {
  #           "value": "perf_user_970",
  #           "source-type": "MIGRATION",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1325634621005,
  #           "selected": false
  #         },
  #         {
  #           "value": "perf_user_970",
  #           "source-type": "FORM",
  #           "source-id": "2e137f47a86e48798322d47f6f529a93",
  #           "source-label": "FirstName",
  #           "timestamp": 1325633423003,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "hs_analytics_average_page_views": {
  #       "value": "0",
  #       "versions": [
  #         {
  #           "value": "0",
  #           "source-type": "ANALYTICS",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1364912952004,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "recent_conversion_date": {
  #       "value": "1325633423000",
  #       "versions": [
  #         {
  #           "value": "1325633423000",
  #           "source-type": "CALCULATED",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 0,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "lifecyclestage": {
  #       "value": "lead",
  #       "versions": [
  #         {
  #           "value": "lead",
  #           "source-type": "MIGRATION",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1325634621005,
  #           "selected": false
  #         }
  #       ]
  #     },
  #     "email": {
  #       "value": "perf_user_970@test.com",
  #       "versions": [
  #         {
  #           "value": "perf_user_970@test.com",
  #           "source-type": "MIGRATION",
  #           "source-id": null,
  #           "source-label": null,
  #           "timestamp": 1325634621005,
  #           "selected": false
  #         }
  #       ]
  #     }
  #   },
  #   "form-submissions": [
  #     {
  #       "conversion-id": "2e137f47a86e48798322d47f6f529a93",
  #       "timestamp": 1325633423000,
  #       "form-id": "762987228e694ef19530f58da2db5f63",
  #       "portal-id": 62515,
  #       "page-title": "testform",
  #       "title": "testform"
  #     }
  #   ],
  #   "list-memberships": [
  #
  #   ],
  #   "identity-profiles": [
  #     {
  #       "vid": 71,
  #       "identities": [
  #         {
  #           "type": "LEAD_GUID",
  #           "value": "8a706adf34a5ee0d0134a5f44e4a01c8",
  #           "timestamp": 1325634178632
  #         },
  #         {
  #           "type": "EMAIL",
  #           "value": "perf_user_970@test.com",
  #           "timestamp": 1325634178632
  #         }
  #       ]
  #     }
  #   ]
  # }
  def create
    hubspot_contact_vid = params[:vid]
    return head(:bad_request) unless hubspot_contact_vid
    CreatePublisherFromHubspotContactJob.perform_later hubspot_contact_vid
    head :accepted
  end

  private

  # SEE: https://developers.hubspot.com/docs/methods/crm-extensions/crm-extensions-overview#request-signatures
  def authenticate_hubspot_request!
    hash = Digest::SHA256.digest("#{ENV["HUBSPOT_CLIENT_SECRET"]}#{request.method}#{request.original_url}#{request.body}")
    head :unauthorized unless request.headers["HTTP_X_HUBSPOT_SIGNATURE"] == hash
  end
end
