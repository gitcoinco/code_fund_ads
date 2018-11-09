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
    property_id bigint,
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
    fallback_campaign boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
)
PARTITION BY RANGE (displayed_at_date);


--
-- Name: impressions-2018-11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2018-11" PARTITION OF public.impressions
FOR VALUES FROM ('2018-11-01') TO ('2018-12-01');


--
-- Name: impressions-2018-12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2018-12" PARTITION OF public.impressions
FOR VALUES FROM ('2018-12-01') TO ('2019-01-01');


--
-- Name: impressions-2019-01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2019-01" PARTITION OF public.impressions
FOR VALUES FROM ('2019-01-01') TO ('2019-02-01');


--
-- Name: impressions-2019-02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2019-02" PARTITION OF public.impressions
FOR VALUES FROM ('2019-02-01') TO ('2019-03-01');


--
-- Name: impressions-2019-03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2019-03" PARTITION OF public.impressions
FOR VALUES FROM ('2019-03-01') TO ('2019-04-01');


--
-- Name: impressions-2019-04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2019-04" PARTITION OF public.impressions
FOR VALUES FROM ('2019-04-01') TO ('2019-05-01');


--
-- Name: impressions-2019-05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2019-05" PARTITION OF public.impressions
FOR VALUES FROM ('2019-05-01') TO ('2019-06-01');


--
-- Name: impressions-2019-06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2019-06" PARTITION OF public.impressions
FOR VALUES FROM ('2019-06-01') TO ('2019-07-01');


--
-- Name: impressions-2019-07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2019-07" PARTITION OF public.impressions
FOR VALUES FROM ('2019-07-01') TO ('2019-08-01');


--
-- Name: impressions-2019-08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2019-08" PARTITION OF public.impressions
FOR VALUES FROM ('2019-08-01') TO ('2019-09-01');


--
-- Name: impressions-2019-09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2019-09" PARTITION OF public.impressions
FOR VALUES FROM ('2019-09-01') TO ('2019-10-01');


--
-- Name: impressions-2019-10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2019-10" PARTITION OF public.impressions
FOR VALUES FROM ('2019-10-01') TO ('2019-11-01');


--
-- Name: impressions-2019-11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2019-11" PARTITION OF public.impressions
FOR VALUES FROM ('2019-11-01') TO ('2019-12-01');


--
-- Name: impressions-2019-12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2019-12" PARTITION OF public.impressions
FOR VALUES FROM ('2019-12-01') TO ('2020-01-01');


--
-- Name: impressions-2020-01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2020-01" PARTITION OF public.impressions
FOR VALUES FROM ('2020-01-01') TO ('2020-02-01');


--
-- Name: impressions-2020-02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2020-02" PARTITION OF public.impressions
FOR VALUES FROM ('2020-02-01') TO ('2020-03-01');


--
-- Name: impressions-2020-03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2020-03" PARTITION OF public.impressions
FOR VALUES FROM ('2020-03-01') TO ('2020-04-01');


--
-- Name: impressions-2020-04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2020-04" PARTITION OF public.impressions
FOR VALUES FROM ('2020-04-01') TO ('2020-05-01');


--
-- Name: impressions-2020-05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2020-05" PARTITION OF public.impressions
FOR VALUES FROM ('2020-05-01') TO ('2020-06-01');


--
-- Name: impressions-2020-06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2020-06" PARTITION OF public.impressions
FOR VALUES FROM ('2020-06-01') TO ('2020-07-01');


--
-- Name: impressions-2020-07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2020-07" PARTITION OF public.impressions
FOR VALUES FROM ('2020-07-01') TO ('2020-08-01');


--
-- Name: impressions-2020-08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2020-08" PARTITION OF public.impressions
FOR VALUES FROM ('2020-08-01') TO ('2020-09-01');


--
-- Name: impressions-2020-09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2020-09" PARTITION OF public.impressions
FOR VALUES FROM ('2020-09-01') TO ('2020-10-01');


--
-- Name: impressions-2020-10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2020-10" PARTITION OF public.impressions
FOR VALUES FROM ('2020-10-01') TO ('2020-11-01');


--
-- Name: impressions-2020-11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2020-11" PARTITION OF public.impressions
FOR VALUES FROM ('2020-11-01') TO ('2020-12-01');


--
-- Name: impressions-2020-12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2020-12" PARTITION OF public.impressions
FOR VALUES FROM ('2020-12-01') TO ('2021-01-01');


--
-- Name: impressions-2021-01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2021-01" PARTITION OF public.impressions
FOR VALUES FROM ('2021-01-01') TO ('2021-02-01');


--
-- Name: impressions-2021-02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2021-02" PARTITION OF public.impressions
FOR VALUES FROM ('2021-02-01') TO ('2021-03-01');


--
-- Name: impressions-2021-03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2021-03" PARTITION OF public.impressions
FOR VALUES FROM ('2021-03-01') TO ('2021-04-01');


--
-- Name: impressions-2021-04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2021-04" PARTITION OF public.impressions
FOR VALUES FROM ('2021-04-01') TO ('2021-05-01');


--
-- Name: impressions-2021-05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2021-05" PARTITION OF public.impressions
FOR VALUES FROM ('2021-05-01') TO ('2021-06-01');


--
-- Name: impressions-2021-06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2021-06" PARTITION OF public.impressions
FOR VALUES FROM ('2021-06-01') TO ('2021-07-01');


--
-- Name: impressions-2021-07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2021-07" PARTITION OF public.impressions
FOR VALUES FROM ('2021-07-01') TO ('2021-08-01');


--
-- Name: impressions-2021-08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2021-08" PARTITION OF public.impressions
FOR VALUES FROM ('2021-08-01') TO ('2021-09-01');


--
-- Name: impressions-2021-09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2021-09" PARTITION OF public.impressions
FOR VALUES FROM ('2021-09-01') TO ('2021-10-01');


--
-- Name: impressions-2021-10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2021-10" PARTITION OF public.impressions
FOR VALUES FROM ('2021-10-01') TO ('2021-11-01');


--
-- Name: impressions-2021-11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2021-11" PARTITION OF public.impressions
FOR VALUES FROM ('2021-11-01') TO ('2021-12-01');


--
-- Name: impressions-2021-12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2021-12" PARTITION OF public.impressions
FOR VALUES FROM ('2021-12-01') TO ('2022-01-01');


--
-- Name: impressions-2022-01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2022-01" PARTITION OF public.impressions
FOR VALUES FROM ('2022-01-01') TO ('2022-02-01');


--
-- Name: impressions-2022-02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2022-02" PARTITION OF public.impressions
FOR VALUES FROM ('2022-02-01') TO ('2022-03-01');


--
-- Name: impressions-2022-03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2022-03" PARTITION OF public.impressions
FOR VALUES FROM ('2022-03-01') TO ('2022-04-01');


--
-- Name: impressions-2022-04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2022-04" PARTITION OF public.impressions
FOR VALUES FROM ('2022-04-01') TO ('2022-05-01');


--
-- Name: impressions-2022-05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2022-05" PARTITION OF public.impressions
FOR VALUES FROM ('2022-05-01') TO ('2022-06-01');


--
-- Name: impressions-2022-06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2022-06" PARTITION OF public.impressions
FOR VALUES FROM ('2022-06-01') TO ('2022-07-01');


--
-- Name: impressions-2022-07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2022-07" PARTITION OF public.impressions
FOR VALUES FROM ('2022-07-01') TO ('2022-08-01');


--
-- Name: impressions-2022-08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2022-08" PARTITION OF public.impressions
FOR VALUES FROM ('2022-08-01') TO ('2022-09-01');


--
-- Name: impressions-2022-09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2022-09" PARTITION OF public.impressions
FOR VALUES FROM ('2022-09-01') TO ('2022-10-01');


--
-- Name: impressions-2022-10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2022-10" PARTITION OF public.impressions
FOR VALUES FROM ('2022-10-01') TO ('2022-11-01');


--
-- Name: impressions-2022-11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2022-11" PARTITION OF public.impressions
FOR VALUES FROM ('2022-11-01') TO ('2022-12-01');


--
-- Name: impressions-2022-12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2022-12" PARTITION OF public.impressions
FOR VALUES FROM ('2022-12-01') TO ('2023-01-01');


--
-- Name: impressions-2023-01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2023-01" PARTITION OF public.impressions
FOR VALUES FROM ('2023-01-01') TO ('2023-02-01');


--
-- Name: impressions-2023-02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2023-02" PARTITION OF public.impressions
FOR VALUES FROM ('2023-02-01') TO ('2023-03-01');


--
-- Name: impressions-2023-03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2023-03" PARTITION OF public.impressions
FOR VALUES FROM ('2023-03-01') TO ('2023-04-01');


--
-- Name: impressions-2023-04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2023-04" PARTITION OF public.impressions
FOR VALUES FROM ('2023-04-01') TO ('2023-05-01');


--
-- Name: impressions-2023-05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2023-05" PARTITION OF public.impressions
FOR VALUES FROM ('2023-05-01') TO ('2023-06-01');


--
-- Name: impressions-2023-06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2023-06" PARTITION OF public.impressions
FOR VALUES FROM ('2023-06-01') TO ('2023-07-01');


--
-- Name: impressions-2023-07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2023-07" PARTITION OF public.impressions
FOR VALUES FROM ('2023-07-01') TO ('2023-08-01');


--
-- Name: impressions-2023-08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2023-08" PARTITION OF public.impressions
FOR VALUES FROM ('2023-08-01') TO ('2023-09-01');


--
-- Name: impressions-2023-09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2023-09" PARTITION OF public.impressions
FOR VALUES FROM ('2023-09-01') TO ('2023-10-01');


--
-- Name: impressions-2023-10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2023-10" PARTITION OF public.impressions
FOR VALUES FROM ('2023-10-01') TO ('2023-11-01');


--
-- Name: impressions-2023-11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2023-11" PARTITION OF public.impressions
FOR VALUES FROM ('2023-11-01') TO ('2023-12-01');


--
-- Name: impressions-2023-12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2023-12" PARTITION OF public.impressions
FOR VALUES FROM ('2023-12-01') TO ('2024-01-01');


--
-- Name: impressions-2024-01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2024-01" PARTITION OF public.impressions
FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');


--
-- Name: impressions-2024-02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2024-02" PARTITION OF public.impressions
FOR VALUES FROM ('2024-02-01') TO ('2024-03-01');


--
-- Name: impressions-2024-03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2024-03" PARTITION OF public.impressions
FOR VALUES FROM ('2024-03-01') TO ('2024-04-01');


--
-- Name: impressions-2024-04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2024-04" PARTITION OF public.impressions
FOR VALUES FROM ('2024-04-01') TO ('2024-05-01');


--
-- Name: impressions-2024-05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2024-05" PARTITION OF public.impressions
FOR VALUES FROM ('2024-05-01') TO ('2024-06-01');


--
-- Name: impressions-2024-06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2024-06" PARTITION OF public.impressions
FOR VALUES FROM ('2024-06-01') TO ('2024-07-01');


--
-- Name: impressions-2024-07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2024-07" PARTITION OF public.impressions
FOR VALUES FROM ('2024-07-01') TO ('2024-08-01');


--
-- Name: impressions-2024-08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2024-08" PARTITION OF public.impressions
FOR VALUES FROM ('2024-08-01') TO ('2024-09-01');


--
-- Name: impressions-2024-09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2024-09" PARTITION OF public.impressions
FOR VALUES FROM ('2024-09-01') TO ('2024-10-01');


--
-- Name: impressions-2024-10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2024-10" PARTITION OF public.impressions
FOR VALUES FROM ('2024-10-01') TO ('2024-11-01');


--
-- Name: impressions-2024-11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2024-11" PARTITION OF public.impressions
FOR VALUES FROM ('2024-11-01') TO ('2024-12-01');


--
-- Name: impressions-2024-12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2024-12" PARTITION OF public.impressions
FOR VALUES FROM ('2024-12-01') TO ('2025-01-01');


--
-- Name: impressions-2025-01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2025-01" PARTITION OF public.impressions
FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');


--
-- Name: impressions-2025-02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2025-02" PARTITION OF public.impressions
FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');


--
-- Name: impressions-2025-03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2025-03" PARTITION OF public.impressions
FOR VALUES FROM ('2025-03-01') TO ('2025-04-01');


--
-- Name: impressions-2025-04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2025-04" PARTITION OF public.impressions
FOR VALUES FROM ('2025-04-01') TO ('2025-05-01');


--
-- Name: impressions-2025-05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2025-05" PARTITION OF public.impressions
FOR VALUES FROM ('2025-05-01') TO ('2025-06-01');


--
-- Name: impressions-2025-06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2025-06" PARTITION OF public.impressions
FOR VALUES FROM ('2025-06-01') TO ('2025-07-01');


--
-- Name: impressions-2025-07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2025-07" PARTITION OF public.impressions
FOR VALUES FROM ('2025-07-01') TO ('2025-08-01');


--
-- Name: impressions-2025-08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2025-08" PARTITION OF public.impressions
FOR VALUES FROM ('2025-08-01') TO ('2025-09-01');


--
-- Name: impressions-2025-09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2025-09" PARTITION OF public.impressions
FOR VALUES FROM ('2025-09-01') TO ('2025-10-01');


--
-- Name: impressions-2025-10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2025-10" PARTITION OF public.impressions
FOR VALUES FROM ('2025-10-01') TO ('2025-11-01');


--
-- Name: impressions-2025-11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2025-11" PARTITION OF public.impressions
FOR VALUES FROM ('2025-11-01') TO ('2025-12-01');


--
-- Name: impressions-2025-12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2025-12" PARTITION OF public.impressions
FOR VALUES FROM ('2025-12-01') TO ('2026-01-01');


--
-- Name: impressions-2026-01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2026-01" PARTITION OF public.impressions
FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');


--
-- Name: impressions-2026-02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2026-02" PARTITION OF public.impressions
FOR VALUES FROM ('2026-02-01') TO ('2026-03-01');


--
-- Name: impressions-2026-03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2026-03" PARTITION OF public.impressions
FOR VALUES FROM ('2026-03-01') TO ('2026-04-01');


--
-- Name: impressions-2026-04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2026-04" PARTITION OF public.impressions
FOR VALUES FROM ('2026-04-01') TO ('2026-05-01');


--
-- Name: impressions-2026-05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2026-05" PARTITION OF public.impressions
FOR VALUES FROM ('2026-05-01') TO ('2026-06-01');


--
-- Name: impressions-2026-06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2026-06" PARTITION OF public.impressions
FOR VALUES FROM ('2026-06-01') TO ('2026-07-01');


--
-- Name: impressions-2026-07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2026-07" PARTITION OF public.impressions
FOR VALUES FROM ('2026-07-01') TO ('2026-08-01');


--
-- Name: impressions-2026-08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2026-08" PARTITION OF public.impressions
FOR VALUES FROM ('2026-08-01') TO ('2026-09-01');


--
-- Name: impressions-2026-09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2026-09" PARTITION OF public.impressions
FOR VALUES FROM ('2026-09-01') TO ('2026-10-01');


--
-- Name: impressions-2026-10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2026-10" PARTITION OF public.impressions
FOR VALUES FROM ('2026-10-01') TO ('2026-11-01');


--
-- Name: impressions-2026-11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2026-11" PARTITION OF public.impressions
FOR VALUES FROM ('2026-11-01') TO ('2026-12-01');


--
-- Name: impressions-2026-12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2026-12" PARTITION OF public.impressions
FOR VALUES FROM ('2026-12-01') TO ('2027-01-01');


--
-- Name: impressions-2027-01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2027-01" PARTITION OF public.impressions
FOR VALUES FROM ('2027-01-01') TO ('2027-02-01');


--
-- Name: impressions-2027-02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2027-02" PARTITION OF public.impressions
FOR VALUES FROM ('2027-02-01') TO ('2027-03-01');


--
-- Name: impressions-2027-03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2027-03" PARTITION OF public.impressions
FOR VALUES FROM ('2027-03-01') TO ('2027-04-01');


--
-- Name: impressions-2027-04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2027-04" PARTITION OF public.impressions
FOR VALUES FROM ('2027-04-01') TO ('2027-05-01');


--
-- Name: impressions-2027-05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2027-05" PARTITION OF public.impressions
FOR VALUES FROM ('2027-05-01') TO ('2027-06-01');


--
-- Name: impressions-2027-06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2027-06" PARTITION OF public.impressions
FOR VALUES FROM ('2027-06-01') TO ('2027-07-01');


--
-- Name: impressions-2027-07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2027-07" PARTITION OF public.impressions
FOR VALUES FROM ('2027-07-01') TO ('2027-08-01');


--
-- Name: impressions-2027-08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2027-08" PARTITION OF public.impressions
FOR VALUES FROM ('2027-08-01') TO ('2027-09-01');


--
-- Name: impressions-2027-09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2027-09" PARTITION OF public.impressions
FOR VALUES FROM ('2027-09-01') TO ('2027-10-01');


