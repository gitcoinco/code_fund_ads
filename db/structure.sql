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
    us_hours_only boolean DEFAULT false,
    weekdays_only boolean DEFAULT false,
    total_budget_cents integer DEFAULT 0 NOT NULL,
    total_budget_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    daily_budget_cents integer DEFAULT 0 NOT NULL,
    daily_budget_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    ecpm_cents integer DEFAULT 0 NOT NULL,
    ecpm_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    countries character varying[] DEFAULT '{}'::character varying[],
    keywords character varying[] DEFAULT '{}'::character varying[],
    negative_keywords character varying[] DEFAULT '{}'::character varying[],
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
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
    headline character varying NOT NULL,
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
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
-- Name: impressions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    campaign_id bigint,
    campaign_name character varying,
    property_id bigint,
    property_name character varying,
    ip character varying,
    user_agent text,
    country character varying,
    postal_code character varying,
    latitude numeric,
    longitude numeric,
    payable boolean DEFAULT false NOT NULL,
    reason character varying,
    displayed_at timestamp without time zone,
    displayed_at_date date,
    clicked_at timestamp without time zone,
    fallback_campaign boolean DEFAULT false NOT NULL
)
PARTITION BY RANGE (displayed_at_date);


--
-- Name: impressions_2018_11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_11 PARTITION OF public.impressions
FOR VALUES FROM ('2018-11-01') TO ('2018-12-01');


--
-- Name: impressions_2018_12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_12 PARTITION OF public.impressions
FOR VALUES FROM ('2018-12-01') TO ('2019-01-01');


--
-- Name: impressions_2019_01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_01 PARTITION OF public.impressions
FOR VALUES FROM ('2019-01-01') TO ('2019-02-01');


--
-- Name: impressions_2019_02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_02 PARTITION OF public.impressions
FOR VALUES FROM ('2019-02-01') TO ('2019-03-01');


--
-- Name: impressions_2019_03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_03 PARTITION OF public.impressions
FOR VALUES FROM ('2019-03-01') TO ('2019-04-01');


--
-- Name: impressions_2019_04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_04 PARTITION OF public.impressions
FOR VALUES FROM ('2019-04-01') TO ('2019-05-01');


--
-- Name: impressions_2019_05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_05 PARTITION OF public.impressions
FOR VALUES FROM ('2019-05-01') TO ('2019-06-01');


--
-- Name: impressions_2019_06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_06 PARTITION OF public.impressions
FOR VALUES FROM ('2019-06-01') TO ('2019-07-01');


--
-- Name: impressions_2019_07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_07 PARTITION OF public.impressions
FOR VALUES FROM ('2019-07-01') TO ('2019-08-01');


--
-- Name: impressions_2019_08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_08 PARTITION OF public.impressions
FOR VALUES FROM ('2019-08-01') TO ('2019-09-01');


--
-- Name: impressions_2019_09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_09 PARTITION OF public.impressions
FOR VALUES FROM ('2019-09-01') TO ('2019-10-01');


--
-- Name: impressions_2019_10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_10 PARTITION OF public.impressions
FOR VALUES FROM ('2019-10-01') TO ('2019-11-01');


--
-- Name: impressions_2019_11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_11 PARTITION OF public.impressions
FOR VALUES FROM ('2019-11-01') TO ('2019-12-01');


--
-- Name: impressions_2019_12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2019_12 PARTITION OF public.impressions
FOR VALUES FROM ('2019-12-01') TO ('2020-01-01');


--
-- Name: impressions_2020_01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2020_01 PARTITION OF public.impressions
FOR VALUES FROM ('2020-01-01') TO ('2020-02-01');


--
-- Name: impressions_2020_02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2020_02 PARTITION OF public.impressions
FOR VALUES FROM ('2020-02-01') TO ('2020-03-01');


--
-- Name: impressions_2020_03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2020_03 PARTITION OF public.impressions
FOR VALUES FROM ('2020-03-01') TO ('2020-04-01');


--
-- Name: impressions_2020_04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2020_04 PARTITION OF public.impressions
FOR VALUES FROM ('2020-04-01') TO ('2020-05-01');


--
-- Name: impressions_2020_05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2020_05 PARTITION OF public.impressions
FOR VALUES FROM ('2020-05-01') TO ('2020-06-01');


--
-- Name: impressions_2020_06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2020_06 PARTITION OF public.impressions
FOR VALUES FROM ('2020-06-01') TO ('2020-07-01');


--
-- Name: impressions_2020_07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2020_07 PARTITION OF public.impressions
FOR VALUES FROM ('2020-07-01') TO ('2020-08-01');


--
-- Name: impressions_2020_08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2020_08 PARTITION OF public.impressions
FOR VALUES FROM ('2020-08-01') TO ('2020-09-01');


--
-- Name: impressions_2020_09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2020_09 PARTITION OF public.impressions
FOR VALUES FROM ('2020-09-01') TO ('2020-10-01');


--
-- Name: impressions_2020_10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2020_10 PARTITION OF public.impressions
FOR VALUES FROM ('2020-10-01') TO ('2020-11-01');


--
-- Name: impressions_2020_11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2020_11 PARTITION OF public.impressions
FOR VALUES FROM ('2020-11-01') TO ('2020-12-01');


--
-- Name: impressions_2020_12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2020_12 PARTITION OF public.impressions
FOR VALUES FROM ('2020-12-01') TO ('2021-01-01');


--
-- Name: impressions_2021_01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2021_01 PARTITION OF public.impressions
FOR VALUES FROM ('2021-01-01') TO ('2021-02-01');


--
-- Name: impressions_2021_02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2021_02 PARTITION OF public.impressions
FOR VALUES FROM ('2021-02-01') TO ('2021-03-01');


--
-- Name: impressions_2021_03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2021_03 PARTITION OF public.impressions
FOR VALUES FROM ('2021-03-01') TO ('2021-04-01');


--
-- Name: impressions_2021_04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2021_04 PARTITION OF public.impressions
FOR VALUES FROM ('2021-04-01') TO ('2021-05-01');


--
-- Name: impressions_2021_05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2021_05 PARTITION OF public.impressions
FOR VALUES FROM ('2021-05-01') TO ('2021-06-01');


--
-- Name: impressions_2021_06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2021_06 PARTITION OF public.impressions
FOR VALUES FROM ('2021-06-01') TO ('2021-07-01');


--
-- Name: impressions_2021_07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2021_07 PARTITION OF public.impressions
FOR VALUES FROM ('2021-07-01') TO ('2021-08-01');


--
-- Name: impressions_2021_08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2021_08 PARTITION OF public.impressions
FOR VALUES FROM ('2021-08-01') TO ('2021-09-01');


--
-- Name: impressions_2021_09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2021_09 PARTITION OF public.impressions
FOR VALUES FROM ('2021-09-01') TO ('2021-10-01');


--
-- Name: impressions_2021_10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2021_10 PARTITION OF public.impressions
FOR VALUES FROM ('2021-10-01') TO ('2021-11-01');


--
-- Name: impressions_2021_11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2021_11 PARTITION OF public.impressions
FOR VALUES FROM ('2021-11-01') TO ('2021-12-01');


--
-- Name: impressions_2021_12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2021_12 PARTITION OF public.impressions
FOR VALUES FROM ('2021-12-01') TO ('2022-01-01');


--
-- Name: impressions_2022_01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2022_01 PARTITION OF public.impressions
FOR VALUES FROM ('2022-01-01') TO ('2022-02-01');


--
-- Name: impressions_2022_02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2022_02 PARTITION OF public.impressions
FOR VALUES FROM ('2022-02-01') TO ('2022-03-01');


--
-- Name: impressions_2022_03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2022_03 PARTITION OF public.impressions
FOR VALUES FROM ('2022-03-01') TO ('2022-04-01');


--
-- Name: impressions_2022_04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2022_04 PARTITION OF public.impressions
FOR VALUES FROM ('2022-04-01') TO ('2022-05-01');


--
-- Name: impressions_2022_05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2022_05 PARTITION OF public.impressions
FOR VALUES FROM ('2022-05-01') TO ('2022-06-01');


--
-- Name: impressions_2022_06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2022_06 PARTITION OF public.impressions
FOR VALUES FROM ('2022-06-01') TO ('2022-07-01');


--
-- Name: impressions_2022_07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2022_07 PARTITION OF public.impressions
FOR VALUES FROM ('2022-07-01') TO ('2022-08-01');


--
-- Name: impressions_2022_08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2022_08 PARTITION OF public.impressions
FOR VALUES FROM ('2022-08-01') TO ('2022-09-01');


--
-- Name: impressions_2022_09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2022_09 PARTITION OF public.impressions
FOR VALUES FROM ('2022-09-01') TO ('2022-10-01');


--
-- Name: impressions_2022_10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2022_10 PARTITION OF public.impressions
FOR VALUES FROM ('2022-10-01') TO ('2022-11-01');


--
-- Name: impressions_2022_11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2022_11 PARTITION OF public.impressions
FOR VALUES FROM ('2022-11-01') TO ('2022-12-01');


--
-- Name: impressions_2022_12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2022_12 PARTITION OF public.impressions
FOR VALUES FROM ('2022-12-01') TO ('2023-01-01');


--
-- Name: impressions_2023_01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2023_01 PARTITION OF public.impressions
FOR VALUES FROM ('2023-01-01') TO ('2023-02-01');


--
-- Name: impressions_2023_02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2023_02 PARTITION OF public.impressions
FOR VALUES FROM ('2023-02-01') TO ('2023-03-01');


--
-- Name: impressions_2023_03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2023_03 PARTITION OF public.impressions
FOR VALUES FROM ('2023-03-01') TO ('2023-04-01');


--
-- Name: impressions_2023_04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2023_04 PARTITION OF public.impressions
FOR VALUES FROM ('2023-04-01') TO ('2023-05-01');


--
-- Name: impressions_2023_05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2023_05 PARTITION OF public.impressions
FOR VALUES FROM ('2023-05-01') TO ('2023-06-01');


--
-- Name: impressions_2023_06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2023_06 PARTITION OF public.impressions
FOR VALUES FROM ('2023-06-01') TO ('2023-07-01');


--
-- Name: impressions_2023_07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2023_07 PARTITION OF public.impressions
FOR VALUES FROM ('2023-07-01') TO ('2023-08-01');


--
-- Name: impressions_2023_08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2023_08 PARTITION OF public.impressions
FOR VALUES FROM ('2023-08-01') TO ('2023-09-01');


--
-- Name: impressions_2023_09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2023_09 PARTITION OF public.impressions
FOR VALUES FROM ('2023-09-01') TO ('2023-10-01');


--
-- Name: impressions_2023_10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2023_10 PARTITION OF public.impressions
FOR VALUES FROM ('2023-10-01') TO ('2023-11-01');


--
-- Name: impressions_2023_11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2023_11 PARTITION OF public.impressions
FOR VALUES FROM ('2023-11-01') TO ('2023-12-01');


--
-- Name: impressions_2023_12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2023_12 PARTITION OF public.impressions
FOR VALUES FROM ('2023-12-01') TO ('2024-01-01');


--
-- Name: impressions_2024_01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2024_01 PARTITION OF public.impressions
FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');


--
-- Name: impressions_2024_02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2024_02 PARTITION OF public.impressions
FOR VALUES FROM ('2024-02-01') TO ('2024-03-01');


--
-- Name: impressions_2024_03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2024_03 PARTITION OF public.impressions
FOR VALUES FROM ('2024-03-01') TO ('2024-04-01');


--
-- Name: impressions_2024_04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2024_04 PARTITION OF public.impressions
FOR VALUES FROM ('2024-04-01') TO ('2024-05-01');


--
-- Name: impressions_2024_05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2024_05 PARTITION OF public.impressions
FOR VALUES FROM ('2024-05-01') TO ('2024-06-01');


--
-- Name: impressions_2024_06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2024_06 PARTITION OF public.impressions
FOR VALUES FROM ('2024-06-01') TO ('2024-07-01');


--
-- Name: impressions_2024_07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2024_07 PARTITION OF public.impressions
FOR VALUES FROM ('2024-07-01') TO ('2024-08-01');


--
-- Name: impressions_2024_08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2024_08 PARTITION OF public.impressions
FOR VALUES FROM ('2024-08-01') TO ('2024-09-01');


--
-- Name: impressions_2024_09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2024_09 PARTITION OF public.impressions
FOR VALUES FROM ('2024-09-01') TO ('2024-10-01');


--
-- Name: impressions_2024_10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2024_10 PARTITION OF public.impressions
FOR VALUES FROM ('2024-10-01') TO ('2024-11-01');


--
-- Name: impressions_2024_11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2024_11 PARTITION OF public.impressions
FOR VALUES FROM ('2024-11-01') TO ('2024-12-01');


--
-- Name: impressions_2024_12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2024_12 PARTITION OF public.impressions
FOR VALUES FROM ('2024-12-01') TO ('2025-01-01');


--
-- Name: impressions_2025_01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2025_01 PARTITION OF public.impressions
FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');


--
-- Name: impressions_2025_02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2025_02 PARTITION OF public.impressions
FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');


--
-- Name: impressions_2025_03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2025_03 PARTITION OF public.impressions
FOR VALUES FROM ('2025-03-01') TO ('2025-04-01');


--
-- Name: impressions_2025_04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2025_04 PARTITION OF public.impressions
FOR VALUES FROM ('2025-04-01') TO ('2025-05-01');


--
-- Name: impressions_2025_05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2025_05 PARTITION OF public.impressions
FOR VALUES FROM ('2025-05-01') TO ('2025-06-01');


--
-- Name: impressions_2025_06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2025_06 PARTITION OF public.impressions
FOR VALUES FROM ('2025-06-01') TO ('2025-07-01');


--
-- Name: impressions_2025_07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2025_07 PARTITION OF public.impressions
FOR VALUES FROM ('2025-07-01') TO ('2025-08-01');


--
-- Name: impressions_2025_08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2025_08 PARTITION OF public.impressions
FOR VALUES FROM ('2025-08-01') TO ('2025-09-01');


--
-- Name: impressions_2025_09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2025_09 PARTITION OF public.impressions
FOR VALUES FROM ('2025-09-01') TO ('2025-10-01');


--
-- Name: impressions_2025_10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2025_10 PARTITION OF public.impressions
FOR VALUES FROM ('2025-10-01') TO ('2025-11-01');


--
-- Name: impressions_2025_11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2025_11 PARTITION OF public.impressions
FOR VALUES FROM ('2025-11-01') TO ('2025-12-01');


--
-- Name: impressions_2025_12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2025_12 PARTITION OF public.impressions
FOR VALUES FROM ('2025-12-01') TO ('2026-01-01');


--
-- Name: impressions_2026_01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2026_01 PARTITION OF public.impressions
FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');


--
-- Name: impressions_2026_02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2026_02 PARTITION OF public.impressions
FOR VALUES FROM ('2026-02-01') TO ('2026-03-01');


--
-- Name: impressions_2026_03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2026_03 PARTITION OF public.impressions
FOR VALUES FROM ('2026-03-01') TO ('2026-04-01');


--
-- Name: impressions_2026_04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2026_04 PARTITION OF public.impressions
FOR VALUES FROM ('2026-04-01') TO ('2026-05-01');


--
-- Name: impressions_2026_05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2026_05 PARTITION OF public.impressions
FOR VALUES FROM ('2026-05-01') TO ('2026-06-01');


--
-- Name: impressions_2026_06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2026_06 PARTITION OF public.impressions
FOR VALUES FROM ('2026-06-01') TO ('2026-07-01');


--
-- Name: impressions_2026_07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2026_07 PARTITION OF public.impressions
FOR VALUES FROM ('2026-07-01') TO ('2026-08-01');


--
-- Name: impressions_2026_08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2026_08 PARTITION OF public.impressions
FOR VALUES FROM ('2026-08-01') TO ('2026-09-01');


--
-- Name: impressions_2026_09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2026_09 PARTITION OF public.impressions
FOR VALUES FROM ('2026-09-01') TO ('2026-10-01');


--
-- Name: impressions_2026_10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2026_10 PARTITION OF public.impressions
FOR VALUES FROM ('2026-10-01') TO ('2026-11-01');


--
-- Name: impressions_2026_11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2026_11 PARTITION OF public.impressions
FOR VALUES FROM ('2026-11-01') TO ('2026-12-01');


--
-- Name: impressions_2026_12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2026_12 PARTITION OF public.impressions
FOR VALUES FROM ('2026-12-01') TO ('2027-01-01');


--
-- Name: impressions_2027_01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2027_01 PARTITION OF public.impressions
FOR VALUES FROM ('2027-01-01') TO ('2027-02-01');


--
-- Name: impressions_2027_02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2027_02 PARTITION OF public.impressions
FOR VALUES FROM ('2027-02-01') TO ('2027-03-01');


--
-- Name: impressions_2027_03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2027_03 PARTITION OF public.impressions
FOR VALUES FROM ('2027-03-01') TO ('2027-04-01');


--
-- Name: impressions_2027_04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2027_04 PARTITION OF public.impressions
FOR VALUES FROM ('2027-04-01') TO ('2027-05-01');


--
-- Name: impressions_2027_05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2027_05 PARTITION OF public.impressions
FOR VALUES FROM ('2027-05-01') TO ('2027-06-01');


--
-- Name: impressions_2027_06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2027_06 PARTITION OF public.impressions
FOR VALUES FROM ('2027-06-01') TO ('2027-07-01');


--
-- Name: impressions_2027_07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2027_07 PARTITION OF public.impressions
FOR VALUES FROM ('2027-07-01') TO ('2027-08-01');


--
-- Name: impressions_2027_08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2027_08 PARTITION OF public.impressions
FOR VALUES FROM ('2027-08-01') TO ('2027-09-01');


--
-- Name: impressions_2027_09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2027_09 PARTITION OF public.impressions
FOR VALUES FROM ('2027-09-01') TO ('2027-10-01');


--
-- Name: impressions_2027_10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2027_10 PARTITION OF public.impressions
FOR VALUES FROM ('2027-10-01') TO ('2027-11-01');


--
-- Name: impressions_2027_11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2027_11 PARTITION OF public.impressions
FOR VALUES FROM ('2027-11-01') TO ('2027-12-01');


--
-- Name: impressions_2027_12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2027_12 PARTITION OF public.impressions
FOR VALUES FROM ('2027-12-01') TO ('2028-01-01');


--
-- Name: impressions_2028_01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2028_01 PARTITION OF public.impressions
FOR VALUES FROM ('2028-01-01') TO ('2028-02-01');


--
-- Name: impressions_2028_02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2028_02 PARTITION OF public.impressions
FOR VALUES FROM ('2028-02-01') TO ('2028-03-01');


--
-- Name: impressions_2028_03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2028_03 PARTITION OF public.impressions
FOR VALUES FROM ('2028-03-01') TO ('2028-04-01');


--
-- Name: impressions_2028_04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2028_04 PARTITION OF public.impressions
FOR VALUES FROM ('2028-04-01') TO ('2028-05-01');


--
-- Name: impressions_2028_05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2028_05 PARTITION OF public.impressions
FOR VALUES FROM ('2028-05-01') TO ('2028-06-01');


--
-- Name: impressions_2028_06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2028_06 PARTITION OF public.impressions
FOR VALUES FROM ('2028-06-01') TO ('2028-07-01');


--
-- Name: impressions_2028_07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2028_07 PARTITION OF public.impressions
FOR VALUES FROM ('2028-07-01') TO ('2028-08-01');


--
-- Name: impressions_2028_08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2028_08 PARTITION OF public.impressions
FOR VALUES FROM ('2028-08-01') TO ('2028-09-01');


--
-- Name: impressions_2028_09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2028_09 PARTITION OF public.impressions
FOR VALUES FROM ('2028-09-01') TO ('2028-10-01');


--
-- Name: impressions_2028_10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2028_10 PARTITION OF public.impressions
FOR VALUES FROM ('2028-10-01') TO ('2028-11-01');


--
-- Name: impressions_2028_11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2028_11 PARTITION OF public.impressions
FOR VALUES FROM ('2028-11-01') TO ('2028-12-01');


--
-- Name: impressions_2028_12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2028_12 PARTITION OF public.impressions
FOR VALUES FROM ('2028-12-01') TO ('2029-01-01');


--
-- Name: impressions_2029_01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2029_01 PARTITION OF public.impressions
FOR VALUES FROM ('2029-01-01') TO ('2029-02-01');


--
-- Name: impressions_2029_02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2029_02 PARTITION OF public.impressions
FOR VALUES FROM ('2029-02-01') TO ('2029-03-01');


--
-- Name: impressions_2029_03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2029_03 PARTITION OF public.impressions
FOR VALUES FROM ('2029-03-01') TO ('2029-04-01');


--
-- Name: impressions_2029_04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2029_04 PARTITION OF public.impressions
FOR VALUES FROM ('2029-04-01') TO ('2029-05-01');


--
-- Name: impressions_2029_05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2029_05 PARTITION OF public.impressions
FOR VALUES FROM ('2029-05-01') TO ('2029-06-01');


--
-- Name: impressions_2029_06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2029_06 PARTITION OF public.impressions
FOR VALUES FROM ('2029-06-01') TO ('2029-07-01');


--
-- Name: impressions_2029_07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2029_07 PARTITION OF public.impressions
FOR VALUES FROM ('2029-07-01') TO ('2029-08-01');


--
-- Name: impressions_2029_08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2029_08 PARTITION OF public.impressions
FOR VALUES FROM ('2029-08-01') TO ('2029-09-01');


--
-- Name: impressions_2029_09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2029_09 PARTITION OF public.impressions
FOR VALUES FROM ('2029-09-01') TO ('2029-10-01');


--
-- Name: impressions_2029_10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2029_10 PARTITION OF public.impressions
FOR VALUES FROM ('2029-10-01') TO ('2029-11-01');


--
-- Name: impressions_2029_11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2029_11 PARTITION OF public.impressions
FOR VALUES FROM ('2029-11-01') TO ('2029-12-01');


--
-- Name: impressions_2029_12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2029_12 PARTITION OF public.impressions
FOR VALUES FROM ('2029-12-01') TO ('2030-01-01');


--
-- Name: impressions_2030_01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2030_01 PARTITION OF public.impressions
FOR VALUES FROM ('2030-01-01') TO ('2030-02-01');


--
-- Name: impressions_2030_02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2030_02 PARTITION OF public.impressions
FOR VALUES FROM ('2030-02-01') TO ('2030-03-01');


--
-- Name: impressions_2030_03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2030_03 PARTITION OF public.impressions
FOR VALUES FROM ('2030-03-01') TO ('2030-04-01');


--
-- Name: impressions_2030_04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2030_04 PARTITION OF public.impressions
FOR VALUES FROM ('2030-04-01') TO ('2030-05-01');


