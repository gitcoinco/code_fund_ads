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
-- Name: impressions_008f8c2; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_008f8c2 PARTITION OF public.impressions
FOR VALUES FROM ('2019-04-01') TO ('2019-05-01');


--
-- Name: impressions_00afa31; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_00afa31 PARTITION OF public.impressions
FOR VALUES FROM ('2023-01-01') TO ('2023-02-01');


--
-- Name: impressions_0281a27; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_0281a27 PARTITION OF public.impressions
FOR VALUES FROM ('2022-12-01') TO ('2023-01-01');


--
-- Name: impressions_081c4ce; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_081c4ce PARTITION OF public.impressions
FOR VALUES FROM ('2023-12-01') TO ('2024-01-01');


--
-- Name: impressions_0947ece; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_0947ece PARTITION OF public.impressions
FOR VALUES FROM ('2028-09-01') TO ('2028-10-01');


--
-- Name: impressions_0a989dc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_0a989dc PARTITION OF public.impressions
FOR VALUES FROM ('2023-09-01') TO ('2023-10-01');


--
-- Name: impressions_0ae566a; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_0ae566a PARTITION OF public.impressions
FOR VALUES FROM ('2025-10-01') TO ('2025-11-01');


--
-- Name: impressions_0bf3fae; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_0bf3fae PARTITION OF public.impressions
FOR VALUES FROM ('2019-01-01') TO ('2019-02-01');


--
-- Name: impressions_0fbc017; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_0fbc017 PARTITION OF public.impressions
FOR VALUES FROM ('2027-07-01') TO ('2027-08-01');


--
-- Name: impressions_132f3f5; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_132f3f5 PARTITION OF public.impressions
FOR VALUES FROM ('2028-08-01') TO ('2028-09-01');


--
-- Name: impressions_155e200; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_155e200 PARTITION OF public.impressions
FOR VALUES FROM ('2024-09-01') TO ('2024-10-01');


--
-- Name: impressions_1c56374; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_1c56374 PARTITION OF public.impressions
FOR VALUES FROM ('2020-03-01') TO ('2020-04-01');


--
-- Name: impressions_1e4146f; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_1e4146f PARTITION OF public.impressions
FOR VALUES FROM ('2021-05-01') TO ('2021-06-01');


--
-- Name: impressions_26d04a3; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_26d04a3 PARTITION OF public.impressions
FOR VALUES FROM ('2025-05-01') TO ('2025-06-01');


--
-- Name: impressions_27d985f; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_27d985f PARTITION OF public.impressions
FOR VALUES FROM ('2022-06-01') TO ('2022-07-01');


--
-- Name: impressions_299ed5e; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_299ed5e PARTITION OF public.impressions
FOR VALUES FROM ('2022-09-01') TO ('2022-10-01');


--
-- Name: impressions_2da957d; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2da957d PARTITION OF public.impressions
FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');


--
-- Name: impressions_2ddf121; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2ddf121 PARTITION OF public.impressions
FOR VALUES FROM ('2021-01-01') TO ('2021-02-01');


--
-- Name: impressions_2ede6f8; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2ede6f8 PARTITION OF public.impressions
FOR VALUES FROM ('2020-09-01') TO ('2020-10-01');


--
-- Name: impressions_318d9ee; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_318d9ee PARTITION OF public.impressions
FOR VALUES FROM ('2025-12-01') TO ('2026-01-01');


--
-- Name: impressions_33e0986; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_33e0986 PARTITION OF public.impressions
FOR VALUES FROM ('2027-09-01') TO ('2027-10-01');


--
-- Name: impressions_36cd868; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_36cd868 PARTITION OF public.impressions
FOR VALUES FROM ('2018-12-01') TO ('2019-01-01');


--
-- Name: impressions_3b83f44; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_3b83f44 PARTITION OF public.impressions
FOR VALUES FROM ('2019-07-01') TO ('2019-08-01');


--
-- Name: impressions_3bb672d; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_3bb672d PARTITION OF public.impressions
FOR VALUES FROM ('2026-08-01') TO ('2026-09-01');


--
-- Name: impressions_3c19367; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_3c19367 PARTITION OF public.impressions
FOR VALUES FROM ('2020-02-01') TO ('2020-03-01');


--
-- Name: impressions_3d6d9e3; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_3d6d9e3 PARTITION OF public.impressions
FOR VALUES FROM ('2024-12-01') TO ('2025-01-01');


--
-- Name: impressions_3ed5b0d; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_3ed5b0d PARTITION OF public.impressions
FOR VALUES FROM ('2028-02-01') TO ('2028-03-01');


--
-- Name: impressions_40d9aec; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_40d9aec PARTITION OF public.impressions
FOR VALUES FROM ('2023-06-01') TO ('2023-07-01');


--
-- Name: impressions_42e511b; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_42e511b PARTITION OF public.impressions
FOR VALUES FROM ('2026-05-01') TO ('2026-06-01');


--
-- Name: impressions_49c6760; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_49c6760 PARTITION OF public.impressions
FOR VALUES FROM ('2025-07-01') TO ('2025-08-01');


--
-- Name: impressions_4afe466; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_4afe466 PARTITION OF public.impressions
FOR VALUES FROM ('2021-09-01') TO ('2021-10-01');


--
-- Name: impressions_4dd4269; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_4dd4269 PARTITION OF public.impressions
FOR VALUES FROM ('2021-06-01') TO ('2021-07-01');


--
-- Name: impressions_4ef837c; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_4ef837c PARTITION OF public.impressions
FOR VALUES FROM ('2027-04-01') TO ('2027-05-01');


--
-- Name: impressions_4f55d86; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_4f55d86 PARTITION OF public.impressions
FOR VALUES FROM ('2024-05-01') TO ('2024-06-01');


--
-- Name: impressions_51233a7; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_51233a7 PARTITION OF public.impressions
FOR VALUES FROM ('2019-02-01') TO ('2019-03-01');


--
-- Name: impressions_522745d; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_522745d PARTITION OF public.impressions
FOR VALUES FROM ('2028-07-01') TO ('2028-08-01');


--
-- Name: impressions_548979a; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_548979a PARTITION OF public.impressions
FOR VALUES FROM ('2019-09-01') TO ('2019-10-01');


--
-- Name: impressions_5576a2c; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_5576a2c PARTITION OF public.impressions
FOR VALUES FROM ('2025-06-01') TO ('2025-07-01');


--
-- Name: impressions_579ba19; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_579ba19 PARTITION OF public.impressions
FOR VALUES FROM ('2022-11-01') TO ('2022-12-01');


--
-- Name: impressions_591d6f9; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_591d6f9 PARTITION OF public.impressions
FOR VALUES FROM ('2027-06-01') TO ('2027-07-01');


--
-- Name: impressions_5ad7ce6; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_5ad7ce6 PARTITION OF public.impressions
FOR VALUES FROM ('2019-06-01') TO ('2019-07-01');


--
-- Name: impressions_5b275aa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_5b275aa PARTITION OF public.impressions
FOR VALUES FROM ('2023-03-01') TO ('2023-04-01');


--
-- Name: impressions_5c24c1f; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_5c24c1f PARTITION OF public.impressions
FOR VALUES FROM ('2026-06-01') TO ('2026-07-01');


--
-- Name: impressions_5e64735; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_5e64735 PARTITION OF public.impressions
FOR VALUES FROM ('2020-10-01') TO ('2020-11-01');


--
-- Name: impressions_6025363; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_6025363 PARTITION OF public.impressions
FOR VALUES FROM ('2025-03-01') TO ('2025-04-01');


--
-- Name: impressions_6707fb6; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_6707fb6 PARTITION OF public.impressions
FOR VALUES FROM ('2028-01-01') TO ('2028-02-01');


--
-- Name: impressions_67312bc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_67312bc PARTITION OF public.impressions
FOR VALUES FROM ('2022-08-01') TO ('2022-09-01');


--
-- Name: impressions_6917f25; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_6917f25 PARTITION OF public.impressions
FOR VALUES FROM ('2022-10-01') TO ('2022-11-01');


--
-- Name: impressions_6e55f42; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_6e55f42 PARTITION OF public.impressions
FOR VALUES FROM ('2028-03-01') TO ('2028-04-01');


--
-- Name: impressions_7056f65; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_7056f65 PARTITION OF public.impressions
FOR VALUES FROM ('2020-12-01') TO ('2021-01-01');


--
-- Name: impressions_74c0c78; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_74c0c78 PARTITION OF public.impressions
FOR VALUES FROM ('2021-10-01') TO ('2021-11-01');


--
-- Name: impressions_78e11c5; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_78e11c5 PARTITION OF public.impressions
FOR VALUES FROM ('2024-06-01') TO ('2024-07-01');


--
-- Name: impressions_7b5e867; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_7b5e867 PARTITION OF public.impressions
FOR VALUES FROM ('2019-08-01') TO ('2019-09-01');


--
-- Name: impressions_7e8ebd6; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_7e8ebd6 PARTITION OF public.impressions
FOR VALUES FROM ('2020-06-01') TO ('2020-07-01');


--
-- Name: impressions_7ebab1d; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_7ebab1d PARTITION OF public.impressions
FOR VALUES FROM ('2021-02-01') TO ('2021-03-01');


--
-- Name: impressions_7f04b7c; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_7f04b7c PARTITION OF public.impressions
FOR VALUES FROM ('2019-12-01') TO ('2020-01-01');


--
-- Name: impressions_7f556bf; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_7f556bf PARTITION OF public.impressions
FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');


--
-- Name: impressions_80a90da; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_80a90da PARTITION OF public.impressions
FOR VALUES FROM ('2028-05-01') TO ('2028-06-01');


--
-- Name: impressions_8142edc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_8142edc PARTITION OF public.impressions
FOR VALUES FROM ('2025-11-01') TO ('2025-12-01');


--
-- Name: impressions_8474984; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_8474984 PARTITION OF public.impressions
FOR VALUES FROM ('2022-01-01') TO ('2022-02-01');


--
-- Name: impressions_85f5e29; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_85f5e29 PARTITION OF public.impressions
FOR VALUES FROM ('2019-05-01') TO ('2019-06-01');


--
-- Name: impressions_862d332; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_862d332 PARTITION OF public.impressions
FOR VALUES FROM ('2027-11-01') TO ('2027-12-01');


--
-- Name: impressions_8894562; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_8894562 PARTITION OF public.impressions
FOR VALUES FROM ('2021-07-01') TO ('2021-08-01');


--
-- Name: impressions_8a205c2; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_8a205c2 PARTITION OF public.impressions
FOR VALUES FROM ('2023-05-01') TO ('2023-06-01');


--
-- Name: impressions_8c4dd57; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_8c4dd57 PARTITION OF public.impressions
FOR VALUES FROM ('2025-09-01') TO ('2025-10-01');


--
-- Name: impressions_8cf9e1c; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_8cf9e1c PARTITION OF public.impressions
FOR VALUES FROM ('2026-03-01') TO ('2026-04-01');


--
-- Name: impressions_8e2ff6b; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_8e2ff6b PARTITION OF public.impressions
FOR VALUES FROM ('2024-08-01') TO ('2024-09-01');


--
-- Name: impressions_9025cbb; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_9025cbb PARTITION OF public.impressions
FOR VALUES FROM ('2025-04-01') TO ('2025-05-01');


--
-- Name: impressions_90d9302; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_90d9302 PARTITION OF public.impressions
FOR VALUES FROM ('2027-03-01') TO ('2027-04-01');


--
-- Name: impressions_9257c9d; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_9257c9d PARTITION OF public.impressions
FOR VALUES FROM ('2026-02-01') TO ('2026-03-01');


--
-- Name: impressions_93d7d18; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_93d7d18 PARTITION OF public.impressions
FOR VALUES FROM ('2023-02-01') TO ('2023-03-01');


--
-- Name: impressions_94f0a87; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_94f0a87 PARTITION OF public.impressions
FOR VALUES FROM ('2020-07-01') TO ('2020-08-01');


--
-- Name: impressions_95c00de; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_95c00de PARTITION OF public.impressions
FOR VALUES FROM ('2024-04-01') TO ('2024-05-01');


--
-- Name: impressions_95f5aed; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_95f5aed PARTITION OF public.impressions
FOR VALUES FROM ('2027-02-01') TO ('2027-03-01');


--
-- Name: impressions_977ed92; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_977ed92 PARTITION OF public.impressions
FOR VALUES FROM ('2024-10-01') TO ('2024-11-01');


--
-- Name: impressions_99bd6ac; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_99bd6ac PARTITION OF public.impressions
FOR VALUES FROM ('2027-01-01') TO ('2027-02-01');


--
-- Name: impressions_9d02901; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_9d02901 PARTITION OF public.impressions
FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');


--
-- Name: impressions_a5b36a9; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_a5b36a9 PARTITION OF public.impressions
FOR VALUES FROM ('2021-04-01') TO ('2021-05-01');


--
-- Name: impressions_a5d876d; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_a5d876d PARTITION OF public.impressions
FOR VALUES FROM ('2024-07-01') TO ('2024-08-01');


--
-- Name: impressions_a6e5a50; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_a6e5a50 PARTITION OF public.impressions
FOR VALUES FROM ('2026-12-01') TO ('2027-01-01');


--
-- Name: impressions_a7f178b; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_a7f178b PARTITION OF public.impressions
FOR VALUES FROM ('2026-04-01') TO ('2026-05-01');


--
-- Name: impressions_accf3ae; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_accf3ae PARTITION OF public.impressions
FOR VALUES FROM ('2023-10-01') TO ('2023-11-01');


--
-- Name: impressions_ad1667d; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_ad1667d PARTITION OF public.impressions
FOR VALUES FROM ('2028-04-01') TO ('2028-05-01');


--
-- Name: impressions_adab992; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_adab992 PARTITION OF public.impressions
FOR VALUES FROM ('2021-12-01') TO ('2022-01-01');


--
-- Name: impressions_af29709; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_af29709 PARTITION OF public.impressions
FOR VALUES FROM ('2027-05-01') TO ('2027-06-01');


--
-- Name: impressions_b30c5f4; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_b30c5f4 PARTITION OF public.impressions
FOR VALUES FROM ('2022-03-01') TO ('2022-04-01');


--
-- Name: impressions_b8b32d6; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_b8b32d6 PARTITION OF public.impressions
FOR VALUES FROM ('2026-07-01') TO ('2026-08-01');


--
-- Name: impressions_b9feea5; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_b9feea5 PARTITION OF public.impressions
FOR VALUES FROM ('2022-02-01') TO ('2022-03-01');


--
-- Name: impressions_bc32520; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_bc32520 PARTITION OF public.impressions
FOR VALUES FROM ('2021-03-01') TO ('2021-04-01');


--
-- Name: impressions_be31132; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_be31132 PARTITION OF public.impressions
FOR VALUES FROM ('2024-11-01') TO ('2024-12-01');


--
-- Name: impressions_c14ec8a; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_c14ec8a PARTITION OF public.impressions
FOR VALUES FROM ('2021-08-01') TO ('2021-09-01');


--
-- Name: impressions_c3037b2; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_c3037b2 PARTITION OF public.impressions
FOR VALUES FROM ('2024-03-01') TO ('2024-04-01');


--
-- Name: impressions_c4350d3; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_c4350d3 PARTITION OF public.impressions
FOR VALUES FROM ('2020-11-01') TO ('2020-12-01');


--
-- Name: impressions_c9cb65e; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_c9cb65e PARTITION OF public.impressions
FOR VALUES FROM ('2023-08-01') TO ('2023-09-01');


--
-- Name: impressions_cb5be27; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_cb5be27 PARTITION OF public.impressions
FOR VALUES FROM ('2025-08-01') TO ('2025-09-01');


--
-- Name: impressions_cc3bbc2; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_cc3bbc2 PARTITION OF public.impressions
FOR VALUES FROM ('2022-07-01') TO ('2022-08-01');


--
-- Name: impressions_ccfc39a; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_ccfc39a PARTITION OF public.impressions
FOR VALUES FROM ('2020-05-01') TO ('2020-06-01');


--
-- Name: impressions_d072121; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_d072121 PARTITION OF public.impressions
FOR VALUES FROM ('2027-10-01') TO ('2027-11-01');


--
-- Name: impressions_d2b5f35; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_d2b5f35 PARTITION OF public.impressions
FOR VALUES FROM ('2021-11-01') TO ('2021-12-01');


--
-- Name: impressions_d500d91; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_d500d91 PARTITION OF public.impressions
FOR VALUES FROM ('2020-04-01') TO ('2020-05-01');


--
-- Name: impressions_d801546; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_d801546 PARTITION OF public.impressions
FOR VALUES FROM ('2018-11-01') TO ('2018-12-01');


