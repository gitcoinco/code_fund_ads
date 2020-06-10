SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_stat_statements IS 'track execution statistics of all SQL statements executed';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


--
-- Name: EXTENSION tablefunc; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';


SET default_tablespace = '';

--
-- Name: action_mailbox_inbound_emails; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.action_mailbox_inbound_emails (
    id bigint NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    message_id character varying NOT NULL,
    message_checksum character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: action_mailbox_inbound_emails_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.action_mailbox_inbound_emails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: action_mailbox_inbound_emails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.action_mailbox_inbound_emails_id_seq OWNED BY public.action_mailbox_inbound_emails.id;


--
-- Name: action_text_rich_texts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.action_text_rich_texts (
    id bigint NOT NULL,
    name character varying NOT NULL,
    body text,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: action_text_rich_texts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.action_text_rich_texts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: action_text_rich_texts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.action_text_rich_texts_id_seq OWNED BY public.action_text_rich_texts.id;


--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    record_id bigint NOT NULL,
    record_type character varying NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    indexed_metadata jsonb DEFAULT '{}'::jsonb,
    byte_size bigint NOT NULL,
    checksum character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: audiences; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.audiences AS
 SELECT 1 AS id,
    'Blockchain'::text AS name,
    'blockchain_ecpm_cents'::text AS ecpm_column_name,
    '{Blockchain,Cryptography,Solidity}'::text[] AS keywords
UNION ALL
 SELECT 2 AS id,
    'CSS & Design'::text AS name,
    'css_and_design_ecpm_cents'::text AS ecpm_column_name,
    '{"CSS & Design"}'::text[] AS keywords
UNION ALL
 SELECT 3 AS id,
    'DevOps'::text AS name,
    'dev_ops_ecpm_cents'::text AS ecpm_column_name,
    '{DevOps,Security,Serverless}'::text[] AS keywords
UNION ALL
 SELECT 4 AS id,
    'Game Development'::text AS name,
    'game_development_ecpm_cents'::text AS ecpm_column_name,
    '{"Game Development","Virtual Reality"}'::text[] AS keywords
UNION ALL
 SELECT 5 AS id,
    'JavaScript & Frontend'::text AS name,
    'javascript_and_frontend_ecpm_cents'::text AS ecpm_column_name,
    '{Angular,Dart,Frontend,JavaScript,React,VueJS}'::text[] AS keywords
UNION ALL
 SELECT 6 AS id,
    'Miscellaneous'::text AS name,
    'miscellaneous_ecpm_cents'::text AS ecpm_column_name,
    '{C,D,"Developer Resources",Erlang,F#,Haskell,IoT,Julia,"Machine Learning",Other,Q,R,Rust,Scala}'::text[] AS keywords
UNION ALL
 SELECT 7 AS id,
    'Mobile Development'::text AS name,
    'mobile_development_ecpm_cents'::text AS ecpm_column_name,
    '{Android,"Hybrid & Mobile Web",Kotlin,Objective-C,Swift,iOS}'::text[] AS keywords
UNION ALL
 SELECT 8 AS id,
    'Web Development & Backend'::text AS name,
    'web_development_and_backend_ecpm_cents'::text AS ecpm_column_name,
    '{.NET,Backend,Database,Go,Groovy,Java,PHP,PL/SQL,Python,Ruby}'::text[] AS keywords;


--
-- Name: campaign_bundles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.campaign_bundles (
    id bigint NOT NULL,
    organization_id bigint NOT NULL,
    user_id bigint NOT NULL,
    name character varying NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    region_ids bigint[] DEFAULT '{}'::bigint[],
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: campaign_bundles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.campaign_bundles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: campaign_bundles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.campaign_bundles_id_seq OWNED BY public.campaign_bundles.id;


--
-- Name: campaigns; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.campaigns (
    id bigint NOT NULL,
    user_id bigint,
    creative_id bigint,
    status character varying NOT NULL,
    fallback boolean DEFAULT false NOT NULL,
    name character varying NOT NULL,
    url text NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    core_hours_only boolean DEFAULT false,
    weekdays_only boolean DEFAULT false,
    total_budget_cents integer DEFAULT 0 NOT NULL,
    total_budget_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    daily_budget_cents integer DEFAULT 0 NOT NULL,
    daily_budget_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    ecpm_cents integer DEFAULT 0 NOT NULL,
    ecpm_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    country_codes character varying[] DEFAULT '{}'::character varying[],
    keywords character varying[] DEFAULT '{}'::character varying[],
    negative_keywords character varying[] DEFAULT '{}'::character varying[],
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    legacy_id uuid,
    organization_id bigint,
    job_posting boolean DEFAULT false NOT NULL,
    province_codes character varying[] DEFAULT '{}'::character varying[],
    fixed_ecpm boolean DEFAULT true NOT NULL,
    assigned_property_ids bigint[] DEFAULT '{}'::bigint[] NOT NULL,
    hourly_budget_cents integer DEFAULT 0 NOT NULL,
    hourly_budget_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    prohibited_property_ids bigint[] DEFAULT '{}'::bigint[] NOT NULL,
    creative_ids bigint[] DEFAULT '{}'::bigint[] NOT NULL,
    paid_fallback boolean DEFAULT false,
    campaign_bundle_id bigint,
    audience_ids bigint[] DEFAULT '{}'::bigint[] NOT NULL,
    region_ids bigint[] DEFAULT '{}'::bigint[] NOT NULL,
    ecpm_multiplier numeric DEFAULT 1.0 NOT NULL
);


--
-- Name: campaigns_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.campaigns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: campaigns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.campaigns_id_seq OWNED BY public.campaigns.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comments (
    id bigint NOT NULL,
    commentable_id bigint,
    commentable_type character varying,
    title character varying,
    body text,
    subject character varying,
    user_id bigint NOT NULL,
    parent_id bigint,
    lft bigint,
    rgt bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: coupons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.coupons (
    id bigint NOT NULL,
    code character varying NOT NULL,
    description character varying,
    coupon_type character varying NOT NULL,
    discount_percent integer DEFAULT 0 NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    quantity integer DEFAULT 99999 NOT NULL,
    claimed integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: coupons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.coupons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: coupons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.coupons_id_seq OWNED BY public.coupons.id;


--
-- Name: creative_images; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.creative_images (
    id bigint NOT NULL,
    creative_id bigint NOT NULL,
    active_storage_attachment_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: creative_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.creative_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: creative_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.creative_images_id_seq OWNED BY public.creative_images.id;


--
-- Name: creatives; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.creatives (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    name character varying NOT NULL,
    headline character varying,
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    legacy_id uuid,
    organization_id bigint,
    cta character varying,
    status character varying DEFAULT 'pending'::character varying,
    creative_type character varying DEFAULT 'standard'::character varying NOT NULL
);


--
-- Name: creatives_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.creatives_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: creatives_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.creatives_id_seq OWNED BY public.creatives.id;


--
-- Name: daily_summaries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.daily_summaries (
    id bigint NOT NULL,
    impressionable_type character varying NOT NULL,
    impressionable_id bigint NOT NULL,
    scoped_by_type character varying,
    scoped_by_id character varying,
    impressions_count integer DEFAULT 0 NOT NULL,
    fallbacks_count integer DEFAULT 0 NOT NULL,
    fallback_percentage numeric DEFAULT 0.0 NOT NULL,
    clicks_count integer DEFAULT 0 NOT NULL,
    click_rate numeric DEFAULT 0.0 NOT NULL,
    ecpm_cents integer DEFAULT 0 NOT NULL,
    ecpm_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    cost_per_click_cents integer DEFAULT 0 NOT NULL,
    cost_per_click_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    gross_revenue_cents integer DEFAULT 0 NOT NULL,
    gross_revenue_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    property_revenue_cents integer DEFAULT 0 NOT NULL,
    property_revenue_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    house_revenue_cents integer DEFAULT 0 NOT NULL,
    house_revenue_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    displayed_at_date date NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    unique_ip_addresses_count integer DEFAULT 0 NOT NULL,
    fallback_clicks_count bigint DEFAULT 0 NOT NULL
);


--
-- Name: daily_summaries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.daily_summaries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: daily_summaries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.daily_summaries_id_seq OWNED BY public.daily_summaries.id;


--
-- Name: email_hierarchies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.email_hierarchies (
    ancestor_id bigint NOT NULL,
    descendant_id bigint NOT NULL,
    generations integer NOT NULL
);


--
-- Name: email_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.email_users (
    id bigint NOT NULL,
    email_id bigint NOT NULL,
    user_id bigint NOT NULL,
    read_at timestamp without time zone
);


--
-- Name: email_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.email_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: email_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.email_users_id_seq OWNED BY public.email_users.id;


--
-- Name: emails; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.emails (
    id bigint NOT NULL,
    body text,
    delivered_at timestamp without time zone NOT NULL,
    delivered_at_date date NOT NULL,
    recipients character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    sender character varying,
    snippet text,
    subject text,
    action_mailbox_inbound_email_id bigint NOT NULL,
    direction character varying DEFAULT 'inbound'::character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    in_reply_to character varying,
    message_id character varying,
    parent_id bigint
);


--
-- Name: emails_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.emails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: emails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.emails_id_seq OWNED BY public.emails.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events (
    id bigint NOT NULL,
    eventable_id bigint NOT NULL,
    eventable_type character varying NOT NULL,
    tags character varying[] DEFAULT '{}'::character varying[],
    body text NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;


--
-- Name: impressions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    advertiser_id bigint NOT NULL,
    publisher_id bigint NOT NULL,
    campaign_id bigint NOT NULL,
    creative_id bigint NOT NULL,
    property_id bigint NOT NULL,
    ip_address character varying NOT NULL,
    user_agent text NOT NULL,
    country_code character varying,
    postal_code character varying,
    latitude numeric,
    longitude numeric,
    displayed_at timestamp without time zone NOT NULL,
    displayed_at_date date NOT NULL,
    clicked_at timestamp without time zone,
    clicked_at_date date,
    fallback_campaign boolean DEFAULT false NOT NULL,
    estimated_gross_revenue_fractional_cents double precision,
    estimated_property_revenue_fractional_cents double precision,
    estimated_house_revenue_fractional_cents double precision,
    ad_template character varying,
    ad_theme character varying,
    organization_id bigint,
    province_code character varying,
    uplift boolean DEFAULT false
)
PARTITION BY RANGE (advertiser_id, displayed_at_date);


--
-- Name: impressions_default; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_default (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    advertiser_id bigint NOT NULL,
    publisher_id bigint NOT NULL,
    campaign_id bigint NOT NULL,
    creative_id bigint NOT NULL,
    property_id bigint NOT NULL,
    ip_address character varying NOT NULL,
    user_agent text NOT NULL,
    country_code character varying,
    postal_code character varying,
    latitude numeric,
    longitude numeric,
    displayed_at timestamp without time zone NOT NULL,
    displayed_at_date date NOT NULL,
    clicked_at timestamp without time zone,
    clicked_at_date date,
    fallback_campaign boolean DEFAULT false NOT NULL,
    estimated_gross_revenue_fractional_cents double precision,
    estimated_property_revenue_fractional_cents double precision,
    estimated_house_revenue_fractional_cents double precision,
    ad_template character varying,
    ad_theme character varying,
    organization_id bigint,
    province_code character varying,
    uplift boolean DEFAULT false
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_default DEFAULT;


--
-- Name: job_postings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.job_postings (
    id bigint NOT NULL,
    organization_id bigint,
    user_id bigint,
    campaign_id bigint,
    status character varying DEFAULT 'pending'::character varying NOT NULL,
    source character varying DEFAULT 'internal'::character varying NOT NULL,
    source_identifier character varying,
    job_type character varying NOT NULL,
    company_name character varying,
    company_url character varying,
    company_logo_url character varying,
    title character varying NOT NULL,
    description text NOT NULL,
    how_to_apply text,
    keywords character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    display_salary boolean DEFAULT true,
    min_annual_salary_cents integer DEFAULT 0 NOT NULL,
    min_annual_salary_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    max_annual_salary_cents integer DEFAULT 0 NOT NULL,
    max_annual_salary_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    remote boolean DEFAULT false NOT NULL,
    remote_country_codes character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    city character varying,
    province_name character varying,
    province_code character varying,
    country_code character varying,
    url text,
    start_date date NOT NULL,
    end_date date NOT NULL,
    full_text_search tsvector,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    company_email character varying,
    stripe_charge_id character varying,
    session_id character varying,
    auto_renew boolean DEFAULT true NOT NULL,
    list_view_count integer DEFAULT 0 NOT NULL,
    detail_view_count integer DEFAULT 0 NOT NULL,
    coupon_id bigint,
    plan character varying,
    offers character varying[] DEFAULT '{}'::character varying[] NOT NULL
);


--
-- Name: job_postings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.job_postings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: job_postings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.job_postings_id_seq OWNED BY public.job_postings.id;


--
-- Name: organization_reports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organization_reports (
    id bigint NOT NULL,
    organization_id bigint NOT NULL,
    title character varying NOT NULL,
    status character varying DEFAULT 'pending'::character varying NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    pdf_url text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    campaign_ids bigint[] DEFAULT '{}'::bigint[] NOT NULL
);


--
-- Name: organization_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.organization_reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organization_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.organization_reports_id_seq OWNED BY public.organization_reports.id;


--
-- Name: organization_transactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organization_transactions (
    id bigint NOT NULL,
    organization_id bigint NOT NULL,
    amount_cents integer DEFAULT 0 NOT NULL,
    amount_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    transaction_type character varying NOT NULL,
    posted_at timestamp without time zone NOT NULL,
    description text,
    reference text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    gift boolean DEFAULT false,
    temporary boolean DEFAULT false
);


--
-- Name: organization_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.organization_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organization_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.organization_transactions_id_seq OWNED BY public.organization_transactions.id;


--
-- Name: organization_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organization_users (
    id bigint NOT NULL,
    organization_id bigint NOT NULL,
    user_id bigint NOT NULL,
    role character varying DEFAULT 'member'::character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: organization_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.organization_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organization_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.organization_users_id_seq OWNED BY public.organization_users.id;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organizations (
    id bigint NOT NULL,
    name character varying NOT NULL,
    balance_cents integer DEFAULT 0 NOT NULL,
    balance_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    creative_approval_needed boolean DEFAULT true,
    account_manager_user_id bigint,
    url text
);


--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.organizations_id_seq OWNED BY public.organizations.id;


--
-- Name: pixel_conversions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pixel_conversions (
    id bigint NOT NULL,
    pixel_id uuid NOT NULL,
    impression_id uuid,
    impression_id_param character varying DEFAULT ''::character varying NOT NULL,
    test boolean DEFAULT false NOT NULL,
    pixel_name character varying DEFAULT ''::character varying NOT NULL,
    pixel_value_cents integer DEFAULT 0 NOT NULL,
    pixel_value_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    advertiser_id bigint,
    publisher_id bigint,
    campaign_id bigint,
    creative_id bigint,
    property_id bigint,
    ip_address character varying,
    user_agent text,
    country_code character varying,
    postal_code character varying,
    latitude numeric,
    longitude numeric,
    displayed_at timestamp without time zone,
    displayed_at_date date,
    clicked_at timestamp without time zone,
    clicked_at_date date,
    fallback_campaign boolean DEFAULT false NOT NULL,
    metadata jsonb DEFAULT '"{}"'::jsonb NOT NULL,
    conversion_referrer text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: pixel_conversions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pixel_conversions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pixel_conversions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pixel_conversions_id_seq OWNED BY public.pixel_conversions.id;


--
-- Name: pixels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pixels (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    description text,
    organization_id bigint NOT NULL,
    user_id bigint NOT NULL,
    value_cents integer DEFAULT 0 NOT NULL,
    value_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: properties; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.properties (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    property_type character varying DEFAULT 'website'::character varying NOT NULL,
    status character varying NOT NULL,
    name character varying NOT NULL,
    description text,
    url text NOT NULL,
    ad_template character varying,
    ad_theme character varying,
    language character varying NOT NULL,
    keywords character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    prohibit_fallback_campaigns boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    legacy_id uuid,
    revenue_percentage numeric DEFAULT 0.6 NOT NULL,
    assigned_fallback_campaign_ids bigint[] DEFAULT '{}'::bigint[] NOT NULL,
    restrict_to_assigner_campaigns boolean DEFAULT false NOT NULL,
    fallback_ad_template character varying,
    fallback_ad_theme character varying,
    responsive_behavior character varying DEFAULT 'none'::character varying NOT NULL,
    audience_id bigint,
    deleted_at timestamp without time zone,
    prohibited_organization_ids bigint[] DEFAULT '{}'::bigint[] NOT NULL
);


--
-- Name: properties_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.properties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: properties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.properties_id_seq OWNED BY public.properties.id;


--
-- Name: property_advertisers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.property_advertisers (
    id bigint NOT NULL,
    property_id bigint NOT NULL,
    advertiser_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: property_advertisers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.property_advertisers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: property_advertisers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.property_advertisers_id_seq OWNED BY public.property_advertisers.id;


--
-- Name: property_traffic_estimates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.property_traffic_estimates (
    id bigint NOT NULL,
    property_id bigint NOT NULL,
    site_worth_cents bigint DEFAULT 0 NOT NULL,
    site_worth_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    visitors_daily bigint DEFAULT 0,
    visitors_monthly bigint DEFAULT 0,
    visitors_yearly bigint DEFAULT 0,
    pageviews_daily bigint DEFAULT 0,
    pageviews_monthly bigint DEFAULT 0,
    pageviews_yearly bigint DEFAULT 0,
    revenue_daily_cents bigint DEFAULT 0 NOT NULL,
    revenue_daily_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    revenue_monthly_cents bigint DEFAULT 0 NOT NULL,
    revenue_monthly_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    revenue_yearly_cents bigint DEFAULT 0 NOT NULL,
    revenue_yearly_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    alexa_rank_3_months bigint DEFAULT 0,
    alexa_rank_1_month bigint DEFAULT 0,
    alexa_rank_7_days bigint DEFAULT 0,
    alexa_rank_1_day bigint DEFAULT 0,
    alexa_rank_delta_3_months bigint DEFAULT 0,
    alexa_rank_delta_1_month bigint DEFAULT 0,
    alexa_rank_delta_7_days bigint DEFAULT 0,
    alexa_rank_delta_1_day bigint DEFAULT 0,
    alexa_reach_3_months bigint DEFAULT 0,
    alexa_reach_1_month bigint DEFAULT 0,
    alexa_reach_7_days bigint DEFAULT 0,
    alexa_reach_1_day bigint DEFAULT 0,
    alexa_reach_delta_3_months bigint DEFAULT 0,
    alexa_reach_delta_1_month bigint DEFAULT 0,
    alexa_reach_delta_7_days bigint DEFAULT 0,
    alexa_reach_delta_1_day bigint DEFAULT 0,
    alexa_pageviews_3_months double precision,
    alexa_pageviews_1_month double precision,
    alexa_pageviews_7_days double precision,
    alexa_pageviews_1_day double precision,
    alexa_pageviews_delta_3_months double precision,
    alexa_pageviews_delta_1_month double precision,
    alexa_pageviews_delta_7_days double precision,
    alexa_pageviews_delta_1_day double precision,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: property_traffic_estimates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.property_traffic_estimates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: property_traffic_estimates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.property_traffic_estimates_id_seq OWNED BY public.property_traffic_estimates.id;


--
-- Name: publisher_invoices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.publisher_invoices (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    amount_cents integer DEFAULT 0 NOT NULL,
    amount_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    currency character varying NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    sent_at date,
    paid_at date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: publisher_invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.publisher_invoices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: publisher_invoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.publisher_invoices_id_seq OWNED BY public.publisher_invoices.id;


--
-- Name: regions; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.regions AS
 SELECT 1 AS id,
    'Africa'::text AS name,
    'USD'::text AS blockchain_ecpm_currency,
    75 AS blockchain_ecpm_cents,
    'USD'::text AS css_and_design_ecpm_currency,
    38 AS css_and_design_ecpm_cents,
    'USD'::text AS dev_ops_ecpm_currency,
    53 AS dev_ops_ecpm_cents,
    'USD'::text AS game_development_ecpm_currency,
    38 AS game_development_ecpm_cents,
    'USD'::text AS javascript_and_frontend_ecpm_currency,
    68 AS javascript_and_frontend_ecpm_cents,
    'USD'::text AS miscellaneous_ecpm_currency,
    23 AS miscellaneous_ecpm_cents,
    'USD'::text AS mobile_development_ecpm_currency,
    38 AS mobile_development_ecpm_cents,
    'USD'::text AS web_development_and_backend_ecpm_currency,
    45 AS web_development_and_backend_ecpm_cents,
    '{AO,BF,BI,BJ,BW,CD,CF,CG,CI,CM,CV,DJ,DZ,EG,EH,ER,ET,GA,GH,GM,GN,GQ,GW,IO,KE,KM,LR,LS,LY,MA,MG,ML,MR,MU,MW,MZ,NA,NE,NG,RE,RW,SC,SD,SH,SL,SN,SO,SS,ST,SZ,TD,TG,TN,TZ,UG,YT,ZA,ZM,ZW}'::text[] AS country_codes
UNION ALL
 SELECT 2 AS id,
    'Americas - Central and Southern'::text AS name,
    'USD'::text AS blockchain_ecpm_currency,
    150 AS blockchain_ecpm_cents,
    'USD'::text AS css_and_design_ecpm_currency,
    75 AS css_and_design_ecpm_cents,
    'USD'::text AS dev_ops_ecpm_currency,
    105 AS dev_ops_ecpm_cents,
    'USD'::text AS game_development_ecpm_currency,
    75 AS game_development_ecpm_cents,
    'USD'::text AS javascript_and_frontend_ecpm_currency,
    135 AS javascript_and_frontend_ecpm_cents,
    'USD'::text AS miscellaneous_ecpm_currency,
    45 AS miscellaneous_ecpm_cents,
    'USD'::text AS mobile_development_ecpm_currency,
    75 AS mobile_development_ecpm_cents,
    'USD'::text AS web_development_and_backend_ecpm_currency,
    90 AS web_development_and_backend_ecpm_cents,
    '{AR,BO,BR,BZ,CL,CO,CR,EC,FK,GF,GS,GT,GY,HN,MX,NI,PA,PE,PY,SR,SV,UY,VE}'::text[] AS country_codes
UNION ALL
 SELECT 3 AS id,
    'Americas - Northern'::text AS name,
    'USD'::text AS blockchain_ecpm_currency,
    750 AS blockchain_ecpm_cents,
    'USD'::text AS css_and_design_ecpm_currency,
    375 AS css_and_design_ecpm_cents,
    'USD'::text AS dev_ops_ecpm_currency,
    525 AS dev_ops_ecpm_cents,
    'USD'::text AS game_development_ecpm_currency,
    375 AS game_development_ecpm_cents,
    'USD'::text AS javascript_and_frontend_ecpm_currency,
    675 AS javascript_and_frontend_ecpm_cents,
    'USD'::text AS miscellaneous_ecpm_currency,
    225 AS miscellaneous_ecpm_cents,
    'USD'::text AS mobile_development_ecpm_currency,
    375 AS mobile_development_ecpm_cents,
    'USD'::text AS web_development_and_backend_ecpm_currency,
    450 AS web_development_and_backend_ecpm_cents,
    '{US,CA}'::text[] AS country_codes
UNION ALL
 SELECT 4 AS id,
    'Asia - Central and South-Eastern'::text AS name,
    'USD'::text AS blockchain_ecpm_currency,
    225 AS blockchain_ecpm_cents,
    'USD'::text AS css_and_design_ecpm_currency,
    113 AS css_and_design_ecpm_cents,
    'USD'::text AS dev_ops_ecpm_currency,
    158 AS dev_ops_ecpm_cents,
    'USD'::text AS game_development_ecpm_currency,
    113 AS game_development_ecpm_cents,
    'USD'::text AS javascript_and_frontend_ecpm_currency,
    203 AS javascript_and_frontend_ecpm_cents,
    'USD'::text AS miscellaneous_ecpm_currency,
    68 AS miscellaneous_ecpm_cents,
    'USD'::text AS mobile_development_ecpm_currency,
    113 AS mobile_development_ecpm_cents,
    'USD'::text AS web_development_and_backend_ecpm_currency,
    135 AS web_development_and_backend_ecpm_cents,
    '{BN,ID,KG,KH,KZ,LA,MM,MY,PH,SG,TH,TJ,TL,TM,UZ,VN}'::text[] AS country_codes
UNION ALL
 SELECT 5 AS id,
    'Asia - Eastern'::text AS name,
    'USD'::text AS blockchain_ecpm_currency,
    225 AS blockchain_ecpm_cents,
    'USD'::text AS css_and_design_ecpm_currency,
    113 AS css_and_design_ecpm_cents,
    'USD'::text AS dev_ops_ecpm_currency,
    158 AS dev_ops_ecpm_cents,
    'USD'::text AS game_development_ecpm_currency,
    113 AS game_development_ecpm_cents,
    'USD'::text AS javascript_and_frontend_ecpm_currency,
    203 AS javascript_and_frontend_ecpm_cents,
    'USD'::text AS miscellaneous_ecpm_currency,
    68 AS miscellaneous_ecpm_cents,
    'USD'::text AS mobile_development_ecpm_currency,
    113 AS mobile_development_ecpm_cents,
    'USD'::text AS web_development_and_backend_ecpm_currency,
    135 AS web_development_and_backend_ecpm_cents,
    '{CN,HK,JP,KP,KR,MN,MO,TW}'::text[] AS country_codes
UNION ALL
 SELECT 6 AS id,
    'Asia - Southern and Western'::text AS name,
    'USD'::text AS blockchain_ecpm_currency,
    225 AS blockchain_ecpm_cents,
    'USD'::text AS css_and_design_ecpm_currency,
    113 AS css_and_design_ecpm_cents,
    'USD'::text AS dev_ops_ecpm_currency,
    158 AS dev_ops_ecpm_cents,
    'USD'::text AS game_development_ecpm_currency,
    113 AS game_development_ecpm_cents,
    'USD'::text AS javascript_and_frontend_ecpm_currency,
    203 AS javascript_and_frontend_ecpm_cents,
    'USD'::text AS miscellaneous_ecpm_currency,
    68 AS miscellaneous_ecpm_cents,
    'USD'::text AS mobile_development_ecpm_currency,
    113 AS mobile_development_ecpm_cents,
    'USD'::text AS web_development_and_backend_ecpm_currency,
    135 AS web_development_and_backend_ecpm_cents,
    '{AE,AF,AM,AZ,BD,BH,BT,CY,GE,IL,IN,IQ,IR,JO,KW,LB,LK,MV,NP,OM,PK,PS,QA,SA,SY,TR,YE}'::text[] AS country_codes
UNION ALL
 SELECT 7 AS id,
    'Australia and New Zealand'::text AS name,
    'USD'::text AS blockchain_ecpm_currency,
    750 AS blockchain_ecpm_cents,
    'USD'::text AS css_and_design_ecpm_currency,
    375 AS css_and_design_ecpm_cents,
    'USD'::text AS dev_ops_ecpm_currency,
    525 AS dev_ops_ecpm_cents,
    'USD'::text AS game_development_ecpm_currency,
    375 AS game_development_ecpm_cents,
    'USD'::text AS javascript_and_frontend_ecpm_currency,
    675 AS javascript_and_frontend_ecpm_cents,
    'USD'::text AS miscellaneous_ecpm_currency,
    225 AS miscellaneous_ecpm_cents,
    'USD'::text AS mobile_development_ecpm_currency,
    375 AS mobile_development_ecpm_cents,
    'USD'::text AS web_development_and_backend_ecpm_currency,
    450 AS web_development_and_backend_ecpm_cents,
    '{AU,CC,CX,NF,NZ}'::text[] AS country_codes
UNION ALL
 SELECT 8 AS id,
    'Europe'::text AS name,
    'USD'::text AS blockchain_ecpm_currency,
    675 AS blockchain_ecpm_cents,
    'USD'::text AS css_and_design_ecpm_currency,
    338 AS css_and_design_ecpm_cents,
    'USD'::text AS dev_ops_ecpm_currency,
    473 AS dev_ops_ecpm_cents,
    'USD'::text AS game_development_ecpm_currency,
    338 AS game_development_ecpm_cents,
    'USD'::text AS javascript_and_frontend_ecpm_currency,
    608 AS javascript_and_frontend_ecpm_cents,
    'USD'::text AS miscellaneous_ecpm_currency,
    203 AS miscellaneous_ecpm_cents,
    'USD'::text AS mobile_development_ecpm_currency,
    338 AS mobile_development_ecpm_cents,
    'USD'::text AS web_development_and_backend_ecpm_currency,
    405 AS web_development_and_backend_ecpm_cents,
    '{AD,AL,AT,AX,BA,BE,CH,DE,DK,EE,ES,FI,FO,FR,GB,GG,GI,GR,HR,IE,IM,IS,IT,JE,LI,LT,LU,LV,MC,ME,MK,MT,NL,NO,PT,RS,SE,SI,SJ,SM,VA}'::text[] AS country_codes
UNION ALL
 SELECT 9 AS id,
    'Europe - Eastern'::text AS name,
    'USD'::text AS blockchain_ecpm_currency,
    450 AS blockchain_ecpm_cents,
    'USD'::text AS css_and_design_ecpm_currency,
    225 AS css_and_design_ecpm_cents,
    'USD'::text AS dev_ops_ecpm_currency,
    315 AS dev_ops_ecpm_cents,
    'USD'::text AS game_development_ecpm_currency,
    225 AS game_development_ecpm_cents,
    'USD'::text AS javascript_and_frontend_ecpm_currency,
    405 AS javascript_and_frontend_ecpm_cents,
    'USD'::text AS miscellaneous_ecpm_currency,
    135 AS miscellaneous_ecpm_cents,
    'USD'::text AS mobile_development_ecpm_currency,
    225 AS mobile_development_ecpm_cents,
    'USD'::text AS web_development_and_backend_ecpm_currency,
    270 AS web_development_and_backend_ecpm_cents,
    '{BG,BY,CZ,HU,MD,PL,RO,RU,SK,UA}'::text[] AS country_codes
UNION ALL
 SELECT 10 AS id,
    'Other'::text AS name,
    'USD'::text AS blockchain_ecpm_currency,
    75 AS blockchain_ecpm_cents,
    'USD'::text AS css_and_design_ecpm_currency,
    38 AS css_and_design_ecpm_cents,
    'USD'::text AS dev_ops_ecpm_currency,
    53 AS dev_ops_ecpm_cents,
    'USD'::text AS game_development_ecpm_currency,
    38 AS game_development_ecpm_cents,
    'USD'::text AS javascript_and_frontend_ecpm_currency,
    68 AS javascript_and_frontend_ecpm_cents,
    'USD'::text AS miscellaneous_ecpm_currency,
    23 AS miscellaneous_ecpm_cents,
    'USD'::text AS mobile_development_ecpm_currency,
    38 AS mobile_development_ecpm_cents,
    'USD'::text AS web_development_and_backend_ecpm_currency,
    45 AS web_development_and_backend_ecpm_cents,
    '{AG,AI,AS,AW,BB,BL,BM,BQ,BS,CK,CU,CW,DM,DO,FJ,FM,GD,GL,GP,GU,HT,JM,KI,KN,KY,LC,MF,MH,MP,MQ,MS,NC,NR,NU,PF,PG,PM,PN,PR,PW,SB,SX,TC,TK,TO,TT,TV,UM,VC,VG,VI,VU,WF,WS}'::text[] AS country_codes;


--
-- Name: scheduled_organization_reports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scheduled_organization_reports (
    id bigint NOT NULL,
    organization_id bigint NOT NULL,
    subject text NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    frequency character varying NOT NULL,
    dataset character varying NOT NULL,
    campaign_ids bigint[] DEFAULT '{}'::bigint[] NOT NULL,
    recipients character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: scheduled_organization_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.scheduled_organization_reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: scheduled_organization_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.scheduled_organization_reports_id_seq OWNED BY public.scheduled_organization_reports.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    roles character varying[] DEFAULT '{}'::character varying[],
    skills text[] DEFAULT '{}'::text[],
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    company_name character varying,
    address_1 character varying,
    address_2 character varying,
    city character varying,
    region character varying,
    postal_code character varying,
    country character varying,
    us_resident boolean DEFAULT false,
    api_access boolean DEFAULT false NOT NULL,
    api_key character varying,
    bio text,
    website_url character varying,
    github_username character varying,
    twitter_username character varying,
    linkedin_username character varying,
    paypal_email character varying,
    email character varying NOT NULL,
    encrypted_password character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp without time zone,
    invitation_token character varying,
    invitation_created_at timestamp without time zone,
    invitation_sent_at timestamp without time zone,
    invitation_accepted_at timestamp without time zone,
    invitation_limit integer,
    invited_by_type character varying,
    invited_by_id bigint,
    invitations_count integer DEFAULT 0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    legacy_id uuid,
    organization_id bigint,
    stripe_customer_id character varying,
    referring_user_id bigint,
    referral_code character varying,
    referral_click_count integer DEFAULT 0,
    utm_source character varying,
    utm_medium character varying,
    utm_campaign character varying,
    utm_term character varying,
    utm_content character varying,
    status character varying DEFAULT 'active'::character varying,
    record_inbound_emails boolean DEFAULT false
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.versions (
    id bigint NOT NULL,
    item_type character varying NOT NULL,
    item_id bigint NOT NULL,
    event character varying NOT NULL,
    whodunnit character varying,
    object jsonb,
    object_changes jsonb,
    created_at timestamp without time zone
);


--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.versions_id_seq OWNED BY public.versions.id;


--
-- Name: action_mailbox_inbound_emails id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.action_mailbox_inbound_emails ALTER COLUMN id SET DEFAULT nextval('public.action_mailbox_inbound_emails_id_seq'::regclass);


--
-- Name: action_text_rich_texts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.action_text_rich_texts ALTER COLUMN id SET DEFAULT nextval('public.action_text_rich_texts_id_seq'::regclass);


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: campaign_bundles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campaign_bundles ALTER COLUMN id SET DEFAULT nextval('public.campaign_bundles_id_seq'::regclass);


--
-- Name: campaigns id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campaigns ALTER COLUMN id SET DEFAULT nextval('public.campaigns_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: coupons id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupons ALTER COLUMN id SET DEFAULT nextval('public.coupons_id_seq'::regclass);


--
-- Name: creative_images id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creative_images ALTER COLUMN id SET DEFAULT nextval('public.creative_images_id_seq'::regclass);


--
-- Name: creatives id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creatives ALTER COLUMN id SET DEFAULT nextval('public.creatives_id_seq'::regclass);


--
-- Name: daily_summaries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_summaries ALTER COLUMN id SET DEFAULT nextval('public.daily_summaries_id_seq'::regclass);


--
-- Name: email_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_users ALTER COLUMN id SET DEFAULT nextval('public.email_users_id_seq'::regclass);


--
-- Name: emails id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.emails ALTER COLUMN id SET DEFAULT nextval('public.emails_id_seq'::regclass);


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- Name: job_postings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_postings ALTER COLUMN id SET DEFAULT nextval('public.job_postings_id_seq'::regclass);


--
-- Name: organization_reports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_reports ALTER COLUMN id SET DEFAULT nextval('public.organization_reports_id_seq'::regclass);


--
-- Name: organization_transactions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_transactions ALTER COLUMN id SET DEFAULT nextval('public.organization_transactions_id_seq'::regclass);


--
-- Name: organization_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_users ALTER COLUMN id SET DEFAULT nextval('public.organization_users_id_seq'::regclass);


--
-- Name: organizations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations ALTER COLUMN id SET DEFAULT nextval('public.organizations_id_seq'::regclass);


--
-- Name: pixel_conversions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pixel_conversions ALTER COLUMN id SET DEFAULT nextval('public.pixel_conversions_id_seq'::regclass);


--
-- Name: properties id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.properties ALTER COLUMN id SET DEFAULT nextval('public.properties_id_seq'::regclass);


--
-- Name: property_advertisers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.property_advertisers ALTER COLUMN id SET DEFAULT nextval('public.property_advertisers_id_seq'::regclass);


--
-- Name: property_traffic_estimates id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.property_traffic_estimates ALTER COLUMN id SET DEFAULT nextval('public.property_traffic_estimates_id_seq'::regclass);


--
-- Name: publisher_invoices id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publisher_invoices ALTER COLUMN id SET DEFAULT nextval('public.publisher_invoices_id_seq'::regclass);


--
-- Name: scheduled_organization_reports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scheduled_organization_reports ALTER COLUMN id SET DEFAULT nextval('public.scheduled_organization_reports_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.versions ALTER COLUMN id SET DEFAULT nextval('public.versions_id_seq'::regclass);


--
-- Name: action_mailbox_inbound_emails action_mailbox_inbound_emails_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.action_mailbox_inbound_emails
    ADD CONSTRAINT action_mailbox_inbound_emails_pkey PRIMARY KEY (id);


--
-- Name: action_text_rich_texts action_text_rich_texts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.action_text_rich_texts
    ADD CONSTRAINT action_text_rich_texts_pkey PRIMARY KEY (id);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: campaign_bundles campaign_bundles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campaign_bundles
    ADD CONSTRAINT campaign_bundles_pkey PRIMARY KEY (id);


--
-- Name: campaigns campaigns_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campaigns
    ADD CONSTRAINT campaigns_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: coupons coupons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupons
    ADD CONSTRAINT coupons_pkey PRIMARY KEY (id);


--
-- Name: creative_images creative_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creative_images
    ADD CONSTRAINT creative_images_pkey PRIMARY KEY (id);


--
-- Name: creatives creatives_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creatives
    ADD CONSTRAINT creatives_pkey PRIMARY KEY (id);


--
-- Name: daily_summaries daily_summaries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_summaries
    ADD CONSTRAINT daily_summaries_pkey PRIMARY KEY (id);


--
-- Name: email_users email_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_users
    ADD CONSTRAINT email_users_pkey PRIMARY KEY (id);


--
-- Name: emails emails_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.emails
    ADD CONSTRAINT emails_pkey PRIMARY KEY (id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: job_postings job_postings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_postings
    ADD CONSTRAINT job_postings_pkey PRIMARY KEY (id);


--
-- Name: organization_reports organization_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_reports
    ADD CONSTRAINT organization_reports_pkey PRIMARY KEY (id);


--
-- Name: organization_transactions organization_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_transactions
    ADD CONSTRAINT organization_transactions_pkey PRIMARY KEY (id);


--
-- Name: organization_users organization_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_users
    ADD CONSTRAINT organization_users_pkey PRIMARY KEY (id);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: pixel_conversions pixel_conversions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pixel_conversions
    ADD CONSTRAINT pixel_conversions_pkey PRIMARY KEY (id);


--
-- Name: pixels pixels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pixels
    ADD CONSTRAINT pixels_pkey PRIMARY KEY (id);


--
-- Name: properties properties_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.properties
    ADD CONSTRAINT properties_pkey PRIMARY KEY (id);


--
-- Name: property_advertisers property_advertisers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.property_advertisers
    ADD CONSTRAINT property_advertisers_pkey PRIMARY KEY (id);


--
-- Name: property_traffic_estimates property_traffic_estimates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.property_traffic_estimates
    ADD CONSTRAINT property_traffic_estimates_pkey PRIMARY KEY (id);


--
-- Name: publisher_invoices publisher_invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publisher_invoices
    ADD CONSTRAINT publisher_invoices_pkey PRIMARY KEY (id);


--
-- Name: scheduled_organization_reports scheduled_organization_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scheduled_organization_reports
    ADD CONSTRAINT scheduled_organization_reports_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: email_anc_desc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX email_anc_desc_idx ON public.email_hierarchies USING btree (ancestor_id, descendant_id, generations);


--
-- Name: email_desc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX email_desc_idx ON public.email_hierarchies USING btree (descendant_id);


--
-- Name: index_impressions_on_ad_template; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_ad_template ON ONLY public.impressions USING btree (ad_template);


--
-- Name: impressions_default_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_ad_template_idx ON public.impressions_default USING btree (ad_template);


--
-- Name: index_impressions_on_ad_theme; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_ad_theme ON ONLY public.impressions USING btree (ad_theme);


--
-- Name: impressions_default_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_ad_theme_idx ON public.impressions_default USING btree (ad_theme);


--
-- Name: index_impressions_on_advertiser_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_advertiser_id ON ONLY public.impressions USING btree (advertiser_id);


--
-- Name: impressions_default_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_advertiser_id_idx ON public.impressions_default USING btree (advertiser_id);


--
-- Name: index_impressions_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_campaign_id ON ONLY public.impressions USING btree (campaign_id);


--
-- Name: impressions_default_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_campaign_id_idx ON public.impressions_default USING btree (campaign_id);


--
-- Name: index_impressions_on_clicked_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_clicked_at_date ON ONLY public.impressions USING btree (clicked_at_date);


--
-- Name: impressions_default_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_clicked_at_date_idx ON public.impressions_default USING btree (clicked_at_date);


--
-- Name: index_impressions_on_country_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_country_code ON ONLY public.impressions USING btree (country_code);


--
-- Name: impressions_default_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_country_code_idx ON public.impressions_default USING btree (country_code);


--
-- Name: index_impressions_on_creative_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_creative_id ON ONLY public.impressions USING btree (creative_id);


--
-- Name: impressions_default_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_creative_id_idx ON public.impressions_default USING btree (creative_id);


--
-- Name: index_impressions_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_displayed_at_hour ON ONLY public.impressions USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_default_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_date_trunc_idx ON public.impressions_default USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_on_clicked_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_clicked_at_hour ON ONLY public.impressions USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_default_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_date_trunc_idx1 ON public.impressions_default USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: index_impressions_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_displayed_at_date ON ONLY public.impressions USING btree (displayed_at_date);


--
-- Name: impressions_default_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_displayed_at_date_idx ON public.impressions_default USING btree (displayed_at_date);


--
-- Name: index_impressions_on_id_and_advertiser_id_and_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_impressions_on_id_and_advertiser_id_and_displayed_at_date ON ONLY public.impressions USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_default_id_advertiser_id_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_default_id_advertiser_id_displayed_at_date_idx ON public.impressions_default USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: index_impressions_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_organization_id ON ONLY public.impressions USING btree (organization_id);


--
-- Name: impressions_default_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_organization_id_idx ON public.impressions_default USING btree (organization_id);


--
-- Name: index_impressions_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_property_id ON ONLY public.impressions USING btree (property_id);


--
-- Name: impressions_default_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_property_id_idx ON public.impressions_default USING btree (property_id);


--
-- Name: index_impressions_on_province_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_province_code ON ONLY public.impressions USING btree (province_code);


--
-- Name: impressions_default_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_province_code_idx ON public.impressions_default USING btree (province_code);


--
-- Name: index_impressions_on_uplift; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_uplift ON ONLY public.impressions USING btree (uplift);


--
-- Name: impressions_default_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_uplift_idx ON public.impressions_default USING btree (uplift);


--
-- Name: index_action_mailbox_inbound_emails_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_action_mailbox_inbound_emails_uniqueness ON public.action_mailbox_inbound_emails USING btree (message_id, message_checksum);


--
-- Name: index_action_text_rich_texts_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_action_text_rich_texts_uniqueness ON public.action_text_rich_texts USING btree (record_type, record_id, name);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_content_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_storage_blobs_on_content_type ON public.active_storage_blobs USING btree (content_type);


--
-- Name: index_active_storage_blobs_on_filename; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_storage_blobs_on_filename ON public.active_storage_blobs USING btree (filename);


--
-- Name: index_active_storage_blobs_on_indexed_metadata; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_storage_blobs_on_indexed_metadata ON public.active_storage_blobs USING gin (indexed_metadata);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_campaign_bundles_on_end_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaign_bundles_on_end_date ON public.campaign_bundles USING btree (end_date);


--
-- Name: index_campaign_bundles_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaign_bundles_on_name ON public.campaign_bundles USING btree (lower((name)::text));


--
-- Name: index_campaign_bundles_on_region_ids; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaign_bundles_on_region_ids ON public.campaign_bundles USING gin (region_ids);


--
-- Name: index_campaign_bundles_on_start_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaign_bundles_on_start_date ON public.campaign_bundles USING btree (start_date);


--
-- Name: index_campaigns_on_assigned_property_ids; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_assigned_property_ids ON public.campaigns USING gin (assigned_property_ids);


--
-- Name: index_campaigns_on_audience_ids; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_audience_ids ON public.campaigns USING gin (audience_ids);


--
-- Name: index_campaigns_on_campaign_bundle_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_campaign_bundle_id ON public.campaigns USING btree (campaign_bundle_id);


--
-- Name: index_campaigns_on_core_hours_only; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_core_hours_only ON public.campaigns USING btree (core_hours_only);


--
-- Name: index_campaigns_on_country_codes; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_country_codes ON public.campaigns USING gin (country_codes);


--
-- Name: index_campaigns_on_creative_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_creative_id ON public.campaigns USING btree (creative_id);


--
-- Name: index_campaigns_on_creative_ids; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_creative_ids ON public.campaigns USING gin (creative_ids);


--
-- Name: index_campaigns_on_end_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_end_date ON public.campaigns USING btree (end_date);


--
-- Name: index_campaigns_on_job_posting; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_job_posting ON public.campaigns USING btree (job_posting);


--
-- Name: index_campaigns_on_keywords; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_keywords ON public.campaigns USING gin (keywords);


--
-- Name: index_campaigns_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_name ON public.campaigns USING btree (lower((name)::text));


--
-- Name: index_campaigns_on_negative_keywords; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_negative_keywords ON public.campaigns USING gin (negative_keywords);


--
-- Name: index_campaigns_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_organization_id ON public.campaigns USING btree (organization_id);


--
-- Name: index_campaigns_on_paid_fallback; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_paid_fallback ON public.campaigns USING btree (paid_fallback);


--
-- Name: index_campaigns_on_prohibited_property_ids; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_prohibited_property_ids ON public.campaigns USING gin (prohibited_property_ids);


--
-- Name: index_campaigns_on_province_codes; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_province_codes ON public.campaigns USING gin (province_codes);


--
-- Name: index_campaigns_on_region_ids; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_region_ids ON public.campaigns USING gin (region_ids);


--
-- Name: index_campaigns_on_start_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_start_date ON public.campaigns USING btree (start_date);


--
-- Name: index_campaigns_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_status ON public.campaigns USING btree (status);


--
-- Name: index_campaigns_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_user_id ON public.campaigns USING btree (user_id);


--
-- Name: index_campaigns_on_weekdays_only; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_weekdays_only ON public.campaigns USING btree (weekdays_only);


--
-- Name: index_comments_on_commentable_id_and_commentable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_commentable_id_and_commentable_type ON public.comments USING btree (commentable_id, commentable_type);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_user_id ON public.comments USING btree (user_id);


--
-- Name: index_coupons_on_code; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_coupons_on_code ON public.coupons USING btree (code);


--
-- Name: index_creative_images_on_active_storage_attachment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_creative_images_on_active_storage_attachment_id ON public.creative_images USING btree (active_storage_attachment_id);


--
-- Name: index_creative_images_on_creative_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_creative_images_on_creative_id ON public.creative_images USING btree (creative_id);


--
-- Name: index_creatives_on_creative_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_creatives_on_creative_type ON public.creatives USING btree (creative_type);


--
-- Name: index_creatives_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_creatives_on_organization_id ON public.creatives USING btree (organization_id);


--
-- Name: index_creatives_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_creatives_on_user_id ON public.creatives USING btree (user_id);


--
-- Name: index_daily_summaries_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_daily_summaries_on_displayed_at_date ON public.daily_summaries USING btree (displayed_at_date);


--
-- Name: index_daily_summaries_on_impressionable_columns; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_daily_summaries_on_impressionable_columns ON public.daily_summaries USING btree (impressionable_type, impressionable_id);


--
-- Name: index_daily_summaries_on_scoped_by_columns; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_daily_summaries_on_scoped_by_columns ON public.daily_summaries USING btree (scoped_by_type, scoped_by_id);


--
-- Name: index_daily_summaries_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_daily_summaries_uniqueness ON public.daily_summaries USING btree (impressionable_type, impressionable_id, scoped_by_type, scoped_by_id, displayed_at_date);


--
-- Name: index_daily_summaries_unscoped_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_daily_summaries_unscoped_uniqueness ON public.daily_summaries USING btree (impressionable_type, impressionable_id, displayed_at_date) WHERE ((scoped_by_type IS NULL) AND (scoped_by_id IS NULL));


--
-- Name: index_email_users_on_email_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_email_users_on_email_id_and_user_id ON public.email_users USING btree (email_id, user_id);


--
-- Name: index_emails_on_delivered_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_emails_on_delivered_at_date ON public.emails USING btree (delivered_at_date);


--
-- Name: index_emails_on_delivered_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_emails_on_delivered_at_hour ON public.emails USING btree (date_trunc('hour'::text, delivered_at));


--
-- Name: index_emails_on_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_emails_on_parent_id ON public.emails USING btree (parent_id);


--
-- Name: index_emails_on_recipients; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_emails_on_recipients ON public.emails USING gin (recipients);


--
-- Name: index_emails_on_sender; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_emails_on_sender ON public.emails USING btree (sender);


--
-- Name: index_events_on_eventable_id_and_eventable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_events_on_eventable_id_and_eventable_type ON public.events USING btree (eventable_id, eventable_type);


--
-- Name: index_events_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_events_on_user_id ON public.events USING btree (user_id);


--
-- Name: index_job_postings_on_auto_renew; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_auto_renew ON public.job_postings USING btree (auto_renew);


--
-- Name: index_job_postings_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_campaign_id ON public.job_postings USING btree (campaign_id);


--
-- Name: index_job_postings_on_city; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_city ON public.job_postings USING btree (city);


--
-- Name: index_job_postings_on_company_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_company_name ON public.job_postings USING btree (company_name);


--
-- Name: index_job_postings_on_country_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_country_code ON public.job_postings USING btree (country_code);


--
-- Name: index_job_postings_on_coupon_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_coupon_id ON public.job_postings USING btree (coupon_id);


--
-- Name: index_job_postings_on_detail_view_count; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_detail_view_count ON public.job_postings USING btree (detail_view_count);


--
-- Name: index_job_postings_on_end_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_end_date ON public.job_postings USING btree (end_date);


--
-- Name: index_job_postings_on_full_text_search; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_full_text_search ON public.job_postings USING gin (full_text_search);


--
-- Name: index_job_postings_on_job_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_job_type ON public.job_postings USING btree (job_type);


--
-- Name: index_job_postings_on_keywords; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_keywords ON public.job_postings USING gin (keywords);


--
-- Name: index_job_postings_on_list_view_count; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_list_view_count ON public.job_postings USING btree (list_view_count);


--
-- Name: index_job_postings_on_max_annual_salary_cents; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_max_annual_salary_cents ON public.job_postings USING btree (max_annual_salary_cents);


--
-- Name: index_job_postings_on_min_annual_salary_cents; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_min_annual_salary_cents ON public.job_postings USING btree (min_annual_salary_cents);


--
-- Name: index_job_postings_on_offers; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_offers ON public.job_postings USING gin (offers);


--
-- Name: index_job_postings_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_organization_id ON public.job_postings USING btree (organization_id);


--
-- Name: index_job_postings_on_plan; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_plan ON public.job_postings USING btree (plan);


--
-- Name: index_job_postings_on_province_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_province_code ON public.job_postings USING btree (province_code);


--
-- Name: index_job_postings_on_province_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_province_name ON public.job_postings USING btree (province_name);


--
-- Name: index_job_postings_on_remote; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_remote ON public.job_postings USING btree (remote);


--
-- Name: index_job_postings_on_remote_country_codes; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_remote_country_codes ON public.job_postings USING gin (remote_country_codes);


--
-- Name: index_job_postings_on_session_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_session_id ON public.job_postings USING btree (session_id);


--
-- Name: index_job_postings_on_source_and_source_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_job_postings_on_source_and_source_identifier ON public.job_postings USING btree (source, source_identifier);


--
-- Name: index_job_postings_on_start_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_start_date ON public.job_postings USING btree (start_date);


--
-- Name: index_job_postings_on_title; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_title ON public.job_postings USING btree (title);


--
-- Name: index_job_postings_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_postings_on_user_id ON public.job_postings USING btree (user_id);


--
-- Name: index_organization_reports_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_organization_reports_on_organization_id ON public.organization_reports USING btree (organization_id);


--
-- Name: index_organization_transactions_on_gift; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_organization_transactions_on_gift ON public.organization_transactions USING btree (gift);


--
-- Name: index_organization_transactions_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_organization_transactions_on_organization_id ON public.organization_transactions USING btree (organization_id);


--
-- Name: index_organization_transactions_on_reference; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_organization_transactions_on_reference ON public.organization_transactions USING btree (reference);


--
-- Name: index_organization_transactions_on_transaction_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_organization_transactions_on_transaction_type ON public.organization_transactions USING btree (transaction_type);


--
-- Name: index_organization_users_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_organization_users_on_organization_id ON public.organization_users USING btree (organization_id);


--
-- Name: index_organization_users_on_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_organization_users_on_uniqueness ON public.organization_users USING btree (organization_id, user_id, role);


--
-- Name: index_organization_users_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_organization_users_on_user_id ON public.organization_users USING btree (user_id);


--
-- Name: index_organizations_on_account_manager_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_organizations_on_account_manager_user_id ON public.organizations USING btree (account_manager_user_id);


--
-- Name: index_organizations_on_creative_approval_needed; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_organizations_on_creative_approval_needed ON public.organizations USING btree (creative_approval_needed);


--
-- Name: index_pixel_conversions_on_advertiser_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pixel_conversions_on_advertiser_id ON public.pixel_conversions USING btree (advertiser_id);


--
-- Name: index_pixel_conversions_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pixel_conversions_on_campaign_id ON public.pixel_conversions USING btree (campaign_id);


--
-- Name: index_pixel_conversions_on_clicked_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pixel_conversions_on_clicked_at_date ON public.pixel_conversions USING btree (clicked_at_date);


--
-- Name: index_pixel_conversions_on_country_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pixel_conversions_on_country_code ON public.pixel_conversions USING btree (country_code);


--
-- Name: index_pixel_conversions_on_creative_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pixel_conversions_on_creative_id ON public.pixel_conversions USING btree (creative_id);


--
-- Name: index_pixel_conversions_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pixel_conversions_on_displayed_at_date ON public.pixel_conversions USING btree (displayed_at_date);


--
-- Name: index_pixel_conversions_on_impression_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pixel_conversions_on_impression_id ON public.pixel_conversions USING btree (impression_id);


--
-- Name: index_pixel_conversions_on_metadata; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pixel_conversions_on_metadata ON public.pixel_conversions USING gin (metadata);


--
-- Name: index_pixel_conversions_on_pixel_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pixel_conversions_on_pixel_id ON public.pixel_conversions USING btree (pixel_id);


--
-- Name: index_pixel_conversions_on_pixel_id_and_impression_id_param; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_pixel_conversions_on_pixel_id_and_impression_id_param ON public.pixel_conversions USING btree (pixel_id, impression_id_param);


--
-- Name: index_pixel_conversions_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pixel_conversions_on_property_id ON public.pixel_conversions USING btree (property_id);


--
-- Name: index_pixels_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pixels_on_organization_id ON public.pixels USING btree (organization_id);


--
-- Name: index_pixels_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pixels_on_user_id ON public.pixels USING btree (user_id);


--
-- Name: index_properties_on_assigned_fallback_campaign_ids; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_properties_on_assigned_fallback_campaign_ids ON public.properties USING gin (assigned_fallback_campaign_ids);


--
-- Name: index_properties_on_audience_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_properties_on_audience_id ON public.properties USING btree (audience_id);


--
-- Name: index_properties_on_keywords; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_properties_on_keywords ON public.properties USING gin (keywords);


--
-- Name: index_properties_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_properties_on_name ON public.properties USING btree (lower((name)::text));


--
-- Name: index_properties_on_prohibited_organization_ids; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_properties_on_prohibited_organization_ids ON public.properties USING gin (prohibited_organization_ids);


--
-- Name: index_properties_on_property_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_properties_on_property_type ON public.properties USING btree (property_type);


--
-- Name: index_properties_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_properties_on_status ON public.properties USING btree (status);


--
-- Name: index_properties_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_properties_on_user_id ON public.properties USING btree (user_id);


--
-- Name: index_property_advertisers_on_advertiser_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_property_advertisers_on_advertiser_id ON public.property_advertisers USING btree (advertiser_id);


--
-- Name: index_property_advertisers_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_property_advertisers_on_property_id ON public.property_advertisers USING btree (property_id);


--
-- Name: index_property_advertisers_on_property_id_and_advertiser_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_property_advertisers_on_property_id_and_advertiser_id ON public.property_advertisers USING btree (property_id, advertiser_id);


--
-- Name: index_property_traffic_estimates_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_property_traffic_estimates_on_property_id ON public.property_traffic_estimates USING btree (property_id);


--
-- Name: index_publisher_invoices_on_end_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_publisher_invoices_on_end_date ON public.publisher_invoices USING btree (end_date);


--
-- Name: index_publisher_invoices_on_paid_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_publisher_invoices_on_paid_at ON public.publisher_invoices USING btree (paid_at);


--
-- Name: index_publisher_invoices_on_start_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_publisher_invoices_on_start_date ON public.publisher_invoices USING btree (start_date);


--
-- Name: index_publisher_invoices_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_publisher_invoices_on_user_id ON public.publisher_invoices USING btree (user_id);


--
-- Name: index_scheduled_organization_reports_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_scheduled_organization_reports_on_organization_id ON public.scheduled_organization_reports USING btree (organization_id);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON public.users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (lower((email)::text));


--
-- Name: index_users_on_invitation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_invitation_token ON public.users USING btree (invitation_token);


--
-- Name: index_users_on_invitations_count; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_invitations_count ON public.users USING btree (invitations_count);


--
-- Name: index_users_on_invited_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_invited_by_id ON public.users USING btree (invited_by_id);


--
-- Name: index_users_on_invited_by_type_and_invited_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_invited_by_type_and_invited_by_id ON public.users USING btree (invited_by_type, invited_by_id);


--
-- Name: index_users_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_organization_id ON public.users USING btree (organization_id);


--
-- Name: index_users_on_referral_code; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_referral_code ON public.users USING btree (referral_code);


--
-- Name: index_users_on_referring_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_referring_user_id ON public.users USING btree (referring_user_id);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_unlock_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_unlock_token ON public.users USING btree (unlock_token);


--
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_item_type_and_item_id ON public.versions USING btree (item_type, item_id);


--
-- Name: index_versions_on_object; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_object ON public.versions USING gin (object);


--
-- Name: index_versions_on_object_changes; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_object_changes ON public.versions USING gin (object_changes);


--
-- Name: impressions_default_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_default_ad_template_idx;


--
-- Name: impressions_default_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_default_ad_theme_idx;


--
-- Name: impressions_default_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_default_advertiser_id_idx;


--
-- Name: impressions_default_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_default_campaign_id_idx;


--
-- Name: impressions_default_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_default_clicked_at_date_idx;


--
-- Name: impressions_default_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_default_country_code_idx;


--
-- Name: impressions_default_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_default_creative_id_idx;


--
-- Name: impressions_default_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_default_date_trunc_idx;


--
-- Name: impressions_default_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_default_date_trunc_idx1;


--
-- Name: impressions_default_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_default_displayed_at_date_idx;


--
-- Name: impressions_default_id_advertiser_id_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_default_id_advertiser_id_displayed_at_date_idx;


--
-- Name: impressions_default_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_default_organization_id_idx;


--
-- Name: impressions_default_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_default_property_id_idx;


--
-- Name: impressions_default_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_default_province_code_idx;


--
-- Name: impressions_default_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_default_uplift_idx;


--
-- Name: pixels fk_rails_6b2dcde3e7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pixels
    ADD CONSTRAINT fk_rails_6b2dcde3e7 FOREIGN KEY (organization_id) REFERENCES public.organizations(id);


--
-- Name: pixels fk_rails_d13d92d4dc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pixels
    ADD CONSTRAINT fk_rails_d13d92d4dc FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20181017152837'),
('20181126182831'),
('20181126220213'),
('20181126220214'),
('20181130175815'),
('20181201120915'),
('20181206210405'),
('20181208164626'),
('20181211000031'),
('20181211164312'),
('20181211201904'),
('20181212160643'),
('20181214184527'),
('20181217205840'),
('20181219171638'),
('20181220153811'),
('20181220153958'),
('20181220201430'),
('20181221205112'),
('20181222164913'),
('20190103230117'),
('20190107225451'),
('20190108190511'),
('20190108201954'),
('20190111172606'),
('20190117205738'),
('20190118223858'),
('20190119154353'),
('20190119160341'),
('20190120042919'),
('20190121220544'),
('20190123180606'),
('20190125221903'),
('20190125224425'),
('20190131172927'),
('20190204215437'),
('20190205155348'),
('20190205173702'),
('20190206211639'),
('20190208174416'),
('20190212171451'),
('20190212221227'),
('20190213224041'),
('20190308214127'),
('20190311172908'),
('20190320223450'),
('20190321180846'),
('20190322161200'),
('20190328185430'),
('20190403154313'),
('20190411165915'),
('20190513200542'),
('20190515193529'),
('20190522214219'),
('20190523203336'),
('20190529215606'),
('20190605172711'),
('20190605185105'),
('20190611183743'),
('20190612154209'),
('20190619201904'),
('20190701210845'),
('20190715195353'),
('20190821192233'),
('20190903173535'),
('20190913192015'),
('20190916195048'),
('20190924203350'),
('20191008153346'),
('20191009151545'),
('20191010203902'),
('20191010214024'),
('20191014171135'),
('20191014205953'),
('20191105141709'),
('20191105190354'),
('20191201235552'),
('20191218185622'),
('20200116165511'),
('20200116184119'),
('20200121171555'),
('20200123175239'),
('20200207162017'),
('20200213234149'),
('20200220160136'),
('20200221220825'),
('20200303224134'),
('20200325201726'),
('20200406223804'),
('20200416182239'),
('20200421152748'),
('20200422185634'),
('20200422190916'),
('20200422195410'),
('20200504175333'),
('20200504194917'),
('20200505193112'),
('20200505203735'),
('20200507164638'),
('20200511174710'),
('20200513193432'),
('20200513210427'),
('20200519191749'),
('20200521213149'),
('20200521230331'),
('20200527164824'),
('20200527175633'),
('20200528141603');