--
-- Name: impressions-2027-10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2027-10" PARTITION OF public.impressions
FOR VALUES FROM ('2027-10-01') TO ('2027-11-01');


--
-- Name: impressions-2027-11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2027-11" PARTITION OF public.impressions
FOR VALUES FROM ('2027-11-01') TO ('2027-12-01');


--
-- Name: impressions-2027-12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2027-12" PARTITION OF public.impressions
FOR VALUES FROM ('2027-12-01') TO ('2028-01-01');


--
-- Name: impressions-2028-01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2028-01" PARTITION OF public.impressions
FOR VALUES FROM ('2028-01-01') TO ('2028-02-01');


--
-- Name: impressions-2028-02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2028-02" PARTITION OF public.impressions
FOR VALUES FROM ('2028-02-01') TO ('2028-03-01');


--
-- Name: impressions-2028-03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2028-03" PARTITION OF public.impressions
FOR VALUES FROM ('2028-03-01') TO ('2028-04-01');


--
-- Name: impressions-2028-04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2028-04" PARTITION OF public.impressions
FOR VALUES FROM ('2028-04-01') TO ('2028-05-01');


--
-- Name: impressions-2028-05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2028-05" PARTITION OF public.impressions
FOR VALUES FROM ('2028-05-01') TO ('2028-06-01');


--
-- Name: impressions-2028-06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2028-06" PARTITION OF public.impressions
FOR VALUES FROM ('2028-06-01') TO ('2028-07-01');


--
-- Name: impressions-2028-07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2028-07" PARTITION OF public.impressions
FOR VALUES FROM ('2028-07-01') TO ('2028-08-01');


--
-- Name: impressions-2028-08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2028-08" PARTITION OF public.impressions
FOR VALUES FROM ('2028-08-01') TO ('2028-09-01');


--
-- Name: impressions-2028-09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2028-09" PARTITION OF public.impressions
FOR VALUES FROM ('2028-09-01') TO ('2028-10-01');


--
-- Name: impressions-2028-10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2028-10" PARTITION OF public.impressions
FOR VALUES FROM ('2028-10-01') TO ('2028-11-01');


--
-- Name: impressions-2028-11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2028-11" PARTITION OF public.impressions
FOR VALUES FROM ('2028-11-01') TO ('2028-12-01');


--
-- Name: impressions-2028-12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2028-12" PARTITION OF public.impressions
FOR VALUES FROM ('2028-12-01') TO ('2029-01-01');


--
-- Name: impressions-2029-01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2029-01" PARTITION OF public.impressions
FOR VALUES FROM ('2029-01-01') TO ('2029-02-01');


--
-- Name: impressions-2029-02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2029-02" PARTITION OF public.impressions
FOR VALUES FROM ('2029-02-01') TO ('2029-03-01');


--
-- Name: impressions-2029-03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2029-03" PARTITION OF public.impressions
FOR VALUES FROM ('2029-03-01') TO ('2029-04-01');


--
-- Name: impressions-2029-04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2029-04" PARTITION OF public.impressions
FOR VALUES FROM ('2029-04-01') TO ('2029-05-01');


--
-- Name: impressions-2029-05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2029-05" PARTITION OF public.impressions
FOR VALUES FROM ('2029-05-01') TO ('2029-06-01');


--
-- Name: impressions-2029-06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2029-06" PARTITION OF public.impressions
FOR VALUES FROM ('2029-06-01') TO ('2029-07-01');


--
-- Name: impressions-2029-07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2029-07" PARTITION OF public.impressions
FOR VALUES FROM ('2029-07-01') TO ('2029-08-01');


--
-- Name: impressions-2029-08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2029-08" PARTITION OF public.impressions
FOR VALUES FROM ('2029-08-01') TO ('2029-09-01');


--
-- Name: impressions-2029-09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2029-09" PARTITION OF public.impressions
FOR VALUES FROM ('2029-09-01') TO ('2029-10-01');


--
-- Name: impressions-2029-10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2029-10" PARTITION OF public.impressions
FOR VALUES FROM ('2029-10-01') TO ('2029-11-01');


--
-- Name: impressions-2029-11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2029-11" PARTITION OF public.impressions
FOR VALUES FROM ('2029-11-01') TO ('2029-12-01');


--
-- Name: impressions-2029-12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2029-12" PARTITION OF public.impressions
FOR VALUES FROM ('2029-12-01') TO ('2030-01-01');


--
-- Name: impressions-2030-01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2030-01" PARTITION OF public.impressions
FOR VALUES FROM ('2030-01-01') TO ('2030-02-01');


--
-- Name: impressions-2030-02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2030-02" PARTITION OF public.impressions
FOR VALUES FROM ('2030-02-01') TO ('2030-03-01');


--
-- Name: impressions-2030-03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2030-03" PARTITION OF public.impressions
FOR VALUES FROM ('2030-03-01') TO ('2030-04-01');


--
-- Name: impressions-2030-04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2030-04" PARTITION OF public.impressions
FOR VALUES FROM ('2030-04-01') TO ('2030-05-01');


--
-- Name: impressions-2030-05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2030-05" PARTITION OF public.impressions
FOR VALUES FROM ('2030-05-01') TO ('2030-06-01');


--
-- Name: impressions-2030-06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2030-06" PARTITION OF public.impressions
FOR VALUES FROM ('2030-06-01') TO ('2030-07-01');


--
-- Name: impressions-2030-07; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2030-07" PARTITION OF public.impressions
FOR VALUES FROM ('2030-07-01') TO ('2030-08-01');


--
-- Name: impressions-2030-08; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2030-08" PARTITION OF public.impressions
FOR VALUES FROM ('2030-08-01') TO ('2030-09-01');


--
-- Name: impressions-2030-09; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2030-09" PARTITION OF public.impressions
FOR VALUES FROM ('2030-09-01') TO ('2030-10-01');


--
-- Name: impressions-2030-10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2030-10" PARTITION OF public.impressions
FOR VALUES FROM ('2030-10-01') TO ('2030-11-01');


--
-- Name: impressions-2030-11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2030-11" PARTITION OF public.impressions
FOR VALUES FROM ('2030-11-01') TO ('2030-12-01');