--
-- Name: impressions_d9f318d; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_d9f318d PARTITION OF public.impressions
FOR VALUES FROM ('2027-12-01') TO ('2028-01-01');


--
-- Name: impressions_db5c100; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_db5c100 PARTITION OF public.impressions
FOR VALUES FROM ('2023-11-01') TO ('2023-12-01');


--
-- Name: impressions_dbfada5; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_dbfada5 PARTITION OF public.impressions
FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');


--
-- Name: impressions_dcfa592; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_dcfa592 PARTITION OF public.impressions
FOR VALUES FROM ('2019-11-01') TO ('2019-12-01');


--
-- Name: impressions_e0da3fd; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_e0da3fd PARTITION OF public.impressions
FOR VALUES FROM ('2023-07-01') TO ('2023-08-01');


--
-- Name: impressions_e6bd22d; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_e6bd22d PARTITION OF public.impressions
FOR VALUES FROM ('2023-04-01') TO ('2023-05-01');


--
-- Name: impressions_e7cdbb8; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_e7cdbb8 PARTITION OF public.impressions
FOR VALUES FROM ('2026-10-01') TO ('2026-11-01');


--
-- Name: impressions_e7f326c; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_e7f326c PARTITION OF public.impressions
FOR VALUES FROM ('2028-06-01') TO ('2028-07-01');


--
-- Name: impressions_e942689; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_e942689 PARTITION OF public.impressions
FOR VALUES FROM ('2026-11-01') TO ('2026-12-01');


--
-- Name: impressions_eb6cfa6; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_eb6cfa6 PARTITION OF public.impressions
FOR VALUES FROM ('2020-08-01') TO ('2020-09-01');


--
-- Name: impressions_ec2dc1e; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_ec2dc1e PARTITION OF public.impressions
FOR VALUES FROM ('2019-10-01') TO ('2019-11-01');


--
-- Name: impressions_efc15cd; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_efc15cd PARTITION OF public.impressions
FOR VALUES FROM ('2022-05-01') TO ('2022-06-01');


--
-- Name: impressions_f03d063; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_f03d063 PARTITION OF public.impressions
FOR VALUES FROM ('2024-02-01') TO ('2024-03-01');


--
-- Name: impressions_f1cbe01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_f1cbe01 PARTITION OF public.impressions
FOR VALUES FROM ('2022-04-01') TO ('2022-05-01');


--
-- Name: impressions_f2d2cd3; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_f2d2cd3 PARTITION OF public.impressions
FOR VALUES FROM ('2020-01-01') TO ('2020-02-01');


--
-- Name: impressions_f2f396a; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_f2f396a PARTITION OF public.impressions
FOR VALUES FROM ('2027-08-01') TO ('2027-09-01');


--
-- Name: impressions_f5a1145; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_f5a1145 PARTITION OF public.impressions
FOR VALUES FROM ('2019-03-01') TO ('2019-04-01');


--
-- Name: impressions_f66d3ce; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_f66d3ce PARTITION OF public.impressions
FOR VALUES FROM ('2028-10-01') TO ('2028-11-01');


--
-- Name: impressions_fbcea0f; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_fbcea0f PARTITION OF public.impressions
FOR VALUES FROM ('2026-09-01') TO ('2026-10-01');


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
-- Name: impressions_008f8c2 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_008f8c2 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_008f8c2 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_008f8c2 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_008f8c2 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_008f8c2 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_00afa31 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_00afa31 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_00afa31 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_00afa31 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_00afa31 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_00afa31 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_0281a27 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0281a27 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_0281a27 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0281a27 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_0281a27 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0281a27 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_081c4ce id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_081c4ce ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_081c4ce payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_081c4ce ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_081c4ce fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_081c4ce ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_0947ece id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0947ece ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_0947ece payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0947ece ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_0947ece fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0947ece ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_0a989dc id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0a989dc ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_0a989dc payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0a989dc ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_0a989dc fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0a989dc ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_0ae566a id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0ae566a ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_0ae566a payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0ae566a ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_0ae566a fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0ae566a ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_0bf3fae id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0bf3fae ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_0bf3fae payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0bf3fae ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_0bf3fae fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0bf3fae ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_0fbc017 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0fbc017 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_0fbc017 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0fbc017 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_0fbc017 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0fbc017 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_132f3f5 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_132f3f5 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_132f3f5 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_132f3f5 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_132f3f5 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_132f3f5 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_155e200 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_155e200 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_155e200 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_155e200 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_155e200 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_155e200 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_1c56374 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_1c56374 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_1c56374 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_1c56374 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_1c56374 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_1c56374 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_1e4146f id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_1e4146f ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_1e4146f payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_1e4146f ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_1e4146f fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_1e4146f ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_26d04a3 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_26d04a3 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_26d04a3 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_26d04a3 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_26d04a3 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_26d04a3 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_27d985f id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_27d985f ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_27d985f payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_27d985f ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_27d985f fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_27d985f ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_299ed5e id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_299ed5e ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_299ed5e payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_299ed5e ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_299ed5e fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_299ed5e ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2da957d id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2da957d ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2da957d payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2da957d ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2da957d fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2da957d ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2ddf121 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2ddf121 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2ddf121 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2ddf121 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2ddf121 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2ddf121 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2ede6f8 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2ede6f8 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2ede6f8 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2ede6f8 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2ede6f8 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2ede6f8 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_318d9ee id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_318d9ee ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_318d9ee payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_318d9ee ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_318d9ee fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_318d9ee ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_33e0986 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_33e0986 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_33e0986 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_33e0986 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_33e0986 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_33e0986 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_36cd868 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_36cd868 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_36cd868 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_36cd868 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_36cd868 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_36cd868 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_3b83f44 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_3b83f44 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_3b83f44 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_3b83f44 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_3b83f44 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_3b83f44 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_3bb672d id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_3bb672d ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_3bb672d payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_3bb672d ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_3bb672d fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_3bb672d ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_3c19367 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_3c19367 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_3c19367 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_3c19367 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_3c19367 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_3c19367 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_3d6d9e3 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_3d6d9e3 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_3d6d9e3 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_3d6d9e3 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_3d6d9e3 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_3d6d9e3 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_3ed5b0d id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_3ed5b0d ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_3ed5b0d payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_3ed5b0d ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_3ed5b0d fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_3ed5b0d ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_40d9aec id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_40d9aec ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_40d9aec payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_40d9aec ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_40d9aec fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_40d9aec ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_42e511b id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_42e511b ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_42e511b payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_42e511b ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_42e511b fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_42e511b ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_49c6760 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_49c6760 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_49c6760 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_49c6760 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_49c6760 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_49c6760 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_4afe466 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_4afe466 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_4afe466 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_4afe466 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_4afe466 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_4afe466 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_4dd4269 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_4dd4269 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_4dd4269 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_4dd4269 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_4dd4269 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_4dd4269 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_4ef837c id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_4ef837c ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_4ef837c payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_4ef837c ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_4ef837c fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_4ef837c ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_4f55d86 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_4f55d86 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_4f55d86 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_4f55d86 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_4f55d86 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_4f55d86 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_51233a7 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_51233a7 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_51233a7 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_51233a7 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_51233a7 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_51233a7 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_522745d id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_522745d ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_522745d payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_522745d ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_522745d fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_522745d ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_548979a id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_548979a ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_548979a payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_548979a ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_548979a fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_548979a ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_5576a2c id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_5576a2c ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_5576a2c payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_5576a2c ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_5576a2c fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_5576a2c ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_579ba19 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_579ba19 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_579ba19 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_579ba19 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_579ba19 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_579ba19 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_591d6f9 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_591d6f9 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_591d6f9 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_591d6f9 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_591d6f9 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_591d6f9 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_5ad7ce6 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_5ad7ce6 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_5ad7ce6 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_5ad7ce6 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_5ad7ce6 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_5ad7ce6 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_5b275aa id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_5b275aa ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_5b275aa payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_5b275aa ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_5b275aa fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_5b275aa ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_5c24c1f id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_5c24c1f ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_5c24c1f payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_5c24c1f ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_5c24c1f fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_5c24c1f ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_5e64735 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_5e64735 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_5e64735 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_5e64735 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_5e64735 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_5e64735 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_6025363 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_6025363 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_6025363 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_6025363 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_6025363 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_6025363 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_6707fb6 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_6707fb6 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_6707fb6 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_6707fb6 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_6707fb6 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_6707fb6 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_67312bc id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_67312bc ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_67312bc payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_67312bc ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_67312bc fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_67312bc ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_6917f25 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_6917f25 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_6917f25 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_6917f25 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_6917f25 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_6917f25 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_6e55f42 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_6e55f42 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_6e55f42 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_6e55f42 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_6e55f42 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_6e55f42 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_7056f65 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7056f65 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_7056f65 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7056f65 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_7056f65 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7056f65 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_74c0c78 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_74c0c78 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_74c0c78 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_74c0c78 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_74c0c78 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_74c0c78 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_78e11c5 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_78e11c5 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_78e11c5 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_78e11c5 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_78e11c5 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_78e11c5 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_7b5e867 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7b5e867 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_7b5e867 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7b5e867 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_7b5e867 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7b5e867 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_7e8ebd6 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7e8ebd6 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_7e8ebd6 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7e8ebd6 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_7e8ebd6 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7e8ebd6 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_7ebab1d id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7ebab1d ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_7ebab1d payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7ebab1d ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_7ebab1d fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7ebab1d ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_7f04b7c id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7f04b7c ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_7f04b7c payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7f04b7c ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_7f04b7c fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7f04b7c ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_7f556bf id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7f556bf ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_7f556bf payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7f556bf ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_7f556bf fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7f556bf ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_80a90da id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_80a90da ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_80a90da payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_80a90da ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_80a90da fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_80a90da ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_8142edc id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8142edc ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_8142edc payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8142edc ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_8142edc fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8142edc ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_8474984 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8474984 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_8474984 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8474984 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_8474984 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8474984 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_85f5e29 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_85f5e29 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_85f5e29 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_85f5e29 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_85f5e29 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_85f5e29 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_862d332 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_862d332 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_862d332 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_862d332 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_862d332 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_862d332 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_8894562 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8894562 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_8894562 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8894562 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_8894562 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8894562 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_8a205c2 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8a205c2 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_8a205c2 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8a205c2 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_8a205c2 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8a205c2 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_8c4dd57 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8c4dd57 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_8c4dd57 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8c4dd57 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_8c4dd57 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8c4dd57 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_8cf9e1c id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8cf9e1c ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_8cf9e1c payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8cf9e1c ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_8cf9e1c fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8cf9e1c ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_8e2ff6b id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8e2ff6b ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_8e2ff6b payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8e2ff6b ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_8e2ff6b fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8e2ff6b ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_9025cbb id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_9025cbb ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_9025cbb payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_9025cbb ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_9025cbb fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_9025cbb ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_90d9302 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_90d9302 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_90d9302 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_90d9302 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_90d9302 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_90d9302 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_9257c9d id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_9257c9d ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_9257c9d payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_9257c9d ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_9257c9d fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_9257c9d ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_93d7d18 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_93d7d18 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_93d7d18 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_93d7d18 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_93d7d18 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_93d7d18 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_94f0a87 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_94f0a87 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_94f0a87 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_94f0a87 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_94f0a87 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_94f0a87 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_95c00de id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_95c00de ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_95c00de payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_95c00de ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_95c00de fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_95c00de ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_95f5aed id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_95f5aed ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_95f5aed payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_95f5aed ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_95f5aed fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_95f5aed ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_977ed92 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_977ed92 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_977ed92 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_977ed92 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_977ed92 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_977ed92 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_99bd6ac id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_99bd6ac ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_99bd6ac payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_99bd6ac ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_99bd6ac fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_99bd6ac ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_9d02901 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_9d02901 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_9d02901 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_9d02901 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_9d02901 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_9d02901 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_a5b36a9 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_a5b36a9 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_a5b36a9 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_a5b36a9 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_a5b36a9 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_a5b36a9 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_a5d876d id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_a5d876d ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_a5d876d payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_a5d876d ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_a5d876d fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_a5d876d ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_a6e5a50 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_a6e5a50 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_a6e5a50 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_a6e5a50 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_a6e5a50 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_a6e5a50 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_a7f178b id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_a7f178b ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_a7f178b payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_a7f178b ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_a7f178b fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_a7f178b ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_accf3ae id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_accf3ae ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_accf3ae payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_accf3ae ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_accf3ae fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_accf3ae ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_ad1667d id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_ad1667d ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_ad1667d payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_ad1667d ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_ad1667d fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_ad1667d ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_adab992 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_adab992 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_adab992 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_adab992 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_adab992 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_adab992 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_af29709 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_af29709 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_af29709 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_af29709 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_af29709 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_af29709 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_b30c5f4 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_b30c5f4 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_b30c5f4 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_b30c5f4 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_b30c5f4 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_b30c5f4 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_b8b32d6 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_b8b32d6 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_b8b32d6 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_b8b32d6 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_b8b32d6 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_b8b32d6 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_b9feea5 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_b9feea5 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_b9feea5 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_b9feea5 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_b9feea5 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_b9feea5 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_bc32520 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_bc32520 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_bc32520 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_bc32520 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_bc32520 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_bc32520 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_be31132 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_be31132 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_be31132 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_be31132 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_be31132 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_be31132 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_c14ec8a id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_c14ec8a ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_c14ec8a payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_c14ec8a ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_c14ec8a fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_c14ec8a ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_c3037b2 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_c3037b2 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_c3037b2 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_c3037b2 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_c3037b2 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_c3037b2 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_c4350d3 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_c4350d3 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_c4350d3 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_c4350d3 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_c4350d3 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_c4350d3 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_c9cb65e id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_c9cb65e ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_c9cb65e payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_c9cb65e ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_c9cb65e fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_c9cb65e ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_cb5be27 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_cb5be27 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_cb5be27 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_cb5be27 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_cb5be27 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_cb5be27 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_cc3bbc2 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_cc3bbc2 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_cc3bbc2 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_cc3bbc2 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_cc3bbc2 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_cc3bbc2 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_ccfc39a id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_ccfc39a ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_ccfc39a payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_ccfc39a ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_ccfc39a fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_ccfc39a ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_d072121 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_d072121 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_d072121 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_d072121 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_d072121 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_d072121 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_d2b5f35 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_d2b5f35 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_d2b5f35 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_d2b5f35 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_d2b5f35 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_d2b5f35 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_d500d91 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_d500d91 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_d500d91 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_d500d91 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_d500d91 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_d500d91 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_d801546 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_d801546 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_d801546 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_d801546 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_d801546 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_d801546 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_d9f318d id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_d9f318d ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_d9f318d payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_d9f318d ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_d9f318d fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_d9f318d ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_db5c100 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_db5c100 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_db5c100 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_db5c100 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_db5c100 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_db5c100 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_dbfada5 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_dbfada5 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_dbfada5 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_dbfada5 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_dbfada5 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_dbfada5 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_dcfa592 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_dcfa592 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_dcfa592 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_dcfa592 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_dcfa592 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_dcfa592 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_e0da3fd id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_e0da3fd ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_e0da3fd payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_e0da3fd ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_e0da3fd fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_e0da3fd ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_e6bd22d id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_e6bd22d ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_e6bd22d payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_e6bd22d ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_e6bd22d fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_e6bd22d ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_e7cdbb8 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_e7cdbb8 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_e7cdbb8 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_e7cdbb8 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_e7cdbb8 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_e7cdbb8 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_e7f326c id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_e7f326c ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_e7f326c payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_e7f326c ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_e7f326c fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_e7f326c ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_e942689 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_e942689 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_e942689 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_e942689 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_e942689 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_e942689 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_eb6cfa6 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_eb6cfa6 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_eb6cfa6 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_eb6cfa6 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_eb6cfa6 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_eb6cfa6 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_ec2dc1e id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_ec2dc1e ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_ec2dc1e payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_ec2dc1e ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_ec2dc1e fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_ec2dc1e ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_efc15cd id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_efc15cd ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_efc15cd payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_efc15cd ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_efc15cd fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_efc15cd ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_f03d063 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f03d063 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_f03d063 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f03d063 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_f03d063 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f03d063 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_f1cbe01 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f1cbe01 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_f1cbe01 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f1cbe01 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_f1cbe01 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f1cbe01 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_f2d2cd3 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f2d2cd3 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_f2d2cd3 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f2d2cd3 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_f2d2cd3 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f2d2cd3 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_f2f396a id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f2f396a ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_f2f396a payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f2f396a ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_f2f396a fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f2f396a ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_f5a1145 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f5a1145 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_f5a1145 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f5a1145 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_f5a1145 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f5a1145 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_f66d3ce id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f66d3ce ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_f66d3ce payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f66d3ce ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_f66d3ce fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f66d3ce ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_fbcea0f id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_fbcea0f ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_fbcea0f payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_fbcea0f ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_fbcea0f fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_fbcea0f ALTER COLUMN fallback_campaign SET DEFAULT false;


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
-- Name: impressions_008f8c2 impressions_008f8c2_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_008f8c2
    ADD CONSTRAINT impressions_008f8c2_pkey PRIMARY KEY (id);