--
-- Name: impressions_2030_05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2030_05 PARTITION OF public.impressions
FOR VALUES FROM ('2030-05-01') TO ('2030-06-01');


--
-- Name: impressions_2030_06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2030_06 PARTITION OF public.impressions
FOR VALUES FROM ('2030-06-01') TO ('2030-07-01');


--
-- Name: impressions_2030_07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2030_07 PARTITION OF public.impressions
FOR VALUES FROM ('2030-07-01') TO ('2030-08-01');


--
-- Name: impressions_2030_08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2030_08 PARTITION OF public.impressions
FOR VALUES FROM ('2030-08-01') TO ('2030-09-01');


--
-- Name: impressions_2030_09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2030_09 PARTITION OF public.impressions
FOR VALUES FROM ('2030-09-01') TO ('2030-10-01');


--
-- Name: impressions_2030_10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2030_10 PARTITION OF public.impressions
FOR VALUES FROM ('2030-10-01') TO ('2030-11-01');


--
-- Name: impressions_2030_11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2030_11 PARTITION OF public.impressions
FOR VALUES FROM ('2030-11-01') TO ('2030-12-01');


--
-- Name: impressions_2030_12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2030_12 PARTITION OF public.impressions
FOR VALUES FROM ('2030-12-01') TO ('2031-01-01');


--
-- Name: impressions_default; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_default PARTITION OF public.impressions
DEFAULT;


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
    prohibited_advertisers bigint[] DEFAULT '{}'::bigint[],
    prohibit_fallback_campaigns boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
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
    updated_at timestamp without time zone NOT NULL
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
-- Name: creative_images id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creative_images ALTER COLUMN id SET DEFAULT nextval('public.creative_images_id_seq'::regclass);


--
-- Name: creatives id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creatives ALTER COLUMN id SET DEFAULT nextval('public.creatives_id_seq'::regclass);


--
-- Name: impressions_2018_11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2019_01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_01 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2019_01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_01 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2019_01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_01 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2019_02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_02 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2019_02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_02 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2019_02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_02 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2019_03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_03 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2019_03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_03 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2019_03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_03 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2019_04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_04 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2019_04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_04 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2019_04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_04 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2019_05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_05 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2019_05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_05 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2019_05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_05 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2019_06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_06 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2019_06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_06 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2019_06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_06 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2019_07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_07 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2019_07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_07 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2019_07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_07 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2019_08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_08 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2019_08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_08 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2019_08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_08 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2019_09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_09 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2019_09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_09 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2019_09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_09 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2019_10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_10 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2019_10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_10 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2019_10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_10 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2019_11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_11 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2019_11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_11 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2019_11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_11 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2019_12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_12 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2019_12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_12 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2019_12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_12 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2020_01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_01 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2020_01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_01 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2020_01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_01 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2020_02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_02 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2020_02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_02 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2020_02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_02 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2020_03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_03 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2020_03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_03 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2020_03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_03 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2020_04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_04 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2020_04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_04 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2020_04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_04 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2020_05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_05 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2020_05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_05 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2020_05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_05 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2020_06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_06 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2020_06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_06 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2020_06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_06 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2020_07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_07 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2020_07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_07 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2020_07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_07 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2020_08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_08 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2020_08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_08 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2020_08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_08 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2020_09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_09 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2020_09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_09 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2020_09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_09 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2020_10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_10 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2020_10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_10 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2020_10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_10 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2020_11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_11 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2020_11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_11 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2020_11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_11 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2020_12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_12 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2020_12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_12 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2020_12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_12 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2021_01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_01 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2021_01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_01 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2021_01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_01 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2021_02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_02 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2021_02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_02 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2021_02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_02 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2021_03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_03 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2021_03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_03 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2021_03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_03 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2021_04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_04 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2021_04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_04 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2021_04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_04 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2021_05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_05 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2021_05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_05 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2021_05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_05 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2021_06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_06 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2021_06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_06 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2021_06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_06 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2021_07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_07 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2021_07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_07 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2021_07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_07 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2021_08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_08 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2021_08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_08 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2021_08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_08 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2021_09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_09 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2021_09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_09 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2021_09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_09 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2021_10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_10 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2021_10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_10 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2021_10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_10 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2021_11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_11 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2021_11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_11 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2021_11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_11 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2021_12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_12 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2021_12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_12 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2021_12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_12 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2022_01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_01 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2022_01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_01 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2022_01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_01 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2022_02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_02 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2022_02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_02 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2022_02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_02 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2022_03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_03 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2022_03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_03 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2022_03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_03 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2022_04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_04 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2022_04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_04 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2022_04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_04 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2022_05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_05 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2022_05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_05 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2022_05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_05 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2022_06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_06 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2022_06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_06 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2022_06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_06 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2022_07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_07 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2022_07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_07 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2022_07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_07 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2022_08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_08 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2022_08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_08 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2022_08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_08 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2022_09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_09 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2022_09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_09 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2022_09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_09 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2022_10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_10 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2022_10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_10 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2022_10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_10 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2022_11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_11 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2022_11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_11 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2022_11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_11 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2022_12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_12 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2022_12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_12 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2022_12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_12 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2023_01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_01 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2023_01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_01 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2023_01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_01 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2023_02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_02 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2023_02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_02 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2023_02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_02 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2023_03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_03 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2023_03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_03 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2023_03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_03 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2023_04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_04 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2023_04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_04 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2023_04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_04 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2023_05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_05 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2023_05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_05 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2023_05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_05 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2023_06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_06 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2023_06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_06 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2023_06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_06 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2023_07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_07 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2023_07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_07 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2023_07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_07 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2023_08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_08 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2023_08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_08 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2023_08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_08 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2023_09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_09 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2023_09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_09 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2023_09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_09 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2023_10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_10 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2023_10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_10 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2023_10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_10 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2023_11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_11 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2023_11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_11 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2023_11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_11 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2023_12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_12 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2023_12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_12 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2023_12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_12 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2024_01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_01 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2024_01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_01 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2024_01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_01 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2024_02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_02 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2024_02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_02 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2024_02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_02 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2024_03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_03 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2024_03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_03 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2024_03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_03 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2024_04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_04 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2024_04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_04 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2024_04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_04 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2024_05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_05 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2024_05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_05 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2024_05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_05 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2024_06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_06 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2024_06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_06 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2024_06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_06 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2024_07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_07 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2024_07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_07 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2024_07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_07 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2024_08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_08 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2024_08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_08 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2024_08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_08 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2024_09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_09 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2024_09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_09 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2024_09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_09 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2024_10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_10 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2024_10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_10 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2024_10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_10 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2024_11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_11 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2024_11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_11 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2024_11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_11 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2024_12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_12 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2024_12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_12 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2024_12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_12 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2025_01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_01 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2025_01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_01 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2025_01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_01 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2025_02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_02 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2025_02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_02 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2025_02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_02 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2025_03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_03 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2025_03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_03 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2025_03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_03 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2025_04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_04 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2025_04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_04 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2025_04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_04 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2025_05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_05 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2025_05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_05 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2025_05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_05 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2025_06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_06 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2025_06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_06 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2025_06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_06 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2025_07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_07 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2025_07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_07 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2025_07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_07 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2025_08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_08 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2025_08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_08 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2025_08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_08 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2025_09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_09 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2025_09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_09 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2025_09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_09 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2025_10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_10 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2025_10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_10 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2025_10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_10 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2025_11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_11 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2025_11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_11 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2025_11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_11 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2025_12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_12 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2025_12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_12 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2025_12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_12 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2026_01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_01 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2026_01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_01 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2026_01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_01 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2026_02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_02 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2026_02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_02 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2026_02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_02 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2026_03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_03 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2026_03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_03 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2026_03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_03 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2026_04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_04 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2026_04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_04 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2026_04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_04 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2026_05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_05 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2026_05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_05 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2026_05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_05 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2026_06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_06 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2026_06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_06 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2026_06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_06 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2026_07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_07 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2026_07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_07 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2026_07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_07 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2026_08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_08 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2026_08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_08 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2026_08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_08 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2026_09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_09 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2026_09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_09 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2026_09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_09 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2026_10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_10 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2026_10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_10 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2026_10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_10 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2026_11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_11 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2026_11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_11 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2026_11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_11 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2026_12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_12 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2026_12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_12 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2026_12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_12 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2027_01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_01 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2027_01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_01 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2027_01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_01 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2027_02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_02 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2027_02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_02 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2027_02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_02 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2027_03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_03 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2027_03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_03 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2027_03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_03 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2027_04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_04 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2027_04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_04 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2027_04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_04 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2027_05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_05 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2027_05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_05 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2027_05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_05 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2027_06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_06 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2027_06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_06 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2027_06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_06 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2027_07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_07 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2027_07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_07 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2027_07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_07 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2027_08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_08 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2027_08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_08 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2027_08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_08 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2027_09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_09 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2027_09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_09 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2027_09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_09 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2027_10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_10 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2027_10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_10 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2027_10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_10 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2027_11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_11 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2027_11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_11 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2027_11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_11 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2027_12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_12 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2027_12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_12 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2027_12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_12 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2028_01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_01 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2028_01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_01 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2028_01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_01 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2028_02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_02 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2028_02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_02 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2028_02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_02 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2028_03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_03 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2028_03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_03 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2028_03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_03 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2028_04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_04 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2028_04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_04 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2028_04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_04 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2028_05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_05 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2028_05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_05 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2028_05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_05 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2028_06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_06 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2028_06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_06 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2028_06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_06 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2028_07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_07 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2028_07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_07 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2028_07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_07 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2028_08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_08 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2028_08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_08 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2028_08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_08 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2028_09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_09 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2028_09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_09 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2028_09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_09 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2028_10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_10 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2028_10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_10 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2028_10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_10 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2028_11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_11 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2028_11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_11 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2028_11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_11 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2028_12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_12 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2028_12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_12 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2028_12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_12 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2029_01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_01 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2029_01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_01 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2029_01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_01 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2029_02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_02 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2029_02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_02 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2029_02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_02 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2029_03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_03 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2029_03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_03 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2029_03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_03 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2029_04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_04 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2029_04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_04 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2029_04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_04 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2029_05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_05 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2029_05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_05 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2029_05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_05 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2029_06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_06 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2029_06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_06 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2029_06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_06 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2029_07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_07 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2029_07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_07 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2029_07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_07 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2029_08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_08 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2029_08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_08 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2029_08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_08 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2029_09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_09 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2029_09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_09 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2029_09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_09 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2029_10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_10 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2029_10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_10 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2029_10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_10 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2029_11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_11 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2029_11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_11 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2029_11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_11 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2029_12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_12 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2029_12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_12 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2029_12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_12 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2030_01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_01 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2030_01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_01 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2030_01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_01 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2030_02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_02 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2030_02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_02 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2030_02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_02 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2030_03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_03 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2030_03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_03 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2030_03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_03 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2030_04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_04 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2030_04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_04 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2030_04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_04 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2030_05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_05 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2030_05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_05 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2030_05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_05 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2030_06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_06 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2030_06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_06 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2030_06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_06 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2030_07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_07 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2030_07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_07 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2030_07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_07 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2030_08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_08 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2030_08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_08 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2030_08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_08 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2030_09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_09 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2030_09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_09 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2030_09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_09 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2030_10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_10 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2030_10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_10 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2030_10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_10 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2030_11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_11 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2030_11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_11 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2030_11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_11 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2030_12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_12 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2030_12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_12 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2030_12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_12 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_default id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_default ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_default payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_default ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_default fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_default ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: properties id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.properties ALTER COLUMN id SET DEFAULT nextval('public.properties_id_seq'::regclass);