--
-- Name: impressions-2030-12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."impressions-2030-12" PARTITION OF public.impressions
FOR VALUES FROM ('2030-12-01') TO ('2031-01-01');


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
    ad_template character varying NOT NULL,
    ad_theme character varying NOT NULL,
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
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    company_name character varying,
    address_1 character varying,
    address_2 character varying,
    city character varying,
    region character varying,
    postal_code character varying,
    country character varying,
    api_access boolean DEFAULT false NOT NULL,
    api_key character varying,
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
-- Name: impressions-2018-11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2018-11" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2018-11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2018-11" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2018-11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2018-11" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2018-12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2018-12" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2018-12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2018-12" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2018-12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2018-12" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2019-01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-01" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2019-01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-01" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2019-01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-01" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2019-02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-02" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2019-02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-02" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2019-02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-02" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2019-03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-03" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2019-03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-03" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2019-03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-03" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2019-04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-04" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2019-04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-04" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2019-04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-04" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2019-05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-05" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2019-05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-05" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2019-05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-05" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2019-06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-06" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2019-06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-06" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2019-06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-06" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2019-07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-07" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2019-07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-07" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2019-07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-07" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2019-08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-08" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2019-08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-08" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2019-08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-08" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2019-09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-09" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2019-09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-09" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2019-09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-09" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2019-10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-10" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2019-10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-10" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2019-10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-10" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2019-11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-11" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2019-11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-11" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2019-11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-11" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2019-12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-12" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2019-12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-12" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2019-12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-12" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2020-01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-01" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2020-01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-01" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2020-01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-01" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2020-02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-02" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2020-02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-02" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2020-02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-02" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2020-03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-03" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2020-03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-03" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2020-03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-03" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2020-04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-04" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2020-04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-04" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2020-04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-04" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2020-05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-05" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2020-05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-05" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2020-05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-05" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2020-06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-06" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2020-06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-06" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2020-06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-06" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2020-07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-07" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2020-07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-07" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2020-07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-07" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2020-08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-08" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2020-08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-08" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2020-08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-08" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2020-09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-09" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2020-09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-09" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2020-09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-09" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2020-10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-10" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2020-10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-10" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2020-10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-10" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2020-11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-11" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2020-11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-11" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2020-11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-11" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2020-12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-12" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2020-12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-12" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2020-12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-12" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2021-01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-01" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2021-01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-01" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2021-01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-01" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2021-02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-02" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2021-02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-02" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2021-02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-02" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2021-03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-03" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2021-03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-03" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2021-03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-03" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2021-04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-04" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2021-04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-04" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2021-04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-04" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2021-05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-05" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2021-05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-05" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2021-05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-05" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2021-06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-06" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2021-06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-06" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2021-06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-06" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2021-07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-07" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2021-07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-07" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2021-07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-07" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2021-08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-08" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2021-08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-08" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2021-08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-08" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2021-09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-09" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2021-09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-09" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2021-09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-09" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2021-10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-10" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2021-10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-10" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2021-10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-10" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2021-11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-11" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2021-11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-11" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2021-11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-11" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2021-12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-12" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2021-12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-12" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2021-12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-12" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2022-01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-01" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2022-01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-01" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2022-01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-01" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2022-02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-02" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2022-02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-02" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2022-02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-02" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2022-03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-03" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2022-03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-03" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2022-03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-03" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2022-04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-04" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2022-04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-04" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2022-04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-04" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2022-05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-05" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2022-05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-05" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2022-05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-05" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2022-06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-06" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2022-06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-06" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2022-06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-06" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2022-07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-07" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2022-07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-07" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2022-07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-07" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2022-08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-08" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2022-08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-08" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2022-08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-08" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2022-09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-09" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2022-09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-09" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2022-09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-09" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2022-10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-10" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2022-10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-10" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2022-10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-10" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2022-11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-11" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2022-11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-11" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2022-11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-11" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2022-12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-12" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2022-12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-12" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2022-12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-12" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2023-01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-01" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2023-01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-01" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2023-01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-01" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2023-02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-02" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2023-02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-02" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2023-02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-02" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2023-03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-03" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2023-03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-03" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2023-03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-03" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2023-04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-04" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2023-04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-04" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2023-04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-04" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2023-05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-05" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2023-05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-05" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2023-05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-05" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2023-06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-06" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2023-06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-06" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2023-06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-06" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2023-07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-07" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2023-07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-07" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2023-07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-07" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2023-08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-08" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2023-08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-08" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2023-08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-08" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2023-09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-09" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2023-09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-09" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2023-09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-09" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2023-10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-10" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2023-10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-10" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2023-10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-10" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2023-11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-11" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2023-11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-11" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2023-11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-11" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2023-12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-12" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2023-12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-12" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2023-12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-12" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2024-01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-01" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2024-01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-01" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2024-01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-01" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2024-02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-02" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2024-02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-02" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2024-02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-02" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2024-03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-03" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2024-03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-03" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2024-03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-03" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2024-04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-04" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2024-04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-04" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2024-04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-04" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2024-05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-05" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2024-05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-05" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2024-05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-05" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2024-06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-06" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2024-06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-06" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2024-06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-06" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2024-07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-07" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2024-07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-07" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2024-07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-07" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2024-08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-08" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2024-08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-08" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2024-08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-08" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2024-09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-09" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2024-09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-09" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2024-09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-09" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2024-10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-10" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2024-10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-10" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2024-10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-10" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2024-11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-11" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2024-11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-11" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2024-11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-11" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2024-12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-12" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2024-12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-12" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2024-12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-12" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2025-01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-01" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2025-01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-01" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2025-01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-01" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2025-02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-02" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2025-02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-02" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2025-02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-02" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2025-03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-03" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2025-03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-03" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2025-03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-03" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2025-04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-04" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2025-04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-04" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2025-04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-04" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2025-05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-05" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2025-05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-05" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2025-05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-05" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2025-06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-06" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2025-06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-06" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2025-06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-06" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2025-07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-07" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2025-07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-07" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2025-07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-07" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2025-08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-08" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2025-08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-08" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2025-08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-08" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2025-09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-09" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2025-09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-09" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2025-09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-09" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2025-10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-10" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2025-10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-10" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2025-10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-10" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2025-11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-11" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2025-11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-11" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2025-11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-11" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2025-12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-12" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2025-12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-12" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2025-12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-12" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2026-01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-01" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2026-01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-01" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2026-01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-01" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2026-02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-02" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2026-02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-02" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2026-02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-02" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2026-03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-03" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2026-03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-03" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2026-03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-03" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2026-04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-04" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2026-04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-04" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2026-04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-04" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2026-05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-05" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2026-05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-05" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2026-05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-05" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2026-06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-06" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2026-06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-06" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2026-06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-06" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2026-07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-07" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2026-07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-07" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2026-07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-07" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2026-08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-08" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2026-08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-08" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2026-08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-08" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2026-09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-09" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2026-09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-09" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2026-09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-09" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2026-10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-10" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2026-10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-10" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2026-10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-10" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2026-11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-11" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2026-11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-11" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2026-11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-11" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2026-12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-12" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2026-12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-12" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2026-12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-12" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2027-01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-01" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2027-01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-01" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2027-01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-01" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2027-02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-02" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2027-02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-02" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2027-02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-02" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2027-03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-03" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2027-03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-03" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2027-03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-03" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2027-04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-04" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2027-04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-04" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2027-04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-04" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2027-05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-05" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2027-05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-05" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2027-05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-05" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2027-06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-06" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2027-06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-06" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2027-06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-06" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2027-07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-07" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2027-07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-07" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2027-07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-07" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2027-08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-08" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2027-08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-08" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2027-08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-08" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2027-09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-09" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2027-09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-09" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2027-09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-09" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2027-10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-10" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2027-10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-10" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2027-10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-10" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2027-11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-11" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2027-11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-11" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2027-11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-11" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2027-12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-12" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2027-12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-12" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2027-12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-12" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2028-01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-01" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2028-01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-01" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2028-01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-01" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2028-02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-02" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2028-02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-02" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2028-02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-02" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2028-03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-03" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2028-03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-03" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2028-03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-03" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2028-04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-04" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2028-04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-04" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2028-04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-04" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2028-05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-05" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2028-05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-05" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2028-05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-05" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2028-06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-06" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2028-06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-06" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2028-06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-06" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2028-07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-07" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2028-07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-07" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2028-07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-07" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2028-08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-08" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2028-08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-08" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2028-08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-08" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2028-09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-09" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2028-09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-09" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2028-09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-09" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2028-10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-10" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2028-10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-10" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2028-10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-10" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2028-11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-11" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2028-11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-11" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2028-11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-11" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2028-12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-12" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2028-12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-12" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2028-12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-12" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2029-01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-01" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2029-01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-01" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2029-01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-01" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2029-02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-02" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2029-02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-02" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2029-02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-02" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2029-03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-03" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2029-03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-03" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2029-03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-03" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2029-04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-04" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2029-04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-04" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2029-04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-04" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2029-05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-05" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2029-05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-05" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2029-05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-05" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2029-06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-06" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2029-06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-06" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2029-06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-06" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2029-07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-07" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2029-07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-07" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2029-07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-07" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2029-08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-08" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2029-08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-08" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2029-08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-08" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2029-09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-09" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2029-09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-09" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2029-09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-09" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2029-10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-10" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2029-10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-10" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2029-10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-10" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2029-11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-11" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2029-11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-11" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2029-11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-11" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2029-12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-12" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2029-12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-12" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2029-12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-12" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2030-01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-01" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2030-01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-01" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2030-01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-01" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2030-02 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-02" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2030-02 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-02" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2030-02 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-02" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2030-03 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-03" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2030-03 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-03" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2030-03 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-03" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2030-04 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-04" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2030-04 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-04" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2030-04 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-04" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2030-05 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-05" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2030-05 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-05" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2030-05 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-05" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2030-06 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-06" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2030-06 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-06" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2030-06 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-06" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2030-07 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-07" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2030-07 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-07" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2030-07 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-07" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2030-08 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-08" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2030-08 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-08" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2030-08 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-08" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2030-09 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-09" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2030-09 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-09" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2030-09 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-09" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2030-10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-10" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2030-10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-10" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2030-10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-10" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2030-11 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-11" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2030-11 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-11" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2030-11 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-11" ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions-2030-12 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-12" ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions-2030-12 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-12" ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions-2030-12 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-12" ALTER COLUMN fallback_campaign SET DEFAULT false;


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
-- Name: impressions-2018-11 impressions-2018-11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2018-11"
    ADD CONSTRAINT "impressions-2018-11_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2018-12 impressions-2018-12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2018-12"
    ADD CONSTRAINT "impressions-2018-12_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2019-01 impressions-2019-01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-01"
    ADD CONSTRAINT "impressions-2019-01_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2019-02 impressions-2019-02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-02"
    ADD CONSTRAINT "impressions-2019-02_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2019-03 impressions-2019-03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-03"
    ADD CONSTRAINT "impressions-2019-03_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2019-04 impressions-2019-04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-04"
    ADD CONSTRAINT "impressions-2019-04_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2019-05 impressions-2019-05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-05"
    ADD CONSTRAINT "impressions-2019-05_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2019-06 impressions-2019-06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-06"
    ADD CONSTRAINT "impressions-2019-06_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2019-07 impressions-2019-07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-07"
    ADD CONSTRAINT "impressions-2019-07_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2019-08 impressions-2019-08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-08"
    ADD CONSTRAINT "impressions-2019-08_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2019-09 impressions-2019-09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-09"
    ADD CONSTRAINT "impressions-2019-09_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2019-10 impressions-2019-10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-10"
    ADD CONSTRAINT "impressions-2019-10_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2019-11 impressions-2019-11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-11"
    ADD CONSTRAINT "impressions-2019-11_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2019-12 impressions-2019-12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2019-12"
    ADD CONSTRAINT "impressions-2019-12_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2020-01 impressions-2020-01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-01"
    ADD CONSTRAINT "impressions-2020-01_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2020-02 impressions-2020-02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-02"
    ADD CONSTRAINT "impressions-2020-02_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2020-03 impressions-2020-03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-03"
    ADD CONSTRAINT "impressions-2020-03_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2020-04 impressions-2020-04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-04"
    ADD CONSTRAINT "impressions-2020-04_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2020-05 impressions-2020-05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-05"
    ADD CONSTRAINT "impressions-2020-05_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2020-06 impressions-2020-06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-06"
    ADD CONSTRAINT "impressions-2020-06_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2020-07 impressions-2020-07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-07"
    ADD CONSTRAINT "impressions-2020-07_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2020-08 impressions-2020-08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-08"
    ADD CONSTRAINT "impressions-2020-08_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2020-09 impressions-2020-09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-09"
    ADD CONSTRAINT "impressions-2020-09_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2020-10 impressions-2020-10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-10"
    ADD CONSTRAINT "impressions-2020-10_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2020-11 impressions-2020-11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-11"
    ADD CONSTRAINT "impressions-2020-11_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2020-12 impressions-2020-12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2020-12"
    ADD CONSTRAINT "impressions-2020-12_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2021-01 impressions-2021-01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-01"
    ADD CONSTRAINT "impressions-2021-01_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2021-02 impressions-2021-02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-02"
    ADD CONSTRAINT "impressions-2021-02_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2021-03 impressions-2021-03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-03"
    ADD CONSTRAINT "impressions-2021-03_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2021-04 impressions-2021-04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-04"
    ADD CONSTRAINT "impressions-2021-04_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2021-05 impressions-2021-05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-05"
    ADD CONSTRAINT "impressions-2021-05_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2021-06 impressions-2021-06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-06"
    ADD CONSTRAINT "impressions-2021-06_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2021-07 impressions-2021-07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-07"
    ADD CONSTRAINT "impressions-2021-07_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2021-08 impressions-2021-08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-08"
    ADD CONSTRAINT "impressions-2021-08_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2021-09 impressions-2021-09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-09"
    ADD CONSTRAINT "impressions-2021-09_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2021-10 impressions-2021-10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-10"
    ADD CONSTRAINT "impressions-2021-10_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2021-11 impressions-2021-11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-11"
    ADD CONSTRAINT "impressions-2021-11_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2021-12 impressions-2021-12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2021-12"
    ADD CONSTRAINT "impressions-2021-12_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2022-01 impressions-2022-01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-01"
    ADD CONSTRAINT "impressions-2022-01_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2022-02 impressions-2022-02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-02"
    ADD CONSTRAINT "impressions-2022-02_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2022-03 impressions-2022-03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-03"
    ADD CONSTRAINT "impressions-2022-03_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2022-04 impressions-2022-04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-04"
    ADD CONSTRAINT "impressions-2022-04_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2022-05 impressions-2022-05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-05"
    ADD CONSTRAINT "impressions-2022-05_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2022-06 impressions-2022-06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-06"
    ADD CONSTRAINT "impressions-2022-06_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2022-07 impressions-2022-07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-07"
    ADD CONSTRAINT "impressions-2022-07_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2022-08 impressions-2022-08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-08"
    ADD CONSTRAINT "impressions-2022-08_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2022-09 impressions-2022-09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-09"
    ADD CONSTRAINT "impressions-2022-09_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2022-10 impressions-2022-10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-10"
    ADD CONSTRAINT "impressions-2022-10_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2022-11 impressions-2022-11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-11"
    ADD CONSTRAINT "impressions-2022-11_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2022-12 impressions-2022-12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2022-12"
    ADD CONSTRAINT "impressions-2022-12_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2023-01 impressions-2023-01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-01"
    ADD CONSTRAINT "impressions-2023-01_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2023-02 impressions-2023-02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-02"
    ADD CONSTRAINT "impressions-2023-02_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2023-03 impressions-2023-03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-03"
    ADD CONSTRAINT "impressions-2023-03_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2023-04 impressions-2023-04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-04"
    ADD CONSTRAINT "impressions-2023-04_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2023-05 impressions-2023-05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-05"
    ADD CONSTRAINT "impressions-2023-05_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2023-06 impressions-2023-06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-06"
    ADD CONSTRAINT "impressions-2023-06_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2023-07 impressions-2023-07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-07"
    ADD CONSTRAINT "impressions-2023-07_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2023-08 impressions-2023-08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-08"
    ADD CONSTRAINT "impressions-2023-08_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2023-09 impressions-2023-09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-09"
    ADD CONSTRAINT "impressions-2023-09_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2023-10 impressions-2023-10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-10"
    ADD CONSTRAINT "impressions-2023-10_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2023-11 impressions-2023-11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-11"
    ADD CONSTRAINT "impressions-2023-11_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2023-12 impressions-2023-12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2023-12"
    ADD CONSTRAINT "impressions-2023-12_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2024-01 impressions-2024-01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-01"
    ADD CONSTRAINT "impressions-2024-01_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2024-02 impressions-2024-02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-02"
    ADD CONSTRAINT "impressions-2024-02_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2024-03 impressions-2024-03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-03"
    ADD CONSTRAINT "impressions-2024-03_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2024-04 impressions-2024-04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-04"
    ADD CONSTRAINT "impressions-2024-04_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2024-05 impressions-2024-05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-05"
    ADD CONSTRAINT "impressions-2024-05_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2024-06 impressions-2024-06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-06"
    ADD CONSTRAINT "impressions-2024-06_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2024-07 impressions-2024-07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-07"
    ADD CONSTRAINT "impressions-2024-07_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2024-08 impressions-2024-08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-08"
    ADD CONSTRAINT "impressions-2024-08_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2024-09 impressions-2024-09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-09"
    ADD CONSTRAINT "impressions-2024-09_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2024-10 impressions-2024-10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-10"
    ADD CONSTRAINT "impressions-2024-10_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2024-11 impressions-2024-11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-11"
    ADD CONSTRAINT "impressions-2024-11_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2024-12 impressions-2024-12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2024-12"
    ADD CONSTRAINT "impressions-2024-12_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2025-01 impressions-2025-01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-01"
    ADD CONSTRAINT "impressions-2025-01_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2025-02 impressions-2025-02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-02"
    ADD CONSTRAINT "impressions-2025-02_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2025-03 impressions-2025-03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-03"
    ADD CONSTRAINT "impressions-2025-03_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2025-04 impressions-2025-04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-04"
    ADD CONSTRAINT "impressions-2025-04_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2025-05 impressions-2025-05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-05"
    ADD CONSTRAINT "impressions-2025-05_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2025-06 impressions-2025-06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-06"
    ADD CONSTRAINT "impressions-2025-06_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2025-07 impressions-2025-07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-07"
    ADD CONSTRAINT "impressions-2025-07_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2025-08 impressions-2025-08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-08"
    ADD CONSTRAINT "impressions-2025-08_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2025-09 impressions-2025-09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-09"
    ADD CONSTRAINT "impressions-2025-09_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2025-10 impressions-2025-10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-10"
    ADD CONSTRAINT "impressions-2025-10_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2025-11 impressions-2025-11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-11"
    ADD CONSTRAINT "impressions-2025-11_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2025-12 impressions-2025-12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2025-12"
    ADD CONSTRAINT "impressions-2025-12_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2026-01 impressions-2026-01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-01"
    ADD CONSTRAINT "impressions-2026-01_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2026-02 impressions-2026-02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-02"
    ADD CONSTRAINT "impressions-2026-02_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2026-03 impressions-2026-03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-03"
    ADD CONSTRAINT "impressions-2026-03_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2026-04 impressions-2026-04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-04"
    ADD CONSTRAINT "impressions-2026-04_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2026-05 impressions-2026-05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-05"
    ADD CONSTRAINT "impressions-2026-05_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2026-06 impressions-2026-06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-06"
    ADD CONSTRAINT "impressions-2026-06_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2026-07 impressions-2026-07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-07"
    ADD CONSTRAINT "impressions-2026-07_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2026-08 impressions-2026-08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-08"
    ADD CONSTRAINT "impressions-2026-08_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2026-09 impressions-2026-09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-09"
    ADD CONSTRAINT "impressions-2026-09_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2026-10 impressions-2026-10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-10"
    ADD CONSTRAINT "impressions-2026-10_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2026-11 impressions-2026-11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-11"
    ADD CONSTRAINT "impressions-2026-11_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2026-12 impressions-2026-12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2026-12"
    ADD CONSTRAINT "impressions-2026-12_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2027-01 impressions-2027-01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-01"
    ADD CONSTRAINT "impressions-2027-01_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2027-02 impressions-2027-02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-02"
    ADD CONSTRAINT "impressions-2027-02_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2027-03 impressions-2027-03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-03"
    ADD CONSTRAINT "impressions-2027-03_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2027-04 impressions-2027-04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-04"
    ADD CONSTRAINT "impressions-2027-04_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2027-05 impressions-2027-05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-05"
    ADD CONSTRAINT "impressions-2027-05_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2027-06 impressions-2027-06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-06"
    ADD CONSTRAINT "impressions-2027-06_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2027-07 impressions-2027-07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-07"
    ADD CONSTRAINT "impressions-2027-07_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2027-08 impressions-2027-08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-08"
    ADD CONSTRAINT "impressions-2027-08_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2027-09 impressions-2027-09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-09"
    ADD CONSTRAINT "impressions-2027-09_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2027-10 impressions-2027-10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-10"
    ADD CONSTRAINT "impressions-2027-10_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2027-11 impressions-2027-11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-11"
    ADD CONSTRAINT "impressions-2027-11_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2027-12 impressions-2027-12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2027-12"
    ADD CONSTRAINT "impressions-2027-12_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2028-01 impressions-2028-01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-01"
    ADD CONSTRAINT "impressions-2028-01_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2028-02 impressions-2028-02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-02"
    ADD CONSTRAINT "impressions-2028-02_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2028-03 impressions-2028-03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-03"
    ADD CONSTRAINT "impressions-2028-03_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2028-04 impressions-2028-04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-04"
    ADD CONSTRAINT "impressions-2028-04_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2028-05 impressions-2028-05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-05"
    ADD CONSTRAINT "impressions-2028-05_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2028-06 impressions-2028-06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-06"
    ADD CONSTRAINT "impressions-2028-06_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2028-07 impressions-2028-07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-07"
    ADD CONSTRAINT "impressions-2028-07_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2028-08 impressions-2028-08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-08"
    ADD CONSTRAINT "impressions-2028-08_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2028-09 impressions-2028-09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-09"
    ADD CONSTRAINT "impressions-2028-09_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2028-10 impressions-2028-10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-10"
    ADD CONSTRAINT "impressions-2028-10_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2028-11 impressions-2028-11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-11"
    ADD CONSTRAINT "impressions-2028-11_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2028-12 impressions-2028-12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2028-12"
    ADD CONSTRAINT "impressions-2028-12_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2029-01 impressions-2029-01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-01"
    ADD CONSTRAINT "impressions-2029-01_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2029-02 impressions-2029-02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-02"
    ADD CONSTRAINT "impressions-2029-02_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2029-03 impressions-2029-03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-03"
    ADD CONSTRAINT "impressions-2029-03_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2029-04 impressions-2029-04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-04"
    ADD CONSTRAINT "impressions-2029-04_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2029-05 impressions-2029-05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-05"
    ADD CONSTRAINT "impressions-2029-05_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2029-06 impressions-2029-06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-06"
    ADD CONSTRAINT "impressions-2029-06_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2029-07 impressions-2029-07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-07"
    ADD CONSTRAINT "impressions-2029-07_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2029-08 impressions-2029-08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-08"
    ADD CONSTRAINT "impressions-2029-08_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2029-09 impressions-2029-09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-09"
    ADD CONSTRAINT "impressions-2029-09_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2029-10 impressions-2029-10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-10"
    ADD CONSTRAINT "impressions-2029-10_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2029-11 impressions-2029-11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-11"
    ADD CONSTRAINT "impressions-2029-11_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2029-12 impressions-2029-12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2029-12"
    ADD CONSTRAINT "impressions-2029-12_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2030-01 impressions-2030-01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-01"
    ADD CONSTRAINT "impressions-2030-01_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2030-02 impressions-2030-02_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-02"
    ADD CONSTRAINT "impressions-2030-02_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2030-03 impressions-2030-03_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-03"
    ADD CONSTRAINT "impressions-2030-03_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2030-04 impressions-2030-04_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-04"
    ADD CONSTRAINT "impressions-2030-04_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2030-05 impressions-2030-05_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-05"
    ADD CONSTRAINT "impressions-2030-05_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2030-06 impressions-2030-06_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-06"
    ADD CONSTRAINT "impressions-2030-06_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2030-07 impressions-2030-07_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-07"
    ADD CONSTRAINT "impressions-2030-07_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2030-08 impressions-2030-08_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-08"
    ADD CONSTRAINT "impressions-2030-08_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2030-09 impressions-2030-09_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-09"
    ADD CONSTRAINT "impressions-2030-09_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2030-10 impressions-2030-10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-10"
    ADD CONSTRAINT "impressions-2030-10_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2030-11 impressions-2030-11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-11"
    ADD CONSTRAINT "impressions-2030-11_pkey" PRIMARY KEY (id);


--
-- Name: impressions-2030-12 impressions-2030-12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."impressions-2030-12"
    ADD CONSTRAINT "impressions-2030-12_pkey" PRIMARY KEY (id);


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
-- Name: index_impressions-2018-11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2018-11_on_campaign_id" ON public."impressions-2018-11" USING btree (campaign_id);


--
-- Name: index_impressions-2018-11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2018-11_on_displayed_at_date" ON public."impressions-2018-11" USING btree (displayed_at_date);


--
-- Name: index_impressions-2018-11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2018-11_on_displayed_at_hour" ON public."impressions-2018-11" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2018-11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2018-11_on_payable" ON public."impressions-2018-11" USING btree (payable);


--
-- Name: index_impressions-2018-11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2018-11_on_property_id" ON public."impressions-2018-11" USING btree (property_id);


--
-- Name: index_impressions-2018-12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2018-12_on_campaign_id" ON public."impressions-2018-12" USING btree (campaign_id);


--
-- Name: index_impressions-2018-12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2018-12_on_displayed_at_date" ON public."impressions-2018-12" USING btree (displayed_at_date);


--
-- Name: index_impressions-2018-12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2018-12_on_displayed_at_hour" ON public."impressions-2018-12" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2018-12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2018-12_on_payable" ON public."impressions-2018-12" USING btree (payable);


--
-- Name: index_impressions-2018-12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2018-12_on_property_id" ON public."impressions-2018-12" USING btree (property_id);


--
-- Name: index_impressions-2019-01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-01_on_campaign_id" ON public."impressions-2019-01" USING btree (campaign_id);


--
-- Name: index_impressions-2019-01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-01_on_displayed_at_date" ON public."impressions-2019-01" USING btree (displayed_at_date);


--
-- Name: index_impressions-2019-01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-01_on_displayed_at_hour" ON public."impressions-2019-01" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2019-01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-01_on_payable" ON public."impressions-2019-01" USING btree (payable);


--
-- Name: index_impressions-2019-01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-01_on_property_id" ON public."impressions-2019-01" USING btree (property_id);


--
-- Name: index_impressions-2019-02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-02_on_campaign_id" ON public."impressions-2019-02" USING btree (campaign_id);


--
-- Name: index_impressions-2019-02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-02_on_displayed_at_date" ON public."impressions-2019-02" USING btree (displayed_at_date);


--
-- Name: index_impressions-2019-02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-02_on_displayed_at_hour" ON public."impressions-2019-02" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2019-02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-02_on_payable" ON public."impressions-2019-02" USING btree (payable);


--
-- Name: index_impressions-2019-02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-02_on_property_id" ON public."impressions-2019-02" USING btree (property_id);


--
-- Name: index_impressions-2019-03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-03_on_campaign_id" ON public."impressions-2019-03" USING btree (campaign_id);