--
-- Name: impressions_00afa31 impressions_00afa31_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_00afa31
    ADD CONSTRAINT impressions_00afa31_pkey PRIMARY KEY (id);


--
-- Name: impressions_0281a27 impressions_0281a27_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0281a27
    ADD CONSTRAINT impressions_0281a27_pkey PRIMARY KEY (id);


--
-- Name: impressions_081c4ce impressions_081c4ce_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_081c4ce
    ADD CONSTRAINT impressions_081c4ce_pkey PRIMARY KEY (id);


--
-- Name: impressions_0947ece impressions_0947ece_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0947ece
    ADD CONSTRAINT impressions_0947ece_pkey PRIMARY KEY (id);


--
-- Name: impressions_0a989dc impressions_0a989dc_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0a989dc
    ADD CONSTRAINT impressions_0a989dc_pkey PRIMARY KEY (id);


--
-- Name: impressions_0ae566a impressions_0ae566a_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0ae566a
    ADD CONSTRAINT impressions_0ae566a_pkey PRIMARY KEY (id);


--
-- Name: impressions_0bf3fae impressions_0bf3fae_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0bf3fae
    ADD CONSTRAINT impressions_0bf3fae_pkey PRIMARY KEY (id);


--
-- Name: impressions_0fbc017 impressions_0fbc017_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_0fbc017
    ADD CONSTRAINT impressions_0fbc017_pkey PRIMARY KEY (id);


--
-- Name: impressions_132f3f5 impressions_132f3f5_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_132f3f5
    ADD CONSTRAINT impressions_132f3f5_pkey PRIMARY KEY (id);


--
-- Name: impressions_155e200 impressions_155e200_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_155e200
    ADD CONSTRAINT impressions_155e200_pkey PRIMARY KEY (id);


--
-- Name: impressions_1c56374 impressions_1c56374_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_1c56374
    ADD CONSTRAINT impressions_1c56374_pkey PRIMARY KEY (id);


--
-- Name: impressions_1e4146f impressions_1e4146f_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_1e4146f
    ADD CONSTRAINT impressions_1e4146f_pkey PRIMARY KEY (id);


--
-- Name: impressions_26d04a3 impressions_26d04a3_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_26d04a3
    ADD CONSTRAINT impressions_26d04a3_pkey PRIMARY KEY (id);


--
-- Name: impressions_27d985f impressions_27d985f_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_27d985f
    ADD CONSTRAINT impressions_27d985f_pkey PRIMARY KEY (id);


--
-- Name: impressions_299ed5e impressions_299ed5e_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_299ed5e
    ADD CONSTRAINT impressions_299ed5e_pkey PRIMARY KEY (id);


--
-- Name: impressions_2da957d impressions_2da957d_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2da957d
    ADD CONSTRAINT impressions_2da957d_pkey PRIMARY KEY (id);


--
-- Name: impressions_2ddf121 impressions_2ddf121_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2ddf121
    ADD CONSTRAINT impressions_2ddf121_pkey PRIMARY KEY (id);


--
-- Name: impressions_2ede6f8 impressions_2ede6f8_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2ede6f8
    ADD CONSTRAINT impressions_2ede6f8_pkey PRIMARY KEY (id);


--
-- Name: impressions_318d9ee impressions_318d9ee_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_318d9ee
    ADD CONSTRAINT impressions_318d9ee_pkey PRIMARY KEY (id);


--
-- Name: impressions_33e0986 impressions_33e0986_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_33e0986
    ADD CONSTRAINT impressions_33e0986_pkey PRIMARY KEY (id);


--
-- Name: impressions_36cd868 impressions_36cd868_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_36cd868
    ADD CONSTRAINT impressions_36cd868_pkey PRIMARY KEY (id);


--
-- Name: impressions_3b83f44 impressions_3b83f44_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_3b83f44
    ADD CONSTRAINT impressions_3b83f44_pkey PRIMARY KEY (id);


--
-- Name: impressions_3bb672d impressions_3bb672d_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_3bb672d
    ADD CONSTRAINT impressions_3bb672d_pkey PRIMARY KEY (id);


--
-- Name: impressions_3c19367 impressions_3c19367_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_3c19367
    ADD CONSTRAINT impressions_3c19367_pkey PRIMARY KEY (id);


--
-- Name: impressions_3d6d9e3 impressions_3d6d9e3_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_3d6d9e3
    ADD CONSTRAINT impressions_3d6d9e3_pkey PRIMARY KEY (id);


--
-- Name: impressions_3ed5b0d impressions_3ed5b0d_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_3ed5b0d
    ADD CONSTRAINT impressions_3ed5b0d_pkey PRIMARY KEY (id);


--
-- Name: impressions_40d9aec impressions_40d9aec_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_40d9aec
    ADD CONSTRAINT impressions_40d9aec_pkey PRIMARY KEY (id);


--
-- Name: impressions_42e511b impressions_42e511b_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_42e511b
    ADD CONSTRAINT impressions_42e511b_pkey PRIMARY KEY (id);


--
-- Name: impressions_49c6760 impressions_49c6760_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_49c6760
    ADD CONSTRAINT impressions_49c6760_pkey PRIMARY KEY (id);


--
-- Name: impressions_4afe466 impressions_4afe466_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_4afe466
    ADD CONSTRAINT impressions_4afe466_pkey PRIMARY KEY (id);


--
-- Name: impressions_4dd4269 impressions_4dd4269_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_4dd4269
    ADD CONSTRAINT impressions_4dd4269_pkey PRIMARY KEY (id);


--
-- Name: impressions_4ef837c impressions_4ef837c_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_4ef837c
    ADD CONSTRAINT impressions_4ef837c_pkey PRIMARY KEY (id);


--
-- Name: impressions_4f55d86 impressions_4f55d86_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_4f55d86
    ADD CONSTRAINT impressions_4f55d86_pkey PRIMARY KEY (id);


--
-- Name: impressions_51233a7 impressions_51233a7_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_51233a7
    ADD CONSTRAINT impressions_51233a7_pkey PRIMARY KEY (id);


--
-- Name: impressions_522745d impressions_522745d_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_522745d
    ADD CONSTRAINT impressions_522745d_pkey PRIMARY KEY (id);


--
-- Name: impressions_548979a impressions_548979a_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_548979a
    ADD CONSTRAINT impressions_548979a_pkey PRIMARY KEY (id);


--
-- Name: impressions_5576a2c impressions_5576a2c_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_5576a2c
    ADD CONSTRAINT impressions_5576a2c_pkey PRIMARY KEY (id);


--
-- Name: impressions_579ba19 impressions_579ba19_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_579ba19
    ADD CONSTRAINT impressions_579ba19_pkey PRIMARY KEY (id);


--
-- Name: impressions_591d6f9 impressions_591d6f9_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_591d6f9
    ADD CONSTRAINT impressions_591d6f9_pkey PRIMARY KEY (id);


--
-- Name: impressions_5ad7ce6 impressions_5ad7ce6_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_5ad7ce6
    ADD CONSTRAINT impressions_5ad7ce6_pkey PRIMARY KEY (id);


--
-- Name: impressions_5b275aa impressions_5b275aa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_5b275aa
    ADD CONSTRAINT impressions_5b275aa_pkey PRIMARY KEY (id);


--
-- Name: impressions_5c24c1f impressions_5c24c1f_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_5c24c1f
    ADD CONSTRAINT impressions_5c24c1f_pkey PRIMARY KEY (id);


--
-- Name: impressions_5e64735 impressions_5e64735_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_5e64735
    ADD CONSTRAINT impressions_5e64735_pkey PRIMARY KEY (id);


--
-- Name: impressions_6025363 impressions_6025363_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_6025363
    ADD CONSTRAINT impressions_6025363_pkey PRIMARY KEY (id);


--
-- Name: impressions_6707fb6 impressions_6707fb6_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_6707fb6
    ADD CONSTRAINT impressions_6707fb6_pkey PRIMARY KEY (id);


--
-- Name: impressions_67312bc impressions_67312bc_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_67312bc
    ADD CONSTRAINT impressions_67312bc_pkey PRIMARY KEY (id);


--
-- Name: impressions_6917f25 impressions_6917f25_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_6917f25
    ADD CONSTRAINT impressions_6917f25_pkey PRIMARY KEY (id);


--
-- Name: impressions_6e55f42 impressions_6e55f42_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_6e55f42
    ADD CONSTRAINT impressions_6e55f42_pkey PRIMARY KEY (id);


--
-- Name: impressions_7056f65 impressions_7056f65_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7056f65
    ADD CONSTRAINT impressions_7056f65_pkey PRIMARY KEY (id);


--
-- Name: impressions_74c0c78 impressions_74c0c78_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_74c0c78
    ADD CONSTRAINT impressions_74c0c78_pkey PRIMARY KEY (id);


--
-- Name: impressions_78e11c5 impressions_78e11c5_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_78e11c5
    ADD CONSTRAINT impressions_78e11c5_pkey PRIMARY KEY (id);


--
-- Name: impressions_7b5e867 impressions_7b5e867_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7b5e867
    ADD CONSTRAINT impressions_7b5e867_pkey PRIMARY KEY (id);


--
-- Name: impressions_7e8ebd6 impressions_7e8ebd6_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7e8ebd6
    ADD CONSTRAINT impressions_7e8ebd6_pkey PRIMARY KEY (id);


--
-- Name: impressions_7ebab1d impressions_7ebab1d_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7ebab1d
    ADD CONSTRAINT impressions_7ebab1d_pkey PRIMARY KEY (id);


--
-- Name: impressions_7f04b7c impressions_7f04b7c_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7f04b7c
    ADD CONSTRAINT impressions_7f04b7c_pkey PRIMARY KEY (id);


--
-- Name: impressions_7f556bf impressions_7f556bf_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_7f556bf
    ADD CONSTRAINT impressions_7f556bf_pkey PRIMARY KEY (id);


--
-- Name: impressions_80a90da impressions_80a90da_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_80a90da
    ADD CONSTRAINT impressions_80a90da_pkey PRIMARY KEY (id);


--
-- Name: impressions_8142edc impressions_8142edc_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8142edc
    ADD CONSTRAINT impressions_8142edc_pkey PRIMARY KEY (id);


--
-- Name: impressions_8474984 impressions_8474984_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8474984
    ADD CONSTRAINT impressions_8474984_pkey PRIMARY KEY (id);


--
-- Name: impressions_85f5e29 impressions_85f5e29_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_85f5e29
    ADD CONSTRAINT impressions_85f5e29_pkey PRIMARY KEY (id);


--
-- Name: impressions_862d332 impressions_862d332_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_862d332
    ADD CONSTRAINT impressions_862d332_pkey PRIMARY KEY (id);


--
-- Name: impressions_8894562 impressions_8894562_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8894562
    ADD CONSTRAINT impressions_8894562_pkey PRIMARY KEY (id);


--
-- Name: impressions_8a205c2 impressions_8a205c2_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8a205c2
    ADD CONSTRAINT impressions_8a205c2_pkey PRIMARY KEY (id);


--
-- Name: impressions_8c4dd57 impressions_8c4dd57_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8c4dd57
    ADD CONSTRAINT impressions_8c4dd57_pkey PRIMARY KEY (id);


--
-- Name: impressions_8cf9e1c impressions_8cf9e1c_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8cf9e1c
    ADD CONSTRAINT impressions_8cf9e1c_pkey PRIMARY KEY (id);


--
-- Name: impressions_8e2ff6b impressions_8e2ff6b_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_8e2ff6b
    ADD CONSTRAINT impressions_8e2ff6b_pkey PRIMARY KEY (id);


--
-- Name: impressions_9025cbb impressions_9025cbb_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_9025cbb
    ADD CONSTRAINT impressions_9025cbb_pkey PRIMARY KEY (id);


--
-- Name: impressions_90d9302 impressions_90d9302_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_90d9302
    ADD CONSTRAINT impressions_90d9302_pkey PRIMARY KEY (id);


--
-- Name: impressions_9257c9d impressions_9257c9d_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_9257c9d
    ADD CONSTRAINT impressions_9257c9d_pkey PRIMARY KEY (id);


--
-- Name: impressions_93d7d18 impressions_93d7d18_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_93d7d18
    ADD CONSTRAINT impressions_93d7d18_pkey PRIMARY KEY (id);


--
-- Name: impressions_94f0a87 impressions_94f0a87_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_94f0a87
    ADD CONSTRAINT impressions_94f0a87_pkey PRIMARY KEY (id);


--
-- Name: impressions_95c00de impressions_95c00de_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_95c00de
    ADD CONSTRAINT impressions_95c00de_pkey PRIMARY KEY (id);


--
-- Name: impressions_95f5aed impressions_95f5aed_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_95f5aed
    ADD CONSTRAINT impressions_95f5aed_pkey PRIMARY KEY (id);


--
-- Name: impressions_977ed92 impressions_977ed92_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_977ed92
    ADD CONSTRAINT impressions_977ed92_pkey PRIMARY KEY (id);


--
-- Name: impressions_99bd6ac impressions_99bd6ac_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_99bd6ac
    ADD CONSTRAINT impressions_99bd6ac_pkey PRIMARY KEY (id);


--
-- Name: impressions_9d02901 impressions_9d02901_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_9d02901
    ADD CONSTRAINT impressions_9d02901_pkey PRIMARY KEY (id);


--
-- Name: impressions_a5b36a9 impressions_a5b36a9_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_a5b36a9
    ADD CONSTRAINT impressions_a5b36a9_pkey PRIMARY KEY (id);


--
-- Name: impressions_a5d876d impressions_a5d876d_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_a5d876d
    ADD CONSTRAINT impressions_a5d876d_pkey PRIMARY KEY (id);


--
-- Name: impressions_a6e5a50 impressions_a6e5a50_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_a6e5a50
    ADD CONSTRAINT impressions_a6e5a50_pkey PRIMARY KEY (id);


--
-- Name: impressions_a7f178b impressions_a7f178b_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_a7f178b
    ADD CONSTRAINT impressions_a7f178b_pkey PRIMARY KEY (id);


--
-- Name: impressions_accf3ae impressions_accf3ae_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_accf3ae
    ADD CONSTRAINT impressions_accf3ae_pkey PRIMARY KEY (id);


--
-- Name: impressions_ad1667d impressions_ad1667d_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_ad1667d
    ADD CONSTRAINT impressions_ad1667d_pkey PRIMARY KEY (id);


--
-- Name: impressions_adab992 impressions_adab992_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_adab992
    ADD CONSTRAINT impressions_adab992_pkey PRIMARY KEY (id);


--
-- Name: impressions_af29709 impressions_af29709_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_af29709
    ADD CONSTRAINT impressions_af29709_pkey PRIMARY KEY (id);


--
-- Name: impressions_b30c5f4 impressions_b30c5f4_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_b30c5f4
    ADD CONSTRAINT impressions_b30c5f4_pkey PRIMARY KEY (id);


--
-- Name: impressions_b8b32d6 impressions_b8b32d6_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_b8b32d6
    ADD CONSTRAINT impressions_b8b32d6_pkey PRIMARY KEY (id);


--
-- Name: impressions_b9feea5 impressions_b9feea5_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_b9feea5
    ADD CONSTRAINT impressions_b9feea5_pkey PRIMARY KEY (id);


--
-- Name: impressions_bc32520 impressions_bc32520_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_bc32520
    ADD CONSTRAINT impressions_bc32520_pkey PRIMARY KEY (id);


--
-- Name: impressions_be31132 impressions_be31132_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_be31132
    ADD CONSTRAINT impressions_be31132_pkey PRIMARY KEY (id);


--
-- Name: impressions_c14ec8a impressions_c14ec8a_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_c14ec8a
    ADD CONSTRAINT impressions_c14ec8a_pkey PRIMARY KEY (id);


--
-- Name: impressions_c3037b2 impressions_c3037b2_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_c3037b2
    ADD CONSTRAINT impressions_c3037b2_pkey PRIMARY KEY (id);


--
-- Name: impressions_c4350d3 impressions_c4350d3_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_c4350d3
    ADD CONSTRAINT impressions_c4350d3_pkey PRIMARY KEY (id);


--
-- Name: impressions_c9cb65e impressions_c9cb65e_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_c9cb65e
    ADD CONSTRAINT impressions_c9cb65e_pkey PRIMARY KEY (id);


