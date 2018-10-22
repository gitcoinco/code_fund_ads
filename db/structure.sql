SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_stat_statements IS 'track execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: assets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.assets (
    user_id uuid,
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    image_object character varying(255) NOT NULL,
    image_bucket character varying(255) NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    height integer,
    width integer
);


--
-- Name: audiences; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audiences (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    programming_languages character varying(255)[] DEFAULT '{}'::character varying[],
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    topic_categories character varying(255)[] DEFAULT '{}'::character varying[],
    fallback_campaign_id uuid
);


--
-- Name: campaigns; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.campaigns (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    redirect_url text NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    ecpm numeric(10,2) NOT NULL,
    budget_daily_amount numeric(10,2) NOT NULL,
    total_spend numeric(10,2) NOT NULL,
    user_id uuid,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    audience_id uuid,
    creative_id uuid,
    included_countries character varying(255)[] DEFAULT '{}'::character varying[],
    impression_count integer DEFAULT 0 NOT NULL,
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    us_hours_only boolean DEFAULT false,
    weekdays_only boolean DEFAULT false,
    included_programming_languages character varying(255)[] DEFAULT '{}'::character varying[],
    included_topic_categories character varying(255)[] DEFAULT '{}'::character varying[],
    excluded_programming_languages character varying(255)[] DEFAULT '{}'::character varying[],
    excluded_topic_categories character varying(255)[] DEFAULT '{}'::character varying[],
    fallback_campaign boolean DEFAULT false NOT NULL
);


--
-- Name: creatives; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.creatives (
    user_id uuid,
    id uuid NOT NULL,
    name character varying(255),
    body character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    headline character varying(255),
    small_image_asset_id uuid,
    large_image_asset_id uuid,
    wide_image_asset_id uuid
);