--
-- Name: index_impressions-2019-03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-03_on_displayed_at_date" ON public."impressions-2019-03" USING btree (displayed_at_date);


--
-- Name: index_impressions-2019-03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-03_on_displayed_at_hour" ON public."impressions-2019-03" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2019-03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-03_on_payable" ON public."impressions-2019-03" USING btree (payable);


--
-- Name: index_impressions-2019-03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-03_on_property_id" ON public."impressions-2019-03" USING btree (property_id);


--
-- Name: index_impressions-2019-04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-04_on_campaign_id" ON public."impressions-2019-04" USING btree (campaign_id);


--
-- Name: index_impressions-2019-04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-04_on_displayed_at_date" ON public."impressions-2019-04" USING btree (displayed_at_date);


--
-- Name: index_impressions-2019-04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-04_on_displayed_at_hour" ON public."impressions-2019-04" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2019-04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-04_on_payable" ON public."impressions-2019-04" USING btree (payable);


--
-- Name: index_impressions-2019-04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-04_on_property_id" ON public."impressions-2019-04" USING btree (property_id);


--
-- Name: index_impressions-2019-05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-05_on_campaign_id" ON public."impressions-2019-05" USING btree (campaign_id);


--
-- Name: index_impressions-2019-05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-05_on_displayed_at_date" ON public."impressions-2019-05" USING btree (displayed_at_date);


--
-- Name: index_impressions-2019-05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-05_on_displayed_at_hour" ON public."impressions-2019-05" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2019-05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-05_on_payable" ON public."impressions-2019-05" USING btree (payable);


--
-- Name: index_impressions-2019-05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-05_on_property_id" ON public."impressions-2019-05" USING btree (property_id);


--
-- Name: index_impressions-2019-06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-06_on_campaign_id" ON public."impressions-2019-06" USING btree (campaign_id);


--
-- Name: index_impressions-2019-06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-06_on_displayed_at_date" ON public."impressions-2019-06" USING btree (displayed_at_date);


--
-- Name: index_impressions-2019-06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-06_on_displayed_at_hour" ON public."impressions-2019-06" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2019-06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-06_on_payable" ON public."impressions-2019-06" USING btree (payable);


--
-- Name: index_impressions-2019-06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-06_on_property_id" ON public."impressions-2019-06" USING btree (property_id);


--
-- Name: index_impressions-2019-07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-07_on_campaign_id" ON public."impressions-2019-07" USING btree (campaign_id);


--
-- Name: index_impressions-2019-07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-07_on_displayed_at_date" ON public."impressions-2019-07" USING btree (displayed_at_date);


--
-- Name: index_impressions-2019-07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-07_on_displayed_at_hour" ON public."impressions-2019-07" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2019-07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-07_on_payable" ON public."impressions-2019-07" USING btree (payable);


--
-- Name: index_impressions-2019-07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-07_on_property_id" ON public."impressions-2019-07" USING btree (property_id);


--
-- Name: index_impressions-2019-08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-08_on_campaign_id" ON public."impressions-2019-08" USING btree (campaign_id);


--
-- Name: index_impressions-2019-08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-08_on_displayed_at_date" ON public."impressions-2019-08" USING btree (displayed_at_date);


--
-- Name: index_impressions-2019-08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-08_on_displayed_at_hour" ON public."impressions-2019-08" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2019-08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-08_on_payable" ON public."impressions-2019-08" USING btree (payable);


--
-- Name: index_impressions-2019-08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-08_on_property_id" ON public."impressions-2019-08" USING btree (property_id);


--
-- Name: index_impressions-2019-09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-09_on_campaign_id" ON public."impressions-2019-09" USING btree (campaign_id);


--
-- Name: index_impressions-2019-09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-09_on_displayed_at_date" ON public."impressions-2019-09" USING btree (displayed_at_date);


--
-- Name: index_impressions-2019-09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-09_on_displayed_at_hour" ON public."impressions-2019-09" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2019-09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-09_on_payable" ON public."impressions-2019-09" USING btree (payable);


--
-- Name: index_impressions-2019-09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-09_on_property_id" ON public."impressions-2019-09" USING btree (property_id);


--
-- Name: index_impressions-2019-10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-10_on_campaign_id" ON public."impressions-2019-10" USING btree (campaign_id);


--
-- Name: index_impressions-2019-10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-10_on_displayed_at_date" ON public."impressions-2019-10" USING btree (displayed_at_date);


--
-- Name: index_impressions-2019-10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-10_on_displayed_at_hour" ON public."impressions-2019-10" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2019-10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-10_on_payable" ON public."impressions-2019-10" USING btree (payable);


--
-- Name: index_impressions-2019-10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-10_on_property_id" ON public."impressions-2019-10" USING btree (property_id);


--
-- Name: index_impressions-2019-11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-11_on_campaign_id" ON public."impressions-2019-11" USING btree (campaign_id);


--
-- Name: index_impressions-2019-11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-11_on_displayed_at_date" ON public."impressions-2019-11" USING btree (displayed_at_date);


--
-- Name: index_impressions-2019-11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-11_on_displayed_at_hour" ON public."impressions-2019-11" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2019-11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-11_on_payable" ON public."impressions-2019-11" USING btree (payable);


--
-- Name: index_impressions-2019-11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-11_on_property_id" ON public."impressions-2019-11" USING btree (property_id);


--
-- Name: index_impressions-2019-12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-12_on_campaign_id" ON public."impressions-2019-12" USING btree (campaign_id);


--
-- Name: index_impressions-2019-12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-12_on_displayed_at_date" ON public."impressions-2019-12" USING btree (displayed_at_date);


--
-- Name: index_impressions-2019-12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-12_on_displayed_at_hour" ON public."impressions-2019-12" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2019-12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-12_on_payable" ON public."impressions-2019-12" USING btree (payable);


--
-- Name: index_impressions-2019-12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2019-12_on_property_id" ON public."impressions-2019-12" USING btree (property_id);


--
-- Name: index_impressions-2020-01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-01_on_campaign_id" ON public."impressions-2020-01" USING btree (campaign_id);


--
-- Name: index_impressions-2020-01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-01_on_displayed_at_date" ON public."impressions-2020-01" USING btree (displayed_at_date);


--
-- Name: index_impressions-2020-01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-01_on_displayed_at_hour" ON public."impressions-2020-01" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2020-01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-01_on_payable" ON public."impressions-2020-01" USING btree (payable);


--
-- Name: index_impressions-2020-01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-01_on_property_id" ON public."impressions-2020-01" USING btree (property_id);


--
-- Name: index_impressions-2020-02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-02_on_campaign_id" ON public."impressions-2020-02" USING btree (campaign_id);


--
-- Name: index_impressions-2020-02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-02_on_displayed_at_date" ON public."impressions-2020-02" USING btree (displayed_at_date);


--
-- Name: index_impressions-2020-02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-02_on_displayed_at_hour" ON public."impressions-2020-02" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2020-02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-02_on_payable" ON public."impressions-2020-02" USING btree (payable);


--
-- Name: index_impressions-2020-02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-02_on_property_id" ON public."impressions-2020-02" USING btree (property_id);


--
-- Name: index_impressions-2020-03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-03_on_campaign_id" ON public."impressions-2020-03" USING btree (campaign_id);


--
-- Name: index_impressions-2020-03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-03_on_displayed_at_date" ON public."impressions-2020-03" USING btree (displayed_at_date);


--
-- Name: index_impressions-2020-03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-03_on_displayed_at_hour" ON public."impressions-2020-03" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2020-03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-03_on_payable" ON public."impressions-2020-03" USING btree (payable);


--
-- Name: index_impressions-2020-03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-03_on_property_id" ON public."impressions-2020-03" USING btree (property_id);


--
-- Name: index_impressions-2020-04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-04_on_campaign_id" ON public."impressions-2020-04" USING btree (campaign_id);


--
-- Name: index_impressions-2020-04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-04_on_displayed_at_date" ON public."impressions-2020-04" USING btree (displayed_at_date);


--
-- Name: index_impressions-2020-04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-04_on_displayed_at_hour" ON public."impressions-2020-04" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2020-04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-04_on_payable" ON public."impressions-2020-04" USING btree (payable);


--
-- Name: index_impressions-2020-04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-04_on_property_id" ON public."impressions-2020-04" USING btree (property_id);


--
-- Name: index_impressions-2020-05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-05_on_campaign_id" ON public."impressions-2020-05" USING btree (campaign_id);


--
-- Name: index_impressions-2020-05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-05_on_displayed_at_date" ON public."impressions-2020-05" USING btree (displayed_at_date);


--
-- Name: index_impressions-2020-05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-05_on_displayed_at_hour" ON public."impressions-2020-05" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2020-05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-05_on_payable" ON public."impressions-2020-05" USING btree (payable);


--
-- Name: index_impressions-2020-05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-05_on_property_id" ON public."impressions-2020-05" USING btree (property_id);


--
-- Name: index_impressions-2020-06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-06_on_campaign_id" ON public."impressions-2020-06" USING btree (campaign_id);


--
-- Name: index_impressions-2020-06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-06_on_displayed_at_date" ON public."impressions-2020-06" USING btree (displayed_at_date);


--
-- Name: index_impressions-2020-06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-06_on_displayed_at_hour" ON public."impressions-2020-06" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2020-06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-06_on_payable" ON public."impressions-2020-06" USING btree (payable);


--
-- Name: index_impressions-2020-06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-06_on_property_id" ON public."impressions-2020-06" USING btree (property_id);


--
-- Name: index_impressions-2020-07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-07_on_campaign_id" ON public."impressions-2020-07" USING btree (campaign_id);


--
-- Name: index_impressions-2020-07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-07_on_displayed_at_date" ON public."impressions-2020-07" USING btree (displayed_at_date);


--
-- Name: index_impressions-2020-07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-07_on_displayed_at_hour" ON public."impressions-2020-07" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2020-07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-07_on_payable" ON public."impressions-2020-07" USING btree (payable);


--
-- Name: index_impressions-2020-07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-07_on_property_id" ON public."impressions-2020-07" USING btree (property_id);


--
-- Name: index_impressions-2020-08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-08_on_campaign_id" ON public."impressions-2020-08" USING btree (campaign_id);


--
-- Name: index_impressions-2020-08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-08_on_displayed_at_date" ON public."impressions-2020-08" USING btree (displayed_at_date);


--
-- Name: index_impressions-2020-08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-08_on_displayed_at_hour" ON public."impressions-2020-08" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2020-08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-08_on_payable" ON public."impressions-2020-08" USING btree (payable);


--
-- Name: index_impressions-2020-08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-08_on_property_id" ON public."impressions-2020-08" USING btree (property_id);


--
-- Name: index_impressions-2020-09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-09_on_campaign_id" ON public."impressions-2020-09" USING btree (campaign_id);


--
-- Name: index_impressions-2020-09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-09_on_displayed_at_date" ON public."impressions-2020-09" USING btree (displayed_at_date);


--
-- Name: index_impressions-2020-09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-09_on_displayed_at_hour" ON public."impressions-2020-09" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2020-09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-09_on_payable" ON public."impressions-2020-09" USING btree (payable);


--
-- Name: index_impressions-2020-09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-09_on_property_id" ON public."impressions-2020-09" USING btree (property_id);


--
-- Name: index_impressions-2020-10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-10_on_campaign_id" ON public."impressions-2020-10" USING btree (campaign_id);


--
-- Name: index_impressions-2020-10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-10_on_displayed_at_date" ON public."impressions-2020-10" USING btree (displayed_at_date);


--
-- Name: index_impressions-2020-10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-10_on_displayed_at_hour" ON public."impressions-2020-10" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2020-10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-10_on_payable" ON public."impressions-2020-10" USING btree (payable);


--
-- Name: index_impressions-2020-10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-10_on_property_id" ON public."impressions-2020-10" USING btree (property_id);


--
-- Name: index_impressions-2020-11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-11_on_campaign_id" ON public."impressions-2020-11" USING btree (campaign_id);


--
-- Name: index_impressions-2020-11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-11_on_displayed_at_date" ON public."impressions-2020-11" USING btree (displayed_at_date);


--
-- Name: index_impressions-2020-11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-11_on_displayed_at_hour" ON public."impressions-2020-11" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2020-11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-11_on_payable" ON public."impressions-2020-11" USING btree (payable);


--
-- Name: index_impressions-2020-11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-11_on_property_id" ON public."impressions-2020-11" USING btree (property_id);


--
-- Name: index_impressions-2020-12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-12_on_campaign_id" ON public."impressions-2020-12" USING btree (campaign_id);


--
-- Name: index_impressions-2020-12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-12_on_displayed_at_date" ON public."impressions-2020-12" USING btree (displayed_at_date);


--
-- Name: index_impressions-2020-12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-12_on_displayed_at_hour" ON public."impressions-2020-12" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2020-12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-12_on_payable" ON public."impressions-2020-12" USING btree (payable);


--
-- Name: index_impressions-2020-12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2020-12_on_property_id" ON public."impressions-2020-12" USING btree (property_id);


--
-- Name: index_impressions-2021-01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-01_on_campaign_id" ON public."impressions-2021-01" USING btree (campaign_id);


--
-- Name: index_impressions-2021-01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-01_on_displayed_at_date" ON public."impressions-2021-01" USING btree (displayed_at_date);


--
-- Name: index_impressions-2021-01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-01_on_displayed_at_hour" ON public."impressions-2021-01" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2021-01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-01_on_payable" ON public."impressions-2021-01" USING btree (payable);


--
-- Name: index_impressions-2021-01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-01_on_property_id" ON public."impressions-2021-01" USING btree (property_id);


--
-- Name: index_impressions-2021-02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-02_on_campaign_id" ON public."impressions-2021-02" USING btree (campaign_id);


--
-- Name: index_impressions-2021-02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-02_on_displayed_at_date" ON public."impressions-2021-02" USING btree (displayed_at_date);


--
-- Name: index_impressions-2021-02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-02_on_displayed_at_hour" ON public."impressions-2021-02" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2021-02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-02_on_payable" ON public."impressions-2021-02" USING btree (payable);


--
-- Name: index_impressions-2021-02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-02_on_property_id" ON public."impressions-2021-02" USING btree (property_id);


--
-- Name: index_impressions-2021-03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-03_on_campaign_id" ON public."impressions-2021-03" USING btree (campaign_id);


--
-- Name: index_impressions-2021-03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-03_on_displayed_at_date" ON public."impressions-2021-03" USING btree (displayed_at_date);


--
-- Name: index_impressions-2021-03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-03_on_displayed_at_hour" ON public."impressions-2021-03" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2021-03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-03_on_payable" ON public."impressions-2021-03" USING btree (payable);


--
-- Name: index_impressions-2021-03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-03_on_property_id" ON public."impressions-2021-03" USING btree (property_id);


--
-- Name: index_impressions-2021-04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-04_on_campaign_id" ON public."impressions-2021-04" USING btree (campaign_id);


--
-- Name: index_impressions-2021-04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-04_on_displayed_at_date" ON public."impressions-2021-04" USING btree (displayed_at_date);


--
-- Name: index_impressions-2021-04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-04_on_displayed_at_hour" ON public."impressions-2021-04" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2021-04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-04_on_payable" ON public."impressions-2021-04" USING btree (payable);


--
-- Name: index_impressions-2021-04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-04_on_property_id" ON public."impressions-2021-04" USING btree (property_id);


--
-- Name: index_impressions-2021-05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-05_on_campaign_id" ON public."impressions-2021-05" USING btree (campaign_id);


--
-- Name: index_impressions-2021-05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-05_on_displayed_at_date" ON public."impressions-2021-05" USING btree (displayed_at_date);


--
-- Name: index_impressions-2021-05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-05_on_displayed_at_hour" ON public."impressions-2021-05" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2021-05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-05_on_payable" ON public."impressions-2021-05" USING btree (payable);


--
-- Name: index_impressions-2021-05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-05_on_property_id" ON public."impressions-2021-05" USING btree (property_id);


--
-- Name: index_impressions-2021-06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-06_on_campaign_id" ON public."impressions-2021-06" USING btree (campaign_id);


--
-- Name: index_impressions-2021-06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-06_on_displayed_at_date" ON public."impressions-2021-06" USING btree (displayed_at_date);


--
-- Name: index_impressions-2021-06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-06_on_displayed_at_hour" ON public."impressions-2021-06" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2021-06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-06_on_payable" ON public."impressions-2021-06" USING btree (payable);


--
-- Name: index_impressions-2021-06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-06_on_property_id" ON public."impressions-2021-06" USING btree (property_id);


--
-- Name: index_impressions-2021-07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-07_on_campaign_id" ON public."impressions-2021-07" USING btree (campaign_id);


--
-- Name: index_impressions-2021-07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-07_on_displayed_at_date" ON public."impressions-2021-07" USING btree (displayed_at_date);