--
-- Name: impressions_cb5be27 impressions_cb5be27_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_cb5be27
    ADD CONSTRAINT impressions_cb5be27_pkey PRIMARY KEY (id);


--
-- Name: impressions_cc3bbc2 impressions_cc3bbc2_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_cc3bbc2
    ADD CONSTRAINT impressions_cc3bbc2_pkey PRIMARY KEY (id);


--
-- Name: impressions_ccfc39a impressions_ccfc39a_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_ccfc39a
    ADD CONSTRAINT impressions_ccfc39a_pkey PRIMARY KEY (id);


--
-- Name: impressions_d072121 impressions_d072121_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_d072121
    ADD CONSTRAINT impressions_d072121_pkey PRIMARY KEY (id);


--
-- Name: impressions_d2b5f35 impressions_d2b5f35_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_d2b5f35
    ADD CONSTRAINT impressions_d2b5f35_pkey PRIMARY KEY (id);


--
-- Name: impressions_d500d91 impressions_d500d91_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_d500d91
    ADD CONSTRAINT impressions_d500d91_pkey PRIMARY KEY (id);


--
-- Name: impressions_d801546 impressions_d801546_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_d801546
    ADD CONSTRAINT impressions_d801546_pkey PRIMARY KEY (id);


--
-- Name: impressions_d9f318d impressions_d9f318d_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_d9f318d
    ADD CONSTRAINT impressions_d9f318d_pkey PRIMARY KEY (id);


--
-- Name: impressions_db5c100 impressions_db5c100_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_db5c100
    ADD CONSTRAINT impressions_db5c100_pkey PRIMARY KEY (id);


--
-- Name: impressions_dbfada5 impressions_dbfada5_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_dbfada5
    ADD CONSTRAINT impressions_dbfada5_pkey PRIMARY KEY (id);


--
-- Name: impressions_dcfa592 impressions_dcfa592_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_dcfa592
    ADD CONSTRAINT impressions_dcfa592_pkey PRIMARY KEY (id);


--
-- Name: impressions_e0da3fd impressions_e0da3fd_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_e0da3fd
    ADD CONSTRAINT impressions_e0da3fd_pkey PRIMARY KEY (id);


--
-- Name: impressions_e6bd22d impressions_e6bd22d_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_e6bd22d
    ADD CONSTRAINT impressions_e6bd22d_pkey PRIMARY KEY (id);


--
-- Name: impressions_e7cdbb8 impressions_e7cdbb8_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_e7cdbb8
    ADD CONSTRAINT impressions_e7cdbb8_pkey PRIMARY KEY (id);


--
-- Name: impressions_e7f326c impressions_e7f326c_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_e7f326c
    ADD CONSTRAINT impressions_e7f326c_pkey PRIMARY KEY (id);


--
-- Name: impressions_e942689 impressions_e942689_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_e942689
    ADD CONSTRAINT impressions_e942689_pkey PRIMARY KEY (id);


--
-- Name: impressions_eb6cfa6 impressions_eb6cfa6_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_eb6cfa6
    ADD CONSTRAINT impressions_eb6cfa6_pkey PRIMARY KEY (id);


--
-- Name: impressions_ec2dc1e impressions_ec2dc1e_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_ec2dc1e
    ADD CONSTRAINT impressions_ec2dc1e_pkey PRIMARY KEY (id);


--
-- Name: impressions_efc15cd impressions_efc15cd_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_efc15cd
    ADD CONSTRAINT impressions_efc15cd_pkey PRIMARY KEY (id);


--
-- Name: impressions_f03d063 impressions_f03d063_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f03d063
    ADD CONSTRAINT impressions_f03d063_pkey PRIMARY KEY (id);


--
-- Name: impressions_f1cbe01 impressions_f1cbe01_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f1cbe01
    ADD CONSTRAINT impressions_f1cbe01_pkey PRIMARY KEY (id);


--
-- Name: impressions_f2d2cd3 impressions_f2d2cd3_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f2d2cd3
    ADD CONSTRAINT impressions_f2d2cd3_pkey PRIMARY KEY (id);


--
-- Name: impressions_f2f396a impressions_f2f396a_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f2f396a
    ADD CONSTRAINT impressions_f2f396a_pkey PRIMARY KEY (id);


--
-- Name: impressions_f5a1145 impressions_f5a1145_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f5a1145
    ADD CONSTRAINT impressions_f5a1145_pkey PRIMARY KEY (id);


--
-- Name: impressions_f66d3ce impressions_f66d3ce_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_f66d3ce
    ADD CONSTRAINT impressions_f66d3ce_pkey PRIMARY KEY (id);


--
-- Name: impressions_fbcea0f impressions_fbcea0f_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_fbcea0f
    ADD CONSTRAINT impressions_fbcea0f_pkey PRIMARY KEY (id);


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
-- Name: index_impressions_008f8c2_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_008f8c2_on_campaign_id ON public.impressions_008f8c2 USING btree (campaign_id);


--
-- Name: index_impressions_008f8c2_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_008f8c2_on_displayed_at_date ON public.impressions_008f8c2 USING btree (displayed_at_date);


--
-- Name: index_impressions_008f8c2_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_008f8c2_on_displayed_at_hour ON public.impressions_008f8c2 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_008f8c2_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_008f8c2_on_payable ON public.impressions_008f8c2 USING btree (payable);


--
-- Name: index_impressions_008f8c2_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_008f8c2_on_property_id ON public.impressions_008f8c2 USING btree (property_id);


--
-- Name: index_impressions_00afa31_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_00afa31_on_campaign_id ON public.impressions_00afa31 USING btree (campaign_id);


--
-- Name: index_impressions_00afa31_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_00afa31_on_displayed_at_date ON public.impressions_00afa31 USING btree (displayed_at_date);


--
-- Name: index_impressions_00afa31_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_00afa31_on_displayed_at_hour ON public.impressions_00afa31 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_00afa31_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_00afa31_on_payable ON public.impressions_00afa31 USING btree (payable);


--
-- Name: index_impressions_00afa31_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_00afa31_on_property_id ON public.impressions_00afa31 USING btree (property_id);


--
-- Name: index_impressions_0281a27_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0281a27_on_campaign_id ON public.impressions_0281a27 USING btree (campaign_id);


--
-- Name: index_impressions_0281a27_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0281a27_on_displayed_at_date ON public.impressions_0281a27 USING btree (displayed_at_date);


--
-- Name: index_impressions_0281a27_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0281a27_on_displayed_at_hour ON public.impressions_0281a27 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_0281a27_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0281a27_on_payable ON public.impressions_0281a27 USING btree (payable);


--
-- Name: index_impressions_0281a27_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0281a27_on_property_id ON public.impressions_0281a27 USING btree (property_id);


--
-- Name: index_impressions_081c4ce_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_081c4ce_on_campaign_id ON public.impressions_081c4ce USING btree (campaign_id);


--
-- Name: index_impressions_081c4ce_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_081c4ce_on_displayed_at_date ON public.impressions_081c4ce USING btree (displayed_at_date);


--
-- Name: index_impressions_081c4ce_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_081c4ce_on_displayed_at_hour ON public.impressions_081c4ce USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_081c4ce_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_081c4ce_on_payable ON public.impressions_081c4ce USING btree (payable);


--
-- Name: index_impressions_081c4ce_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_081c4ce_on_property_id ON public.impressions_081c4ce USING btree (property_id);


--
-- Name: index_impressions_0947ece_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0947ece_on_campaign_id ON public.impressions_0947ece USING btree (campaign_id);


--
-- Name: index_impressions_0947ece_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0947ece_on_displayed_at_date ON public.impressions_0947ece USING btree (displayed_at_date);


--
-- Name: index_impressions_0947ece_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0947ece_on_displayed_at_hour ON public.impressions_0947ece USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_0947ece_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0947ece_on_payable ON public.impressions_0947ece USING btree (payable);


--
-- Name: index_impressions_0947ece_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0947ece_on_property_id ON public.impressions_0947ece USING btree (property_id);


--
-- Name: index_impressions_0a989dc_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0a989dc_on_campaign_id ON public.impressions_0a989dc USING btree (campaign_id);


--
-- Name: index_impressions_0a989dc_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0a989dc_on_displayed_at_date ON public.impressions_0a989dc USING btree (displayed_at_date);


--
-- Name: index_impressions_0a989dc_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0a989dc_on_displayed_at_hour ON public.impressions_0a989dc USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_0a989dc_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0a989dc_on_payable ON public.impressions_0a989dc USING btree (payable);


--
-- Name: index_impressions_0a989dc_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0a989dc_on_property_id ON public.impressions_0a989dc USING btree (property_id);


--
-- Name: index_impressions_0ae566a_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0ae566a_on_campaign_id ON public.impressions_0ae566a USING btree (campaign_id);


--
-- Name: index_impressions_0ae566a_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0ae566a_on_displayed_at_date ON public.impressions_0ae566a USING btree (displayed_at_date);


--
-- Name: index_impressions_0ae566a_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0ae566a_on_displayed_at_hour ON public.impressions_0ae566a USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_0ae566a_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0ae566a_on_payable ON public.impressions_0ae566a USING btree (payable);


--
-- Name: index_impressions_0ae566a_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0ae566a_on_property_id ON public.impressions_0ae566a USING btree (property_id);


--
-- Name: index_impressions_0bf3fae_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0bf3fae_on_campaign_id ON public.impressions_0bf3fae USING btree (campaign_id);


--
-- Name: index_impressions_0bf3fae_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0bf3fae_on_displayed_at_date ON public.impressions_0bf3fae USING btree (displayed_at_date);


--
-- Name: index_impressions_0bf3fae_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0bf3fae_on_displayed_at_hour ON public.impressions_0bf3fae USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_0bf3fae_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0bf3fae_on_payable ON public.impressions_0bf3fae USING btree (payable);


--
-- Name: index_impressions_0bf3fae_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0bf3fae_on_property_id ON public.impressions_0bf3fae USING btree (property_id);


--
-- Name: index_impressions_0fbc017_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0fbc017_on_campaign_id ON public.impressions_0fbc017 USING btree (campaign_id);


--
-- Name: index_impressions_0fbc017_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0fbc017_on_displayed_at_date ON public.impressions_0fbc017 USING btree (displayed_at_date);


--
-- Name: index_impressions_0fbc017_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0fbc017_on_displayed_at_hour ON public.impressions_0fbc017 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_0fbc017_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0fbc017_on_payable ON public.impressions_0fbc017 USING btree (payable);


--
-- Name: index_impressions_0fbc017_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_0fbc017_on_property_id ON public.impressions_0fbc017 USING btree (property_id);


--
-- Name: index_impressions_132f3f5_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_132f3f5_on_campaign_id ON public.impressions_132f3f5 USING btree (campaign_id);


--
-- Name: index_impressions_132f3f5_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_132f3f5_on_displayed_at_date ON public.impressions_132f3f5 USING btree (displayed_at_date);


--
-- Name: index_impressions_132f3f5_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_132f3f5_on_displayed_at_hour ON public.impressions_132f3f5 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_132f3f5_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_132f3f5_on_payable ON public.impressions_132f3f5 USING btree (payable);


--
-- Name: index_impressions_132f3f5_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_132f3f5_on_property_id ON public.impressions_132f3f5 USING btree (property_id);


--
-- Name: index_impressions_155e200_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_155e200_on_campaign_id ON public.impressions_155e200 USING btree (campaign_id);


--
-- Name: index_impressions_155e200_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_155e200_on_displayed_at_date ON public.impressions_155e200 USING btree (displayed_at_date);


--
-- Name: index_impressions_155e200_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_155e200_on_displayed_at_hour ON public.impressions_155e200 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_155e200_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_155e200_on_payable ON public.impressions_155e200 USING btree (payable);


--
-- Name: index_impressions_155e200_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_155e200_on_property_id ON public.impressions_155e200 USING btree (property_id);


--
-- Name: index_impressions_1c56374_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_1c56374_on_campaign_id ON public.impressions_1c56374 USING btree (campaign_id);


--
-- Name: index_impressions_1c56374_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_1c56374_on_displayed_at_date ON public.impressions_1c56374 USING btree (displayed_at_date);


--
-- Name: index_impressions_1c56374_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_1c56374_on_displayed_at_hour ON public.impressions_1c56374 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_1c56374_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_1c56374_on_payable ON public.impressions_1c56374 USING btree (payable);


--
-- Name: index_impressions_1c56374_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_1c56374_on_property_id ON public.impressions_1c56374 USING btree (property_id);


--
-- Name: index_impressions_1e4146f_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_1e4146f_on_campaign_id ON public.impressions_1e4146f USING btree (campaign_id);


--
-- Name: index_impressions_1e4146f_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_1e4146f_on_displayed_at_date ON public.impressions_1e4146f USING btree (displayed_at_date);


--
-- Name: index_impressions_1e4146f_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_1e4146f_on_displayed_at_hour ON public.impressions_1e4146f USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_1e4146f_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_1e4146f_on_payable ON public.impressions_1e4146f USING btree (payable);


--
-- Name: index_impressions_1e4146f_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_1e4146f_on_property_id ON public.impressions_1e4146f USING btree (property_id);


--
-- Name: index_impressions_26d04a3_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_26d04a3_on_campaign_id ON public.impressions_26d04a3 USING btree (campaign_id);


--
-- Name: index_impressions_26d04a3_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_26d04a3_on_displayed_at_date ON public.impressions_26d04a3 USING btree (displayed_at_date);


--
-- Name: index_impressions_26d04a3_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_26d04a3_on_displayed_at_hour ON public.impressions_26d04a3 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_26d04a3_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_26d04a3_on_payable ON public.impressions_26d04a3 USING btree (payable);


--
-- Name: index_impressions_26d04a3_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_26d04a3_on_property_id ON public.impressions_26d04a3 USING btree (property_id);


--
-- Name: index_impressions_27d985f_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_27d985f_on_campaign_id ON public.impressions_27d985f USING btree (campaign_id);


--
-- Name: index_impressions_27d985f_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_27d985f_on_displayed_at_date ON public.impressions_27d985f USING btree (displayed_at_date);


--
-- Name: index_impressions_27d985f_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_27d985f_on_displayed_at_hour ON public.impressions_27d985f USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_27d985f_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_27d985f_on_payable ON public.impressions_27d985f USING btree (payable);


--
-- Name: index_impressions_27d985f_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_27d985f_on_property_id ON public.impressions_27d985f USING btree (property_id);


--
-- Name: index_impressions_299ed5e_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_299ed5e_on_campaign_id ON public.impressions_299ed5e USING btree (campaign_id);


--
-- Name: index_impressions_299ed5e_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_299ed5e_on_displayed_at_date ON public.impressions_299ed5e USING btree (displayed_at_date);


--
-- Name: index_impressions_299ed5e_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_299ed5e_on_displayed_at_hour ON public.impressions_299ed5e USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_299ed5e_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_299ed5e_on_payable ON public.impressions_299ed5e USING btree (payable);


--
-- Name: index_impressions_299ed5e_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_299ed5e_on_property_id ON public.impressions_299ed5e USING btree (property_id);


--
-- Name: index_impressions_2da957d_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2da957d_on_campaign_id ON public.impressions_2da957d USING btree (campaign_id);


--
-- Name: index_impressions_2da957d_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2da957d_on_displayed_at_date ON public.impressions_2da957d USING btree (displayed_at_date);


--
-- Name: index_impressions_2da957d_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2da957d_on_displayed_at_hour ON public.impressions_2da957d USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2da957d_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2da957d_on_payable ON public.impressions_2da957d USING btree (payable);


--
-- Name: index_impressions_2da957d_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2da957d_on_property_id ON public.impressions_2da957d USING btree (property_id);


--
-- Name: index_impressions_2ddf121_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2ddf121_on_campaign_id ON public.impressions_2ddf121 USING btree (campaign_id);


--
-- Name: index_impressions_2ddf121_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2ddf121_on_displayed_at_date ON public.impressions_2ddf121 USING btree (displayed_at_date);


--
-- Name: index_impressions_2ddf121_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2ddf121_on_displayed_at_hour ON public.impressions_2ddf121 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2ddf121_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2ddf121_on_payable ON public.impressions_2ddf121 USING btree (payable);


--
-- Name: index_impressions_2ddf121_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2ddf121_on_property_id ON public.impressions_2ddf121 USING btree (property_id);


--
-- Name: index_impressions_2ede6f8_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2ede6f8_on_campaign_id ON public.impressions_2ede6f8 USING btree (campaign_id);


--
-- Name: index_impressions_2ede6f8_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2ede6f8_on_displayed_at_date ON public.impressions_2ede6f8 USING btree (displayed_at_date);