--
-- Name: distributions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.distributions (
    id uuid NOT NULL,
    amount numeric(10,2) NOT NULL,
    currency character varying(255) NOT NULL,
    range_start timestamp without time zone NOT NULL,
    range_end timestamp without time zone NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: impressions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions (
    id uuid NOT NULL,
    ip character varying(255) NOT NULL,
    user_agent text,
    browser character varying(255),
    os character varying(255),
    device_type character varying(255),
    country character varying(255),
    region character varying(255),
    city character varying(255),
    postal_code character varying(255),
    latitude numeric,
    longitude numeric,
    property_id uuid,
    campaign_id uuid,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    redirected_at timestamp without time zone,
    redirected_to_url character varying(255),
    revenue_amount numeric(13,12) DEFAULT 0.0 NOT NULL,
    distribution_amount numeric(13,12) DEFAULT 0.0 NOT NULL,
    distribution_id uuid,
    browser_height integer,
    browser_width integer,
    error_code integer,
    house_ad boolean DEFAULT false
);


--
-- Name: invitations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.invitations (
    id uuid NOT NULL,
    email character varying(255),
    token character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    first_name character varying(255),
    last_name character varying(255)
);


--
-- Name: properties; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.properties (
    id uuid NOT NULL,
    legacy_id character varying(255),
    name character varying(255) NOT NULL,
    url text NOT NULL,
    description text,
    property_type integer NOT NULL,
    user_id uuid,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    status integer DEFAULT 0,
    estimated_monthly_page_views integer,
    estimated_monthly_visitors integer,
    alexa_site_rank integer,
    language character varying(255) NOT NULL,
    programming_languages character varying(255)[] DEFAULT '{}'::character varying[] NOT NULL,
    topic_categories character varying(255)[] DEFAULT '{}'::character varying[] NOT NULL,
    screenshot_url text,
    slug character varying(255) NOT NULL,
    audience_id uuid,
    excluded_advertisers character varying(255)[] DEFAULT '{}'::character varying[],
    template_id uuid,
    no_api_house_ads boolean DEFAULT false NOT NULL
);


--
-- Name: rememberables; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rememberables (
    id uuid NOT NULL,
    series_hash character varying(255),
    token_hash character varying(255),
    token_created_at timestamp without time zone,
    user_id uuid,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: templates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.templates (
    id uuid NOT NULL,
    name character varying(255),
    slug character varying(255),
    description text,
    body text,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: themes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.themes (
    template_id uuid,
    id uuid NOT NULL,
    name character varying(255),
    slug character varying(255),
    description text,
    body text,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    email character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    address_1 character varying(255),
    address_2 character varying(255),
    city character varying(255),
    region character varying(255),
    postal_code character varying(255),
    country character varying(255),
    roles character varying(255)[] DEFAULT ARRAY['developer'::text],
    revenue_rate numeric(3,3) DEFAULT 0.5 NOT NULL,
    password_hash character varying(255),
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    failed_attempts integer DEFAULT 0,
    locked_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    unlock_token character varying(255),
    remember_created_at timestamp without time zone,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    paypal_email character varying(255),
    company character varying(255),
    api_access boolean DEFAULT false NOT NULL,
    api_key character varying(255)
);


--
-- Name: user_impressions; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.user_impressions AS
 SELECT campaigns.user_id AS campaign_user_id,
    impressions.id,
    impressions.campaign_id,
    impressions.revenue_amount,
    impressions.distribution_amount,
    impressions.inserted_at,
    impressions.redirected_at,
    impressions.country,
    impressions.house_ad,
    properties.name AS property_name,
    properties.user_id AS property_user_id,
    audiences.name AS audience_name,
    campaigns.name AS campaign_name,
    users.company AS advertiser_company_name
   FROM ((((public.impressions
     JOIN public.campaigns ON ((impressions.campaign_id = campaigns.id)))
     JOIN public.properties ON ((impressions.property_id = properties.id)))
     JOIN public.audiences ON ((campaigns.audience_id = audiences.id)))
     JOIN public.users ON ((campaigns.user_id = users.id)))
  WITH NO DATA;


--
-- Name: campaigns campaigns_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campaigns
    ADD CONSTRAINT campaigns_pkey PRIMARY KEY (id);


--
-- Name: budgeted_campaigns; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.budgeted_campaigns AS
 WITH data AS (
         SELECT campaigns.id AS campaign_id,
            campaigns.user_id,
            campaigns.total_spend,
            campaigns.status,
            campaigns.name AS campaign_name,
            campaigns.ecpm AS target_ecpm,
            campaigns.impression_count AS estimated_impressions,
            sum(user_impressions.revenue_amount) AS revenue_amount,
            sum(user_impressions.distribution_amount) AS distribution_amount,
            count(user_impressions.id) AS total_impressions,
            users.company AS advertiser_company_name,
            audiences.id AS audience_id,
            audiences.name AS audience_name,
            creatives.id AS creative_id,
            creatives.name AS creative_name
           FROM ((((public.campaigns
             JOIN public.user_impressions ON ((user_impressions.campaign_id = campaigns.id)))
             JOIN public.users ON ((campaigns.user_id = users.id)))
             JOIN public.audiences ON ((campaigns.audience_id = audiences.id)))
             JOIN public.creatives ON ((campaigns.creative_id = creatives.id)))
          GROUP BY campaigns.id, users.company, audiences.id, creatives.id, audiences.name, creatives.name
        )
 SELECT data.campaign_id,
    data.user_id,
    data.total_spend,
    data.status,
    data.campaign_name,
    data.target_ecpm,
    data.estimated_impressions,
    data.revenue_amount,
    data.distribution_amount,
    data.total_impressions,
    data.advertiser_company_name,
    data.audience_id,
    data.audience_name,
    data.creative_id,
    data.creative_name,
    (data.total_spend - data.revenue_amount) AS balance,
    ((data.revenue_amount / (data.total_impressions)::numeric) * (1000)::numeric) AS actual_ecpm
   FROM data
  WITH NO DATA;


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- Name: audiences audiences_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audiences
    ADD CONSTRAINT audiences_pkey PRIMARY KEY (id);


--
-- Name: creatives creatives_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creatives
    ADD CONSTRAINT creatives_pkey PRIMARY KEY (id);


--
-- Name: distributions distributions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.distributions
    ADD CONSTRAINT distributions_pkey PRIMARY KEY (id);


--
-- Name: impressions impressions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions
    ADD CONSTRAINT impressions_pkey PRIMARY KEY (id);


--
-- Name: invitations invitations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invitations
    ADD CONSTRAINT invitations_pkey PRIMARY KEY (id);


--
-- Name: properties properties_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.properties
    ADD CONSTRAINT properties_pkey PRIMARY KEY (id);


--
-- Name: rememberables rememberables_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rememberables
    ADD CONSTRAINT rememberables_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: templates templates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.templates
    ADD CONSTRAINT templates_pkey PRIMARY KEY (id);


--
-- Name: themes themes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.themes
    ADD CONSTRAINT themes_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: assets_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX assets_user_id_index ON public.assets USING btree (user_id);


--
-- Name: audiences_programming_languages_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX audiences_programming_languages_index ON public.audiences USING btree (programming_languages);


--
-- Name: budgeted_campaigns_advertiser_company_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX budgeted_campaigns_advertiser_company_name_index ON public.budgeted_campaigns USING btree (advertiser_company_name);


--
-- Name: budgeted_campaigns_audience_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX budgeted_campaigns_audience_id_index ON public.budgeted_campaigns USING btree (audience_id);


--
-- Name: budgeted_campaigns_audience_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX budgeted_campaigns_audience_name_index ON public.budgeted_campaigns USING btree (audience_name);


--
-- Name: budgeted_campaigns_campaign_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX budgeted_campaigns_campaign_id_index ON public.budgeted_campaigns USING btree (campaign_id);


--
-- Name: budgeted_campaigns_campaign_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX budgeted_campaigns_campaign_name_index ON public.budgeted_campaigns USING btree (campaign_name);


--
-- Name: budgeted_campaigns_creative_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX budgeted_campaigns_creative_id_index ON public.budgeted_campaigns USING btree (creative_id);


--
-- Name: budgeted_campaigns_creative_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX budgeted_campaigns_creative_name_index ON public.budgeted_campaigns USING btree (creative_name);


--
-- Name: budgeted_campaigns_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX budgeted_campaigns_user_id_index ON public.budgeted_campaigns USING btree (user_id);


--
-- Name: campaigns_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX campaigns_user_id_index ON public.campaigns USING btree (user_id);


--
-- Name: creatives_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX creatives_user_id_index ON public.creatives USING btree (user_id);


--
-- Name: impressions_campaign_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_campaign_id_index ON public.impressions USING btree (campaign_id);


--
-- Name: impressions_ip_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_ip_index ON public.impressions USING btree (ip);


--
-- Name: impressions_property_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_property_id_index ON public.impressions USING btree (property_id);


--
-- Name: index_impressions_on_inserted_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_inserted_at_date ON public.impressions USING btree (((inserted_at)::date));


--
-- Name: invitations_email_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX invitations_email_index ON public.invitations USING btree (email);


--
-- Name: invitations_token_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX invitations_token_index ON public.invitations USING btree (token);


--
-- Name: properties_slug_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX properties_slug_index ON public.properties USING btree (slug);


--
-- Name: properties_status_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX properties_status_index ON public.properties USING btree (status);


--
-- Name: properties_template_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX properties_template_id_index ON public.properties USING btree (template_id);


--
-- Name: properties_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX properties_user_id_index ON public.properties USING btree (user_id);


--
-- Name: rememberables_series_hash_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rememberables_series_hash_index ON public.rememberables USING btree (series_hash);


--
-- Name: rememberables_token_hash_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rememberables_token_hash_index ON public.rememberables USING btree (token_hash);


--
-- Name: rememberables_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX rememberables_user_id_index ON public.rememberables USING btree (user_id);


--
-- Name: rememberables_user_id_series_hash_token_hash_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX rememberables_user_id_series_hash_token_hash_index ON public.rememberables USING btree (user_id, series_hash, token_hash);


--
-- Name: templates_slug_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX templates_slug_index ON public.templates USING btree (slug);


--
-- Name: themes_template_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX themes_template_id_index ON public.themes USING btree (template_id);


--
-- Name: themes_template_id_slug_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX themes_template_id_slug_index ON public.themes USING btree (template_id, slug);


--
-- Name: user_impressions_advertiser_company_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_impressions_advertiser_company_name_index ON public.user_impressions USING btree (advertiser_company_name);


--
-- Name: user_impressions_audience_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_impressions_audience_name_index ON public.user_impressions USING btree (audience_name);


--
-- Name: user_impressions_campaign_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_impressions_campaign_name_index ON public.user_impressions USING btree (campaign_name);


--
-- Name: user_impressions_campaign_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_impressions_campaign_user_id_index ON public.user_impressions USING btree (campaign_user_id);


--
-- Name: user_impressions_country_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_impressions_country_index ON public.user_impressions USING btree (country);


--
-- Name: user_impressions_distribution_amount_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_impressions_distribution_amount_index ON public.user_impressions USING btree (distribution_amount);


--
-- Name: user_impressions_house_ad_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_impressions_house_ad_index ON public.user_impressions USING btree (house_ad);


--
-- Name: user_impressions_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX user_impressions_id_index ON public.user_impressions USING btree (id);


--
-- Name: user_impressions_inserted_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_impressions_inserted_at_index ON public.user_impressions USING btree (date(inserted_at));


--
-- Name: user_impressions_property_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_impressions_property_name_index ON public.user_impressions USING btree (property_name);


--
-- Name: user_impressions_property_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_impressions_property_user_id_index ON public.user_impressions USING btree (property_user_id);


--
-- Name: user_impressions_redirected_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_impressions_redirected_at_index ON public.user_impressions USING btree (date(redirected_at));


--
-- Name: user_impressions_revenue_amount_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_impressions_revenue_amount_index ON public.user_impressions USING btree (revenue_amount);


--
-- Name: users_email_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_email_index ON public.users USING btree (email);


--
-- Name: assets assets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: audiences audiences_fallback_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audiences
    ADD CONSTRAINT audiences_fallback_campaign_id_fkey FOREIGN KEY (fallback_campaign_id) REFERENCES public.campaigns(id);


--
-- Name: campaigns campaigns_audience_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campaigns
    ADD CONSTRAINT campaigns_audience_id_fkey FOREIGN KEY (audience_id) REFERENCES public.audiences(id);


--
-- Name: campaigns campaigns_creative_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campaigns
    ADD CONSTRAINT campaigns_creative_id_fkey FOREIGN KEY (creative_id) REFERENCES public.creatives(id);


--
-- Name: campaigns campaigns_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campaigns
    ADD CONSTRAINT campaigns_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: creatives creatives_large_image_asset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creatives
    ADD CONSTRAINT creatives_large_image_asset_id_fkey FOREIGN KEY (large_image_asset_id) REFERENCES public.assets(id);


--
-- Name: creatives creatives_small_image_asset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creatives
    ADD CONSTRAINT creatives_small_image_asset_id_fkey FOREIGN KEY (small_image_asset_id) REFERENCES public.assets(id);


--
-- Name: creatives creatives_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creatives
    ADD CONSTRAINT creatives_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: creatives creatives_wide_image_asset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creatives
    ADD CONSTRAINT creatives_wide_image_asset_id_fkey FOREIGN KEY (wide_image_asset_id) REFERENCES public.assets(id);


--
-- Name: impressions impressions_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions
    ADD CONSTRAINT impressions_campaign_id_fkey FOREIGN KEY (campaign_id) REFERENCES public.campaigns(id);


--
-- Name: impressions impressions_distribution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions
    ADD CONSTRAINT impressions_distribution_id_fkey FOREIGN KEY (distribution_id) REFERENCES public.distributions(id);


--
-- Name: impressions impressions_property_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions
    ADD CONSTRAINT impressions_property_id_fkey FOREIGN KEY (property_id) REFERENCES public.properties(id);


--
-- Name: properties properties_audience_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.properties
    ADD CONSTRAINT properties_audience_id_fkey FOREIGN KEY (audience_id) REFERENCES public.audiences(id);


--
-- Name: properties properties_template_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.properties
    ADD CONSTRAINT properties_template_id_fkey FOREIGN KEY (template_id) REFERENCES public.templates(id);


--
-- Name: properties properties_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.properties
    ADD CONSTRAINT properties_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: rememberables rememberables_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rememberables
    ADD CONSTRAINT rememberables_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: themes themes_template_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.themes
    ADD CONSTRAINT themes_template_id_fkey FOREIGN KEY (template_id) REFERENCES public.templates(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20181017141813'),
('20181017152837');