--
-- Name: index_impressions-2021-07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-07_on_displayed_at_hour" ON public."impressions-2021-07" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2021-07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-07_on_payable" ON public."impressions-2021-07" USING btree (payable);


--
-- Name: index_impressions-2021-07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-07_on_property_id" ON public."impressions-2021-07" USING btree (property_id);


--
-- Name: index_impressions-2021-08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-08_on_campaign_id" ON public."impressions-2021-08" USING btree (campaign_id);


--
-- Name: index_impressions-2021-08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-08_on_displayed_at_date" ON public."impressions-2021-08" USING btree (displayed_at_date);


--
-- Name: index_impressions-2021-08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-08_on_displayed_at_hour" ON public."impressions-2021-08" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2021-08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-08_on_payable" ON public."impressions-2021-08" USING btree (payable);


--
-- Name: index_impressions-2021-08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-08_on_property_id" ON public."impressions-2021-08" USING btree (property_id);


--
-- Name: index_impressions-2021-09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-09_on_campaign_id" ON public."impressions-2021-09" USING btree (campaign_id);


--
-- Name: index_impressions-2021-09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-09_on_displayed_at_date" ON public."impressions-2021-09" USING btree (displayed_at_date);


--
-- Name: index_impressions-2021-09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-09_on_displayed_at_hour" ON public."impressions-2021-09" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2021-09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-09_on_payable" ON public."impressions-2021-09" USING btree (payable);


--
-- Name: index_impressions-2021-09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-09_on_property_id" ON public."impressions-2021-09" USING btree (property_id);


--
-- Name: index_impressions-2021-10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-10_on_campaign_id" ON public."impressions-2021-10" USING btree (campaign_id);


--
-- Name: index_impressions-2021-10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-10_on_displayed_at_date" ON public."impressions-2021-10" USING btree (displayed_at_date);


--
-- Name: index_impressions-2021-10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-10_on_displayed_at_hour" ON public."impressions-2021-10" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2021-10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-10_on_payable" ON public."impressions-2021-10" USING btree (payable);


--
-- Name: index_impressions-2021-10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-10_on_property_id" ON public."impressions-2021-10" USING btree (property_id);


--
-- Name: index_impressions-2021-11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-11_on_campaign_id" ON public."impressions-2021-11" USING btree (campaign_id);


--
-- Name: index_impressions-2021-11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-11_on_displayed_at_date" ON public."impressions-2021-11" USING btree (displayed_at_date);


--
-- Name: index_impressions-2021-11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-11_on_displayed_at_hour" ON public."impressions-2021-11" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2021-11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-11_on_payable" ON public."impressions-2021-11" USING btree (payable);


--
-- Name: index_impressions-2021-11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-11_on_property_id" ON public."impressions-2021-11" USING btree (property_id);


--
-- Name: index_impressions-2021-12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-12_on_campaign_id" ON public."impressions-2021-12" USING btree (campaign_id);


--
-- Name: index_impressions-2021-12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-12_on_displayed_at_date" ON public."impressions-2021-12" USING btree (displayed_at_date);


--
-- Name: index_impressions-2021-12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-12_on_displayed_at_hour" ON public."impressions-2021-12" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2021-12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-12_on_payable" ON public."impressions-2021-12" USING btree (payable);


--
-- Name: index_impressions-2021-12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2021-12_on_property_id" ON public."impressions-2021-12" USING btree (property_id);


--
-- Name: index_impressions-2022-01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-01_on_campaign_id" ON public."impressions-2022-01" USING btree (campaign_id);


--
-- Name: index_impressions-2022-01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-01_on_displayed_at_date" ON public."impressions-2022-01" USING btree (displayed_at_date);


--
-- Name: index_impressions-2022-01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-01_on_displayed_at_hour" ON public."impressions-2022-01" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2022-01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-01_on_payable" ON public."impressions-2022-01" USING btree (payable);


--
-- Name: index_impressions-2022-01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-01_on_property_id" ON public."impressions-2022-01" USING btree (property_id);


--
-- Name: index_impressions-2022-02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-02_on_campaign_id" ON public."impressions-2022-02" USING btree (campaign_id);


--
-- Name: index_impressions-2022-02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-02_on_displayed_at_date" ON public."impressions-2022-02" USING btree (displayed_at_date);


--
-- Name: index_impressions-2022-02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-02_on_displayed_at_hour" ON public."impressions-2022-02" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2022-02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-02_on_payable" ON public."impressions-2022-02" USING btree (payable);


--
-- Name: index_impressions-2022-02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-02_on_property_id" ON public."impressions-2022-02" USING btree (property_id);


--
-- Name: index_impressions-2022-03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-03_on_campaign_id" ON public."impressions-2022-03" USING btree (campaign_id);


--
-- Name: index_impressions-2022-03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-03_on_displayed_at_date" ON public."impressions-2022-03" USING btree (displayed_at_date);


--
-- Name: index_impressions-2022-03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-03_on_displayed_at_hour" ON public."impressions-2022-03" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2022-03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-03_on_payable" ON public."impressions-2022-03" USING btree (payable);


--
-- Name: index_impressions-2022-03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-03_on_property_id" ON public."impressions-2022-03" USING btree (property_id);


--
-- Name: index_impressions-2022-04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-04_on_campaign_id" ON public."impressions-2022-04" USING btree (campaign_id);


--
-- Name: index_impressions-2022-04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-04_on_displayed_at_date" ON public."impressions-2022-04" USING btree (displayed_at_date);


--
-- Name: index_impressions-2022-04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-04_on_displayed_at_hour" ON public."impressions-2022-04" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2022-04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-04_on_payable" ON public."impressions-2022-04" USING btree (payable);


--
-- Name: index_impressions-2022-04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-04_on_property_id" ON public."impressions-2022-04" USING btree (property_id);


--
-- Name: index_impressions-2022-05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-05_on_campaign_id" ON public."impressions-2022-05" USING btree (campaign_id);


--
-- Name: index_impressions-2022-05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-05_on_displayed_at_date" ON public."impressions-2022-05" USING btree (displayed_at_date);


--
-- Name: index_impressions-2022-05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-05_on_displayed_at_hour" ON public."impressions-2022-05" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2022-05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-05_on_payable" ON public."impressions-2022-05" USING btree (payable);


--
-- Name: index_impressions-2022-05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-05_on_property_id" ON public."impressions-2022-05" USING btree (property_id);


--
-- Name: index_impressions-2022-06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-06_on_campaign_id" ON public."impressions-2022-06" USING btree (campaign_id);


--
-- Name: index_impressions-2022-06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-06_on_displayed_at_date" ON public."impressions-2022-06" USING btree (displayed_at_date);


--
-- Name: index_impressions-2022-06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-06_on_displayed_at_hour" ON public."impressions-2022-06" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2022-06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-06_on_payable" ON public."impressions-2022-06" USING btree (payable);


--
-- Name: index_impressions-2022-06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-06_on_property_id" ON public."impressions-2022-06" USING btree (property_id);


--
-- Name: index_impressions-2022-07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-07_on_campaign_id" ON public."impressions-2022-07" USING btree (campaign_id);


--
-- Name: index_impressions-2022-07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-07_on_displayed_at_date" ON public."impressions-2022-07" USING btree (displayed_at_date);


--
-- Name: index_impressions-2022-07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-07_on_displayed_at_hour" ON public."impressions-2022-07" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2022-07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-07_on_payable" ON public."impressions-2022-07" USING btree (payable);


--
-- Name: index_impressions-2022-07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-07_on_property_id" ON public."impressions-2022-07" USING btree (property_id);


--
-- Name: index_impressions-2022-08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-08_on_campaign_id" ON public."impressions-2022-08" USING btree (campaign_id);


--
-- Name: index_impressions-2022-08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-08_on_displayed_at_date" ON public."impressions-2022-08" USING btree (displayed_at_date);


--
-- Name: index_impressions-2022-08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-08_on_displayed_at_hour" ON public."impressions-2022-08" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2022-08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-08_on_payable" ON public."impressions-2022-08" USING btree (payable);


--
-- Name: index_impressions-2022-08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-08_on_property_id" ON public."impressions-2022-08" USING btree (property_id);


--
-- Name: index_impressions-2022-09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-09_on_campaign_id" ON public."impressions-2022-09" USING btree (campaign_id);


--
-- Name: index_impressions-2022-09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-09_on_displayed_at_date" ON public."impressions-2022-09" USING btree (displayed_at_date);


--
-- Name: index_impressions-2022-09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-09_on_displayed_at_hour" ON public."impressions-2022-09" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2022-09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-09_on_payable" ON public."impressions-2022-09" USING btree (payable);


--
-- Name: index_impressions-2022-09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-09_on_property_id" ON public."impressions-2022-09" USING btree (property_id);


--
-- Name: index_impressions-2022-10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-10_on_campaign_id" ON public."impressions-2022-10" USING btree (campaign_id);


--
-- Name: index_impressions-2022-10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-10_on_displayed_at_date" ON public."impressions-2022-10" USING btree (displayed_at_date);


--
-- Name: index_impressions-2022-10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-10_on_displayed_at_hour" ON public."impressions-2022-10" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2022-10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-10_on_payable" ON public."impressions-2022-10" USING btree (payable);


--
-- Name: index_impressions-2022-10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-10_on_property_id" ON public."impressions-2022-10" USING btree (property_id);


--
-- Name: index_impressions-2022-11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-11_on_campaign_id" ON public."impressions-2022-11" USING btree (campaign_id);


--
-- Name: index_impressions-2022-11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-11_on_displayed_at_date" ON public."impressions-2022-11" USING btree (displayed_at_date);


--
-- Name: index_impressions-2022-11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-11_on_displayed_at_hour" ON public."impressions-2022-11" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2022-11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-11_on_payable" ON public."impressions-2022-11" USING btree (payable);


--
-- Name: index_impressions-2022-11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-11_on_property_id" ON public."impressions-2022-11" USING btree (property_id);


--
-- Name: index_impressions-2022-12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-12_on_campaign_id" ON public."impressions-2022-12" USING btree (campaign_id);


--
-- Name: index_impressions-2022-12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-12_on_displayed_at_date" ON public."impressions-2022-12" USING btree (displayed_at_date);


--
-- Name: index_impressions-2022-12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-12_on_displayed_at_hour" ON public."impressions-2022-12" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2022-12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-12_on_payable" ON public."impressions-2022-12" USING btree (payable);


--
-- Name: index_impressions-2022-12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2022-12_on_property_id" ON public."impressions-2022-12" USING btree (property_id);


--
-- Name: index_impressions-2023-01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-01_on_campaign_id" ON public."impressions-2023-01" USING btree (campaign_id);


--
-- Name: index_impressions-2023-01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-01_on_displayed_at_date" ON public."impressions-2023-01" USING btree (displayed_at_date);


--
-- Name: index_impressions-2023-01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-01_on_displayed_at_hour" ON public."impressions-2023-01" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2023-01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-01_on_payable" ON public."impressions-2023-01" USING btree (payable);


--
-- Name: index_impressions-2023-01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-01_on_property_id" ON public."impressions-2023-01" USING btree (property_id);


--
-- Name: index_impressions-2023-02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-02_on_campaign_id" ON public."impressions-2023-02" USING btree (campaign_id);


--
-- Name: index_impressions-2023-02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-02_on_displayed_at_date" ON public."impressions-2023-02" USING btree (displayed_at_date);


--
-- Name: index_impressions-2023-02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-02_on_displayed_at_hour" ON public."impressions-2023-02" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2023-02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-02_on_payable" ON public."impressions-2023-02" USING btree (payable);


--
-- Name: index_impressions-2023-02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-02_on_property_id" ON public."impressions-2023-02" USING btree (property_id);


--
-- Name: index_impressions-2023-03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-03_on_campaign_id" ON public."impressions-2023-03" USING btree (campaign_id);


--
-- Name: index_impressions-2023-03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-03_on_displayed_at_date" ON public."impressions-2023-03" USING btree (displayed_at_date);


--
-- Name: index_impressions-2023-03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-03_on_displayed_at_hour" ON public."impressions-2023-03" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2023-03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-03_on_payable" ON public."impressions-2023-03" USING btree (payable);


--
-- Name: index_impressions-2023-03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-03_on_property_id" ON public."impressions-2023-03" USING btree (property_id);


--
-- Name: index_impressions-2023-04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-04_on_campaign_id" ON public."impressions-2023-04" USING btree (campaign_id);


--
-- Name: index_impressions-2023-04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-04_on_displayed_at_date" ON public."impressions-2023-04" USING btree (displayed_at_date);


--
-- Name: index_impressions-2023-04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-04_on_displayed_at_hour" ON public."impressions-2023-04" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2023-04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-04_on_payable" ON public."impressions-2023-04" USING btree (payable);


--
-- Name: index_impressions-2023-04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-04_on_property_id" ON public."impressions-2023-04" USING btree (property_id);


--
-- Name: index_impressions-2023-05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-05_on_campaign_id" ON public."impressions-2023-05" USING btree (campaign_id);


--
-- Name: index_impressions-2023-05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-05_on_displayed_at_date" ON public."impressions-2023-05" USING btree (displayed_at_date);


--
-- Name: index_impressions-2023-05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-05_on_displayed_at_hour" ON public."impressions-2023-05" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2023-05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-05_on_payable" ON public."impressions-2023-05" USING btree (payable);


--
-- Name: index_impressions-2023-05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-05_on_property_id" ON public."impressions-2023-05" USING btree (property_id);


--
-- Name: index_impressions-2023-06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-06_on_campaign_id" ON public."impressions-2023-06" USING btree (campaign_id);


--
-- Name: index_impressions-2023-06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-06_on_displayed_at_date" ON public."impressions-2023-06" USING btree (displayed_at_date);


--
-- Name: index_impressions-2023-06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-06_on_displayed_at_hour" ON public."impressions-2023-06" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2023-06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-06_on_payable" ON public."impressions-2023-06" USING btree (payable);


--
-- Name: index_impressions-2023-06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-06_on_property_id" ON public."impressions-2023-06" USING btree (property_id);


--
-- Name: index_impressions-2023-07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-07_on_campaign_id" ON public."impressions-2023-07" USING btree (campaign_id);


--
-- Name: index_impressions-2023-07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-07_on_displayed_at_date" ON public."impressions-2023-07" USING btree (displayed_at_date);


--
-- Name: index_impressions-2023-07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-07_on_displayed_at_hour" ON public."impressions-2023-07" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2023-07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-07_on_payable" ON public."impressions-2023-07" USING btree (payable);


--
-- Name: index_impressions-2023-07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-07_on_property_id" ON public."impressions-2023-07" USING btree (property_id);


--
-- Name: index_impressions-2023-08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-08_on_campaign_id" ON public."impressions-2023-08" USING btree (campaign_id);


--
-- Name: index_impressions-2023-08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-08_on_displayed_at_date" ON public."impressions-2023-08" USING btree (displayed_at_date);


--
-- Name: index_impressions-2023-08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-08_on_displayed_at_hour" ON public."impressions-2023-08" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2023-08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-08_on_payable" ON public."impressions-2023-08" USING btree (payable);


--
-- Name: index_impressions-2023-08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-08_on_property_id" ON public."impressions-2023-08" USING btree (property_id);


--
-- Name: index_impressions-2023-09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-09_on_campaign_id" ON public."impressions-2023-09" USING btree (campaign_id);


--
-- Name: index_impressions-2023-09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-09_on_displayed_at_date" ON public."impressions-2023-09" USING btree (displayed_at_date);


--
-- Name: index_impressions-2023-09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-09_on_displayed_at_hour" ON public."impressions-2023-09" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2023-09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-09_on_payable" ON public."impressions-2023-09" USING btree (payable);


--
-- Name: index_impressions-2023-09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-09_on_property_id" ON public."impressions-2023-09" USING btree (property_id);


--
-- Name: index_impressions-2023-10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-10_on_campaign_id" ON public."impressions-2023-10" USING btree (campaign_id);


--
-- Name: index_impressions-2023-10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-10_on_displayed_at_date" ON public."impressions-2023-10" USING btree (displayed_at_date);


--
-- Name: index_impressions-2023-10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-10_on_displayed_at_hour" ON public."impressions-2023-10" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2023-10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-10_on_payable" ON public."impressions-2023-10" USING btree (payable);


--
-- Name: index_impressions-2023-10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-10_on_property_id" ON public."impressions-2023-10" USING btree (property_id);


--
-- Name: index_impressions-2023-11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-11_on_campaign_id" ON public."impressions-2023-11" USING btree (campaign_id);


--
-- Name: index_impressions-2023-11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-11_on_displayed_at_date" ON public."impressions-2023-11" USING btree (displayed_at_date);


--
-- Name: index_impressions-2023-11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-11_on_displayed_at_hour" ON public."impressions-2023-11" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2023-11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-11_on_payable" ON public."impressions-2023-11" USING btree (payable);


--
-- Name: index_impressions-2023-11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-11_on_property_id" ON public."impressions-2023-11" USING btree (property_id);