--
-- Name: index_impressions_2ede6f8_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2ede6f8_on_displayed_at_hour ON public.impressions_2ede6f8 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_2ede6f8_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2ede6f8_on_payable ON public.impressions_2ede6f8 USING btree (payable);


--
-- Name: index_impressions_2ede6f8_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_2ede6f8_on_property_id ON public.impressions_2ede6f8 USING btree (property_id);


--
-- Name: index_impressions_318d9ee_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_318d9ee_on_campaign_id ON public.impressions_318d9ee USING btree (campaign_id);


--
-- Name: index_impressions_318d9ee_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_318d9ee_on_displayed_at_date ON public.impressions_318d9ee USING btree (displayed_at_date);


--
-- Name: index_impressions_318d9ee_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_318d9ee_on_displayed_at_hour ON public.impressions_318d9ee USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_318d9ee_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_318d9ee_on_payable ON public.impressions_318d9ee USING btree (payable);


--
-- Name: index_impressions_318d9ee_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_318d9ee_on_property_id ON public.impressions_318d9ee USING btree (property_id);


--
-- Name: index_impressions_33e0986_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_33e0986_on_campaign_id ON public.impressions_33e0986 USING btree (campaign_id);


--
-- Name: index_impressions_33e0986_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_33e0986_on_displayed_at_date ON public.impressions_33e0986 USING btree (displayed_at_date);


--
-- Name: index_impressions_33e0986_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_33e0986_on_displayed_at_hour ON public.impressions_33e0986 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_33e0986_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_33e0986_on_payable ON public.impressions_33e0986 USING btree (payable);


--
-- Name: index_impressions_33e0986_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_33e0986_on_property_id ON public.impressions_33e0986 USING btree (property_id);


--
-- Name: index_impressions_36cd868_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_36cd868_on_campaign_id ON public.impressions_36cd868 USING btree (campaign_id);


--
-- Name: index_impressions_36cd868_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_36cd868_on_displayed_at_date ON public.impressions_36cd868 USING btree (displayed_at_date);


--
-- Name: index_impressions_36cd868_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_36cd868_on_displayed_at_hour ON public.impressions_36cd868 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_36cd868_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_36cd868_on_payable ON public.impressions_36cd868 USING btree (payable);


--
-- Name: index_impressions_36cd868_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_36cd868_on_property_id ON public.impressions_36cd868 USING btree (property_id);


--
-- Name: index_impressions_3b83f44_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3b83f44_on_campaign_id ON public.impressions_3b83f44 USING btree (campaign_id);


--
-- Name: index_impressions_3b83f44_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3b83f44_on_displayed_at_date ON public.impressions_3b83f44 USING btree (displayed_at_date);


--
-- Name: index_impressions_3b83f44_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3b83f44_on_displayed_at_hour ON public.impressions_3b83f44 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_3b83f44_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3b83f44_on_payable ON public.impressions_3b83f44 USING btree (payable);


--
-- Name: index_impressions_3b83f44_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3b83f44_on_property_id ON public.impressions_3b83f44 USING btree (property_id);


--
-- Name: index_impressions_3bb672d_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3bb672d_on_campaign_id ON public.impressions_3bb672d USING btree (campaign_id);


--
-- Name: index_impressions_3bb672d_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3bb672d_on_displayed_at_date ON public.impressions_3bb672d USING btree (displayed_at_date);


--
-- Name: index_impressions_3bb672d_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3bb672d_on_displayed_at_hour ON public.impressions_3bb672d USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_3bb672d_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3bb672d_on_payable ON public.impressions_3bb672d USING btree (payable);


--
-- Name: index_impressions_3bb672d_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3bb672d_on_property_id ON public.impressions_3bb672d USING btree (property_id);


--
-- Name: index_impressions_3c19367_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3c19367_on_campaign_id ON public.impressions_3c19367 USING btree (campaign_id);


--
-- Name: index_impressions_3c19367_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3c19367_on_displayed_at_date ON public.impressions_3c19367 USING btree (displayed_at_date);


--
-- Name: index_impressions_3c19367_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3c19367_on_displayed_at_hour ON public.impressions_3c19367 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_3c19367_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3c19367_on_payable ON public.impressions_3c19367 USING btree (payable);


--
-- Name: index_impressions_3c19367_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3c19367_on_property_id ON public.impressions_3c19367 USING btree (property_id);


--
-- Name: index_impressions_3d6d9e3_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3d6d9e3_on_campaign_id ON public.impressions_3d6d9e3 USING btree (campaign_id);


--
-- Name: index_impressions_3d6d9e3_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3d6d9e3_on_displayed_at_date ON public.impressions_3d6d9e3 USING btree (displayed_at_date);


--
-- Name: index_impressions_3d6d9e3_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3d6d9e3_on_displayed_at_hour ON public.impressions_3d6d9e3 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_3d6d9e3_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3d6d9e3_on_payable ON public.impressions_3d6d9e3 USING btree (payable);


--
-- Name: index_impressions_3d6d9e3_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3d6d9e3_on_property_id ON public.impressions_3d6d9e3 USING btree (property_id);


--
-- Name: index_impressions_3ed5b0d_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3ed5b0d_on_campaign_id ON public.impressions_3ed5b0d USING btree (campaign_id);


--
-- Name: index_impressions_3ed5b0d_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3ed5b0d_on_displayed_at_date ON public.impressions_3ed5b0d USING btree (displayed_at_date);


--
-- Name: index_impressions_3ed5b0d_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3ed5b0d_on_displayed_at_hour ON public.impressions_3ed5b0d USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_3ed5b0d_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3ed5b0d_on_payable ON public.impressions_3ed5b0d USING btree (payable);


--
-- Name: index_impressions_3ed5b0d_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_3ed5b0d_on_property_id ON public.impressions_3ed5b0d USING btree (property_id);


--
-- Name: index_impressions_40d9aec_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_40d9aec_on_campaign_id ON public.impressions_40d9aec USING btree (campaign_id);


--
-- Name: index_impressions_40d9aec_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_40d9aec_on_displayed_at_date ON public.impressions_40d9aec USING btree (displayed_at_date);


--
-- Name: index_impressions_40d9aec_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_40d9aec_on_displayed_at_hour ON public.impressions_40d9aec USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_40d9aec_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_40d9aec_on_payable ON public.impressions_40d9aec USING btree (payable);


--
-- Name: index_impressions_40d9aec_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_40d9aec_on_property_id ON public.impressions_40d9aec USING btree (property_id);


--
-- Name: index_impressions_42e511b_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_42e511b_on_campaign_id ON public.impressions_42e511b USING btree (campaign_id);


--
-- Name: index_impressions_42e511b_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_42e511b_on_displayed_at_date ON public.impressions_42e511b USING btree (displayed_at_date);


--
-- Name: index_impressions_42e511b_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_42e511b_on_displayed_at_hour ON public.impressions_42e511b USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_42e511b_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_42e511b_on_payable ON public.impressions_42e511b USING btree (payable);


--
-- Name: index_impressions_42e511b_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_42e511b_on_property_id ON public.impressions_42e511b USING btree (property_id);


--
-- Name: index_impressions_49c6760_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_49c6760_on_campaign_id ON public.impressions_49c6760 USING btree (campaign_id);


--
-- Name: index_impressions_49c6760_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_49c6760_on_displayed_at_date ON public.impressions_49c6760 USING btree (displayed_at_date);


--
-- Name: index_impressions_49c6760_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_49c6760_on_displayed_at_hour ON public.impressions_49c6760 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_49c6760_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_49c6760_on_payable ON public.impressions_49c6760 USING btree (payable);


--
-- Name: index_impressions_49c6760_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_49c6760_on_property_id ON public.impressions_49c6760 USING btree (property_id);


--
-- Name: index_impressions_4afe466_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_4afe466_on_campaign_id ON public.impressions_4afe466 USING btree (campaign_id);


--
-- Name: index_impressions_4afe466_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_4afe466_on_displayed_at_date ON public.impressions_4afe466 USING btree (displayed_at_date);


--
-- Name: index_impressions_4afe466_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_4afe466_on_displayed_at_hour ON public.impressions_4afe466 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_4afe466_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_4afe466_on_payable ON public.impressions_4afe466 USING btree (payable);


--
-- Name: index_impressions_4afe466_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_4afe466_on_property_id ON public.impressions_4afe466 USING btree (property_id);


--
-- Name: index_impressions_4dd4269_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_4dd4269_on_campaign_id ON public.impressions_4dd4269 USING btree (campaign_id);


--
-- Name: index_impressions_4dd4269_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_4dd4269_on_displayed_at_date ON public.impressions_4dd4269 USING btree (displayed_at_date);


--
-- Name: index_impressions_4dd4269_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_4dd4269_on_displayed_at_hour ON public.impressions_4dd4269 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_4dd4269_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_4dd4269_on_payable ON public.impressions_4dd4269 USING btree (payable);


--
-- Name: index_impressions_4dd4269_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_4dd4269_on_property_id ON public.impressions_4dd4269 USING btree (property_id);


--
-- Name: index_impressions_4ef837c_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_4ef837c_on_campaign_id ON public.impressions_4ef837c USING btree (campaign_id);


--
-- Name: index_impressions_4ef837c_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_4ef837c_on_displayed_at_date ON public.impressions_4ef837c USING btree (displayed_at_date);


--
-- Name: index_impressions_4ef837c_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_4ef837c_on_displayed_at_hour ON public.impressions_4ef837c USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_4ef837c_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_4ef837c_on_payable ON public.impressions_4ef837c USING btree (payable);


--
-- Name: index_impressions_4ef837c_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_4ef837c_on_property_id ON public.impressions_4ef837c USING btree (property_id);


--
-- Name: index_impressions_4f55d86_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_4f55d86_on_campaign_id ON public.impressions_4f55d86 USING btree (campaign_id);


--
-- Name: index_impressions_4f55d86_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_4f55d86_on_displayed_at_date ON public.impressions_4f55d86 USING btree (displayed_at_date);


--
-- Name: index_impressions_4f55d86_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_4f55d86_on_displayed_at_hour ON public.impressions_4f55d86 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_4f55d86_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_4f55d86_on_payable ON public.impressions_4f55d86 USING btree (payable);


--
-- Name: index_impressions_4f55d86_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_4f55d86_on_property_id ON public.impressions_4f55d86 USING btree (property_id);


--
-- Name: index_impressions_51233a7_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_51233a7_on_campaign_id ON public.impressions_51233a7 USING btree (campaign_id);


--
-- Name: index_impressions_51233a7_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_51233a7_on_displayed_at_date ON public.impressions_51233a7 USING btree (displayed_at_date);


--
-- Name: index_impressions_51233a7_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_51233a7_on_displayed_at_hour ON public.impressions_51233a7 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_51233a7_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_51233a7_on_payable ON public.impressions_51233a7 USING btree (payable);


--
-- Name: index_impressions_51233a7_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_51233a7_on_property_id ON public.impressions_51233a7 USING btree (property_id);


--
-- Name: index_impressions_522745d_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_522745d_on_campaign_id ON public.impressions_522745d USING btree (campaign_id);


--
-- Name: index_impressions_522745d_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_522745d_on_displayed_at_date ON public.impressions_522745d USING btree (displayed_at_date);


--
-- Name: index_impressions_522745d_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_522745d_on_displayed_at_hour ON public.impressions_522745d USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_522745d_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_522745d_on_payable ON public.impressions_522745d USING btree (payable);


--
-- Name: index_impressions_522745d_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_522745d_on_property_id ON public.impressions_522745d USING btree (property_id);


--
-- Name: index_impressions_548979a_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_548979a_on_campaign_id ON public.impressions_548979a USING btree (campaign_id);


--
-- Name: index_impressions_548979a_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_548979a_on_displayed_at_date ON public.impressions_548979a USING btree (displayed_at_date);


--
-- Name: index_impressions_548979a_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_548979a_on_displayed_at_hour ON public.impressions_548979a USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_548979a_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_548979a_on_payable ON public.impressions_548979a USING btree (payable);


--
-- Name: index_impressions_548979a_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_548979a_on_property_id ON public.impressions_548979a USING btree (property_id);


--
-- Name: index_impressions_5576a2c_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5576a2c_on_campaign_id ON public.impressions_5576a2c USING btree (campaign_id);


--
-- Name: index_impressions_5576a2c_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5576a2c_on_displayed_at_date ON public.impressions_5576a2c USING btree (displayed_at_date);


--
-- Name: index_impressions_5576a2c_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5576a2c_on_displayed_at_hour ON public.impressions_5576a2c USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_5576a2c_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5576a2c_on_payable ON public.impressions_5576a2c USING btree (payable);


--
-- Name: index_impressions_5576a2c_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5576a2c_on_property_id ON public.impressions_5576a2c USING btree (property_id);


--
-- Name: index_impressions_579ba19_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_579ba19_on_campaign_id ON public.impressions_579ba19 USING btree (campaign_id);


--
-- Name: index_impressions_579ba19_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_579ba19_on_displayed_at_date ON public.impressions_579ba19 USING btree (displayed_at_date);


--
-- Name: index_impressions_579ba19_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_579ba19_on_displayed_at_hour ON public.impressions_579ba19 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_579ba19_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_579ba19_on_payable ON public.impressions_579ba19 USING btree (payable);


--
-- Name: index_impressions_579ba19_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_579ba19_on_property_id ON public.impressions_579ba19 USING btree (property_id);


--
-- Name: index_impressions_591d6f9_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_591d6f9_on_campaign_id ON public.impressions_591d6f9 USING btree (campaign_id);


--
-- Name: index_impressions_591d6f9_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_591d6f9_on_displayed_at_date ON public.impressions_591d6f9 USING btree (displayed_at_date);


--
-- Name: index_impressions_591d6f9_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_591d6f9_on_displayed_at_hour ON public.impressions_591d6f9 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_591d6f9_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_591d6f9_on_payable ON public.impressions_591d6f9 USING btree (payable);


--
-- Name: index_impressions_591d6f9_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_591d6f9_on_property_id ON public.impressions_591d6f9 USING btree (property_id);


--
-- Name: index_impressions_5ad7ce6_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5ad7ce6_on_campaign_id ON public.impressions_5ad7ce6 USING btree (campaign_id);


--
-- Name: index_impressions_5ad7ce6_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5ad7ce6_on_displayed_at_date ON public.impressions_5ad7ce6 USING btree (displayed_at_date);


--
-- Name: index_impressions_5ad7ce6_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5ad7ce6_on_displayed_at_hour ON public.impressions_5ad7ce6 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_5ad7ce6_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5ad7ce6_on_payable ON public.impressions_5ad7ce6 USING btree (payable);


--
-- Name: index_impressions_5ad7ce6_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5ad7ce6_on_property_id ON public.impressions_5ad7ce6 USING btree (property_id);


--
-- Name: index_impressions_5b275aa_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5b275aa_on_campaign_id ON public.impressions_5b275aa USING btree (campaign_id);


--
-- Name: index_impressions_5b275aa_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5b275aa_on_displayed_at_date ON public.impressions_5b275aa USING btree (displayed_at_date);


--
-- Name: index_impressions_5b275aa_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5b275aa_on_displayed_at_hour ON public.impressions_5b275aa USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_5b275aa_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5b275aa_on_payable ON public.impressions_5b275aa USING btree (payable);


--
-- Name: index_impressions_5b275aa_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5b275aa_on_property_id ON public.impressions_5b275aa USING btree (property_id);


--
-- Name: index_impressions_5c24c1f_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5c24c1f_on_campaign_id ON public.impressions_5c24c1f USING btree (campaign_id);


--
-- Name: index_impressions_5c24c1f_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5c24c1f_on_displayed_at_date ON public.impressions_5c24c1f USING btree (displayed_at_date);


--
-- Name: index_impressions_5c24c1f_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5c24c1f_on_displayed_at_hour ON public.impressions_5c24c1f USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_5c24c1f_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5c24c1f_on_payable ON public.impressions_5c24c1f USING btree (payable);


--
-- Name: index_impressions_5c24c1f_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5c24c1f_on_property_id ON public.impressions_5c24c1f USING btree (property_id);


--
-- Name: index_impressions_5e64735_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5e64735_on_campaign_id ON public.impressions_5e64735 USING btree (campaign_id);


--
-- Name: index_impressions_5e64735_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5e64735_on_displayed_at_date ON public.impressions_5e64735 USING btree (displayed_at_date);


--
-- Name: index_impressions_5e64735_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5e64735_on_displayed_at_hour ON public.impressions_5e64735 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_5e64735_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5e64735_on_payable ON public.impressions_5e64735 USING btree (payable);


--
-- Name: index_impressions_5e64735_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_5e64735_on_property_id ON public.impressions_5e64735 USING btree (property_id);


--
-- Name: index_impressions_6025363_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_6025363_on_campaign_id ON public.impressions_6025363 USING btree (campaign_id);


