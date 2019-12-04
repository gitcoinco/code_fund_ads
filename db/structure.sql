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


SET default_tablespace = '';

SET default_with_oids = false;

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
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: audiences; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.audiences AS
 SELECT 1 AS id,
    'Blockchain'::text AS name,
    'blockchain_ecpm_cents'::text AS ecpm_column_name,
    '{Blockchain,Cryptography}'::text[] AS keywords
UNION ALL
 SELECT 2 AS id,
    'CSS & Design'::text AS name,
    'css_and_design_ecpm_cents'::text AS ecpm_column_name,
    '{"CSS & Design"}'::text[] AS keywords
UNION ALL
 SELECT 3 AS id,
    'DevOps'::text AS name,
    'dev_ops_ecpm_cents'::text AS ecpm_column_name,
    '{DevOps,Python,Ruby,Security,Serverless}'::text[] AS keywords
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
    '{C,D,"Developer Resources",Erlang,F#,Haskell,IoT,Julia,"Machine Learning",Other,Python,Q,R,Rust,Scala}'::text[] AS keywords
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
    start_date date,
    end_date date,
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
    paid_fallback boolean DEFAULT false
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
    commentable_id bigint NOT NULL,
    commentable_type character varying NOT NULL,
    title character varying,
    body text,
    subject character varying,
    user_id bigint NOT NULL,
    parent_id bigint,
    lft integer,
    rgt integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
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
    fallback_percentage numeric DEFAULT 0 NOT NULL,
    clicks_count integer DEFAULT 0 NOT NULL,
    click_rate numeric DEFAULT 0 NOT NULL,
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
    unique_ip_addresses_count integer DEFAULT 0 NOT NULL
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
    uplift boolean DEFAULT false,
    province_code character varying
)
PARTITION BY RANGE (advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_10_advertiser_365; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_10_advertiser_365 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_10_advertiser_365 FOR VALUES FROM ('365', '2019-10-01') TO ('365', '2019-11-01');


--
-- Name: impressions_2019_10_advertiser_457; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_10_advertiser_457 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_10_advertiser_457 FOR VALUES FROM ('457', '2019-10-01') TO ('457', '2019-11-01');


--
-- Name: impressions_2019_10_advertiser_572; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_10_advertiser_572 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_10_advertiser_572 FOR VALUES FROM ('572', '2019-10-01') TO ('572', '2019-11-01');


--
-- Name: impressions_2019_10_advertiser_615; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_10_advertiser_615 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_10_advertiser_615 FOR VALUES FROM ('615', '2019-10-01') TO ('615', '2019-11-01');


--
-- Name: impressions_2019_10_advertiser_646; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_10_advertiser_646 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_10_advertiser_646 FOR VALUES FROM ('646', '2019-10-01') TO ('646', '2019-11-01');


--
-- Name: impressions_2019_10_advertiser_659; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_10_advertiser_659 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_10_advertiser_659 FOR VALUES FROM ('659', '2019-10-01') TO ('659', '2019-11-01');


--
-- Name: impressions_2019_10_advertiser_710; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_10_advertiser_710 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_10_advertiser_710 FOR VALUES FROM ('710', '2019-10-01') TO ('710', '2019-11-01');


--
-- Name: impressions_2019_11_advertiser_123; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_123 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_123 FOR VALUES FROM ('123', '2019-11-01') TO ('123', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_146; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_146 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_146 FOR VALUES FROM ('146', '2019-11-01') TO ('146', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_185; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_185 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_185 FOR VALUES FROM ('185', '2019-11-01') TO ('185', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_239; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_239 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_239 FOR VALUES FROM ('239', '2019-11-01') TO ('239', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_272; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_272 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_272 FOR VALUES FROM ('272', '2019-11-01') TO ('272', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_305; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_305 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_305 FOR VALUES FROM ('305', '2019-11-01') TO ('305', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_365; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_365 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_365 FOR VALUES FROM ('365', '2019-11-01') TO ('365', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_457; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_457 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_457 FOR VALUES FROM ('457', '2019-11-01') TO ('457', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_572; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_572 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_572 FOR VALUES FROM ('572', '2019-11-01') TO ('572', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_576; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_576 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_576 FOR VALUES FROM ('576', '2019-11-01') TO ('576', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_613; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_613 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_613 FOR VALUES FROM ('613', '2019-11-01') TO ('613', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_615; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_615 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_615 FOR VALUES FROM ('615', '2019-11-01') TO ('615', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_619; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_619 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_619 FOR VALUES FROM ('619', '2019-11-01') TO ('619', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_624; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_624 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_624 FOR VALUES FROM ('624', '2019-11-01') TO ('624', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_632; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_632 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_632 FOR VALUES FROM ('632', '2019-11-01') TO ('632', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_646; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_646 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_646 FOR VALUES FROM ('646', '2019-11-01') TO ('646', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_651; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_651 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_651 FOR VALUES FROM ('651', '2019-11-01') TO ('651', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_659; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_659 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_659 FOR VALUES FROM ('659', '2019-11-01') TO ('659', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_660; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_660 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_660 FOR VALUES FROM ('660', '2019-11-01') TO ('660', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_697; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_697 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_697 FOR VALUES FROM ('697', '2019-11-01') TO ('697', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_700; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_700 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_700 FOR VALUES FROM ('700', '2019-11-01') TO ('700', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_707; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_707 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_707 FOR VALUES FROM ('707', '2019-11-01') TO ('707', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_710; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_710 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_710 FOR VALUES FROM ('710', '2019-11-01') TO ('710', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_711; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_711 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_711 FOR VALUES FROM ('711', '2019-11-01') TO ('711', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_712; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_712 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_712 FOR VALUES FROM ('712', '2019-11-01') TO ('712', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_714; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_714 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_714 FOR VALUES FROM ('714', '2019-11-01') TO ('714', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_723; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_723 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_723 FOR VALUES FROM ('723', '2019-11-01') TO ('723', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_727; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_727 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_727 FOR VALUES FROM ('727', '2019-11-01') TO ('727', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_735; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_735 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_735 FOR VALUES FROM ('735', '2019-11-01') TO ('735', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_769; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_769 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_769 FOR VALUES FROM ('769', '2019-11-01') TO ('769', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_779; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_779 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_779 FOR VALUES FROM ('779', '2019-11-01') TO ('779', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_788; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_788 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_788 FOR VALUES FROM ('788', '2019-11-01') TO ('788', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_789; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_789 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_789 FOR VALUES FROM ('789', '2019-11-01') TO ('789', '2019-12-01');


--
-- Name: impressions_2019_11_advertiser_850; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11_advertiser_850 (
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
    uplift boolean DEFAULT false,
    province_code character varying
);
ALTER TABLE ONLY public.impressions ATTACH PARTITION public.impressions_2019_11_advertiser_850 FOR VALUES FROM ('850', '2019-11-01') TO ('850', '2019-12-01');


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
    gift boolean DEFAULT false
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
-- Name: organizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organizations (
    id bigint NOT NULL,
    name character varying NOT NULL,
    balance_cents integer DEFAULT 0 NOT NULL,
    balance_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
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
-- Name: properties; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.properties (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    property_type character varying NOT NULL,
    status character varying NOT NULL,
    name character varying NOT NULL,
    description text,
    url text NOT NULL,
    ad_template character varying,
    ad_theme character varying,
    language character varying NOT NULL,
    keywords character varying[] DEFAULT '{}'::character varying[] NOT NULL,
    prohibited_advertiser_ids bigint[] DEFAULT '{}'::bigint[] NOT NULL,
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
    deleted_at timestamp without time zone
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
    amount money NOT NULL,
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
    'United States and Candada'::text AS name,
    'USD'::text AS blockchain_ecpm_currency,
    1000 AS blockchain_ecpm_cents,
    'USD'::text AS css_and_design_ecpm_currency,
    450 AS css_and_design_ecpm_cents,
    'USD'::text AS dev_ops_ecpm_currency,
    650 AS dev_ops_ecpm_cents,
    'USD'::text AS game_development_ecpm_currency,
    425 AS game_development_ecpm_cents,
    'USD'::text AS javascript_and_frontend_ecpm_currency,
    625 AS javascript_and_frontend_ecpm_cents,
    'USD'::text AS miscellaneous_ecpm_currency,
    425 AS miscellaneous_ecpm_cents,
    'USD'::text AS mobile_development_ecpm_currency,
    450 AS mobile_development_ecpm_cents,
    'USD'::text AS web_development_and_backend_ecpm_currency,
    500 AS web_development_and_backend_ecpm_cents,
    '{US,CA}'::text[] AS country_codes
UNION ALL
 SELECT 2 AS id,
    'Europe, Australia and New Zealand'::text AS name,
    'USD'::text AS blockchain_ecpm_currency,
    900 AS blockchain_ecpm_cents,
    'USD'::text AS css_and_design_ecpm_currency,
    350 AS css_and_design_ecpm_cents,
    'USD'::text AS dev_ops_ecpm_currency,
    550 AS dev_ops_ecpm_cents,
    'USD'::text AS game_development_ecpm_currency,
    325 AS game_development_ecpm_cents,
    'USD'::text AS javascript_and_frontend_ecpm_currency,
    525 AS javascript_and_frontend_ecpm_cents,
    'USD'::text AS miscellaneous_ecpm_currency,
    325 AS miscellaneous_ecpm_cents,
    'USD'::text AS mobile_development_ecpm_currency,
    350 AS mobile_development_ecpm_cents,
    'USD'::text AS web_development_and_backend_ecpm_currency,
    400 AS web_development_and_backend_ecpm_cents,
    '{AD,AL,AT,AU,AX,BA,BE,BG,BY,CC,CH,CX,CZ,DE,DK,EE,ES,FI,FO,FR,GB,GG,GI,GR,HR,HU,IE,IM,IS,IT,JE,LI,LT,LU,LV,MC,MD,ME,MK,MT,NF,NL,NO,NZ,PL,PT,RO,RS,SE,SI,SJ,SK,SM,UA,VA}'::text[] AS country_codes
UNION ALL
 SELECT 3 AS id,
    'Other'::text AS name,
    'USD'::text AS blockchain_ecpm_currency,
    600 AS blockchain_ecpm_cents,
    'USD'::text AS css_and_design_ecpm_currency,
    50 AS css_and_design_ecpm_cents,
    'USD'::text AS dev_ops_ecpm_currency,
    250 AS dev_ops_ecpm_cents,
    'USD'::text AS game_development_ecpm_currency,
    25 AS game_development_ecpm_cents,
    'USD'::text AS javascript_and_frontend_ecpm_currency,
    225 AS javascript_and_frontend_ecpm_cents,
    'USD'::text AS miscellaneous_ecpm_currency,
    25 AS miscellaneous_ecpm_cents,
    'USD'::text AS mobile_development_ecpm_currency,
    50 AS mobile_development_ecpm_cents,
    'USD'::text AS web_development_and_backend_ecpm_currency,
    100 AS web_development_and_backend_ecpm_cents,
    '{AE,AF,AG,AI,AM,AO,AR,AS,AW,AZ,BB,BD,BF,BH,BI,BJ,BL,BM,BN,BO,BQ,BR,BS,BT,BW,BZ,CD,CF,CG,CI,CK,CL,CM,CN,CO,CR,CU,CV,CW,CY,DJ,DM,DO,DZ,EC,EG,EH,ER,ET,FJ,FK,FM,GA,GD,GE,GF,GH,GL,GM,GN,GP,GQ,GS,GT,GU,GW,GY,HK,HN,HT,ID,IL,IN,IO,IQ,IR,JM,JO,JP,KE,KG,KH,KI,KM,KN,KP,KR,KW,KY,KZ,LA,LB,LC,LK,LR,LS,LY,MA,MF,MG,MH,ML,MM,MN,MO,MP,MQ,MR,MS,MU,MV,MW,MX,MY,MZ,NA,NC,NE,NG,NI,NP,NR,NU,OM,PA,PE,PF,PG,PH,PK,PM,PN,PR,PS,PW,PY,QA,RE,RU,RW,SA,SB,SC,SD,SG,SH,SL,SN,SO,SR,SS,ST,SV,SX,SY,SZ,TC,TD,TG,TH,TJ,TK,TL,TM,TN,TO,TR,TT,TV,TW,TZ,UG,UM,UY,UZ,VC,VE,VG,VI,VN,VU,WF,WS,YE,YT,ZA,ZM,ZW}'::text[] AS country_codes;


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
    status character varying DEFAULT 'active'::character varying
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
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


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
-- Name: organizations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations ALTER COLUMN id SET DEFAULT nextval('public.organizations_id_seq'::regclass);


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
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


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
-- Name: index_impressions_on_id_and_advertiser_id_and_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_impressions_on_id_and_advertiser_id_and_displayed_at_date ON ONLY public.impressions USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx24; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx24 ON public.impressions_2019_10_advertiser_646 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx25; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx25 ON public.impressions_2019_10_advertiser_572 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx26; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx26 ON public.impressions_2019_10_advertiser_365 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx27; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx27 ON public.impressions_2019_10_advertiser_659 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx28; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx28 ON public.impressions_2019_10_advertiser_457 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx29; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx29 ON public.impressions_2019_10_advertiser_710 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx30; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx30 ON public.impressions_2019_10_advertiser_615 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: index_impressions_on_ad_template; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_ad_template ON ONLY public.impressions USING btree (ad_template);


--
-- Name: impressions_2019_10_advertiser_365_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_365_ad_template_idx ON public.impressions_2019_10_advertiser_365 USING btree (ad_template);


--
-- Name: index_impressions_on_ad_theme; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_ad_theme ON ONLY public.impressions USING btree (ad_theme);


--
-- Name: impressions_2019_10_advertiser_365_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_365_ad_theme_idx ON public.impressions_2019_10_advertiser_365 USING btree (ad_theme);


--
-- Name: index_impressions_on_advertiser_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_advertiser_id ON ONLY public.impressions USING btree (advertiser_id);


--
-- Name: impressions_2019_10_advertiser_365_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_365_advertiser_id_idx ON public.impressions_2019_10_advertiser_365 USING btree (advertiser_id);


--
-- Name: index_impressions_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_campaign_id ON ONLY public.impressions USING btree (campaign_id);


--
-- Name: impressions_2019_10_advertiser_365_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_365_campaign_id_idx ON public.impressions_2019_10_advertiser_365 USING btree (campaign_id);


--
-- Name: index_impressions_on_clicked_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_clicked_at_date ON ONLY public.impressions USING btree (clicked_at_date);


--
-- Name: impressions_2019_10_advertiser_365_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_365_clicked_at_date_idx ON public.impressions_2019_10_advertiser_365 USING btree (clicked_at_date);


--
-- Name: index_impressions_on_country_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_country_code ON ONLY public.impressions USING btree (country_code);


--
-- Name: impressions_2019_10_advertiser_365_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_365_country_code_idx ON public.impressions_2019_10_advertiser_365 USING btree (country_code);


--
-- Name: index_impressions_on_creative_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_creative_id ON ONLY public.impressions USING btree (creative_id);


--
-- Name: impressions_2019_10_advertiser_365_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_365_creative_id_idx ON public.impressions_2019_10_advertiser_365 USING btree (creative_id);


--
-- Name: index_impressions_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_displayed_at_hour ON ONLY public.impressions USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_10_advertiser_365_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_365_date_trunc_idx ON public.impressions_2019_10_advertiser_365 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_on_clicked_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_clicked_at_hour ON ONLY public.impressions USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_10_advertiser_365_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_365_date_trunc_idx1 ON public.impressions_2019_10_advertiser_365 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: index_impressions_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_displayed_at_date ON ONLY public.impressions USING btree (displayed_at_date);


--
-- Name: impressions_2019_10_advertiser_365_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_365_displayed_at_date_idx ON public.impressions_2019_10_advertiser_365 USING btree (displayed_at_date);


--
-- Name: index_impressions_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_organization_id ON ONLY public.impressions USING btree (organization_id);


--
-- Name: impressions_2019_10_advertiser_365_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_365_organization_id_idx ON public.impressions_2019_10_advertiser_365 USING btree (organization_id);


--
-- Name: index_impressions_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_property_id ON ONLY public.impressions USING btree (property_id);


--
-- Name: impressions_2019_10_advertiser_365_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_365_property_id_idx ON public.impressions_2019_10_advertiser_365 USING btree (property_id);


--
-- Name: index_impressions_on_province_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_province_code ON ONLY public.impressions USING btree (province_code);


--
-- Name: impressions_2019_10_advertiser_365_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_365_province_code_idx ON public.impressions_2019_10_advertiser_365 USING btree (province_code);


--
-- Name: index_impressions_on_uplift; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_uplift ON ONLY public.impressions USING btree (uplift);


--
-- Name: impressions_2019_10_advertiser_365_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_365_uplift_idx ON public.impressions_2019_10_advertiser_365 USING btree (uplift);


--
-- Name: impressions_2019_10_advertiser_457_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_457_ad_template_idx ON public.impressions_2019_10_advertiser_457 USING btree (ad_template);


--
-- Name: impressions_2019_10_advertiser_457_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_457_ad_theme_idx ON public.impressions_2019_10_advertiser_457 USING btree (ad_theme);


--
-- Name: impressions_2019_10_advertiser_457_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_457_advertiser_id_idx ON public.impressions_2019_10_advertiser_457 USING btree (advertiser_id);


--
-- Name: impressions_2019_10_advertiser_457_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_457_campaign_id_idx ON public.impressions_2019_10_advertiser_457 USING btree (campaign_id);


--
-- Name: impressions_2019_10_advertiser_457_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_457_clicked_at_date_idx ON public.impressions_2019_10_advertiser_457 USING btree (clicked_at_date);


--
-- Name: impressions_2019_10_advertiser_457_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_457_country_code_idx ON public.impressions_2019_10_advertiser_457 USING btree (country_code);


--
-- Name: impressions_2019_10_advertiser_457_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_457_creative_id_idx ON public.impressions_2019_10_advertiser_457 USING btree (creative_id);


--
-- Name: impressions_2019_10_advertiser_457_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_457_date_trunc_idx ON public.impressions_2019_10_advertiser_457 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_10_advertiser_457_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_457_date_trunc_idx1 ON public.impressions_2019_10_advertiser_457 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_10_advertiser_457_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_457_displayed_at_date_idx ON public.impressions_2019_10_advertiser_457 USING btree (displayed_at_date);


--
-- Name: impressions_2019_10_advertiser_457_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_457_organization_id_idx ON public.impressions_2019_10_advertiser_457 USING btree (organization_id);


--
-- Name: impressions_2019_10_advertiser_457_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_457_property_id_idx ON public.impressions_2019_10_advertiser_457 USING btree (property_id);


--
-- Name: impressions_2019_10_advertiser_457_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_457_province_code_idx ON public.impressions_2019_10_advertiser_457 USING btree (province_code);


--
-- Name: impressions_2019_10_advertiser_457_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_457_uplift_idx ON public.impressions_2019_10_advertiser_457 USING btree (uplift);


--
-- Name: impressions_2019_10_advertiser_572_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_572_ad_template_idx ON public.impressions_2019_10_advertiser_572 USING btree (ad_template);


--
-- Name: impressions_2019_10_advertiser_572_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_572_ad_theme_idx ON public.impressions_2019_10_advertiser_572 USING btree (ad_theme);


--
-- Name: impressions_2019_10_advertiser_572_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_572_advertiser_id_idx ON public.impressions_2019_10_advertiser_572 USING btree (advertiser_id);


--
-- Name: impressions_2019_10_advertiser_572_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_572_campaign_id_idx ON public.impressions_2019_10_advertiser_572 USING btree (campaign_id);


--
-- Name: impressions_2019_10_advertiser_572_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_572_clicked_at_date_idx ON public.impressions_2019_10_advertiser_572 USING btree (clicked_at_date);


--
-- Name: impressions_2019_10_advertiser_572_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_572_country_code_idx ON public.impressions_2019_10_advertiser_572 USING btree (country_code);


--
-- Name: impressions_2019_10_advertiser_572_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_572_creative_id_idx ON public.impressions_2019_10_advertiser_572 USING btree (creative_id);


--
-- Name: impressions_2019_10_advertiser_572_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_572_date_trunc_idx ON public.impressions_2019_10_advertiser_572 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_10_advertiser_572_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_572_date_trunc_idx1 ON public.impressions_2019_10_advertiser_572 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_10_advertiser_572_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_572_displayed_at_date_idx ON public.impressions_2019_10_advertiser_572 USING btree (displayed_at_date);


--
-- Name: impressions_2019_10_advertiser_572_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_572_organization_id_idx ON public.impressions_2019_10_advertiser_572 USING btree (organization_id);


--
-- Name: impressions_2019_10_advertiser_572_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_572_property_id_idx ON public.impressions_2019_10_advertiser_572 USING btree (property_id);


--
-- Name: impressions_2019_10_advertiser_572_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_572_province_code_idx ON public.impressions_2019_10_advertiser_572 USING btree (province_code);


--
-- Name: impressions_2019_10_advertiser_572_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_572_uplift_idx ON public.impressions_2019_10_advertiser_572 USING btree (uplift);


--
-- Name: impressions_2019_10_advertiser_615_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_615_ad_template_idx ON public.impressions_2019_10_advertiser_615 USING btree (ad_template);


--
-- Name: impressions_2019_10_advertiser_615_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_615_ad_theme_idx ON public.impressions_2019_10_advertiser_615 USING btree (ad_theme);


--
-- Name: impressions_2019_10_advertiser_615_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_615_advertiser_id_idx ON public.impressions_2019_10_advertiser_615 USING btree (advertiser_id);


--
-- Name: impressions_2019_10_advertiser_615_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_615_campaign_id_idx ON public.impressions_2019_10_advertiser_615 USING btree (campaign_id);


--
-- Name: impressions_2019_10_advertiser_615_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_615_clicked_at_date_idx ON public.impressions_2019_10_advertiser_615 USING btree (clicked_at_date);


--
-- Name: impressions_2019_10_advertiser_615_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_615_country_code_idx ON public.impressions_2019_10_advertiser_615 USING btree (country_code);


--
-- Name: impressions_2019_10_advertiser_615_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_615_creative_id_idx ON public.impressions_2019_10_advertiser_615 USING btree (creative_id);


--
-- Name: impressions_2019_10_advertiser_615_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_615_date_trunc_idx ON public.impressions_2019_10_advertiser_615 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_10_advertiser_615_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_615_date_trunc_idx1 ON public.impressions_2019_10_advertiser_615 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_10_advertiser_615_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_615_displayed_at_date_idx ON public.impressions_2019_10_advertiser_615 USING btree (displayed_at_date);


--
-- Name: impressions_2019_10_advertiser_615_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_615_organization_id_idx ON public.impressions_2019_10_advertiser_615 USING btree (organization_id);


--
-- Name: impressions_2019_10_advertiser_615_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_615_property_id_idx ON public.impressions_2019_10_advertiser_615 USING btree (property_id);


--
-- Name: impressions_2019_10_advertiser_615_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_615_province_code_idx ON public.impressions_2019_10_advertiser_615 USING btree (province_code);


--
-- Name: impressions_2019_10_advertiser_615_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_615_uplift_idx ON public.impressions_2019_10_advertiser_615 USING btree (uplift);


--
-- Name: impressions_2019_10_advertiser_646_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_646_ad_template_idx ON public.impressions_2019_10_advertiser_646 USING btree (ad_template);


--
-- Name: impressions_2019_10_advertiser_646_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_646_ad_theme_idx ON public.impressions_2019_10_advertiser_646 USING btree (ad_theme);


--
-- Name: impressions_2019_10_advertiser_646_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_646_advertiser_id_idx ON public.impressions_2019_10_advertiser_646 USING btree (advertiser_id);


--
-- Name: impressions_2019_10_advertiser_646_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_646_campaign_id_idx ON public.impressions_2019_10_advertiser_646 USING btree (campaign_id);


--
-- Name: impressions_2019_10_advertiser_646_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_646_clicked_at_date_idx ON public.impressions_2019_10_advertiser_646 USING btree (clicked_at_date);


--
-- Name: impressions_2019_10_advertiser_646_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_646_country_code_idx ON public.impressions_2019_10_advertiser_646 USING btree (country_code);


--
-- Name: impressions_2019_10_advertiser_646_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_646_creative_id_idx ON public.impressions_2019_10_advertiser_646 USING btree (creative_id);


--
-- Name: impressions_2019_10_advertiser_646_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_646_date_trunc_idx ON public.impressions_2019_10_advertiser_646 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_10_advertiser_646_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_646_date_trunc_idx1 ON public.impressions_2019_10_advertiser_646 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_10_advertiser_646_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_646_displayed_at_date_idx ON public.impressions_2019_10_advertiser_646 USING btree (displayed_at_date);


--
-- Name: impressions_2019_10_advertiser_646_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_646_organization_id_idx ON public.impressions_2019_10_advertiser_646 USING btree (organization_id);


--
-- Name: impressions_2019_10_advertiser_646_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_646_property_id_idx ON public.impressions_2019_10_advertiser_646 USING btree (property_id);


--
-- Name: impressions_2019_10_advertiser_646_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_646_province_code_idx ON public.impressions_2019_10_advertiser_646 USING btree (province_code);


--
-- Name: impressions_2019_10_advertiser_646_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_646_uplift_idx ON public.impressions_2019_10_advertiser_646 USING btree (uplift);


--
-- Name: impressions_2019_10_advertiser_659_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_659_ad_template_idx ON public.impressions_2019_10_advertiser_659 USING btree (ad_template);


--
-- Name: impressions_2019_10_advertiser_659_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_659_ad_theme_idx ON public.impressions_2019_10_advertiser_659 USING btree (ad_theme);


--
-- Name: impressions_2019_10_advertiser_659_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_659_advertiser_id_idx ON public.impressions_2019_10_advertiser_659 USING btree (advertiser_id);


--
-- Name: impressions_2019_10_advertiser_659_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_659_campaign_id_idx ON public.impressions_2019_10_advertiser_659 USING btree (campaign_id);


--
-- Name: impressions_2019_10_advertiser_659_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_659_clicked_at_date_idx ON public.impressions_2019_10_advertiser_659 USING btree (clicked_at_date);


--
-- Name: impressions_2019_10_advertiser_659_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_659_country_code_idx ON public.impressions_2019_10_advertiser_659 USING btree (country_code);


--
-- Name: impressions_2019_10_advertiser_659_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_659_creative_id_idx ON public.impressions_2019_10_advertiser_659 USING btree (creative_id);


--
-- Name: impressions_2019_10_advertiser_659_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_659_date_trunc_idx ON public.impressions_2019_10_advertiser_659 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_10_advertiser_659_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_659_date_trunc_idx1 ON public.impressions_2019_10_advertiser_659 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_10_advertiser_659_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_659_displayed_at_date_idx ON public.impressions_2019_10_advertiser_659 USING btree (displayed_at_date);


--
-- Name: impressions_2019_10_advertiser_659_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_659_organization_id_idx ON public.impressions_2019_10_advertiser_659 USING btree (organization_id);


--
-- Name: impressions_2019_10_advertiser_659_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_659_property_id_idx ON public.impressions_2019_10_advertiser_659 USING btree (property_id);


--
-- Name: impressions_2019_10_advertiser_659_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_659_province_code_idx ON public.impressions_2019_10_advertiser_659 USING btree (province_code);


--
-- Name: impressions_2019_10_advertiser_659_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_659_uplift_idx ON public.impressions_2019_10_advertiser_659 USING btree (uplift);


--
-- Name: impressions_2019_10_advertiser_710_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_710_ad_template_idx ON public.impressions_2019_10_advertiser_710 USING btree (ad_template);


--
-- Name: impressions_2019_10_advertiser_710_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_710_ad_theme_idx ON public.impressions_2019_10_advertiser_710 USING btree (ad_theme);


--
-- Name: impressions_2019_10_advertiser_710_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_710_advertiser_id_idx ON public.impressions_2019_10_advertiser_710 USING btree (advertiser_id);


--
-- Name: impressions_2019_10_advertiser_710_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_710_campaign_id_idx ON public.impressions_2019_10_advertiser_710 USING btree (campaign_id);


--
-- Name: impressions_2019_10_advertiser_710_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_710_clicked_at_date_idx ON public.impressions_2019_10_advertiser_710 USING btree (clicked_at_date);


--
-- Name: impressions_2019_10_advertiser_710_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_710_country_code_idx ON public.impressions_2019_10_advertiser_710 USING btree (country_code);


--
-- Name: impressions_2019_10_advertiser_710_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_710_creative_id_idx ON public.impressions_2019_10_advertiser_710 USING btree (creative_id);


--
-- Name: impressions_2019_10_advertiser_710_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_710_date_trunc_idx ON public.impressions_2019_10_advertiser_710 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_10_advertiser_710_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_710_date_trunc_idx1 ON public.impressions_2019_10_advertiser_710 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_10_advertiser_710_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_710_displayed_at_date_idx ON public.impressions_2019_10_advertiser_710 USING btree (displayed_at_date);


--
-- Name: impressions_2019_10_advertiser_710_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_710_organization_id_idx ON public.impressions_2019_10_advertiser_710 USING btree (organization_id);


--
-- Name: impressions_2019_10_advertiser_710_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_710_property_id_idx ON public.impressions_2019_10_advertiser_710 USING btree (property_id);


--
-- Name: impressions_2019_10_advertiser_710_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_710_province_code_idx ON public.impressions_2019_10_advertiser_710 USING btree (province_code);


--
-- Name: impressions_2019_10_advertiser_710_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_10_advertiser_710_uplift_idx ON public.impressions_2019_10_advertiser_710 USING btree (uplift);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx10; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx10 ON public.impressions_2019_11_advertiser_710 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx11; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx11 ON public.impressions_2019_11_advertiser_659 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx12; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx12 ON public.impressions_2019_11_advertiser_660 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx13; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx13 ON public.impressions_2019_11_advertiser_272 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx14; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx14 ON public.impressions_2019_11_advertiser_712 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx15; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx15 ON public.impressions_2019_11_advertiser_651 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx16; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx16 ON public.impressions_2019_11_advertiser_646 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx17; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx17 ON public.impressions_2019_11_advertiser_457 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx18; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx18 ON public.impressions_2019_11_advertiser_697 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx19; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx19 ON public.impressions_2019_11_advertiser_123 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx20; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx20 ON public.impressions_2019_11_advertiser_788 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx21; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx21 ON public.impressions_2019_11_advertiser_711 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx22; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx22 ON public.impressions_2019_11_advertiser_365 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx23; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx23 ON public.impressions_2019_11_advertiser_615 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx24; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx24 ON public.impressions_2019_11_advertiser_707 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx25; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx25 ON public.impressions_2019_11_advertiser_789 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx26; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx26 ON public.impressions_2019_11_advertiser_305 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx27; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx27 ON public.impressions_2019_11_advertiser_624 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx28; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx28 ON public.impressions_2019_11_advertiser_619 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx29; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx29 ON public.impressions_2019_11_advertiser_576 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx30; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx30 ON public.impressions_2019_11_advertiser_850 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx31; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx31 ON public.impressions_2019_11_advertiser_779 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx32; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx32 ON public.impressions_2019_11_advertiser_735 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx33; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx33 ON public.impressions_2019_11_advertiser_714 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx1 ON public.impressions_2019_11_advertiser_613 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx2; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx2 ON public.impressions_2019_11_advertiser_185 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx3; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx3 ON public.impressions_2019_11_advertiser_146 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx4; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx4 ON public.impressions_2019_11_advertiser_632 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx5; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx5 ON public.impressions_2019_11_advertiser_700 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx6; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx6 ON public.impressions_2019_11_advertiser_723 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx7; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx7 ON public.impressions_2019_11_advertiser_239 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx8; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx8 ON public.impressions_2019_11_advertiser_769 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx9; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx9 ON public.impressions_2019_11_advertiser_572 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertise_id_advertiser_id_displayed_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX impressions_2019_11_advertise_id_advertiser_id_displayed_at_idx ON public.impressions_2019_11_advertiser_727 USING btree (id, advertiser_id, displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_123_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_123_ad_template_idx ON public.impressions_2019_11_advertiser_123 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_123_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_123_ad_theme_idx ON public.impressions_2019_11_advertiser_123 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_123_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_123_advertiser_id_idx ON public.impressions_2019_11_advertiser_123 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_123_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_123_campaign_id_idx ON public.impressions_2019_11_advertiser_123 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_123_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_123_clicked_at_date_idx ON public.impressions_2019_11_advertiser_123 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_123_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_123_country_code_idx ON public.impressions_2019_11_advertiser_123 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_123_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_123_creative_id_idx ON public.impressions_2019_11_advertiser_123 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_123_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_123_date_trunc_idx ON public.impressions_2019_11_advertiser_123 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_123_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_123_date_trunc_idx1 ON public.impressions_2019_11_advertiser_123 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_123_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_123_displayed_at_date_idx ON public.impressions_2019_11_advertiser_123 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_123_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_123_organization_id_idx ON public.impressions_2019_11_advertiser_123 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_123_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_123_property_id_idx ON public.impressions_2019_11_advertiser_123 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_123_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_123_province_code_idx ON public.impressions_2019_11_advertiser_123 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_123_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_123_uplift_idx ON public.impressions_2019_11_advertiser_123 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_146_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_146_ad_template_idx ON public.impressions_2019_11_advertiser_146 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_146_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_146_ad_theme_idx ON public.impressions_2019_11_advertiser_146 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_146_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_146_advertiser_id_idx ON public.impressions_2019_11_advertiser_146 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_146_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_146_campaign_id_idx ON public.impressions_2019_11_advertiser_146 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_146_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_146_clicked_at_date_idx ON public.impressions_2019_11_advertiser_146 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_146_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_146_country_code_idx ON public.impressions_2019_11_advertiser_146 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_146_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_146_creative_id_idx ON public.impressions_2019_11_advertiser_146 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_146_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_146_date_trunc_idx ON public.impressions_2019_11_advertiser_146 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_146_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_146_date_trunc_idx1 ON public.impressions_2019_11_advertiser_146 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_146_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_146_displayed_at_date_idx ON public.impressions_2019_11_advertiser_146 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_146_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_146_organization_id_idx ON public.impressions_2019_11_advertiser_146 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_146_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_146_property_id_idx ON public.impressions_2019_11_advertiser_146 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_146_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_146_province_code_idx ON public.impressions_2019_11_advertiser_146 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_146_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_146_uplift_idx ON public.impressions_2019_11_advertiser_146 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_185_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_185_ad_template_idx ON public.impressions_2019_11_advertiser_185 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_185_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_185_ad_theme_idx ON public.impressions_2019_11_advertiser_185 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_185_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_185_advertiser_id_idx ON public.impressions_2019_11_advertiser_185 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_185_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_185_campaign_id_idx ON public.impressions_2019_11_advertiser_185 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_185_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_185_clicked_at_date_idx ON public.impressions_2019_11_advertiser_185 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_185_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_185_country_code_idx ON public.impressions_2019_11_advertiser_185 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_185_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_185_creative_id_idx ON public.impressions_2019_11_advertiser_185 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_185_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_185_date_trunc_idx ON public.impressions_2019_11_advertiser_185 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_185_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_185_date_trunc_idx1 ON public.impressions_2019_11_advertiser_185 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_185_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_185_displayed_at_date_idx ON public.impressions_2019_11_advertiser_185 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_185_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_185_organization_id_idx ON public.impressions_2019_11_advertiser_185 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_185_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_185_property_id_idx ON public.impressions_2019_11_advertiser_185 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_185_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_185_province_code_idx ON public.impressions_2019_11_advertiser_185 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_185_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_185_uplift_idx ON public.impressions_2019_11_advertiser_185 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_239_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_239_ad_template_idx ON public.impressions_2019_11_advertiser_239 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_239_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_239_ad_theme_idx ON public.impressions_2019_11_advertiser_239 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_239_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_239_advertiser_id_idx ON public.impressions_2019_11_advertiser_239 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_239_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_239_campaign_id_idx ON public.impressions_2019_11_advertiser_239 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_239_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_239_clicked_at_date_idx ON public.impressions_2019_11_advertiser_239 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_239_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_239_country_code_idx ON public.impressions_2019_11_advertiser_239 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_239_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_239_creative_id_idx ON public.impressions_2019_11_advertiser_239 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_239_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_239_date_trunc_idx ON public.impressions_2019_11_advertiser_239 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_239_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_239_date_trunc_idx1 ON public.impressions_2019_11_advertiser_239 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_239_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_239_displayed_at_date_idx ON public.impressions_2019_11_advertiser_239 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_239_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_239_organization_id_idx ON public.impressions_2019_11_advertiser_239 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_239_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_239_property_id_idx ON public.impressions_2019_11_advertiser_239 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_239_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_239_province_code_idx ON public.impressions_2019_11_advertiser_239 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_239_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_239_uplift_idx ON public.impressions_2019_11_advertiser_239 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_272_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_272_ad_template_idx ON public.impressions_2019_11_advertiser_272 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_272_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_272_ad_theme_idx ON public.impressions_2019_11_advertiser_272 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_272_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_272_advertiser_id_idx ON public.impressions_2019_11_advertiser_272 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_272_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_272_campaign_id_idx ON public.impressions_2019_11_advertiser_272 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_272_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_272_clicked_at_date_idx ON public.impressions_2019_11_advertiser_272 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_272_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_272_country_code_idx ON public.impressions_2019_11_advertiser_272 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_272_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_272_creative_id_idx ON public.impressions_2019_11_advertiser_272 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_272_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_272_date_trunc_idx ON public.impressions_2019_11_advertiser_272 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_272_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_272_date_trunc_idx1 ON public.impressions_2019_11_advertiser_272 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_272_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_272_displayed_at_date_idx ON public.impressions_2019_11_advertiser_272 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_272_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_272_organization_id_idx ON public.impressions_2019_11_advertiser_272 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_272_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_272_property_id_idx ON public.impressions_2019_11_advertiser_272 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_272_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_272_province_code_idx ON public.impressions_2019_11_advertiser_272 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_272_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_272_uplift_idx ON public.impressions_2019_11_advertiser_272 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_305_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_305_ad_template_idx ON public.impressions_2019_11_advertiser_305 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_305_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_305_ad_theme_idx ON public.impressions_2019_11_advertiser_305 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_305_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_305_advertiser_id_idx ON public.impressions_2019_11_advertiser_305 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_305_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_305_campaign_id_idx ON public.impressions_2019_11_advertiser_305 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_305_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_305_clicked_at_date_idx ON public.impressions_2019_11_advertiser_305 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_305_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_305_country_code_idx ON public.impressions_2019_11_advertiser_305 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_305_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_305_creative_id_idx ON public.impressions_2019_11_advertiser_305 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_305_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_305_date_trunc_idx ON public.impressions_2019_11_advertiser_305 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_305_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_305_date_trunc_idx1 ON public.impressions_2019_11_advertiser_305 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_305_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_305_displayed_at_date_idx ON public.impressions_2019_11_advertiser_305 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_305_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_305_organization_id_idx ON public.impressions_2019_11_advertiser_305 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_305_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_305_property_id_idx ON public.impressions_2019_11_advertiser_305 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_305_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_305_province_code_idx ON public.impressions_2019_11_advertiser_305 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_305_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_305_uplift_idx ON public.impressions_2019_11_advertiser_305 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_365_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_365_ad_template_idx ON public.impressions_2019_11_advertiser_365 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_365_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_365_ad_theme_idx ON public.impressions_2019_11_advertiser_365 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_365_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_365_advertiser_id_idx ON public.impressions_2019_11_advertiser_365 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_365_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_365_campaign_id_idx ON public.impressions_2019_11_advertiser_365 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_365_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_365_clicked_at_date_idx ON public.impressions_2019_11_advertiser_365 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_365_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_365_country_code_idx ON public.impressions_2019_11_advertiser_365 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_365_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_365_creative_id_idx ON public.impressions_2019_11_advertiser_365 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_365_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_365_date_trunc_idx ON public.impressions_2019_11_advertiser_365 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_365_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_365_date_trunc_idx1 ON public.impressions_2019_11_advertiser_365 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_365_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_365_displayed_at_date_idx ON public.impressions_2019_11_advertiser_365 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_365_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_365_organization_id_idx ON public.impressions_2019_11_advertiser_365 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_365_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_365_property_id_idx ON public.impressions_2019_11_advertiser_365 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_365_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_365_province_code_idx ON public.impressions_2019_11_advertiser_365 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_365_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_365_uplift_idx ON public.impressions_2019_11_advertiser_365 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_457_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_457_ad_template_idx ON public.impressions_2019_11_advertiser_457 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_457_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_457_ad_theme_idx ON public.impressions_2019_11_advertiser_457 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_457_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_457_advertiser_id_idx ON public.impressions_2019_11_advertiser_457 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_457_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_457_campaign_id_idx ON public.impressions_2019_11_advertiser_457 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_457_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_457_clicked_at_date_idx ON public.impressions_2019_11_advertiser_457 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_457_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_457_country_code_idx ON public.impressions_2019_11_advertiser_457 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_457_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_457_creative_id_idx ON public.impressions_2019_11_advertiser_457 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_457_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_457_date_trunc_idx ON public.impressions_2019_11_advertiser_457 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_457_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_457_date_trunc_idx1 ON public.impressions_2019_11_advertiser_457 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_457_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_457_displayed_at_date_idx ON public.impressions_2019_11_advertiser_457 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_457_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_457_organization_id_idx ON public.impressions_2019_11_advertiser_457 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_457_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_457_property_id_idx ON public.impressions_2019_11_advertiser_457 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_457_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_457_province_code_idx ON public.impressions_2019_11_advertiser_457 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_457_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_457_uplift_idx ON public.impressions_2019_11_advertiser_457 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_572_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_572_ad_template_idx ON public.impressions_2019_11_advertiser_572 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_572_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_572_ad_theme_idx ON public.impressions_2019_11_advertiser_572 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_572_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_572_advertiser_id_idx ON public.impressions_2019_11_advertiser_572 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_572_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_572_campaign_id_idx ON public.impressions_2019_11_advertiser_572 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_572_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_572_clicked_at_date_idx ON public.impressions_2019_11_advertiser_572 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_572_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_572_country_code_idx ON public.impressions_2019_11_advertiser_572 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_572_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_572_creative_id_idx ON public.impressions_2019_11_advertiser_572 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_572_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_572_date_trunc_idx ON public.impressions_2019_11_advertiser_572 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_572_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_572_date_trunc_idx1 ON public.impressions_2019_11_advertiser_572 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_572_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_572_displayed_at_date_idx ON public.impressions_2019_11_advertiser_572 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_572_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_572_organization_id_idx ON public.impressions_2019_11_advertiser_572 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_572_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_572_property_id_idx ON public.impressions_2019_11_advertiser_572 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_572_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_572_province_code_idx ON public.impressions_2019_11_advertiser_572 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_572_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_572_uplift_idx ON public.impressions_2019_11_advertiser_572 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_576_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_576_ad_template_idx ON public.impressions_2019_11_advertiser_576 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_576_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_576_ad_theme_idx ON public.impressions_2019_11_advertiser_576 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_576_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_576_advertiser_id_idx ON public.impressions_2019_11_advertiser_576 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_576_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_576_campaign_id_idx ON public.impressions_2019_11_advertiser_576 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_576_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_576_clicked_at_date_idx ON public.impressions_2019_11_advertiser_576 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_576_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_576_country_code_idx ON public.impressions_2019_11_advertiser_576 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_576_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_576_creative_id_idx ON public.impressions_2019_11_advertiser_576 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_576_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_576_date_trunc_idx ON public.impressions_2019_11_advertiser_576 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_576_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_576_date_trunc_idx1 ON public.impressions_2019_11_advertiser_576 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_576_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_576_displayed_at_date_idx ON public.impressions_2019_11_advertiser_576 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_576_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_576_organization_id_idx ON public.impressions_2019_11_advertiser_576 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_576_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_576_property_id_idx ON public.impressions_2019_11_advertiser_576 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_576_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_576_province_code_idx ON public.impressions_2019_11_advertiser_576 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_576_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_576_uplift_idx ON public.impressions_2019_11_advertiser_576 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_613_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_613_ad_template_idx ON public.impressions_2019_11_advertiser_613 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_613_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_613_ad_theme_idx ON public.impressions_2019_11_advertiser_613 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_613_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_613_advertiser_id_idx ON public.impressions_2019_11_advertiser_613 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_613_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_613_campaign_id_idx ON public.impressions_2019_11_advertiser_613 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_613_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_613_clicked_at_date_idx ON public.impressions_2019_11_advertiser_613 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_613_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_613_country_code_idx ON public.impressions_2019_11_advertiser_613 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_613_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_613_creative_id_idx ON public.impressions_2019_11_advertiser_613 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_613_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_613_date_trunc_idx ON public.impressions_2019_11_advertiser_613 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_613_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_613_date_trunc_idx1 ON public.impressions_2019_11_advertiser_613 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_613_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_613_displayed_at_date_idx ON public.impressions_2019_11_advertiser_613 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_613_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_613_organization_id_idx ON public.impressions_2019_11_advertiser_613 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_613_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_613_property_id_idx ON public.impressions_2019_11_advertiser_613 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_613_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_613_province_code_idx ON public.impressions_2019_11_advertiser_613 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_613_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_613_uplift_idx ON public.impressions_2019_11_advertiser_613 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_615_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_615_ad_template_idx ON public.impressions_2019_11_advertiser_615 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_615_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_615_ad_theme_idx ON public.impressions_2019_11_advertiser_615 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_615_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_615_advertiser_id_idx ON public.impressions_2019_11_advertiser_615 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_615_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_615_campaign_id_idx ON public.impressions_2019_11_advertiser_615 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_615_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_615_clicked_at_date_idx ON public.impressions_2019_11_advertiser_615 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_615_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_615_country_code_idx ON public.impressions_2019_11_advertiser_615 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_615_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_615_creative_id_idx ON public.impressions_2019_11_advertiser_615 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_615_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_615_date_trunc_idx ON public.impressions_2019_11_advertiser_615 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_615_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_615_date_trunc_idx1 ON public.impressions_2019_11_advertiser_615 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_615_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_615_displayed_at_date_idx ON public.impressions_2019_11_advertiser_615 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_615_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_615_organization_id_idx ON public.impressions_2019_11_advertiser_615 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_615_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_615_property_id_idx ON public.impressions_2019_11_advertiser_615 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_615_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_615_province_code_idx ON public.impressions_2019_11_advertiser_615 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_615_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_615_uplift_idx ON public.impressions_2019_11_advertiser_615 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_619_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_619_ad_template_idx ON public.impressions_2019_11_advertiser_619 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_619_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_619_ad_theme_idx ON public.impressions_2019_11_advertiser_619 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_619_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_619_advertiser_id_idx ON public.impressions_2019_11_advertiser_619 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_619_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_619_campaign_id_idx ON public.impressions_2019_11_advertiser_619 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_619_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_619_clicked_at_date_idx ON public.impressions_2019_11_advertiser_619 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_619_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_619_country_code_idx ON public.impressions_2019_11_advertiser_619 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_619_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_619_creative_id_idx ON public.impressions_2019_11_advertiser_619 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_619_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_619_date_trunc_idx ON public.impressions_2019_11_advertiser_619 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_619_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_619_date_trunc_idx1 ON public.impressions_2019_11_advertiser_619 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_619_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_619_displayed_at_date_idx ON public.impressions_2019_11_advertiser_619 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_619_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_619_organization_id_idx ON public.impressions_2019_11_advertiser_619 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_619_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_619_property_id_idx ON public.impressions_2019_11_advertiser_619 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_619_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_619_province_code_idx ON public.impressions_2019_11_advertiser_619 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_619_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_619_uplift_idx ON public.impressions_2019_11_advertiser_619 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_624_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_624_ad_template_idx ON public.impressions_2019_11_advertiser_624 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_624_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_624_ad_theme_idx ON public.impressions_2019_11_advertiser_624 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_624_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_624_advertiser_id_idx ON public.impressions_2019_11_advertiser_624 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_624_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_624_campaign_id_idx ON public.impressions_2019_11_advertiser_624 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_624_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_624_clicked_at_date_idx ON public.impressions_2019_11_advertiser_624 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_624_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_624_country_code_idx ON public.impressions_2019_11_advertiser_624 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_624_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_624_creative_id_idx ON public.impressions_2019_11_advertiser_624 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_624_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_624_date_trunc_idx ON public.impressions_2019_11_advertiser_624 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_624_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_624_date_trunc_idx1 ON public.impressions_2019_11_advertiser_624 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_624_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_624_displayed_at_date_idx ON public.impressions_2019_11_advertiser_624 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_624_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_624_organization_id_idx ON public.impressions_2019_11_advertiser_624 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_624_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_624_property_id_idx ON public.impressions_2019_11_advertiser_624 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_624_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_624_province_code_idx ON public.impressions_2019_11_advertiser_624 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_624_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_624_uplift_idx ON public.impressions_2019_11_advertiser_624 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_632_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_632_ad_template_idx ON public.impressions_2019_11_advertiser_632 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_632_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_632_ad_theme_idx ON public.impressions_2019_11_advertiser_632 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_632_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_632_advertiser_id_idx ON public.impressions_2019_11_advertiser_632 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_632_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_632_campaign_id_idx ON public.impressions_2019_11_advertiser_632 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_632_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_632_clicked_at_date_idx ON public.impressions_2019_11_advertiser_632 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_632_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_632_country_code_idx ON public.impressions_2019_11_advertiser_632 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_632_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_632_creative_id_idx ON public.impressions_2019_11_advertiser_632 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_632_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_632_date_trunc_idx ON public.impressions_2019_11_advertiser_632 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_632_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_632_date_trunc_idx1 ON public.impressions_2019_11_advertiser_632 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_632_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_632_displayed_at_date_idx ON public.impressions_2019_11_advertiser_632 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_632_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_632_organization_id_idx ON public.impressions_2019_11_advertiser_632 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_632_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_632_property_id_idx ON public.impressions_2019_11_advertiser_632 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_632_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_632_province_code_idx ON public.impressions_2019_11_advertiser_632 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_632_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_632_uplift_idx ON public.impressions_2019_11_advertiser_632 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_646_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_646_ad_template_idx ON public.impressions_2019_11_advertiser_646 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_646_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_646_ad_theme_idx ON public.impressions_2019_11_advertiser_646 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_646_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_646_advertiser_id_idx ON public.impressions_2019_11_advertiser_646 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_646_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_646_campaign_id_idx ON public.impressions_2019_11_advertiser_646 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_646_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_646_clicked_at_date_idx ON public.impressions_2019_11_advertiser_646 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_646_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_646_country_code_idx ON public.impressions_2019_11_advertiser_646 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_646_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_646_creative_id_idx ON public.impressions_2019_11_advertiser_646 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_646_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_646_date_trunc_idx ON public.impressions_2019_11_advertiser_646 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_646_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_646_date_trunc_idx1 ON public.impressions_2019_11_advertiser_646 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_646_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_646_displayed_at_date_idx ON public.impressions_2019_11_advertiser_646 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_646_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_646_organization_id_idx ON public.impressions_2019_11_advertiser_646 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_646_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_646_property_id_idx ON public.impressions_2019_11_advertiser_646 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_646_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_646_province_code_idx ON public.impressions_2019_11_advertiser_646 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_646_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_646_uplift_idx ON public.impressions_2019_11_advertiser_646 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_651_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_651_ad_template_idx ON public.impressions_2019_11_advertiser_651 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_651_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_651_ad_theme_idx ON public.impressions_2019_11_advertiser_651 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_651_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_651_advertiser_id_idx ON public.impressions_2019_11_advertiser_651 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_651_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_651_campaign_id_idx ON public.impressions_2019_11_advertiser_651 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_651_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_651_clicked_at_date_idx ON public.impressions_2019_11_advertiser_651 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_651_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_651_country_code_idx ON public.impressions_2019_11_advertiser_651 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_651_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_651_creative_id_idx ON public.impressions_2019_11_advertiser_651 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_651_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_651_date_trunc_idx ON public.impressions_2019_11_advertiser_651 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_651_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_651_date_trunc_idx1 ON public.impressions_2019_11_advertiser_651 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_651_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_651_displayed_at_date_idx ON public.impressions_2019_11_advertiser_651 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_651_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_651_organization_id_idx ON public.impressions_2019_11_advertiser_651 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_651_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_651_property_id_idx ON public.impressions_2019_11_advertiser_651 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_651_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_651_province_code_idx ON public.impressions_2019_11_advertiser_651 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_651_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_651_uplift_idx ON public.impressions_2019_11_advertiser_651 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_659_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_659_ad_template_idx ON public.impressions_2019_11_advertiser_659 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_659_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_659_ad_theme_idx ON public.impressions_2019_11_advertiser_659 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_659_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_659_advertiser_id_idx ON public.impressions_2019_11_advertiser_659 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_659_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_659_campaign_id_idx ON public.impressions_2019_11_advertiser_659 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_659_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_659_clicked_at_date_idx ON public.impressions_2019_11_advertiser_659 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_659_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_659_country_code_idx ON public.impressions_2019_11_advertiser_659 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_659_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_659_creative_id_idx ON public.impressions_2019_11_advertiser_659 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_659_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_659_date_trunc_idx ON public.impressions_2019_11_advertiser_659 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_659_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_659_date_trunc_idx1 ON public.impressions_2019_11_advertiser_659 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_659_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_659_displayed_at_date_idx ON public.impressions_2019_11_advertiser_659 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_659_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_659_organization_id_idx ON public.impressions_2019_11_advertiser_659 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_659_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_659_property_id_idx ON public.impressions_2019_11_advertiser_659 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_659_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_659_province_code_idx ON public.impressions_2019_11_advertiser_659 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_659_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_659_uplift_idx ON public.impressions_2019_11_advertiser_659 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_660_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_660_ad_template_idx ON public.impressions_2019_11_advertiser_660 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_660_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_660_ad_theme_idx ON public.impressions_2019_11_advertiser_660 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_660_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_660_advertiser_id_idx ON public.impressions_2019_11_advertiser_660 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_660_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_660_campaign_id_idx ON public.impressions_2019_11_advertiser_660 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_660_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_660_clicked_at_date_idx ON public.impressions_2019_11_advertiser_660 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_660_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_660_country_code_idx ON public.impressions_2019_11_advertiser_660 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_660_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_660_creative_id_idx ON public.impressions_2019_11_advertiser_660 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_660_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_660_date_trunc_idx ON public.impressions_2019_11_advertiser_660 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_660_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_660_date_trunc_idx1 ON public.impressions_2019_11_advertiser_660 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_660_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_660_displayed_at_date_idx ON public.impressions_2019_11_advertiser_660 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_660_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_660_organization_id_idx ON public.impressions_2019_11_advertiser_660 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_660_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_660_property_id_idx ON public.impressions_2019_11_advertiser_660 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_660_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_660_province_code_idx ON public.impressions_2019_11_advertiser_660 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_660_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_660_uplift_idx ON public.impressions_2019_11_advertiser_660 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_697_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_697_ad_template_idx ON public.impressions_2019_11_advertiser_697 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_697_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_697_ad_theme_idx ON public.impressions_2019_11_advertiser_697 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_697_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_697_advertiser_id_idx ON public.impressions_2019_11_advertiser_697 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_697_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_697_campaign_id_idx ON public.impressions_2019_11_advertiser_697 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_697_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_697_clicked_at_date_idx ON public.impressions_2019_11_advertiser_697 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_697_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_697_country_code_idx ON public.impressions_2019_11_advertiser_697 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_697_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_697_creative_id_idx ON public.impressions_2019_11_advertiser_697 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_697_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_697_date_trunc_idx ON public.impressions_2019_11_advertiser_697 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_697_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_697_date_trunc_idx1 ON public.impressions_2019_11_advertiser_697 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_697_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_697_displayed_at_date_idx ON public.impressions_2019_11_advertiser_697 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_697_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_697_organization_id_idx ON public.impressions_2019_11_advertiser_697 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_697_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_697_property_id_idx ON public.impressions_2019_11_advertiser_697 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_697_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_697_province_code_idx ON public.impressions_2019_11_advertiser_697 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_697_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_697_uplift_idx ON public.impressions_2019_11_advertiser_697 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_700_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_700_ad_template_idx ON public.impressions_2019_11_advertiser_700 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_700_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_700_ad_theme_idx ON public.impressions_2019_11_advertiser_700 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_700_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_700_advertiser_id_idx ON public.impressions_2019_11_advertiser_700 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_700_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_700_campaign_id_idx ON public.impressions_2019_11_advertiser_700 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_700_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_700_clicked_at_date_idx ON public.impressions_2019_11_advertiser_700 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_700_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_700_country_code_idx ON public.impressions_2019_11_advertiser_700 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_700_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_700_creative_id_idx ON public.impressions_2019_11_advertiser_700 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_700_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_700_date_trunc_idx ON public.impressions_2019_11_advertiser_700 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_700_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_700_date_trunc_idx1 ON public.impressions_2019_11_advertiser_700 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_700_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_700_displayed_at_date_idx ON public.impressions_2019_11_advertiser_700 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_700_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_700_organization_id_idx ON public.impressions_2019_11_advertiser_700 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_700_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_700_property_id_idx ON public.impressions_2019_11_advertiser_700 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_700_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_700_province_code_idx ON public.impressions_2019_11_advertiser_700 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_700_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_700_uplift_idx ON public.impressions_2019_11_advertiser_700 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_707_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_707_ad_template_idx ON public.impressions_2019_11_advertiser_707 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_707_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_707_ad_theme_idx ON public.impressions_2019_11_advertiser_707 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_707_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_707_advertiser_id_idx ON public.impressions_2019_11_advertiser_707 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_707_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_707_campaign_id_idx ON public.impressions_2019_11_advertiser_707 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_707_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_707_clicked_at_date_idx ON public.impressions_2019_11_advertiser_707 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_707_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_707_country_code_idx ON public.impressions_2019_11_advertiser_707 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_707_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_707_creative_id_idx ON public.impressions_2019_11_advertiser_707 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_707_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_707_date_trunc_idx ON public.impressions_2019_11_advertiser_707 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_707_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_707_date_trunc_idx1 ON public.impressions_2019_11_advertiser_707 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_707_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_707_displayed_at_date_idx ON public.impressions_2019_11_advertiser_707 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_707_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_707_organization_id_idx ON public.impressions_2019_11_advertiser_707 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_707_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_707_property_id_idx ON public.impressions_2019_11_advertiser_707 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_707_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_707_province_code_idx ON public.impressions_2019_11_advertiser_707 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_707_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_707_uplift_idx ON public.impressions_2019_11_advertiser_707 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_710_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_710_ad_template_idx ON public.impressions_2019_11_advertiser_710 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_710_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_710_ad_theme_idx ON public.impressions_2019_11_advertiser_710 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_710_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_710_advertiser_id_idx ON public.impressions_2019_11_advertiser_710 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_710_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_710_campaign_id_idx ON public.impressions_2019_11_advertiser_710 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_710_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_710_clicked_at_date_idx ON public.impressions_2019_11_advertiser_710 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_710_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_710_country_code_idx ON public.impressions_2019_11_advertiser_710 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_710_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_710_creative_id_idx ON public.impressions_2019_11_advertiser_710 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_710_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_710_date_trunc_idx ON public.impressions_2019_11_advertiser_710 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_710_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_710_date_trunc_idx1 ON public.impressions_2019_11_advertiser_710 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_710_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_710_displayed_at_date_idx ON public.impressions_2019_11_advertiser_710 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_710_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_710_organization_id_idx ON public.impressions_2019_11_advertiser_710 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_710_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_710_property_id_idx ON public.impressions_2019_11_advertiser_710 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_710_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_710_province_code_idx ON public.impressions_2019_11_advertiser_710 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_710_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_710_uplift_idx ON public.impressions_2019_11_advertiser_710 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_711_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_711_ad_template_idx ON public.impressions_2019_11_advertiser_711 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_711_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_711_ad_theme_idx ON public.impressions_2019_11_advertiser_711 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_711_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_711_advertiser_id_idx ON public.impressions_2019_11_advertiser_711 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_711_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_711_campaign_id_idx ON public.impressions_2019_11_advertiser_711 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_711_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_711_clicked_at_date_idx ON public.impressions_2019_11_advertiser_711 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_711_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_711_country_code_idx ON public.impressions_2019_11_advertiser_711 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_711_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_711_creative_id_idx ON public.impressions_2019_11_advertiser_711 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_711_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_711_date_trunc_idx ON public.impressions_2019_11_advertiser_711 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_711_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_711_date_trunc_idx1 ON public.impressions_2019_11_advertiser_711 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_711_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_711_displayed_at_date_idx ON public.impressions_2019_11_advertiser_711 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_711_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_711_organization_id_idx ON public.impressions_2019_11_advertiser_711 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_711_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_711_property_id_idx ON public.impressions_2019_11_advertiser_711 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_711_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_711_province_code_idx ON public.impressions_2019_11_advertiser_711 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_711_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_711_uplift_idx ON public.impressions_2019_11_advertiser_711 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_712_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_712_ad_template_idx ON public.impressions_2019_11_advertiser_712 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_712_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_712_ad_theme_idx ON public.impressions_2019_11_advertiser_712 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_712_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_712_advertiser_id_idx ON public.impressions_2019_11_advertiser_712 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_712_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_712_campaign_id_idx ON public.impressions_2019_11_advertiser_712 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_712_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_712_clicked_at_date_idx ON public.impressions_2019_11_advertiser_712 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_712_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_712_country_code_idx ON public.impressions_2019_11_advertiser_712 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_712_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_712_creative_id_idx ON public.impressions_2019_11_advertiser_712 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_712_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_712_date_trunc_idx ON public.impressions_2019_11_advertiser_712 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_712_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_712_date_trunc_idx1 ON public.impressions_2019_11_advertiser_712 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_712_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_712_displayed_at_date_idx ON public.impressions_2019_11_advertiser_712 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_712_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_712_organization_id_idx ON public.impressions_2019_11_advertiser_712 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_712_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_712_property_id_idx ON public.impressions_2019_11_advertiser_712 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_712_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_712_province_code_idx ON public.impressions_2019_11_advertiser_712 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_712_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_712_uplift_idx ON public.impressions_2019_11_advertiser_712 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_714_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_714_ad_template_idx ON public.impressions_2019_11_advertiser_714 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_714_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_714_ad_theme_idx ON public.impressions_2019_11_advertiser_714 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_714_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_714_advertiser_id_idx ON public.impressions_2019_11_advertiser_714 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_714_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_714_campaign_id_idx ON public.impressions_2019_11_advertiser_714 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_714_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_714_clicked_at_date_idx ON public.impressions_2019_11_advertiser_714 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_714_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_714_country_code_idx ON public.impressions_2019_11_advertiser_714 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_714_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_714_creative_id_idx ON public.impressions_2019_11_advertiser_714 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_714_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_714_date_trunc_idx ON public.impressions_2019_11_advertiser_714 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_714_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_714_date_trunc_idx1 ON public.impressions_2019_11_advertiser_714 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_714_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_714_displayed_at_date_idx ON public.impressions_2019_11_advertiser_714 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_714_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_714_organization_id_idx ON public.impressions_2019_11_advertiser_714 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_714_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_714_property_id_idx ON public.impressions_2019_11_advertiser_714 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_714_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_714_province_code_idx ON public.impressions_2019_11_advertiser_714 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_714_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_714_uplift_idx ON public.impressions_2019_11_advertiser_714 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_723_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_723_ad_template_idx ON public.impressions_2019_11_advertiser_723 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_723_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_723_ad_theme_idx ON public.impressions_2019_11_advertiser_723 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_723_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_723_advertiser_id_idx ON public.impressions_2019_11_advertiser_723 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_723_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_723_campaign_id_idx ON public.impressions_2019_11_advertiser_723 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_723_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_723_clicked_at_date_idx ON public.impressions_2019_11_advertiser_723 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_723_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_723_country_code_idx ON public.impressions_2019_11_advertiser_723 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_723_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_723_creative_id_idx ON public.impressions_2019_11_advertiser_723 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_723_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_723_date_trunc_idx ON public.impressions_2019_11_advertiser_723 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_723_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_723_date_trunc_idx1 ON public.impressions_2019_11_advertiser_723 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_723_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_723_displayed_at_date_idx ON public.impressions_2019_11_advertiser_723 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_723_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_723_organization_id_idx ON public.impressions_2019_11_advertiser_723 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_723_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_723_property_id_idx ON public.impressions_2019_11_advertiser_723 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_723_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_723_province_code_idx ON public.impressions_2019_11_advertiser_723 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_723_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_723_uplift_idx ON public.impressions_2019_11_advertiser_723 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_727_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_727_ad_template_idx ON public.impressions_2019_11_advertiser_727 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_727_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_727_ad_theme_idx ON public.impressions_2019_11_advertiser_727 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_727_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_727_advertiser_id_idx ON public.impressions_2019_11_advertiser_727 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_727_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_727_campaign_id_idx ON public.impressions_2019_11_advertiser_727 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_727_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_727_clicked_at_date_idx ON public.impressions_2019_11_advertiser_727 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_727_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_727_country_code_idx ON public.impressions_2019_11_advertiser_727 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_727_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_727_creative_id_idx ON public.impressions_2019_11_advertiser_727 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_727_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_727_date_trunc_idx ON public.impressions_2019_11_advertiser_727 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_727_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_727_date_trunc_idx1 ON public.impressions_2019_11_advertiser_727 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_727_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_727_displayed_at_date_idx ON public.impressions_2019_11_advertiser_727 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_727_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_727_organization_id_idx ON public.impressions_2019_11_advertiser_727 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_727_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_727_property_id_idx ON public.impressions_2019_11_advertiser_727 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_727_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_727_province_code_idx ON public.impressions_2019_11_advertiser_727 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_727_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_727_uplift_idx ON public.impressions_2019_11_advertiser_727 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_735_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_735_ad_template_idx ON public.impressions_2019_11_advertiser_735 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_735_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_735_ad_theme_idx ON public.impressions_2019_11_advertiser_735 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_735_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_735_advertiser_id_idx ON public.impressions_2019_11_advertiser_735 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_735_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_735_campaign_id_idx ON public.impressions_2019_11_advertiser_735 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_735_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_735_clicked_at_date_idx ON public.impressions_2019_11_advertiser_735 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_735_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_735_country_code_idx ON public.impressions_2019_11_advertiser_735 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_735_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_735_creative_id_idx ON public.impressions_2019_11_advertiser_735 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_735_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_735_date_trunc_idx ON public.impressions_2019_11_advertiser_735 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_735_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_735_date_trunc_idx1 ON public.impressions_2019_11_advertiser_735 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_735_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_735_displayed_at_date_idx ON public.impressions_2019_11_advertiser_735 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_735_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_735_organization_id_idx ON public.impressions_2019_11_advertiser_735 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_735_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_735_property_id_idx ON public.impressions_2019_11_advertiser_735 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_735_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_735_province_code_idx ON public.impressions_2019_11_advertiser_735 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_735_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_735_uplift_idx ON public.impressions_2019_11_advertiser_735 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_769_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_769_ad_template_idx ON public.impressions_2019_11_advertiser_769 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_769_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_769_ad_theme_idx ON public.impressions_2019_11_advertiser_769 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_769_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_769_advertiser_id_idx ON public.impressions_2019_11_advertiser_769 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_769_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_769_campaign_id_idx ON public.impressions_2019_11_advertiser_769 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_769_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_769_clicked_at_date_idx ON public.impressions_2019_11_advertiser_769 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_769_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_769_country_code_idx ON public.impressions_2019_11_advertiser_769 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_769_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_769_creative_id_idx ON public.impressions_2019_11_advertiser_769 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_769_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_769_date_trunc_idx ON public.impressions_2019_11_advertiser_769 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_769_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_769_date_trunc_idx1 ON public.impressions_2019_11_advertiser_769 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_769_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_769_displayed_at_date_idx ON public.impressions_2019_11_advertiser_769 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_769_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_769_organization_id_idx ON public.impressions_2019_11_advertiser_769 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_769_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_769_property_id_idx ON public.impressions_2019_11_advertiser_769 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_769_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_769_province_code_idx ON public.impressions_2019_11_advertiser_769 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_769_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_769_uplift_idx ON public.impressions_2019_11_advertiser_769 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_779_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_779_ad_template_idx ON public.impressions_2019_11_advertiser_779 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_779_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_779_ad_theme_idx ON public.impressions_2019_11_advertiser_779 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_779_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_779_advertiser_id_idx ON public.impressions_2019_11_advertiser_779 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_779_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_779_campaign_id_idx ON public.impressions_2019_11_advertiser_779 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_779_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_779_clicked_at_date_idx ON public.impressions_2019_11_advertiser_779 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_779_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_779_country_code_idx ON public.impressions_2019_11_advertiser_779 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_779_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_779_creative_id_idx ON public.impressions_2019_11_advertiser_779 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_779_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_779_date_trunc_idx ON public.impressions_2019_11_advertiser_779 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_779_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_779_date_trunc_idx1 ON public.impressions_2019_11_advertiser_779 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_779_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_779_displayed_at_date_idx ON public.impressions_2019_11_advertiser_779 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_779_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_779_organization_id_idx ON public.impressions_2019_11_advertiser_779 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_779_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_779_property_id_idx ON public.impressions_2019_11_advertiser_779 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_779_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_779_province_code_idx ON public.impressions_2019_11_advertiser_779 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_779_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_779_uplift_idx ON public.impressions_2019_11_advertiser_779 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_788_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_788_ad_template_idx ON public.impressions_2019_11_advertiser_788 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_788_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_788_ad_theme_idx ON public.impressions_2019_11_advertiser_788 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_788_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_788_advertiser_id_idx ON public.impressions_2019_11_advertiser_788 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_788_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_788_campaign_id_idx ON public.impressions_2019_11_advertiser_788 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_788_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_788_clicked_at_date_idx ON public.impressions_2019_11_advertiser_788 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_788_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_788_country_code_idx ON public.impressions_2019_11_advertiser_788 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_788_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_788_creative_id_idx ON public.impressions_2019_11_advertiser_788 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_788_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_788_date_trunc_idx ON public.impressions_2019_11_advertiser_788 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_788_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_788_date_trunc_idx1 ON public.impressions_2019_11_advertiser_788 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_788_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_788_displayed_at_date_idx ON public.impressions_2019_11_advertiser_788 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_788_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_788_organization_id_idx ON public.impressions_2019_11_advertiser_788 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_788_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_788_property_id_idx ON public.impressions_2019_11_advertiser_788 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_788_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_788_province_code_idx ON public.impressions_2019_11_advertiser_788 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_788_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_788_uplift_idx ON public.impressions_2019_11_advertiser_788 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_789_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_789_ad_template_idx ON public.impressions_2019_11_advertiser_789 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_789_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_789_ad_theme_idx ON public.impressions_2019_11_advertiser_789 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_789_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_789_advertiser_id_idx ON public.impressions_2019_11_advertiser_789 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_789_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_789_campaign_id_idx ON public.impressions_2019_11_advertiser_789 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_789_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_789_clicked_at_date_idx ON public.impressions_2019_11_advertiser_789 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_789_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_789_country_code_idx ON public.impressions_2019_11_advertiser_789 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_789_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_789_creative_id_idx ON public.impressions_2019_11_advertiser_789 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_789_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_789_date_trunc_idx ON public.impressions_2019_11_advertiser_789 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_789_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_789_date_trunc_idx1 ON public.impressions_2019_11_advertiser_789 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_789_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_789_displayed_at_date_idx ON public.impressions_2019_11_advertiser_789 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_789_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_789_organization_id_idx ON public.impressions_2019_11_advertiser_789 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_789_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_789_property_id_idx ON public.impressions_2019_11_advertiser_789 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_789_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_789_province_code_idx ON public.impressions_2019_11_advertiser_789 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_789_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_789_uplift_idx ON public.impressions_2019_11_advertiser_789 USING btree (uplift);


--
-- Name: impressions_2019_11_advertiser_850_ad_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_850_ad_template_idx ON public.impressions_2019_11_advertiser_850 USING btree (ad_template);


--
-- Name: impressions_2019_11_advertiser_850_ad_theme_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_850_ad_theme_idx ON public.impressions_2019_11_advertiser_850 USING btree (ad_theme);


--
-- Name: impressions_2019_11_advertiser_850_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_850_advertiser_id_idx ON public.impressions_2019_11_advertiser_850 USING btree (advertiser_id);


--
-- Name: impressions_2019_11_advertiser_850_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_850_campaign_id_idx ON public.impressions_2019_11_advertiser_850 USING btree (campaign_id);


--
-- Name: impressions_2019_11_advertiser_850_clicked_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_850_clicked_at_date_idx ON public.impressions_2019_11_advertiser_850 USING btree (clicked_at_date);


--
-- Name: impressions_2019_11_advertiser_850_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_850_country_code_idx ON public.impressions_2019_11_advertiser_850 USING btree (country_code);


--
-- Name: impressions_2019_11_advertiser_850_creative_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_850_creative_id_idx ON public.impressions_2019_11_advertiser_850 USING btree (creative_id);


--
-- Name: impressions_2019_11_advertiser_850_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_850_date_trunc_idx ON public.impressions_2019_11_advertiser_850 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2019_11_advertiser_850_date_trunc_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_850_date_trunc_idx1 ON public.impressions_2019_11_advertiser_850 USING btree (date_trunc('hour'::text, clicked_at));


--
-- Name: impressions_2019_11_advertiser_850_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_850_displayed_at_date_idx ON public.impressions_2019_11_advertiser_850 USING btree (displayed_at_date);


--
-- Name: impressions_2019_11_advertiser_850_organization_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_850_organization_id_idx ON public.impressions_2019_11_advertiser_850 USING btree (organization_id);


--
-- Name: impressions_2019_11_advertiser_850_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_850_property_id_idx ON public.impressions_2019_11_advertiser_850 USING btree (property_id);


--
-- Name: impressions_2019_11_advertiser_850_province_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_850_province_code_idx ON public.impressions_2019_11_advertiser_850 USING btree (province_code);


--
-- Name: impressions_2019_11_advertiser_850_uplift_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2019_11_advertiser_850_uplift_idx ON public.impressions_2019_11_advertiser_850 USING btree (uplift);


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
-- Name: index_campaigns_on_assigned_property_ids; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_assigned_property_ids ON public.campaigns USING gin (assigned_property_ids);


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
-- Name: index_properties_on_assigned_fallback_campaign_ids; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_properties_on_assigned_fallback_campaign_ids ON public.properties USING gin (assigned_fallback_campaign_ids);


--
-- Name: index_properties_on_audience_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_properties_on_audience_id ON public.properties USING btree (audience_id);


--
-- Name: index_properties_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_properties_on_deleted_at ON public.properties USING btree (deleted_at);


--
-- Name: index_properties_on_keywords; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_properties_on_keywords ON public.properties USING gin (keywords);


--
-- Name: index_properties_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_properties_on_name ON public.properties USING btree (lower((name)::text));


--
-- Name: index_properties_on_prohibited_advertiser_ids; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_properties_on_prohibited_advertiser_ids ON public.properties USING gin (prohibited_advertiser_ids);


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
-- Name: impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx24; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx24;


--
-- Name: impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx25; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx25;


--
-- Name: impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx26; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx26;


--
-- Name: impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx27; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx27;


--
-- Name: impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx28; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx28;


--
-- Name: impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx29; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx29;


--
-- Name: impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx30; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_10_advertis_id_advertiser_id_displayed_a_idx30;


--
-- Name: impressions_2019_10_advertiser_365_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_10_advertiser_365_ad_template_idx;


--
-- Name: impressions_2019_10_advertiser_365_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_10_advertiser_365_ad_theme_idx;


--
-- Name: impressions_2019_10_advertiser_365_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_10_advertiser_365_advertiser_id_idx;


--
-- Name: impressions_2019_10_advertiser_365_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_10_advertiser_365_campaign_id_idx;


--
-- Name: impressions_2019_10_advertiser_365_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_10_advertiser_365_clicked_at_date_idx;


--
-- Name: impressions_2019_10_advertiser_365_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_10_advertiser_365_country_code_idx;


--
-- Name: impressions_2019_10_advertiser_365_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_10_advertiser_365_creative_id_idx;


--
-- Name: impressions_2019_10_advertiser_365_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_10_advertiser_365_date_trunc_idx;


--
-- Name: impressions_2019_10_advertiser_365_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_10_advertiser_365_date_trunc_idx1;


--
-- Name: impressions_2019_10_advertiser_365_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_10_advertiser_365_displayed_at_date_idx;


--
-- Name: impressions_2019_10_advertiser_365_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_10_advertiser_365_organization_id_idx;


--
-- Name: impressions_2019_10_advertiser_365_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_10_advertiser_365_property_id_idx;


--
-- Name: impressions_2019_10_advertiser_365_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_10_advertiser_365_province_code_idx;


--
-- Name: impressions_2019_10_advertiser_365_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_10_advertiser_365_uplift_idx;


--
-- Name: impressions_2019_10_advertiser_457_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_10_advertiser_457_ad_template_idx;


--
-- Name: impressions_2019_10_advertiser_457_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_10_advertiser_457_ad_theme_idx;


--
-- Name: impressions_2019_10_advertiser_457_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_10_advertiser_457_advertiser_id_idx;


--
-- Name: impressions_2019_10_advertiser_457_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_10_advertiser_457_campaign_id_idx;


--
-- Name: impressions_2019_10_advertiser_457_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_10_advertiser_457_clicked_at_date_idx;


--
-- Name: impressions_2019_10_advertiser_457_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_10_advertiser_457_country_code_idx;


--
-- Name: impressions_2019_10_advertiser_457_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_10_advertiser_457_creative_id_idx;


--
-- Name: impressions_2019_10_advertiser_457_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_10_advertiser_457_date_trunc_idx;


--
-- Name: impressions_2019_10_advertiser_457_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_10_advertiser_457_date_trunc_idx1;


--
-- Name: impressions_2019_10_advertiser_457_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_10_advertiser_457_displayed_at_date_idx;


--
-- Name: impressions_2019_10_advertiser_457_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_10_advertiser_457_organization_id_idx;


--
-- Name: impressions_2019_10_advertiser_457_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_10_advertiser_457_property_id_idx;


--
-- Name: impressions_2019_10_advertiser_457_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_10_advertiser_457_province_code_idx;


--
-- Name: impressions_2019_10_advertiser_457_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_10_advertiser_457_uplift_idx;


--
-- Name: impressions_2019_10_advertiser_572_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_10_advertiser_572_ad_template_idx;


--
-- Name: impressions_2019_10_advertiser_572_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_10_advertiser_572_ad_theme_idx;


--
-- Name: impressions_2019_10_advertiser_572_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_10_advertiser_572_advertiser_id_idx;


--
-- Name: impressions_2019_10_advertiser_572_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_10_advertiser_572_campaign_id_idx;


--
-- Name: impressions_2019_10_advertiser_572_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_10_advertiser_572_clicked_at_date_idx;


--
-- Name: impressions_2019_10_advertiser_572_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_10_advertiser_572_country_code_idx;


--
-- Name: impressions_2019_10_advertiser_572_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_10_advertiser_572_creative_id_idx;


--
-- Name: impressions_2019_10_advertiser_572_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_10_advertiser_572_date_trunc_idx;


--
-- Name: impressions_2019_10_advertiser_572_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_10_advertiser_572_date_trunc_idx1;


--
-- Name: impressions_2019_10_advertiser_572_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_10_advertiser_572_displayed_at_date_idx;


--
-- Name: impressions_2019_10_advertiser_572_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_10_advertiser_572_organization_id_idx;


--
-- Name: impressions_2019_10_advertiser_572_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_10_advertiser_572_property_id_idx;


--
-- Name: impressions_2019_10_advertiser_572_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_10_advertiser_572_province_code_idx;


--
-- Name: impressions_2019_10_advertiser_572_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_10_advertiser_572_uplift_idx;


--
-- Name: impressions_2019_10_advertiser_615_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_10_advertiser_615_ad_template_idx;


--
-- Name: impressions_2019_10_advertiser_615_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_10_advertiser_615_ad_theme_idx;


--
-- Name: impressions_2019_10_advertiser_615_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_10_advertiser_615_advertiser_id_idx;


--
-- Name: impressions_2019_10_advertiser_615_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_10_advertiser_615_campaign_id_idx;


--
-- Name: impressions_2019_10_advertiser_615_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_10_advertiser_615_clicked_at_date_idx;


--
-- Name: impressions_2019_10_advertiser_615_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_10_advertiser_615_country_code_idx;


--
-- Name: impressions_2019_10_advertiser_615_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_10_advertiser_615_creative_id_idx;


--
-- Name: impressions_2019_10_advertiser_615_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_10_advertiser_615_date_trunc_idx;


--
-- Name: impressions_2019_10_advertiser_615_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_10_advertiser_615_date_trunc_idx1;


--
-- Name: impressions_2019_10_advertiser_615_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_10_advertiser_615_displayed_at_date_idx;


--
-- Name: impressions_2019_10_advertiser_615_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_10_advertiser_615_organization_id_idx;


--
-- Name: impressions_2019_10_advertiser_615_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_10_advertiser_615_property_id_idx;


--
-- Name: impressions_2019_10_advertiser_615_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_10_advertiser_615_province_code_idx;


--
-- Name: impressions_2019_10_advertiser_615_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_10_advertiser_615_uplift_idx;


--
-- Name: impressions_2019_10_advertiser_646_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_10_advertiser_646_ad_template_idx;


--
-- Name: impressions_2019_10_advertiser_646_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_10_advertiser_646_ad_theme_idx;


--
-- Name: impressions_2019_10_advertiser_646_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_10_advertiser_646_advertiser_id_idx;


--
-- Name: impressions_2019_10_advertiser_646_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_10_advertiser_646_campaign_id_idx;


--
-- Name: impressions_2019_10_advertiser_646_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_10_advertiser_646_clicked_at_date_idx;


--
-- Name: impressions_2019_10_advertiser_646_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_10_advertiser_646_country_code_idx;


--
-- Name: impressions_2019_10_advertiser_646_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_10_advertiser_646_creative_id_idx;


--
-- Name: impressions_2019_10_advertiser_646_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_10_advertiser_646_date_trunc_idx;


--
-- Name: impressions_2019_10_advertiser_646_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_10_advertiser_646_date_trunc_idx1;


--
-- Name: impressions_2019_10_advertiser_646_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_10_advertiser_646_displayed_at_date_idx;


--
-- Name: impressions_2019_10_advertiser_646_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_10_advertiser_646_organization_id_idx;


--
-- Name: impressions_2019_10_advertiser_646_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_10_advertiser_646_property_id_idx;


--
-- Name: impressions_2019_10_advertiser_646_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_10_advertiser_646_province_code_idx;


--
-- Name: impressions_2019_10_advertiser_646_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_10_advertiser_646_uplift_idx;


--
-- Name: impressions_2019_10_advertiser_659_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_10_advertiser_659_ad_template_idx;


--
-- Name: impressions_2019_10_advertiser_659_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_10_advertiser_659_ad_theme_idx;


--
-- Name: impressions_2019_10_advertiser_659_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_10_advertiser_659_advertiser_id_idx;


--
-- Name: impressions_2019_10_advertiser_659_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_10_advertiser_659_campaign_id_idx;


--
-- Name: impressions_2019_10_advertiser_659_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_10_advertiser_659_clicked_at_date_idx;


--
-- Name: impressions_2019_10_advertiser_659_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_10_advertiser_659_country_code_idx;


--
-- Name: impressions_2019_10_advertiser_659_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_10_advertiser_659_creative_id_idx;


--
-- Name: impressions_2019_10_advertiser_659_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_10_advertiser_659_date_trunc_idx;


--
-- Name: impressions_2019_10_advertiser_659_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_10_advertiser_659_date_trunc_idx1;


--
-- Name: impressions_2019_10_advertiser_659_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_10_advertiser_659_displayed_at_date_idx;


--
-- Name: impressions_2019_10_advertiser_659_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_10_advertiser_659_organization_id_idx;


--
-- Name: impressions_2019_10_advertiser_659_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_10_advertiser_659_property_id_idx;


--
-- Name: impressions_2019_10_advertiser_659_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_10_advertiser_659_province_code_idx;


--
-- Name: impressions_2019_10_advertiser_659_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_10_advertiser_659_uplift_idx;


--
-- Name: impressions_2019_10_advertiser_710_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_10_advertiser_710_ad_template_idx;


--
-- Name: impressions_2019_10_advertiser_710_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_10_advertiser_710_ad_theme_idx;


--
-- Name: impressions_2019_10_advertiser_710_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_10_advertiser_710_advertiser_id_idx;


--
-- Name: impressions_2019_10_advertiser_710_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_10_advertiser_710_campaign_id_idx;


--
-- Name: impressions_2019_10_advertiser_710_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_10_advertiser_710_clicked_at_date_idx;


--
-- Name: impressions_2019_10_advertiser_710_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_10_advertiser_710_country_code_idx;


--
-- Name: impressions_2019_10_advertiser_710_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_10_advertiser_710_creative_id_idx;


--
-- Name: impressions_2019_10_advertiser_710_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_10_advertiser_710_date_trunc_idx;


--
-- Name: impressions_2019_10_advertiser_710_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_10_advertiser_710_date_trunc_idx1;


--
-- Name: impressions_2019_10_advertiser_710_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_10_advertiser_710_displayed_at_date_idx;


--
-- Name: impressions_2019_10_advertiser_710_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_10_advertiser_710_organization_id_idx;


--
-- Name: impressions_2019_10_advertiser_710_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_10_advertiser_710_property_id_idx;


--
-- Name: impressions_2019_10_advertiser_710_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_10_advertiser_710_province_code_idx;


--
-- Name: impressions_2019_10_advertiser_710_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_10_advertiser_710_uplift_idx;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx10; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx10;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx11; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx11;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx12; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx12;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx13; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx13;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx14; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx14;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx15; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx15;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx16; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx16;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx17; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx17;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx18; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx18;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx19; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx19;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx20; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx20;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx21; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx21;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx22; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx22;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx23; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx23;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx24; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx24;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx25; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx25;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx26; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx26;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx27; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx27;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx28; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx28;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx29; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx29;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx30; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx30;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx31; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx31;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx32; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx32;


--
-- Name: impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx33; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertis_id_advertiser_id_displayed_a_idx33;


--
-- Name: impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx1;


--
-- Name: impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx2; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx2;


--
-- Name: impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx3; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx3;


--
-- Name: impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx4; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx4;


--
-- Name: impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx5; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx5;


--
-- Name: impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx6; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx6;


--
-- Name: impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx7; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx7;


--
-- Name: impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx8; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx8;


--
-- Name: impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx9; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertise_id_advertiser_id_displayed_a_idx9;


--
-- Name: impressions_2019_11_advertise_id_advertiser_id_displayed_at_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_id_and_advertiser_id_and_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertise_id_advertiser_id_displayed_at_idx;


--
-- Name: impressions_2019_11_advertiser_123_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_123_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_123_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_123_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_123_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_123_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_123_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_123_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_123_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_123_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_123_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_123_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_123_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_123_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_123_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_123_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_123_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_123_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_123_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_123_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_123_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_123_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_123_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_123_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_123_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_123_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_123_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_123_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_146_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_146_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_146_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_146_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_146_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_146_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_146_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_146_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_146_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_146_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_146_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_146_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_146_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_146_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_146_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_146_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_146_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_146_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_146_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_146_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_146_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_146_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_146_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_146_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_146_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_146_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_146_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_146_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_185_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_185_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_185_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_185_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_185_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_185_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_185_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_185_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_185_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_185_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_185_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_185_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_185_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_185_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_185_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_185_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_185_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_185_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_185_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_185_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_185_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_185_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_185_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_185_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_185_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_185_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_185_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_185_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_239_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_239_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_239_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_239_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_239_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_239_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_239_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_239_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_239_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_239_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_239_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_239_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_239_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_239_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_239_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_239_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_239_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_239_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_239_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_239_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_239_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_239_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_239_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_239_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_239_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_239_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_239_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_239_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_272_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_272_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_272_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_272_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_272_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_272_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_272_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_272_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_272_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_272_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_272_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_272_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_272_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_272_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_272_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_272_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_272_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_272_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_272_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_272_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_272_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_272_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_272_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_272_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_272_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_272_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_272_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_272_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_305_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_305_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_305_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_305_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_305_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_305_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_305_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_305_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_305_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_305_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_305_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_305_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_305_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_305_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_305_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_305_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_305_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_305_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_305_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_305_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_305_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_305_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_305_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_305_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_305_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_305_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_305_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_305_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_365_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_365_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_365_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_365_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_365_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_365_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_365_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_365_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_365_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_365_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_365_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_365_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_365_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_365_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_365_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_365_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_365_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_365_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_365_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_365_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_365_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_365_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_365_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_365_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_365_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_365_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_365_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_365_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_457_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_457_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_457_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_457_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_457_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_457_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_457_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_457_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_457_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_457_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_457_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_457_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_457_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_457_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_457_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_457_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_457_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_457_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_457_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_457_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_457_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_457_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_457_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_457_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_457_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_457_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_457_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_457_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_572_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_572_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_572_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_572_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_572_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_572_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_572_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_572_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_572_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_572_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_572_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_572_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_572_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_572_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_572_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_572_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_572_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_572_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_572_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_572_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_572_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_572_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_572_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_572_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_572_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_572_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_572_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_572_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_576_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_576_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_576_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_576_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_576_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_576_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_576_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_576_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_576_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_576_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_576_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_576_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_576_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_576_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_576_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_576_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_576_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_576_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_576_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_576_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_576_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_576_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_576_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_576_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_576_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_576_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_576_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_576_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_613_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_613_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_613_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_613_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_613_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_613_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_613_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_613_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_613_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_613_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_613_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_613_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_613_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_613_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_613_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_613_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_613_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_613_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_613_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_613_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_613_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_613_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_613_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_613_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_613_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_613_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_613_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_613_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_615_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_615_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_615_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_615_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_615_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_615_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_615_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_615_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_615_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_615_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_615_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_615_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_615_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_615_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_615_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_615_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_615_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_615_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_615_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_615_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_615_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_615_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_615_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_615_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_615_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_615_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_615_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_615_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_619_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_619_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_619_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_619_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_619_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_619_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_619_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_619_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_619_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_619_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_619_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_619_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_619_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_619_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_619_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_619_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_619_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_619_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_619_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_619_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_619_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_619_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_619_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_619_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_619_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_619_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_619_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_619_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_624_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_624_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_624_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_624_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_624_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_624_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_624_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_624_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_624_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_624_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_624_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_624_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_624_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_624_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_624_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_624_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_624_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_624_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_624_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_624_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_624_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_624_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_624_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_624_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_624_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_624_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_624_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_624_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_632_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_632_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_632_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_632_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_632_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_632_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_632_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_632_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_632_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_632_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_632_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_632_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_632_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_632_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_632_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_632_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_632_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_632_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_632_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_632_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_632_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_632_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_632_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_632_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_632_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_632_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_632_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_632_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_646_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_646_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_646_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_646_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_646_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_646_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_646_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_646_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_646_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_646_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_646_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_646_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_646_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_646_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_646_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_646_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_646_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_646_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_646_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_646_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_646_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_646_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_646_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_646_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_646_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_646_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_646_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_646_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_651_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_651_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_651_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_651_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_651_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_651_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_651_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_651_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_651_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_651_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_651_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_651_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_651_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_651_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_651_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_651_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_651_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_651_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_651_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_651_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_651_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_651_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_651_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_651_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_651_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_651_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_651_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_651_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_659_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_659_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_659_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_659_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_659_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_659_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_659_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_659_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_659_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_659_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_659_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_659_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_659_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_659_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_659_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_659_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_659_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_659_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_659_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_659_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_659_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_659_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_659_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_659_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_659_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_659_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_659_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_659_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_660_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_660_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_660_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_660_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_660_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_660_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_660_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_660_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_660_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_660_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_660_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_660_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_660_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_660_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_660_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_660_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_660_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_660_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_660_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_660_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_660_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_660_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_660_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_660_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_660_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_660_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_660_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_660_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_697_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_697_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_697_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_697_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_697_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_697_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_697_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_697_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_697_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_697_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_697_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_697_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_697_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_697_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_697_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_697_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_697_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_697_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_697_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_697_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_697_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_697_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_697_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_697_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_697_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_697_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_697_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_697_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_700_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_700_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_700_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_700_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_700_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_700_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_700_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_700_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_700_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_700_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_700_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_700_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_700_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_700_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_700_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_700_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_700_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_700_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_700_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_700_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_700_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_700_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_700_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_700_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_700_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_700_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_700_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_700_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_707_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_707_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_707_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_707_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_707_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_707_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_707_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_707_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_707_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_707_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_707_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_707_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_707_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_707_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_707_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_707_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_707_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_707_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_707_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_707_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_707_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_707_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_707_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_707_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_707_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_707_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_707_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_707_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_710_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_710_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_710_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_710_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_710_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_710_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_710_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_710_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_710_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_710_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_710_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_710_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_710_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_710_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_710_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_710_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_710_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_710_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_710_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_710_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_710_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_710_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_710_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_710_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_710_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_710_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_710_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_710_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_711_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_711_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_711_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_711_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_711_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_711_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_711_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_711_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_711_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_711_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_711_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_711_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_711_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_711_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_711_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_711_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_711_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_711_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_711_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_711_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_711_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_711_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_711_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_711_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_711_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_711_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_711_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_711_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_712_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_712_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_712_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_712_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_712_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_712_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_712_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_712_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_712_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_712_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_712_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_712_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_712_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_712_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_712_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_712_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_712_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_712_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_712_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_712_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_712_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_712_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_712_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_712_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_712_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_712_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_712_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_712_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_714_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_714_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_714_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_714_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_714_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_714_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_714_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_714_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_714_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_714_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_714_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_714_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_714_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_714_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_714_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_714_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_714_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_714_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_714_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_714_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_714_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_714_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_714_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_714_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_714_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_714_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_714_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_714_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_723_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_723_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_723_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_723_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_723_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_723_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_723_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_723_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_723_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_723_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_723_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_723_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_723_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_723_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_723_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_723_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_723_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_723_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_723_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_723_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_723_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_723_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_723_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_723_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_723_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_723_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_723_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_723_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_727_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_727_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_727_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_727_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_727_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_727_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_727_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_727_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_727_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_727_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_727_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_727_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_727_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_727_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_727_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_727_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_727_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_727_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_727_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_727_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_727_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_727_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_727_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_727_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_727_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_727_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_727_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_727_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_735_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_735_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_735_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_735_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_735_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_735_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_735_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_735_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_735_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_735_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_735_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_735_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_735_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_735_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_735_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_735_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_735_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_735_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_735_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_735_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_735_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_735_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_735_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_735_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_735_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_735_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_735_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_735_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_769_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_769_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_769_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_769_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_769_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_769_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_769_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_769_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_769_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_769_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_769_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_769_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_769_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_769_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_769_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_769_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_769_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_769_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_769_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_769_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_769_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_769_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_769_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_769_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_769_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_769_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_769_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_769_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_779_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_779_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_779_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_779_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_779_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_779_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_779_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_779_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_779_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_779_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_779_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_779_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_779_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_779_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_779_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_779_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_779_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_779_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_779_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_779_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_779_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_779_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_779_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_779_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_779_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_779_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_779_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_779_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_788_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_788_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_788_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_788_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_788_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_788_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_788_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_788_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_788_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_788_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_788_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_788_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_788_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_788_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_788_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_788_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_788_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_788_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_788_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_788_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_788_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_788_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_788_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_788_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_788_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_788_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_788_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_788_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_789_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_789_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_789_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_789_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_789_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_789_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_789_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_789_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_789_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_789_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_789_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_789_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_789_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_789_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_789_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_789_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_789_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_789_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_789_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_789_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_789_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_789_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_789_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_789_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_789_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_789_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_789_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_789_uplift_idx;


--
-- Name: impressions_2019_11_advertiser_850_ad_template_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_template ATTACH PARTITION public.impressions_2019_11_advertiser_850_ad_template_idx;


--
-- Name: impressions_2019_11_advertiser_850_ad_theme_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_ad_theme ATTACH PARTITION public.impressions_2019_11_advertiser_850_ad_theme_idx;


--
-- Name: impressions_2019_11_advertiser_850_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2019_11_advertiser_850_advertiser_id_idx;


--
-- Name: impressions_2019_11_advertiser_850_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2019_11_advertiser_850_campaign_id_idx;


--
-- Name: impressions_2019_11_advertiser_850_clicked_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_850_clicked_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_850_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2019_11_advertiser_850_country_code_idx;


--
-- Name: impressions_2019_11_advertiser_850_creative_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_creative_id ATTACH PARTITION public.impressions_2019_11_advertiser_850_creative_id_idx;


--
-- Name: impressions_2019_11_advertiser_850_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_850_date_trunc_idx;


--
-- Name: impressions_2019_11_advertiser_850_date_trunc_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_clicked_at_hour ATTACH PARTITION public.impressions_2019_11_advertiser_850_date_trunc_idx1;


--
-- Name: impressions_2019_11_advertiser_850_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2019_11_advertiser_850_displayed_at_date_idx;


--
-- Name: impressions_2019_11_advertiser_850_organization_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_organization_id ATTACH PARTITION public.impressions_2019_11_advertiser_850_organization_id_idx;


--
-- Name: impressions_2019_11_advertiser_850_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2019_11_advertiser_850_property_id_idx;


--
-- Name: impressions_2019_11_advertiser_850_province_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_province_code ATTACH PARTITION public.impressions_2019_11_advertiser_850_province_code_idx;


--
-- Name: impressions_2019_11_advertiser_850_uplift_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_uplift ATTACH PARTITION public.impressions_2019_11_advertiser_850_uplift_idx;


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
('20191201235552');