--
-- Name: index_impressions-2023-12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-12_on_campaign_id" ON public."impressions-2023-12" USING btree (campaign_id);


--
-- Name: index_impressions-2023-12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-12_on_displayed_at_date" ON public."impressions-2023-12" USING btree (displayed_at_date);


--
-- Name: index_impressions-2023-12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-12_on_displayed_at_hour" ON public."impressions-2023-12" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2023-12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-12_on_payable" ON public."impressions-2023-12" USING btree (payable);


--
-- Name: index_impressions-2023-12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2023-12_on_property_id" ON public."impressions-2023-12" USING btree (property_id);


--
-- Name: index_impressions-2024-01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-01_on_campaign_id" ON public."impressions-2024-01" USING btree (campaign_id);


--
-- Name: index_impressions-2024-01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-01_on_displayed_at_date" ON public."impressions-2024-01" USING btree (displayed_at_date);


--
-- Name: index_impressions-2024-01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-01_on_displayed_at_hour" ON public."impressions-2024-01" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2024-01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-01_on_payable" ON public."impressions-2024-01" USING btree (payable);


--
-- Name: index_impressions-2024-01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-01_on_property_id" ON public."impressions-2024-01" USING btree (property_id);


--
-- Name: index_impressions-2024-02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-02_on_campaign_id" ON public."impressions-2024-02" USING btree (campaign_id);


--
-- Name: index_impressions-2024-02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-02_on_displayed_at_date" ON public."impressions-2024-02" USING btree (displayed_at_date);


--
-- Name: index_impressions-2024-02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-02_on_displayed_at_hour" ON public."impressions-2024-02" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2024-02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-02_on_payable" ON public."impressions-2024-02" USING btree (payable);


--
-- Name: index_impressions-2024-02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-02_on_property_id" ON public."impressions-2024-02" USING btree (property_id);


--
-- Name: index_impressions-2024-03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-03_on_campaign_id" ON public."impressions-2024-03" USING btree (campaign_id);


--
-- Name: index_impressions-2024-03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-03_on_displayed_at_date" ON public."impressions-2024-03" USING btree (displayed_at_date);


--
-- Name: index_impressions-2024-03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-03_on_displayed_at_hour" ON public."impressions-2024-03" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2024-03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-03_on_payable" ON public."impressions-2024-03" USING btree (payable);


--
-- Name: index_impressions-2024-03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-03_on_property_id" ON public."impressions-2024-03" USING btree (property_id);


--
-- Name: index_impressions-2024-04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-04_on_campaign_id" ON public."impressions-2024-04" USING btree (campaign_id);


--
-- Name: index_impressions-2024-04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-04_on_displayed_at_date" ON public."impressions-2024-04" USING btree (displayed_at_date);


--
-- Name: index_impressions-2024-04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-04_on_displayed_at_hour" ON public."impressions-2024-04" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2024-04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-04_on_payable" ON public."impressions-2024-04" USING btree (payable);


--
-- Name: index_impressions-2024-04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-04_on_property_id" ON public."impressions-2024-04" USING btree (property_id);


--
-- Name: index_impressions-2024-05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-05_on_campaign_id" ON public."impressions-2024-05" USING btree (campaign_id);


--
-- Name: index_impressions-2024-05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-05_on_displayed_at_date" ON public."impressions-2024-05" USING btree (displayed_at_date);


--
-- Name: index_impressions-2024-05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-05_on_displayed_at_hour" ON public."impressions-2024-05" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2024-05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-05_on_payable" ON public."impressions-2024-05" USING btree (payable);


--
-- Name: index_impressions-2024-05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-05_on_property_id" ON public."impressions-2024-05" USING btree (property_id);


--
-- Name: index_impressions-2024-06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-06_on_campaign_id" ON public."impressions-2024-06" USING btree (campaign_id);


--
-- Name: index_impressions-2024-06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-06_on_displayed_at_date" ON public."impressions-2024-06" USING btree (displayed_at_date);


--
-- Name: index_impressions-2024-06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-06_on_displayed_at_hour" ON public."impressions-2024-06" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2024-06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-06_on_payable" ON public."impressions-2024-06" USING btree (payable);


--
-- Name: index_impressions-2024-06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-06_on_property_id" ON public."impressions-2024-06" USING btree (property_id);


--
-- Name: index_impressions-2024-07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-07_on_campaign_id" ON public."impressions-2024-07" USING btree (campaign_id);


--
-- Name: index_impressions-2024-07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-07_on_displayed_at_date" ON public."impressions-2024-07" USING btree (displayed_at_date);


--
-- Name: index_impressions-2024-07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-07_on_displayed_at_hour" ON public."impressions-2024-07" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2024-07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-07_on_payable" ON public."impressions-2024-07" USING btree (payable);


--
-- Name: index_impressions-2024-07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-07_on_property_id" ON public."impressions-2024-07" USING btree (property_id);


--
-- Name: index_impressions-2024-08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-08_on_campaign_id" ON public."impressions-2024-08" USING btree (campaign_id);


--
-- Name: index_impressions-2024-08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-08_on_displayed_at_date" ON public."impressions-2024-08" USING btree (displayed_at_date);


--
-- Name: index_impressions-2024-08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-08_on_displayed_at_hour" ON public."impressions-2024-08" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2024-08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-08_on_payable" ON public."impressions-2024-08" USING btree (payable);


--
-- Name: index_impressions-2024-08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-08_on_property_id" ON public."impressions-2024-08" USING btree (property_id);


--
-- Name: index_impressions-2024-09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-09_on_campaign_id" ON public."impressions-2024-09" USING btree (campaign_id);


--
-- Name: index_impressions-2024-09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-09_on_displayed_at_date" ON public."impressions-2024-09" USING btree (displayed_at_date);


--
-- Name: index_impressions-2024-09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-09_on_displayed_at_hour" ON public."impressions-2024-09" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2024-09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-09_on_payable" ON public."impressions-2024-09" USING btree (payable);


--
-- Name: index_impressions-2024-09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-09_on_property_id" ON public."impressions-2024-09" USING btree (property_id);


--
-- Name: index_impressions-2024-10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-10_on_campaign_id" ON public."impressions-2024-10" USING btree (campaign_id);


--
-- Name: index_impressions-2024-10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-10_on_displayed_at_date" ON public."impressions-2024-10" USING btree (displayed_at_date);


--
-- Name: index_impressions-2024-10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-10_on_displayed_at_hour" ON public."impressions-2024-10" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2024-10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-10_on_payable" ON public."impressions-2024-10" USING btree (payable);


--
-- Name: index_impressions-2024-10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-10_on_property_id" ON public."impressions-2024-10" USING btree (property_id);


--
-- Name: index_impressions-2024-11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-11_on_campaign_id" ON public."impressions-2024-11" USING btree (campaign_id);


--
-- Name: index_impressions-2024-11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-11_on_displayed_at_date" ON public."impressions-2024-11" USING btree (displayed_at_date);


--
-- Name: index_impressions-2024-11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-11_on_displayed_at_hour" ON public."impressions-2024-11" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2024-11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-11_on_payable" ON public."impressions-2024-11" USING btree (payable);


--
-- Name: index_impressions-2024-11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-11_on_property_id" ON public."impressions-2024-11" USING btree (property_id);


--
-- Name: index_impressions-2024-12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-12_on_campaign_id" ON public."impressions-2024-12" USING btree (campaign_id);


--
-- Name: index_impressions-2024-12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-12_on_displayed_at_date" ON public."impressions-2024-12" USING btree (displayed_at_date);


--
-- Name: index_impressions-2024-12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-12_on_displayed_at_hour" ON public."impressions-2024-12" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2024-12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-12_on_payable" ON public."impressions-2024-12" USING btree (payable);


--
-- Name: index_impressions-2024-12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2024-12_on_property_id" ON public."impressions-2024-12" USING btree (property_id);


--
-- Name: index_impressions-2025-01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-01_on_campaign_id" ON public."impressions-2025-01" USING btree (campaign_id);


--
-- Name: index_impressions-2025-01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-01_on_displayed_at_date" ON public."impressions-2025-01" USING btree (displayed_at_date);


--
-- Name: index_impressions-2025-01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-01_on_displayed_at_hour" ON public."impressions-2025-01" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2025-01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-01_on_payable" ON public."impressions-2025-01" USING btree (payable);


--
-- Name: index_impressions-2025-01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-01_on_property_id" ON public."impressions-2025-01" USING btree (property_id);


--
-- Name: index_impressions-2025-02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-02_on_campaign_id" ON public."impressions-2025-02" USING btree (campaign_id);


--
-- Name: index_impressions-2025-02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-02_on_displayed_at_date" ON public."impressions-2025-02" USING btree (displayed_at_date);


--
-- Name: index_impressions-2025-02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-02_on_displayed_at_hour" ON public."impressions-2025-02" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2025-02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-02_on_payable" ON public."impressions-2025-02" USING btree (payable);


--
-- Name: index_impressions-2025-02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-02_on_property_id" ON public."impressions-2025-02" USING btree (property_id);


--
-- Name: index_impressions-2025-03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-03_on_campaign_id" ON public."impressions-2025-03" USING btree (campaign_id);


--
-- Name: index_impressions-2025-03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-03_on_displayed_at_date" ON public."impressions-2025-03" USING btree (displayed_at_date);


--
-- Name: index_impressions-2025-03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-03_on_displayed_at_hour" ON public."impressions-2025-03" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2025-03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-03_on_payable" ON public."impressions-2025-03" USING btree (payable);


--
-- Name: index_impressions-2025-03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-03_on_property_id" ON public."impressions-2025-03" USING btree (property_id);


--
-- Name: index_impressions-2025-04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-04_on_campaign_id" ON public."impressions-2025-04" USING btree (campaign_id);


--
-- Name: index_impressions-2025-04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-04_on_displayed_at_date" ON public."impressions-2025-04" USING btree (displayed_at_date);


--
-- Name: index_impressions-2025-04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-04_on_displayed_at_hour" ON public."impressions-2025-04" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2025-04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-04_on_payable" ON public."impressions-2025-04" USING btree (payable);


--
-- Name: index_impressions-2025-04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-04_on_property_id" ON public."impressions-2025-04" USING btree (property_id);


--
-- Name: index_impressions-2025-05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-05_on_campaign_id" ON public."impressions-2025-05" USING btree (campaign_id);


--
-- Name: index_impressions-2025-05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-05_on_displayed_at_date" ON public."impressions-2025-05" USING btree (displayed_at_date);


--
-- Name: index_impressions-2025-05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-05_on_displayed_at_hour" ON public."impressions-2025-05" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2025-05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-05_on_payable" ON public."impressions-2025-05" USING btree (payable);


--
-- Name: index_impressions-2025-05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-05_on_property_id" ON public."impressions-2025-05" USING btree (property_id);


--
-- Name: index_impressions-2025-06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-06_on_campaign_id" ON public."impressions-2025-06" USING btree (campaign_id);


--
-- Name: index_impressions-2025-06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-06_on_displayed_at_date" ON public."impressions-2025-06" USING btree (displayed_at_date);


--
-- Name: index_impressions-2025-06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-06_on_displayed_at_hour" ON public."impressions-2025-06" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2025-06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-06_on_payable" ON public."impressions-2025-06" USING btree (payable);


--
-- Name: index_impressions-2025-06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-06_on_property_id" ON public."impressions-2025-06" USING btree (property_id);


--
-- Name: index_impressions-2025-07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-07_on_campaign_id" ON public."impressions-2025-07" USING btree (campaign_id);


--
-- Name: index_impressions-2025-07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-07_on_displayed_at_date" ON public."impressions-2025-07" USING btree (displayed_at_date);


--
-- Name: index_impressions-2025-07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-07_on_displayed_at_hour" ON public."impressions-2025-07" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2025-07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-07_on_payable" ON public."impressions-2025-07" USING btree (payable);


--
-- Name: index_impressions-2025-07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-07_on_property_id" ON public."impressions-2025-07" USING btree (property_id);


--
-- Name: index_impressions-2025-08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-08_on_campaign_id" ON public."impressions-2025-08" USING btree (campaign_id);


--
-- Name: index_impressions-2025-08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-08_on_displayed_at_date" ON public."impressions-2025-08" USING btree (displayed_at_date);


--
-- Name: index_impressions-2025-08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-08_on_displayed_at_hour" ON public."impressions-2025-08" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2025-08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-08_on_payable" ON public."impressions-2025-08" USING btree (payable);


--
-- Name: index_impressions-2025-08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-08_on_property_id" ON public."impressions-2025-08" USING btree (property_id);


--
-- Name: index_impressions-2025-09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-09_on_campaign_id" ON public."impressions-2025-09" USING btree (campaign_id);


--
-- Name: index_impressions-2025-09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-09_on_displayed_at_date" ON public."impressions-2025-09" USING btree (displayed_at_date);


--
-- Name: index_impressions-2025-09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-09_on_displayed_at_hour" ON public."impressions-2025-09" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2025-09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-09_on_payable" ON public."impressions-2025-09" USING btree (payable);


--
-- Name: index_impressions-2025-09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-09_on_property_id" ON public."impressions-2025-09" USING btree (property_id);


--
-- Name: index_impressions-2025-10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-10_on_campaign_id" ON public."impressions-2025-10" USING btree (campaign_id);


--
-- Name: index_impressions-2025-10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-10_on_displayed_at_date" ON public."impressions-2025-10" USING btree (displayed_at_date);


--
-- Name: index_impressions-2025-10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-10_on_displayed_at_hour" ON public."impressions-2025-10" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2025-10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-10_on_payable" ON public."impressions-2025-10" USING btree (payable);


--
-- Name: index_impressions-2025-10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-10_on_property_id" ON public."impressions-2025-10" USING btree (property_id);


--
-- Name: index_impressions-2025-11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-11_on_campaign_id" ON public."impressions-2025-11" USING btree (campaign_id);


--
-- Name: index_impressions-2025-11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-11_on_displayed_at_date" ON public."impressions-2025-11" USING btree (displayed_at_date);


--
-- Name: index_impressions-2025-11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-11_on_displayed_at_hour" ON public."impressions-2025-11" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2025-11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-11_on_payable" ON public."impressions-2025-11" USING btree (payable);


--
-- Name: index_impressions-2025-11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-11_on_property_id" ON public."impressions-2025-11" USING btree (property_id);


--
-- Name: index_impressions-2025-12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-12_on_campaign_id" ON public."impressions-2025-12" USING btree (campaign_id);


--
-- Name: index_impressions-2025-12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-12_on_displayed_at_date" ON public."impressions-2025-12" USING btree (displayed_at_date);


--
-- Name: index_impressions-2025-12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-12_on_displayed_at_hour" ON public."impressions-2025-12" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2025-12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-12_on_payable" ON public."impressions-2025-12" USING btree (payable);


--
-- Name: index_impressions-2025-12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2025-12_on_property_id" ON public."impressions-2025-12" USING btree (property_id);


--
-- Name: index_impressions-2026-01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-01_on_campaign_id" ON public."impressions-2026-01" USING btree (campaign_id);


--
-- Name: index_impressions-2026-01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-01_on_displayed_at_date" ON public."impressions-2026-01" USING btree (displayed_at_date);


--
-- Name: index_impressions-2026-01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-01_on_displayed_at_hour" ON public."impressions-2026-01" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2026-01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-01_on_payable" ON public."impressions-2026-01" USING btree (payable);


--
-- Name: index_impressions-2026-01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-01_on_property_id" ON public."impressions-2026-01" USING btree (property_id);


--
-- Name: index_impressions-2026-02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-02_on_campaign_id" ON public."impressions-2026-02" USING btree (campaign_id);


--
-- Name: index_impressions-2026-02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-02_on_displayed_at_date" ON public."impressions-2026-02" USING btree (displayed_at_date);


--
-- Name: index_impressions-2026-02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-02_on_displayed_at_hour" ON public."impressions-2026-02" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2026-02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-02_on_payable" ON public."impressions-2026-02" USING btree (payable);


--
-- Name: index_impressions-2026-02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-02_on_property_id" ON public."impressions-2026-02" USING btree (property_id);


--
-- Name: index_impressions-2026-03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-03_on_campaign_id" ON public."impressions-2026-03" USING btree (campaign_id);


--
-- Name: index_impressions-2026-03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-03_on_displayed_at_date" ON public."impressions-2026-03" USING btree (displayed_at_date);


--
-- Name: index_impressions-2026-03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-03_on_displayed_at_hour" ON public."impressions-2026-03" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2026-03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-03_on_payable" ON public."impressions-2026-03" USING btree (payable);


--
-- Name: index_impressions-2026-03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-03_on_property_id" ON public."impressions-2026-03" USING btree (property_id);


--
-- Name: index_impressions-2026-04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-04_on_campaign_id" ON public."impressions-2026-04" USING btree (campaign_id);


--
-- Name: index_impressions-2026-04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-04_on_displayed_at_date" ON public."impressions-2026-04" USING btree (displayed_at_date);