--
-- Name: index_impressions_6025363_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_6025363_on_displayed_at_date ON public.impressions_6025363 USING btree (displayed_at_date);


--
-- Name: index_impressions_6025363_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_6025363_on_displayed_at_hour ON public.impressions_6025363 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_6025363_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_6025363_on_payable ON public.impressions_6025363 USING btree (payable);


--
-- Name: index_impressions_6025363_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_6025363_on_property_id ON public.impressions_6025363 USING btree (property_id);


--
-- Name: index_impressions_6707fb6_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_6707fb6_on_campaign_id ON public.impressions_6707fb6 USING btree (campaign_id);


--
-- Name: index_impressions_6707fb6_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_6707fb6_on_displayed_at_date ON public.impressions_6707fb6 USING btree (displayed_at_date);


--
-- Name: index_impressions_6707fb6_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_6707fb6_on_displayed_at_hour ON public.impressions_6707fb6 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_6707fb6_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_6707fb6_on_payable ON public.impressions_6707fb6 USING btree (payable);


--
-- Name: index_impressions_6707fb6_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_6707fb6_on_property_id ON public.impressions_6707fb6 USING btree (property_id);


--
-- Name: index_impressions_67312bc_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_67312bc_on_campaign_id ON public.impressions_67312bc USING btree (campaign_id);


--
-- Name: index_impressions_67312bc_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_67312bc_on_displayed_at_date ON public.impressions_67312bc USING btree (displayed_at_date);


--
-- Name: index_impressions_67312bc_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_67312bc_on_displayed_at_hour ON public.impressions_67312bc USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_67312bc_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_67312bc_on_payable ON public.impressions_67312bc USING btree (payable);


--
-- Name: index_impressions_67312bc_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_67312bc_on_property_id ON public.impressions_67312bc USING btree (property_id);


--
-- Name: index_impressions_6917f25_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_6917f25_on_campaign_id ON public.impressions_6917f25 USING btree (campaign_id);


--
-- Name: index_impressions_6917f25_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_6917f25_on_displayed_at_date ON public.impressions_6917f25 USING btree (displayed_at_date);


--
-- Name: index_impressions_6917f25_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_6917f25_on_displayed_at_hour ON public.impressions_6917f25 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_6917f25_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_6917f25_on_payable ON public.impressions_6917f25 USING btree (payable);


--
-- Name: index_impressions_6917f25_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_6917f25_on_property_id ON public.impressions_6917f25 USING btree (property_id);


--
-- Name: index_impressions_6e55f42_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_6e55f42_on_campaign_id ON public.impressions_6e55f42 USING btree (campaign_id);


--
-- Name: index_impressions_6e55f42_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_6e55f42_on_displayed_at_date ON public.impressions_6e55f42 USING btree (displayed_at_date);


--
-- Name: index_impressions_6e55f42_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_6e55f42_on_displayed_at_hour ON public.impressions_6e55f42 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_6e55f42_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_6e55f42_on_payable ON public.impressions_6e55f42 USING btree (payable);


--
-- Name: index_impressions_6e55f42_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_6e55f42_on_property_id ON public.impressions_6e55f42 USING btree (property_id);


--
-- Name: index_impressions_7056f65_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7056f65_on_campaign_id ON public.impressions_7056f65 USING btree (campaign_id);


--
-- Name: index_impressions_7056f65_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7056f65_on_displayed_at_date ON public.impressions_7056f65 USING btree (displayed_at_date);


--
-- Name: index_impressions_7056f65_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7056f65_on_displayed_at_hour ON public.impressions_7056f65 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_7056f65_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7056f65_on_payable ON public.impressions_7056f65 USING btree (payable);


--
-- Name: index_impressions_7056f65_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7056f65_on_property_id ON public.impressions_7056f65 USING btree (property_id);


--
-- Name: index_impressions_74c0c78_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_74c0c78_on_campaign_id ON public.impressions_74c0c78 USING btree (campaign_id);


--
-- Name: index_impressions_74c0c78_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_74c0c78_on_displayed_at_date ON public.impressions_74c0c78 USING btree (displayed_at_date);


--
-- Name: index_impressions_74c0c78_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_74c0c78_on_displayed_at_hour ON public.impressions_74c0c78 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_74c0c78_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_74c0c78_on_payable ON public.impressions_74c0c78 USING btree (payable);


--
-- Name: index_impressions_74c0c78_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_74c0c78_on_property_id ON public.impressions_74c0c78 USING btree (property_id);


--
-- Name: index_impressions_78e11c5_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_78e11c5_on_campaign_id ON public.impressions_78e11c5 USING btree (campaign_id);


--
-- Name: index_impressions_78e11c5_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_78e11c5_on_displayed_at_date ON public.impressions_78e11c5 USING btree (displayed_at_date);


--
-- Name: index_impressions_78e11c5_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_78e11c5_on_displayed_at_hour ON public.impressions_78e11c5 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_78e11c5_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_78e11c5_on_payable ON public.impressions_78e11c5 USING btree (payable);


--
-- Name: index_impressions_78e11c5_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_78e11c5_on_property_id ON public.impressions_78e11c5 USING btree (property_id);


--
-- Name: index_impressions_7b5e867_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7b5e867_on_campaign_id ON public.impressions_7b5e867 USING btree (campaign_id);


--
-- Name: index_impressions_7b5e867_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7b5e867_on_displayed_at_date ON public.impressions_7b5e867 USING btree (displayed_at_date);


--
-- Name: index_impressions_7b5e867_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7b5e867_on_displayed_at_hour ON public.impressions_7b5e867 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_7b5e867_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7b5e867_on_payable ON public.impressions_7b5e867 USING btree (payable);


--
-- Name: index_impressions_7b5e867_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7b5e867_on_property_id ON public.impressions_7b5e867 USING btree (property_id);


--
-- Name: index_impressions_7e8ebd6_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7e8ebd6_on_campaign_id ON public.impressions_7e8ebd6 USING btree (campaign_id);


--
-- Name: index_impressions_7e8ebd6_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7e8ebd6_on_displayed_at_date ON public.impressions_7e8ebd6 USING btree (displayed_at_date);


--
-- Name: index_impressions_7e8ebd6_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7e8ebd6_on_displayed_at_hour ON public.impressions_7e8ebd6 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_7e8ebd6_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7e8ebd6_on_payable ON public.impressions_7e8ebd6 USING btree (payable);


--
-- Name: index_impressions_7e8ebd6_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7e8ebd6_on_property_id ON public.impressions_7e8ebd6 USING btree (property_id);


--
-- Name: index_impressions_7ebab1d_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7ebab1d_on_campaign_id ON public.impressions_7ebab1d USING btree (campaign_id);


--
-- Name: index_impressions_7ebab1d_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7ebab1d_on_displayed_at_date ON public.impressions_7ebab1d USING btree (displayed_at_date);


--
-- Name: index_impressions_7ebab1d_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7ebab1d_on_displayed_at_hour ON public.impressions_7ebab1d USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_7ebab1d_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7ebab1d_on_payable ON public.impressions_7ebab1d USING btree (payable);


--
-- Name: index_impressions_7ebab1d_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7ebab1d_on_property_id ON public.impressions_7ebab1d USING btree (property_id);


--
-- Name: index_impressions_7f04b7c_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7f04b7c_on_campaign_id ON public.impressions_7f04b7c USING btree (campaign_id);


--
-- Name: index_impressions_7f04b7c_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7f04b7c_on_displayed_at_date ON public.impressions_7f04b7c USING btree (displayed_at_date);


--
-- Name: index_impressions_7f04b7c_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7f04b7c_on_displayed_at_hour ON public.impressions_7f04b7c USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_7f04b7c_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7f04b7c_on_payable ON public.impressions_7f04b7c USING btree (payable);


--
-- Name: index_impressions_7f04b7c_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7f04b7c_on_property_id ON public.impressions_7f04b7c USING btree (property_id);


--
-- Name: index_impressions_7f556bf_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7f556bf_on_campaign_id ON public.impressions_7f556bf USING btree (campaign_id);


--
-- Name: index_impressions_7f556bf_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7f556bf_on_displayed_at_date ON public.impressions_7f556bf USING btree (displayed_at_date);


--
-- Name: index_impressions_7f556bf_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7f556bf_on_displayed_at_hour ON public.impressions_7f556bf USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_7f556bf_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7f556bf_on_payable ON public.impressions_7f556bf USING btree (payable);


--
-- Name: index_impressions_7f556bf_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_7f556bf_on_property_id ON public.impressions_7f556bf USING btree (property_id);


--
-- Name: index_impressions_80a90da_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_80a90da_on_campaign_id ON public.impressions_80a90da USING btree (campaign_id);


--
-- Name: index_impressions_80a90da_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_80a90da_on_displayed_at_date ON public.impressions_80a90da USING btree (displayed_at_date);


--
-- Name: index_impressions_80a90da_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_80a90da_on_displayed_at_hour ON public.impressions_80a90da USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_80a90da_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_80a90da_on_payable ON public.impressions_80a90da USING btree (payable);


--
-- Name: index_impressions_80a90da_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_80a90da_on_property_id ON public.impressions_80a90da USING btree (property_id);


--
-- Name: index_impressions_8142edc_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8142edc_on_campaign_id ON public.impressions_8142edc USING btree (campaign_id);


--
-- Name: index_impressions_8142edc_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8142edc_on_displayed_at_date ON public.impressions_8142edc USING btree (displayed_at_date);


--
-- Name: index_impressions_8142edc_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8142edc_on_displayed_at_hour ON public.impressions_8142edc USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_8142edc_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8142edc_on_payable ON public.impressions_8142edc USING btree (payable);


--
-- Name: index_impressions_8142edc_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8142edc_on_property_id ON public.impressions_8142edc USING btree (property_id);


--
-- Name: index_impressions_8474984_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8474984_on_campaign_id ON public.impressions_8474984 USING btree (campaign_id);


--
-- Name: index_impressions_8474984_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8474984_on_displayed_at_date ON public.impressions_8474984 USING btree (displayed_at_date);


--
-- Name: index_impressions_8474984_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8474984_on_displayed_at_hour ON public.impressions_8474984 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_8474984_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8474984_on_payable ON public.impressions_8474984 USING btree (payable);


--
-- Name: index_impressions_8474984_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8474984_on_property_id ON public.impressions_8474984 USING btree (property_id);


--
-- Name: index_impressions_85f5e29_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_85f5e29_on_campaign_id ON public.impressions_85f5e29 USING btree (campaign_id);


--
-- Name: index_impressions_85f5e29_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_85f5e29_on_displayed_at_date ON public.impressions_85f5e29 USING btree (displayed_at_date);


--
-- Name: index_impressions_85f5e29_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_85f5e29_on_displayed_at_hour ON public.impressions_85f5e29 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_85f5e29_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_85f5e29_on_payable ON public.impressions_85f5e29 USING btree (payable);


--
-- Name: index_impressions_85f5e29_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_85f5e29_on_property_id ON public.impressions_85f5e29 USING btree (property_id);


--
-- Name: index_impressions_862d332_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_862d332_on_campaign_id ON public.impressions_862d332 USING btree (campaign_id);


--
-- Name: index_impressions_862d332_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_862d332_on_displayed_at_date ON public.impressions_862d332 USING btree (displayed_at_date);


--
-- Name: index_impressions_862d332_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_862d332_on_displayed_at_hour ON public.impressions_862d332 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_862d332_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_862d332_on_payable ON public.impressions_862d332 USING btree (payable);


--
-- Name: index_impressions_862d332_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_862d332_on_property_id ON public.impressions_862d332 USING btree (property_id);


--
-- Name: index_impressions_8894562_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8894562_on_campaign_id ON public.impressions_8894562 USING btree (campaign_id);


--
-- Name: index_impressions_8894562_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8894562_on_displayed_at_date ON public.impressions_8894562 USING btree (displayed_at_date);


--
-- Name: index_impressions_8894562_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8894562_on_displayed_at_hour ON public.impressions_8894562 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_8894562_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8894562_on_payable ON public.impressions_8894562 USING btree (payable);


--
-- Name: index_impressions_8894562_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8894562_on_property_id ON public.impressions_8894562 USING btree (property_id);


--
-- Name: index_impressions_8a205c2_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8a205c2_on_campaign_id ON public.impressions_8a205c2 USING btree (campaign_id);


--
-- Name: index_impressions_8a205c2_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8a205c2_on_displayed_at_date ON public.impressions_8a205c2 USING btree (displayed_at_date);


--
-- Name: index_impressions_8a205c2_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8a205c2_on_displayed_at_hour ON public.impressions_8a205c2 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_8a205c2_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8a205c2_on_payable ON public.impressions_8a205c2 USING btree (payable);


--
-- Name: index_impressions_8a205c2_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8a205c2_on_property_id ON public.impressions_8a205c2 USING btree (property_id);


--
-- Name: index_impressions_8c4dd57_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8c4dd57_on_campaign_id ON public.impressions_8c4dd57 USING btree (campaign_id);


--
-- Name: index_impressions_8c4dd57_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8c4dd57_on_displayed_at_date ON public.impressions_8c4dd57 USING btree (displayed_at_date);


--
-- Name: index_impressions_8c4dd57_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8c4dd57_on_displayed_at_hour ON public.impressions_8c4dd57 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_8c4dd57_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8c4dd57_on_payable ON public.impressions_8c4dd57 USING btree (payable);


--
-- Name: index_impressions_8c4dd57_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8c4dd57_on_property_id ON public.impressions_8c4dd57 USING btree (property_id);


--
-- Name: index_impressions_8cf9e1c_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8cf9e1c_on_campaign_id ON public.impressions_8cf9e1c USING btree (campaign_id);


--
-- Name: index_impressions_8cf9e1c_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8cf9e1c_on_displayed_at_date ON public.impressions_8cf9e1c USING btree (displayed_at_date);


--
-- Name: index_impressions_8cf9e1c_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8cf9e1c_on_displayed_at_hour ON public.impressions_8cf9e1c USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_8cf9e1c_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8cf9e1c_on_payable ON public.impressions_8cf9e1c USING btree (payable);


--
-- Name: index_impressions_8cf9e1c_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8cf9e1c_on_property_id ON public.impressions_8cf9e1c USING btree (property_id);


--
-- Name: index_impressions_8e2ff6b_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8e2ff6b_on_campaign_id ON public.impressions_8e2ff6b USING btree (campaign_id);


--
-- Name: index_impressions_8e2ff6b_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8e2ff6b_on_displayed_at_date ON public.impressions_8e2ff6b USING btree (displayed_at_date);


--
-- Name: index_impressions_8e2ff6b_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8e2ff6b_on_displayed_at_hour ON public.impressions_8e2ff6b USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_8e2ff6b_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8e2ff6b_on_payable ON public.impressions_8e2ff6b USING btree (payable);


--
-- Name: index_impressions_8e2ff6b_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_8e2ff6b_on_property_id ON public.impressions_8e2ff6b USING btree (property_id);


--
-- Name: index_impressions_9025cbb_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_9025cbb_on_campaign_id ON public.impressions_9025cbb USING btree (campaign_id);


--
-- Name: index_impressions_9025cbb_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_9025cbb_on_displayed_at_date ON public.impressions_9025cbb USING btree (displayed_at_date);


--
-- Name: index_impressions_9025cbb_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_9025cbb_on_displayed_at_hour ON public.impressions_9025cbb USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_9025cbb_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_9025cbb_on_payable ON public.impressions_9025cbb USING btree (payable);


--
-- Name: index_impressions_9025cbb_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_9025cbb_on_property_id ON public.impressions_9025cbb USING btree (property_id);


--
-- Name: index_impressions_90d9302_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_90d9302_on_campaign_id ON public.impressions_90d9302 USING btree (campaign_id);


--
-- Name: index_impressions_90d9302_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_90d9302_on_displayed_at_date ON public.impressions_90d9302 USING btree (displayed_at_date);


--
-- Name: index_impressions_90d9302_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_90d9302_on_displayed_at_hour ON public.impressions_90d9302 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_90d9302_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_90d9302_on_payable ON public.impressions_90d9302 USING btree (payable);


--
-- Name: index_impressions_90d9302_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_90d9302_on_property_id ON public.impressions_90d9302 USING btree (property_id);


--
-- Name: index_impressions_9257c9d_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_9257c9d_on_campaign_id ON public.impressions_9257c9d USING btree (campaign_id);


--
-- Name: index_impressions_9257c9d_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_9257c9d_on_displayed_at_date ON public.impressions_9257c9d USING btree (displayed_at_date);


--
-- Name: index_impressions_9257c9d_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_9257c9d_on_displayed_at_hour ON public.impressions_9257c9d USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_9257c9d_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_9257c9d_on_payable ON public.impressions_9257c9d USING btree (payable);