--
-- Name: publisher_invoices id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publisher_invoices ALTER COLUMN id SET DEFAULT nextval('public.publisher_invoices_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


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
-- Name: impressions_2018_11 impressions_2018_11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11
    ADD CONSTRAINT impressions_2018_11_pkey PRIMARY KEY (id);


--
-- Name: impressions_2018_12 impressions_2018_12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12
    ADD CONSTRAINT impressions_2018_12_pkey PRIMARY KEY (id);


--
-- Name: impressions_2019_01 impressions_2019_01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_01
    ADD CONSTRAINT impressions_2019_01_pkey PRIMARY KEY (id);


--
-- Name: impressions_2019_02 impressions_2019_02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_02
    ADD CONSTRAINT impressions_2019_02_pkey PRIMARY KEY (id);


--
-- Name: impressions_2019_03 impressions_2019_03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_03
    ADD CONSTRAINT impressions_2019_03_pkey PRIMARY KEY (id);


--
-- Name: impressions_2019_04 impressions_2019_04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_04
    ADD CONSTRAINT impressions_2019_04_pkey PRIMARY KEY (id);


--
-- Name: impressions_2019_05 impressions_2019_05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_05
    ADD CONSTRAINT impressions_2019_05_pkey PRIMARY KEY (id);


--
-- Name: impressions_2019_06 impressions_2019_06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_06
    ADD CONSTRAINT impressions_2019_06_pkey PRIMARY KEY (id);


--
-- Name: impressions_2019_07 impressions_2019_07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_07
    ADD CONSTRAINT impressions_2019_07_pkey PRIMARY KEY (id);


--
-- Name: impressions_2019_08 impressions_2019_08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_08
    ADD CONSTRAINT impressions_2019_08_pkey PRIMARY KEY (id);


--
-- Name: impressions_2019_09 impressions_2019_09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_09
    ADD CONSTRAINT impressions_2019_09_pkey PRIMARY KEY (id);


--
-- Name: impressions_2019_10 impressions_2019_10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_10
    ADD CONSTRAINT impressions_2019_10_pkey PRIMARY KEY (id);


--
-- Name: impressions_2019_11 impressions_2019_11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_11
    ADD CONSTRAINT impressions_2019_11_pkey PRIMARY KEY (id);


--
-- Name: impressions_2019_12 impressions_2019_12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2019_12
    ADD CONSTRAINT impressions_2019_12_pkey PRIMARY KEY (id);


--
-- Name: impressions_2020_01 impressions_2020_01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_01
    ADD CONSTRAINT impressions_2020_01_pkey PRIMARY KEY (id);


--
-- Name: impressions_2020_02 impressions_2020_02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_02
    ADD CONSTRAINT impressions_2020_02_pkey PRIMARY KEY (id);


--
-- Name: impressions_2020_03 impressions_2020_03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_03
    ADD CONSTRAINT impressions_2020_03_pkey PRIMARY KEY (id);


--
-- Name: impressions_2020_04 impressions_2020_04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_04
    ADD CONSTRAINT impressions_2020_04_pkey PRIMARY KEY (id);


--
-- Name: impressions_2020_05 impressions_2020_05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_05
    ADD CONSTRAINT impressions_2020_05_pkey PRIMARY KEY (id);


--
-- Name: impressions_2020_06 impressions_2020_06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_06
    ADD CONSTRAINT impressions_2020_06_pkey PRIMARY KEY (id);


--
-- Name: impressions_2020_07 impressions_2020_07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_07
    ADD CONSTRAINT impressions_2020_07_pkey PRIMARY KEY (id);


--
-- Name: impressions_2020_08 impressions_2020_08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_08
    ADD CONSTRAINT impressions_2020_08_pkey PRIMARY KEY (id);


--
-- Name: impressions_2020_09 impressions_2020_09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_09
    ADD CONSTRAINT impressions_2020_09_pkey PRIMARY KEY (id);


--
-- Name: impressions_2020_10 impressions_2020_10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_10
    ADD CONSTRAINT impressions_2020_10_pkey PRIMARY KEY (id);


--
-- Name: impressions_2020_11 impressions_2020_11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_11
    ADD CONSTRAINT impressions_2020_11_pkey PRIMARY KEY (id);


--
-- Name: impressions_2020_12 impressions_2020_12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2020_12
    ADD CONSTRAINT impressions_2020_12_pkey PRIMARY KEY (id);


--
-- Name: impressions_2021_01 impressions_2021_01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_01
    ADD CONSTRAINT impressions_2021_01_pkey PRIMARY KEY (id);


--
-- Name: impressions_2021_02 impressions_2021_02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_02
    ADD CONSTRAINT impressions_2021_02_pkey PRIMARY KEY (id);


--
-- Name: impressions_2021_03 impressions_2021_03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_03
    ADD CONSTRAINT impressions_2021_03_pkey PRIMARY KEY (id);


--
-- Name: impressions_2021_04 impressions_2021_04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_04
    ADD CONSTRAINT impressions_2021_04_pkey PRIMARY KEY (id);


--
-- Name: impressions_2021_05 impressions_2021_05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_05
    ADD CONSTRAINT impressions_2021_05_pkey PRIMARY KEY (id);


--
-- Name: impressions_2021_06 impressions_2021_06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_06
    ADD CONSTRAINT impressions_2021_06_pkey PRIMARY KEY (id);


--
-- Name: impressions_2021_07 impressions_2021_07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_07
    ADD CONSTRAINT impressions_2021_07_pkey PRIMARY KEY (id);


--
-- Name: impressions_2021_08 impressions_2021_08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_08
    ADD CONSTRAINT impressions_2021_08_pkey PRIMARY KEY (id);


--
-- Name: impressions_2021_09 impressions_2021_09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_09
    ADD CONSTRAINT impressions_2021_09_pkey PRIMARY KEY (id);


--
-- Name: impressions_2021_10 impressions_2021_10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_10
    ADD CONSTRAINT impressions_2021_10_pkey PRIMARY KEY (id);


--
-- Name: impressions_2021_11 impressions_2021_11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_11
    ADD CONSTRAINT impressions_2021_11_pkey PRIMARY KEY (id);


--
-- Name: impressions_2021_12 impressions_2021_12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2021_12
    ADD CONSTRAINT impressions_2021_12_pkey PRIMARY KEY (id);


--
-- Name: impressions_2022_01 impressions_2022_01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_01
    ADD CONSTRAINT impressions_2022_01_pkey PRIMARY KEY (id);


--
-- Name: impressions_2022_02 impressions_2022_02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_02
    ADD CONSTRAINT impressions_2022_02_pkey PRIMARY KEY (id);


--
-- Name: impressions_2022_03 impressions_2022_03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_03
    ADD CONSTRAINT impressions_2022_03_pkey PRIMARY KEY (id);


--
-- Name: impressions_2022_04 impressions_2022_04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_04
    ADD CONSTRAINT impressions_2022_04_pkey PRIMARY KEY (id);


--
-- Name: impressions_2022_05 impressions_2022_05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_05
    ADD CONSTRAINT impressions_2022_05_pkey PRIMARY KEY (id);


--
-- Name: impressions_2022_06 impressions_2022_06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_06
    ADD CONSTRAINT impressions_2022_06_pkey PRIMARY KEY (id);


--
-- Name: impressions_2022_07 impressions_2022_07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_07
    ADD CONSTRAINT impressions_2022_07_pkey PRIMARY KEY (id);


--
-- Name: impressions_2022_08 impressions_2022_08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_08
    ADD CONSTRAINT impressions_2022_08_pkey PRIMARY KEY (id);


--
-- Name: impressions_2022_09 impressions_2022_09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_09
    ADD CONSTRAINT impressions_2022_09_pkey PRIMARY KEY (id);


--
-- Name: impressions_2022_10 impressions_2022_10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_10
    ADD CONSTRAINT impressions_2022_10_pkey PRIMARY KEY (id);


--
-- Name: impressions_2022_11 impressions_2022_11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_11
    ADD CONSTRAINT impressions_2022_11_pkey PRIMARY KEY (id);


--
-- Name: impressions_2022_12 impressions_2022_12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2022_12
    ADD CONSTRAINT impressions_2022_12_pkey PRIMARY KEY (id);


--
-- Name: impressions_2023_01 impressions_2023_01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_01
    ADD CONSTRAINT impressions_2023_01_pkey PRIMARY KEY (id);


--
-- Name: impressions_2023_02 impressions_2023_02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_02
    ADD CONSTRAINT impressions_2023_02_pkey PRIMARY KEY (id);


--
-- Name: impressions_2023_03 impressions_2023_03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_03
    ADD CONSTRAINT impressions_2023_03_pkey PRIMARY KEY (id);


--
-- Name: impressions_2023_04 impressions_2023_04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_04
    ADD CONSTRAINT impressions_2023_04_pkey PRIMARY KEY (id);


--
-- Name: impressions_2023_05 impressions_2023_05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_05
    ADD CONSTRAINT impressions_2023_05_pkey PRIMARY KEY (id);


--
-- Name: impressions_2023_06 impressions_2023_06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_06
    ADD CONSTRAINT impressions_2023_06_pkey PRIMARY KEY (id);


--
-- Name: impressions_2023_07 impressions_2023_07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_07
    ADD CONSTRAINT impressions_2023_07_pkey PRIMARY KEY (id);


--
-- Name: impressions_2023_08 impressions_2023_08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_08
    ADD CONSTRAINT impressions_2023_08_pkey PRIMARY KEY (id);


--
-- Name: impressions_2023_09 impressions_2023_09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_09
    ADD CONSTRAINT impressions_2023_09_pkey PRIMARY KEY (id);


--
-- Name: impressions_2023_10 impressions_2023_10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_10
    ADD CONSTRAINT impressions_2023_10_pkey PRIMARY KEY (id);


--
-- Name: impressions_2023_11 impressions_2023_11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_11
    ADD CONSTRAINT impressions_2023_11_pkey PRIMARY KEY (id);


--
-- Name: impressions_2023_12 impressions_2023_12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2023_12
    ADD CONSTRAINT impressions_2023_12_pkey PRIMARY KEY (id);


--
-- Name: impressions_2024_01 impressions_2024_01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_01
    ADD CONSTRAINT impressions_2024_01_pkey PRIMARY KEY (id);


--
-- Name: impressions_2024_02 impressions_2024_02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_02
    ADD CONSTRAINT impressions_2024_02_pkey PRIMARY KEY (id);


--
-- Name: impressions_2024_03 impressions_2024_03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_03
    ADD CONSTRAINT impressions_2024_03_pkey PRIMARY KEY (id);


--
-- Name: impressions_2024_04 impressions_2024_04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_04
    ADD CONSTRAINT impressions_2024_04_pkey PRIMARY KEY (id);


--
-- Name: impressions_2024_05 impressions_2024_05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_05
    ADD CONSTRAINT impressions_2024_05_pkey PRIMARY KEY (id);


--
-- Name: impressions_2024_06 impressions_2024_06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_06
    ADD CONSTRAINT impressions_2024_06_pkey PRIMARY KEY (id);


--
-- Name: impressions_2024_07 impressions_2024_07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_07
    ADD CONSTRAINT impressions_2024_07_pkey PRIMARY KEY (id);


--
-- Name: impressions_2024_08 impressions_2024_08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_08
    ADD CONSTRAINT impressions_2024_08_pkey PRIMARY KEY (id);


--
-- Name: impressions_2024_09 impressions_2024_09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_09
    ADD CONSTRAINT impressions_2024_09_pkey PRIMARY KEY (id);


--
-- Name: impressions_2024_10 impressions_2024_10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_10
    ADD CONSTRAINT impressions_2024_10_pkey PRIMARY KEY (id);


--
-- Name: impressions_2024_11 impressions_2024_11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_11
    ADD CONSTRAINT impressions_2024_11_pkey PRIMARY KEY (id);


--
-- Name: impressions_2024_12 impressions_2024_12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2024_12
    ADD CONSTRAINT impressions_2024_12_pkey PRIMARY KEY (id);


--
-- Name: impressions_2025_01 impressions_2025_01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_01
    ADD CONSTRAINT impressions_2025_01_pkey PRIMARY KEY (id);


--
-- Name: impressions_2025_02 impressions_2025_02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_02
    ADD CONSTRAINT impressions_2025_02_pkey PRIMARY KEY (id);


--
-- Name: impressions_2025_03 impressions_2025_03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_03
    ADD CONSTRAINT impressions_2025_03_pkey PRIMARY KEY (id);


--
-- Name: impressions_2025_04 impressions_2025_04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_04
    ADD CONSTRAINT impressions_2025_04_pkey PRIMARY KEY (id);


--
-- Name: impressions_2025_05 impressions_2025_05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_05
    ADD CONSTRAINT impressions_2025_05_pkey PRIMARY KEY (id);


--
-- Name: impressions_2025_06 impressions_2025_06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_06
    ADD CONSTRAINT impressions_2025_06_pkey PRIMARY KEY (id);


--
-- Name: impressions_2025_07 impressions_2025_07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_07
    ADD CONSTRAINT impressions_2025_07_pkey PRIMARY KEY (id);


--
-- Name: impressions_2025_08 impressions_2025_08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_08
    ADD CONSTRAINT impressions_2025_08_pkey PRIMARY KEY (id);


--
-- Name: impressions_2025_09 impressions_2025_09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_09
    ADD CONSTRAINT impressions_2025_09_pkey PRIMARY KEY (id);


--
-- Name: impressions_2025_10 impressions_2025_10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_10
    ADD CONSTRAINT impressions_2025_10_pkey PRIMARY KEY (id);


--
-- Name: impressions_2025_11 impressions_2025_11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_11
    ADD CONSTRAINT impressions_2025_11_pkey PRIMARY KEY (id);


--
-- Name: impressions_2025_12 impressions_2025_12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2025_12
    ADD CONSTRAINT impressions_2025_12_pkey PRIMARY KEY (id);


--
-- Name: impressions_2026_01 impressions_2026_01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_01
    ADD CONSTRAINT impressions_2026_01_pkey PRIMARY KEY (id);


--
-- Name: impressions_2026_02 impressions_2026_02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_02
    ADD CONSTRAINT impressions_2026_02_pkey PRIMARY KEY (id);


--
-- Name: impressions_2026_03 impressions_2026_03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_03
    ADD CONSTRAINT impressions_2026_03_pkey PRIMARY KEY (id);


--
-- Name: impressions_2026_04 impressions_2026_04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_04
    ADD CONSTRAINT impressions_2026_04_pkey PRIMARY KEY (id);


--
-- Name: impressions_2026_05 impressions_2026_05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_05
    ADD CONSTRAINT impressions_2026_05_pkey PRIMARY KEY (id);


--
-- Name: impressions_2026_06 impressions_2026_06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_06
    ADD CONSTRAINT impressions_2026_06_pkey PRIMARY KEY (id);


--
-- Name: impressions_2026_07 impressions_2026_07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_07
    ADD CONSTRAINT impressions_2026_07_pkey PRIMARY KEY (id);


--
-- Name: impressions_2026_08 impressions_2026_08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_08
    ADD CONSTRAINT impressions_2026_08_pkey PRIMARY KEY (id);


--
-- Name: impressions_2026_09 impressions_2026_09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_09
    ADD CONSTRAINT impressions_2026_09_pkey PRIMARY KEY (id);


--
-- Name: impressions_2026_10 impressions_2026_10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_10
    ADD CONSTRAINT impressions_2026_10_pkey PRIMARY KEY (id);


--
-- Name: impressions_2026_11 impressions_2026_11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_11
    ADD CONSTRAINT impressions_2026_11_pkey PRIMARY KEY (id);


--
-- Name: impressions_2026_12 impressions_2026_12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2026_12
    ADD CONSTRAINT impressions_2026_12_pkey PRIMARY KEY (id);


--
-- Name: impressions_2027_01 impressions_2027_01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_01
    ADD CONSTRAINT impressions_2027_01_pkey PRIMARY KEY (id);


--
-- Name: impressions_2027_02 impressions_2027_02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_02
    ADD CONSTRAINT impressions_2027_02_pkey PRIMARY KEY (id);


--
-- Name: impressions_2027_03 impressions_2027_03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_03
    ADD CONSTRAINT impressions_2027_03_pkey PRIMARY KEY (id);


--
-- Name: impressions_2027_04 impressions_2027_04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_04
    ADD CONSTRAINT impressions_2027_04_pkey PRIMARY KEY (id);


--
-- Name: impressions_2027_05 impressions_2027_05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_05
    ADD CONSTRAINT impressions_2027_05_pkey PRIMARY KEY (id);


--
-- Name: impressions_2027_06 impressions_2027_06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_06
    ADD CONSTRAINT impressions_2027_06_pkey PRIMARY KEY (id);


--
-- Name: impressions_2027_07 impressions_2027_07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_07
    ADD CONSTRAINT impressions_2027_07_pkey PRIMARY KEY (id);


--
-- Name: impressions_2027_08 impressions_2027_08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_08
    ADD CONSTRAINT impressions_2027_08_pkey PRIMARY KEY (id);


--
-- Name: impressions_2027_09 impressions_2027_09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_09
    ADD CONSTRAINT impressions_2027_09_pkey PRIMARY KEY (id);


--
-- Name: impressions_2027_10 impressions_2027_10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_10
    ADD CONSTRAINT impressions_2027_10_pkey PRIMARY KEY (id);


--
-- Name: impressions_2027_11 impressions_2027_11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_11
    ADD CONSTRAINT impressions_2027_11_pkey PRIMARY KEY (id);


--
-- Name: impressions_2027_12 impressions_2027_12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2027_12
    ADD CONSTRAINT impressions_2027_12_pkey PRIMARY KEY (id);


--
-- Name: impressions_2028_01 impressions_2028_01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_01
    ADD CONSTRAINT impressions_2028_01_pkey PRIMARY KEY (id);


--
-- Name: impressions_2028_02 impressions_2028_02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_02
    ADD CONSTRAINT impressions_2028_02_pkey PRIMARY KEY (id);


--
-- Name: impressions_2028_03 impressions_2028_03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_03
    ADD CONSTRAINT impressions_2028_03_pkey PRIMARY KEY (id);


--
-- Name: impressions_2028_04 impressions_2028_04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_04
    ADD CONSTRAINT impressions_2028_04_pkey PRIMARY KEY (id);


--
-- Name: impressions_2028_05 impressions_2028_05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_05
    ADD CONSTRAINT impressions_2028_05_pkey PRIMARY KEY (id);


--
-- Name: impressions_2028_06 impressions_2028_06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_06
    ADD CONSTRAINT impressions_2028_06_pkey PRIMARY KEY (id);


--
-- Name: impressions_2028_07 impressions_2028_07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_07
    ADD CONSTRAINT impressions_2028_07_pkey PRIMARY KEY (id);


--
-- Name: impressions_2028_08 impressions_2028_08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_08
    ADD CONSTRAINT impressions_2028_08_pkey PRIMARY KEY (id);


--
-- Name: impressions_2028_09 impressions_2028_09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_09
    ADD CONSTRAINT impressions_2028_09_pkey PRIMARY KEY (id);


--
-- Name: impressions_2028_10 impressions_2028_10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_10
    ADD CONSTRAINT impressions_2028_10_pkey PRIMARY KEY (id);


--
-- Name: impressions_2028_11 impressions_2028_11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_11
    ADD CONSTRAINT impressions_2028_11_pkey PRIMARY KEY (id);


--
-- Name: impressions_2028_12 impressions_2028_12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2028_12
    ADD CONSTRAINT impressions_2028_12_pkey PRIMARY KEY (id);


--
-- Name: impressions_2029_01 impressions_2029_01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_01
    ADD CONSTRAINT impressions_2029_01_pkey PRIMARY KEY (id);


--
-- Name: impressions_2029_02 impressions_2029_02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_02
    ADD CONSTRAINT impressions_2029_02_pkey PRIMARY KEY (id);


--
-- Name: impressions_2029_03 impressions_2029_03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_03
    ADD CONSTRAINT impressions_2029_03_pkey PRIMARY KEY (id);


--
-- Name: impressions_2029_04 impressions_2029_04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_04
    ADD CONSTRAINT impressions_2029_04_pkey PRIMARY KEY (id);


--
-- Name: impressions_2029_05 impressions_2029_05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_05
    ADD CONSTRAINT impressions_2029_05_pkey PRIMARY KEY (id);


--
-- Name: impressions_2029_06 impressions_2029_06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_06
    ADD CONSTRAINT impressions_2029_06_pkey PRIMARY KEY (id);


--
-- Name: impressions_2029_07 impressions_2029_07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_07
    ADD CONSTRAINT impressions_2029_07_pkey PRIMARY KEY (id);


--
-- Name: impressions_2029_08 impressions_2029_08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_08
    ADD CONSTRAINT impressions_2029_08_pkey PRIMARY KEY (id);


--
-- Name: impressions_2029_09 impressions_2029_09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_09
    ADD CONSTRAINT impressions_2029_09_pkey PRIMARY KEY (id);


--
-- Name: impressions_2029_10 impressions_2029_10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_10
    ADD CONSTRAINT impressions_2029_10_pkey PRIMARY KEY (id);


--
-- Name: impressions_2029_11 impressions_2029_11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_11
    ADD CONSTRAINT impressions_2029_11_pkey PRIMARY KEY (id);


--
-- Name: impressions_2029_12 impressions_2029_12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2029_12
    ADD CONSTRAINT impressions_2029_12_pkey PRIMARY KEY (id);


--
-- Name: impressions_2030_01 impressions_2030_01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_01
    ADD CONSTRAINT impressions_2030_01_pkey PRIMARY KEY (id);


--
-- Name: impressions_2030_02 impressions_2030_02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_02
    ADD CONSTRAINT impressions_2030_02_pkey PRIMARY KEY (id);


--
-- Name: impressions_2030_03 impressions_2030_03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_03
    ADD CONSTRAINT impressions_2030_03_pkey PRIMARY KEY (id);


--
-- Name: impressions_2030_04 impressions_2030_04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_04
    ADD CONSTRAINT impressions_2030_04_pkey PRIMARY KEY (id);


--
-- Name: impressions_2030_05 impressions_2030_05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_05
    ADD CONSTRAINT impressions_2030_05_pkey PRIMARY KEY (id);


--
-- Name: impressions_2030_06 impressions_2030_06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_06
    ADD CONSTRAINT impressions_2030_06_pkey PRIMARY KEY (id);


--
-- Name: impressions_2030_07 impressions_2030_07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_07
    ADD CONSTRAINT impressions_2030_07_pkey PRIMARY KEY (id);


--
-- Name: impressions_2030_08 impressions_2030_08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_08
    ADD CONSTRAINT impressions_2030_08_pkey PRIMARY KEY (id);


--
-- Name: impressions_2030_09 impressions_2030_09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_09
    ADD CONSTRAINT impressions_2030_09_pkey PRIMARY KEY (id);


--
-- Name: impressions_2030_10 impressions_2030_10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_10
    ADD CONSTRAINT impressions_2030_10_pkey PRIMARY KEY (id);


--
-- Name: impressions_2030_11 impressions_2030_11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_11
    ADD CONSTRAINT impressions_2030_11_pkey PRIMARY KEY (id);


--
-- Name: impressions_2030_12 impressions_2030_12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2030_12
    ADD CONSTRAINT impressions_2030_12_pkey PRIMARY KEY (id);


--
-- Name: properties properties_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.properties
    ADD CONSTRAINT properties_pkey PRIMARY KEY (id);


--
-- Name: publisher_invoices publisher_invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publisher_invoices
    ADD CONSTRAINT publisher_invoices_pkey PRIMARY KEY (id);


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
-- Name: index_campaigns_on_countries; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_countries ON public.campaigns USING gin (countries);


--
-- Name: index_campaigns_on_creative_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_creative_id ON public.campaigns USING btree (creative_id);


--
-- Name: index_campaigns_on_end_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_end_date ON public.campaigns USING btree (end_date);


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
-- Name: index_campaigns_on_start_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_start_date ON public.campaigns USING btree (start_date);


--
-- Name: index_campaigns_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_status ON public.campaigns USING btree (status);


--
-- Name: index_campaigns_on_us_hours_only; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_us_hours_only ON public.campaigns USING btree (us_hours_only);


--
-- Name: index_campaigns_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_user_id ON public.campaigns USING btree (user_id);


--
-- Name: index_campaigns_on_weekdays_only; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaigns_on_weekdays_only ON public.campaigns USING btree (weekdays_only);


--
-- Name: index_creative_images_on_active_storage_attachment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_creative_images_on_active_storage_attachment_id ON public.creative_images USING btree (active_storage_attachment_id);


--
-- Name: index_creative_images_on_creative_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_creative_images_on_creative_id ON public.creative_images USING btree (creative_id);


--
-- Name: index_creatives_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_creatives_on_user_id ON public.creatives USING btree (user_id);


--
-- Name: index_impressions_2018_11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2018_11_on_campaign_id ON public.impressions_2018_11 USING btree (campaign_id);


--
-- Name: index_impressions_2018_11_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2018_11_on_campaign_name ON public.impressions_2018_11 USING btree (campaign_name);


--
-- Name: index_impressions_2018_11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2018_11_on_displayed_at_date ON public.impressions_2018_11 USING btree (displayed_at_date);


--
-- Name: index_impressions_2018_11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2018_11_on_displayed_at_hour ON public.impressions_2018_11 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2018_11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2018_11_on_payable ON public.impressions_2018_11 USING btree (payable);


--
-- Name: index_impressions_2018_11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2018_11_on_property_id ON public.impressions_2018_11 USING btree (property_id);


--
-- Name: index_impressions_2018_11_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2018_11_on_property_name ON public.impressions_2018_11 USING btree (property_name);


--
-- Name: index_impressions_2018_12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2018_12_on_campaign_id ON public.impressions_2018_12 USING btree (campaign_id);


--
-- Name: index_impressions_2018_12_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2018_12_on_campaign_name ON public.impressions_2018_12 USING btree (campaign_name);


--
-- Name: index_impressions_2018_12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2018_12_on_displayed_at_date ON public.impressions_2018_12 USING btree (displayed_at_date);


--
-- Name: index_impressions_2018_12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2018_12_on_displayed_at_hour ON public.impressions_2018_12 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2018_12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2018_12_on_payable ON public.impressions_2018_12 USING btree (payable);


--
-- Name: index_impressions_2018_12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2018_12_on_property_id ON public.impressions_2018_12 USING btree (property_id);


--
-- Name: index_impressions_2018_12_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2018_12_on_property_name ON public.impressions_2018_12 USING btree (property_name);


--
-- Name: index_impressions_2019_01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_01_on_campaign_id ON public.impressions_2019_01 USING btree (campaign_id);


--
-- Name: index_impressions_2019_01_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_01_on_campaign_name ON public.impressions_2019_01 USING btree (campaign_name);


--
-- Name: index_impressions_2019_01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_01_on_displayed_at_date ON public.impressions_2019_01 USING btree (displayed_at_date);


--
-- Name: index_impressions_2019_01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_01_on_displayed_at_hour ON public.impressions_2019_01 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2019_01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_01_on_payable ON public.impressions_2019_01 USING btree (payable);


--
-- Name: index_impressions_2019_01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_01_on_property_id ON public.impressions_2019_01 USING btree (property_id);


--
-- Name: index_impressions_2019_01_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_01_on_property_name ON public.impressions_2019_01 USING btree (property_name);


--
-- Name: index_impressions_2019_02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_02_on_campaign_id ON public.impressions_2019_02 USING btree (campaign_id);


--
-- Name: index_impressions_2019_02_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_02_on_campaign_name ON public.impressions_2019_02 USING btree (campaign_name);


--
-- Name: index_impressions_2019_02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_02_on_displayed_at_date ON public.impressions_2019_02 USING btree (displayed_at_date);


--
-- Name: index_impressions_2019_02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_02_on_displayed_at_hour ON public.impressions_2019_02 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2019_02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_02_on_payable ON public.impressions_2019_02 USING btree (payable);


--
-- Name: index_impressions_2019_02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_02_on_property_id ON public.impressions_2019_02 USING btree (property_id);


--
-- Name: index_impressions_2019_02_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_02_on_property_name ON public.impressions_2019_02 USING btree (property_name);


--
-- Name: index_impressions_2019_03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_03_on_campaign_id ON public.impressions_2019_03 USING btree (campaign_id);


--
-- Name: index_impressions_2019_03_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_03_on_campaign_name ON public.impressions_2019_03 USING btree (campaign_name);


--
-- Name: index_impressions_2019_03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_03_on_displayed_at_date ON public.impressions_2019_03 USING btree (displayed_at_date);


--
-- Name: index_impressions_2019_03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_03_on_displayed_at_hour ON public.impressions_2019_03 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2019_03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_03_on_payable ON public.impressions_2019_03 USING btree (payable);


--
-- Name: index_impressions_2019_03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_03_on_property_id ON public.impressions_2019_03 USING btree (property_id);


--
-- Name: index_impressions_2019_03_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_03_on_property_name ON public.impressions_2019_03 USING btree (property_name);


--
-- Name: index_impressions_2019_04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_04_on_campaign_id ON public.impressions_2019_04 USING btree (campaign_id);


--
-- Name: index_impressions_2019_04_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_04_on_campaign_name ON public.impressions_2019_04 USING btree (campaign_name);


--
-- Name: index_impressions_2019_04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_04_on_displayed_at_date ON public.impressions_2019_04 USING btree (displayed_at_date);


--
-- Name: index_impressions_2019_04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_04_on_displayed_at_hour ON public.impressions_2019_04 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2019_04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_04_on_payable ON public.impressions_2019_04 USING btree (payable);


--
-- Name: index_impressions_2019_04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_04_on_property_id ON public.impressions_2019_04 USING btree (property_id);


--
-- Name: index_impressions_2019_04_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_04_on_property_name ON public.impressions_2019_04 USING btree (property_name);


--
-- Name: index_impressions_2019_05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_05_on_campaign_id ON public.impressions_2019_05 USING btree (campaign_id);


--
-- Name: index_impressions_2019_05_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_05_on_campaign_name ON public.impressions_2019_05 USING btree (campaign_name);


--
-- Name: index_impressions_2019_05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_05_on_displayed_at_date ON public.impressions_2019_05 USING btree (displayed_at_date);


--
-- Name: index_impressions_2019_05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_05_on_displayed_at_hour ON public.impressions_2019_05 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2019_05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_05_on_payable ON public.impressions_2019_05 USING btree (payable);


--
-- Name: index_impressions_2019_05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_05_on_property_id ON public.impressions_2019_05 USING btree (property_id);


--
-- Name: index_impressions_2019_05_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_05_on_property_name ON public.impressions_2019_05 USING btree (property_name);


--
-- Name: index_impressions_2019_06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_06_on_campaign_id ON public.impressions_2019_06 USING btree (campaign_id);


--
-- Name: index_impressions_2019_06_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_06_on_campaign_name ON public.impressions_2019_06 USING btree (campaign_name);


--
-- Name: index_impressions_2019_06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_06_on_displayed_at_date ON public.impressions_2019_06 USING btree (displayed_at_date);


--
-- Name: index_impressions_2019_06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_06_on_displayed_at_hour ON public.impressions_2019_06 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2019_06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_06_on_payable ON public.impressions_2019_06 USING btree (payable);


--
-- Name: index_impressions_2019_06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_06_on_property_id ON public.impressions_2019_06 USING btree (property_id);


--
-- Name: index_impressions_2019_06_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_06_on_property_name ON public.impressions_2019_06 USING btree (property_name);


--
-- Name: index_impressions_2019_07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_07_on_campaign_id ON public.impressions_2019_07 USING btree (campaign_id);


--
-- Name: index_impressions_2019_07_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_07_on_campaign_name ON public.impressions_2019_07 USING btree (campaign_name);


--
-- Name: index_impressions_2019_07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_07_on_displayed_at_date ON public.impressions_2019_07 USING btree (displayed_at_date);


--
-- Name: index_impressions_2019_07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_07_on_displayed_at_hour ON public.impressions_2019_07 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2019_07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_07_on_payable ON public.impressions_2019_07 USING btree (payable);


--
-- Name: index_impressions_2019_07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_07_on_property_id ON public.impressions_2019_07 USING btree (property_id);


--
-- Name: index_impressions_2019_07_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_07_on_property_name ON public.impressions_2019_07 USING btree (property_name);


--
-- Name: index_impressions_2019_08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_08_on_campaign_id ON public.impressions_2019_08 USING btree (campaign_id);


--
-- Name: index_impressions_2019_08_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_08_on_campaign_name ON public.impressions_2019_08 USING btree (campaign_name);


--
-- Name: index_impressions_2019_08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_08_on_displayed_at_date ON public.impressions_2019_08 USING btree (displayed_at_date);


--
-- Name: index_impressions_2019_08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_08_on_displayed_at_hour ON public.impressions_2019_08 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2019_08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_08_on_payable ON public.impressions_2019_08 USING btree (payable);


--
-- Name: index_impressions_2019_08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_08_on_property_id ON public.impressions_2019_08 USING btree (property_id);


--
-- Name: index_impressions_2019_08_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_08_on_property_name ON public.impressions_2019_08 USING btree (property_name);


--
-- Name: index_impressions_2019_09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_09_on_campaign_id ON public.impressions_2019_09 USING btree (campaign_id);


--
-- Name: index_impressions_2019_09_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_09_on_campaign_name ON public.impressions_2019_09 USING btree (campaign_name);


--
-- Name: index_impressions_2019_09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_09_on_displayed_at_date ON public.impressions_2019_09 USING btree (displayed_at_date);


--
-- Name: index_impressions_2019_09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_09_on_displayed_at_hour ON public.impressions_2019_09 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2019_09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_09_on_payable ON public.impressions_2019_09 USING btree (payable);


--
-- Name: index_impressions_2019_09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_09_on_property_id ON public.impressions_2019_09 USING btree (property_id);


--
-- Name: index_impressions_2019_09_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_09_on_property_name ON public.impressions_2019_09 USING btree (property_name);


--
-- Name: index_impressions_2019_10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_10_on_campaign_id ON public.impressions_2019_10 USING btree (campaign_id);


--
-- Name: index_impressions_2019_10_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_10_on_campaign_name ON public.impressions_2019_10 USING btree (campaign_name);


--
-- Name: index_impressions_2019_10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_10_on_displayed_at_date ON public.impressions_2019_10 USING btree (displayed_at_date);


--
-- Name: index_impressions_2019_10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_10_on_displayed_at_hour ON public.impressions_2019_10 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2019_10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_10_on_payable ON public.impressions_2019_10 USING btree (payable);


--
-- Name: index_impressions_2019_10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_10_on_property_id ON public.impressions_2019_10 USING btree (property_id);


--
-- Name: index_impressions_2019_10_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_10_on_property_name ON public.impressions_2019_10 USING btree (property_name);


--
-- Name: index_impressions_2019_11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_11_on_campaign_id ON public.impressions_2019_11 USING btree (campaign_id);


--
-- Name: index_impressions_2019_11_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_11_on_campaign_name ON public.impressions_2019_11 USING btree (campaign_name);


--
-- Name: index_impressions_2019_11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_11_on_displayed_at_date ON public.impressions_2019_11 USING btree (displayed_at_date);


--
-- Name: index_impressions_2019_11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_11_on_displayed_at_hour ON public.impressions_2019_11 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2019_11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_11_on_payable ON public.impressions_2019_11 USING btree (payable);


--
-- Name: index_impressions_2019_11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_11_on_property_id ON public.impressions_2019_11 USING btree (property_id);


--
-- Name: index_impressions_2019_11_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_11_on_property_name ON public.impressions_2019_11 USING btree (property_name);


--
-- Name: index_impressions_2019_12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_12_on_campaign_id ON public.impressions_2019_12 USING btree (campaign_id);


--
-- Name: index_impressions_2019_12_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_12_on_campaign_name ON public.impressions_2019_12 USING btree (campaign_name);


--
-- Name: index_impressions_2019_12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_12_on_displayed_at_date ON public.impressions_2019_12 USING btree (displayed_at_date);


--
-- Name: index_impressions_2019_12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_12_on_displayed_at_hour ON public.impressions_2019_12 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2019_12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_12_on_payable ON public.impressions_2019_12 USING btree (payable);


--
-- Name: index_impressions_2019_12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_12_on_property_id ON public.impressions_2019_12 USING btree (property_id);


--
-- Name: index_impressions_2019_12_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2019_12_on_property_name ON public.impressions_2019_12 USING btree (property_name);


--
-- Name: index_impressions_2020_01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_01_on_campaign_id ON public.impressions_2020_01 USING btree (campaign_id);


--
-- Name: index_impressions_2020_01_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_01_on_campaign_name ON public.impressions_2020_01 USING btree (campaign_name);


--
-- Name: index_impressions_2020_01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_01_on_displayed_at_date ON public.impressions_2020_01 USING btree (displayed_at_date);


--
-- Name: index_impressions_2020_01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_01_on_displayed_at_hour ON public.impressions_2020_01 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2020_01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_01_on_payable ON public.impressions_2020_01 USING btree (payable);


--
-- Name: index_impressions_2020_01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_01_on_property_id ON public.impressions_2020_01 USING btree (property_id);


--
-- Name: index_impressions_2020_01_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_01_on_property_name ON public.impressions_2020_01 USING btree (property_name);


--
-- Name: index_impressions_2020_02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_02_on_campaign_id ON public.impressions_2020_02 USING btree (campaign_id);


--
-- Name: index_impressions_2020_02_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_02_on_campaign_name ON public.impressions_2020_02 USING btree (campaign_name);


--
-- Name: index_impressions_2020_02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_02_on_displayed_at_date ON public.impressions_2020_02 USING btree (displayed_at_date);


--
-- Name: index_impressions_2020_02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_02_on_displayed_at_hour ON public.impressions_2020_02 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2020_02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_02_on_payable ON public.impressions_2020_02 USING btree (payable);


--
-- Name: index_impressions_2020_02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_02_on_property_id ON public.impressions_2020_02 USING btree (property_id);


--
-- Name: index_impressions_2020_02_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_02_on_property_name ON public.impressions_2020_02 USING btree (property_name);


--
-- Name: index_impressions_2020_03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_03_on_campaign_id ON public.impressions_2020_03 USING btree (campaign_id);


--
-- Name: index_impressions_2020_03_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_03_on_campaign_name ON public.impressions_2020_03 USING btree (campaign_name);


--
-- Name: index_impressions_2020_03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_03_on_displayed_at_date ON public.impressions_2020_03 USING btree (displayed_at_date);


--
-- Name: index_impressions_2020_03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_03_on_displayed_at_hour ON public.impressions_2020_03 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2020_03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_03_on_payable ON public.impressions_2020_03 USING btree (payable);


--
-- Name: index_impressions_2020_03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_03_on_property_id ON public.impressions_2020_03 USING btree (property_id);


--
-- Name: index_impressions_2020_03_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_03_on_property_name ON public.impressions_2020_03 USING btree (property_name);


--
-- Name: index_impressions_2020_04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_04_on_campaign_id ON public.impressions_2020_04 USING btree (campaign_id);


--
-- Name: index_impressions_2020_04_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_04_on_campaign_name ON public.impressions_2020_04 USING btree (campaign_name);


--
-- Name: index_impressions_2020_04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_04_on_displayed_at_date ON public.impressions_2020_04 USING btree (displayed_at_date);


--
-- Name: index_impressions_2020_04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_04_on_displayed_at_hour ON public.impressions_2020_04 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2020_04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_04_on_payable ON public.impressions_2020_04 USING btree (payable);


--
-- Name: index_impressions_2020_04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_04_on_property_id ON public.impressions_2020_04 USING btree (property_id);


--
-- Name: index_impressions_2020_04_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_04_on_property_name ON public.impressions_2020_04 USING btree (property_name);


--
-- Name: index_impressions_2020_05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_05_on_campaign_id ON public.impressions_2020_05 USING btree (campaign_id);


--
-- Name: index_impressions_2020_05_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_05_on_campaign_name ON public.impressions_2020_05 USING btree (campaign_name);


--
-- Name: index_impressions_2020_05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_05_on_displayed_at_date ON public.impressions_2020_05 USING btree (displayed_at_date);


--
-- Name: index_impressions_2020_05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_05_on_displayed_at_hour ON public.impressions_2020_05 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2020_05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_05_on_payable ON public.impressions_2020_05 USING btree (payable);


--
-- Name: index_impressions_2020_05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_05_on_property_id ON public.impressions_2020_05 USING btree (property_id);


--
-- Name: index_impressions_2020_05_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_05_on_property_name ON public.impressions_2020_05 USING btree (property_name);


--
-- Name: index_impressions_2020_06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_06_on_campaign_id ON public.impressions_2020_06 USING btree (campaign_id);


--
-- Name: index_impressions_2020_06_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_06_on_campaign_name ON public.impressions_2020_06 USING btree (campaign_name);


--
-- Name: index_impressions_2020_06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_06_on_displayed_at_date ON public.impressions_2020_06 USING btree (displayed_at_date);


--
-- Name: index_impressions_2020_06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_06_on_displayed_at_hour ON public.impressions_2020_06 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2020_06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_06_on_payable ON public.impressions_2020_06 USING btree (payable);


--
-- Name: index_impressions_2020_06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_06_on_property_id ON public.impressions_2020_06 USING btree (property_id);


--
-- Name: index_impressions_2020_06_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_06_on_property_name ON public.impressions_2020_06 USING btree (property_name);


--
-- Name: index_impressions_2020_07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_07_on_campaign_id ON public.impressions_2020_07 USING btree (campaign_id);


--
-- Name: index_impressions_2020_07_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_07_on_campaign_name ON public.impressions_2020_07 USING btree (campaign_name);


--
-- Name: index_impressions_2020_07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_07_on_displayed_at_date ON public.impressions_2020_07 USING btree (displayed_at_date);


--
-- Name: index_impressions_2020_07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_07_on_displayed_at_hour ON public.impressions_2020_07 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2020_07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_07_on_payable ON public.impressions_2020_07 USING btree (payable);


--
-- Name: index_impressions_2020_07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_07_on_property_id ON public.impressions_2020_07 USING btree (property_id);


--
-- Name: index_impressions_2020_07_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_07_on_property_name ON public.impressions_2020_07 USING btree (property_name);


--
-- Name: index_impressions_2020_08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_08_on_campaign_id ON public.impressions_2020_08 USING btree (campaign_id);


--
-- Name: index_impressions_2020_08_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_08_on_campaign_name ON public.impressions_2020_08 USING btree (campaign_name);


--
-- Name: index_impressions_2020_08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_08_on_displayed_at_date ON public.impressions_2020_08 USING btree (displayed_at_date);


--
-- Name: index_impressions_2020_08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_08_on_displayed_at_hour ON public.impressions_2020_08 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2020_08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_08_on_payable ON public.impressions_2020_08 USING btree (payable);


--
-- Name: index_impressions_2020_08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_08_on_property_id ON public.impressions_2020_08 USING btree (property_id);


--
-- Name: index_impressions_2020_08_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_08_on_property_name ON public.impressions_2020_08 USING btree (property_name);


--
-- Name: index_impressions_2020_09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_09_on_campaign_id ON public.impressions_2020_09 USING btree (campaign_id);


--
-- Name: index_impressions_2020_09_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_09_on_campaign_name ON public.impressions_2020_09 USING btree (campaign_name);


--
-- Name: index_impressions_2020_09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_09_on_displayed_at_date ON public.impressions_2020_09 USING btree (displayed_at_date);


--
-- Name: index_impressions_2020_09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_09_on_displayed_at_hour ON public.impressions_2020_09 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2020_09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_09_on_payable ON public.impressions_2020_09 USING btree (payable);


--
-- Name: index_impressions_2020_09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_09_on_property_id ON public.impressions_2020_09 USING btree (property_id);


--
-- Name: index_impressions_2020_09_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_09_on_property_name ON public.impressions_2020_09 USING btree (property_name);


--
-- Name: index_impressions_2020_10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_10_on_campaign_id ON public.impressions_2020_10 USING btree (campaign_id);


--
-- Name: index_impressions_2020_10_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_10_on_campaign_name ON public.impressions_2020_10 USING btree (campaign_name);


--
-- Name: index_impressions_2020_10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_10_on_displayed_at_date ON public.impressions_2020_10 USING btree (displayed_at_date);


--
-- Name: index_impressions_2020_10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_10_on_displayed_at_hour ON public.impressions_2020_10 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2020_10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_10_on_payable ON public.impressions_2020_10 USING btree (payable);


--
-- Name: index_impressions_2020_10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_10_on_property_id ON public.impressions_2020_10 USING btree (property_id);


--
-- Name: index_impressions_2020_10_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_10_on_property_name ON public.impressions_2020_10 USING btree (property_name);


--
-- Name: index_impressions_2020_11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_11_on_campaign_id ON public.impressions_2020_11 USING btree (campaign_id);


--
-- Name: index_impressions_2020_11_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_11_on_campaign_name ON public.impressions_2020_11 USING btree (campaign_name);


--
-- Name: index_impressions_2020_11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_11_on_displayed_at_date ON public.impressions_2020_11 USING btree (displayed_at_date);


--
-- Name: index_impressions_2020_11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_11_on_displayed_at_hour ON public.impressions_2020_11 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2020_11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_11_on_payable ON public.impressions_2020_11 USING btree (payable);


--
-- Name: index_impressions_2020_11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_11_on_property_id ON public.impressions_2020_11 USING btree (property_id);


--
-- Name: index_impressions_2020_11_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_11_on_property_name ON public.impressions_2020_11 USING btree (property_name);


--
-- Name: index_impressions_2020_12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_12_on_campaign_id ON public.impressions_2020_12 USING btree (campaign_id);


--
-- Name: index_impressions_2020_12_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_12_on_campaign_name ON public.impressions_2020_12 USING btree (campaign_name);


--
-- Name: index_impressions_2020_12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_12_on_displayed_at_date ON public.impressions_2020_12 USING btree (displayed_at_date);


--
-- Name: index_impressions_2020_12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_12_on_displayed_at_hour ON public.impressions_2020_12 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2020_12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_12_on_payable ON public.impressions_2020_12 USING btree (payable);


--
-- Name: index_impressions_2020_12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_12_on_property_id ON public.impressions_2020_12 USING btree (property_id);


--
-- Name: index_impressions_2020_12_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2020_12_on_property_name ON public.impressions_2020_12 USING btree (property_name);


--
-- Name: index_impressions_2021_01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_01_on_campaign_id ON public.impressions_2021_01 USING btree (campaign_id);


--
-- Name: index_impressions_2021_01_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_01_on_campaign_name ON public.impressions_2021_01 USING btree (campaign_name);


--
-- Name: index_impressions_2021_01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_01_on_displayed_at_date ON public.impressions_2021_01 USING btree (displayed_at_date);


--
-- Name: index_impressions_2021_01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_01_on_displayed_at_hour ON public.impressions_2021_01 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2021_01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_01_on_payable ON public.impressions_2021_01 USING btree (payable);


--
-- Name: index_impressions_2021_01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_01_on_property_id ON public.impressions_2021_01 USING btree (property_id);


--
-- Name: index_impressions_2021_01_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_01_on_property_name ON public.impressions_2021_01 USING btree (property_name);


--
-- Name: index_impressions_2021_02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_02_on_campaign_id ON public.impressions_2021_02 USING btree (campaign_id);


--
-- Name: index_impressions_2021_02_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_02_on_campaign_name ON public.impressions_2021_02 USING btree (campaign_name);


--
-- Name: index_impressions_2021_02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_02_on_displayed_at_date ON public.impressions_2021_02 USING btree (displayed_at_date);


--
-- Name: index_impressions_2021_02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_02_on_displayed_at_hour ON public.impressions_2021_02 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2021_02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_02_on_payable ON public.impressions_2021_02 USING btree (payable);


--
-- Name: index_impressions_2021_02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_02_on_property_id ON public.impressions_2021_02 USING btree (property_id);


--
-- Name: index_impressions_2021_02_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_02_on_property_name ON public.impressions_2021_02 USING btree (property_name);


--
-- Name: index_impressions_2021_03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_03_on_campaign_id ON public.impressions_2021_03 USING btree (campaign_id);


--
-- Name: index_impressions_2021_03_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_03_on_campaign_name ON public.impressions_2021_03 USING btree (campaign_name);


--
-- Name: index_impressions_2021_03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_03_on_displayed_at_date ON public.impressions_2021_03 USING btree (displayed_at_date);


--
-- Name: index_impressions_2021_03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_03_on_displayed_at_hour ON public.impressions_2021_03 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2021_03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_03_on_payable ON public.impressions_2021_03 USING btree (payable);


--
-- Name: index_impressions_2021_03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_03_on_property_id ON public.impressions_2021_03 USING btree (property_id);


--
-- Name: index_impressions_2021_03_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_03_on_property_name ON public.impressions_2021_03 USING btree (property_name);


--
-- Name: index_impressions_2021_04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_04_on_campaign_id ON public.impressions_2021_04 USING btree (campaign_id);


--
-- Name: index_impressions_2021_04_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_04_on_campaign_name ON public.impressions_2021_04 USING btree (campaign_name);


--
-- Name: index_impressions_2021_04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_04_on_displayed_at_date ON public.impressions_2021_04 USING btree (displayed_at_date);


--
-- Name: index_impressions_2021_04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_04_on_displayed_at_hour ON public.impressions_2021_04 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2021_04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_04_on_payable ON public.impressions_2021_04 USING btree (payable);


--
-- Name: index_impressions_2021_04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_04_on_property_id ON public.impressions_2021_04 USING btree (property_id);


--
-- Name: index_impressions_2021_04_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_04_on_property_name ON public.impressions_2021_04 USING btree (property_name);


--
-- Name: index_impressions_2021_05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_05_on_campaign_id ON public.impressions_2021_05 USING btree (campaign_id);


--
-- Name: index_impressions_2021_05_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_05_on_campaign_name ON public.impressions_2021_05 USING btree (campaign_name);


--
-- Name: index_impressions_2021_05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_05_on_displayed_at_date ON public.impressions_2021_05 USING btree (displayed_at_date);


--
-- Name: index_impressions_2021_05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_05_on_displayed_at_hour ON public.impressions_2021_05 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2021_05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_05_on_payable ON public.impressions_2021_05 USING btree (payable);


--
-- Name: index_impressions_2021_05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_05_on_property_id ON public.impressions_2021_05 USING btree (property_id);


--
-- Name: index_impressions_2021_05_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_05_on_property_name ON public.impressions_2021_05 USING btree (property_name);


--
-- Name: index_impressions_2021_06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_06_on_campaign_id ON public.impressions_2021_06 USING btree (campaign_id);


--
-- Name: index_impressions_2021_06_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_06_on_campaign_name ON public.impressions_2021_06 USING btree (campaign_name);


--
-- Name: index_impressions_2021_06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_06_on_displayed_at_date ON public.impressions_2021_06 USING btree (displayed_at_date);


--
-- Name: index_impressions_2021_06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_06_on_displayed_at_hour ON public.impressions_2021_06 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2021_06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_06_on_payable ON public.impressions_2021_06 USING btree (payable);


--
-- Name: index_impressions_2021_06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_06_on_property_id ON public.impressions_2021_06 USING btree (property_id);


--
-- Name: index_impressions_2021_06_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_06_on_property_name ON public.impressions_2021_06 USING btree (property_name);


--
-- Name: index_impressions_2021_07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_07_on_campaign_id ON public.impressions_2021_07 USING btree (campaign_id);


--
-- Name: index_impressions_2021_07_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_07_on_campaign_name ON public.impressions_2021_07 USING btree (campaign_name);


--
-- Name: index_impressions_2021_07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_07_on_displayed_at_date ON public.impressions_2021_07 USING btree (displayed_at_date);


--
-- Name: index_impressions_2021_07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_07_on_displayed_at_hour ON public.impressions_2021_07 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2021_07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_07_on_payable ON public.impressions_2021_07 USING btree (payable);


--
-- Name: index_impressions_2021_07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_07_on_property_id ON public.impressions_2021_07 USING btree (property_id);


--
-- Name: index_impressions_2021_07_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_07_on_property_name ON public.impressions_2021_07 USING btree (property_name);


--
-- Name: index_impressions_2021_08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_08_on_campaign_id ON public.impressions_2021_08 USING btree (campaign_id);


--
-- Name: index_impressions_2021_08_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_08_on_campaign_name ON public.impressions_2021_08 USING btree (campaign_name);


--
-- Name: index_impressions_2021_08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_08_on_displayed_at_date ON public.impressions_2021_08 USING btree (displayed_at_date);


--
-- Name: index_impressions_2021_08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_08_on_displayed_at_hour ON public.impressions_2021_08 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2021_08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_08_on_payable ON public.impressions_2021_08 USING btree (payable);


--
-- Name: index_impressions_2021_08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_08_on_property_id ON public.impressions_2021_08 USING btree (property_id);


--
-- Name: index_impressions_2021_08_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_08_on_property_name ON public.impressions_2021_08 USING btree (property_name);


--
-- Name: index_impressions_2021_09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_09_on_campaign_id ON public.impressions_2021_09 USING btree (campaign_id);


--
-- Name: index_impressions_2021_09_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_09_on_campaign_name ON public.impressions_2021_09 USING btree (campaign_name);


--
-- Name: index_impressions_2021_09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_09_on_displayed_at_date ON public.impressions_2021_09 USING btree (displayed_at_date);


--
-- Name: index_impressions_2021_09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_09_on_displayed_at_hour ON public.impressions_2021_09 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2021_09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_09_on_payable ON public.impressions_2021_09 USING btree (payable);


--
-- Name: index_impressions_2021_09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_09_on_property_id ON public.impressions_2021_09 USING btree (property_id);


--
-- Name: index_impressions_2021_09_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_09_on_property_name ON public.impressions_2021_09 USING btree (property_name);


--
-- Name: index_impressions_2021_10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_10_on_campaign_id ON public.impressions_2021_10 USING btree (campaign_id);


--
-- Name: index_impressions_2021_10_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_10_on_campaign_name ON public.impressions_2021_10 USING btree (campaign_name);


--
-- Name: index_impressions_2021_10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_10_on_displayed_at_date ON public.impressions_2021_10 USING btree (displayed_at_date);


--
-- Name: index_impressions_2021_10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_10_on_displayed_at_hour ON public.impressions_2021_10 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2021_10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_10_on_payable ON public.impressions_2021_10 USING btree (payable);


--
-- Name: index_impressions_2021_10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_10_on_property_id ON public.impressions_2021_10 USING btree (property_id);


--
-- Name: index_impressions_2021_10_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_10_on_property_name ON public.impressions_2021_10 USING btree (property_name);


--
-- Name: index_impressions_2021_11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_11_on_campaign_id ON public.impressions_2021_11 USING btree (campaign_id);


--
-- Name: index_impressions_2021_11_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_11_on_campaign_name ON public.impressions_2021_11 USING btree (campaign_name);


--
-- Name: index_impressions_2021_11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_11_on_displayed_at_date ON public.impressions_2021_11 USING btree (displayed_at_date);


--
-- Name: index_impressions_2021_11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_11_on_displayed_at_hour ON public.impressions_2021_11 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2021_11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_11_on_payable ON public.impressions_2021_11 USING btree (payable);


--
-- Name: index_impressions_2021_11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_11_on_property_id ON public.impressions_2021_11 USING btree (property_id);


--
-- Name: index_impressions_2021_11_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_11_on_property_name ON public.impressions_2021_11 USING btree (property_name);


--
-- Name: index_impressions_2021_12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_12_on_campaign_id ON public.impressions_2021_12 USING btree (campaign_id);


--
-- Name: index_impressions_2021_12_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_12_on_campaign_name ON public.impressions_2021_12 USING btree (campaign_name);


--
-- Name: index_impressions_2021_12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_12_on_displayed_at_date ON public.impressions_2021_12 USING btree (displayed_at_date);


--
-- Name: index_impressions_2021_12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_12_on_displayed_at_hour ON public.impressions_2021_12 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2021_12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_12_on_payable ON public.impressions_2021_12 USING btree (payable);


--
-- Name: index_impressions_2021_12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_12_on_property_id ON public.impressions_2021_12 USING btree (property_id);


--
-- Name: index_impressions_2021_12_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2021_12_on_property_name ON public.impressions_2021_12 USING btree (property_name);


--
-- Name: index_impressions_2022_01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_01_on_campaign_id ON public.impressions_2022_01 USING btree (campaign_id);


--
-- Name: index_impressions_2022_01_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_01_on_campaign_name ON public.impressions_2022_01 USING btree (campaign_name);


--
-- Name: index_impressions_2022_01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_01_on_displayed_at_date ON public.impressions_2022_01 USING btree (displayed_at_date);


--
-- Name: index_impressions_2022_01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_01_on_displayed_at_hour ON public.impressions_2022_01 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2022_01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_01_on_payable ON public.impressions_2022_01 USING btree (payable);


--
-- Name: index_impressions_2022_01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_01_on_property_id ON public.impressions_2022_01 USING btree (property_id);


--
-- Name: index_impressions_2022_01_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_01_on_property_name ON public.impressions_2022_01 USING btree (property_name);


--
-- Name: index_impressions_2022_02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_02_on_campaign_id ON public.impressions_2022_02 USING btree (campaign_id);


--
-- Name: index_impressions_2022_02_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_02_on_campaign_name ON public.impressions_2022_02 USING btree (campaign_name);


--
-- Name: index_impressions_2022_02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_02_on_displayed_at_date ON public.impressions_2022_02 USING btree (displayed_at_date);


--
-- Name: index_impressions_2022_02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_02_on_displayed_at_hour ON public.impressions_2022_02 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2022_02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_02_on_payable ON public.impressions_2022_02 USING btree (payable);


--
-- Name: index_impressions_2022_02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_02_on_property_id ON public.impressions_2022_02 USING btree (property_id);


--
-- Name: index_impressions_2022_02_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_02_on_property_name ON public.impressions_2022_02 USING btree (property_name);


--
-- Name: index_impressions_2022_03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_03_on_campaign_id ON public.impressions_2022_03 USING btree (campaign_id);


--
-- Name: index_impressions_2022_03_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_03_on_campaign_name ON public.impressions_2022_03 USING btree (campaign_name);


--
-- Name: index_impressions_2022_03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_03_on_displayed_at_date ON public.impressions_2022_03 USING btree (displayed_at_date);


--
-- Name: index_impressions_2022_03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_03_on_displayed_at_hour ON public.impressions_2022_03 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2022_03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_03_on_payable ON public.impressions_2022_03 USING btree (payable);


--
-- Name: index_impressions_2022_03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_03_on_property_id ON public.impressions_2022_03 USING btree (property_id);


--
-- Name: index_impressions_2022_03_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_03_on_property_name ON public.impressions_2022_03 USING btree (property_name);


--
-- Name: index_impressions_2022_04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_04_on_campaign_id ON public.impressions_2022_04 USING btree (campaign_id);


--
-- Name: index_impressions_2022_04_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_04_on_campaign_name ON public.impressions_2022_04 USING btree (campaign_name);


--
-- Name: index_impressions_2022_04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_04_on_displayed_at_date ON public.impressions_2022_04 USING btree (displayed_at_date);


--
-- Name: index_impressions_2022_04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_04_on_displayed_at_hour ON public.impressions_2022_04 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2022_04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_04_on_payable ON public.impressions_2022_04 USING btree (payable);


--
-- Name: index_impressions_2022_04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_04_on_property_id ON public.impressions_2022_04 USING btree (property_id);


--
-- Name: index_impressions_2022_04_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_04_on_property_name ON public.impressions_2022_04 USING btree (property_name);


--
-- Name: index_impressions_2022_05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_05_on_campaign_id ON public.impressions_2022_05 USING btree (campaign_id);


--
-- Name: index_impressions_2022_05_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_05_on_campaign_name ON public.impressions_2022_05 USING btree (campaign_name);


--
-- Name: index_impressions_2022_05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_05_on_displayed_at_date ON public.impressions_2022_05 USING btree (displayed_at_date);


--
-- Name: index_impressions_2022_05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_05_on_displayed_at_hour ON public.impressions_2022_05 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2022_05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_05_on_payable ON public.impressions_2022_05 USING btree (payable);


--
-- Name: index_impressions_2022_05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_05_on_property_id ON public.impressions_2022_05 USING btree (property_id);


--
-- Name: index_impressions_2022_05_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_05_on_property_name ON public.impressions_2022_05 USING btree (property_name);


--
-- Name: index_impressions_2022_06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_06_on_campaign_id ON public.impressions_2022_06 USING btree (campaign_id);


--
-- Name: index_impressions_2022_06_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_06_on_campaign_name ON public.impressions_2022_06 USING btree (campaign_name);


--
-- Name: index_impressions_2022_06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_06_on_displayed_at_date ON public.impressions_2022_06 USING btree (displayed_at_date);


--
-- Name: index_impressions_2022_06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_06_on_displayed_at_hour ON public.impressions_2022_06 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2022_06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_06_on_payable ON public.impressions_2022_06 USING btree (payable);


--
-- Name: index_impressions_2022_06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_06_on_property_id ON public.impressions_2022_06 USING btree (property_id);


--
-- Name: index_impressions_2022_06_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_06_on_property_name ON public.impressions_2022_06 USING btree (property_name);


--
-- Name: index_impressions_2022_07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_07_on_campaign_id ON public.impressions_2022_07 USING btree (campaign_id);


--
-- Name: index_impressions_2022_07_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_07_on_campaign_name ON public.impressions_2022_07 USING btree (campaign_name);


--
-- Name: index_impressions_2022_07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_07_on_displayed_at_date ON public.impressions_2022_07 USING btree (displayed_at_date);


--
-- Name: index_impressions_2022_07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_07_on_displayed_at_hour ON public.impressions_2022_07 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2022_07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_07_on_payable ON public.impressions_2022_07 USING btree (payable);


--
-- Name: index_impressions_2022_07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_07_on_property_id ON public.impressions_2022_07 USING btree (property_id);


--
-- Name: index_impressions_2022_07_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_07_on_property_name ON public.impressions_2022_07 USING btree (property_name);


--
-- Name: index_impressions_2022_08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_08_on_campaign_id ON public.impressions_2022_08 USING btree (campaign_id);


--
-- Name: index_impressions_2022_08_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_08_on_campaign_name ON public.impressions_2022_08 USING btree (campaign_name);


--
-- Name: index_impressions_2022_08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_08_on_displayed_at_date ON public.impressions_2022_08 USING btree (displayed_at_date);


--
-- Name: index_impressions_2022_08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_08_on_displayed_at_hour ON public.impressions_2022_08 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2022_08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_08_on_payable ON public.impressions_2022_08 USING btree (payable);


--
-- Name: index_impressions_2022_08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_08_on_property_id ON public.impressions_2022_08 USING btree (property_id);


--
-- Name: index_impressions_2022_08_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_08_on_property_name ON public.impressions_2022_08 USING btree (property_name);


--
-- Name: index_impressions_2022_09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_09_on_campaign_id ON public.impressions_2022_09 USING btree (campaign_id);


--
-- Name: index_impressions_2022_09_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_09_on_campaign_name ON public.impressions_2022_09 USING btree (campaign_name);


--
-- Name: index_impressions_2022_09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_09_on_displayed_at_date ON public.impressions_2022_09 USING btree (displayed_at_date);


--
-- Name: index_impressions_2022_09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_09_on_displayed_at_hour ON public.impressions_2022_09 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2022_09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_09_on_payable ON public.impressions_2022_09 USING btree (payable);


--
-- Name: index_impressions_2022_09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_09_on_property_id ON public.impressions_2022_09 USING btree (property_id);


--
-- Name: index_impressions_2022_09_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_09_on_property_name ON public.impressions_2022_09 USING btree (property_name);


--
-- Name: index_impressions_2022_10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_10_on_campaign_id ON public.impressions_2022_10 USING btree (campaign_id);


--
-- Name: index_impressions_2022_10_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_10_on_campaign_name ON public.impressions_2022_10 USING btree (campaign_name);


--
-- Name: index_impressions_2022_10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_10_on_displayed_at_date ON public.impressions_2022_10 USING btree (displayed_at_date);


--
-- Name: index_impressions_2022_10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_10_on_displayed_at_hour ON public.impressions_2022_10 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2022_10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_10_on_payable ON public.impressions_2022_10 USING btree (payable);


--
-- Name: index_impressions_2022_10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_10_on_property_id ON public.impressions_2022_10 USING btree (property_id);


--
-- Name: index_impressions_2022_10_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_10_on_property_name ON public.impressions_2022_10 USING btree (property_name);


--
-- Name: index_impressions_2022_11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_11_on_campaign_id ON public.impressions_2022_11 USING btree (campaign_id);


--
-- Name: index_impressions_2022_11_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_11_on_campaign_name ON public.impressions_2022_11 USING btree (campaign_name);


--
-- Name: index_impressions_2022_11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_11_on_displayed_at_date ON public.impressions_2022_11 USING btree (displayed_at_date);


--
-- Name: index_impressions_2022_11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_11_on_displayed_at_hour ON public.impressions_2022_11 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2022_11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_11_on_payable ON public.impressions_2022_11 USING btree (payable);


--
-- Name: index_impressions_2022_11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_11_on_property_id ON public.impressions_2022_11 USING btree (property_id);


--
-- Name: index_impressions_2022_11_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_11_on_property_name ON public.impressions_2022_11 USING btree (property_name);


--
-- Name: index_impressions_2022_12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_12_on_campaign_id ON public.impressions_2022_12 USING btree (campaign_id);


--
-- Name: index_impressions_2022_12_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_12_on_campaign_name ON public.impressions_2022_12 USING btree (campaign_name);


--
-- Name: index_impressions_2022_12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_12_on_displayed_at_date ON public.impressions_2022_12 USING btree (displayed_at_date);


--
-- Name: index_impressions_2022_12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_12_on_displayed_at_hour ON public.impressions_2022_12 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2022_12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_12_on_payable ON public.impressions_2022_12 USING btree (payable);


--
-- Name: index_impressions_2022_12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_12_on_property_id ON public.impressions_2022_12 USING btree (property_id);


--
-- Name: index_impressions_2022_12_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2022_12_on_property_name ON public.impressions_2022_12 USING btree (property_name);


--
-- Name: index_impressions_2023_01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_01_on_campaign_id ON public.impressions_2023_01 USING btree (campaign_id);


--
-- Name: index_impressions_2023_01_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_01_on_campaign_name ON public.impressions_2023_01 USING btree (campaign_name);


--
-- Name: index_impressions_2023_01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_01_on_displayed_at_date ON public.impressions_2023_01 USING btree (displayed_at_date);


--
-- Name: index_impressions_2023_01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_01_on_displayed_at_hour ON public.impressions_2023_01 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2023_01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_01_on_payable ON public.impressions_2023_01 USING btree (payable);


--
-- Name: index_impressions_2023_01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_01_on_property_id ON public.impressions_2023_01 USING btree (property_id);


--
-- Name: index_impressions_2023_01_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_01_on_property_name ON public.impressions_2023_01 USING btree (property_name);


--
-- Name: index_impressions_2023_02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_02_on_campaign_id ON public.impressions_2023_02 USING btree (campaign_id);


--
-- Name: index_impressions_2023_02_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_02_on_campaign_name ON public.impressions_2023_02 USING btree (campaign_name);


--
-- Name: index_impressions_2023_02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_02_on_displayed_at_date ON public.impressions_2023_02 USING btree (displayed_at_date);


--
-- Name: index_impressions_2023_02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_02_on_displayed_at_hour ON public.impressions_2023_02 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2023_02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_02_on_payable ON public.impressions_2023_02 USING btree (payable);


--
-- Name: index_impressions_2023_02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_02_on_property_id ON public.impressions_2023_02 USING btree (property_id);


--
-- Name: index_impressions_2023_02_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_02_on_property_name ON public.impressions_2023_02 USING btree (property_name);


--
-- Name: index_impressions_2023_03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_03_on_campaign_id ON public.impressions_2023_03 USING btree (campaign_id);


--
-- Name: index_impressions_2023_03_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_03_on_campaign_name ON public.impressions_2023_03 USING btree (campaign_name);


--
-- Name: index_impressions_2023_03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_03_on_displayed_at_date ON public.impressions_2023_03 USING btree (displayed_at_date);


--
-- Name: index_impressions_2023_03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_03_on_displayed_at_hour ON public.impressions_2023_03 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2023_03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_03_on_payable ON public.impressions_2023_03 USING btree (payable);


--
-- Name: index_impressions_2023_03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_03_on_property_id ON public.impressions_2023_03 USING btree (property_id);


--
-- Name: index_impressions_2023_03_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_03_on_property_name ON public.impressions_2023_03 USING btree (property_name);


--
-- Name: index_impressions_2023_04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_04_on_campaign_id ON public.impressions_2023_04 USING btree (campaign_id);


--
-- Name: index_impressions_2023_04_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_04_on_campaign_name ON public.impressions_2023_04 USING btree (campaign_name);


--
-- Name: index_impressions_2023_04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_04_on_displayed_at_date ON public.impressions_2023_04 USING btree (displayed_at_date);


--
-- Name: index_impressions_2023_04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_04_on_displayed_at_hour ON public.impressions_2023_04 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2023_04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_04_on_payable ON public.impressions_2023_04 USING btree (payable);


--
-- Name: index_impressions_2023_04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_04_on_property_id ON public.impressions_2023_04 USING btree (property_id);


--
-- Name: index_impressions_2023_04_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_04_on_property_name ON public.impressions_2023_04 USING btree (property_name);


--
-- Name: index_impressions_2023_05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_05_on_campaign_id ON public.impressions_2023_05 USING btree (campaign_id);


--
-- Name: index_impressions_2023_05_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_05_on_campaign_name ON public.impressions_2023_05 USING btree (campaign_name);


--
-- Name: index_impressions_2023_05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_05_on_displayed_at_date ON public.impressions_2023_05 USING btree (displayed_at_date);


--
-- Name: index_impressions_2023_05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_05_on_displayed_at_hour ON public.impressions_2023_05 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2023_05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_05_on_payable ON public.impressions_2023_05 USING btree (payable);


--
-- Name: index_impressions_2023_05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_05_on_property_id ON public.impressions_2023_05 USING btree (property_id);


--
-- Name: index_impressions_2023_05_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_05_on_property_name ON public.impressions_2023_05 USING btree (property_name);


--
-- Name: index_impressions_2023_06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_06_on_campaign_id ON public.impressions_2023_06 USING btree (campaign_id);


--
-- Name: index_impressions_2023_06_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_06_on_campaign_name ON public.impressions_2023_06 USING btree (campaign_name);


--
-- Name: index_impressions_2023_06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_06_on_displayed_at_date ON public.impressions_2023_06 USING btree (displayed_at_date);


--
-- Name: index_impressions_2023_06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_06_on_displayed_at_hour ON public.impressions_2023_06 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2023_06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_06_on_payable ON public.impressions_2023_06 USING btree (payable);


--
-- Name: index_impressions_2023_06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_06_on_property_id ON public.impressions_2023_06 USING btree (property_id);


--
-- Name: index_impressions_2023_06_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_06_on_property_name ON public.impressions_2023_06 USING btree (property_name);


--
-- Name: index_impressions_2023_07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_07_on_campaign_id ON public.impressions_2023_07 USING btree (campaign_id);


--
-- Name: index_impressions_2023_07_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_07_on_campaign_name ON public.impressions_2023_07 USING btree (campaign_name);


--
-- Name: index_impressions_2023_07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_07_on_displayed_at_date ON public.impressions_2023_07 USING btree (displayed_at_date);


--
-- Name: index_impressions_2023_07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_07_on_displayed_at_hour ON public.impressions_2023_07 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2023_07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_07_on_payable ON public.impressions_2023_07 USING btree (payable);


--
-- Name: index_impressions_2023_07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_07_on_property_id ON public.impressions_2023_07 USING btree (property_id);


--
-- Name: index_impressions_2023_07_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_07_on_property_name ON public.impressions_2023_07 USING btree (property_name);


--
-- Name: index_impressions_2023_08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_08_on_campaign_id ON public.impressions_2023_08 USING btree (campaign_id);


--
-- Name: index_impressions_2023_08_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_08_on_campaign_name ON public.impressions_2023_08 USING btree (campaign_name);


--
-- Name: index_impressions_2023_08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_08_on_displayed_at_date ON public.impressions_2023_08 USING btree (displayed_at_date);


--
-- Name: index_impressions_2023_08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_08_on_displayed_at_hour ON public.impressions_2023_08 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2023_08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_08_on_payable ON public.impressions_2023_08 USING btree (payable);


--
-- Name: index_impressions_2023_08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_08_on_property_id ON public.impressions_2023_08 USING btree (property_id);


--
-- Name: index_impressions_2023_08_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_08_on_property_name ON public.impressions_2023_08 USING btree (property_name);


--
-- Name: index_impressions_2023_09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_09_on_campaign_id ON public.impressions_2023_09 USING btree (campaign_id);


--
-- Name: index_impressions_2023_09_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_09_on_campaign_name ON public.impressions_2023_09 USING btree (campaign_name);


--
-- Name: index_impressions_2023_09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_09_on_displayed_at_date ON public.impressions_2023_09 USING btree (displayed_at_date);


--
-- Name: index_impressions_2023_09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_09_on_displayed_at_hour ON public.impressions_2023_09 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2023_09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_09_on_payable ON public.impressions_2023_09 USING btree (payable);


--
-- Name: index_impressions_2023_09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_09_on_property_id ON public.impressions_2023_09 USING btree (property_id);


--
-- Name: index_impressions_2023_09_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_09_on_property_name ON public.impressions_2023_09 USING btree (property_name);


--
-- Name: index_impressions_2023_10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_10_on_campaign_id ON public.impressions_2023_10 USING btree (campaign_id);


--
-- Name: index_impressions_2023_10_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_10_on_campaign_name ON public.impressions_2023_10 USING btree (campaign_name);


--
-- Name: index_impressions_2023_10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_10_on_displayed_at_date ON public.impressions_2023_10 USING btree (displayed_at_date);


--
-- Name: index_impressions_2023_10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_10_on_displayed_at_hour ON public.impressions_2023_10 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2023_10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_10_on_payable ON public.impressions_2023_10 USING btree (payable);


--
-- Name: index_impressions_2023_10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_10_on_property_id ON public.impressions_2023_10 USING btree (property_id);


--
-- Name: index_impressions_2023_10_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_10_on_property_name ON public.impressions_2023_10 USING btree (property_name);


--
-- Name: index_impressions_2023_11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_11_on_campaign_id ON public.impressions_2023_11 USING btree (campaign_id);


--
-- Name: index_impressions_2023_11_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_11_on_campaign_name ON public.impressions_2023_11 USING btree (campaign_name);


--
-- Name: index_impressions_2023_11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_11_on_displayed_at_date ON public.impressions_2023_11 USING btree (displayed_at_date);


--
-- Name: index_impressions_2023_11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_11_on_displayed_at_hour ON public.impressions_2023_11 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2023_11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_11_on_payable ON public.impressions_2023_11 USING btree (payable);


--
-- Name: index_impressions_2023_11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_11_on_property_id ON public.impressions_2023_11 USING btree (property_id);


--
-- Name: index_impressions_2023_11_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_11_on_property_name ON public.impressions_2023_11 USING btree (property_name);


--
-- Name: index_impressions_2023_12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_12_on_campaign_id ON public.impressions_2023_12 USING btree (campaign_id);


--
-- Name: index_impressions_2023_12_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_12_on_campaign_name ON public.impressions_2023_12 USING btree (campaign_name);


--
-- Name: index_impressions_2023_12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_12_on_displayed_at_date ON public.impressions_2023_12 USING btree (displayed_at_date);


--
-- Name: index_impressions_2023_12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_12_on_displayed_at_hour ON public.impressions_2023_12 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2023_12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_12_on_payable ON public.impressions_2023_12 USING btree (payable);


--
-- Name: index_impressions_2023_12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_12_on_property_id ON public.impressions_2023_12 USING btree (property_id);


--
-- Name: index_impressions_2023_12_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2023_12_on_property_name ON public.impressions_2023_12 USING btree (property_name);


--
-- Name: index_impressions_2024_01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_01_on_campaign_id ON public.impressions_2024_01 USING btree (campaign_id);


--
-- Name: index_impressions_2024_01_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_01_on_campaign_name ON public.impressions_2024_01 USING btree (campaign_name);


--
-- Name: index_impressions_2024_01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_01_on_displayed_at_date ON public.impressions_2024_01 USING btree (displayed_at_date);


--
-- Name: index_impressions_2024_01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_01_on_displayed_at_hour ON public.impressions_2024_01 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2024_01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_01_on_payable ON public.impressions_2024_01 USING btree (payable);


--
-- Name: index_impressions_2024_01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_01_on_property_id ON public.impressions_2024_01 USING btree (property_id);


--
-- Name: index_impressions_2024_01_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_01_on_property_name ON public.impressions_2024_01 USING btree (property_name);


--
-- Name: index_impressions_2024_02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_02_on_campaign_id ON public.impressions_2024_02 USING btree (campaign_id);


--
-- Name: index_impressions_2024_02_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_02_on_campaign_name ON public.impressions_2024_02 USING btree (campaign_name);


--
-- Name: index_impressions_2024_02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_02_on_displayed_at_date ON public.impressions_2024_02 USING btree (displayed_at_date);


--
-- Name: index_impressions_2024_02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_02_on_displayed_at_hour ON public.impressions_2024_02 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2024_02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_02_on_payable ON public.impressions_2024_02 USING btree (payable);


--
-- Name: index_impressions_2024_02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_02_on_property_id ON public.impressions_2024_02 USING btree (property_id);


--
-- Name: index_impressions_2024_02_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_02_on_property_name ON public.impressions_2024_02 USING btree (property_name);


--
-- Name: index_impressions_2024_03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_03_on_campaign_id ON public.impressions_2024_03 USING btree (campaign_id);


--
-- Name: index_impressions_2024_03_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_03_on_campaign_name ON public.impressions_2024_03 USING btree (campaign_name);


--
-- Name: index_impressions_2024_03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_03_on_displayed_at_date ON public.impressions_2024_03 USING btree (displayed_at_date);


--
-- Name: index_impressions_2024_03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_03_on_displayed_at_hour ON public.impressions_2024_03 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2024_03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_03_on_payable ON public.impressions_2024_03 USING btree (payable);


--
-- Name: index_impressions_2024_03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_03_on_property_id ON public.impressions_2024_03 USING btree (property_id);


--
-- Name: index_impressions_2024_03_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_03_on_property_name ON public.impressions_2024_03 USING btree (property_name);


--
-- Name: index_impressions_2024_04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_04_on_campaign_id ON public.impressions_2024_04 USING btree (campaign_id);


--
-- Name: index_impressions_2024_04_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_04_on_campaign_name ON public.impressions_2024_04 USING btree (campaign_name);


--
-- Name: index_impressions_2024_04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_04_on_displayed_at_date ON public.impressions_2024_04 USING btree (displayed_at_date);


--
-- Name: index_impressions_2024_04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_04_on_displayed_at_hour ON public.impressions_2024_04 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2024_04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_04_on_payable ON public.impressions_2024_04 USING btree (payable);


--
-- Name: index_impressions_2024_04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_04_on_property_id ON public.impressions_2024_04 USING btree (property_id);


--
-- Name: index_impressions_2024_04_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_04_on_property_name ON public.impressions_2024_04 USING btree (property_name);


--
-- Name: index_impressions_2024_05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_05_on_campaign_id ON public.impressions_2024_05 USING btree (campaign_id);


--
-- Name: index_impressions_2024_05_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_05_on_campaign_name ON public.impressions_2024_05 USING btree (campaign_name);


--
-- Name: index_impressions_2024_05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_05_on_displayed_at_date ON public.impressions_2024_05 USING btree (displayed_at_date);


--
-- Name: index_impressions_2024_05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_05_on_displayed_at_hour ON public.impressions_2024_05 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2024_05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_05_on_payable ON public.impressions_2024_05 USING btree (payable);


--
-- Name: index_impressions_2024_05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_05_on_property_id ON public.impressions_2024_05 USING btree (property_id);


--
-- Name: index_impressions_2024_05_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_05_on_property_name ON public.impressions_2024_05 USING btree (property_name);


--
-- Name: index_impressions_2024_06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_06_on_campaign_id ON public.impressions_2024_06 USING btree (campaign_id);


--
-- Name: index_impressions_2024_06_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_06_on_campaign_name ON public.impressions_2024_06 USING btree (campaign_name);


--
-- Name: index_impressions_2024_06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_06_on_displayed_at_date ON public.impressions_2024_06 USING btree (displayed_at_date);


--
-- Name: index_impressions_2024_06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_06_on_displayed_at_hour ON public.impressions_2024_06 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2024_06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_06_on_payable ON public.impressions_2024_06 USING btree (payable);


--
-- Name: index_impressions_2024_06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_06_on_property_id ON public.impressions_2024_06 USING btree (property_id);


--
-- Name: index_impressions_2024_06_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_06_on_property_name ON public.impressions_2024_06 USING btree (property_name);


--
-- Name: index_impressions_2024_07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_07_on_campaign_id ON public.impressions_2024_07 USING btree (campaign_id);


--
-- Name: index_impressions_2024_07_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_07_on_campaign_name ON public.impressions_2024_07 USING btree (campaign_name);


--
-- Name: index_impressions_2024_07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_07_on_displayed_at_date ON public.impressions_2024_07 USING btree (displayed_at_date);


--
-- Name: index_impressions_2024_07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_07_on_displayed_at_hour ON public.impressions_2024_07 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2024_07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_07_on_payable ON public.impressions_2024_07 USING btree (payable);


--
-- Name: index_impressions_2024_07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_07_on_property_id ON public.impressions_2024_07 USING btree (property_id);


--
-- Name: index_impressions_2024_07_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_07_on_property_name ON public.impressions_2024_07 USING btree (property_name);


--
-- Name: index_impressions_2024_08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_08_on_campaign_id ON public.impressions_2024_08 USING btree (campaign_id);


--
-- Name: index_impressions_2024_08_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_08_on_campaign_name ON public.impressions_2024_08 USING btree (campaign_name);


--
-- Name: index_impressions_2024_08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_08_on_displayed_at_date ON public.impressions_2024_08 USING btree (displayed_at_date);


--
-- Name: index_impressions_2024_08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_08_on_displayed_at_hour ON public.impressions_2024_08 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2024_08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_08_on_payable ON public.impressions_2024_08 USING btree (payable);


--
-- Name: index_impressions_2024_08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_08_on_property_id ON public.impressions_2024_08 USING btree (property_id);


--
-- Name: index_impressions_2024_08_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_08_on_property_name ON public.impressions_2024_08 USING btree (property_name);


--
-- Name: index_impressions_2024_09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_09_on_campaign_id ON public.impressions_2024_09 USING btree (campaign_id);


--
-- Name: index_impressions_2024_09_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_09_on_campaign_name ON public.impressions_2024_09 USING btree (campaign_name);


--
-- Name: index_impressions_2024_09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_09_on_displayed_at_date ON public.impressions_2024_09 USING btree (displayed_at_date);


--
-- Name: index_impressions_2024_09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_09_on_displayed_at_hour ON public.impressions_2024_09 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2024_09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_09_on_payable ON public.impressions_2024_09 USING btree (payable);


--
-- Name: index_impressions_2024_09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_09_on_property_id ON public.impressions_2024_09 USING btree (property_id);


--
-- Name: index_impressions_2024_09_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_09_on_property_name ON public.impressions_2024_09 USING btree (property_name);


--
-- Name: index_impressions_2024_10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_10_on_campaign_id ON public.impressions_2024_10 USING btree (campaign_id);


--
-- Name: index_impressions_2024_10_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_10_on_campaign_name ON public.impressions_2024_10 USING btree (campaign_name);


--
-- Name: index_impressions_2024_10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_10_on_displayed_at_date ON public.impressions_2024_10 USING btree (displayed_at_date);


--
-- Name: index_impressions_2024_10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_10_on_displayed_at_hour ON public.impressions_2024_10 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2024_10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_10_on_payable ON public.impressions_2024_10 USING btree (payable);


--
-- Name: index_impressions_2024_10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_10_on_property_id ON public.impressions_2024_10 USING btree (property_id);


--
-- Name: index_impressions_2024_10_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_10_on_property_name ON public.impressions_2024_10 USING btree (property_name);


--
-- Name: index_impressions_2024_11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_11_on_campaign_id ON public.impressions_2024_11 USING btree (campaign_id);


--
-- Name: index_impressions_2024_11_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_11_on_campaign_name ON public.impressions_2024_11 USING btree (campaign_name);


--
-- Name: index_impressions_2024_11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_11_on_displayed_at_date ON public.impressions_2024_11 USING btree (displayed_at_date);


--
-- Name: index_impressions_2024_11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_11_on_displayed_at_hour ON public.impressions_2024_11 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2024_11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_11_on_payable ON public.impressions_2024_11 USING btree (payable);


--
-- Name: index_impressions_2024_11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_11_on_property_id ON public.impressions_2024_11 USING btree (property_id);


--
-- Name: index_impressions_2024_11_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_11_on_property_name ON public.impressions_2024_11 USING btree (property_name);


--
-- Name: index_impressions_2024_12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_12_on_campaign_id ON public.impressions_2024_12 USING btree (campaign_id);


--
-- Name: index_impressions_2024_12_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_12_on_campaign_name ON public.impressions_2024_12 USING btree (campaign_name);


--
-- Name: index_impressions_2024_12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_12_on_displayed_at_date ON public.impressions_2024_12 USING btree (displayed_at_date);


--
-- Name: index_impressions_2024_12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_12_on_displayed_at_hour ON public.impressions_2024_12 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2024_12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_12_on_payable ON public.impressions_2024_12 USING btree (payable);


--
-- Name: index_impressions_2024_12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_12_on_property_id ON public.impressions_2024_12 USING btree (property_id);


--
-- Name: index_impressions_2024_12_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2024_12_on_property_name ON public.impressions_2024_12 USING btree (property_name);


--
-- Name: index_impressions_2025_01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_01_on_campaign_id ON public.impressions_2025_01 USING btree (campaign_id);


--
-- Name: index_impressions_2025_01_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_01_on_campaign_name ON public.impressions_2025_01 USING btree (campaign_name);


--
-- Name: index_impressions_2025_01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_01_on_displayed_at_date ON public.impressions_2025_01 USING btree (displayed_at_date);


--
-- Name: index_impressions_2025_01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_01_on_displayed_at_hour ON public.impressions_2025_01 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2025_01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_01_on_payable ON public.impressions_2025_01 USING btree (payable);


--
-- Name: index_impressions_2025_01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_01_on_property_id ON public.impressions_2025_01 USING btree (property_id);


--
-- Name: index_impressions_2025_01_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_01_on_property_name ON public.impressions_2025_01 USING btree (property_name);


--
-- Name: index_impressions_2025_02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_02_on_campaign_id ON public.impressions_2025_02 USING btree (campaign_id);


--
-- Name: index_impressions_2025_02_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_02_on_campaign_name ON public.impressions_2025_02 USING btree (campaign_name);


--
-- Name: index_impressions_2025_02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_02_on_displayed_at_date ON public.impressions_2025_02 USING btree (displayed_at_date);


--
-- Name: index_impressions_2025_02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_02_on_displayed_at_hour ON public.impressions_2025_02 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2025_02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_02_on_payable ON public.impressions_2025_02 USING btree (payable);


--
-- Name: index_impressions_2025_02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_02_on_property_id ON public.impressions_2025_02 USING btree (property_id);


--
-- Name: index_impressions_2025_02_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_02_on_property_name ON public.impressions_2025_02 USING btree (property_name);


--
-- Name: index_impressions_2025_03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_03_on_campaign_id ON public.impressions_2025_03 USING btree (campaign_id);


--
-- Name: index_impressions_2025_03_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_03_on_campaign_name ON public.impressions_2025_03 USING btree (campaign_name);


--
-- Name: index_impressions_2025_03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_03_on_displayed_at_date ON public.impressions_2025_03 USING btree (displayed_at_date);


--
-- Name: index_impressions_2025_03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_03_on_displayed_at_hour ON public.impressions_2025_03 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2025_03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_03_on_payable ON public.impressions_2025_03 USING btree (payable);


--
-- Name: index_impressions_2025_03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_03_on_property_id ON public.impressions_2025_03 USING btree (property_id);


--
-- Name: index_impressions_2025_03_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_03_on_property_name ON public.impressions_2025_03 USING btree (property_name);


--
-- Name: index_impressions_2025_04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_04_on_campaign_id ON public.impressions_2025_04 USING btree (campaign_id);


--
-- Name: index_impressions_2025_04_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_04_on_campaign_name ON public.impressions_2025_04 USING btree (campaign_name);


--
-- Name: index_impressions_2025_04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_04_on_displayed_at_date ON public.impressions_2025_04 USING btree (displayed_at_date);


--
-- Name: index_impressions_2025_04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_04_on_displayed_at_hour ON public.impressions_2025_04 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2025_04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_04_on_payable ON public.impressions_2025_04 USING btree (payable);


--
-- Name: index_impressions_2025_04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_04_on_property_id ON public.impressions_2025_04 USING btree (property_id);


--
-- Name: index_impressions_2025_04_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_04_on_property_name ON public.impressions_2025_04 USING btree (property_name);


--
-- Name: index_impressions_2025_05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_05_on_campaign_id ON public.impressions_2025_05 USING btree (campaign_id);


--
-- Name: index_impressions_2025_05_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_05_on_campaign_name ON public.impressions_2025_05 USING btree (campaign_name);


--
-- Name: index_impressions_2025_05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_05_on_displayed_at_date ON public.impressions_2025_05 USING btree (displayed_at_date);


--
-- Name: index_impressions_2025_05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_05_on_displayed_at_hour ON public.impressions_2025_05 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2025_05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_05_on_payable ON public.impressions_2025_05 USING btree (payable);


--
-- Name: index_impressions_2025_05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_05_on_property_id ON public.impressions_2025_05 USING btree (property_id);


--
-- Name: index_impressions_2025_05_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_05_on_property_name ON public.impressions_2025_05 USING btree (property_name);


--
-- Name: index_impressions_2025_06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_06_on_campaign_id ON public.impressions_2025_06 USING btree (campaign_id);


--
-- Name: index_impressions_2025_06_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_06_on_campaign_name ON public.impressions_2025_06 USING btree (campaign_name);


--
-- Name: index_impressions_2025_06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_06_on_displayed_at_date ON public.impressions_2025_06 USING btree (displayed_at_date);


--
-- Name: index_impressions_2025_06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_06_on_displayed_at_hour ON public.impressions_2025_06 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2025_06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_06_on_payable ON public.impressions_2025_06 USING btree (payable);


--
-- Name: index_impressions_2025_06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_06_on_property_id ON public.impressions_2025_06 USING btree (property_id);


--
-- Name: index_impressions_2025_06_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_06_on_property_name ON public.impressions_2025_06 USING btree (property_name);


--
-- Name: index_impressions_2025_07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_07_on_campaign_id ON public.impressions_2025_07 USING btree (campaign_id);


--
-- Name: index_impressions_2025_07_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_07_on_campaign_name ON public.impressions_2025_07 USING btree (campaign_name);


--
-- Name: index_impressions_2025_07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_07_on_displayed_at_date ON public.impressions_2025_07 USING btree (displayed_at_date);


--
-- Name: index_impressions_2025_07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_07_on_displayed_at_hour ON public.impressions_2025_07 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2025_07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_07_on_payable ON public.impressions_2025_07 USING btree (payable);


--
-- Name: index_impressions_2025_07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_07_on_property_id ON public.impressions_2025_07 USING btree (property_id);


--
-- Name: index_impressions_2025_07_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_07_on_property_name ON public.impressions_2025_07 USING btree (property_name);


--
-- Name: index_impressions_2025_08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_08_on_campaign_id ON public.impressions_2025_08 USING btree (campaign_id);


--
-- Name: index_impressions_2025_08_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_08_on_campaign_name ON public.impressions_2025_08 USING btree (campaign_name);


--
-- Name: index_impressions_2025_08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_08_on_displayed_at_date ON public.impressions_2025_08 USING btree (displayed_at_date);


--
-- Name: index_impressions_2025_08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_08_on_displayed_at_hour ON public.impressions_2025_08 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2025_08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_08_on_payable ON public.impressions_2025_08 USING btree (payable);


--
-- Name: index_impressions_2025_08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_08_on_property_id ON public.impressions_2025_08 USING btree (property_id);


--
-- Name: index_impressions_2025_08_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_08_on_property_name ON public.impressions_2025_08 USING btree (property_name);


--
-- Name: index_impressions_2025_09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_09_on_campaign_id ON public.impressions_2025_09 USING btree (campaign_id);


--
-- Name: index_impressions_2025_09_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_09_on_campaign_name ON public.impressions_2025_09 USING btree (campaign_name);


--
-- Name: index_impressions_2025_09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_09_on_displayed_at_date ON public.impressions_2025_09 USING btree (displayed_at_date);


--
-- Name: index_impressions_2025_09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_09_on_displayed_at_hour ON public.impressions_2025_09 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2025_09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_09_on_payable ON public.impressions_2025_09 USING btree (payable);


--
-- Name: index_impressions_2025_09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_09_on_property_id ON public.impressions_2025_09 USING btree (property_id);


--
-- Name: index_impressions_2025_09_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_09_on_property_name ON public.impressions_2025_09 USING btree (property_name);


--
-- Name: index_impressions_2025_10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_10_on_campaign_id ON public.impressions_2025_10 USING btree (campaign_id);


--
-- Name: index_impressions_2025_10_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_10_on_campaign_name ON public.impressions_2025_10 USING btree (campaign_name);


--
-- Name: index_impressions_2025_10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_10_on_displayed_at_date ON public.impressions_2025_10 USING btree (displayed_at_date);


--
-- Name: index_impressions_2025_10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_10_on_displayed_at_hour ON public.impressions_2025_10 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2025_10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_10_on_payable ON public.impressions_2025_10 USING btree (payable);


--
-- Name: index_impressions_2025_10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_10_on_property_id ON public.impressions_2025_10 USING btree (property_id);


--
-- Name: index_impressions_2025_10_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_10_on_property_name ON public.impressions_2025_10 USING btree (property_name);


--
-- Name: index_impressions_2025_11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_11_on_campaign_id ON public.impressions_2025_11 USING btree (campaign_id);


--
-- Name: index_impressions_2025_11_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_11_on_campaign_name ON public.impressions_2025_11 USING btree (campaign_name);


--
-- Name: index_impressions_2025_11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_11_on_displayed_at_date ON public.impressions_2025_11 USING btree (displayed_at_date);


--
-- Name: index_impressions_2025_11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_11_on_displayed_at_hour ON public.impressions_2025_11 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2025_11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_11_on_payable ON public.impressions_2025_11 USING btree (payable);


--
-- Name: index_impressions_2025_11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_11_on_property_id ON public.impressions_2025_11 USING btree (property_id);


--
-- Name: index_impressions_2025_11_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_11_on_property_name ON public.impressions_2025_11 USING btree (property_name);


--
-- Name: index_impressions_2025_12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_12_on_campaign_id ON public.impressions_2025_12 USING btree (campaign_id);


--
-- Name: index_impressions_2025_12_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_12_on_campaign_name ON public.impressions_2025_12 USING btree (campaign_name);


--
-- Name: index_impressions_2025_12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_12_on_displayed_at_date ON public.impressions_2025_12 USING btree (displayed_at_date);


--
-- Name: index_impressions_2025_12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_12_on_displayed_at_hour ON public.impressions_2025_12 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2025_12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_12_on_payable ON public.impressions_2025_12 USING btree (payable);


--
-- Name: index_impressions_2025_12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_12_on_property_id ON public.impressions_2025_12 USING btree (property_id);


--
-- Name: index_impressions_2025_12_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2025_12_on_property_name ON public.impressions_2025_12 USING btree (property_name);


--
-- Name: index_impressions_2026_01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_01_on_campaign_id ON public.impressions_2026_01 USING btree (campaign_id);


--
-- Name: index_impressions_2026_01_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_01_on_campaign_name ON public.impressions_2026_01 USING btree (campaign_name);


--
-- Name: index_impressions_2026_01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_01_on_displayed_at_date ON public.impressions_2026_01 USING btree (displayed_at_date);


--
-- Name: index_impressions_2026_01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_01_on_displayed_at_hour ON public.impressions_2026_01 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2026_01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_01_on_payable ON public.impressions_2026_01 USING btree (payable);


--
-- Name: index_impressions_2026_01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_01_on_property_id ON public.impressions_2026_01 USING btree (property_id);


--
-- Name: index_impressions_2026_01_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_01_on_property_name ON public.impressions_2026_01 USING btree (property_name);


--
-- Name: index_impressions_2026_02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_02_on_campaign_id ON public.impressions_2026_02 USING btree (campaign_id);


--
-- Name: index_impressions_2026_02_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_02_on_campaign_name ON public.impressions_2026_02 USING btree (campaign_name);


--
-- Name: index_impressions_2026_02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_02_on_displayed_at_date ON public.impressions_2026_02 USING btree (displayed_at_date);


--
-- Name: index_impressions_2026_02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_02_on_displayed_at_hour ON public.impressions_2026_02 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2026_02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_02_on_payable ON public.impressions_2026_02 USING btree (payable);


--
-- Name: index_impressions_2026_02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_02_on_property_id ON public.impressions_2026_02 USING btree (property_id);


--
-- Name: index_impressions_2026_02_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_02_on_property_name ON public.impressions_2026_02 USING btree (property_name);


--
-- Name: index_impressions_2026_03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_03_on_campaign_id ON public.impressions_2026_03 USING btree (campaign_id);


--
-- Name: index_impressions_2026_03_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_03_on_campaign_name ON public.impressions_2026_03 USING btree (campaign_name);


--
-- Name: index_impressions_2026_03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_03_on_displayed_at_date ON public.impressions_2026_03 USING btree (displayed_at_date);


--
-- Name: index_impressions_2026_03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_03_on_displayed_at_hour ON public.impressions_2026_03 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2026_03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_03_on_payable ON public.impressions_2026_03 USING btree (payable);


--
-- Name: index_impressions_2026_03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_03_on_property_id ON public.impressions_2026_03 USING btree (property_id);


--
-- Name: index_impressions_2026_03_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_03_on_property_name ON public.impressions_2026_03 USING btree (property_name);


--
-- Name: index_impressions_2026_04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_04_on_campaign_id ON public.impressions_2026_04 USING btree (campaign_id);


--
-- Name: index_impressions_2026_04_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_04_on_campaign_name ON public.impressions_2026_04 USING btree (campaign_name);


--
-- Name: index_impressions_2026_04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_04_on_displayed_at_date ON public.impressions_2026_04 USING btree (displayed_at_date);


--
-- Name: index_impressions_2026_04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_04_on_displayed_at_hour ON public.impressions_2026_04 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2026_04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_04_on_payable ON public.impressions_2026_04 USING btree (payable);


--
-- Name: index_impressions_2026_04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_04_on_property_id ON public.impressions_2026_04 USING btree (property_id);


--
-- Name: index_impressions_2026_04_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_04_on_property_name ON public.impressions_2026_04 USING btree (property_name);


--
-- Name: index_impressions_2026_05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_05_on_campaign_id ON public.impressions_2026_05 USING btree (campaign_id);


--
-- Name: index_impressions_2026_05_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_05_on_campaign_name ON public.impressions_2026_05 USING btree (campaign_name);


--
-- Name: index_impressions_2026_05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_05_on_displayed_at_date ON public.impressions_2026_05 USING btree (displayed_at_date);


--
-- Name: index_impressions_2026_05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_05_on_displayed_at_hour ON public.impressions_2026_05 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2026_05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_05_on_payable ON public.impressions_2026_05 USING btree (payable);


--
-- Name: index_impressions_2026_05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_05_on_property_id ON public.impressions_2026_05 USING btree (property_id);


--
-- Name: index_impressions_2026_05_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_05_on_property_name ON public.impressions_2026_05 USING btree (property_name);


--
-- Name: index_impressions_2026_06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_06_on_campaign_id ON public.impressions_2026_06 USING btree (campaign_id);


--
-- Name: index_impressions_2026_06_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_06_on_campaign_name ON public.impressions_2026_06 USING btree (campaign_name);


--
-- Name: index_impressions_2026_06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_06_on_displayed_at_date ON public.impressions_2026_06 USING btree (displayed_at_date);


--
-- Name: index_impressions_2026_06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_06_on_displayed_at_hour ON public.impressions_2026_06 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2026_06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_06_on_payable ON public.impressions_2026_06 USING btree (payable);


--
-- Name: index_impressions_2026_06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_06_on_property_id ON public.impressions_2026_06 USING btree (property_id);


--
-- Name: index_impressions_2026_06_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_06_on_property_name ON public.impressions_2026_06 USING btree (property_name);


--
-- Name: index_impressions_2026_07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_07_on_campaign_id ON public.impressions_2026_07 USING btree (campaign_id);


--
-- Name: index_impressions_2026_07_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_07_on_campaign_name ON public.impressions_2026_07 USING btree (campaign_name);


--
-- Name: index_impressions_2026_07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_07_on_displayed_at_date ON public.impressions_2026_07 USING btree (displayed_at_date);


--
-- Name: index_impressions_2026_07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_07_on_displayed_at_hour ON public.impressions_2026_07 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2026_07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_07_on_payable ON public.impressions_2026_07 USING btree (payable);


--
-- Name: index_impressions_2026_07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_07_on_property_id ON public.impressions_2026_07 USING btree (property_id);


--
-- Name: index_impressions_2026_07_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_07_on_property_name ON public.impressions_2026_07 USING btree (property_name);


--
-- Name: index_impressions_2026_08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_08_on_campaign_id ON public.impressions_2026_08 USING btree (campaign_id);


--
-- Name: index_impressions_2026_08_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_08_on_campaign_name ON public.impressions_2026_08 USING btree (campaign_name);


--
-- Name: index_impressions_2026_08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_08_on_displayed_at_date ON public.impressions_2026_08 USING btree (displayed_at_date);


--
-- Name: index_impressions_2026_08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_08_on_displayed_at_hour ON public.impressions_2026_08 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2026_08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_08_on_payable ON public.impressions_2026_08 USING btree (payable);


--
-- Name: index_impressions_2026_08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_08_on_property_id ON public.impressions_2026_08 USING btree (property_id);


--
-- Name: index_impressions_2026_08_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_08_on_property_name ON public.impressions_2026_08 USING btree (property_name);


--
-- Name: index_impressions_2026_09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_09_on_campaign_id ON public.impressions_2026_09 USING btree (campaign_id);


--
-- Name: index_impressions_2026_09_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_09_on_campaign_name ON public.impressions_2026_09 USING btree (campaign_name);


--
-- Name: index_impressions_2026_09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_09_on_displayed_at_date ON public.impressions_2026_09 USING btree (displayed_at_date);


--
-- Name: index_impressions_2026_09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_09_on_displayed_at_hour ON public.impressions_2026_09 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2026_09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_09_on_payable ON public.impressions_2026_09 USING btree (payable);


--
-- Name: index_impressions_2026_09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_09_on_property_id ON public.impressions_2026_09 USING btree (property_id);


--
-- Name: index_impressions_2026_09_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_09_on_property_name ON public.impressions_2026_09 USING btree (property_name);


--
-- Name: index_impressions_2026_10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_10_on_campaign_id ON public.impressions_2026_10 USING btree (campaign_id);


--
-- Name: index_impressions_2026_10_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_10_on_campaign_name ON public.impressions_2026_10 USING btree (campaign_name);


--
-- Name: index_impressions_2026_10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_10_on_displayed_at_date ON public.impressions_2026_10 USING btree (displayed_at_date);


--
-- Name: index_impressions_2026_10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_10_on_displayed_at_hour ON public.impressions_2026_10 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2026_10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_10_on_payable ON public.impressions_2026_10 USING btree (payable);


--
-- Name: index_impressions_2026_10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_10_on_property_id ON public.impressions_2026_10 USING btree (property_id);


--
-- Name: index_impressions_2026_10_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_10_on_property_name ON public.impressions_2026_10 USING btree (property_name);


--
-- Name: index_impressions_2026_11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_11_on_campaign_id ON public.impressions_2026_11 USING btree (campaign_id);


--
-- Name: index_impressions_2026_11_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_11_on_campaign_name ON public.impressions_2026_11 USING btree (campaign_name);


--
-- Name: index_impressions_2026_11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_11_on_displayed_at_date ON public.impressions_2026_11 USING btree (displayed_at_date);


--
-- Name: index_impressions_2026_11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_11_on_displayed_at_hour ON public.impressions_2026_11 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2026_11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_11_on_payable ON public.impressions_2026_11 USING btree (payable);


--
-- Name: index_impressions_2026_11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_11_on_property_id ON public.impressions_2026_11 USING btree (property_id);


--
-- Name: index_impressions_2026_11_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_11_on_property_name ON public.impressions_2026_11 USING btree (property_name);


--
-- Name: index_impressions_2026_12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_12_on_campaign_id ON public.impressions_2026_12 USING btree (campaign_id);


--
-- Name: index_impressions_2026_12_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_12_on_campaign_name ON public.impressions_2026_12 USING btree (campaign_name);


--
-- Name: index_impressions_2026_12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_12_on_displayed_at_date ON public.impressions_2026_12 USING btree (displayed_at_date);


--
-- Name: index_impressions_2026_12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_12_on_displayed_at_hour ON public.impressions_2026_12 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2026_12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_12_on_payable ON public.impressions_2026_12 USING btree (payable);


--
-- Name: index_impressions_2026_12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_12_on_property_id ON public.impressions_2026_12 USING btree (property_id);


--
-- Name: index_impressions_2026_12_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2026_12_on_property_name ON public.impressions_2026_12 USING btree (property_name);


--
-- Name: index_impressions_2027_01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_01_on_campaign_id ON public.impressions_2027_01 USING btree (campaign_id);


--
-- Name: index_impressions_2027_01_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_01_on_campaign_name ON public.impressions_2027_01 USING btree (campaign_name);


--
-- Name: index_impressions_2027_01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_01_on_displayed_at_date ON public.impressions_2027_01 USING btree (displayed_at_date);


--
-- Name: index_impressions_2027_01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_01_on_displayed_at_hour ON public.impressions_2027_01 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2027_01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_01_on_payable ON public.impressions_2027_01 USING btree (payable);


--
-- Name: index_impressions_2027_01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_01_on_property_id ON public.impressions_2027_01 USING btree (property_id);


--
-- Name: index_impressions_2027_01_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_01_on_property_name ON public.impressions_2027_01 USING btree (property_name);


--
-- Name: index_impressions_2027_02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_02_on_campaign_id ON public.impressions_2027_02 USING btree (campaign_id);


--
-- Name: index_impressions_2027_02_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_02_on_campaign_name ON public.impressions_2027_02 USING btree (campaign_name);


--
-- Name: index_impressions_2027_02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_02_on_displayed_at_date ON public.impressions_2027_02 USING btree (displayed_at_date);


--
-- Name: index_impressions_2027_02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_02_on_displayed_at_hour ON public.impressions_2027_02 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2027_02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_02_on_payable ON public.impressions_2027_02 USING btree (payable);


--
-- Name: index_impressions_2027_02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_02_on_property_id ON public.impressions_2027_02 USING btree (property_id);


--
-- Name: index_impressions_2027_02_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_02_on_property_name ON public.impressions_2027_02 USING btree (property_name);


--
-- Name: index_impressions_2027_03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_03_on_campaign_id ON public.impressions_2027_03 USING btree (campaign_id);


--
-- Name: index_impressions_2027_03_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_03_on_campaign_name ON public.impressions_2027_03 USING btree (campaign_name);


--
-- Name: index_impressions_2027_03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_03_on_displayed_at_date ON public.impressions_2027_03 USING btree (displayed_at_date);


--
-- Name: index_impressions_2027_03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_03_on_displayed_at_hour ON public.impressions_2027_03 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2027_03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_03_on_payable ON public.impressions_2027_03 USING btree (payable);


--
-- Name: index_impressions_2027_03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_03_on_property_id ON public.impressions_2027_03 USING btree (property_id);


--
-- Name: index_impressions_2027_03_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_03_on_property_name ON public.impressions_2027_03 USING btree (property_name);


--
-- Name: index_impressions_2027_04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_04_on_campaign_id ON public.impressions_2027_04 USING btree (campaign_id);


--
-- Name: index_impressions_2027_04_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_04_on_campaign_name ON public.impressions_2027_04 USING btree (campaign_name);


--
-- Name: index_impressions_2027_04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_04_on_displayed_at_date ON public.impressions_2027_04 USING btree (displayed_at_date);


--
-- Name: index_impressions_2027_04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_04_on_displayed_at_hour ON public.impressions_2027_04 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2027_04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_04_on_payable ON public.impressions_2027_04 USING btree (payable);


--
-- Name: index_impressions_2027_04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_04_on_property_id ON public.impressions_2027_04 USING btree (property_id);


--
-- Name: index_impressions_2027_04_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_04_on_property_name ON public.impressions_2027_04 USING btree (property_name);


--
-- Name: index_impressions_2027_05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_05_on_campaign_id ON public.impressions_2027_05 USING btree (campaign_id);


--
-- Name: index_impressions_2027_05_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_05_on_campaign_name ON public.impressions_2027_05 USING btree (campaign_name);


--
-- Name: index_impressions_2027_05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_05_on_displayed_at_date ON public.impressions_2027_05 USING btree (displayed_at_date);


--
-- Name: index_impressions_2027_05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_05_on_displayed_at_hour ON public.impressions_2027_05 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2027_05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_05_on_payable ON public.impressions_2027_05 USING btree (payable);


--
-- Name: index_impressions_2027_05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_05_on_property_id ON public.impressions_2027_05 USING btree (property_id);


--
-- Name: index_impressions_2027_05_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_05_on_property_name ON public.impressions_2027_05 USING btree (property_name);


--
-- Name: index_impressions_2027_06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_06_on_campaign_id ON public.impressions_2027_06 USING btree (campaign_id);


--
-- Name: index_impressions_2027_06_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_06_on_campaign_name ON public.impressions_2027_06 USING btree (campaign_name);


--
-- Name: index_impressions_2027_06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_06_on_displayed_at_date ON public.impressions_2027_06 USING btree (displayed_at_date);


--
-- Name: index_impressions_2027_06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_06_on_displayed_at_hour ON public.impressions_2027_06 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2027_06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_06_on_payable ON public.impressions_2027_06 USING btree (payable);


--
-- Name: index_impressions_2027_06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_06_on_property_id ON public.impressions_2027_06 USING btree (property_id);


--
-- Name: index_impressions_2027_06_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_06_on_property_name ON public.impressions_2027_06 USING btree (property_name);


--
-- Name: index_impressions_2027_07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_07_on_campaign_id ON public.impressions_2027_07 USING btree (campaign_id);


--
-- Name: index_impressions_2027_07_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_07_on_campaign_name ON public.impressions_2027_07 USING btree (campaign_name);


--
-- Name: index_impressions_2027_07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_07_on_displayed_at_date ON public.impressions_2027_07 USING btree (displayed_at_date);


--
-- Name: index_impressions_2027_07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_07_on_displayed_at_hour ON public.impressions_2027_07 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2027_07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_07_on_payable ON public.impressions_2027_07 USING btree (payable);


--
-- Name: index_impressions_2027_07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_07_on_property_id ON public.impressions_2027_07 USING btree (property_id);


--
-- Name: index_impressions_2027_07_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_07_on_property_name ON public.impressions_2027_07 USING btree (property_name);


--
-- Name: index_impressions_2027_08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_08_on_campaign_id ON public.impressions_2027_08 USING btree (campaign_id);


--
-- Name: index_impressions_2027_08_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_08_on_campaign_name ON public.impressions_2027_08 USING btree (campaign_name);


--
-- Name: index_impressions_2027_08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_08_on_displayed_at_date ON public.impressions_2027_08 USING btree (displayed_at_date);


--
-- Name: index_impressions_2027_08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_08_on_displayed_at_hour ON public.impressions_2027_08 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2027_08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_08_on_payable ON public.impressions_2027_08 USING btree (payable);


--
-- Name: index_impressions_2027_08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_08_on_property_id ON public.impressions_2027_08 USING btree (property_id);


--
-- Name: index_impressions_2027_08_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_08_on_property_name ON public.impressions_2027_08 USING btree (property_name);


--
-- Name: index_impressions_2027_09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_09_on_campaign_id ON public.impressions_2027_09 USING btree (campaign_id);


--
-- Name: index_impressions_2027_09_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_09_on_campaign_name ON public.impressions_2027_09 USING btree (campaign_name);


--
-- Name: index_impressions_2027_09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_09_on_displayed_at_date ON public.impressions_2027_09 USING btree (displayed_at_date);


--
-- Name: index_impressions_2027_09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_09_on_displayed_at_hour ON public.impressions_2027_09 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2027_09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_09_on_payable ON public.impressions_2027_09 USING btree (payable);


--
-- Name: index_impressions_2027_09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_09_on_property_id ON public.impressions_2027_09 USING btree (property_id);


--
-- Name: index_impressions_2027_09_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_09_on_property_name ON public.impressions_2027_09 USING btree (property_name);


--
-- Name: index_impressions_2027_10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_10_on_campaign_id ON public.impressions_2027_10 USING btree (campaign_id);


--
-- Name: index_impressions_2027_10_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_10_on_campaign_name ON public.impressions_2027_10 USING btree (campaign_name);


--
-- Name: index_impressions_2027_10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_10_on_displayed_at_date ON public.impressions_2027_10 USING btree (displayed_at_date);


--
-- Name: index_impressions_2027_10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_10_on_displayed_at_hour ON public.impressions_2027_10 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2027_10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_10_on_payable ON public.impressions_2027_10 USING btree (payable);


--
-- Name: index_impressions_2027_10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_10_on_property_id ON public.impressions_2027_10 USING btree (property_id);


--
-- Name: index_impressions_2027_10_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_10_on_property_name ON public.impressions_2027_10 USING btree (property_name);


--
-- Name: index_impressions_2027_11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_11_on_campaign_id ON public.impressions_2027_11 USING btree (campaign_id);


--
-- Name: index_impressions_2027_11_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_11_on_campaign_name ON public.impressions_2027_11 USING btree (campaign_name);


--
-- Name: index_impressions_2027_11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_11_on_displayed_at_date ON public.impressions_2027_11 USING btree (displayed_at_date);


--
-- Name: index_impressions_2027_11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_11_on_displayed_at_hour ON public.impressions_2027_11 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2027_11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_11_on_payable ON public.impressions_2027_11 USING btree (payable);


--
-- Name: index_impressions_2027_11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_11_on_property_id ON public.impressions_2027_11 USING btree (property_id);


--
-- Name: index_impressions_2027_11_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_11_on_property_name ON public.impressions_2027_11 USING btree (property_name);


--
-- Name: index_impressions_2027_12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_12_on_campaign_id ON public.impressions_2027_12 USING btree (campaign_id);


--
-- Name: index_impressions_2027_12_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_12_on_campaign_name ON public.impressions_2027_12 USING btree (campaign_name);


--
-- Name: index_impressions_2027_12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_12_on_displayed_at_date ON public.impressions_2027_12 USING btree (displayed_at_date);


--
-- Name: index_impressions_2027_12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_12_on_displayed_at_hour ON public.impressions_2027_12 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2027_12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_12_on_payable ON public.impressions_2027_12 USING btree (payable);


--
-- Name: index_impressions_2027_12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_12_on_property_id ON public.impressions_2027_12 USING btree (property_id);


--
-- Name: index_impressions_2027_12_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2027_12_on_property_name ON public.impressions_2027_12 USING btree (property_name);


--
-- Name: index_impressions_2028_01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_01_on_campaign_id ON public.impressions_2028_01 USING btree (campaign_id);


--
-- Name: index_impressions_2028_01_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_01_on_campaign_name ON public.impressions_2028_01 USING btree (campaign_name);


--
-- Name: index_impressions_2028_01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_01_on_displayed_at_date ON public.impressions_2028_01 USING btree (displayed_at_date);


--
-- Name: index_impressions_2028_01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_01_on_displayed_at_hour ON public.impressions_2028_01 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2028_01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_01_on_payable ON public.impressions_2028_01 USING btree (payable);


--
-- Name: index_impressions_2028_01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_01_on_property_id ON public.impressions_2028_01 USING btree (property_id);


--
-- Name: index_impressions_2028_01_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_01_on_property_name ON public.impressions_2028_01 USING btree (property_name);


--
-- Name: index_impressions_2028_02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_02_on_campaign_id ON public.impressions_2028_02 USING btree (campaign_id);


--
-- Name: index_impressions_2028_02_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_02_on_campaign_name ON public.impressions_2028_02 USING btree (campaign_name);


--
-- Name: index_impressions_2028_02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_02_on_displayed_at_date ON public.impressions_2028_02 USING btree (displayed_at_date);


--
-- Name: index_impressions_2028_02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_02_on_displayed_at_hour ON public.impressions_2028_02 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2028_02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_02_on_payable ON public.impressions_2028_02 USING btree (payable);


--
-- Name: index_impressions_2028_02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_02_on_property_id ON public.impressions_2028_02 USING btree (property_id);


--
-- Name: index_impressions_2028_02_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_02_on_property_name ON public.impressions_2028_02 USING btree (property_name);


--
-- Name: index_impressions_2028_03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_03_on_campaign_id ON public.impressions_2028_03 USING btree (campaign_id);


--
-- Name: index_impressions_2028_03_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_03_on_campaign_name ON public.impressions_2028_03 USING btree (campaign_name);


--
-- Name: index_impressions_2028_03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_03_on_displayed_at_date ON public.impressions_2028_03 USING btree (displayed_at_date);


--
-- Name: index_impressions_2028_03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_03_on_displayed_at_hour ON public.impressions_2028_03 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2028_03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_03_on_payable ON public.impressions_2028_03 USING btree (payable);


--
-- Name: index_impressions_2028_03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_03_on_property_id ON public.impressions_2028_03 USING btree (property_id);


--
-- Name: index_impressions_2028_03_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_03_on_property_name ON public.impressions_2028_03 USING btree (property_name);


--
-- Name: index_impressions_2028_04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_04_on_campaign_id ON public.impressions_2028_04 USING btree (campaign_id);


--
-- Name: index_impressions_2028_04_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_04_on_campaign_name ON public.impressions_2028_04 USING btree (campaign_name);


--
-- Name: index_impressions_2028_04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_04_on_displayed_at_date ON public.impressions_2028_04 USING btree (displayed_at_date);


--
-- Name: index_impressions_2028_04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_04_on_displayed_at_hour ON public.impressions_2028_04 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2028_04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_04_on_payable ON public.impressions_2028_04 USING btree (payable);


--
-- Name: index_impressions_2028_04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_04_on_property_id ON public.impressions_2028_04 USING btree (property_id);


--
-- Name: index_impressions_2028_04_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_04_on_property_name ON public.impressions_2028_04 USING btree (property_name);


--
-- Name: index_impressions_2028_05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_05_on_campaign_id ON public.impressions_2028_05 USING btree (campaign_id);


--
-- Name: index_impressions_2028_05_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_05_on_campaign_name ON public.impressions_2028_05 USING btree (campaign_name);


--
-- Name: index_impressions_2028_05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_05_on_displayed_at_date ON public.impressions_2028_05 USING btree (displayed_at_date);


--
-- Name: index_impressions_2028_05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_05_on_displayed_at_hour ON public.impressions_2028_05 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2028_05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_05_on_payable ON public.impressions_2028_05 USING btree (payable);


--
-- Name: index_impressions_2028_05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_05_on_property_id ON public.impressions_2028_05 USING btree (property_id);


--
-- Name: index_impressions_2028_05_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_05_on_property_name ON public.impressions_2028_05 USING btree (property_name);


--
-- Name: index_impressions_2028_06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_06_on_campaign_id ON public.impressions_2028_06 USING btree (campaign_id);


--
-- Name: index_impressions_2028_06_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_06_on_campaign_name ON public.impressions_2028_06 USING btree (campaign_name);


--
-- Name: index_impressions_2028_06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_06_on_displayed_at_date ON public.impressions_2028_06 USING btree (displayed_at_date);


--
-- Name: index_impressions_2028_06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_06_on_displayed_at_hour ON public.impressions_2028_06 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2028_06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_06_on_payable ON public.impressions_2028_06 USING btree (payable);


--
-- Name: index_impressions_2028_06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_06_on_property_id ON public.impressions_2028_06 USING btree (property_id);


--
-- Name: index_impressions_2028_06_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_06_on_property_name ON public.impressions_2028_06 USING btree (property_name);


--
-- Name: index_impressions_2028_07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_07_on_campaign_id ON public.impressions_2028_07 USING btree (campaign_id);


--
-- Name: index_impressions_2028_07_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_07_on_campaign_name ON public.impressions_2028_07 USING btree (campaign_name);


--
-- Name: index_impressions_2028_07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_07_on_displayed_at_date ON public.impressions_2028_07 USING btree (displayed_at_date);


--
-- Name: index_impressions_2028_07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_07_on_displayed_at_hour ON public.impressions_2028_07 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2028_07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_07_on_payable ON public.impressions_2028_07 USING btree (payable);


--
-- Name: index_impressions_2028_07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_07_on_property_id ON public.impressions_2028_07 USING btree (property_id);


--
-- Name: index_impressions_2028_07_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_07_on_property_name ON public.impressions_2028_07 USING btree (property_name);


--
-- Name: index_impressions_2028_08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_08_on_campaign_id ON public.impressions_2028_08 USING btree (campaign_id);


--
-- Name: index_impressions_2028_08_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_08_on_campaign_name ON public.impressions_2028_08 USING btree (campaign_name);


--
-- Name: index_impressions_2028_08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_08_on_displayed_at_date ON public.impressions_2028_08 USING btree (displayed_at_date);


--
-- Name: index_impressions_2028_08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_08_on_displayed_at_hour ON public.impressions_2028_08 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2028_08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_08_on_payable ON public.impressions_2028_08 USING btree (payable);


--
-- Name: index_impressions_2028_08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_08_on_property_id ON public.impressions_2028_08 USING btree (property_id);


--
-- Name: index_impressions_2028_08_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_08_on_property_name ON public.impressions_2028_08 USING btree (property_name);


--
-- Name: index_impressions_2028_09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_09_on_campaign_id ON public.impressions_2028_09 USING btree (campaign_id);


--
-- Name: index_impressions_2028_09_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_09_on_campaign_name ON public.impressions_2028_09 USING btree (campaign_name);


--
-- Name: index_impressions_2028_09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_09_on_displayed_at_date ON public.impressions_2028_09 USING btree (displayed_at_date);


--
-- Name: index_impressions_2028_09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_09_on_displayed_at_hour ON public.impressions_2028_09 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2028_09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_09_on_payable ON public.impressions_2028_09 USING btree (payable);


--
-- Name: index_impressions_2028_09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_09_on_property_id ON public.impressions_2028_09 USING btree (property_id);


--
-- Name: index_impressions_2028_09_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_09_on_property_name ON public.impressions_2028_09 USING btree (property_name);


--
-- Name: index_impressions_2028_10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_10_on_campaign_id ON public.impressions_2028_10 USING btree (campaign_id);


--
-- Name: index_impressions_2028_10_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_10_on_campaign_name ON public.impressions_2028_10 USING btree (campaign_name);


--
-- Name: index_impressions_2028_10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_10_on_displayed_at_date ON public.impressions_2028_10 USING btree (displayed_at_date);


--
-- Name: index_impressions_2028_10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_10_on_displayed_at_hour ON public.impressions_2028_10 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2028_10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_10_on_payable ON public.impressions_2028_10 USING btree (payable);


--
-- Name: index_impressions_2028_10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_10_on_property_id ON public.impressions_2028_10 USING btree (property_id);


--
-- Name: index_impressions_2028_10_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_10_on_property_name ON public.impressions_2028_10 USING btree (property_name);


--
-- Name: index_impressions_2028_11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_11_on_campaign_id ON public.impressions_2028_11 USING btree (campaign_id);


--
-- Name: index_impressions_2028_11_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_11_on_campaign_name ON public.impressions_2028_11 USING btree (campaign_name);


--
-- Name: index_impressions_2028_11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_11_on_displayed_at_date ON public.impressions_2028_11 USING btree (displayed_at_date);


--
-- Name: index_impressions_2028_11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_11_on_displayed_at_hour ON public.impressions_2028_11 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2028_11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_11_on_payable ON public.impressions_2028_11 USING btree (payable);


--
-- Name: index_impressions_2028_11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_11_on_property_id ON public.impressions_2028_11 USING btree (property_id);


--
-- Name: index_impressions_2028_11_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_11_on_property_name ON public.impressions_2028_11 USING btree (property_name);


--
-- Name: index_impressions_2028_12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_12_on_campaign_id ON public.impressions_2028_12 USING btree (campaign_id);


--
-- Name: index_impressions_2028_12_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_12_on_campaign_name ON public.impressions_2028_12 USING btree (campaign_name);


--
-- Name: index_impressions_2028_12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_12_on_displayed_at_date ON public.impressions_2028_12 USING btree (displayed_at_date);


--
-- Name: index_impressions_2028_12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_12_on_displayed_at_hour ON public.impressions_2028_12 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2028_12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_12_on_payable ON public.impressions_2028_12 USING btree (payable);


--
-- Name: index_impressions_2028_12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_12_on_property_id ON public.impressions_2028_12 USING btree (property_id);


--
-- Name: index_impressions_2028_12_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2028_12_on_property_name ON public.impressions_2028_12 USING btree (property_name);


--
-- Name: index_impressions_2029_01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_01_on_campaign_id ON public.impressions_2029_01 USING btree (campaign_id);


--
-- Name: index_impressions_2029_01_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_01_on_campaign_name ON public.impressions_2029_01 USING btree (campaign_name);


--
-- Name: index_impressions_2029_01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_01_on_displayed_at_date ON public.impressions_2029_01 USING btree (displayed_at_date);


--
-- Name: index_impressions_2029_01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_01_on_displayed_at_hour ON public.impressions_2029_01 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2029_01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_01_on_payable ON public.impressions_2029_01 USING btree (payable);


--
-- Name: index_impressions_2029_01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_01_on_property_id ON public.impressions_2029_01 USING btree (property_id);


--
-- Name: index_impressions_2029_01_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_01_on_property_name ON public.impressions_2029_01 USING btree (property_name);


--
-- Name: index_impressions_2029_02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_02_on_campaign_id ON public.impressions_2029_02 USING btree (campaign_id);


--
-- Name: index_impressions_2029_02_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_02_on_campaign_name ON public.impressions_2029_02 USING btree (campaign_name);


--
-- Name: index_impressions_2029_02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_02_on_displayed_at_date ON public.impressions_2029_02 USING btree (displayed_at_date);


--
-- Name: index_impressions_2029_02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_02_on_displayed_at_hour ON public.impressions_2029_02 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2029_02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_02_on_payable ON public.impressions_2029_02 USING btree (payable);


--
-- Name: index_impressions_2029_02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_02_on_property_id ON public.impressions_2029_02 USING btree (property_id);


--
-- Name: index_impressions_2029_02_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_02_on_property_name ON public.impressions_2029_02 USING btree (property_name);


--
-- Name: index_impressions_2029_03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_03_on_campaign_id ON public.impressions_2029_03 USING btree (campaign_id);


--
-- Name: index_impressions_2029_03_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_03_on_campaign_name ON public.impressions_2029_03 USING btree (campaign_name);


--
-- Name: index_impressions_2029_03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_03_on_displayed_at_date ON public.impressions_2029_03 USING btree (displayed_at_date);


--
-- Name: index_impressions_2029_03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_03_on_displayed_at_hour ON public.impressions_2029_03 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2029_03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_03_on_payable ON public.impressions_2029_03 USING btree (payable);


--
-- Name: index_impressions_2029_03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_03_on_property_id ON public.impressions_2029_03 USING btree (property_id);


--
-- Name: index_impressions_2029_03_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_03_on_property_name ON public.impressions_2029_03 USING btree (property_name);


--
-- Name: index_impressions_2029_04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_04_on_campaign_id ON public.impressions_2029_04 USING btree (campaign_id);


--
-- Name: index_impressions_2029_04_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_04_on_campaign_name ON public.impressions_2029_04 USING btree (campaign_name);


--
-- Name: index_impressions_2029_04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_04_on_displayed_at_date ON public.impressions_2029_04 USING btree (displayed_at_date);


--
-- Name: index_impressions_2029_04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_04_on_displayed_at_hour ON public.impressions_2029_04 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2029_04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_04_on_payable ON public.impressions_2029_04 USING btree (payable);


--
-- Name: index_impressions_2029_04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_04_on_property_id ON public.impressions_2029_04 USING btree (property_id);


--
-- Name: index_impressions_2029_04_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_04_on_property_name ON public.impressions_2029_04 USING btree (property_name);


--
-- Name: index_impressions_2029_05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_05_on_campaign_id ON public.impressions_2029_05 USING btree (campaign_id);


--
-- Name: index_impressions_2029_05_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_05_on_campaign_name ON public.impressions_2029_05 USING btree (campaign_name);


--
-- Name: index_impressions_2029_05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_05_on_displayed_at_date ON public.impressions_2029_05 USING btree (displayed_at_date);


--
-- Name: index_impressions_2029_05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_05_on_displayed_at_hour ON public.impressions_2029_05 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2029_05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_05_on_payable ON public.impressions_2029_05 USING btree (payable);


--
-- Name: index_impressions_2029_05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_05_on_property_id ON public.impressions_2029_05 USING btree (property_id);


--
-- Name: index_impressions_2029_05_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_05_on_property_name ON public.impressions_2029_05 USING btree (property_name);


--
-- Name: index_impressions_2029_06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_06_on_campaign_id ON public.impressions_2029_06 USING btree (campaign_id);


--
-- Name: index_impressions_2029_06_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_06_on_campaign_name ON public.impressions_2029_06 USING btree (campaign_name);


--
-- Name: index_impressions_2029_06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_06_on_displayed_at_date ON public.impressions_2029_06 USING btree (displayed_at_date);


--
-- Name: index_impressions_2029_06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_06_on_displayed_at_hour ON public.impressions_2029_06 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2029_06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_06_on_payable ON public.impressions_2029_06 USING btree (payable);


--
-- Name: index_impressions_2029_06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_06_on_property_id ON public.impressions_2029_06 USING btree (property_id);


--
-- Name: index_impressions_2029_06_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_06_on_property_name ON public.impressions_2029_06 USING btree (property_name);


--
-- Name: index_impressions_2029_07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_07_on_campaign_id ON public.impressions_2029_07 USING btree (campaign_id);


--
-- Name: index_impressions_2029_07_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_07_on_campaign_name ON public.impressions_2029_07 USING btree (campaign_name);


--
-- Name: index_impressions_2029_07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_07_on_displayed_at_date ON public.impressions_2029_07 USING btree (displayed_at_date);


--
-- Name: index_impressions_2029_07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_07_on_displayed_at_hour ON public.impressions_2029_07 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2029_07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_07_on_payable ON public.impressions_2029_07 USING btree (payable);


--
-- Name: index_impressions_2029_07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_07_on_property_id ON public.impressions_2029_07 USING btree (property_id);


--
-- Name: index_impressions_2029_07_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_07_on_property_name ON public.impressions_2029_07 USING btree (property_name);


--
-- Name: index_impressions_2029_08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_08_on_campaign_id ON public.impressions_2029_08 USING btree (campaign_id);


--
-- Name: index_impressions_2029_08_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_08_on_campaign_name ON public.impressions_2029_08 USING btree (campaign_name);


--
-- Name: index_impressions_2029_08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_08_on_displayed_at_date ON public.impressions_2029_08 USING btree (displayed_at_date);


--
-- Name: index_impressions_2029_08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_08_on_displayed_at_hour ON public.impressions_2029_08 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2029_08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_08_on_payable ON public.impressions_2029_08 USING btree (payable);


--
-- Name: index_impressions_2029_08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_08_on_property_id ON public.impressions_2029_08 USING btree (property_id);


--
-- Name: index_impressions_2029_08_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_08_on_property_name ON public.impressions_2029_08 USING btree (property_name);


--
-- Name: index_impressions_2029_09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_09_on_campaign_id ON public.impressions_2029_09 USING btree (campaign_id);


--
-- Name: index_impressions_2029_09_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_09_on_campaign_name ON public.impressions_2029_09 USING btree (campaign_name);


--
-- Name: index_impressions_2029_09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_09_on_displayed_at_date ON public.impressions_2029_09 USING btree (displayed_at_date);


--
-- Name: index_impressions_2029_09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_09_on_displayed_at_hour ON public.impressions_2029_09 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2029_09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_09_on_payable ON public.impressions_2029_09 USING btree (payable);


--
-- Name: index_impressions_2029_09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_09_on_property_id ON public.impressions_2029_09 USING btree (property_id);


--
-- Name: index_impressions_2029_09_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_09_on_property_name ON public.impressions_2029_09 USING btree (property_name);


--
-- Name: index_impressions_2029_10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_10_on_campaign_id ON public.impressions_2029_10 USING btree (campaign_id);


--
-- Name: index_impressions_2029_10_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_10_on_campaign_name ON public.impressions_2029_10 USING btree (campaign_name);


--
-- Name: index_impressions_2029_10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_10_on_displayed_at_date ON public.impressions_2029_10 USING btree (displayed_at_date);


--
-- Name: index_impressions_2029_10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_10_on_displayed_at_hour ON public.impressions_2029_10 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2029_10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_10_on_payable ON public.impressions_2029_10 USING btree (payable);


--
-- Name: index_impressions_2029_10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_10_on_property_id ON public.impressions_2029_10 USING btree (property_id);


--
-- Name: index_impressions_2029_10_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_10_on_property_name ON public.impressions_2029_10 USING btree (property_name);


--
-- Name: index_impressions_2029_11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_11_on_campaign_id ON public.impressions_2029_11 USING btree (campaign_id);


--
-- Name: index_impressions_2029_11_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_11_on_campaign_name ON public.impressions_2029_11 USING btree (campaign_name);


--
-- Name: index_impressions_2029_11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_11_on_displayed_at_date ON public.impressions_2029_11 USING btree (displayed_at_date);


--
-- Name: index_impressions_2029_11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_11_on_displayed_at_hour ON public.impressions_2029_11 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2029_11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_11_on_payable ON public.impressions_2029_11 USING btree (payable);


--
-- Name: index_impressions_2029_11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_11_on_property_id ON public.impressions_2029_11 USING btree (property_id);


--
-- Name: index_impressions_2029_11_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_11_on_property_name ON public.impressions_2029_11 USING btree (property_name);


--
-- Name: index_impressions_2029_12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_12_on_campaign_id ON public.impressions_2029_12 USING btree (campaign_id);


--
-- Name: index_impressions_2029_12_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_12_on_campaign_name ON public.impressions_2029_12 USING btree (campaign_name);


--
-- Name: index_impressions_2029_12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_12_on_displayed_at_date ON public.impressions_2029_12 USING btree (displayed_at_date);


--
-- Name: index_impressions_2029_12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_12_on_displayed_at_hour ON public.impressions_2029_12 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2029_12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_12_on_payable ON public.impressions_2029_12 USING btree (payable);


--
-- Name: index_impressions_2029_12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_12_on_property_id ON public.impressions_2029_12 USING btree (property_id);


--
-- Name: index_impressions_2029_12_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2029_12_on_property_name ON public.impressions_2029_12 USING btree (property_name);


--
-- Name: index_impressions_2030_01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_01_on_campaign_id ON public.impressions_2030_01 USING btree (campaign_id);


--
-- Name: index_impressions_2030_01_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_01_on_campaign_name ON public.impressions_2030_01 USING btree (campaign_name);


--
-- Name: index_impressions_2030_01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_01_on_displayed_at_date ON public.impressions_2030_01 USING btree (displayed_at_date);


--
-- Name: index_impressions_2030_01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_01_on_displayed_at_hour ON public.impressions_2030_01 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2030_01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_01_on_payable ON public.impressions_2030_01 USING btree (payable);


--
-- Name: index_impressions_2030_01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_01_on_property_id ON public.impressions_2030_01 USING btree (property_id);


--
-- Name: index_impressions_2030_01_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_01_on_property_name ON public.impressions_2030_01 USING btree (property_name);


--
-- Name: index_impressions_2030_02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_02_on_campaign_id ON public.impressions_2030_02 USING btree (campaign_id);


--
-- Name: index_impressions_2030_02_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_02_on_campaign_name ON public.impressions_2030_02 USING btree (campaign_name);


--
-- Name: index_impressions_2030_02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_02_on_displayed_at_date ON public.impressions_2030_02 USING btree (displayed_at_date);


--
-- Name: index_impressions_2030_02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_02_on_displayed_at_hour ON public.impressions_2030_02 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2030_02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_02_on_payable ON public.impressions_2030_02 USING btree (payable);


--
-- Name: index_impressions_2030_02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_02_on_property_id ON public.impressions_2030_02 USING btree (property_id);


--
-- Name: index_impressions_2030_02_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_02_on_property_name ON public.impressions_2030_02 USING btree (property_name);


--
-- Name: index_impressions_2030_03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_03_on_campaign_id ON public.impressions_2030_03 USING btree (campaign_id);


--
-- Name: index_impressions_2030_03_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_03_on_campaign_name ON public.impressions_2030_03 USING btree (campaign_name);


--
-- Name: index_impressions_2030_03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_03_on_displayed_at_date ON public.impressions_2030_03 USING btree (displayed_at_date);


--
-- Name: index_impressions_2030_03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_03_on_displayed_at_hour ON public.impressions_2030_03 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2030_03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_03_on_payable ON public.impressions_2030_03 USING btree (payable);


--
-- Name: index_impressions_2030_03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_03_on_property_id ON public.impressions_2030_03 USING btree (property_id);


--
-- Name: index_impressions_2030_03_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_03_on_property_name ON public.impressions_2030_03 USING btree (property_name);


--
-- Name: index_impressions_2030_04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_04_on_campaign_id ON public.impressions_2030_04 USING btree (campaign_id);


--
-- Name: index_impressions_2030_04_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_04_on_campaign_name ON public.impressions_2030_04 USING btree (campaign_name);


--
-- Name: index_impressions_2030_04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_04_on_displayed_at_date ON public.impressions_2030_04 USING btree (displayed_at_date);


--
-- Name: index_impressions_2030_04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_04_on_displayed_at_hour ON public.impressions_2030_04 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2030_04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_04_on_payable ON public.impressions_2030_04 USING btree (payable);


--
-- Name: index_impressions_2030_04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_04_on_property_id ON public.impressions_2030_04 USING btree (property_id);


--
-- Name: index_impressions_2030_04_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_04_on_property_name ON public.impressions_2030_04 USING btree (property_name);


--
-- Name: index_impressions_2030_05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_05_on_campaign_id ON public.impressions_2030_05 USING btree (campaign_id);


--
-- Name: index_impressions_2030_05_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_05_on_campaign_name ON public.impressions_2030_05 USING btree (campaign_name);


--
-- Name: index_impressions_2030_05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_05_on_displayed_at_date ON public.impressions_2030_05 USING btree (displayed_at_date);


--
-- Name: index_impressions_2030_05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_05_on_displayed_at_hour ON public.impressions_2030_05 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2030_05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_05_on_payable ON public.impressions_2030_05 USING btree (payable);


--
-- Name: index_impressions_2030_05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_05_on_property_id ON public.impressions_2030_05 USING btree (property_id);


--
-- Name: index_impressions_2030_05_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_05_on_property_name ON public.impressions_2030_05 USING btree (property_name);


--
-- Name: index_impressions_2030_06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_06_on_campaign_id ON public.impressions_2030_06 USING btree (campaign_id);


--
-- Name: index_impressions_2030_06_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_06_on_campaign_name ON public.impressions_2030_06 USING btree (campaign_name);


--
-- Name: index_impressions_2030_06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_06_on_displayed_at_date ON public.impressions_2030_06 USING btree (displayed_at_date);


--
-- Name: index_impressions_2030_06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_06_on_displayed_at_hour ON public.impressions_2030_06 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2030_06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_06_on_payable ON public.impressions_2030_06 USING btree (payable);


--
-- Name: index_impressions_2030_06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_06_on_property_id ON public.impressions_2030_06 USING btree (property_id);


--
-- Name: index_impressions_2030_06_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_06_on_property_name ON public.impressions_2030_06 USING btree (property_name);


--
-- Name: index_impressions_2030_07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_07_on_campaign_id ON public.impressions_2030_07 USING btree (campaign_id);


--
-- Name: index_impressions_2030_07_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_07_on_campaign_name ON public.impressions_2030_07 USING btree (campaign_name);


--
-- Name: index_impressions_2030_07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_07_on_displayed_at_date ON public.impressions_2030_07 USING btree (displayed_at_date);


--
-- Name: index_impressions_2030_07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_07_on_displayed_at_hour ON public.impressions_2030_07 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2030_07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_07_on_payable ON public.impressions_2030_07 USING btree (payable);


--
-- Name: index_impressions_2030_07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_07_on_property_id ON public.impressions_2030_07 USING btree (property_id);


--
-- Name: index_impressions_2030_07_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_07_on_property_name ON public.impressions_2030_07 USING btree (property_name);


--
-- Name: index_impressions_2030_08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_08_on_campaign_id ON public.impressions_2030_08 USING btree (campaign_id);


--
-- Name: index_impressions_2030_08_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_08_on_campaign_name ON public.impressions_2030_08 USING btree (campaign_name);


--
-- Name: index_impressions_2030_08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_08_on_displayed_at_date ON public.impressions_2030_08 USING btree (displayed_at_date);


--
-- Name: index_impressions_2030_08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_08_on_displayed_at_hour ON public.impressions_2030_08 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2030_08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_08_on_payable ON public.impressions_2030_08 USING btree (payable);


--
-- Name: index_impressions_2030_08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_08_on_property_id ON public.impressions_2030_08 USING btree (property_id);


--
-- Name: index_impressions_2030_08_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_08_on_property_name ON public.impressions_2030_08 USING btree (property_name);


--
-- Name: index_impressions_2030_09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_09_on_campaign_id ON public.impressions_2030_09 USING btree (campaign_id);


--
-- Name: index_impressions_2030_09_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_09_on_campaign_name ON public.impressions_2030_09 USING btree (campaign_name);


--
-- Name: index_impressions_2030_09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_09_on_displayed_at_date ON public.impressions_2030_09 USING btree (displayed_at_date);


--
-- Name: index_impressions_2030_09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_09_on_displayed_at_hour ON public.impressions_2030_09 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2030_09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_09_on_payable ON public.impressions_2030_09 USING btree (payable);


--
-- Name: index_impressions_2030_09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_09_on_property_id ON public.impressions_2030_09 USING btree (property_id);


--
-- Name: index_impressions_2030_09_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_09_on_property_name ON public.impressions_2030_09 USING btree (property_name);


--
-- Name: index_impressions_2030_10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_10_on_campaign_id ON public.impressions_2030_10 USING btree (campaign_id);


--
-- Name: index_impressions_2030_10_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_10_on_campaign_name ON public.impressions_2030_10 USING btree (campaign_name);


--
-- Name: index_impressions_2030_10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_10_on_displayed_at_date ON public.impressions_2030_10 USING btree (displayed_at_date);


--
-- Name: index_impressions_2030_10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_10_on_displayed_at_hour ON public.impressions_2030_10 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2030_10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_10_on_payable ON public.impressions_2030_10 USING btree (payable);


--
-- Name: index_impressions_2030_10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_10_on_property_id ON public.impressions_2030_10 USING btree (property_id);


--
-- Name: index_impressions_2030_10_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_10_on_property_name ON public.impressions_2030_10 USING btree (property_name);


--
-- Name: index_impressions_2030_11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_11_on_campaign_id ON public.impressions_2030_11 USING btree (campaign_id);


--
-- Name: index_impressions_2030_11_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_11_on_campaign_name ON public.impressions_2030_11 USING btree (campaign_name);


--
-- Name: index_impressions_2030_11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_11_on_displayed_at_date ON public.impressions_2030_11 USING btree (displayed_at_date);


--
-- Name: index_impressions_2030_11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_11_on_displayed_at_hour ON public.impressions_2030_11 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2030_11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_11_on_payable ON public.impressions_2030_11 USING btree (payable);


--
-- Name: index_impressions_2030_11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_11_on_property_id ON public.impressions_2030_11 USING btree (property_id);


--
-- Name: index_impressions_2030_11_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_11_on_property_name ON public.impressions_2030_11 USING btree (property_name);


--
-- Name: index_impressions_2030_12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_12_on_campaign_id ON public.impressions_2030_12 USING btree (campaign_id);


--
-- Name: index_impressions_2030_12_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_12_on_campaign_name ON public.impressions_2030_12 USING btree (campaign_name);


--
-- Name: index_impressions_2030_12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_12_on_displayed_at_date ON public.impressions_2030_12 USING btree (displayed_at_date);


--
-- Name: index_impressions_2030_12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_12_on_displayed_at_hour ON public.impressions_2030_12 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2030_12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_12_on_payable ON public.impressions_2030_12 USING btree (payable);


--
-- Name: index_impressions_2030_12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_12_on_property_id ON public.impressions_2030_12 USING btree (property_id);


--
-- Name: index_impressions_2030_12_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2030_12_on_property_name ON public.impressions_2030_12 USING btree (property_name);


--
-- Name: index_impressions_default_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_default_on_campaign_id ON public.impressions_default USING btree (campaign_id);


--
-- Name: index_impressions_default_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_default_on_campaign_name ON public.impressions_default USING btree (campaign_name);


--
-- Name: index_impressions_default_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_default_on_displayed_at_date ON public.impressions_default USING btree (displayed_at_date);


--
-- Name: index_impressions_default_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_default_on_displayed_at_hour ON public.impressions_default USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_default_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_default_on_payable ON public.impressions_default USING btree (payable);


--
-- Name: index_impressions_default_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_default_on_property_id ON public.impressions_default USING btree (property_id);


--
-- Name: index_impressions_default_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_default_on_property_name ON public.impressions_default USING btree (property_name);


--
-- Name: index_properties_on_keywords; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_properties_on_keywords ON public.properties USING gin (keywords);


--
-- Name: index_properties_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_properties_on_name ON public.properties USING btree (lower((name)::text));


--
-- Name: index_properties_on_prohibited_advertisers; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_properties_on_prohibited_advertisers ON public.properties USING gin (prohibited_advertisers);


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
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_unlock_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_unlock_token ON public.users USING btree (unlock_token);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20181017152837');