--
-- Name: index_impressions-2026-04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-04_on_displayed_at_hour" ON public."impressions-2026-04" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2026-04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-04_on_payable" ON public."impressions-2026-04" USING btree (payable);


--
-- Name: index_impressions-2026-04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-04_on_property_id" ON public."impressions-2026-04" USING btree (property_id);


--
-- Name: index_impressions-2026-05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-05_on_campaign_id" ON public."impressions-2026-05" USING btree (campaign_id);


--
-- Name: index_impressions-2026-05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-05_on_displayed_at_date" ON public."impressions-2026-05" USING btree (displayed_at_date);


--
-- Name: index_impressions-2026-05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-05_on_displayed_at_hour" ON public."impressions-2026-05" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2026-05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-05_on_payable" ON public."impressions-2026-05" USING btree (payable);


--
-- Name: index_impressions-2026-05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-05_on_property_id" ON public."impressions-2026-05" USING btree (property_id);


--
-- Name: index_impressions-2026-06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-06_on_campaign_id" ON public."impressions-2026-06" USING btree (campaign_id);


--
-- Name: index_impressions-2026-06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-06_on_displayed_at_date" ON public."impressions-2026-06" USING btree (displayed_at_date);


--
-- Name: index_impressions-2026-06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-06_on_displayed_at_hour" ON public."impressions-2026-06" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2026-06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-06_on_payable" ON public."impressions-2026-06" USING btree (payable);


--
-- Name: index_impressions-2026-06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-06_on_property_id" ON public."impressions-2026-06" USING btree (property_id);


--
-- Name: index_impressions-2026-07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-07_on_campaign_id" ON public."impressions-2026-07" USING btree (campaign_id);


--
-- Name: index_impressions-2026-07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-07_on_displayed_at_date" ON public."impressions-2026-07" USING btree (displayed_at_date);


--
-- Name: index_impressions-2026-07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-07_on_displayed_at_hour" ON public."impressions-2026-07" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2026-07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-07_on_payable" ON public."impressions-2026-07" USING btree (payable);


--
-- Name: index_impressions-2026-07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-07_on_property_id" ON public."impressions-2026-07" USING btree (property_id);


--
-- Name: index_impressions-2026-08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-08_on_campaign_id" ON public."impressions-2026-08" USING btree (campaign_id);


--
-- Name: index_impressions-2026-08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-08_on_displayed_at_date" ON public."impressions-2026-08" USING btree (displayed_at_date);


--
-- Name: index_impressions-2026-08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-08_on_displayed_at_hour" ON public."impressions-2026-08" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2026-08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-08_on_payable" ON public."impressions-2026-08" USING btree (payable);


--
-- Name: index_impressions-2026-08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-08_on_property_id" ON public."impressions-2026-08" USING btree (property_id);


--
-- Name: index_impressions-2026-09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-09_on_campaign_id" ON public."impressions-2026-09" USING btree (campaign_id);


--
-- Name: index_impressions-2026-09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-09_on_displayed_at_date" ON public."impressions-2026-09" USING btree (displayed_at_date);


--
-- Name: index_impressions-2026-09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-09_on_displayed_at_hour" ON public."impressions-2026-09" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2026-09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-09_on_payable" ON public."impressions-2026-09" USING btree (payable);


--
-- Name: index_impressions-2026-09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-09_on_property_id" ON public."impressions-2026-09" USING btree (property_id);


--
-- Name: index_impressions-2026-10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-10_on_campaign_id" ON public."impressions-2026-10" USING btree (campaign_id);


--
-- Name: index_impressions-2026-10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-10_on_displayed_at_date" ON public."impressions-2026-10" USING btree (displayed_at_date);


--
-- Name: index_impressions-2026-10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-10_on_displayed_at_hour" ON public."impressions-2026-10" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2026-10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-10_on_payable" ON public."impressions-2026-10" USING btree (payable);


--
-- Name: index_impressions-2026-10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-10_on_property_id" ON public."impressions-2026-10" USING btree (property_id);


--
-- Name: index_impressions-2026-11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-11_on_campaign_id" ON public."impressions-2026-11" USING btree (campaign_id);


--
-- Name: index_impressions-2026-11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-11_on_displayed_at_date" ON public."impressions-2026-11" USING btree (displayed_at_date);


--
-- Name: index_impressions-2026-11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-11_on_displayed_at_hour" ON public."impressions-2026-11" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2026-11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-11_on_payable" ON public."impressions-2026-11" USING btree (payable);


--
-- Name: index_impressions-2026-11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-11_on_property_id" ON public."impressions-2026-11" USING btree (property_id);


--
-- Name: index_impressions-2026-12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-12_on_campaign_id" ON public."impressions-2026-12" USING btree (campaign_id);


--
-- Name: index_impressions-2026-12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-12_on_displayed_at_date" ON public."impressions-2026-12" USING btree (displayed_at_date);


--
-- Name: index_impressions-2026-12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-12_on_displayed_at_hour" ON public."impressions-2026-12" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2026-12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-12_on_payable" ON public."impressions-2026-12" USING btree (payable);


--
-- Name: index_impressions-2026-12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2026-12_on_property_id" ON public."impressions-2026-12" USING btree (property_id);


--
-- Name: index_impressions-2027-01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-01_on_campaign_id" ON public."impressions-2027-01" USING btree (campaign_id);


--
-- Name: index_impressions-2027-01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-01_on_displayed_at_date" ON public."impressions-2027-01" USING btree (displayed_at_date);


--
-- Name: index_impressions-2027-01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-01_on_displayed_at_hour" ON public."impressions-2027-01" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2027-01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-01_on_payable" ON public."impressions-2027-01" USING btree (payable);


--
-- Name: index_impressions-2027-01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-01_on_property_id" ON public."impressions-2027-01" USING btree (property_id);


--
-- Name: index_impressions-2027-02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-02_on_campaign_id" ON public."impressions-2027-02" USING btree (campaign_id);


--
-- Name: index_impressions-2027-02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-02_on_displayed_at_date" ON public."impressions-2027-02" USING btree (displayed_at_date);


--
-- Name: index_impressions-2027-02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-02_on_displayed_at_hour" ON public."impressions-2027-02" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2027-02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-02_on_payable" ON public."impressions-2027-02" USING btree (payable);


--
-- Name: index_impressions-2027-02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-02_on_property_id" ON public."impressions-2027-02" USING btree (property_id);


--
-- Name: index_impressions-2027-03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-03_on_campaign_id" ON public."impressions-2027-03" USING btree (campaign_id);


--
-- Name: index_impressions-2027-03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-03_on_displayed_at_date" ON public."impressions-2027-03" USING btree (displayed_at_date);


--
-- Name: index_impressions-2027-03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-03_on_displayed_at_hour" ON public."impressions-2027-03" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2027-03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-03_on_payable" ON public."impressions-2027-03" USING btree (payable);


--
-- Name: index_impressions-2027-03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-03_on_property_id" ON public."impressions-2027-03" USING btree (property_id);


--
-- Name: index_impressions-2027-04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-04_on_campaign_id" ON public."impressions-2027-04" USING btree (campaign_id);


--
-- Name: index_impressions-2027-04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-04_on_displayed_at_date" ON public."impressions-2027-04" USING btree (displayed_at_date);


--
-- Name: index_impressions-2027-04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-04_on_displayed_at_hour" ON public."impressions-2027-04" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2027-04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-04_on_payable" ON public."impressions-2027-04" USING btree (payable);


--
-- Name: index_impressions-2027-04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-04_on_property_id" ON public."impressions-2027-04" USING btree (property_id);


--
-- Name: index_impressions-2027-05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-05_on_campaign_id" ON public."impressions-2027-05" USING btree (campaign_id);


--
-- Name: index_impressions-2027-05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-05_on_displayed_at_date" ON public."impressions-2027-05" USING btree (displayed_at_date);


--
-- Name: index_impressions-2027-05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-05_on_displayed_at_hour" ON public."impressions-2027-05" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2027-05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-05_on_payable" ON public."impressions-2027-05" USING btree (payable);


--
-- Name: index_impressions-2027-05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-05_on_property_id" ON public."impressions-2027-05" USING btree (property_id);


--
-- Name: index_impressions-2027-06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-06_on_campaign_id" ON public."impressions-2027-06" USING btree (campaign_id);


--
-- Name: index_impressions-2027-06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-06_on_displayed_at_date" ON public."impressions-2027-06" USING btree (displayed_at_date);


--
-- Name: index_impressions-2027-06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-06_on_displayed_at_hour" ON public."impressions-2027-06" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2027-06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-06_on_payable" ON public."impressions-2027-06" USING btree (payable);


--
-- Name: index_impressions-2027-06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-06_on_property_id" ON public."impressions-2027-06" USING btree (property_id);


--
-- Name: index_impressions-2027-07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-07_on_campaign_id" ON public."impressions-2027-07" USING btree (campaign_id);


--
-- Name: index_impressions-2027-07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-07_on_displayed_at_date" ON public."impressions-2027-07" USING btree (displayed_at_date);


--
-- Name: index_impressions-2027-07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-07_on_displayed_at_hour" ON public."impressions-2027-07" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2027-07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-07_on_payable" ON public."impressions-2027-07" USING btree (payable);


--
-- Name: index_impressions-2027-07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-07_on_property_id" ON public."impressions-2027-07" USING btree (property_id);


--
-- Name: index_impressions-2027-08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-08_on_campaign_id" ON public."impressions-2027-08" USING btree (campaign_id);


--
-- Name: index_impressions-2027-08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-08_on_displayed_at_date" ON public."impressions-2027-08" USING btree (displayed_at_date);


--
-- Name: index_impressions-2027-08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-08_on_displayed_at_hour" ON public."impressions-2027-08" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2027-08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-08_on_payable" ON public."impressions-2027-08" USING btree (payable);


--
-- Name: index_impressions-2027-08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-08_on_property_id" ON public."impressions-2027-08" USING btree (property_id);


--
-- Name: index_impressions-2027-09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-09_on_campaign_id" ON public."impressions-2027-09" USING btree (campaign_id);


--
-- Name: index_impressions-2027-09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-09_on_displayed_at_date" ON public."impressions-2027-09" USING btree (displayed_at_date);


--
-- Name: index_impressions-2027-09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-09_on_displayed_at_hour" ON public."impressions-2027-09" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2027-09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-09_on_payable" ON public."impressions-2027-09" USING btree (payable);


--
-- Name: index_impressions-2027-09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-09_on_property_id" ON public."impressions-2027-09" USING btree (property_id);


--
-- Name: index_impressions-2027-10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-10_on_campaign_id" ON public."impressions-2027-10" USING btree (campaign_id);


--
-- Name: index_impressions-2027-10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-10_on_displayed_at_date" ON public."impressions-2027-10" USING btree (displayed_at_date);


--
-- Name: index_impressions-2027-10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-10_on_displayed_at_hour" ON public."impressions-2027-10" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2027-10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-10_on_payable" ON public."impressions-2027-10" USING btree (payable);


--
-- Name: index_impressions-2027-10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-10_on_property_id" ON public."impressions-2027-10" USING btree (property_id);


--
-- Name: index_impressions-2027-11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-11_on_campaign_id" ON public."impressions-2027-11" USING btree (campaign_id);


--
-- Name: index_impressions-2027-11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-11_on_displayed_at_date" ON public."impressions-2027-11" USING btree (displayed_at_date);


--
-- Name: index_impressions-2027-11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-11_on_displayed_at_hour" ON public."impressions-2027-11" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2027-11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-11_on_payable" ON public."impressions-2027-11" USING btree (payable);


--
-- Name: index_impressions-2027-11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-11_on_property_id" ON public."impressions-2027-11" USING btree (property_id);


--
-- Name: index_impressions-2027-12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-12_on_campaign_id" ON public."impressions-2027-12" USING btree (campaign_id);


--
-- Name: index_impressions-2027-12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-12_on_displayed_at_date" ON public."impressions-2027-12" USING btree (displayed_at_date);


--
-- Name: index_impressions-2027-12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-12_on_displayed_at_hour" ON public."impressions-2027-12" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2027-12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-12_on_payable" ON public."impressions-2027-12" USING btree (payable);


--
-- Name: index_impressions-2027-12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2027-12_on_property_id" ON public."impressions-2027-12" USING btree (property_id);


--
-- Name: index_impressions-2028-01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-01_on_campaign_id" ON public."impressions-2028-01" USING btree (campaign_id);


--
-- Name: index_impressions-2028-01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-01_on_displayed_at_date" ON public."impressions-2028-01" USING btree (displayed_at_date);


--
-- Name: index_impressions-2028-01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-01_on_displayed_at_hour" ON public."impressions-2028-01" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2028-01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-01_on_payable" ON public."impressions-2028-01" USING btree (payable);


--
-- Name: index_impressions-2028-01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-01_on_property_id" ON public."impressions-2028-01" USING btree (property_id);


--
-- Name: index_impressions-2028-02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-02_on_campaign_id" ON public."impressions-2028-02" USING btree (campaign_id);


--
-- Name: index_impressions-2028-02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-02_on_displayed_at_date" ON public."impressions-2028-02" USING btree (displayed_at_date);


--
-- Name: index_impressions-2028-02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-02_on_displayed_at_hour" ON public."impressions-2028-02" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2028-02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-02_on_payable" ON public."impressions-2028-02" USING btree (payable);


--
-- Name: index_impressions-2028-02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-02_on_property_id" ON public."impressions-2028-02" USING btree (property_id);


--
-- Name: index_impressions-2028-03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-03_on_campaign_id" ON public."impressions-2028-03" USING btree (campaign_id);


--
-- Name: index_impressions-2028-03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-03_on_displayed_at_date" ON public."impressions-2028-03" USING btree (displayed_at_date);


--
-- Name: index_impressions-2028-03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-03_on_displayed_at_hour" ON public."impressions-2028-03" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2028-03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-03_on_payable" ON public."impressions-2028-03" USING btree (payable);


--
-- Name: index_impressions-2028-03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-03_on_property_id" ON public."impressions-2028-03" USING btree (property_id);


--
-- Name: index_impressions-2028-04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-04_on_campaign_id" ON public."impressions-2028-04" USING btree (campaign_id);


--
-- Name: index_impressions-2028-04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-04_on_displayed_at_date" ON public."impressions-2028-04" USING btree (displayed_at_date);


--
-- Name: index_impressions-2028-04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-04_on_displayed_at_hour" ON public."impressions-2028-04" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2028-04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-04_on_payable" ON public."impressions-2028-04" USING btree (payable);


--
-- Name: index_impressions-2028-04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-04_on_property_id" ON public."impressions-2028-04" USING btree (property_id);


--
-- Name: index_impressions-2028-05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-05_on_campaign_id" ON public."impressions-2028-05" USING btree (campaign_id);


--
-- Name: index_impressions-2028-05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-05_on_displayed_at_date" ON public."impressions-2028-05" USING btree (displayed_at_date);


--
-- Name: index_impressions-2028-05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-05_on_displayed_at_hour" ON public."impressions-2028-05" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2028-05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-05_on_payable" ON public."impressions-2028-05" USING btree (payable);


--
-- Name: index_impressions-2028-05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-05_on_property_id" ON public."impressions-2028-05" USING btree (property_id);


--
-- Name: index_impressions-2028-06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-06_on_campaign_id" ON public."impressions-2028-06" USING btree (campaign_id);


--
-- Name: index_impressions-2028-06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-06_on_displayed_at_date" ON public."impressions-2028-06" USING btree (displayed_at_date);


--
-- Name: index_impressions-2028-06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-06_on_displayed_at_hour" ON public."impressions-2028-06" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2028-06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-06_on_payable" ON public."impressions-2028-06" USING btree (payable);


--
-- Name: index_impressions-2028-06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-06_on_property_id" ON public."impressions-2028-06" USING btree (property_id);


--
-- Name: index_impressions-2028-07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-07_on_campaign_id" ON public."impressions-2028-07" USING btree (campaign_id);


--
-- Name: index_impressions-2028-07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-07_on_displayed_at_date" ON public."impressions-2028-07" USING btree (displayed_at_date);


--
-- Name: index_impressions-2028-07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-07_on_displayed_at_hour" ON public."impressions-2028-07" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2028-07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-07_on_payable" ON public."impressions-2028-07" USING btree (payable);


--
-- Name: index_impressions-2028-07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-07_on_property_id" ON public."impressions-2028-07" USING btree (property_id);


--
-- Name: index_impressions-2028-08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-08_on_campaign_id" ON public."impressions-2028-08" USING btree (campaign_id);


--
-- Name: index_impressions-2028-08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-08_on_displayed_at_date" ON public."impressions-2028-08" USING btree (displayed_at_date);


--
-- Name: index_impressions-2028-08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-08_on_displayed_at_hour" ON public."impressions-2028-08" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2028-08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-08_on_payable" ON public."impressions-2028-08" USING btree (payable);