--
-- Name: index_impressions_9257c9d_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_9257c9d_on_property_id ON public.impressions_9257c9d USING btree (property_id);


--
-- Name: index_impressions_93d7d18_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_93d7d18_on_campaign_id ON public.impressions_93d7d18 USING btree (campaign_id);


--
-- Name: index_impressions_93d7d18_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_93d7d18_on_displayed_at_date ON public.impressions_93d7d18 USING btree (displayed_at_date);


--
-- Name: index_impressions_93d7d18_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_93d7d18_on_displayed_at_hour ON public.impressions_93d7d18 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_93d7d18_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_93d7d18_on_payable ON public.impressions_93d7d18 USING btree (payable);


--
-- Name: index_impressions_93d7d18_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_93d7d18_on_property_id ON public.impressions_93d7d18 USING btree (property_id);


--
-- Name: index_impressions_94f0a87_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_94f0a87_on_campaign_id ON public.impressions_94f0a87 USING btree (campaign_id);


--
-- Name: index_impressions_94f0a87_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_94f0a87_on_displayed_at_date ON public.impressions_94f0a87 USING btree (displayed_at_date);


--
-- Name: index_impressions_94f0a87_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_94f0a87_on_displayed_at_hour ON public.impressions_94f0a87 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_94f0a87_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_94f0a87_on_payable ON public.impressions_94f0a87 USING btree (payable);


--
-- Name: index_impressions_94f0a87_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_94f0a87_on_property_id ON public.impressions_94f0a87 USING btree (property_id);


--
-- Name: index_impressions_95c00de_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_95c00de_on_campaign_id ON public.impressions_95c00de USING btree (campaign_id);


--
-- Name: index_impressions_95c00de_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_95c00de_on_displayed_at_date ON public.impressions_95c00de USING btree (displayed_at_date);


--
-- Name: index_impressions_95c00de_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_95c00de_on_displayed_at_hour ON public.impressions_95c00de USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_95c00de_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_95c00de_on_payable ON public.impressions_95c00de USING btree (payable);


--
-- Name: index_impressions_95c00de_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_95c00de_on_property_id ON public.impressions_95c00de USING btree (property_id);


--
-- Name: index_impressions_95f5aed_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_95f5aed_on_campaign_id ON public.impressions_95f5aed USING btree (campaign_id);


--
-- Name: index_impressions_95f5aed_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_95f5aed_on_displayed_at_date ON public.impressions_95f5aed USING btree (displayed_at_date);


--
-- Name: index_impressions_95f5aed_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_95f5aed_on_displayed_at_hour ON public.impressions_95f5aed USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_95f5aed_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_95f5aed_on_payable ON public.impressions_95f5aed USING btree (payable);


--
-- Name: index_impressions_95f5aed_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_95f5aed_on_property_id ON public.impressions_95f5aed USING btree (property_id);


--
-- Name: index_impressions_977ed92_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_977ed92_on_campaign_id ON public.impressions_977ed92 USING btree (campaign_id);


--
-- Name: index_impressions_977ed92_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_977ed92_on_displayed_at_date ON public.impressions_977ed92 USING btree (displayed_at_date);


--
-- Name: index_impressions_977ed92_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_977ed92_on_displayed_at_hour ON public.impressions_977ed92 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_977ed92_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_977ed92_on_payable ON public.impressions_977ed92 USING btree (payable);


--
-- Name: index_impressions_977ed92_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_977ed92_on_property_id ON public.impressions_977ed92 USING btree (property_id);


--
-- Name: index_impressions_99bd6ac_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_99bd6ac_on_campaign_id ON public.impressions_99bd6ac USING btree (campaign_id);


--
-- Name: index_impressions_99bd6ac_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_99bd6ac_on_displayed_at_date ON public.impressions_99bd6ac USING btree (displayed_at_date);


--
-- Name: index_impressions_99bd6ac_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_99bd6ac_on_displayed_at_hour ON public.impressions_99bd6ac USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_99bd6ac_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_99bd6ac_on_payable ON public.impressions_99bd6ac USING btree (payable);


--
-- Name: index_impressions_99bd6ac_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_99bd6ac_on_property_id ON public.impressions_99bd6ac USING btree (property_id);


--
-- Name: index_impressions_9d02901_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_9d02901_on_campaign_id ON public.impressions_9d02901 USING btree (campaign_id);


--
-- Name: index_impressions_9d02901_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_9d02901_on_displayed_at_date ON public.impressions_9d02901 USING btree (displayed_at_date);


--
-- Name: index_impressions_9d02901_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_9d02901_on_displayed_at_hour ON public.impressions_9d02901 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_9d02901_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_9d02901_on_payable ON public.impressions_9d02901 USING btree (payable);


--
-- Name: index_impressions_9d02901_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_9d02901_on_property_id ON public.impressions_9d02901 USING btree (property_id);


--
-- Name: index_impressions_a5b36a9_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_a5b36a9_on_campaign_id ON public.impressions_a5b36a9 USING btree (campaign_id);


--
-- Name: index_impressions_a5b36a9_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_a5b36a9_on_displayed_at_date ON public.impressions_a5b36a9 USING btree (displayed_at_date);


--
-- Name: index_impressions_a5b36a9_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_a5b36a9_on_displayed_at_hour ON public.impressions_a5b36a9 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_a5b36a9_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_a5b36a9_on_payable ON public.impressions_a5b36a9 USING btree (payable);


--
-- Name: index_impressions_a5b36a9_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_a5b36a9_on_property_id ON public.impressions_a5b36a9 USING btree (property_id);


--
-- Name: index_impressions_a5d876d_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_a5d876d_on_campaign_id ON public.impressions_a5d876d USING btree (campaign_id);


--
-- Name: index_impressions_a5d876d_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_a5d876d_on_displayed_at_date ON public.impressions_a5d876d USING btree (displayed_at_date);


--
-- Name: index_impressions_a5d876d_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_a5d876d_on_displayed_at_hour ON public.impressions_a5d876d USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_a5d876d_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_a5d876d_on_payable ON public.impressions_a5d876d USING btree (payable);


--
-- Name: index_impressions_a5d876d_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_a5d876d_on_property_id ON public.impressions_a5d876d USING btree (property_id);


--
-- Name: index_impressions_a6e5a50_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_a6e5a50_on_campaign_id ON public.impressions_a6e5a50 USING btree (campaign_id);


--
-- Name: index_impressions_a6e5a50_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_a6e5a50_on_displayed_at_date ON public.impressions_a6e5a50 USING btree (displayed_at_date);


--
-- Name: index_impressions_a6e5a50_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_a6e5a50_on_displayed_at_hour ON public.impressions_a6e5a50 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_a6e5a50_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_a6e5a50_on_payable ON public.impressions_a6e5a50 USING btree (payable);


--
-- Name: index_impressions_a6e5a50_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_a6e5a50_on_property_id ON public.impressions_a6e5a50 USING btree (property_id);


--
-- Name: index_impressions_a7f178b_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_a7f178b_on_campaign_id ON public.impressions_a7f178b USING btree (campaign_id);


--
-- Name: index_impressions_a7f178b_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_a7f178b_on_displayed_at_date ON public.impressions_a7f178b USING btree (displayed_at_date);


--
-- Name: index_impressions_a7f178b_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_a7f178b_on_displayed_at_hour ON public.impressions_a7f178b USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_a7f178b_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_a7f178b_on_payable ON public.impressions_a7f178b USING btree (payable);


--
-- Name: index_impressions_a7f178b_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_a7f178b_on_property_id ON public.impressions_a7f178b USING btree (property_id);


--
-- Name: index_impressions_accf3ae_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_accf3ae_on_campaign_id ON public.impressions_accf3ae USING btree (campaign_id);


--
-- Name: index_impressions_accf3ae_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_accf3ae_on_displayed_at_date ON public.impressions_accf3ae USING btree (displayed_at_date);


--
-- Name: index_impressions_accf3ae_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_accf3ae_on_displayed_at_hour ON public.impressions_accf3ae USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_accf3ae_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_accf3ae_on_payable ON public.impressions_accf3ae USING btree (payable);


--
-- Name: index_impressions_accf3ae_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_accf3ae_on_property_id ON public.impressions_accf3ae USING btree (property_id);


--
-- Name: index_impressions_ad1667d_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_ad1667d_on_campaign_id ON public.impressions_ad1667d USING btree (campaign_id);


--
-- Name: index_impressions_ad1667d_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_ad1667d_on_displayed_at_date ON public.impressions_ad1667d USING btree (displayed_at_date);


--
-- Name: index_impressions_ad1667d_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_ad1667d_on_displayed_at_hour ON public.impressions_ad1667d USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_ad1667d_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_ad1667d_on_payable ON public.impressions_ad1667d USING btree (payable);


--
-- Name: index_impressions_ad1667d_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_ad1667d_on_property_id ON public.impressions_ad1667d USING btree (property_id);


--
-- Name: index_impressions_adab992_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_adab992_on_campaign_id ON public.impressions_adab992 USING btree (campaign_id);


--
-- Name: index_impressions_adab992_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_adab992_on_displayed_at_date ON public.impressions_adab992 USING btree (displayed_at_date);


--
-- Name: index_impressions_adab992_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_adab992_on_displayed_at_hour ON public.impressions_adab992 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_adab992_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_adab992_on_payable ON public.impressions_adab992 USING btree (payable);


--
-- Name: index_impressions_adab992_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_adab992_on_property_id ON public.impressions_adab992 USING btree (property_id);


--
-- Name: index_impressions_af29709_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_af29709_on_campaign_id ON public.impressions_af29709 USING btree (campaign_id);


--
-- Name: index_impressions_af29709_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_af29709_on_displayed_at_date ON public.impressions_af29709 USING btree (displayed_at_date);


--
-- Name: index_impressions_af29709_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_af29709_on_displayed_at_hour ON public.impressions_af29709 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_af29709_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_af29709_on_payable ON public.impressions_af29709 USING btree (payable);


--
-- Name: index_impressions_af29709_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_af29709_on_property_id ON public.impressions_af29709 USING btree (property_id);


--
-- Name: index_impressions_b30c5f4_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_b30c5f4_on_campaign_id ON public.impressions_b30c5f4 USING btree (campaign_id);


--
-- Name: index_impressions_b30c5f4_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_b30c5f4_on_displayed_at_date ON public.impressions_b30c5f4 USING btree (displayed_at_date);


--
-- Name: index_impressions_b30c5f4_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_b30c5f4_on_displayed_at_hour ON public.impressions_b30c5f4 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_b30c5f4_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_b30c5f4_on_payable ON public.impressions_b30c5f4 USING btree (payable);


--
-- Name: index_impressions_b30c5f4_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_b30c5f4_on_property_id ON public.impressions_b30c5f4 USING btree (property_id);


--
-- Name: index_impressions_b8b32d6_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_b8b32d6_on_campaign_id ON public.impressions_b8b32d6 USING btree (campaign_id);


--
-- Name: index_impressions_b8b32d6_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_b8b32d6_on_displayed_at_date ON public.impressions_b8b32d6 USING btree (displayed_at_date);


--
-- Name: index_impressions_b8b32d6_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_b8b32d6_on_displayed_at_hour ON public.impressions_b8b32d6 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_b8b32d6_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_b8b32d6_on_payable ON public.impressions_b8b32d6 USING btree (payable);


--
-- Name: index_impressions_b8b32d6_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_b8b32d6_on_property_id ON public.impressions_b8b32d6 USING btree (property_id);


--
-- Name: index_impressions_b9feea5_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_b9feea5_on_campaign_id ON public.impressions_b9feea5 USING btree (campaign_id);


--
-- Name: index_impressions_b9feea5_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_b9feea5_on_displayed_at_date ON public.impressions_b9feea5 USING btree (displayed_at_date);


--
-- Name: index_impressions_b9feea5_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_b9feea5_on_displayed_at_hour ON public.impressions_b9feea5 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_b9feea5_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_b9feea5_on_payable ON public.impressions_b9feea5 USING btree (payable);


--
-- Name: index_impressions_b9feea5_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_b9feea5_on_property_id ON public.impressions_b9feea5 USING btree (property_id);


--
-- Name: index_impressions_bc32520_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_bc32520_on_campaign_id ON public.impressions_bc32520 USING btree (campaign_id);


--
-- Name: index_impressions_bc32520_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_bc32520_on_displayed_at_date ON public.impressions_bc32520 USING btree (displayed_at_date);


--
-- Name: index_impressions_bc32520_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_bc32520_on_displayed_at_hour ON public.impressions_bc32520 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_bc32520_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_bc32520_on_payable ON public.impressions_bc32520 USING btree (payable);


--
-- Name: index_impressions_bc32520_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_bc32520_on_property_id ON public.impressions_bc32520 USING btree (property_id);


--
-- Name: index_impressions_be31132_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_be31132_on_campaign_id ON public.impressions_be31132 USING btree (campaign_id);


--
-- Name: index_impressions_be31132_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_be31132_on_displayed_at_date ON public.impressions_be31132 USING btree (displayed_at_date);


--
-- Name: index_impressions_be31132_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_be31132_on_displayed_at_hour ON public.impressions_be31132 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_be31132_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_be31132_on_payable ON public.impressions_be31132 USING btree (payable);


--
-- Name: index_impressions_be31132_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_be31132_on_property_id ON public.impressions_be31132 USING btree (property_id);


--
-- Name: index_impressions_c14ec8a_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_c14ec8a_on_campaign_id ON public.impressions_c14ec8a USING btree (campaign_id);


--
-- Name: index_impressions_c14ec8a_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_c14ec8a_on_displayed_at_date ON public.impressions_c14ec8a USING btree (displayed_at_date);


--
-- Name: index_impressions_c14ec8a_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_c14ec8a_on_displayed_at_hour ON public.impressions_c14ec8a USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_c14ec8a_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_c14ec8a_on_payable ON public.impressions_c14ec8a USING btree (payable);


--
-- Name: index_impressions_c14ec8a_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_c14ec8a_on_property_id ON public.impressions_c14ec8a USING btree (property_id);


--
-- Name: index_impressions_c3037b2_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_c3037b2_on_campaign_id ON public.impressions_c3037b2 USING btree (campaign_id);


--
-- Name: index_impressions_c3037b2_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_c3037b2_on_displayed_at_date ON public.impressions_c3037b2 USING btree (displayed_at_date);


--
-- Name: index_impressions_c3037b2_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_c3037b2_on_displayed_at_hour ON public.impressions_c3037b2 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_c3037b2_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_c3037b2_on_payable ON public.impressions_c3037b2 USING btree (payable);


--
-- Name: index_impressions_c3037b2_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_c3037b2_on_property_id ON public.impressions_c3037b2 USING btree (property_id);


--
-- Name: index_impressions_c4350d3_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_c4350d3_on_campaign_id ON public.impressions_c4350d3 USING btree (campaign_id);


--
-- Name: index_impressions_c4350d3_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_c4350d3_on_displayed_at_date ON public.impressions_c4350d3 USING btree (displayed_at_date);


--
-- Name: index_impressions_c4350d3_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_c4350d3_on_displayed_at_hour ON public.impressions_c4350d3 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_c4350d3_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_c4350d3_on_payable ON public.impressions_c4350d3 USING btree (payable);


--
-- Name: index_impressions_c4350d3_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_c4350d3_on_property_id ON public.impressions_c4350d3 USING btree (property_id);


--
-- Name: index_impressions_c9cb65e_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_c9cb65e_on_campaign_id ON public.impressions_c9cb65e USING btree (campaign_id);


--
-- Name: index_impressions_c9cb65e_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_c9cb65e_on_displayed_at_date ON public.impressions_c9cb65e USING btree (displayed_at_date);


--
-- Name: index_impressions_c9cb65e_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_c9cb65e_on_displayed_at_hour ON public.impressions_c9cb65e USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_c9cb65e_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_c9cb65e_on_payable ON public.impressions_c9cb65e USING btree (payable);


--
-- Name: index_impressions_c9cb65e_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_c9cb65e_on_property_id ON public.impressions_c9cb65e USING btree (property_id);


--
-- Name: index_impressions_cb5be27_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_cb5be27_on_campaign_id ON public.impressions_cb5be27 USING btree (campaign_id);


--
-- Name: index_impressions_cb5be27_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_cb5be27_on_displayed_at_date ON public.impressions_cb5be27 USING btree (displayed_at_date);


--
-- Name: index_impressions_cb5be27_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_cb5be27_on_displayed_at_hour ON public.impressions_cb5be27 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_cb5be27_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_cb5be27_on_payable ON public.impressions_cb5be27 USING btree (payable);


--
-- Name: index_impressions_cb5be27_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_cb5be27_on_property_id ON public.impressions_cb5be27 USING btree (property_id);


--
-- Name: index_impressions_cc3bbc2_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_cc3bbc2_on_campaign_id ON public.impressions_cc3bbc2 USING btree (campaign_id);


--
-- Name: index_impressions_cc3bbc2_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_cc3bbc2_on_displayed_at_date ON public.impressions_cc3bbc2 USING btree (displayed_at_date);


--
-- Name: index_impressions_cc3bbc2_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_cc3bbc2_on_displayed_at_hour ON public.impressions_cc3bbc2 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_cc3bbc2_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_cc3bbc2_on_payable ON public.impressions_cc3bbc2 USING btree (payable);


--
-- Name: index_impressions_cc3bbc2_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_cc3bbc2_on_property_id ON public.impressions_cc3bbc2 USING btree (property_id);


--
-- Name: index_impressions_ccfc39a_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_ccfc39a_on_campaign_id ON public.impressions_ccfc39a USING btree (campaign_id);


--
-- Name: index_impressions_ccfc39a_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_ccfc39a_on_displayed_at_date ON public.impressions_ccfc39a USING btree (displayed_at_date);


--
-- Name: index_impressions_ccfc39a_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_ccfc39a_on_displayed_at_hour ON public.impressions_ccfc39a USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_ccfc39a_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_ccfc39a_on_payable ON public.impressions_ccfc39a USING btree (payable);


--
-- Name: index_impressions_ccfc39a_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_ccfc39a_on_property_id ON public.impressions_ccfc39a USING btree (property_id);


--
-- Name: index_impressions_d072121_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d072121_on_campaign_id ON public.impressions_d072121 USING btree (campaign_id);


--
-- Name: index_impressions_d072121_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d072121_on_displayed_at_date ON public.impressions_d072121 USING btree (displayed_at_date);


--
-- Name: index_impressions_d072121_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d072121_on_displayed_at_hour ON public.impressions_d072121 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_d072121_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d072121_on_payable ON public.impressions_d072121 USING btree (payable);


--
-- Name: index_impressions_d072121_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d072121_on_property_id ON public.impressions_d072121 USING btree (property_id);


--
-- Name: index_impressions_d2b5f35_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d2b5f35_on_campaign_id ON public.impressions_d2b5f35 USING btree (campaign_id);


--
-- Name: index_impressions_d2b5f35_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d2b5f35_on_displayed_at_date ON public.impressions_d2b5f35 USING btree (displayed_at_date);


--
-- Name: index_impressions_d2b5f35_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d2b5f35_on_displayed_at_hour ON public.impressions_d2b5f35 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_d2b5f35_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d2b5f35_on_payable ON public.impressions_d2b5f35 USING btree (payable);


--
-- Name: index_impressions_d2b5f35_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d2b5f35_on_property_id ON public.impressions_d2b5f35 USING btree (property_id);


--
-- Name: index_impressions_d500d91_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d500d91_on_campaign_id ON public.impressions_d500d91 USING btree (campaign_id);


--
-- Name: index_impressions_d500d91_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d500d91_on_displayed_at_date ON public.impressions_d500d91 USING btree (displayed_at_date);


--
-- Name: index_impressions_d500d91_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d500d91_on_displayed_at_hour ON public.impressions_d500d91 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_d500d91_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d500d91_on_payable ON public.impressions_d500d91 USING btree (payable);


--
-- Name: index_impressions_d500d91_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d500d91_on_property_id ON public.impressions_d500d91 USING btree (property_id);


--
-- Name: index_impressions_d801546_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d801546_on_campaign_id ON public.impressions_d801546 USING btree (campaign_id);


--
-- Name: index_impressions_d801546_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d801546_on_displayed_at_date ON public.impressions_d801546 USING btree (displayed_at_date);


--
-- Name: index_impressions_d801546_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d801546_on_displayed_at_hour ON public.impressions_d801546 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_d801546_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d801546_on_payable ON public.impressions_d801546 USING btree (payable);


--
-- Name: index_impressions_d801546_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d801546_on_property_id ON public.impressions_d801546 USING btree (property_id);


--
-- Name: index_impressions_d9f318d_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d9f318d_on_campaign_id ON public.impressions_d9f318d USING btree (campaign_id);


--
-- Name: index_impressions_d9f318d_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d9f318d_on_displayed_at_date ON public.impressions_d9f318d USING btree (displayed_at_date);


--
-- Name: index_impressions_d9f318d_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d9f318d_on_displayed_at_hour ON public.impressions_d9f318d USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_d9f318d_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d9f318d_on_payable ON public.impressions_d9f318d USING btree (payable);


--
-- Name: index_impressions_d9f318d_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_d9f318d_on_property_id ON public.impressions_d9f318d USING btree (property_id);


--
-- Name: index_impressions_db5c100_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_db5c100_on_campaign_id ON public.impressions_db5c100 USING btree (campaign_id);


--
-- Name: index_impressions_db5c100_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_db5c100_on_displayed_at_date ON public.impressions_db5c100 USING btree (displayed_at_date);


--
-- Name: index_impressions_db5c100_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_db5c100_on_displayed_at_hour ON public.impressions_db5c100 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_db5c100_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_db5c100_on_payable ON public.impressions_db5c100 USING btree (payable);


--
-- Name: index_impressions_db5c100_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_db5c100_on_property_id ON public.impressions_db5c100 USING btree (property_id);


--
-- Name: index_impressions_dbfada5_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_dbfada5_on_campaign_id ON public.impressions_dbfada5 USING btree (campaign_id);


--
-- Name: index_impressions_dbfada5_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_dbfada5_on_displayed_at_date ON public.impressions_dbfada5 USING btree (displayed_at_date);


--
-- Name: index_impressions_dbfada5_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_dbfada5_on_displayed_at_hour ON public.impressions_dbfada5 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_dbfada5_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_dbfada5_on_payable ON public.impressions_dbfada5 USING btree (payable);


--
-- Name: index_impressions_dbfada5_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_dbfada5_on_property_id ON public.impressions_dbfada5 USING btree (property_id);


--
-- Name: index_impressions_dcfa592_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_dcfa592_on_campaign_id ON public.impressions_dcfa592 USING btree (campaign_id);


--
-- Name: index_impressions_dcfa592_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_dcfa592_on_displayed_at_date ON public.impressions_dcfa592 USING btree (displayed_at_date);


--
-- Name: index_impressions_dcfa592_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_dcfa592_on_displayed_at_hour ON public.impressions_dcfa592 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_dcfa592_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_dcfa592_on_payable ON public.impressions_dcfa592 USING btree (payable);


--
-- Name: index_impressions_dcfa592_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_dcfa592_on_property_id ON public.impressions_dcfa592 USING btree (property_id);


--
-- Name: index_impressions_e0da3fd_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e0da3fd_on_campaign_id ON public.impressions_e0da3fd USING btree (campaign_id);


--
-- Name: index_impressions_e0da3fd_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e0da3fd_on_displayed_at_date ON public.impressions_e0da3fd USING btree (displayed_at_date);


--
-- Name: index_impressions_e0da3fd_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e0da3fd_on_displayed_at_hour ON public.impressions_e0da3fd USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_e0da3fd_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e0da3fd_on_payable ON public.impressions_e0da3fd USING btree (payable);


--
-- Name: index_impressions_e0da3fd_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e0da3fd_on_property_id ON public.impressions_e0da3fd USING btree (property_id);


--
-- Name: index_impressions_e6bd22d_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e6bd22d_on_campaign_id ON public.impressions_e6bd22d USING btree (campaign_id);


--
-- Name: index_impressions_e6bd22d_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e6bd22d_on_displayed_at_date ON public.impressions_e6bd22d USING btree (displayed_at_date);


--
-- Name: index_impressions_e6bd22d_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e6bd22d_on_displayed_at_hour ON public.impressions_e6bd22d USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_e6bd22d_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e6bd22d_on_payable ON public.impressions_e6bd22d USING btree (payable);


--
-- Name: index_impressions_e6bd22d_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e6bd22d_on_property_id ON public.impressions_e6bd22d USING btree (property_id);


--
-- Name: index_impressions_e7cdbb8_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e7cdbb8_on_campaign_id ON public.impressions_e7cdbb8 USING btree (campaign_id);


--
-- Name: index_impressions_e7cdbb8_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e7cdbb8_on_displayed_at_date ON public.impressions_e7cdbb8 USING btree (displayed_at_date);


--
-- Name: index_impressions_e7cdbb8_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e7cdbb8_on_displayed_at_hour ON public.impressions_e7cdbb8 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_e7cdbb8_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e7cdbb8_on_payable ON public.impressions_e7cdbb8 USING btree (payable);


--
-- Name: index_impressions_e7cdbb8_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e7cdbb8_on_property_id ON public.impressions_e7cdbb8 USING btree (property_id);


--
-- Name: index_impressions_e7f326c_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e7f326c_on_campaign_id ON public.impressions_e7f326c USING btree (campaign_id);


--
-- Name: index_impressions_e7f326c_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e7f326c_on_displayed_at_date ON public.impressions_e7f326c USING btree (displayed_at_date);


--
-- Name: index_impressions_e7f326c_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e7f326c_on_displayed_at_hour ON public.impressions_e7f326c USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_e7f326c_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e7f326c_on_payable ON public.impressions_e7f326c USING btree (payable);


--
-- Name: index_impressions_e7f326c_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e7f326c_on_property_id ON public.impressions_e7f326c USING btree (property_id);


--
-- Name: index_impressions_e942689_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e942689_on_campaign_id ON public.impressions_e942689 USING btree (campaign_id);


--
-- Name: index_impressions_e942689_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e942689_on_displayed_at_date ON public.impressions_e942689 USING btree (displayed_at_date);


--
-- Name: index_impressions_e942689_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e942689_on_displayed_at_hour ON public.impressions_e942689 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_e942689_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e942689_on_payable ON public.impressions_e942689 USING btree (payable);


--
-- Name: index_impressions_e942689_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_e942689_on_property_id ON public.impressions_e942689 USING btree (property_id);


--
-- Name: index_impressions_eb6cfa6_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_eb6cfa6_on_campaign_id ON public.impressions_eb6cfa6 USING btree (campaign_id);


--
-- Name: index_impressions_eb6cfa6_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_eb6cfa6_on_displayed_at_date ON public.impressions_eb6cfa6 USING btree (displayed_at_date);


--
-- Name: index_impressions_eb6cfa6_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_eb6cfa6_on_displayed_at_hour ON public.impressions_eb6cfa6 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_eb6cfa6_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_eb6cfa6_on_payable ON public.impressions_eb6cfa6 USING btree (payable);


--
-- Name: index_impressions_eb6cfa6_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_eb6cfa6_on_property_id ON public.impressions_eb6cfa6 USING btree (property_id);


--
-- Name: index_impressions_ec2dc1e_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_ec2dc1e_on_campaign_id ON public.impressions_ec2dc1e USING btree (campaign_id);


--
-- Name: index_impressions_ec2dc1e_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_ec2dc1e_on_displayed_at_date ON public.impressions_ec2dc1e USING btree (displayed_at_date);


--
-- Name: index_impressions_ec2dc1e_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_ec2dc1e_on_displayed_at_hour ON public.impressions_ec2dc1e USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_ec2dc1e_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_ec2dc1e_on_payable ON public.impressions_ec2dc1e USING btree (payable);


--
-- Name: index_impressions_ec2dc1e_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_ec2dc1e_on_property_id ON public.impressions_ec2dc1e USING btree (property_id);


--
-- Name: index_impressions_efc15cd_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_efc15cd_on_campaign_id ON public.impressions_efc15cd USING btree (campaign_id);


--
-- Name: index_impressions_efc15cd_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_efc15cd_on_displayed_at_date ON public.impressions_efc15cd USING btree (displayed_at_date);


--
-- Name: index_impressions_efc15cd_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_efc15cd_on_displayed_at_hour ON public.impressions_efc15cd USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_efc15cd_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_efc15cd_on_payable ON public.impressions_efc15cd USING btree (payable);


--
-- Name: index_impressions_efc15cd_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_efc15cd_on_property_id ON public.impressions_efc15cd USING btree (property_id);


--
-- Name: index_impressions_f03d063_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f03d063_on_campaign_id ON public.impressions_f03d063 USING btree (campaign_id);


--
-- Name: index_impressions_f03d063_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f03d063_on_displayed_at_date ON public.impressions_f03d063 USING btree (displayed_at_date);


--
-- Name: index_impressions_f03d063_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f03d063_on_displayed_at_hour ON public.impressions_f03d063 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_f03d063_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f03d063_on_payable ON public.impressions_f03d063 USING btree (payable);


--
-- Name: index_impressions_f03d063_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f03d063_on_property_id ON public.impressions_f03d063 USING btree (property_id);


--
-- Name: index_impressions_f1cbe01_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f1cbe01_on_campaign_id ON public.impressions_f1cbe01 USING btree (campaign_id);


--
-- Name: index_impressions_f1cbe01_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f1cbe01_on_displayed_at_date ON public.impressions_f1cbe01 USING btree (displayed_at_date);


--
-- Name: index_impressions_f1cbe01_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f1cbe01_on_displayed_at_hour ON public.impressions_f1cbe01 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_f1cbe01_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f1cbe01_on_payable ON public.impressions_f1cbe01 USING btree (payable);


--
-- Name: index_impressions_f1cbe01_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f1cbe01_on_property_id ON public.impressions_f1cbe01 USING btree (property_id);


--
-- Name: index_impressions_f2d2cd3_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f2d2cd3_on_campaign_id ON public.impressions_f2d2cd3 USING btree (campaign_id);


--
-- Name: index_impressions_f2d2cd3_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f2d2cd3_on_displayed_at_date ON public.impressions_f2d2cd3 USING btree (displayed_at_date);


--
-- Name: index_impressions_f2d2cd3_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f2d2cd3_on_displayed_at_hour ON public.impressions_f2d2cd3 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_f2d2cd3_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f2d2cd3_on_payable ON public.impressions_f2d2cd3 USING btree (payable);


--
-- Name: index_impressions_f2d2cd3_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f2d2cd3_on_property_id ON public.impressions_f2d2cd3 USING btree (property_id);


--
-- Name: index_impressions_f2f396a_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f2f396a_on_campaign_id ON public.impressions_f2f396a USING btree (campaign_id);


--
-- Name: index_impressions_f2f396a_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f2f396a_on_displayed_at_date ON public.impressions_f2f396a USING btree (displayed_at_date);


--
-- Name: index_impressions_f2f396a_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f2f396a_on_displayed_at_hour ON public.impressions_f2f396a USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_f2f396a_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f2f396a_on_payable ON public.impressions_f2f396a USING btree (payable);


--
-- Name: index_impressions_f2f396a_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f2f396a_on_property_id ON public.impressions_f2f396a USING btree (property_id);


--
-- Name: index_impressions_f5a1145_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f5a1145_on_campaign_id ON public.impressions_f5a1145 USING btree (campaign_id);


--
-- Name: index_impressions_f5a1145_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f5a1145_on_displayed_at_date ON public.impressions_f5a1145 USING btree (displayed_at_date);


--
-- Name: index_impressions_f5a1145_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f5a1145_on_displayed_at_hour ON public.impressions_f5a1145 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_f5a1145_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f5a1145_on_payable ON public.impressions_f5a1145 USING btree (payable);


--
-- Name: index_impressions_f5a1145_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f5a1145_on_property_id ON public.impressions_f5a1145 USING btree (property_id);


--
-- Name: index_impressions_f66d3ce_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f66d3ce_on_campaign_id ON public.impressions_f66d3ce USING btree (campaign_id);


--
-- Name: index_impressions_f66d3ce_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f66d3ce_on_displayed_at_date ON public.impressions_f66d3ce USING btree (displayed_at_date);


--
-- Name: index_impressions_f66d3ce_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f66d3ce_on_displayed_at_hour ON public.impressions_f66d3ce USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_f66d3ce_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f66d3ce_on_payable ON public.impressions_f66d3ce USING btree (payable);


--
-- Name: index_impressions_f66d3ce_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_f66d3ce_on_property_id ON public.impressions_f66d3ce USING btree (property_id);


--
-- Name: index_impressions_fbcea0f_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_fbcea0f_on_campaign_id ON public.impressions_fbcea0f USING btree (campaign_id);


--
-- Name: index_impressions_fbcea0f_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_fbcea0f_on_displayed_at_date ON public.impressions_fbcea0f USING btree (displayed_at_date);


--
-- Name: index_impressions_fbcea0f_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_fbcea0f_on_displayed_at_hour ON public.impressions_fbcea0f USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_fbcea0f_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_fbcea0f_on_payable ON public.impressions_fbcea0f USING btree (payable);


--
-- Name: index_impressions_fbcea0f_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_fbcea0f_on_property_id ON public.impressions_fbcea0f USING btree (property_id);


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