--
-- Name: index_impressions-2028-08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-08_on_property_id" ON public."impressions-2028-08" USING btree (property_id);


--
-- Name: index_impressions-2028-09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-09_on_campaign_id" ON public."impressions-2028-09" USING btree (campaign_id);


--
-- Name: index_impressions-2028-09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-09_on_displayed_at_date" ON public."impressions-2028-09" USING btree (displayed_at_date);


--
-- Name: index_impressions-2028-09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-09_on_displayed_at_hour" ON public."impressions-2028-09" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2028-09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-09_on_payable" ON public."impressions-2028-09" USING btree (payable);


--
-- Name: index_impressions-2028-09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-09_on_property_id" ON public."impressions-2028-09" USING btree (property_id);


--
-- Name: index_impressions-2028-10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-10_on_campaign_id" ON public."impressions-2028-10" USING btree (campaign_id);


--
-- Name: index_impressions-2028-10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-10_on_displayed_at_date" ON public."impressions-2028-10" USING btree (displayed_at_date);


--
-- Name: index_impressions-2028-10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-10_on_displayed_at_hour" ON public."impressions-2028-10" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2028-10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-10_on_payable" ON public."impressions-2028-10" USING btree (payable);


--
-- Name: index_impressions-2028-10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-10_on_property_id" ON public."impressions-2028-10" USING btree (property_id);


--
-- Name: index_impressions-2028-11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-11_on_campaign_id" ON public."impressions-2028-11" USING btree (campaign_id);


--
-- Name: index_impressions-2028-11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-11_on_displayed_at_date" ON public."impressions-2028-11" USING btree (displayed_at_date);


--
-- Name: index_impressions-2028-11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-11_on_displayed_at_hour" ON public."impressions-2028-11" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2028-11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-11_on_payable" ON public."impressions-2028-11" USING btree (payable);


--
-- Name: index_impressions-2028-11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-11_on_property_id" ON public."impressions-2028-11" USING btree (property_id);


--
-- Name: index_impressions-2028-12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-12_on_campaign_id" ON public."impressions-2028-12" USING btree (campaign_id);


--
-- Name: index_impressions-2028-12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-12_on_displayed_at_date" ON public."impressions-2028-12" USING btree (displayed_at_date);


--
-- Name: index_impressions-2028-12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-12_on_displayed_at_hour" ON public."impressions-2028-12" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2028-12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-12_on_payable" ON public."impressions-2028-12" USING btree (payable);


--
-- Name: index_impressions-2028-12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2028-12_on_property_id" ON public."impressions-2028-12" USING btree (property_id);


--
-- Name: index_impressions-2029-01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-01_on_campaign_id" ON public."impressions-2029-01" USING btree (campaign_id);


--
-- Name: index_impressions-2029-01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-01_on_displayed_at_date" ON public."impressions-2029-01" USING btree (displayed_at_date);


--
-- Name: index_impressions-2029-01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-01_on_displayed_at_hour" ON public."impressions-2029-01" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2029-01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-01_on_payable" ON public."impressions-2029-01" USING btree (payable);


--
-- Name: index_impressions-2029-01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-01_on_property_id" ON public."impressions-2029-01" USING btree (property_id);


--
-- Name: index_impressions-2029-02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-02_on_campaign_id" ON public."impressions-2029-02" USING btree (campaign_id);


--
-- Name: index_impressions-2029-02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-02_on_displayed_at_date" ON public."impressions-2029-02" USING btree (displayed_at_date);


--
-- Name: index_impressions-2029-02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-02_on_displayed_at_hour" ON public."impressions-2029-02" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2029-02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-02_on_payable" ON public."impressions-2029-02" USING btree (payable);


--
-- Name: index_impressions-2029-02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-02_on_property_id" ON public."impressions-2029-02" USING btree (property_id);


--
-- Name: index_impressions-2029-03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-03_on_campaign_id" ON public."impressions-2029-03" USING btree (campaign_id);


--
-- Name: index_impressions-2029-03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-03_on_displayed_at_date" ON public."impressions-2029-03" USING btree (displayed_at_date);


--
-- Name: index_impressions-2029-03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-03_on_displayed_at_hour" ON public."impressions-2029-03" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2029-03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-03_on_payable" ON public."impressions-2029-03" USING btree (payable);


--
-- Name: index_impressions-2029-03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-03_on_property_id" ON public."impressions-2029-03" USING btree (property_id);


--
-- Name: index_impressions-2029-04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-04_on_campaign_id" ON public."impressions-2029-04" USING btree (campaign_id);


--
-- Name: index_impressions-2029-04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-04_on_displayed_at_date" ON public."impressions-2029-04" USING btree (displayed_at_date);


--
-- Name: index_impressions-2029-04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-04_on_displayed_at_hour" ON public."impressions-2029-04" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2029-04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-04_on_payable" ON public."impressions-2029-04" USING btree (payable);


--
-- Name: index_impressions-2029-04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-04_on_property_id" ON public."impressions-2029-04" USING btree (property_id);


--
-- Name: index_impressions-2029-05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-05_on_campaign_id" ON public."impressions-2029-05" USING btree (campaign_id);


--
-- Name: index_impressions-2029-05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-05_on_displayed_at_date" ON public."impressions-2029-05" USING btree (displayed_at_date);


--
-- Name: index_impressions-2029-05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-05_on_displayed_at_hour" ON public."impressions-2029-05" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2029-05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-05_on_payable" ON public."impressions-2029-05" USING btree (payable);


--
-- Name: index_impressions-2029-05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-05_on_property_id" ON public."impressions-2029-05" USING btree (property_id);


--
-- Name: index_impressions-2029-06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-06_on_campaign_id" ON public."impressions-2029-06" USING btree (campaign_id);


--
-- Name: index_impressions-2029-06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-06_on_displayed_at_date" ON public."impressions-2029-06" USING btree (displayed_at_date);


--
-- Name: index_impressions-2029-06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-06_on_displayed_at_hour" ON public."impressions-2029-06" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2029-06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-06_on_payable" ON public."impressions-2029-06" USING btree (payable);


--
-- Name: index_impressions-2029-06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-06_on_property_id" ON public."impressions-2029-06" USING btree (property_id);


--
-- Name: index_impressions-2029-07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-07_on_campaign_id" ON public."impressions-2029-07" USING btree (campaign_id);


--
-- Name: index_impressions-2029-07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-07_on_displayed_at_date" ON public."impressions-2029-07" USING btree (displayed_at_date);


--
-- Name: index_impressions-2029-07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-07_on_displayed_at_hour" ON public."impressions-2029-07" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2029-07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-07_on_payable" ON public."impressions-2029-07" USING btree (payable);


--
-- Name: index_impressions-2029-07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-07_on_property_id" ON public."impressions-2029-07" USING btree (property_id);


--
-- Name: index_impressions-2029-08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-08_on_campaign_id" ON public."impressions-2029-08" USING btree (campaign_id);


--
-- Name: index_impressions-2029-08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-08_on_displayed_at_date" ON public."impressions-2029-08" USING btree (displayed_at_date);


--
-- Name: index_impressions-2029-08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-08_on_displayed_at_hour" ON public."impressions-2029-08" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2029-08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-08_on_payable" ON public."impressions-2029-08" USING btree (payable);


--
-- Name: index_impressions-2029-08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-08_on_property_id" ON public."impressions-2029-08" USING btree (property_id);


--
-- Name: index_impressions-2029-09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-09_on_campaign_id" ON public."impressions-2029-09" USING btree (campaign_id);


--
-- Name: index_impressions-2029-09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-09_on_displayed_at_date" ON public."impressions-2029-09" USING btree (displayed_at_date);


--
-- Name: index_impressions-2029-09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-09_on_displayed_at_hour" ON public."impressions-2029-09" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2029-09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-09_on_payable" ON public."impressions-2029-09" USING btree (payable);


--
-- Name: index_impressions-2029-09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-09_on_property_id" ON public."impressions-2029-09" USING btree (property_id);


--
-- Name: index_impressions-2029-10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-10_on_campaign_id" ON public."impressions-2029-10" USING btree (campaign_id);


--
-- Name: index_impressions-2029-10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-10_on_displayed_at_date" ON public."impressions-2029-10" USING btree (displayed_at_date);


--
-- Name: index_impressions-2029-10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-10_on_displayed_at_hour" ON public."impressions-2029-10" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2029-10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-10_on_payable" ON public."impressions-2029-10" USING btree (payable);


--
-- Name: index_impressions-2029-10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-10_on_property_id" ON public."impressions-2029-10" USING btree (property_id);


--
-- Name: index_impressions-2029-11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-11_on_campaign_id" ON public."impressions-2029-11" USING btree (campaign_id);


--
-- Name: index_impressions-2029-11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-11_on_displayed_at_date" ON public."impressions-2029-11" USING btree (displayed_at_date);


--
-- Name: index_impressions-2029-11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-11_on_displayed_at_hour" ON public."impressions-2029-11" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2029-11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-11_on_payable" ON public."impressions-2029-11" USING btree (payable);


--
-- Name: index_impressions-2029-11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-11_on_property_id" ON public."impressions-2029-11" USING btree (property_id);


--
-- Name: index_impressions-2029-12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-12_on_campaign_id" ON public."impressions-2029-12" USING btree (campaign_id);


--
-- Name: index_impressions-2029-12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-12_on_displayed_at_date" ON public."impressions-2029-12" USING btree (displayed_at_date);


--
-- Name: index_impressions-2029-12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-12_on_displayed_at_hour" ON public."impressions-2029-12" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2029-12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-12_on_payable" ON public."impressions-2029-12" USING btree (payable);


--
-- Name: index_impressions-2029-12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2029-12_on_property_id" ON public."impressions-2029-12" USING btree (property_id);


--
-- Name: index_impressions-2030-01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-01_on_campaign_id" ON public."impressions-2030-01" USING btree (campaign_id);


--
-- Name: index_impressions-2030-01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-01_on_displayed_at_date" ON public."impressions-2030-01" USING btree (displayed_at_date);


--
-- Name: index_impressions-2030-01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-01_on_displayed_at_hour" ON public."impressions-2030-01" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2030-01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-01_on_payable" ON public."impressions-2030-01" USING btree (payable);


--
-- Name: index_impressions-2030-01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-01_on_property_id" ON public."impressions-2030-01" USING btree (property_id);


--
-- Name: index_impressions-2030-02_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-02_on_campaign_id" ON public."impressions-2030-02" USING btree (campaign_id);


--
-- Name: index_impressions-2030-02_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-02_on_displayed_at_date" ON public."impressions-2030-02" USING btree (displayed_at_date);


--
-- Name: index_impressions-2030-02_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-02_on_displayed_at_hour" ON public."impressions-2030-02" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2030-02_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-02_on_payable" ON public."impressions-2030-02" USING btree (payable);


--
-- Name: index_impressions-2030-02_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-02_on_property_id" ON public."impressions-2030-02" USING btree (property_id);


--
-- Name: index_impressions-2030-03_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-03_on_campaign_id" ON public."impressions-2030-03" USING btree (campaign_id);


--
-- Name: index_impressions-2030-03_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-03_on_displayed_at_date" ON public."impressions-2030-03" USING btree (displayed_at_date);


--
-- Name: index_impressions-2030-03_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-03_on_displayed_at_hour" ON public."impressions-2030-03" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2030-03_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-03_on_payable" ON public."impressions-2030-03" USING btree (payable);


--
-- Name: index_impressions-2030-03_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-03_on_property_id" ON public."impressions-2030-03" USING btree (property_id);


--
-- Name: index_impressions-2030-04_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-04_on_campaign_id" ON public."impressions-2030-04" USING btree (campaign_id);


--
-- Name: index_impressions-2030-04_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-04_on_displayed_at_date" ON public."impressions-2030-04" USING btree (displayed_at_date);


--
-- Name: index_impressions-2030-04_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-04_on_displayed_at_hour" ON public."impressions-2030-04" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2030-04_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-04_on_payable" ON public."impressions-2030-04" USING btree (payable);


--
-- Name: index_impressions-2030-04_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-04_on_property_id" ON public."impressions-2030-04" USING btree (property_id);


--
-- Name: index_impressions-2030-05_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-05_on_campaign_id" ON public."impressions-2030-05" USING btree (campaign_id);


--
-- Name: index_impressions-2030-05_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-05_on_displayed_at_date" ON public."impressions-2030-05" USING btree (displayed_at_date);


--
-- Name: index_impressions-2030-05_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-05_on_displayed_at_hour" ON public."impressions-2030-05" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2030-05_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-05_on_payable" ON public."impressions-2030-05" USING btree (payable);


--
-- Name: index_impressions-2030-05_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-05_on_property_id" ON public."impressions-2030-05" USING btree (property_id);


--
-- Name: index_impressions-2030-06_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-06_on_campaign_id" ON public."impressions-2030-06" USING btree (campaign_id);


--
-- Name: index_impressions-2030-06_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-06_on_displayed_at_date" ON public."impressions-2030-06" USING btree (displayed_at_date);


--
-- Name: index_impressions-2030-06_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-06_on_displayed_at_hour" ON public."impressions-2030-06" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2030-06_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-06_on_payable" ON public."impressions-2030-06" USING btree (payable);


--
-- Name: index_impressions-2030-06_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-06_on_property_id" ON public."impressions-2030-06" USING btree (property_id);


--
-- Name: index_impressions-2030-07_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-07_on_campaign_id" ON public."impressions-2030-07" USING btree (campaign_id);


--
-- Name: index_impressions-2030-07_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-07_on_displayed_at_date" ON public."impressions-2030-07" USING btree (displayed_at_date);


--
-- Name: index_impressions-2030-07_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-07_on_displayed_at_hour" ON public."impressions-2030-07" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2030-07_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-07_on_payable" ON public."impressions-2030-07" USING btree (payable);


--
-- Name: index_impressions-2030-07_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-07_on_property_id" ON public."impressions-2030-07" USING btree (property_id);


--
-- Name: index_impressions-2030-08_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-08_on_campaign_id" ON public."impressions-2030-08" USING btree (campaign_id);


--
-- Name: index_impressions-2030-08_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-08_on_displayed_at_date" ON public."impressions-2030-08" USING btree (displayed_at_date);


--
-- Name: index_impressions-2030-08_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-08_on_displayed_at_hour" ON public."impressions-2030-08" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2030-08_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-08_on_payable" ON public."impressions-2030-08" USING btree (payable);


--
-- Name: index_impressions-2030-08_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-08_on_property_id" ON public."impressions-2030-08" USING btree (property_id);


--
-- Name: index_impressions-2030-09_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-09_on_campaign_id" ON public."impressions-2030-09" USING btree (campaign_id);


--
-- Name: index_impressions-2030-09_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-09_on_displayed_at_date" ON public."impressions-2030-09" USING btree (displayed_at_date);


--
-- Name: index_impressions-2030-09_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-09_on_displayed_at_hour" ON public."impressions-2030-09" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2030-09_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-09_on_payable" ON public."impressions-2030-09" USING btree (payable);


--
-- Name: index_impressions-2030-09_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-09_on_property_id" ON public."impressions-2030-09" USING btree (property_id);


--
-- Name: index_impressions-2030-10_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-10_on_campaign_id" ON public."impressions-2030-10" USING btree (campaign_id);


--
-- Name: index_impressions-2030-10_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-10_on_displayed_at_date" ON public."impressions-2030-10" USING btree (displayed_at_date);


--
-- Name: index_impressions-2030-10_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-10_on_displayed_at_hour" ON public."impressions-2030-10" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2030-10_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-10_on_payable" ON public."impressions-2030-10" USING btree (payable);


--
-- Name: index_impressions-2030-10_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-10_on_property_id" ON public."impressions-2030-10" USING btree (property_id);


--
-- Name: index_impressions-2030-11_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-11_on_campaign_id" ON public."impressions-2030-11" USING btree (campaign_id);


--
-- Name: index_impressions-2030-11_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-11_on_displayed_at_date" ON public."impressions-2030-11" USING btree (displayed_at_date);


--
-- Name: index_impressions-2030-11_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-11_on_displayed_at_hour" ON public."impressions-2030-11" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2030-11_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-11_on_payable" ON public."impressions-2030-11" USING btree (payable);


--
-- Name: index_impressions-2030-11_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-11_on_property_id" ON public."impressions-2030-11" USING btree (property_id);


--
-- Name: index_impressions-2030-12_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-12_on_campaign_id" ON public."impressions-2030-12" USING btree (campaign_id);


--
-- Name: index_impressions-2030-12_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-12_on_displayed_at_date" ON public."impressions-2030-12" USING btree (displayed_at_date);


--
-- Name: index_impressions-2030-12_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-12_on_displayed_at_hour" ON public."impressions-2030-12" USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions-2030-12_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-12_on_payable" ON public."impressions-2030-12" USING btree (payable);


--
-- Name: index_impressions-2030-12_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "index_impressions-2030-12_on_property_id" ON public."impressions-2030-12" USING btree (property_id);


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


