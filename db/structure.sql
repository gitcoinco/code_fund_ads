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
-- Name: comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comments (
    id bigint NOT NULL,
    commentable_id integer,
    commentable_type character varying,
    title character varying,
    body text,
    subject character varying,
    user_id integer NOT NULL,
    parent_id integer,
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
    advertiser_id bigint NOT NULL,
    campaign_id bigint NOT NULL,
    campaign_name character varying NOT NULL,
    property_id bigint NOT NULL,
    property_name character varying NOT NULL,
    ip character varying NOT NULL,
    user_agent text NOT NULL,
    country_code character varying,
    postal_code character varying,
    latitude numeric,
    longitude numeric,
    payable boolean DEFAULT false NOT NULL,
    reason character varying,
    displayed_at timestamp without time zone NOT NULL,
    displayed_at_date date NOT NULL,
    clicked_at timestamp without time zone,
    fallback_campaign boolean DEFAULT false NOT NULL
)
PARTITION BY RANGE (advertiser_id, displayed_at_date);


--
-- Name: impressions_2018_03_advertiser_15; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_03_advertiser_15 PARTITION OF public.impressions
FOR VALUES FROM ('15', '2018-03-01') TO ('15', '2018-04-01');


--
-- Name: impressions_2018_03_advertiser_16; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_03_advertiser_16 PARTITION OF public.impressions
FOR VALUES FROM ('16', '2018-03-01') TO ('16', '2018-04-01');


--
-- Name: impressions_2018_03_advertiser_24; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_03_advertiser_24 PARTITION OF public.impressions
FOR VALUES FROM ('24', '2018-03-01') TO ('24', '2018-04-01');


--
-- Name: impressions_2018_03_advertiser_27; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_03_advertiser_27 PARTITION OF public.impressions
FOR VALUES FROM ('27', '2018-03-01') TO ('27', '2018-04-01');


--
-- Name: impressions_2018_03_advertiser_33; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_03_advertiser_33 PARTITION OF public.impressions
FOR VALUES FROM ('33', '2018-03-01') TO ('33', '2018-04-01');


--
-- Name: impressions_2018_03_advertiser_59; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_03_advertiser_59 PARTITION OF public.impressions
FOR VALUES FROM ('59', '2018-03-01') TO ('59', '2018-04-01');


--
-- Name: impressions_2018_03_advertiser_66; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_03_advertiser_66 PARTITION OF public.impressions
FOR VALUES FROM ('66', '2018-03-01') TO ('66', '2018-04-01');


--
-- Name: impressions_2018_03_advertiser_74; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_03_advertiser_74 PARTITION OF public.impressions
FOR VALUES FROM ('74', '2018-03-01') TO ('74', '2018-04-01');


--
-- Name: impressions_2018_03_advertiser_75; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_03_advertiser_75 PARTITION OF public.impressions
FOR VALUES FROM ('75', '2018-03-01') TO ('75', '2018-04-01');


--
-- Name: impressions_2018_03_advertiser_82; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_03_advertiser_82 PARTITION OF public.impressions
FOR VALUES FROM ('82', '2018-03-01') TO ('82', '2018-04-01');


--
-- Name: impressions_2018_03_advertiser_87; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_03_advertiser_87 PARTITION OF public.impressions
FOR VALUES FROM ('87', '2018-03-01') TO ('87', '2018-04-01');


--
-- Name: impressions_2018_03_advertiser_92; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_03_advertiser_92 PARTITION OF public.impressions
FOR VALUES FROM ('92', '2018-03-01') TO ('92', '2018-04-01');


--
-- Name: impressions_2018_03_advertiser_95; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_03_advertiser_95 PARTITION OF public.impressions
FOR VALUES FROM ('95', '2018-03-01') TO ('95', '2018-04-01');


--
-- Name: impressions_2018_03_advertiser_97; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_03_advertiser_97 PARTITION OF public.impressions
FOR VALUES FROM ('97', '2018-03-01') TO ('97', '2018-04-01');


--
-- Name: impressions_2018_04_advertiser_15; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_04_advertiser_15 PARTITION OF public.impressions
FOR VALUES FROM ('15', '2018-04-01') TO ('15', '2018-05-01');


--
-- Name: impressions_2018_04_advertiser_18; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_04_advertiser_18 PARTITION OF public.impressions
FOR VALUES FROM ('18', '2018-04-01') TO ('18', '2018-05-01');


--
-- Name: impressions_2018_04_advertiser_27; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_04_advertiser_27 PARTITION OF public.impressions
FOR VALUES FROM ('27', '2018-04-01') TO ('27', '2018-05-01');


--
-- Name: impressions_2018_04_advertiser_33; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_04_advertiser_33 PARTITION OF public.impressions
FOR VALUES FROM ('33', '2018-04-01') TO ('33', '2018-05-01');


--
-- Name: impressions_2018_04_advertiser_46; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_04_advertiser_46 PARTITION OF public.impressions
FOR VALUES FROM ('46', '2018-04-01') TO ('46', '2018-05-01');


--
-- Name: impressions_2018_04_advertiser_48; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_04_advertiser_48 PARTITION OF public.impressions
FOR VALUES FROM ('48', '2018-04-01') TO ('48', '2018-05-01');


--
-- Name: impressions_2018_04_advertiser_49; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_04_advertiser_49 PARTITION OF public.impressions
FOR VALUES FROM ('49', '2018-04-01') TO ('49', '2018-05-01');


--
-- Name: impressions_2018_04_advertiser_74; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_04_advertiser_74 PARTITION OF public.impressions
FOR VALUES FROM ('74', '2018-04-01') TO ('74', '2018-05-01');


--
-- Name: impressions_2018_04_advertiser_75; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_04_advertiser_75 PARTITION OF public.impressions
FOR VALUES FROM ('75', '2018-04-01') TO ('75', '2018-05-01');


--
-- Name: impressions_2018_04_advertiser_96; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_04_advertiser_96 PARTITION OF public.impressions
FOR VALUES FROM ('96', '2018-04-01') TO ('96', '2018-05-01');


--
-- Name: impressions_2018_04_advertiser_97; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_04_advertiser_97 PARTITION OF public.impressions
FOR VALUES FROM ('97', '2018-04-01') TO ('97', '2018-05-01');


--
-- Name: impressions_2018_06_advertiser_18; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_06_advertiser_18 PARTITION OF public.impressions
FOR VALUES FROM ('18', '2018-06-01') TO ('18', '2018-07-01');


--
-- Name: impressions_2018_06_advertiser_19; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_06_advertiser_19 PARTITION OF public.impressions
FOR VALUES FROM ('19', '2018-06-01') TO ('19', '2018-07-01');


--
-- Name: impressions_2018_06_advertiser_52; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_06_advertiser_52 PARTITION OF public.impressions
FOR VALUES FROM ('52', '2018-06-01') TO ('52', '2018-07-01');


--
-- Name: impressions_2018_06_advertiser_55; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_06_advertiser_55 PARTITION OF public.impressions
FOR VALUES FROM ('55', '2018-06-01') TO ('55', '2018-07-01');


--
-- Name: impressions_2018_06_advertiser_62; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_06_advertiser_62 PARTITION OF public.impressions
FOR VALUES FROM ('62', '2018-06-01') TO ('62', '2018-07-01');


--
-- Name: impressions_2018_06_advertiser_64; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_06_advertiser_64 PARTITION OF public.impressions
FOR VALUES FROM ('64', '2018-06-01') TO ('64', '2018-07-01');


--
-- Name: impressions_2018_06_advertiser_7; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_06_advertiser_7 PARTITION OF public.impressions
FOR VALUES FROM ('7', '2018-06-01') TO ('7', '2018-07-01');


--
-- Name: impressions_2018_06_advertiser_72; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_06_advertiser_72 PARTITION OF public.impressions
FOR VALUES FROM ('72', '2018-06-01') TO ('72', '2018-07-01');


--
-- Name: impressions_2018_06_advertiser_85; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_06_advertiser_85 PARTITION OF public.impressions
FOR VALUES FROM ('85', '2018-06-01') TO ('85', '2018-07-01');


--
-- Name: impressions_2018_06_advertiser_89; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_06_advertiser_89 PARTITION OF public.impressions
FOR VALUES FROM ('89', '2018-06-01') TO ('89', '2018-07-01');


--
-- Name: impressions_2018_06_advertiser_98; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_06_advertiser_98 PARTITION OF public.impressions
FOR VALUES FROM ('98', '2018-06-01') TO ('98', '2018-07-01');


--
-- Name: impressions_2018_07_advertiser_19; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_07_advertiser_19 PARTITION OF public.impressions
FOR VALUES FROM ('19', '2018-07-01') TO ('19', '2018-08-01');


--
-- Name: impressions_2018_07_advertiser_23; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_07_advertiser_23 PARTITION OF public.impressions
FOR VALUES FROM ('23', '2018-07-01') TO ('23', '2018-08-01');


--
-- Name: impressions_2018_07_advertiser_39; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_07_advertiser_39 PARTITION OF public.impressions
FOR VALUES FROM ('39', '2018-07-01') TO ('39', '2018-08-01');


--
-- Name: impressions_2018_07_advertiser_62; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_07_advertiser_62 PARTITION OF public.impressions
FOR VALUES FROM ('62', '2018-07-01') TO ('62', '2018-08-01');


--
-- Name: impressions_2018_07_advertiser_64; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_07_advertiser_64 PARTITION OF public.impressions
FOR VALUES FROM ('64', '2018-07-01') TO ('64', '2018-08-01');


--
-- Name: impressions_2018_07_advertiser_84; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_07_advertiser_84 PARTITION OF public.impressions
FOR VALUES FROM ('84', '2018-07-01') TO ('84', '2018-08-01');


--
-- Name: impressions_2018_07_advertiser_85; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_07_advertiser_85 PARTITION OF public.impressions
FOR VALUES FROM ('85', '2018-07-01') TO ('85', '2018-08-01');


--
-- Name: impressions_2018_07_advertiser_87; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_07_advertiser_87 PARTITION OF public.impressions
FOR VALUES FROM ('87', '2018-07-01') TO ('87', '2018-08-01');


--
-- Name: impressions_2018_07_advertiser_89; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_07_advertiser_89 PARTITION OF public.impressions
FOR VALUES FROM ('89', '2018-07-01') TO ('89', '2018-08-01');


--
-- Name: impressions_2018_07_advertiser_95; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_07_advertiser_95 PARTITION OF public.impressions
FOR VALUES FROM ('95', '2018-07-01') TO ('95', '2018-08-01');


--
-- Name: impressions_2018_07_advertiser_96; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_07_advertiser_96 PARTITION OF public.impressions
FOR VALUES FROM ('96', '2018-07-01') TO ('96', '2018-08-01');


--
-- Name: impressions_2018_08_advertiser_39; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_08_advertiser_39 PARTITION OF public.impressions
FOR VALUES FROM ('39', '2018-08-01') TO ('39', '2018-09-01');


--
-- Name: impressions_2018_08_advertiser_46; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_08_advertiser_46 PARTITION OF public.impressions
FOR VALUES FROM ('46', '2018-08-01') TO ('46', '2018-09-01');


--
-- Name: impressions_2018_08_advertiser_55; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_08_advertiser_55 PARTITION OF public.impressions
FOR VALUES FROM ('55', '2018-08-01') TO ('55', '2018-09-01');


--
-- Name: impressions_2018_08_advertiser_57; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_08_advertiser_57 PARTITION OF public.impressions
FOR VALUES FROM ('57', '2018-08-01') TO ('57', '2018-09-01');


--
-- Name: impressions_2018_08_advertiser_58; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_08_advertiser_58 PARTITION OF public.impressions
FOR VALUES FROM ('58', '2018-08-01') TO ('58', '2018-09-01');


--
-- Name: impressions_2018_08_advertiser_72; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_08_advertiser_72 PARTITION OF public.impressions
FOR VALUES FROM ('72', '2018-08-01') TO ('72', '2018-09-01');


--
-- Name: impressions_2018_08_advertiser_84; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_08_advertiser_84 PARTITION OF public.impressions
FOR VALUES FROM ('84', '2018-08-01') TO ('84', '2018-09-01');


--
-- Name: impressions_2018_08_advertiser_89; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_08_advertiser_89 PARTITION OF public.impressions
FOR VALUES FROM ('89', '2018-08-01') TO ('89', '2018-09-01');


--
-- Name: impressions_2018_08_advertiser_95; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_08_advertiser_95 PARTITION OF public.impressions
FOR VALUES FROM ('95', '2018-08-01') TO ('95', '2018-09-01');


--
-- Name: impressions_2018_08_advertiser_96; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_08_advertiser_96 PARTITION OF public.impressions
FOR VALUES FROM ('96', '2018-08-01') TO ('96', '2018-09-01');


--
-- Name: impressions_2018_10_advertiser_31; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_10_advertiser_31 PARTITION OF public.impressions
FOR VALUES FROM ('31', '2018-10-01') TO ('31', '2018-11-01');


--
-- Name: impressions_2018_10_advertiser_53; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_10_advertiser_53 PARTITION OF public.impressions
FOR VALUES FROM ('53', '2018-10-01') TO ('53', '2018-11-01');


--
-- Name: impressions_2018_10_advertiser_55; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_10_advertiser_55 PARTITION OF public.impressions
FOR VALUES FROM ('55', '2018-10-01') TO ('55', '2018-11-01');


--
-- Name: impressions_2018_10_advertiser_56; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_10_advertiser_56 PARTITION OF public.impressions
FOR VALUES FROM ('56', '2018-10-01') TO ('56', '2018-11-01');


--
-- Name: impressions_2018_10_advertiser_70; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_10_advertiser_70 PARTITION OF public.impressions
FOR VALUES FROM ('70', '2018-10-01') TO ('70', '2018-11-01');


--
-- Name: impressions_2018_10_advertiser_71; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_10_advertiser_71 PARTITION OF public.impressions
FOR VALUES FROM ('71', '2018-10-01') TO ('71', '2018-11-01');


--
-- Name: impressions_2018_10_advertiser_76; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_10_advertiser_76 PARTITION OF public.impressions
FOR VALUES FROM ('76', '2018-10-01') TO ('76', '2018-11-01');


--
-- Name: impressions_2018_11_advertiser_10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_11_advertiser_10 PARTITION OF public.impressions
FOR VALUES FROM ('10', '2018-11-01') TO ('10', '2018-12-01');


--
-- Name: impressions_2018_11_advertiser_15; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_11_advertiser_15 PARTITION OF public.impressions
FOR VALUES FROM ('15', '2018-11-01') TO ('15', '2018-12-01');


--
-- Name: impressions_2018_11_advertiser_19; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_11_advertiser_19 PARTITION OF public.impressions
FOR VALUES FROM ('19', '2018-11-01') TO ('19', '2018-12-01');


--
-- Name: impressions_2018_11_advertiser_37; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_11_advertiser_37 PARTITION OF public.impressions
FOR VALUES FROM ('37', '2018-11-01') TO ('37', '2018-12-01');


--
-- Name: impressions_2018_11_advertiser_47; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_11_advertiser_47 PARTITION OF public.impressions
FOR VALUES FROM ('47', '2018-11-01') TO ('47', '2018-12-01');


--
-- Name: impressions_2018_11_advertiser_53; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_11_advertiser_53 PARTITION OF public.impressions
FOR VALUES FROM ('53', '2018-11-01') TO ('53', '2018-12-01');


--
-- Name: impressions_2018_11_advertiser_56; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_11_advertiser_56 PARTITION OF public.impressions
FOR VALUES FROM ('56', '2018-11-01') TO ('56', '2018-12-01');


--
-- Name: impressions_2018_11_advertiser_61; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_11_advertiser_61 PARTITION OF public.impressions
FOR VALUES FROM ('61', '2018-11-01') TO ('61', '2018-12-01');


--
-- Name: impressions_2018_11_advertiser_69; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_11_advertiser_69 PARTITION OF public.impressions
FOR VALUES FROM ('69', '2018-11-01') TO ('69', '2018-12-01');


--
-- Name: impressions_2018_11_advertiser_74; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_11_advertiser_74 PARTITION OF public.impressions
FOR VALUES FROM ('74', '2018-11-01') TO ('74', '2018-12-01');


--
-- Name: impressions_2018_11_advertiser_89; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_11_advertiser_89 PARTITION OF public.impressions
FOR VALUES FROM ('89', '2018-11-01') TO ('89', '2018-12-01');


--
-- Name: impressions_2018_11_advertiser_94; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_11_advertiser_94 PARTITION OF public.impressions
FOR VALUES FROM ('94', '2018-11-01') TO ('94', '2018-12-01');


--
-- Name: impressions_2018_11_advertiser_97; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_11_advertiser_97 PARTITION OF public.impressions
FOR VALUES FROM ('97', '2018-11-01') TO ('97', '2018-12-01');


--
-- Name: impressions_2018_12_advertiser_10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_12_advertiser_10 PARTITION OF public.impressions
FOR VALUES FROM ('10', '2018-12-01') TO ('10', '2019-01-01');


--
-- Name: impressions_2018_12_advertiser_15; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_12_advertiser_15 PARTITION OF public.impressions
FOR VALUES FROM ('15', '2018-12-01') TO ('15', '2019-01-01');


--
-- Name: impressions_2018_12_advertiser_19; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_12_advertiser_19 PARTITION OF public.impressions
FOR VALUES FROM ('19', '2018-12-01') TO ('19', '2019-01-01');


--
-- Name: impressions_2018_12_advertiser_2; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_12_advertiser_2 PARTITION OF public.impressions
FOR VALUES FROM ('2', '2018-12-01') TO ('2', '2019-01-01');


--
-- Name: impressions_2018_12_advertiser_22; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_12_advertiser_22 PARTITION OF public.impressions
FOR VALUES FROM ('22', '2018-12-01') TO ('22', '2019-01-01');


--
-- Name: impressions_2018_12_advertiser_25; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_12_advertiser_25 PARTITION OF public.impressions
FOR VALUES FROM ('25', '2018-12-01') TO ('25', '2019-01-01');


--
-- Name: impressions_2018_12_advertiser_27; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_12_advertiser_27 PARTITION OF public.impressions
FOR VALUES FROM ('27', '2018-12-01') TO ('27', '2019-01-01');


--
-- Name: impressions_2018_12_advertiser_37; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_12_advertiser_37 PARTITION OF public.impressions
FOR VALUES FROM ('37', '2018-12-01') TO ('37', '2019-01-01');


--
-- Name: impressions_2018_12_advertiser_43; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_12_advertiser_43 PARTITION OF public.impressions
FOR VALUES FROM ('43', '2018-12-01') TO ('43', '2019-01-01');


--
-- Name: impressions_2018_12_advertiser_45; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_12_advertiser_45 PARTITION OF public.impressions
FOR VALUES FROM ('45', '2018-12-01') TO ('45', '2019-01-01');


--
-- Name: impressions_2018_12_advertiser_47; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_12_advertiser_47 PARTITION OF public.impressions
FOR VALUES FROM ('47', '2018-12-01') TO ('47', '2019-01-01');


--
-- Name: impressions_2018_12_advertiser_53; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_12_advertiser_53 PARTITION OF public.impressions
FOR VALUES FROM ('53', '2018-12-01') TO ('53', '2019-01-01');


--
-- Name: impressions_2018_12_advertiser_61; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_12_advertiser_61 PARTITION OF public.impressions
FOR VALUES FROM ('61', '2018-12-01') TO ('61', '2019-01-01');


--
-- Name: impressions_2018_12_advertiser_69; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_12_advertiser_69 PARTITION OF public.impressions
FOR VALUES FROM ('69', '2018-12-01') TO ('69', '2019-01-01');


--
-- Name: impressions_2018_12_advertiser_74; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_12_advertiser_74 PARTITION OF public.impressions
FOR VALUES FROM ('74', '2018-12-01') TO ('74', '2019-01-01');


--
-- Name: impressions_2018_12_advertiser_87; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_12_advertiser_87 PARTITION OF public.impressions
FOR VALUES FROM ('87', '2018-12-01') TO ('87', '2019-01-01');


--
-- Name: impressions_2018_12_advertiser_88; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_12_advertiser_88 PARTITION OF public.impressions
FOR VALUES FROM ('88', '2018-12-01') TO ('88', '2019-01-01');


--
-- Name: impressions_2018_12_advertiser_89; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_12_advertiser_89 PARTITION OF public.impressions
FOR VALUES FROM ('89', '2018-12-01') TO ('89', '2019-01-01');


--
-- Name: impressions_2018_12_advertiser_9; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_12_advertiser_9 PARTITION OF public.impressions
FOR VALUES FROM ('9', '2018-12-01') TO ('9', '2019-01-01');


--
-- Name: impressions_2018_12_advertiser_91; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_12_advertiser_91 PARTITION OF public.impressions
FOR VALUES FROM ('91', '2018-12-01') TO ('91', '2019-01-01');


--
-- Name: impressions_2018_12_advertiser_98; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impressions_2018_12_advertiser_98 PARTITION OF public.impressions
FOR VALUES FROM ('98', '2018-12-01') TO ('98', '2019-01-01');


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
-- Name: versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.versions (
    id bigint NOT NULL,
    item_type character varying NOT NULL,
    item_id integer NOT NULL,
    event character varying NOT NULL,
    whodunnit character varying,
    object text,
    created_at timestamp without time zone,
    object_changes text
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
-- Name: creative_images id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creative_images ALTER COLUMN id SET DEFAULT nextval('public.creative_images_id_seq'::regclass);


--
-- Name: creatives id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creatives ALTER COLUMN id SET DEFAULT nextval('public.creatives_id_seq'::regclass);


--
-- Name: impressions_2018_03_advertiser_15 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_15 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_03_advertiser_15 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_15 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_15 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_15 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_16 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_16 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_03_advertiser_16 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_16 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_16 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_16 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_24 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_24 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_03_advertiser_24 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_24 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_24 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_24 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_27 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_27 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_03_advertiser_27 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_27 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_27 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_27 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_33 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_33 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_03_advertiser_33 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_33 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_33 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_33 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_59 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_59 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_03_advertiser_59 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_59 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_59 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_59 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_66 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_66 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_03_advertiser_66 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_66 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_66 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_66 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_74 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_74 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_03_advertiser_74 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_74 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_74 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_74 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_75 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_75 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_03_advertiser_75 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_75 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_75 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_75 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_82 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_82 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_03_advertiser_82 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_82 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_82 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_82 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_87 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_87 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_03_advertiser_87 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_87 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_87 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_87 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_92 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_92 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_03_advertiser_92 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_92 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_92 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_92 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_95 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_95 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_03_advertiser_95 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_95 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_95 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_95 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_97 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_97 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_03_advertiser_97 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_97 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_03_advertiser_97 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_03_advertiser_97 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_04_advertiser_15 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_15 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_04_advertiser_15 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_15 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_04_advertiser_15 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_15 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_04_advertiser_18 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_18 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_04_advertiser_18 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_18 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_04_advertiser_18 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_18 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_04_advertiser_27 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_27 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_04_advertiser_27 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_27 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_04_advertiser_27 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_27 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_04_advertiser_33 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_33 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_04_advertiser_33 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_33 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_04_advertiser_33 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_33 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_04_advertiser_46 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_46 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_04_advertiser_46 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_46 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_04_advertiser_46 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_46 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_04_advertiser_48 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_48 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_04_advertiser_48 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_48 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_04_advertiser_48 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_48 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_04_advertiser_49 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_49 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_04_advertiser_49 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_49 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_04_advertiser_49 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_49 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_04_advertiser_74 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_74 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_04_advertiser_74 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_74 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_04_advertiser_74 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_74 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_04_advertiser_75 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_75 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_04_advertiser_75 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_75 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_04_advertiser_75 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_75 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_04_advertiser_96 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_96 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_04_advertiser_96 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_96 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_04_advertiser_96 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_96 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_04_advertiser_97 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_97 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_04_advertiser_97 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_97 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_04_advertiser_97 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_04_advertiser_97 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_06_advertiser_18 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_18 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_06_advertiser_18 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_18 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_06_advertiser_18 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_18 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_06_advertiser_19 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_19 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_06_advertiser_19 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_19 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_06_advertiser_19 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_19 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_06_advertiser_52 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_52 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_06_advertiser_52 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_52 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_06_advertiser_52 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_52 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_06_advertiser_55 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_55 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_06_advertiser_55 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_55 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_06_advertiser_55 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_55 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_06_advertiser_62 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_62 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_06_advertiser_62 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_62 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_06_advertiser_62 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_62 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_06_advertiser_64 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_64 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_06_advertiser_64 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_64 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_06_advertiser_64 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_64 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_06_advertiser_7 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_7 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_06_advertiser_7 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_7 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_06_advertiser_7 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_7 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_06_advertiser_72 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_72 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_06_advertiser_72 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_72 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_06_advertiser_72 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_72 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_06_advertiser_85 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_85 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_06_advertiser_85 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_85 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_06_advertiser_85 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_85 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_06_advertiser_89 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_89 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_06_advertiser_89 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_89 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_06_advertiser_89 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_89 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_06_advertiser_98 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_98 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_06_advertiser_98 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_98 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_06_advertiser_98 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_06_advertiser_98 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_07_advertiser_19 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_19 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_07_advertiser_19 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_19 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_07_advertiser_19 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_19 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_07_advertiser_23 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_23 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_07_advertiser_23 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_23 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_07_advertiser_23 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_23 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_07_advertiser_39 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_39 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_07_advertiser_39 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_39 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_07_advertiser_39 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_39 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_07_advertiser_62 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_62 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_07_advertiser_62 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_62 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_07_advertiser_62 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_62 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_07_advertiser_64 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_64 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_07_advertiser_64 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_64 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_07_advertiser_64 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_64 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_07_advertiser_84 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_84 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_07_advertiser_84 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_84 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_07_advertiser_84 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_84 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_07_advertiser_85 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_85 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_07_advertiser_85 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_85 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_07_advertiser_85 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_85 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_07_advertiser_87 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_87 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_07_advertiser_87 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_87 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_07_advertiser_87 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_87 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_07_advertiser_89 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_89 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_07_advertiser_89 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_89 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_07_advertiser_89 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_89 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_07_advertiser_95 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_95 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_07_advertiser_95 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_95 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_07_advertiser_95 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_95 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_07_advertiser_96 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_96 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_07_advertiser_96 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_96 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_07_advertiser_96 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_07_advertiser_96 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_08_advertiser_39 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_39 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_08_advertiser_39 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_39 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_08_advertiser_39 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_39 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_08_advertiser_46 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_46 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_08_advertiser_46 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_46 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_08_advertiser_46 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_46 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_08_advertiser_55 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_55 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_08_advertiser_55 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_55 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_08_advertiser_55 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_55 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_08_advertiser_57 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_57 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_08_advertiser_57 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_57 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_08_advertiser_57 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_57 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_08_advertiser_58 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_58 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_08_advertiser_58 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_58 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_08_advertiser_58 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_58 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_08_advertiser_72 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_72 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_08_advertiser_72 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_72 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_08_advertiser_72 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_72 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_08_advertiser_84 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_84 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_08_advertiser_84 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_84 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_08_advertiser_84 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_84 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_08_advertiser_89 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_89 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_08_advertiser_89 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_89 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_08_advertiser_89 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_89 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_08_advertiser_95 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_95 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_08_advertiser_95 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_95 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_08_advertiser_95 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_95 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_08_advertiser_96 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_96 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_08_advertiser_96 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_96 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_08_advertiser_96 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_08_advertiser_96 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_10_advertiser_31 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_10_advertiser_31 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_10_advertiser_31 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_10_advertiser_31 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_10_advertiser_31 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_10_advertiser_31 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_10_advertiser_53 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_10_advertiser_53 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_10_advertiser_53 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_10_advertiser_53 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_10_advertiser_53 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_10_advertiser_53 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_10_advertiser_55 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_10_advertiser_55 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_10_advertiser_55 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_10_advertiser_55 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_10_advertiser_55 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_10_advertiser_55 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_10_advertiser_56 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_10_advertiser_56 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_10_advertiser_56 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_10_advertiser_56 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_10_advertiser_56 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_10_advertiser_56 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_10_advertiser_70 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_10_advertiser_70 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_10_advertiser_70 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_10_advertiser_70 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_10_advertiser_70 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_10_advertiser_70 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_10_advertiser_71 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_10_advertiser_71 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_10_advertiser_71 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_10_advertiser_71 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_10_advertiser_71 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_10_advertiser_71 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_10_advertiser_76 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_10_advertiser_76 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_10_advertiser_76 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_10_advertiser_76 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_10_advertiser_76 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_10_advertiser_76 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_10 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_11_advertiser_10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_10 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_10 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_15 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_15 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_11_advertiser_15 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_15 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_15 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_15 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_19 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_19 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_11_advertiser_19 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_19 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_19 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_19 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_37 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_37 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_11_advertiser_37 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_37 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_37 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_37 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_47 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_47 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_11_advertiser_47 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_47 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_47 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_47 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_53 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_53 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_11_advertiser_53 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_53 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_53 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_53 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_56 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_56 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_11_advertiser_56 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_56 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_56 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_56 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_61 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_61 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_11_advertiser_61 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_61 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_61 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_61 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_69 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_69 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_11_advertiser_69 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_69 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_69 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_69 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_74 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_74 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_11_advertiser_74 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_74 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_74 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_74 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_89 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_89 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_11_advertiser_89 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_89 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_89 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_89 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_94 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_94 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_11_advertiser_94 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_94 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_94 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_94 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_97 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_97 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_11_advertiser_97 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_97 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_11_advertiser_97 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_11_advertiser_97 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_10 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_10 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_12_advertiser_10 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_10 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_10 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_10 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_15 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_15 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_12_advertiser_15 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_15 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_15 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_15 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_19 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_19 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_12_advertiser_19 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_19 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_19 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_19 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_2 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_2 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_12_advertiser_2 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_2 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_2 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_2 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_22 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_22 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_12_advertiser_22 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_22 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_22 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_22 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_25 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_25 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_12_advertiser_25 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_25 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_25 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_25 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_27 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_27 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_12_advertiser_27 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_27 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_27 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_27 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_37 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_37 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_12_advertiser_37 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_37 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_37 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_37 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_43 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_43 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_12_advertiser_43 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_43 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_43 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_43 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_45 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_45 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_12_advertiser_45 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_45 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_45 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_45 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_47 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_47 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_12_advertiser_47 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_47 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_47 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_47 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_53 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_53 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_12_advertiser_53 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_53 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_53 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_53 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_61 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_61 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_12_advertiser_61 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_61 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_61 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_61 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_69 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_69 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_12_advertiser_69 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_69 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_69 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_69 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_74 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_74 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_12_advertiser_74 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_74 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_74 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_74 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_87 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_87 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_12_advertiser_87 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_87 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_87 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_87 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_88 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_88 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_12_advertiser_88 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_88 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_88 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_88 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_89 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_89 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_12_advertiser_89 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_89 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_89 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_89 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_9 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_9 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_12_advertiser_9 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_9 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_9 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_9 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_91 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_91 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_12_advertiser_91 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_91 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_91 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_91 ALTER COLUMN fallback_campaign SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_98 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_98 ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


--
-- Name: impressions_2018_12_advertiser_98 payable; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_98 ALTER COLUMN payable SET DEFAULT false;


--
-- Name: impressions_2018_12_advertiser_98 fallback_campaign; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_2018_12_advertiser_98 ALTER COLUMN fallback_campaign SET DEFAULT false;


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
-- Name: property_advertisers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.property_advertisers ALTER COLUMN id SET DEFAULT nextval('public.property_advertisers_id_seq'::regclass);


--
-- Name: publisher_invoices id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publisher_invoices ALTER COLUMN id SET DEFAULT nextval('public.publisher_invoices_id_seq'::regclass);


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
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: index_impressions_on_campaign_name_and_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_campaign_name_and_property_name ON ONLY public.impressions USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_03_advertise_campaign_name_property_name_idx10; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertise_campaign_name_property_name_idx10 ON public.impressions_2018_03_advertiser_97 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_03_advertise_campaign_name_property_name_idx11; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertise_campaign_name_property_name_idx11 ON public.impressions_2018_03_advertiser_15 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_03_advertise_campaign_name_property_name_idx12; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertise_campaign_name_property_name_idx12 ON public.impressions_2018_03_advertiser_66 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_03_advertise_campaign_name_property_name_idx13; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertise_campaign_name_property_name_idx13 ON public.impressions_2018_03_advertiser_33 USING btree (campaign_name, property_name);


--
-- Name: index_impressions_on_advertiser_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_advertiser_id ON ONLY public.impressions USING btree (advertiser_id);


--
-- Name: impressions_2018_03_advertiser_15_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_15_advertiser_id_idx ON public.impressions_2018_03_advertiser_15 USING btree (advertiser_id);


--
-- Name: index_impressions_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_campaign_id ON ONLY public.impressions USING btree (campaign_id);


--
-- Name: impressions_2018_03_advertiser_15_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_15_campaign_id_idx ON public.impressions_2018_03_advertiser_15 USING btree (campaign_id);


--
-- Name: index_impressions_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_campaign_name ON ONLY public.impressions USING btree (campaign_name);


--
-- Name: impressions_2018_03_advertiser_15_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_15_campaign_name_idx ON public.impressions_2018_03_advertiser_15 USING btree (campaign_name);


--
-- Name: index_impressions_on_country_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_country_code ON ONLY public.impressions USING btree (country_code);


--
-- Name: impressions_2018_03_advertiser_15_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_15_country_code_idx ON public.impressions_2018_03_advertiser_15 USING btree (country_code);


--
-- Name: index_impressions_on_displayed_at_hour; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_displayed_at_hour ON ONLY public.impressions USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_03_advertiser_15_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_15_date_trunc_idx ON public.impressions_2018_03_advertiser_15 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: index_impressions_on_displayed_at_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_displayed_at_date ON ONLY public.impressions USING btree (displayed_at_date);


--
-- Name: impressions_2018_03_advertiser_15_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_15_displayed_at_date_idx ON public.impressions_2018_03_advertiser_15 USING btree (displayed_at_date);


--
-- Name: index_impressions_on_payable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_payable ON ONLY public.impressions USING btree (payable);


--
-- Name: impressions_2018_03_advertiser_15_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_15_payable_idx ON public.impressions_2018_03_advertiser_15 USING btree (payable);


--
-- Name: index_impressions_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_property_id ON ONLY public.impressions USING btree (property_id);


--
-- Name: impressions_2018_03_advertiser_15_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_15_property_id_idx ON public.impressions_2018_03_advertiser_15 USING btree (property_id);


--
-- Name: index_impressions_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_property_name ON ONLY public.impressions USING btree (property_name);


--
-- Name: impressions_2018_03_advertiser_15_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_15_property_name_idx ON public.impressions_2018_03_advertiser_15 USING btree (property_name);


--
-- Name: impressions_2018_03_advertiser_16_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_16_advertiser_id_idx ON public.impressions_2018_03_advertiser_16 USING btree (advertiser_id);


--
-- Name: impressions_2018_03_advertiser_16_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_16_campaign_id_idx ON public.impressions_2018_03_advertiser_16 USING btree (campaign_id);


--
-- Name: impressions_2018_03_advertiser_16_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_16_campaign_name_idx ON public.impressions_2018_03_advertiser_16 USING btree (campaign_name);


--
-- Name: impressions_2018_03_advertiser_16_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_16_country_code_idx ON public.impressions_2018_03_advertiser_16 USING btree (country_code);


--
-- Name: impressions_2018_03_advertiser_16_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_16_date_trunc_idx ON public.impressions_2018_03_advertiser_16 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_03_advertiser_16_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_16_displayed_at_date_idx ON public.impressions_2018_03_advertiser_16 USING btree (displayed_at_date);


--
-- Name: impressions_2018_03_advertiser_16_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_16_payable_idx ON public.impressions_2018_03_advertiser_16 USING btree (payable);


--
-- Name: impressions_2018_03_advertiser_16_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_16_property_id_idx ON public.impressions_2018_03_advertiser_16 USING btree (property_id);


--
-- Name: impressions_2018_03_advertiser_16_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_16_property_name_idx ON public.impressions_2018_03_advertiser_16 USING btree (property_name);


--
-- Name: impressions_2018_03_advertiser_24_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_24_advertiser_id_idx ON public.impressions_2018_03_advertiser_24 USING btree (advertiser_id);


--
-- Name: impressions_2018_03_advertiser_24_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_24_campaign_id_idx ON public.impressions_2018_03_advertiser_24 USING btree (campaign_id);


--
-- Name: impressions_2018_03_advertiser_24_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_24_campaign_name_idx ON public.impressions_2018_03_advertiser_24 USING btree (campaign_name);


--
-- Name: impressions_2018_03_advertiser_24_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_24_country_code_idx ON public.impressions_2018_03_advertiser_24 USING btree (country_code);


--
-- Name: impressions_2018_03_advertiser_24_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_24_date_trunc_idx ON public.impressions_2018_03_advertiser_24 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_03_advertiser_24_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_24_displayed_at_date_idx ON public.impressions_2018_03_advertiser_24 USING btree (displayed_at_date);


--
-- Name: impressions_2018_03_advertiser_24_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_24_payable_idx ON public.impressions_2018_03_advertiser_24 USING btree (payable);


--
-- Name: impressions_2018_03_advertiser_24_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_24_property_id_idx ON public.impressions_2018_03_advertiser_24 USING btree (property_id);


--
-- Name: impressions_2018_03_advertiser_24_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_24_property_name_idx ON public.impressions_2018_03_advertiser_24 USING btree (property_name);


--
-- Name: impressions_2018_03_advertiser_27_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_27_advertiser_id_idx ON public.impressions_2018_03_advertiser_27 USING btree (advertiser_id);


--
-- Name: impressions_2018_03_advertiser_27_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_27_campaign_id_idx ON public.impressions_2018_03_advertiser_27 USING btree (campaign_id);


--
-- Name: impressions_2018_03_advertiser_27_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_27_campaign_name_idx ON public.impressions_2018_03_advertiser_27 USING btree (campaign_name);


--
-- Name: impressions_2018_03_advertiser_27_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_27_country_code_idx ON public.impressions_2018_03_advertiser_27 USING btree (country_code);


--
-- Name: impressions_2018_03_advertiser_27_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_27_date_trunc_idx ON public.impressions_2018_03_advertiser_27 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_03_advertiser_27_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_27_displayed_at_date_idx ON public.impressions_2018_03_advertiser_27 USING btree (displayed_at_date);


--
-- Name: impressions_2018_03_advertiser_27_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_27_payable_idx ON public.impressions_2018_03_advertiser_27 USING btree (payable);


--
-- Name: impressions_2018_03_advertiser_27_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_27_property_id_idx ON public.impressions_2018_03_advertiser_27 USING btree (property_id);


--
-- Name: impressions_2018_03_advertiser_27_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_27_property_name_idx ON public.impressions_2018_03_advertiser_27 USING btree (property_name);


--
-- Name: impressions_2018_03_advertiser_33_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_33_advertiser_id_idx ON public.impressions_2018_03_advertiser_33 USING btree (advertiser_id);


--
-- Name: impressions_2018_03_advertiser_33_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_33_campaign_id_idx ON public.impressions_2018_03_advertiser_33 USING btree (campaign_id);


--
-- Name: impressions_2018_03_advertiser_33_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_33_campaign_name_idx ON public.impressions_2018_03_advertiser_33 USING btree (campaign_name);


--
-- Name: impressions_2018_03_advertiser_33_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_33_country_code_idx ON public.impressions_2018_03_advertiser_33 USING btree (country_code);


--
-- Name: impressions_2018_03_advertiser_33_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_33_date_trunc_idx ON public.impressions_2018_03_advertiser_33 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_03_advertiser_33_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_33_displayed_at_date_idx ON public.impressions_2018_03_advertiser_33 USING btree (displayed_at_date);


--
-- Name: impressions_2018_03_advertiser_33_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_33_payable_idx ON public.impressions_2018_03_advertiser_33 USING btree (payable);


--
-- Name: impressions_2018_03_advertiser_33_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_33_property_id_idx ON public.impressions_2018_03_advertiser_33 USING btree (property_id);


--
-- Name: impressions_2018_03_advertiser_33_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_33_property_name_idx ON public.impressions_2018_03_advertiser_33 USING btree (property_name);


--
-- Name: impressions_2018_03_advertiser_59_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_59_advertiser_id_idx ON public.impressions_2018_03_advertiser_59 USING btree (advertiser_id);


--
-- Name: impressions_2018_03_advertiser_59_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_59_campaign_id_idx ON public.impressions_2018_03_advertiser_59 USING btree (campaign_id);


--
-- Name: impressions_2018_03_advertiser_59_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_59_campaign_name_idx ON public.impressions_2018_03_advertiser_59 USING btree (campaign_name);


--
-- Name: impressions_2018_03_advertiser_59_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_59_country_code_idx ON public.impressions_2018_03_advertiser_59 USING btree (country_code);


--
-- Name: impressions_2018_03_advertiser_59_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_59_date_trunc_idx ON public.impressions_2018_03_advertiser_59 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_03_advertiser_59_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_59_displayed_at_date_idx ON public.impressions_2018_03_advertiser_59 USING btree (displayed_at_date);


--
-- Name: impressions_2018_03_advertiser_59_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_59_payable_idx ON public.impressions_2018_03_advertiser_59 USING btree (payable);


--
-- Name: impressions_2018_03_advertiser_59_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_59_property_id_idx ON public.impressions_2018_03_advertiser_59 USING btree (property_id);


--
-- Name: impressions_2018_03_advertiser_59_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_59_property_name_idx ON public.impressions_2018_03_advertiser_59 USING btree (property_name);


--
-- Name: impressions_2018_03_advertiser_66_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_66_advertiser_id_idx ON public.impressions_2018_03_advertiser_66 USING btree (advertiser_id);


--
-- Name: impressions_2018_03_advertiser_66_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_66_campaign_id_idx ON public.impressions_2018_03_advertiser_66 USING btree (campaign_id);


--
-- Name: impressions_2018_03_advertiser_66_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_66_campaign_name_idx ON public.impressions_2018_03_advertiser_66 USING btree (campaign_name);


--
-- Name: impressions_2018_03_advertiser_66_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_66_country_code_idx ON public.impressions_2018_03_advertiser_66 USING btree (country_code);


--
-- Name: impressions_2018_03_advertiser_66_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_66_date_trunc_idx ON public.impressions_2018_03_advertiser_66 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_03_advertiser_66_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_66_displayed_at_date_idx ON public.impressions_2018_03_advertiser_66 USING btree (displayed_at_date);


--
-- Name: impressions_2018_03_advertiser_66_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_66_payable_idx ON public.impressions_2018_03_advertiser_66 USING btree (payable);


--
-- Name: impressions_2018_03_advertiser_66_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_66_property_id_idx ON public.impressions_2018_03_advertiser_66 USING btree (property_id);


--
-- Name: impressions_2018_03_advertiser_66_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_66_property_name_idx ON public.impressions_2018_03_advertiser_66 USING btree (property_name);


--
-- Name: impressions_2018_03_advertiser_74_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_74_advertiser_id_idx ON public.impressions_2018_03_advertiser_74 USING btree (advertiser_id);


--
-- Name: impressions_2018_03_advertiser_74_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_74_campaign_id_idx ON public.impressions_2018_03_advertiser_74 USING btree (campaign_id);


--
-- Name: impressions_2018_03_advertiser_74_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_74_campaign_name_idx ON public.impressions_2018_03_advertiser_74 USING btree (campaign_name);


--
-- Name: impressions_2018_03_advertiser_74_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_74_country_code_idx ON public.impressions_2018_03_advertiser_74 USING btree (country_code);


--
-- Name: impressions_2018_03_advertiser_74_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_74_date_trunc_idx ON public.impressions_2018_03_advertiser_74 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_03_advertiser_74_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_74_displayed_at_date_idx ON public.impressions_2018_03_advertiser_74 USING btree (displayed_at_date);


--
-- Name: impressions_2018_03_advertiser_74_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_74_payable_idx ON public.impressions_2018_03_advertiser_74 USING btree (payable);


--
-- Name: impressions_2018_03_advertiser_74_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_74_property_id_idx ON public.impressions_2018_03_advertiser_74 USING btree (property_id);


--
-- Name: impressions_2018_03_advertiser_74_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_74_property_name_idx ON public.impressions_2018_03_advertiser_74 USING btree (property_name);


--
-- Name: impressions_2018_03_advertiser_75_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_75_advertiser_id_idx ON public.impressions_2018_03_advertiser_75 USING btree (advertiser_id);


--
-- Name: impressions_2018_03_advertiser_75_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_75_campaign_id_idx ON public.impressions_2018_03_advertiser_75 USING btree (campaign_id);


--
-- Name: impressions_2018_03_advertiser_75_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_75_campaign_name_idx ON public.impressions_2018_03_advertiser_75 USING btree (campaign_name);


--
-- Name: impressions_2018_03_advertiser_75_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_75_country_code_idx ON public.impressions_2018_03_advertiser_75 USING btree (country_code);


--
-- Name: impressions_2018_03_advertiser_75_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_75_date_trunc_idx ON public.impressions_2018_03_advertiser_75 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_03_advertiser_75_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_75_displayed_at_date_idx ON public.impressions_2018_03_advertiser_75 USING btree (displayed_at_date);


--
-- Name: impressions_2018_03_advertiser_75_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_75_payable_idx ON public.impressions_2018_03_advertiser_75 USING btree (payable);


--
-- Name: impressions_2018_03_advertiser_75_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_75_property_id_idx ON public.impressions_2018_03_advertiser_75 USING btree (property_id);


--
-- Name: impressions_2018_03_advertiser_75_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_75_property_name_idx ON public.impressions_2018_03_advertiser_75 USING btree (property_name);


--
-- Name: impressions_2018_03_advertiser_82_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_82_advertiser_id_idx ON public.impressions_2018_03_advertiser_82 USING btree (advertiser_id);


--
-- Name: impressions_2018_03_advertiser_82_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_82_campaign_id_idx ON public.impressions_2018_03_advertiser_82 USING btree (campaign_id);


--
-- Name: impressions_2018_03_advertiser_82_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_82_campaign_name_idx ON public.impressions_2018_03_advertiser_82 USING btree (campaign_name);


--
-- Name: impressions_2018_03_advertiser_82_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_82_country_code_idx ON public.impressions_2018_03_advertiser_82 USING btree (country_code);


--
-- Name: impressions_2018_03_advertiser_82_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_82_date_trunc_idx ON public.impressions_2018_03_advertiser_82 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_03_advertiser_82_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_82_displayed_at_date_idx ON public.impressions_2018_03_advertiser_82 USING btree (displayed_at_date);


--
-- Name: impressions_2018_03_advertiser_82_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_82_payable_idx ON public.impressions_2018_03_advertiser_82 USING btree (payable);


--
-- Name: impressions_2018_03_advertiser_82_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_82_property_id_idx ON public.impressions_2018_03_advertiser_82 USING btree (property_id);


--
-- Name: impressions_2018_03_advertiser_82_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_82_property_name_idx ON public.impressions_2018_03_advertiser_82 USING btree (property_name);


--
-- Name: impressions_2018_03_advertiser_87_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_87_advertiser_id_idx ON public.impressions_2018_03_advertiser_87 USING btree (advertiser_id);


--
-- Name: impressions_2018_03_advertiser_87_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_87_campaign_id_idx ON public.impressions_2018_03_advertiser_87 USING btree (campaign_id);


--
-- Name: impressions_2018_03_advertiser_87_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_87_campaign_name_idx ON public.impressions_2018_03_advertiser_87 USING btree (campaign_name);


--
-- Name: impressions_2018_03_advertiser_87_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_87_country_code_idx ON public.impressions_2018_03_advertiser_87 USING btree (country_code);


--
-- Name: impressions_2018_03_advertiser_87_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_87_date_trunc_idx ON public.impressions_2018_03_advertiser_87 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_03_advertiser_87_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_87_displayed_at_date_idx ON public.impressions_2018_03_advertiser_87 USING btree (displayed_at_date);


--
-- Name: impressions_2018_03_advertiser_87_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_87_payable_idx ON public.impressions_2018_03_advertiser_87 USING btree (payable);


--
-- Name: impressions_2018_03_advertiser_87_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_87_property_id_idx ON public.impressions_2018_03_advertiser_87 USING btree (property_id);


--
-- Name: impressions_2018_03_advertiser_87_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_87_property_name_idx ON public.impressions_2018_03_advertiser_87 USING btree (property_name);


--
-- Name: impressions_2018_03_advertiser_92_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_92_advertiser_id_idx ON public.impressions_2018_03_advertiser_92 USING btree (advertiser_id);


--
-- Name: impressions_2018_03_advertiser_92_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_92_campaign_id_idx ON public.impressions_2018_03_advertiser_92 USING btree (campaign_id);


--
-- Name: impressions_2018_03_advertiser_92_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_92_campaign_name_idx ON public.impressions_2018_03_advertiser_92 USING btree (campaign_name);


--
-- Name: impressions_2018_03_advertiser_92_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_92_country_code_idx ON public.impressions_2018_03_advertiser_92 USING btree (country_code);


--
-- Name: impressions_2018_03_advertiser_92_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_92_date_trunc_idx ON public.impressions_2018_03_advertiser_92 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_03_advertiser_92_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_92_displayed_at_date_idx ON public.impressions_2018_03_advertiser_92 USING btree (displayed_at_date);


--
-- Name: impressions_2018_03_advertiser_92_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_92_payable_idx ON public.impressions_2018_03_advertiser_92 USING btree (payable);


--
-- Name: impressions_2018_03_advertiser_92_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_92_property_id_idx ON public.impressions_2018_03_advertiser_92 USING btree (property_id);


--
-- Name: impressions_2018_03_advertiser_92_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_92_property_name_idx ON public.impressions_2018_03_advertiser_92 USING btree (property_name);


--
-- Name: impressions_2018_03_advertiser_95_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_95_advertiser_id_idx ON public.impressions_2018_03_advertiser_95 USING btree (advertiser_id);


--
-- Name: impressions_2018_03_advertiser_95_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_95_campaign_id_idx ON public.impressions_2018_03_advertiser_95 USING btree (campaign_id);


--
-- Name: impressions_2018_03_advertiser_95_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_95_campaign_name_idx ON public.impressions_2018_03_advertiser_95 USING btree (campaign_name);


--
-- Name: impressions_2018_03_advertiser_95_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_95_country_code_idx ON public.impressions_2018_03_advertiser_95 USING btree (country_code);


--
-- Name: impressions_2018_03_advertiser_95_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_95_date_trunc_idx ON public.impressions_2018_03_advertiser_95 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_03_advertiser_95_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_95_displayed_at_date_idx ON public.impressions_2018_03_advertiser_95 USING btree (displayed_at_date);


--
-- Name: impressions_2018_03_advertiser_95_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_95_payable_idx ON public.impressions_2018_03_advertiser_95 USING btree (payable);


--
-- Name: impressions_2018_03_advertiser_95_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_95_property_id_idx ON public.impressions_2018_03_advertiser_95 USING btree (property_id);


--
-- Name: impressions_2018_03_advertiser_95_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_95_property_name_idx ON public.impressions_2018_03_advertiser_95 USING btree (property_name);


--
-- Name: impressions_2018_03_advertiser_97_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_97_advertiser_id_idx ON public.impressions_2018_03_advertiser_97 USING btree (advertiser_id);


--
-- Name: impressions_2018_03_advertiser_97_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_97_campaign_id_idx ON public.impressions_2018_03_advertiser_97 USING btree (campaign_id);


--
-- Name: impressions_2018_03_advertiser_97_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_97_campaign_name_idx ON public.impressions_2018_03_advertiser_97 USING btree (campaign_name);


--
-- Name: impressions_2018_03_advertiser_97_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_97_country_code_idx ON public.impressions_2018_03_advertiser_97 USING btree (country_code);


--
-- Name: impressions_2018_03_advertiser_97_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_97_date_trunc_idx ON public.impressions_2018_03_advertiser_97 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_03_advertiser_97_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_97_displayed_at_date_idx ON public.impressions_2018_03_advertiser_97 USING btree (displayed_at_date);


--
-- Name: impressions_2018_03_advertiser_97_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_97_payable_idx ON public.impressions_2018_03_advertiser_97 USING btree (payable);


--
-- Name: impressions_2018_03_advertiser_97_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_97_property_id_idx ON public.impressions_2018_03_advertiser_97 USING btree (property_id);


--
-- Name: impressions_2018_03_advertiser_97_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_97_property_name_idx ON public.impressions_2018_03_advertiser_97 USING btree (property_name);


--
-- Name: impressions_2018_03_advertiser__campaign_name_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser__campaign_name_property_name_idx ON public.impressions_2018_03_advertiser_16 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_03_advertiser_campaign_name_property_name_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_campaign_name_property_name_idx1 ON public.impressions_2018_03_advertiser_27 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_03_advertiser_campaign_name_property_name_idx2; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_campaign_name_property_name_idx2 ON public.impressions_2018_03_advertiser_87 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_03_advertiser_campaign_name_property_name_idx3; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_campaign_name_property_name_idx3 ON public.impressions_2018_03_advertiser_74 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_03_advertiser_campaign_name_property_name_idx4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_campaign_name_property_name_idx4 ON public.impressions_2018_03_advertiser_75 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_03_advertiser_campaign_name_property_name_idx5; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_campaign_name_property_name_idx5 ON public.impressions_2018_03_advertiser_24 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_03_advertiser_campaign_name_property_name_idx6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_campaign_name_property_name_idx6 ON public.impressions_2018_03_advertiser_95 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_03_advertiser_campaign_name_property_name_idx7; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_campaign_name_property_name_idx7 ON public.impressions_2018_03_advertiser_82 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_03_advertiser_campaign_name_property_name_idx8; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_campaign_name_property_name_idx8 ON public.impressions_2018_03_advertiser_59 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_03_advertiser_campaign_name_property_name_idx9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_03_advertiser_campaign_name_property_name_idx9 ON public.impressions_2018_03_advertiser_92 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_04_advertise_campaign_name_property_name_idx10; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertise_campaign_name_property_name_idx10 ON public.impressions_2018_04_advertiser_49 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_04_advertiser_15_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_15_advertiser_id_idx ON public.impressions_2018_04_advertiser_15 USING btree (advertiser_id);


--
-- Name: impressions_2018_04_advertiser_15_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_15_campaign_id_idx ON public.impressions_2018_04_advertiser_15 USING btree (campaign_id);


--
-- Name: impressions_2018_04_advertiser_15_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_15_campaign_name_idx ON public.impressions_2018_04_advertiser_15 USING btree (campaign_name);


--
-- Name: impressions_2018_04_advertiser_15_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_15_country_code_idx ON public.impressions_2018_04_advertiser_15 USING btree (country_code);


--
-- Name: impressions_2018_04_advertiser_15_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_15_date_trunc_idx ON public.impressions_2018_04_advertiser_15 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_04_advertiser_15_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_15_displayed_at_date_idx ON public.impressions_2018_04_advertiser_15 USING btree (displayed_at_date);


--
-- Name: impressions_2018_04_advertiser_15_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_15_payable_idx ON public.impressions_2018_04_advertiser_15 USING btree (payable);


--
-- Name: impressions_2018_04_advertiser_15_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_15_property_id_idx ON public.impressions_2018_04_advertiser_15 USING btree (property_id);


--
-- Name: impressions_2018_04_advertiser_15_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_15_property_name_idx ON public.impressions_2018_04_advertiser_15 USING btree (property_name);


--
-- Name: impressions_2018_04_advertiser_18_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_18_advertiser_id_idx ON public.impressions_2018_04_advertiser_18 USING btree (advertiser_id);


--
-- Name: impressions_2018_04_advertiser_18_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_18_campaign_id_idx ON public.impressions_2018_04_advertiser_18 USING btree (campaign_id);


--
-- Name: impressions_2018_04_advertiser_18_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_18_campaign_name_idx ON public.impressions_2018_04_advertiser_18 USING btree (campaign_name);


--
-- Name: impressions_2018_04_advertiser_18_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_18_country_code_idx ON public.impressions_2018_04_advertiser_18 USING btree (country_code);


--
-- Name: impressions_2018_04_advertiser_18_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_18_date_trunc_idx ON public.impressions_2018_04_advertiser_18 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_04_advertiser_18_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_18_displayed_at_date_idx ON public.impressions_2018_04_advertiser_18 USING btree (displayed_at_date);


--
-- Name: impressions_2018_04_advertiser_18_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_18_payable_idx ON public.impressions_2018_04_advertiser_18 USING btree (payable);


--
-- Name: impressions_2018_04_advertiser_18_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_18_property_id_idx ON public.impressions_2018_04_advertiser_18 USING btree (property_id);


--
-- Name: impressions_2018_04_advertiser_18_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_18_property_name_idx ON public.impressions_2018_04_advertiser_18 USING btree (property_name);


--
-- Name: impressions_2018_04_advertiser_27_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_27_advertiser_id_idx ON public.impressions_2018_04_advertiser_27 USING btree (advertiser_id);


--
-- Name: impressions_2018_04_advertiser_27_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_27_campaign_id_idx ON public.impressions_2018_04_advertiser_27 USING btree (campaign_id);


--
-- Name: impressions_2018_04_advertiser_27_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_27_campaign_name_idx ON public.impressions_2018_04_advertiser_27 USING btree (campaign_name);


--
-- Name: impressions_2018_04_advertiser_27_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_27_country_code_idx ON public.impressions_2018_04_advertiser_27 USING btree (country_code);


--
-- Name: impressions_2018_04_advertiser_27_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_27_date_trunc_idx ON public.impressions_2018_04_advertiser_27 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_04_advertiser_27_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_27_displayed_at_date_idx ON public.impressions_2018_04_advertiser_27 USING btree (displayed_at_date);


--
-- Name: impressions_2018_04_advertiser_27_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_27_payable_idx ON public.impressions_2018_04_advertiser_27 USING btree (payable);


--
-- Name: impressions_2018_04_advertiser_27_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_27_property_id_idx ON public.impressions_2018_04_advertiser_27 USING btree (property_id);


--
-- Name: impressions_2018_04_advertiser_27_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_27_property_name_idx ON public.impressions_2018_04_advertiser_27 USING btree (property_name);


--
-- Name: impressions_2018_04_advertiser_33_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_33_advertiser_id_idx ON public.impressions_2018_04_advertiser_33 USING btree (advertiser_id);


--
-- Name: impressions_2018_04_advertiser_33_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_33_campaign_id_idx ON public.impressions_2018_04_advertiser_33 USING btree (campaign_id);


--
-- Name: impressions_2018_04_advertiser_33_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_33_campaign_name_idx ON public.impressions_2018_04_advertiser_33 USING btree (campaign_name);


--
-- Name: impressions_2018_04_advertiser_33_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_33_country_code_idx ON public.impressions_2018_04_advertiser_33 USING btree (country_code);


--
-- Name: impressions_2018_04_advertiser_33_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_33_date_trunc_idx ON public.impressions_2018_04_advertiser_33 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_04_advertiser_33_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_33_displayed_at_date_idx ON public.impressions_2018_04_advertiser_33 USING btree (displayed_at_date);


--
-- Name: impressions_2018_04_advertiser_33_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_33_payable_idx ON public.impressions_2018_04_advertiser_33 USING btree (payable);


--
-- Name: impressions_2018_04_advertiser_33_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_33_property_id_idx ON public.impressions_2018_04_advertiser_33 USING btree (property_id);


--
-- Name: impressions_2018_04_advertiser_33_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_33_property_name_idx ON public.impressions_2018_04_advertiser_33 USING btree (property_name);


--
-- Name: impressions_2018_04_advertiser_46_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_46_advertiser_id_idx ON public.impressions_2018_04_advertiser_46 USING btree (advertiser_id);


--
-- Name: impressions_2018_04_advertiser_46_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_46_campaign_id_idx ON public.impressions_2018_04_advertiser_46 USING btree (campaign_id);


--
-- Name: impressions_2018_04_advertiser_46_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_46_campaign_name_idx ON public.impressions_2018_04_advertiser_46 USING btree (campaign_name);


--
-- Name: impressions_2018_04_advertiser_46_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_46_country_code_idx ON public.impressions_2018_04_advertiser_46 USING btree (country_code);


--
-- Name: impressions_2018_04_advertiser_46_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_46_date_trunc_idx ON public.impressions_2018_04_advertiser_46 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_04_advertiser_46_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_46_displayed_at_date_idx ON public.impressions_2018_04_advertiser_46 USING btree (displayed_at_date);


--
-- Name: impressions_2018_04_advertiser_46_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_46_payable_idx ON public.impressions_2018_04_advertiser_46 USING btree (payable);


--
-- Name: impressions_2018_04_advertiser_46_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_46_property_id_idx ON public.impressions_2018_04_advertiser_46 USING btree (property_id);


--
-- Name: impressions_2018_04_advertiser_46_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_46_property_name_idx ON public.impressions_2018_04_advertiser_46 USING btree (property_name);


--
-- Name: impressions_2018_04_advertiser_48_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_48_advertiser_id_idx ON public.impressions_2018_04_advertiser_48 USING btree (advertiser_id);


--
-- Name: impressions_2018_04_advertiser_48_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_48_campaign_id_idx ON public.impressions_2018_04_advertiser_48 USING btree (campaign_id);


--
-- Name: impressions_2018_04_advertiser_48_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_48_campaign_name_idx ON public.impressions_2018_04_advertiser_48 USING btree (campaign_name);


--
-- Name: impressions_2018_04_advertiser_48_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_48_country_code_idx ON public.impressions_2018_04_advertiser_48 USING btree (country_code);


--
-- Name: impressions_2018_04_advertiser_48_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_48_date_trunc_idx ON public.impressions_2018_04_advertiser_48 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_04_advertiser_48_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_48_displayed_at_date_idx ON public.impressions_2018_04_advertiser_48 USING btree (displayed_at_date);


--
-- Name: impressions_2018_04_advertiser_48_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_48_payable_idx ON public.impressions_2018_04_advertiser_48 USING btree (payable);


--
-- Name: impressions_2018_04_advertiser_48_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_48_property_id_idx ON public.impressions_2018_04_advertiser_48 USING btree (property_id);


--
-- Name: impressions_2018_04_advertiser_48_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_48_property_name_idx ON public.impressions_2018_04_advertiser_48 USING btree (property_name);


--
-- Name: impressions_2018_04_advertiser_49_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_49_advertiser_id_idx ON public.impressions_2018_04_advertiser_49 USING btree (advertiser_id);


--
-- Name: impressions_2018_04_advertiser_49_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_49_campaign_id_idx ON public.impressions_2018_04_advertiser_49 USING btree (campaign_id);


--
-- Name: impressions_2018_04_advertiser_49_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_49_campaign_name_idx ON public.impressions_2018_04_advertiser_49 USING btree (campaign_name);


--
-- Name: impressions_2018_04_advertiser_49_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_49_country_code_idx ON public.impressions_2018_04_advertiser_49 USING btree (country_code);


--
-- Name: impressions_2018_04_advertiser_49_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_49_date_trunc_idx ON public.impressions_2018_04_advertiser_49 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_04_advertiser_49_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_49_displayed_at_date_idx ON public.impressions_2018_04_advertiser_49 USING btree (displayed_at_date);


--
-- Name: impressions_2018_04_advertiser_49_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_49_payable_idx ON public.impressions_2018_04_advertiser_49 USING btree (payable);


--
-- Name: impressions_2018_04_advertiser_49_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_49_property_id_idx ON public.impressions_2018_04_advertiser_49 USING btree (property_id);


--
-- Name: impressions_2018_04_advertiser_49_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_49_property_name_idx ON public.impressions_2018_04_advertiser_49 USING btree (property_name);


--
-- Name: impressions_2018_04_advertiser_74_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_74_advertiser_id_idx ON public.impressions_2018_04_advertiser_74 USING btree (advertiser_id);


--
-- Name: impressions_2018_04_advertiser_74_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_74_campaign_id_idx ON public.impressions_2018_04_advertiser_74 USING btree (campaign_id);


--
-- Name: impressions_2018_04_advertiser_74_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_74_campaign_name_idx ON public.impressions_2018_04_advertiser_74 USING btree (campaign_name);


--
-- Name: impressions_2018_04_advertiser_74_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_74_country_code_idx ON public.impressions_2018_04_advertiser_74 USING btree (country_code);


--
-- Name: impressions_2018_04_advertiser_74_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_74_date_trunc_idx ON public.impressions_2018_04_advertiser_74 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_04_advertiser_74_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_74_displayed_at_date_idx ON public.impressions_2018_04_advertiser_74 USING btree (displayed_at_date);


--
-- Name: impressions_2018_04_advertiser_74_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_74_payable_idx ON public.impressions_2018_04_advertiser_74 USING btree (payable);


--
-- Name: impressions_2018_04_advertiser_74_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_74_property_id_idx ON public.impressions_2018_04_advertiser_74 USING btree (property_id);


--
-- Name: impressions_2018_04_advertiser_74_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_74_property_name_idx ON public.impressions_2018_04_advertiser_74 USING btree (property_name);


--
-- Name: impressions_2018_04_advertiser_75_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_75_advertiser_id_idx ON public.impressions_2018_04_advertiser_75 USING btree (advertiser_id);


--
-- Name: impressions_2018_04_advertiser_75_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_75_campaign_id_idx ON public.impressions_2018_04_advertiser_75 USING btree (campaign_id);


--
-- Name: impressions_2018_04_advertiser_75_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_75_campaign_name_idx ON public.impressions_2018_04_advertiser_75 USING btree (campaign_name);


--
-- Name: impressions_2018_04_advertiser_75_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_75_country_code_idx ON public.impressions_2018_04_advertiser_75 USING btree (country_code);


--
-- Name: impressions_2018_04_advertiser_75_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_75_date_trunc_idx ON public.impressions_2018_04_advertiser_75 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_04_advertiser_75_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_75_displayed_at_date_idx ON public.impressions_2018_04_advertiser_75 USING btree (displayed_at_date);


--
-- Name: impressions_2018_04_advertiser_75_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_75_payable_idx ON public.impressions_2018_04_advertiser_75 USING btree (payable);


--
-- Name: impressions_2018_04_advertiser_75_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_75_property_id_idx ON public.impressions_2018_04_advertiser_75 USING btree (property_id);


--
-- Name: impressions_2018_04_advertiser_75_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_75_property_name_idx ON public.impressions_2018_04_advertiser_75 USING btree (property_name);


--
-- Name: impressions_2018_04_advertiser_96_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_96_advertiser_id_idx ON public.impressions_2018_04_advertiser_96 USING btree (advertiser_id);


--
-- Name: impressions_2018_04_advertiser_96_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_96_campaign_id_idx ON public.impressions_2018_04_advertiser_96 USING btree (campaign_id);


--
-- Name: impressions_2018_04_advertiser_96_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_96_campaign_name_idx ON public.impressions_2018_04_advertiser_96 USING btree (campaign_name);


--
-- Name: impressions_2018_04_advertiser_96_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_96_country_code_idx ON public.impressions_2018_04_advertiser_96 USING btree (country_code);


--
-- Name: impressions_2018_04_advertiser_96_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_96_date_trunc_idx ON public.impressions_2018_04_advertiser_96 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_04_advertiser_96_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_96_displayed_at_date_idx ON public.impressions_2018_04_advertiser_96 USING btree (displayed_at_date);


--
-- Name: impressions_2018_04_advertiser_96_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_96_payable_idx ON public.impressions_2018_04_advertiser_96 USING btree (payable);


--
-- Name: impressions_2018_04_advertiser_96_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_96_property_id_idx ON public.impressions_2018_04_advertiser_96 USING btree (property_id);


--
-- Name: impressions_2018_04_advertiser_96_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_96_property_name_idx ON public.impressions_2018_04_advertiser_96 USING btree (property_name);


--
-- Name: impressions_2018_04_advertiser_97_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_97_advertiser_id_idx ON public.impressions_2018_04_advertiser_97 USING btree (advertiser_id);


--
-- Name: impressions_2018_04_advertiser_97_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_97_campaign_id_idx ON public.impressions_2018_04_advertiser_97 USING btree (campaign_id);


--
-- Name: impressions_2018_04_advertiser_97_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_97_campaign_name_idx ON public.impressions_2018_04_advertiser_97 USING btree (campaign_name);


--
-- Name: impressions_2018_04_advertiser_97_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_97_country_code_idx ON public.impressions_2018_04_advertiser_97 USING btree (country_code);


--
-- Name: impressions_2018_04_advertiser_97_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_97_date_trunc_idx ON public.impressions_2018_04_advertiser_97 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_04_advertiser_97_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_97_displayed_at_date_idx ON public.impressions_2018_04_advertiser_97 USING btree (displayed_at_date);


--
-- Name: impressions_2018_04_advertiser_97_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_97_payable_idx ON public.impressions_2018_04_advertiser_97 USING btree (payable);


--
-- Name: impressions_2018_04_advertiser_97_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_97_property_id_idx ON public.impressions_2018_04_advertiser_97 USING btree (property_id);


--
-- Name: impressions_2018_04_advertiser_97_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_97_property_name_idx ON public.impressions_2018_04_advertiser_97 USING btree (property_name);


--
-- Name: impressions_2018_04_advertiser__campaign_name_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser__campaign_name_property_name_idx ON public.impressions_2018_04_advertiser_97 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_04_advertiser_campaign_name_property_name_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_campaign_name_property_name_idx1 ON public.impressions_2018_04_advertiser_15 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_04_advertiser_campaign_name_property_name_idx2; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_campaign_name_property_name_idx2 ON public.impressions_2018_04_advertiser_75 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_04_advertiser_campaign_name_property_name_idx3; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_campaign_name_property_name_idx3 ON public.impressions_2018_04_advertiser_27 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_04_advertiser_campaign_name_property_name_idx4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_campaign_name_property_name_idx4 ON public.impressions_2018_04_advertiser_48 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_04_advertiser_campaign_name_property_name_idx5; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_campaign_name_property_name_idx5 ON public.impressions_2018_04_advertiser_46 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_04_advertiser_campaign_name_property_name_idx6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_campaign_name_property_name_idx6 ON public.impressions_2018_04_advertiser_74 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_04_advertiser_campaign_name_property_name_idx7; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_campaign_name_property_name_idx7 ON public.impressions_2018_04_advertiser_33 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_04_advertiser_campaign_name_property_name_idx8; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_campaign_name_property_name_idx8 ON public.impressions_2018_04_advertiser_96 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_04_advertiser_campaign_name_property_name_idx9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_04_advertiser_campaign_name_property_name_idx9 ON public.impressions_2018_04_advertiser_18 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_06_advertise_campaign_name_property_name_idx10; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertise_campaign_name_property_name_idx10 ON public.impressions_2018_06_advertiser_55 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_06_advertiser_18_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_18_advertiser_id_idx ON public.impressions_2018_06_advertiser_18 USING btree (advertiser_id);


--
-- Name: impressions_2018_06_advertiser_18_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_18_campaign_id_idx ON public.impressions_2018_06_advertiser_18 USING btree (campaign_id);


--
-- Name: impressions_2018_06_advertiser_18_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_18_campaign_name_idx ON public.impressions_2018_06_advertiser_18 USING btree (campaign_name);


--
-- Name: impressions_2018_06_advertiser_18_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_18_country_code_idx ON public.impressions_2018_06_advertiser_18 USING btree (country_code);


--
-- Name: impressions_2018_06_advertiser_18_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_18_date_trunc_idx ON public.impressions_2018_06_advertiser_18 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_06_advertiser_18_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_18_displayed_at_date_idx ON public.impressions_2018_06_advertiser_18 USING btree (displayed_at_date);


--
-- Name: impressions_2018_06_advertiser_18_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_18_payable_idx ON public.impressions_2018_06_advertiser_18 USING btree (payable);


--
-- Name: impressions_2018_06_advertiser_18_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_18_property_id_idx ON public.impressions_2018_06_advertiser_18 USING btree (property_id);


--
-- Name: impressions_2018_06_advertiser_18_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_18_property_name_idx ON public.impressions_2018_06_advertiser_18 USING btree (property_name);


--
-- Name: impressions_2018_06_advertiser_19_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_19_advertiser_id_idx ON public.impressions_2018_06_advertiser_19 USING btree (advertiser_id);


--
-- Name: impressions_2018_06_advertiser_19_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_19_campaign_id_idx ON public.impressions_2018_06_advertiser_19 USING btree (campaign_id);


--
-- Name: impressions_2018_06_advertiser_19_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_19_campaign_name_idx ON public.impressions_2018_06_advertiser_19 USING btree (campaign_name);


--
-- Name: impressions_2018_06_advertiser_19_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_19_country_code_idx ON public.impressions_2018_06_advertiser_19 USING btree (country_code);


--
-- Name: impressions_2018_06_advertiser_19_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_19_date_trunc_idx ON public.impressions_2018_06_advertiser_19 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_06_advertiser_19_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_19_displayed_at_date_idx ON public.impressions_2018_06_advertiser_19 USING btree (displayed_at_date);


--
-- Name: impressions_2018_06_advertiser_19_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_19_payable_idx ON public.impressions_2018_06_advertiser_19 USING btree (payable);


--
-- Name: impressions_2018_06_advertiser_19_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_19_property_id_idx ON public.impressions_2018_06_advertiser_19 USING btree (property_id);


--
-- Name: impressions_2018_06_advertiser_19_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_19_property_name_idx ON public.impressions_2018_06_advertiser_19 USING btree (property_name);


--
-- Name: impressions_2018_06_advertiser_52_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_52_advertiser_id_idx ON public.impressions_2018_06_advertiser_52 USING btree (advertiser_id);


--
-- Name: impressions_2018_06_advertiser_52_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_52_campaign_id_idx ON public.impressions_2018_06_advertiser_52 USING btree (campaign_id);


--
-- Name: impressions_2018_06_advertiser_52_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_52_campaign_name_idx ON public.impressions_2018_06_advertiser_52 USING btree (campaign_name);


--
-- Name: impressions_2018_06_advertiser_52_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_52_country_code_idx ON public.impressions_2018_06_advertiser_52 USING btree (country_code);


--
-- Name: impressions_2018_06_advertiser_52_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_52_date_trunc_idx ON public.impressions_2018_06_advertiser_52 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_06_advertiser_52_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_52_displayed_at_date_idx ON public.impressions_2018_06_advertiser_52 USING btree (displayed_at_date);


--
-- Name: impressions_2018_06_advertiser_52_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_52_payable_idx ON public.impressions_2018_06_advertiser_52 USING btree (payable);


--
-- Name: impressions_2018_06_advertiser_52_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_52_property_id_idx ON public.impressions_2018_06_advertiser_52 USING btree (property_id);


--
-- Name: impressions_2018_06_advertiser_52_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_52_property_name_idx ON public.impressions_2018_06_advertiser_52 USING btree (property_name);


--
-- Name: impressions_2018_06_advertiser_55_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_55_advertiser_id_idx ON public.impressions_2018_06_advertiser_55 USING btree (advertiser_id);


--
-- Name: impressions_2018_06_advertiser_55_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_55_campaign_id_idx ON public.impressions_2018_06_advertiser_55 USING btree (campaign_id);


--
-- Name: impressions_2018_06_advertiser_55_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_55_campaign_name_idx ON public.impressions_2018_06_advertiser_55 USING btree (campaign_name);


--
-- Name: impressions_2018_06_advertiser_55_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_55_country_code_idx ON public.impressions_2018_06_advertiser_55 USING btree (country_code);


--
-- Name: impressions_2018_06_advertiser_55_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_55_date_trunc_idx ON public.impressions_2018_06_advertiser_55 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_06_advertiser_55_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_55_displayed_at_date_idx ON public.impressions_2018_06_advertiser_55 USING btree (displayed_at_date);


--
-- Name: impressions_2018_06_advertiser_55_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_55_payable_idx ON public.impressions_2018_06_advertiser_55 USING btree (payable);


--
-- Name: impressions_2018_06_advertiser_55_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_55_property_id_idx ON public.impressions_2018_06_advertiser_55 USING btree (property_id);


--
-- Name: impressions_2018_06_advertiser_55_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_55_property_name_idx ON public.impressions_2018_06_advertiser_55 USING btree (property_name);


--
-- Name: impressions_2018_06_advertiser_62_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_62_advertiser_id_idx ON public.impressions_2018_06_advertiser_62 USING btree (advertiser_id);


--
-- Name: impressions_2018_06_advertiser_62_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_62_campaign_id_idx ON public.impressions_2018_06_advertiser_62 USING btree (campaign_id);


--
-- Name: impressions_2018_06_advertiser_62_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_62_campaign_name_idx ON public.impressions_2018_06_advertiser_62 USING btree (campaign_name);


--
-- Name: impressions_2018_06_advertiser_62_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_62_country_code_idx ON public.impressions_2018_06_advertiser_62 USING btree (country_code);


--
-- Name: impressions_2018_06_advertiser_62_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_62_date_trunc_idx ON public.impressions_2018_06_advertiser_62 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_06_advertiser_62_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_62_displayed_at_date_idx ON public.impressions_2018_06_advertiser_62 USING btree (displayed_at_date);


--
-- Name: impressions_2018_06_advertiser_62_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_62_payable_idx ON public.impressions_2018_06_advertiser_62 USING btree (payable);


--
-- Name: impressions_2018_06_advertiser_62_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_62_property_id_idx ON public.impressions_2018_06_advertiser_62 USING btree (property_id);


--
-- Name: impressions_2018_06_advertiser_62_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_62_property_name_idx ON public.impressions_2018_06_advertiser_62 USING btree (property_name);


--
-- Name: impressions_2018_06_advertiser_64_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_64_advertiser_id_idx ON public.impressions_2018_06_advertiser_64 USING btree (advertiser_id);


--
-- Name: impressions_2018_06_advertiser_64_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_64_campaign_id_idx ON public.impressions_2018_06_advertiser_64 USING btree (campaign_id);


--
-- Name: impressions_2018_06_advertiser_64_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_64_campaign_name_idx ON public.impressions_2018_06_advertiser_64 USING btree (campaign_name);


--
-- Name: impressions_2018_06_advertiser_64_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_64_country_code_idx ON public.impressions_2018_06_advertiser_64 USING btree (country_code);


--
-- Name: impressions_2018_06_advertiser_64_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_64_date_trunc_idx ON public.impressions_2018_06_advertiser_64 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_06_advertiser_64_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_64_displayed_at_date_idx ON public.impressions_2018_06_advertiser_64 USING btree (displayed_at_date);


--
-- Name: impressions_2018_06_advertiser_64_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_64_payable_idx ON public.impressions_2018_06_advertiser_64 USING btree (payable);


--
-- Name: impressions_2018_06_advertiser_64_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_64_property_id_idx ON public.impressions_2018_06_advertiser_64 USING btree (property_id);


--
-- Name: impressions_2018_06_advertiser_64_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_64_property_name_idx ON public.impressions_2018_06_advertiser_64 USING btree (property_name);


--
-- Name: impressions_2018_06_advertiser_72_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_72_advertiser_id_idx ON public.impressions_2018_06_advertiser_72 USING btree (advertiser_id);


--
-- Name: impressions_2018_06_advertiser_72_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_72_campaign_id_idx ON public.impressions_2018_06_advertiser_72 USING btree (campaign_id);


--
-- Name: impressions_2018_06_advertiser_72_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_72_campaign_name_idx ON public.impressions_2018_06_advertiser_72 USING btree (campaign_name);


--
-- Name: impressions_2018_06_advertiser_72_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_72_country_code_idx ON public.impressions_2018_06_advertiser_72 USING btree (country_code);


--
-- Name: impressions_2018_06_advertiser_72_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_72_date_trunc_idx ON public.impressions_2018_06_advertiser_72 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_06_advertiser_72_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_72_displayed_at_date_idx ON public.impressions_2018_06_advertiser_72 USING btree (displayed_at_date);


--
-- Name: impressions_2018_06_advertiser_72_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_72_payable_idx ON public.impressions_2018_06_advertiser_72 USING btree (payable);


--
-- Name: impressions_2018_06_advertiser_72_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_72_property_id_idx ON public.impressions_2018_06_advertiser_72 USING btree (property_id);


--
-- Name: impressions_2018_06_advertiser_72_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_72_property_name_idx ON public.impressions_2018_06_advertiser_72 USING btree (property_name);


--
-- Name: impressions_2018_06_advertiser_7_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_7_advertiser_id_idx ON public.impressions_2018_06_advertiser_7 USING btree (advertiser_id);


--
-- Name: impressions_2018_06_advertiser_7_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_7_campaign_id_idx ON public.impressions_2018_06_advertiser_7 USING btree (campaign_id);


--
-- Name: impressions_2018_06_advertiser_7_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_7_campaign_name_idx ON public.impressions_2018_06_advertiser_7 USING btree (campaign_name);


--
-- Name: impressions_2018_06_advertiser_7_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_7_country_code_idx ON public.impressions_2018_06_advertiser_7 USING btree (country_code);


--
-- Name: impressions_2018_06_advertiser_7_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_7_date_trunc_idx ON public.impressions_2018_06_advertiser_7 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_06_advertiser_7_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_7_displayed_at_date_idx ON public.impressions_2018_06_advertiser_7 USING btree (displayed_at_date);


--
-- Name: impressions_2018_06_advertiser_7_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_7_payable_idx ON public.impressions_2018_06_advertiser_7 USING btree (payable);


--
-- Name: impressions_2018_06_advertiser_7_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_7_property_id_idx ON public.impressions_2018_06_advertiser_7 USING btree (property_id);


--
-- Name: impressions_2018_06_advertiser_7_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_7_property_name_idx ON public.impressions_2018_06_advertiser_7 USING btree (property_name);


--
-- Name: impressions_2018_06_advertiser_85_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_85_advertiser_id_idx ON public.impressions_2018_06_advertiser_85 USING btree (advertiser_id);


--
-- Name: impressions_2018_06_advertiser_85_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_85_campaign_id_idx ON public.impressions_2018_06_advertiser_85 USING btree (campaign_id);


--
-- Name: impressions_2018_06_advertiser_85_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_85_campaign_name_idx ON public.impressions_2018_06_advertiser_85 USING btree (campaign_name);


--
-- Name: impressions_2018_06_advertiser_85_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_85_country_code_idx ON public.impressions_2018_06_advertiser_85 USING btree (country_code);


--
-- Name: impressions_2018_06_advertiser_85_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_85_date_trunc_idx ON public.impressions_2018_06_advertiser_85 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_06_advertiser_85_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_85_displayed_at_date_idx ON public.impressions_2018_06_advertiser_85 USING btree (displayed_at_date);


--
-- Name: impressions_2018_06_advertiser_85_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_85_payable_idx ON public.impressions_2018_06_advertiser_85 USING btree (payable);


--
-- Name: impressions_2018_06_advertiser_85_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_85_property_id_idx ON public.impressions_2018_06_advertiser_85 USING btree (property_id);


--
-- Name: impressions_2018_06_advertiser_85_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_85_property_name_idx ON public.impressions_2018_06_advertiser_85 USING btree (property_name);


--
-- Name: impressions_2018_06_advertiser_89_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_89_advertiser_id_idx ON public.impressions_2018_06_advertiser_89 USING btree (advertiser_id);


--
-- Name: impressions_2018_06_advertiser_89_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_89_campaign_id_idx ON public.impressions_2018_06_advertiser_89 USING btree (campaign_id);


--
-- Name: impressions_2018_06_advertiser_89_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_89_campaign_name_idx ON public.impressions_2018_06_advertiser_89 USING btree (campaign_name);


--
-- Name: impressions_2018_06_advertiser_89_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_89_country_code_idx ON public.impressions_2018_06_advertiser_89 USING btree (country_code);


--
-- Name: impressions_2018_06_advertiser_89_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_89_date_trunc_idx ON public.impressions_2018_06_advertiser_89 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_06_advertiser_89_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_89_displayed_at_date_idx ON public.impressions_2018_06_advertiser_89 USING btree (displayed_at_date);


--
-- Name: impressions_2018_06_advertiser_89_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_89_payable_idx ON public.impressions_2018_06_advertiser_89 USING btree (payable);


--
-- Name: impressions_2018_06_advertiser_89_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_89_property_id_idx ON public.impressions_2018_06_advertiser_89 USING btree (property_id);


--
-- Name: impressions_2018_06_advertiser_89_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_89_property_name_idx ON public.impressions_2018_06_advertiser_89 USING btree (property_name);


--
-- Name: impressions_2018_06_advertiser_98_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_98_advertiser_id_idx ON public.impressions_2018_06_advertiser_98 USING btree (advertiser_id);


--
-- Name: impressions_2018_06_advertiser_98_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_98_campaign_id_idx ON public.impressions_2018_06_advertiser_98 USING btree (campaign_id);


--
-- Name: impressions_2018_06_advertiser_98_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_98_campaign_name_idx ON public.impressions_2018_06_advertiser_98 USING btree (campaign_name);


--
-- Name: impressions_2018_06_advertiser_98_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_98_country_code_idx ON public.impressions_2018_06_advertiser_98 USING btree (country_code);


--
-- Name: impressions_2018_06_advertiser_98_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_98_date_trunc_idx ON public.impressions_2018_06_advertiser_98 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_06_advertiser_98_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_98_displayed_at_date_idx ON public.impressions_2018_06_advertiser_98 USING btree (displayed_at_date);


--
-- Name: impressions_2018_06_advertiser_98_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_98_payable_idx ON public.impressions_2018_06_advertiser_98 USING btree (payable);


--
-- Name: impressions_2018_06_advertiser_98_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_98_property_id_idx ON public.impressions_2018_06_advertiser_98 USING btree (property_id);


--
-- Name: impressions_2018_06_advertiser_98_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_98_property_name_idx ON public.impressions_2018_06_advertiser_98 USING btree (property_name);


--
-- Name: impressions_2018_06_advertiser__campaign_name_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser__campaign_name_property_name_idx ON public.impressions_2018_06_advertiser_85 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_06_advertiser_campaign_name_property_name_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_campaign_name_property_name_idx1 ON public.impressions_2018_06_advertiser_64 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_06_advertiser_campaign_name_property_name_idx2; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_campaign_name_property_name_idx2 ON public.impressions_2018_06_advertiser_72 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_06_advertiser_campaign_name_property_name_idx3; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_campaign_name_property_name_idx3 ON public.impressions_2018_06_advertiser_18 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_06_advertiser_campaign_name_property_name_idx4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_campaign_name_property_name_idx4 ON public.impressions_2018_06_advertiser_62 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_06_advertiser_campaign_name_property_name_idx5; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_campaign_name_property_name_idx5 ON public.impressions_2018_06_advertiser_19 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_06_advertiser_campaign_name_property_name_idx6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_campaign_name_property_name_idx6 ON public.impressions_2018_06_advertiser_7 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_06_advertiser_campaign_name_property_name_idx7; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_campaign_name_property_name_idx7 ON public.impressions_2018_06_advertiser_89 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_06_advertiser_campaign_name_property_name_idx8; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_campaign_name_property_name_idx8 ON public.impressions_2018_06_advertiser_98 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_06_advertiser_campaign_name_property_name_idx9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_06_advertiser_campaign_name_property_name_idx9 ON public.impressions_2018_06_advertiser_52 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_07_advertise_campaign_name_property_name_idx10; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertise_campaign_name_property_name_idx10 ON public.impressions_2018_07_advertiser_39 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_07_advertiser_19_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_19_advertiser_id_idx ON public.impressions_2018_07_advertiser_19 USING btree (advertiser_id);


--
-- Name: impressions_2018_07_advertiser_19_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_19_campaign_id_idx ON public.impressions_2018_07_advertiser_19 USING btree (campaign_id);


--
-- Name: impressions_2018_07_advertiser_19_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_19_campaign_name_idx ON public.impressions_2018_07_advertiser_19 USING btree (campaign_name);


--
-- Name: impressions_2018_07_advertiser_19_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_19_country_code_idx ON public.impressions_2018_07_advertiser_19 USING btree (country_code);


--
-- Name: impressions_2018_07_advertiser_19_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_19_date_trunc_idx ON public.impressions_2018_07_advertiser_19 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_07_advertiser_19_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_19_displayed_at_date_idx ON public.impressions_2018_07_advertiser_19 USING btree (displayed_at_date);


--
-- Name: impressions_2018_07_advertiser_19_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_19_payable_idx ON public.impressions_2018_07_advertiser_19 USING btree (payable);


--
-- Name: impressions_2018_07_advertiser_19_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_19_property_id_idx ON public.impressions_2018_07_advertiser_19 USING btree (property_id);


--
-- Name: impressions_2018_07_advertiser_19_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_19_property_name_idx ON public.impressions_2018_07_advertiser_19 USING btree (property_name);


--
-- Name: impressions_2018_07_advertiser_23_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_23_advertiser_id_idx ON public.impressions_2018_07_advertiser_23 USING btree (advertiser_id);


--
-- Name: impressions_2018_07_advertiser_23_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_23_campaign_id_idx ON public.impressions_2018_07_advertiser_23 USING btree (campaign_id);


--
-- Name: impressions_2018_07_advertiser_23_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_23_campaign_name_idx ON public.impressions_2018_07_advertiser_23 USING btree (campaign_name);


--
-- Name: impressions_2018_07_advertiser_23_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_23_country_code_idx ON public.impressions_2018_07_advertiser_23 USING btree (country_code);


--
-- Name: impressions_2018_07_advertiser_23_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_23_date_trunc_idx ON public.impressions_2018_07_advertiser_23 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_07_advertiser_23_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_23_displayed_at_date_idx ON public.impressions_2018_07_advertiser_23 USING btree (displayed_at_date);


--
-- Name: impressions_2018_07_advertiser_23_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_23_payable_idx ON public.impressions_2018_07_advertiser_23 USING btree (payable);


--
-- Name: impressions_2018_07_advertiser_23_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_23_property_id_idx ON public.impressions_2018_07_advertiser_23 USING btree (property_id);


--
-- Name: impressions_2018_07_advertiser_23_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_23_property_name_idx ON public.impressions_2018_07_advertiser_23 USING btree (property_name);


--
-- Name: impressions_2018_07_advertiser_39_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_39_advertiser_id_idx ON public.impressions_2018_07_advertiser_39 USING btree (advertiser_id);


--
-- Name: impressions_2018_07_advertiser_39_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_39_campaign_id_idx ON public.impressions_2018_07_advertiser_39 USING btree (campaign_id);


--
-- Name: impressions_2018_07_advertiser_39_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_39_campaign_name_idx ON public.impressions_2018_07_advertiser_39 USING btree (campaign_name);


--
-- Name: impressions_2018_07_advertiser_39_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_39_country_code_idx ON public.impressions_2018_07_advertiser_39 USING btree (country_code);


--
-- Name: impressions_2018_07_advertiser_39_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_39_date_trunc_idx ON public.impressions_2018_07_advertiser_39 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_07_advertiser_39_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_39_displayed_at_date_idx ON public.impressions_2018_07_advertiser_39 USING btree (displayed_at_date);


--
-- Name: impressions_2018_07_advertiser_39_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_39_payable_idx ON public.impressions_2018_07_advertiser_39 USING btree (payable);


--
-- Name: impressions_2018_07_advertiser_39_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_39_property_id_idx ON public.impressions_2018_07_advertiser_39 USING btree (property_id);


--
-- Name: impressions_2018_07_advertiser_39_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_39_property_name_idx ON public.impressions_2018_07_advertiser_39 USING btree (property_name);


--
-- Name: impressions_2018_07_advertiser_62_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_62_advertiser_id_idx ON public.impressions_2018_07_advertiser_62 USING btree (advertiser_id);


--
-- Name: impressions_2018_07_advertiser_62_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_62_campaign_id_idx ON public.impressions_2018_07_advertiser_62 USING btree (campaign_id);


--
-- Name: impressions_2018_07_advertiser_62_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_62_campaign_name_idx ON public.impressions_2018_07_advertiser_62 USING btree (campaign_name);


--
-- Name: impressions_2018_07_advertiser_62_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_62_country_code_idx ON public.impressions_2018_07_advertiser_62 USING btree (country_code);


--
-- Name: impressions_2018_07_advertiser_62_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_62_date_trunc_idx ON public.impressions_2018_07_advertiser_62 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_07_advertiser_62_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_62_displayed_at_date_idx ON public.impressions_2018_07_advertiser_62 USING btree (displayed_at_date);


--
-- Name: impressions_2018_07_advertiser_62_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_62_payable_idx ON public.impressions_2018_07_advertiser_62 USING btree (payable);


--
-- Name: impressions_2018_07_advertiser_62_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_62_property_id_idx ON public.impressions_2018_07_advertiser_62 USING btree (property_id);


--
-- Name: impressions_2018_07_advertiser_62_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_62_property_name_idx ON public.impressions_2018_07_advertiser_62 USING btree (property_name);


--
-- Name: impressions_2018_07_advertiser_64_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_64_advertiser_id_idx ON public.impressions_2018_07_advertiser_64 USING btree (advertiser_id);


--
-- Name: impressions_2018_07_advertiser_64_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_64_campaign_id_idx ON public.impressions_2018_07_advertiser_64 USING btree (campaign_id);


--
-- Name: impressions_2018_07_advertiser_64_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_64_campaign_name_idx ON public.impressions_2018_07_advertiser_64 USING btree (campaign_name);


--
-- Name: impressions_2018_07_advertiser_64_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_64_country_code_idx ON public.impressions_2018_07_advertiser_64 USING btree (country_code);


--
-- Name: impressions_2018_07_advertiser_64_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_64_date_trunc_idx ON public.impressions_2018_07_advertiser_64 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_07_advertiser_64_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_64_displayed_at_date_idx ON public.impressions_2018_07_advertiser_64 USING btree (displayed_at_date);


--
-- Name: impressions_2018_07_advertiser_64_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_64_payable_idx ON public.impressions_2018_07_advertiser_64 USING btree (payable);


--
-- Name: impressions_2018_07_advertiser_64_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_64_property_id_idx ON public.impressions_2018_07_advertiser_64 USING btree (property_id);


--
-- Name: impressions_2018_07_advertiser_64_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_64_property_name_idx ON public.impressions_2018_07_advertiser_64 USING btree (property_name);


--
-- Name: impressions_2018_07_advertiser_84_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_84_advertiser_id_idx ON public.impressions_2018_07_advertiser_84 USING btree (advertiser_id);


--
-- Name: impressions_2018_07_advertiser_84_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_84_campaign_id_idx ON public.impressions_2018_07_advertiser_84 USING btree (campaign_id);


--
-- Name: impressions_2018_07_advertiser_84_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_84_campaign_name_idx ON public.impressions_2018_07_advertiser_84 USING btree (campaign_name);


--
-- Name: impressions_2018_07_advertiser_84_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_84_country_code_idx ON public.impressions_2018_07_advertiser_84 USING btree (country_code);


--
-- Name: impressions_2018_07_advertiser_84_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_84_date_trunc_idx ON public.impressions_2018_07_advertiser_84 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_07_advertiser_84_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_84_displayed_at_date_idx ON public.impressions_2018_07_advertiser_84 USING btree (displayed_at_date);


--
-- Name: impressions_2018_07_advertiser_84_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_84_payable_idx ON public.impressions_2018_07_advertiser_84 USING btree (payable);


--
-- Name: impressions_2018_07_advertiser_84_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_84_property_id_idx ON public.impressions_2018_07_advertiser_84 USING btree (property_id);


--
-- Name: impressions_2018_07_advertiser_84_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_84_property_name_idx ON public.impressions_2018_07_advertiser_84 USING btree (property_name);


--
-- Name: impressions_2018_07_advertiser_85_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_85_advertiser_id_idx ON public.impressions_2018_07_advertiser_85 USING btree (advertiser_id);


--
-- Name: impressions_2018_07_advertiser_85_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_85_campaign_id_idx ON public.impressions_2018_07_advertiser_85 USING btree (campaign_id);


--
-- Name: impressions_2018_07_advertiser_85_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_85_campaign_name_idx ON public.impressions_2018_07_advertiser_85 USING btree (campaign_name);


--
-- Name: impressions_2018_07_advertiser_85_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_85_country_code_idx ON public.impressions_2018_07_advertiser_85 USING btree (country_code);


--
-- Name: impressions_2018_07_advertiser_85_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_85_date_trunc_idx ON public.impressions_2018_07_advertiser_85 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_07_advertiser_85_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_85_displayed_at_date_idx ON public.impressions_2018_07_advertiser_85 USING btree (displayed_at_date);


--
-- Name: impressions_2018_07_advertiser_85_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_85_payable_idx ON public.impressions_2018_07_advertiser_85 USING btree (payable);


--
-- Name: impressions_2018_07_advertiser_85_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_85_property_id_idx ON public.impressions_2018_07_advertiser_85 USING btree (property_id);


--
-- Name: impressions_2018_07_advertiser_85_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_85_property_name_idx ON public.impressions_2018_07_advertiser_85 USING btree (property_name);


--
-- Name: impressions_2018_07_advertiser_87_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_87_advertiser_id_idx ON public.impressions_2018_07_advertiser_87 USING btree (advertiser_id);


--
-- Name: impressions_2018_07_advertiser_87_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_87_campaign_id_idx ON public.impressions_2018_07_advertiser_87 USING btree (campaign_id);


--
-- Name: impressions_2018_07_advertiser_87_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_87_campaign_name_idx ON public.impressions_2018_07_advertiser_87 USING btree (campaign_name);


--
-- Name: impressions_2018_07_advertiser_87_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_87_country_code_idx ON public.impressions_2018_07_advertiser_87 USING btree (country_code);


--
-- Name: impressions_2018_07_advertiser_87_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_87_date_trunc_idx ON public.impressions_2018_07_advertiser_87 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_07_advertiser_87_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_87_displayed_at_date_idx ON public.impressions_2018_07_advertiser_87 USING btree (displayed_at_date);


--
-- Name: impressions_2018_07_advertiser_87_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_87_payable_idx ON public.impressions_2018_07_advertiser_87 USING btree (payable);


--
-- Name: impressions_2018_07_advertiser_87_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_87_property_id_idx ON public.impressions_2018_07_advertiser_87 USING btree (property_id);


--
-- Name: impressions_2018_07_advertiser_87_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_87_property_name_idx ON public.impressions_2018_07_advertiser_87 USING btree (property_name);


--
-- Name: impressions_2018_07_advertiser_89_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_89_advertiser_id_idx ON public.impressions_2018_07_advertiser_89 USING btree (advertiser_id);


--
-- Name: impressions_2018_07_advertiser_89_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_89_campaign_id_idx ON public.impressions_2018_07_advertiser_89 USING btree (campaign_id);


--
-- Name: impressions_2018_07_advertiser_89_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_89_campaign_name_idx ON public.impressions_2018_07_advertiser_89 USING btree (campaign_name);


--
-- Name: impressions_2018_07_advertiser_89_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_89_country_code_idx ON public.impressions_2018_07_advertiser_89 USING btree (country_code);


--
-- Name: impressions_2018_07_advertiser_89_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_89_date_trunc_idx ON public.impressions_2018_07_advertiser_89 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_07_advertiser_89_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_89_displayed_at_date_idx ON public.impressions_2018_07_advertiser_89 USING btree (displayed_at_date);


--
-- Name: impressions_2018_07_advertiser_89_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_89_payable_idx ON public.impressions_2018_07_advertiser_89 USING btree (payable);


--
-- Name: impressions_2018_07_advertiser_89_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_89_property_id_idx ON public.impressions_2018_07_advertiser_89 USING btree (property_id);


--
-- Name: impressions_2018_07_advertiser_89_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_89_property_name_idx ON public.impressions_2018_07_advertiser_89 USING btree (property_name);


--
-- Name: impressions_2018_07_advertiser_95_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_95_advertiser_id_idx ON public.impressions_2018_07_advertiser_95 USING btree (advertiser_id);


--
-- Name: impressions_2018_07_advertiser_95_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_95_campaign_id_idx ON public.impressions_2018_07_advertiser_95 USING btree (campaign_id);


--
-- Name: impressions_2018_07_advertiser_95_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_95_campaign_name_idx ON public.impressions_2018_07_advertiser_95 USING btree (campaign_name);


--
-- Name: impressions_2018_07_advertiser_95_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_95_country_code_idx ON public.impressions_2018_07_advertiser_95 USING btree (country_code);


--
-- Name: impressions_2018_07_advertiser_95_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_95_date_trunc_idx ON public.impressions_2018_07_advertiser_95 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_07_advertiser_95_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_95_displayed_at_date_idx ON public.impressions_2018_07_advertiser_95 USING btree (displayed_at_date);


--
-- Name: impressions_2018_07_advertiser_95_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_95_payable_idx ON public.impressions_2018_07_advertiser_95 USING btree (payable);


--
-- Name: impressions_2018_07_advertiser_95_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_95_property_id_idx ON public.impressions_2018_07_advertiser_95 USING btree (property_id);


--
-- Name: impressions_2018_07_advertiser_95_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_95_property_name_idx ON public.impressions_2018_07_advertiser_95 USING btree (property_name);


--
-- Name: impressions_2018_07_advertiser_96_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_96_advertiser_id_idx ON public.impressions_2018_07_advertiser_96 USING btree (advertiser_id);


--
-- Name: impressions_2018_07_advertiser_96_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_96_campaign_id_idx ON public.impressions_2018_07_advertiser_96 USING btree (campaign_id);


--
-- Name: impressions_2018_07_advertiser_96_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_96_campaign_name_idx ON public.impressions_2018_07_advertiser_96 USING btree (campaign_name);


--
-- Name: impressions_2018_07_advertiser_96_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_96_country_code_idx ON public.impressions_2018_07_advertiser_96 USING btree (country_code);


--
-- Name: impressions_2018_07_advertiser_96_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_96_date_trunc_idx ON public.impressions_2018_07_advertiser_96 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_07_advertiser_96_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_96_displayed_at_date_idx ON public.impressions_2018_07_advertiser_96 USING btree (displayed_at_date);


--
-- Name: impressions_2018_07_advertiser_96_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_96_payable_idx ON public.impressions_2018_07_advertiser_96 USING btree (payable);


--
-- Name: impressions_2018_07_advertiser_96_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_96_property_id_idx ON public.impressions_2018_07_advertiser_96 USING btree (property_id);


--
-- Name: impressions_2018_07_advertiser_96_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_96_property_name_idx ON public.impressions_2018_07_advertiser_96 USING btree (property_name);


--
-- Name: impressions_2018_07_advertiser__campaign_name_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser__campaign_name_property_name_idx ON public.impressions_2018_07_advertiser_87 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_07_advertiser_campaign_name_property_name_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_campaign_name_property_name_idx1 ON public.impressions_2018_07_advertiser_89 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_07_advertiser_campaign_name_property_name_idx2; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_campaign_name_property_name_idx2 ON public.impressions_2018_07_advertiser_95 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_07_advertiser_campaign_name_property_name_idx3; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_campaign_name_property_name_idx3 ON public.impressions_2018_07_advertiser_64 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_07_advertiser_campaign_name_property_name_idx4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_campaign_name_property_name_idx4 ON public.impressions_2018_07_advertiser_96 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_07_advertiser_campaign_name_property_name_idx5; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_campaign_name_property_name_idx5 ON public.impressions_2018_07_advertiser_23 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_07_advertiser_campaign_name_property_name_idx6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_campaign_name_property_name_idx6 ON public.impressions_2018_07_advertiser_19 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_07_advertiser_campaign_name_property_name_idx7; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_campaign_name_property_name_idx7 ON public.impressions_2018_07_advertiser_85 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_07_advertiser_campaign_name_property_name_idx8; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_campaign_name_property_name_idx8 ON public.impressions_2018_07_advertiser_62 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_07_advertiser_campaign_name_property_name_idx9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_07_advertiser_campaign_name_property_name_idx9 ON public.impressions_2018_07_advertiser_84 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_08_advertiser_39_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_39_advertiser_id_idx ON public.impressions_2018_08_advertiser_39 USING btree (advertiser_id);


--
-- Name: impressions_2018_08_advertiser_39_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_39_campaign_id_idx ON public.impressions_2018_08_advertiser_39 USING btree (campaign_id);


--
-- Name: impressions_2018_08_advertiser_39_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_39_campaign_name_idx ON public.impressions_2018_08_advertiser_39 USING btree (campaign_name);


--
-- Name: impressions_2018_08_advertiser_39_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_39_country_code_idx ON public.impressions_2018_08_advertiser_39 USING btree (country_code);


--
-- Name: impressions_2018_08_advertiser_39_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_39_date_trunc_idx ON public.impressions_2018_08_advertiser_39 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_08_advertiser_39_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_39_displayed_at_date_idx ON public.impressions_2018_08_advertiser_39 USING btree (displayed_at_date);


--
-- Name: impressions_2018_08_advertiser_39_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_39_payable_idx ON public.impressions_2018_08_advertiser_39 USING btree (payable);


--
-- Name: impressions_2018_08_advertiser_39_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_39_property_id_idx ON public.impressions_2018_08_advertiser_39 USING btree (property_id);


--
-- Name: impressions_2018_08_advertiser_39_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_39_property_name_idx ON public.impressions_2018_08_advertiser_39 USING btree (property_name);


--
-- Name: impressions_2018_08_advertiser_46_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_46_advertiser_id_idx ON public.impressions_2018_08_advertiser_46 USING btree (advertiser_id);


--
-- Name: impressions_2018_08_advertiser_46_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_46_campaign_id_idx ON public.impressions_2018_08_advertiser_46 USING btree (campaign_id);


--
-- Name: impressions_2018_08_advertiser_46_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_46_campaign_name_idx ON public.impressions_2018_08_advertiser_46 USING btree (campaign_name);


--
-- Name: impressions_2018_08_advertiser_46_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_46_country_code_idx ON public.impressions_2018_08_advertiser_46 USING btree (country_code);


--
-- Name: impressions_2018_08_advertiser_46_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_46_date_trunc_idx ON public.impressions_2018_08_advertiser_46 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_08_advertiser_46_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_46_displayed_at_date_idx ON public.impressions_2018_08_advertiser_46 USING btree (displayed_at_date);


--
-- Name: impressions_2018_08_advertiser_46_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_46_payable_idx ON public.impressions_2018_08_advertiser_46 USING btree (payable);


--
-- Name: impressions_2018_08_advertiser_46_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_46_property_id_idx ON public.impressions_2018_08_advertiser_46 USING btree (property_id);


--
-- Name: impressions_2018_08_advertiser_46_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_46_property_name_idx ON public.impressions_2018_08_advertiser_46 USING btree (property_name);


--
-- Name: impressions_2018_08_advertiser_55_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_55_advertiser_id_idx ON public.impressions_2018_08_advertiser_55 USING btree (advertiser_id);


--
-- Name: impressions_2018_08_advertiser_55_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_55_campaign_id_idx ON public.impressions_2018_08_advertiser_55 USING btree (campaign_id);


--
-- Name: impressions_2018_08_advertiser_55_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_55_campaign_name_idx ON public.impressions_2018_08_advertiser_55 USING btree (campaign_name);


--
-- Name: impressions_2018_08_advertiser_55_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_55_country_code_idx ON public.impressions_2018_08_advertiser_55 USING btree (country_code);


--
-- Name: impressions_2018_08_advertiser_55_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_55_date_trunc_idx ON public.impressions_2018_08_advertiser_55 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_08_advertiser_55_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_55_displayed_at_date_idx ON public.impressions_2018_08_advertiser_55 USING btree (displayed_at_date);


--
-- Name: impressions_2018_08_advertiser_55_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_55_payable_idx ON public.impressions_2018_08_advertiser_55 USING btree (payable);


--
-- Name: impressions_2018_08_advertiser_55_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_55_property_id_idx ON public.impressions_2018_08_advertiser_55 USING btree (property_id);


--
-- Name: impressions_2018_08_advertiser_55_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_55_property_name_idx ON public.impressions_2018_08_advertiser_55 USING btree (property_name);


--
-- Name: impressions_2018_08_advertiser_57_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_57_advertiser_id_idx ON public.impressions_2018_08_advertiser_57 USING btree (advertiser_id);


--
-- Name: impressions_2018_08_advertiser_57_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_57_campaign_id_idx ON public.impressions_2018_08_advertiser_57 USING btree (campaign_id);


--
-- Name: impressions_2018_08_advertiser_57_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_57_campaign_name_idx ON public.impressions_2018_08_advertiser_57 USING btree (campaign_name);


--
-- Name: impressions_2018_08_advertiser_57_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_57_country_code_idx ON public.impressions_2018_08_advertiser_57 USING btree (country_code);


--
-- Name: impressions_2018_08_advertiser_57_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_57_date_trunc_idx ON public.impressions_2018_08_advertiser_57 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_08_advertiser_57_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_57_displayed_at_date_idx ON public.impressions_2018_08_advertiser_57 USING btree (displayed_at_date);


--
-- Name: impressions_2018_08_advertiser_57_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_57_payable_idx ON public.impressions_2018_08_advertiser_57 USING btree (payable);


--
-- Name: impressions_2018_08_advertiser_57_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_57_property_id_idx ON public.impressions_2018_08_advertiser_57 USING btree (property_id);


--
-- Name: impressions_2018_08_advertiser_57_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_57_property_name_idx ON public.impressions_2018_08_advertiser_57 USING btree (property_name);


--
-- Name: impressions_2018_08_advertiser_58_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_58_advertiser_id_idx ON public.impressions_2018_08_advertiser_58 USING btree (advertiser_id);


--
-- Name: impressions_2018_08_advertiser_58_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_58_campaign_id_idx ON public.impressions_2018_08_advertiser_58 USING btree (campaign_id);


--
-- Name: impressions_2018_08_advertiser_58_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_58_campaign_name_idx ON public.impressions_2018_08_advertiser_58 USING btree (campaign_name);


--
-- Name: impressions_2018_08_advertiser_58_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_58_country_code_idx ON public.impressions_2018_08_advertiser_58 USING btree (country_code);


--
-- Name: impressions_2018_08_advertiser_58_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_58_date_trunc_idx ON public.impressions_2018_08_advertiser_58 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_08_advertiser_58_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_58_displayed_at_date_idx ON public.impressions_2018_08_advertiser_58 USING btree (displayed_at_date);


--
-- Name: impressions_2018_08_advertiser_58_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_58_payable_idx ON public.impressions_2018_08_advertiser_58 USING btree (payable);


--
-- Name: impressions_2018_08_advertiser_58_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_58_property_id_idx ON public.impressions_2018_08_advertiser_58 USING btree (property_id);


--
-- Name: impressions_2018_08_advertiser_58_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_58_property_name_idx ON public.impressions_2018_08_advertiser_58 USING btree (property_name);


--
-- Name: impressions_2018_08_advertiser_72_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_72_advertiser_id_idx ON public.impressions_2018_08_advertiser_72 USING btree (advertiser_id);


--
-- Name: impressions_2018_08_advertiser_72_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_72_campaign_id_idx ON public.impressions_2018_08_advertiser_72 USING btree (campaign_id);


--
-- Name: impressions_2018_08_advertiser_72_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_72_campaign_name_idx ON public.impressions_2018_08_advertiser_72 USING btree (campaign_name);


--
-- Name: impressions_2018_08_advertiser_72_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_72_country_code_idx ON public.impressions_2018_08_advertiser_72 USING btree (country_code);


--
-- Name: impressions_2018_08_advertiser_72_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_72_date_trunc_idx ON public.impressions_2018_08_advertiser_72 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_08_advertiser_72_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_72_displayed_at_date_idx ON public.impressions_2018_08_advertiser_72 USING btree (displayed_at_date);


--
-- Name: impressions_2018_08_advertiser_72_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_72_payable_idx ON public.impressions_2018_08_advertiser_72 USING btree (payable);


--
-- Name: impressions_2018_08_advertiser_72_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_72_property_id_idx ON public.impressions_2018_08_advertiser_72 USING btree (property_id);


--
-- Name: impressions_2018_08_advertiser_72_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_72_property_name_idx ON public.impressions_2018_08_advertiser_72 USING btree (property_name);


--
-- Name: impressions_2018_08_advertiser_84_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_84_advertiser_id_idx ON public.impressions_2018_08_advertiser_84 USING btree (advertiser_id);


--
-- Name: impressions_2018_08_advertiser_84_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_84_campaign_id_idx ON public.impressions_2018_08_advertiser_84 USING btree (campaign_id);


--
-- Name: impressions_2018_08_advertiser_84_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_84_campaign_name_idx ON public.impressions_2018_08_advertiser_84 USING btree (campaign_name);


--
-- Name: impressions_2018_08_advertiser_84_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_84_country_code_idx ON public.impressions_2018_08_advertiser_84 USING btree (country_code);


--
-- Name: impressions_2018_08_advertiser_84_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_84_date_trunc_idx ON public.impressions_2018_08_advertiser_84 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_08_advertiser_84_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_84_displayed_at_date_idx ON public.impressions_2018_08_advertiser_84 USING btree (displayed_at_date);


--
-- Name: impressions_2018_08_advertiser_84_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_84_payable_idx ON public.impressions_2018_08_advertiser_84 USING btree (payable);


--
-- Name: impressions_2018_08_advertiser_84_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_84_property_id_idx ON public.impressions_2018_08_advertiser_84 USING btree (property_id);


--
-- Name: impressions_2018_08_advertiser_84_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_84_property_name_idx ON public.impressions_2018_08_advertiser_84 USING btree (property_name);


--
-- Name: impressions_2018_08_advertiser_89_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_89_advertiser_id_idx ON public.impressions_2018_08_advertiser_89 USING btree (advertiser_id);


--
-- Name: impressions_2018_08_advertiser_89_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_89_campaign_id_idx ON public.impressions_2018_08_advertiser_89 USING btree (campaign_id);


--
-- Name: impressions_2018_08_advertiser_89_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_89_campaign_name_idx ON public.impressions_2018_08_advertiser_89 USING btree (campaign_name);


--
-- Name: impressions_2018_08_advertiser_89_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_89_country_code_idx ON public.impressions_2018_08_advertiser_89 USING btree (country_code);


--
-- Name: impressions_2018_08_advertiser_89_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_89_date_trunc_idx ON public.impressions_2018_08_advertiser_89 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_08_advertiser_89_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_89_displayed_at_date_idx ON public.impressions_2018_08_advertiser_89 USING btree (displayed_at_date);


--
-- Name: impressions_2018_08_advertiser_89_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_89_payable_idx ON public.impressions_2018_08_advertiser_89 USING btree (payable);


--
-- Name: impressions_2018_08_advertiser_89_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_89_property_id_idx ON public.impressions_2018_08_advertiser_89 USING btree (property_id);


--
-- Name: impressions_2018_08_advertiser_89_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_89_property_name_idx ON public.impressions_2018_08_advertiser_89 USING btree (property_name);


--
-- Name: impressions_2018_08_advertiser_95_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_95_advertiser_id_idx ON public.impressions_2018_08_advertiser_95 USING btree (advertiser_id);


--
-- Name: impressions_2018_08_advertiser_95_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_95_campaign_id_idx ON public.impressions_2018_08_advertiser_95 USING btree (campaign_id);


--
-- Name: impressions_2018_08_advertiser_95_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_95_campaign_name_idx ON public.impressions_2018_08_advertiser_95 USING btree (campaign_name);


--
-- Name: impressions_2018_08_advertiser_95_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_95_country_code_idx ON public.impressions_2018_08_advertiser_95 USING btree (country_code);


--
-- Name: impressions_2018_08_advertiser_95_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_95_date_trunc_idx ON public.impressions_2018_08_advertiser_95 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_08_advertiser_95_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_95_displayed_at_date_idx ON public.impressions_2018_08_advertiser_95 USING btree (displayed_at_date);


--
-- Name: impressions_2018_08_advertiser_95_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_95_payable_idx ON public.impressions_2018_08_advertiser_95 USING btree (payable);


--
-- Name: impressions_2018_08_advertiser_95_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_95_property_id_idx ON public.impressions_2018_08_advertiser_95 USING btree (property_id);


--
-- Name: impressions_2018_08_advertiser_95_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_95_property_name_idx ON public.impressions_2018_08_advertiser_95 USING btree (property_name);


--
-- Name: impressions_2018_08_advertiser_96_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_96_advertiser_id_idx ON public.impressions_2018_08_advertiser_96 USING btree (advertiser_id);


--
-- Name: impressions_2018_08_advertiser_96_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_96_campaign_id_idx ON public.impressions_2018_08_advertiser_96 USING btree (campaign_id);


--
-- Name: impressions_2018_08_advertiser_96_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_96_campaign_name_idx ON public.impressions_2018_08_advertiser_96 USING btree (campaign_name);


--
-- Name: impressions_2018_08_advertiser_96_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_96_country_code_idx ON public.impressions_2018_08_advertiser_96 USING btree (country_code);


--
-- Name: impressions_2018_08_advertiser_96_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_96_date_trunc_idx ON public.impressions_2018_08_advertiser_96 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_08_advertiser_96_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_96_displayed_at_date_idx ON public.impressions_2018_08_advertiser_96 USING btree (displayed_at_date);


--
-- Name: impressions_2018_08_advertiser_96_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_96_payable_idx ON public.impressions_2018_08_advertiser_96 USING btree (payable);


--
-- Name: impressions_2018_08_advertiser_96_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_96_property_id_idx ON public.impressions_2018_08_advertiser_96 USING btree (property_id);


--
-- Name: impressions_2018_08_advertiser_96_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_96_property_name_idx ON public.impressions_2018_08_advertiser_96 USING btree (property_name);


--
-- Name: impressions_2018_08_advertiser__campaign_name_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser__campaign_name_property_name_idx ON public.impressions_2018_08_advertiser_95 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_08_advertiser_campaign_name_property_name_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_campaign_name_property_name_idx1 ON public.impressions_2018_08_advertiser_39 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_08_advertiser_campaign_name_property_name_idx2; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_campaign_name_property_name_idx2 ON public.impressions_2018_08_advertiser_96 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_08_advertiser_campaign_name_property_name_idx3; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_campaign_name_property_name_idx3 ON public.impressions_2018_08_advertiser_46 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_08_advertiser_campaign_name_property_name_idx4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_campaign_name_property_name_idx4 ON public.impressions_2018_08_advertiser_72 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_08_advertiser_campaign_name_property_name_idx5; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_campaign_name_property_name_idx5 ON public.impressions_2018_08_advertiser_84 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_08_advertiser_campaign_name_property_name_idx6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_campaign_name_property_name_idx6 ON public.impressions_2018_08_advertiser_89 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_08_advertiser_campaign_name_property_name_idx7; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_campaign_name_property_name_idx7 ON public.impressions_2018_08_advertiser_57 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_08_advertiser_campaign_name_property_name_idx8; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_campaign_name_property_name_idx8 ON public.impressions_2018_08_advertiser_58 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_08_advertiser_campaign_name_property_name_idx9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_08_advertiser_campaign_name_property_name_idx9 ON public.impressions_2018_08_advertiser_55 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_10_advertiser_31_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_31_advertiser_id_idx ON public.impressions_2018_10_advertiser_31 USING btree (advertiser_id);


--
-- Name: impressions_2018_10_advertiser_31_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_31_campaign_id_idx ON public.impressions_2018_10_advertiser_31 USING btree (campaign_id);


--
-- Name: impressions_2018_10_advertiser_31_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_31_campaign_name_idx ON public.impressions_2018_10_advertiser_31 USING btree (campaign_name);


--
-- Name: impressions_2018_10_advertiser_31_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_31_country_code_idx ON public.impressions_2018_10_advertiser_31 USING btree (country_code);


--
-- Name: impressions_2018_10_advertiser_31_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_31_date_trunc_idx ON public.impressions_2018_10_advertiser_31 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_10_advertiser_31_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_31_displayed_at_date_idx ON public.impressions_2018_10_advertiser_31 USING btree (displayed_at_date);


--
-- Name: impressions_2018_10_advertiser_31_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_31_payable_idx ON public.impressions_2018_10_advertiser_31 USING btree (payable);


--
-- Name: impressions_2018_10_advertiser_31_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_31_property_id_idx ON public.impressions_2018_10_advertiser_31 USING btree (property_id);


--
-- Name: impressions_2018_10_advertiser_31_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_31_property_name_idx ON public.impressions_2018_10_advertiser_31 USING btree (property_name);


--
-- Name: impressions_2018_10_advertiser_53_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_53_advertiser_id_idx ON public.impressions_2018_10_advertiser_53 USING btree (advertiser_id);


--
-- Name: impressions_2018_10_advertiser_53_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_53_campaign_id_idx ON public.impressions_2018_10_advertiser_53 USING btree (campaign_id);


--
-- Name: impressions_2018_10_advertiser_53_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_53_campaign_name_idx ON public.impressions_2018_10_advertiser_53 USING btree (campaign_name);


--
-- Name: impressions_2018_10_advertiser_53_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_53_country_code_idx ON public.impressions_2018_10_advertiser_53 USING btree (country_code);


--
-- Name: impressions_2018_10_advertiser_53_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_53_date_trunc_idx ON public.impressions_2018_10_advertiser_53 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_10_advertiser_53_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_53_displayed_at_date_idx ON public.impressions_2018_10_advertiser_53 USING btree (displayed_at_date);


--
-- Name: impressions_2018_10_advertiser_53_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_53_payable_idx ON public.impressions_2018_10_advertiser_53 USING btree (payable);


--
-- Name: impressions_2018_10_advertiser_53_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_53_property_id_idx ON public.impressions_2018_10_advertiser_53 USING btree (property_id);


--
-- Name: impressions_2018_10_advertiser_53_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_53_property_name_idx ON public.impressions_2018_10_advertiser_53 USING btree (property_name);


--
-- Name: impressions_2018_10_advertiser_55_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_55_advertiser_id_idx ON public.impressions_2018_10_advertiser_55 USING btree (advertiser_id);


--
-- Name: impressions_2018_10_advertiser_55_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_55_campaign_id_idx ON public.impressions_2018_10_advertiser_55 USING btree (campaign_id);


--
-- Name: impressions_2018_10_advertiser_55_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_55_campaign_name_idx ON public.impressions_2018_10_advertiser_55 USING btree (campaign_name);


--
-- Name: impressions_2018_10_advertiser_55_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_55_country_code_idx ON public.impressions_2018_10_advertiser_55 USING btree (country_code);


--
-- Name: impressions_2018_10_advertiser_55_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_55_date_trunc_idx ON public.impressions_2018_10_advertiser_55 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_10_advertiser_55_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_55_displayed_at_date_idx ON public.impressions_2018_10_advertiser_55 USING btree (displayed_at_date);


--
-- Name: impressions_2018_10_advertiser_55_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_55_payable_idx ON public.impressions_2018_10_advertiser_55 USING btree (payable);


--
-- Name: impressions_2018_10_advertiser_55_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_55_property_id_idx ON public.impressions_2018_10_advertiser_55 USING btree (property_id);


--
-- Name: impressions_2018_10_advertiser_55_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_55_property_name_idx ON public.impressions_2018_10_advertiser_55 USING btree (property_name);


--
-- Name: impressions_2018_10_advertiser_56_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_56_advertiser_id_idx ON public.impressions_2018_10_advertiser_56 USING btree (advertiser_id);


--
-- Name: impressions_2018_10_advertiser_56_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_56_campaign_id_idx ON public.impressions_2018_10_advertiser_56 USING btree (campaign_id);


--
-- Name: impressions_2018_10_advertiser_56_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_56_campaign_name_idx ON public.impressions_2018_10_advertiser_56 USING btree (campaign_name);


--
-- Name: impressions_2018_10_advertiser_56_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_56_country_code_idx ON public.impressions_2018_10_advertiser_56 USING btree (country_code);


--
-- Name: impressions_2018_10_advertiser_56_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_56_date_trunc_idx ON public.impressions_2018_10_advertiser_56 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_10_advertiser_56_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_56_displayed_at_date_idx ON public.impressions_2018_10_advertiser_56 USING btree (displayed_at_date);


--
-- Name: impressions_2018_10_advertiser_56_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_56_payable_idx ON public.impressions_2018_10_advertiser_56 USING btree (payable);


--
-- Name: impressions_2018_10_advertiser_56_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_56_property_id_idx ON public.impressions_2018_10_advertiser_56 USING btree (property_id);


--
-- Name: impressions_2018_10_advertiser_56_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_56_property_name_idx ON public.impressions_2018_10_advertiser_56 USING btree (property_name);


--
-- Name: impressions_2018_10_advertiser_70_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_70_advertiser_id_idx ON public.impressions_2018_10_advertiser_70 USING btree (advertiser_id);


--
-- Name: impressions_2018_10_advertiser_70_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_70_campaign_id_idx ON public.impressions_2018_10_advertiser_70 USING btree (campaign_id);


--
-- Name: impressions_2018_10_advertiser_70_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_70_campaign_name_idx ON public.impressions_2018_10_advertiser_70 USING btree (campaign_name);


--
-- Name: impressions_2018_10_advertiser_70_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_70_country_code_idx ON public.impressions_2018_10_advertiser_70 USING btree (country_code);


--
-- Name: impressions_2018_10_advertiser_70_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_70_date_trunc_idx ON public.impressions_2018_10_advertiser_70 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_10_advertiser_70_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_70_displayed_at_date_idx ON public.impressions_2018_10_advertiser_70 USING btree (displayed_at_date);


--
-- Name: impressions_2018_10_advertiser_70_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_70_payable_idx ON public.impressions_2018_10_advertiser_70 USING btree (payable);


--
-- Name: impressions_2018_10_advertiser_70_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_70_property_id_idx ON public.impressions_2018_10_advertiser_70 USING btree (property_id);


--
-- Name: impressions_2018_10_advertiser_70_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_70_property_name_idx ON public.impressions_2018_10_advertiser_70 USING btree (property_name);


--
-- Name: impressions_2018_10_advertiser_71_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_71_advertiser_id_idx ON public.impressions_2018_10_advertiser_71 USING btree (advertiser_id);


--
-- Name: impressions_2018_10_advertiser_71_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_71_campaign_id_idx ON public.impressions_2018_10_advertiser_71 USING btree (campaign_id);


--
-- Name: impressions_2018_10_advertiser_71_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_71_campaign_name_idx ON public.impressions_2018_10_advertiser_71 USING btree (campaign_name);


--
-- Name: impressions_2018_10_advertiser_71_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_71_country_code_idx ON public.impressions_2018_10_advertiser_71 USING btree (country_code);


--
-- Name: impressions_2018_10_advertiser_71_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_71_date_trunc_idx ON public.impressions_2018_10_advertiser_71 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_10_advertiser_71_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_71_displayed_at_date_idx ON public.impressions_2018_10_advertiser_71 USING btree (displayed_at_date);


--
-- Name: impressions_2018_10_advertiser_71_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_71_payable_idx ON public.impressions_2018_10_advertiser_71 USING btree (payable);


--
-- Name: impressions_2018_10_advertiser_71_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_71_property_id_idx ON public.impressions_2018_10_advertiser_71 USING btree (property_id);


--
-- Name: impressions_2018_10_advertiser_71_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_71_property_name_idx ON public.impressions_2018_10_advertiser_71 USING btree (property_name);


--
-- Name: impressions_2018_10_advertiser_76_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_76_advertiser_id_idx ON public.impressions_2018_10_advertiser_76 USING btree (advertiser_id);


--
-- Name: impressions_2018_10_advertiser_76_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_76_campaign_id_idx ON public.impressions_2018_10_advertiser_76 USING btree (campaign_id);


--
-- Name: impressions_2018_10_advertiser_76_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_76_campaign_name_idx ON public.impressions_2018_10_advertiser_76 USING btree (campaign_name);


--
-- Name: impressions_2018_10_advertiser_76_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_76_country_code_idx ON public.impressions_2018_10_advertiser_76 USING btree (country_code);


--
-- Name: impressions_2018_10_advertiser_76_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_76_date_trunc_idx ON public.impressions_2018_10_advertiser_76 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_10_advertiser_76_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_76_displayed_at_date_idx ON public.impressions_2018_10_advertiser_76 USING btree (displayed_at_date);


--
-- Name: impressions_2018_10_advertiser_76_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_76_payable_idx ON public.impressions_2018_10_advertiser_76 USING btree (payable);


--
-- Name: impressions_2018_10_advertiser_76_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_76_property_id_idx ON public.impressions_2018_10_advertiser_76 USING btree (property_id);


--
-- Name: impressions_2018_10_advertiser_76_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_76_property_name_idx ON public.impressions_2018_10_advertiser_76 USING btree (property_name);


--
-- Name: impressions_2018_10_advertiser__campaign_name_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser__campaign_name_property_name_idx ON public.impressions_2018_10_advertiser_76 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_10_advertiser_campaign_name_property_name_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_campaign_name_property_name_idx1 ON public.impressions_2018_10_advertiser_70 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_10_advertiser_campaign_name_property_name_idx2; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_campaign_name_property_name_idx2 ON public.impressions_2018_10_advertiser_55 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_10_advertiser_campaign_name_property_name_idx3; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_campaign_name_property_name_idx3 ON public.impressions_2018_10_advertiser_71 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_10_advertiser_campaign_name_property_name_idx4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_campaign_name_property_name_idx4 ON public.impressions_2018_10_advertiser_56 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_10_advertiser_campaign_name_property_name_idx5; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_campaign_name_property_name_idx5 ON public.impressions_2018_10_advertiser_53 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_10_advertiser_campaign_name_property_name_idx6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_10_advertiser_campaign_name_property_name_idx6 ON public.impressions_2018_10_advertiser_31 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_11_advertise_campaign_name_property_name_idx10; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertise_campaign_name_property_name_idx10 ON public.impressions_2018_11_advertiser_89 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_11_advertise_campaign_name_property_name_idx11; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertise_campaign_name_property_name_idx11 ON public.impressions_2018_11_advertiser_10 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_11_advertise_campaign_name_property_name_idx12; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertise_campaign_name_property_name_idx12 ON public.impressions_2018_11_advertiser_69 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_11_advertiser_10_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_10_advertiser_id_idx ON public.impressions_2018_11_advertiser_10 USING btree (advertiser_id);


--
-- Name: impressions_2018_11_advertiser_10_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_10_campaign_id_idx ON public.impressions_2018_11_advertiser_10 USING btree (campaign_id);


--
-- Name: impressions_2018_11_advertiser_10_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_10_campaign_name_idx ON public.impressions_2018_11_advertiser_10 USING btree (campaign_name);


--
-- Name: impressions_2018_11_advertiser_10_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_10_country_code_idx ON public.impressions_2018_11_advertiser_10 USING btree (country_code);


--
-- Name: impressions_2018_11_advertiser_10_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_10_date_trunc_idx ON public.impressions_2018_11_advertiser_10 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_11_advertiser_10_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_10_displayed_at_date_idx ON public.impressions_2018_11_advertiser_10 USING btree (displayed_at_date);


--
-- Name: impressions_2018_11_advertiser_10_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_10_payable_idx ON public.impressions_2018_11_advertiser_10 USING btree (payable);


--
-- Name: impressions_2018_11_advertiser_10_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_10_property_id_idx ON public.impressions_2018_11_advertiser_10 USING btree (property_id);


--
-- Name: impressions_2018_11_advertiser_10_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_10_property_name_idx ON public.impressions_2018_11_advertiser_10 USING btree (property_name);


--
-- Name: impressions_2018_11_advertiser_15_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_15_advertiser_id_idx ON public.impressions_2018_11_advertiser_15 USING btree (advertiser_id);


--
-- Name: impressions_2018_11_advertiser_15_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_15_campaign_id_idx ON public.impressions_2018_11_advertiser_15 USING btree (campaign_id);


--
-- Name: impressions_2018_11_advertiser_15_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_15_campaign_name_idx ON public.impressions_2018_11_advertiser_15 USING btree (campaign_name);


--
-- Name: impressions_2018_11_advertiser_15_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_15_country_code_idx ON public.impressions_2018_11_advertiser_15 USING btree (country_code);


--
-- Name: impressions_2018_11_advertiser_15_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_15_date_trunc_idx ON public.impressions_2018_11_advertiser_15 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_11_advertiser_15_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_15_displayed_at_date_idx ON public.impressions_2018_11_advertiser_15 USING btree (displayed_at_date);


--
-- Name: impressions_2018_11_advertiser_15_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_15_payable_idx ON public.impressions_2018_11_advertiser_15 USING btree (payable);


--
-- Name: impressions_2018_11_advertiser_15_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_15_property_id_idx ON public.impressions_2018_11_advertiser_15 USING btree (property_id);


--
-- Name: impressions_2018_11_advertiser_15_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_15_property_name_idx ON public.impressions_2018_11_advertiser_15 USING btree (property_name);


--
-- Name: impressions_2018_11_advertiser_19_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_19_advertiser_id_idx ON public.impressions_2018_11_advertiser_19 USING btree (advertiser_id);


--
-- Name: impressions_2018_11_advertiser_19_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_19_campaign_id_idx ON public.impressions_2018_11_advertiser_19 USING btree (campaign_id);


--
-- Name: impressions_2018_11_advertiser_19_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_19_campaign_name_idx ON public.impressions_2018_11_advertiser_19 USING btree (campaign_name);


--
-- Name: impressions_2018_11_advertiser_19_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_19_country_code_idx ON public.impressions_2018_11_advertiser_19 USING btree (country_code);


--
-- Name: impressions_2018_11_advertiser_19_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_19_date_trunc_idx ON public.impressions_2018_11_advertiser_19 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_11_advertiser_19_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_19_displayed_at_date_idx ON public.impressions_2018_11_advertiser_19 USING btree (displayed_at_date);


--
-- Name: impressions_2018_11_advertiser_19_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_19_payable_idx ON public.impressions_2018_11_advertiser_19 USING btree (payable);


--
-- Name: impressions_2018_11_advertiser_19_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_19_property_id_idx ON public.impressions_2018_11_advertiser_19 USING btree (property_id);


--
-- Name: impressions_2018_11_advertiser_19_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_19_property_name_idx ON public.impressions_2018_11_advertiser_19 USING btree (property_name);


--
-- Name: impressions_2018_11_advertiser_37_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_37_advertiser_id_idx ON public.impressions_2018_11_advertiser_37 USING btree (advertiser_id);


--
-- Name: impressions_2018_11_advertiser_37_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_37_campaign_id_idx ON public.impressions_2018_11_advertiser_37 USING btree (campaign_id);


--
-- Name: impressions_2018_11_advertiser_37_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_37_campaign_name_idx ON public.impressions_2018_11_advertiser_37 USING btree (campaign_name);


--
-- Name: impressions_2018_11_advertiser_37_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_37_country_code_idx ON public.impressions_2018_11_advertiser_37 USING btree (country_code);


--
-- Name: impressions_2018_11_advertiser_37_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_37_date_trunc_idx ON public.impressions_2018_11_advertiser_37 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_11_advertiser_37_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_37_displayed_at_date_idx ON public.impressions_2018_11_advertiser_37 USING btree (displayed_at_date);


--
-- Name: impressions_2018_11_advertiser_37_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_37_payable_idx ON public.impressions_2018_11_advertiser_37 USING btree (payable);


--
-- Name: impressions_2018_11_advertiser_37_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_37_property_id_idx ON public.impressions_2018_11_advertiser_37 USING btree (property_id);


--
-- Name: impressions_2018_11_advertiser_37_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_37_property_name_idx ON public.impressions_2018_11_advertiser_37 USING btree (property_name);


--
-- Name: impressions_2018_11_advertiser_47_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_47_advertiser_id_idx ON public.impressions_2018_11_advertiser_47 USING btree (advertiser_id);


--
-- Name: impressions_2018_11_advertiser_47_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_47_campaign_id_idx ON public.impressions_2018_11_advertiser_47 USING btree (campaign_id);


--
-- Name: impressions_2018_11_advertiser_47_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_47_campaign_name_idx ON public.impressions_2018_11_advertiser_47 USING btree (campaign_name);


--
-- Name: impressions_2018_11_advertiser_47_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_47_country_code_idx ON public.impressions_2018_11_advertiser_47 USING btree (country_code);


--
-- Name: impressions_2018_11_advertiser_47_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_47_date_trunc_idx ON public.impressions_2018_11_advertiser_47 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_11_advertiser_47_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_47_displayed_at_date_idx ON public.impressions_2018_11_advertiser_47 USING btree (displayed_at_date);


--
-- Name: impressions_2018_11_advertiser_47_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_47_payable_idx ON public.impressions_2018_11_advertiser_47 USING btree (payable);


--
-- Name: impressions_2018_11_advertiser_47_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_47_property_id_idx ON public.impressions_2018_11_advertiser_47 USING btree (property_id);


--
-- Name: impressions_2018_11_advertiser_47_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_47_property_name_idx ON public.impressions_2018_11_advertiser_47 USING btree (property_name);


--
-- Name: impressions_2018_11_advertiser_53_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_53_advertiser_id_idx ON public.impressions_2018_11_advertiser_53 USING btree (advertiser_id);


--
-- Name: impressions_2018_11_advertiser_53_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_53_campaign_id_idx ON public.impressions_2018_11_advertiser_53 USING btree (campaign_id);


--
-- Name: impressions_2018_11_advertiser_53_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_53_campaign_name_idx ON public.impressions_2018_11_advertiser_53 USING btree (campaign_name);


--
-- Name: impressions_2018_11_advertiser_53_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_53_country_code_idx ON public.impressions_2018_11_advertiser_53 USING btree (country_code);


--
-- Name: impressions_2018_11_advertiser_53_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_53_date_trunc_idx ON public.impressions_2018_11_advertiser_53 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_11_advertiser_53_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_53_displayed_at_date_idx ON public.impressions_2018_11_advertiser_53 USING btree (displayed_at_date);


--
-- Name: impressions_2018_11_advertiser_53_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_53_payable_idx ON public.impressions_2018_11_advertiser_53 USING btree (payable);


--
-- Name: impressions_2018_11_advertiser_53_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_53_property_id_idx ON public.impressions_2018_11_advertiser_53 USING btree (property_id);


--
-- Name: impressions_2018_11_advertiser_53_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_53_property_name_idx ON public.impressions_2018_11_advertiser_53 USING btree (property_name);


--
-- Name: impressions_2018_11_advertiser_56_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_56_advertiser_id_idx ON public.impressions_2018_11_advertiser_56 USING btree (advertiser_id);


--
-- Name: impressions_2018_11_advertiser_56_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_56_campaign_id_idx ON public.impressions_2018_11_advertiser_56 USING btree (campaign_id);


--
-- Name: impressions_2018_11_advertiser_56_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_56_campaign_name_idx ON public.impressions_2018_11_advertiser_56 USING btree (campaign_name);


--
-- Name: impressions_2018_11_advertiser_56_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_56_country_code_idx ON public.impressions_2018_11_advertiser_56 USING btree (country_code);


--
-- Name: impressions_2018_11_advertiser_56_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_56_date_trunc_idx ON public.impressions_2018_11_advertiser_56 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_11_advertiser_56_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_56_displayed_at_date_idx ON public.impressions_2018_11_advertiser_56 USING btree (displayed_at_date);


--
-- Name: impressions_2018_11_advertiser_56_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_56_payable_idx ON public.impressions_2018_11_advertiser_56 USING btree (payable);


--
-- Name: impressions_2018_11_advertiser_56_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_56_property_id_idx ON public.impressions_2018_11_advertiser_56 USING btree (property_id);


--
-- Name: impressions_2018_11_advertiser_56_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_56_property_name_idx ON public.impressions_2018_11_advertiser_56 USING btree (property_name);


--
-- Name: impressions_2018_11_advertiser_61_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_61_advertiser_id_idx ON public.impressions_2018_11_advertiser_61 USING btree (advertiser_id);


--
-- Name: impressions_2018_11_advertiser_61_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_61_campaign_id_idx ON public.impressions_2018_11_advertiser_61 USING btree (campaign_id);


--
-- Name: impressions_2018_11_advertiser_61_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_61_campaign_name_idx ON public.impressions_2018_11_advertiser_61 USING btree (campaign_name);


--
-- Name: impressions_2018_11_advertiser_61_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_61_country_code_idx ON public.impressions_2018_11_advertiser_61 USING btree (country_code);


--
-- Name: impressions_2018_11_advertiser_61_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_61_date_trunc_idx ON public.impressions_2018_11_advertiser_61 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_11_advertiser_61_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_61_displayed_at_date_idx ON public.impressions_2018_11_advertiser_61 USING btree (displayed_at_date);


--
-- Name: impressions_2018_11_advertiser_61_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_61_payable_idx ON public.impressions_2018_11_advertiser_61 USING btree (payable);


--
-- Name: impressions_2018_11_advertiser_61_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_61_property_id_idx ON public.impressions_2018_11_advertiser_61 USING btree (property_id);


--
-- Name: impressions_2018_11_advertiser_61_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_61_property_name_idx ON public.impressions_2018_11_advertiser_61 USING btree (property_name);


--
-- Name: impressions_2018_11_advertiser_69_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_69_advertiser_id_idx ON public.impressions_2018_11_advertiser_69 USING btree (advertiser_id);


--
-- Name: impressions_2018_11_advertiser_69_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_69_campaign_id_idx ON public.impressions_2018_11_advertiser_69 USING btree (campaign_id);


--
-- Name: impressions_2018_11_advertiser_69_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_69_campaign_name_idx ON public.impressions_2018_11_advertiser_69 USING btree (campaign_name);


--
-- Name: impressions_2018_11_advertiser_69_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_69_country_code_idx ON public.impressions_2018_11_advertiser_69 USING btree (country_code);


--
-- Name: impressions_2018_11_advertiser_69_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_69_date_trunc_idx ON public.impressions_2018_11_advertiser_69 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_11_advertiser_69_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_69_displayed_at_date_idx ON public.impressions_2018_11_advertiser_69 USING btree (displayed_at_date);


--
-- Name: impressions_2018_11_advertiser_69_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_69_payable_idx ON public.impressions_2018_11_advertiser_69 USING btree (payable);


--
-- Name: impressions_2018_11_advertiser_69_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_69_property_id_idx ON public.impressions_2018_11_advertiser_69 USING btree (property_id);


--
-- Name: impressions_2018_11_advertiser_69_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_69_property_name_idx ON public.impressions_2018_11_advertiser_69 USING btree (property_name);


--
-- Name: impressions_2018_11_advertiser_74_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_74_advertiser_id_idx ON public.impressions_2018_11_advertiser_74 USING btree (advertiser_id);


--
-- Name: impressions_2018_11_advertiser_74_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_74_campaign_id_idx ON public.impressions_2018_11_advertiser_74 USING btree (campaign_id);


--
-- Name: impressions_2018_11_advertiser_74_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_74_campaign_name_idx ON public.impressions_2018_11_advertiser_74 USING btree (campaign_name);


--
-- Name: impressions_2018_11_advertiser_74_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_74_country_code_idx ON public.impressions_2018_11_advertiser_74 USING btree (country_code);


--
-- Name: impressions_2018_11_advertiser_74_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_74_date_trunc_idx ON public.impressions_2018_11_advertiser_74 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_11_advertiser_74_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_74_displayed_at_date_idx ON public.impressions_2018_11_advertiser_74 USING btree (displayed_at_date);


--
-- Name: impressions_2018_11_advertiser_74_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_74_payable_idx ON public.impressions_2018_11_advertiser_74 USING btree (payable);


--
-- Name: impressions_2018_11_advertiser_74_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_74_property_id_idx ON public.impressions_2018_11_advertiser_74 USING btree (property_id);


--
-- Name: impressions_2018_11_advertiser_74_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_74_property_name_idx ON public.impressions_2018_11_advertiser_74 USING btree (property_name);


--
-- Name: impressions_2018_11_advertiser_89_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_89_advertiser_id_idx ON public.impressions_2018_11_advertiser_89 USING btree (advertiser_id);


--
-- Name: impressions_2018_11_advertiser_89_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_89_campaign_id_idx ON public.impressions_2018_11_advertiser_89 USING btree (campaign_id);


--
-- Name: impressions_2018_11_advertiser_89_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_89_campaign_name_idx ON public.impressions_2018_11_advertiser_89 USING btree (campaign_name);


--
-- Name: impressions_2018_11_advertiser_89_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_89_country_code_idx ON public.impressions_2018_11_advertiser_89 USING btree (country_code);


--
-- Name: impressions_2018_11_advertiser_89_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_89_date_trunc_idx ON public.impressions_2018_11_advertiser_89 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_11_advertiser_89_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_89_displayed_at_date_idx ON public.impressions_2018_11_advertiser_89 USING btree (displayed_at_date);


--
-- Name: impressions_2018_11_advertiser_89_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_89_payable_idx ON public.impressions_2018_11_advertiser_89 USING btree (payable);


--
-- Name: impressions_2018_11_advertiser_89_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_89_property_id_idx ON public.impressions_2018_11_advertiser_89 USING btree (property_id);


--
-- Name: impressions_2018_11_advertiser_89_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_89_property_name_idx ON public.impressions_2018_11_advertiser_89 USING btree (property_name);


--
-- Name: impressions_2018_11_advertiser_94_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_94_advertiser_id_idx ON public.impressions_2018_11_advertiser_94 USING btree (advertiser_id);


--
-- Name: impressions_2018_11_advertiser_94_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_94_campaign_id_idx ON public.impressions_2018_11_advertiser_94 USING btree (campaign_id);


--
-- Name: impressions_2018_11_advertiser_94_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_94_campaign_name_idx ON public.impressions_2018_11_advertiser_94 USING btree (campaign_name);


--
-- Name: impressions_2018_11_advertiser_94_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_94_country_code_idx ON public.impressions_2018_11_advertiser_94 USING btree (country_code);


--
-- Name: impressions_2018_11_advertiser_94_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_94_date_trunc_idx ON public.impressions_2018_11_advertiser_94 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_11_advertiser_94_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_94_displayed_at_date_idx ON public.impressions_2018_11_advertiser_94 USING btree (displayed_at_date);


--
-- Name: impressions_2018_11_advertiser_94_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_94_payable_idx ON public.impressions_2018_11_advertiser_94 USING btree (payable);


--
-- Name: impressions_2018_11_advertiser_94_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_94_property_id_idx ON public.impressions_2018_11_advertiser_94 USING btree (property_id);


--
-- Name: impressions_2018_11_advertiser_94_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_94_property_name_idx ON public.impressions_2018_11_advertiser_94 USING btree (property_name);


--
-- Name: impressions_2018_11_advertiser_97_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_97_advertiser_id_idx ON public.impressions_2018_11_advertiser_97 USING btree (advertiser_id);


--
-- Name: impressions_2018_11_advertiser_97_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_97_campaign_id_idx ON public.impressions_2018_11_advertiser_97 USING btree (campaign_id);


--
-- Name: impressions_2018_11_advertiser_97_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_97_campaign_name_idx ON public.impressions_2018_11_advertiser_97 USING btree (campaign_name);


--
-- Name: impressions_2018_11_advertiser_97_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_97_country_code_idx ON public.impressions_2018_11_advertiser_97 USING btree (country_code);


--
-- Name: impressions_2018_11_advertiser_97_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_97_date_trunc_idx ON public.impressions_2018_11_advertiser_97 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_11_advertiser_97_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_97_displayed_at_date_idx ON public.impressions_2018_11_advertiser_97 USING btree (displayed_at_date);


--
-- Name: impressions_2018_11_advertiser_97_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_97_payable_idx ON public.impressions_2018_11_advertiser_97 USING btree (payable);


--
-- Name: impressions_2018_11_advertiser_97_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_97_property_id_idx ON public.impressions_2018_11_advertiser_97 USING btree (property_id);


--
-- Name: impressions_2018_11_advertiser_97_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_97_property_name_idx ON public.impressions_2018_11_advertiser_97 USING btree (property_name);


--
-- Name: impressions_2018_11_advertiser__campaign_name_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser__campaign_name_property_name_idx ON public.impressions_2018_11_advertiser_37 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_11_advertiser_campaign_name_property_name_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_campaign_name_property_name_idx1 ON public.impressions_2018_11_advertiser_56 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_11_advertiser_campaign_name_property_name_idx2; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_campaign_name_property_name_idx2 ON public.impressions_2018_11_advertiser_47 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_11_advertiser_campaign_name_property_name_idx3; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_campaign_name_property_name_idx3 ON public.impressions_2018_11_advertiser_97 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_11_advertiser_campaign_name_property_name_idx4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_campaign_name_property_name_idx4 ON public.impressions_2018_11_advertiser_15 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_11_advertiser_campaign_name_property_name_idx5; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_campaign_name_property_name_idx5 ON public.impressions_2018_11_advertiser_53 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_11_advertiser_campaign_name_property_name_idx6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_campaign_name_property_name_idx6 ON public.impressions_2018_11_advertiser_94 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_11_advertiser_campaign_name_property_name_idx7; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_campaign_name_property_name_idx7 ON public.impressions_2018_11_advertiser_19 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_11_advertiser_campaign_name_property_name_idx8; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_campaign_name_property_name_idx8 ON public.impressions_2018_11_advertiser_61 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_11_advertiser_campaign_name_property_name_idx9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_11_advertiser_campaign_name_property_name_idx9 ON public.impressions_2018_11_advertiser_74 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_12_advertise_campaign_name_property_name_idx10; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertise_campaign_name_property_name_idx10 ON public.impressions_2018_12_advertiser_9 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_12_advertise_campaign_name_property_name_idx11; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertise_campaign_name_property_name_idx11 ON public.impressions_2018_12_advertiser_10 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_12_advertise_campaign_name_property_name_idx12; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertise_campaign_name_property_name_idx12 ON public.impressions_2018_12_advertiser_89 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_12_advertise_campaign_name_property_name_idx13; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertise_campaign_name_property_name_idx13 ON public.impressions_2018_12_advertiser_98 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_12_advertise_campaign_name_property_name_idx14; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertise_campaign_name_property_name_idx14 ON public.impressions_2018_12_advertiser_47 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_12_advertise_campaign_name_property_name_idx15; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertise_campaign_name_property_name_idx15 ON public.impressions_2018_12_advertiser_91 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_12_advertise_campaign_name_property_name_idx16; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertise_campaign_name_property_name_idx16 ON public.impressions_2018_12_advertiser_25 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_12_advertise_campaign_name_property_name_idx17; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertise_campaign_name_property_name_idx17 ON public.impressions_2018_12_advertiser_15 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_12_advertise_campaign_name_property_name_idx18; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertise_campaign_name_property_name_idx18 ON public.impressions_2018_12_advertiser_43 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_12_advertise_campaign_name_property_name_idx19; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertise_campaign_name_property_name_idx19 ON public.impressions_2018_12_advertiser_37 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_12_advertise_campaign_name_property_name_idx20; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertise_campaign_name_property_name_idx20 ON public.impressions_2018_12_advertiser_69 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_12_advertiser_10_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_10_advertiser_id_idx ON public.impressions_2018_12_advertiser_10 USING btree (advertiser_id);


--
-- Name: impressions_2018_12_advertiser_10_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_10_campaign_id_idx ON public.impressions_2018_12_advertiser_10 USING btree (campaign_id);


--
-- Name: impressions_2018_12_advertiser_10_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_10_campaign_name_idx ON public.impressions_2018_12_advertiser_10 USING btree (campaign_name);


--
-- Name: impressions_2018_12_advertiser_10_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_10_country_code_idx ON public.impressions_2018_12_advertiser_10 USING btree (country_code);


--
-- Name: impressions_2018_12_advertiser_10_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_10_date_trunc_idx ON public.impressions_2018_12_advertiser_10 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_12_advertiser_10_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_10_displayed_at_date_idx ON public.impressions_2018_12_advertiser_10 USING btree (displayed_at_date);


--
-- Name: impressions_2018_12_advertiser_10_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_10_payable_idx ON public.impressions_2018_12_advertiser_10 USING btree (payable);


--
-- Name: impressions_2018_12_advertiser_10_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_10_property_id_idx ON public.impressions_2018_12_advertiser_10 USING btree (property_id);


--
-- Name: impressions_2018_12_advertiser_10_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_10_property_name_idx ON public.impressions_2018_12_advertiser_10 USING btree (property_name);


--
-- Name: impressions_2018_12_advertiser_15_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_15_advertiser_id_idx ON public.impressions_2018_12_advertiser_15 USING btree (advertiser_id);


--
-- Name: impressions_2018_12_advertiser_15_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_15_campaign_id_idx ON public.impressions_2018_12_advertiser_15 USING btree (campaign_id);


--
-- Name: impressions_2018_12_advertiser_15_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_15_campaign_name_idx ON public.impressions_2018_12_advertiser_15 USING btree (campaign_name);


--
-- Name: impressions_2018_12_advertiser_15_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_15_country_code_idx ON public.impressions_2018_12_advertiser_15 USING btree (country_code);


--
-- Name: impressions_2018_12_advertiser_15_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_15_date_trunc_idx ON public.impressions_2018_12_advertiser_15 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_12_advertiser_15_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_15_displayed_at_date_idx ON public.impressions_2018_12_advertiser_15 USING btree (displayed_at_date);


--
-- Name: impressions_2018_12_advertiser_15_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_15_payable_idx ON public.impressions_2018_12_advertiser_15 USING btree (payable);


--
-- Name: impressions_2018_12_advertiser_15_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_15_property_id_idx ON public.impressions_2018_12_advertiser_15 USING btree (property_id);


--
-- Name: impressions_2018_12_advertiser_15_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_15_property_name_idx ON public.impressions_2018_12_advertiser_15 USING btree (property_name);


--
-- Name: impressions_2018_12_advertiser_19_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_19_advertiser_id_idx ON public.impressions_2018_12_advertiser_19 USING btree (advertiser_id);


--
-- Name: impressions_2018_12_advertiser_19_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_19_campaign_id_idx ON public.impressions_2018_12_advertiser_19 USING btree (campaign_id);


--
-- Name: impressions_2018_12_advertiser_19_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_19_campaign_name_idx ON public.impressions_2018_12_advertiser_19 USING btree (campaign_name);


--
-- Name: impressions_2018_12_advertiser_19_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_19_country_code_idx ON public.impressions_2018_12_advertiser_19 USING btree (country_code);


--
-- Name: impressions_2018_12_advertiser_19_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_19_date_trunc_idx ON public.impressions_2018_12_advertiser_19 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_12_advertiser_19_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_19_displayed_at_date_idx ON public.impressions_2018_12_advertiser_19 USING btree (displayed_at_date);


--
-- Name: impressions_2018_12_advertiser_19_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_19_payable_idx ON public.impressions_2018_12_advertiser_19 USING btree (payable);


--
-- Name: impressions_2018_12_advertiser_19_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_19_property_id_idx ON public.impressions_2018_12_advertiser_19 USING btree (property_id);


--
-- Name: impressions_2018_12_advertiser_19_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_19_property_name_idx ON public.impressions_2018_12_advertiser_19 USING btree (property_name);


--
-- Name: impressions_2018_12_advertiser_22_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_22_advertiser_id_idx ON public.impressions_2018_12_advertiser_22 USING btree (advertiser_id);


--
-- Name: impressions_2018_12_advertiser_22_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_22_campaign_id_idx ON public.impressions_2018_12_advertiser_22 USING btree (campaign_id);


--
-- Name: impressions_2018_12_advertiser_22_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_22_campaign_name_idx ON public.impressions_2018_12_advertiser_22 USING btree (campaign_name);


--
-- Name: impressions_2018_12_advertiser_22_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_22_country_code_idx ON public.impressions_2018_12_advertiser_22 USING btree (country_code);


--
-- Name: impressions_2018_12_advertiser_22_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_22_date_trunc_idx ON public.impressions_2018_12_advertiser_22 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_12_advertiser_22_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_22_displayed_at_date_idx ON public.impressions_2018_12_advertiser_22 USING btree (displayed_at_date);


--
-- Name: impressions_2018_12_advertiser_22_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_22_payable_idx ON public.impressions_2018_12_advertiser_22 USING btree (payable);


--
-- Name: impressions_2018_12_advertiser_22_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_22_property_id_idx ON public.impressions_2018_12_advertiser_22 USING btree (property_id);


--
-- Name: impressions_2018_12_advertiser_22_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_22_property_name_idx ON public.impressions_2018_12_advertiser_22 USING btree (property_name);


--
-- Name: impressions_2018_12_advertiser_25_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_25_advertiser_id_idx ON public.impressions_2018_12_advertiser_25 USING btree (advertiser_id);


--
-- Name: impressions_2018_12_advertiser_25_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_25_campaign_id_idx ON public.impressions_2018_12_advertiser_25 USING btree (campaign_id);


--
-- Name: impressions_2018_12_advertiser_25_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_25_campaign_name_idx ON public.impressions_2018_12_advertiser_25 USING btree (campaign_name);


--
-- Name: impressions_2018_12_advertiser_25_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_25_country_code_idx ON public.impressions_2018_12_advertiser_25 USING btree (country_code);


--
-- Name: impressions_2018_12_advertiser_25_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_25_date_trunc_idx ON public.impressions_2018_12_advertiser_25 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_12_advertiser_25_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_25_displayed_at_date_idx ON public.impressions_2018_12_advertiser_25 USING btree (displayed_at_date);


--
-- Name: impressions_2018_12_advertiser_25_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_25_payable_idx ON public.impressions_2018_12_advertiser_25 USING btree (payable);


--
-- Name: impressions_2018_12_advertiser_25_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_25_property_id_idx ON public.impressions_2018_12_advertiser_25 USING btree (property_id);


--
-- Name: impressions_2018_12_advertiser_25_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_25_property_name_idx ON public.impressions_2018_12_advertiser_25 USING btree (property_name);


--
-- Name: impressions_2018_12_advertiser_27_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_27_advertiser_id_idx ON public.impressions_2018_12_advertiser_27 USING btree (advertiser_id);


--
-- Name: impressions_2018_12_advertiser_27_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_27_campaign_id_idx ON public.impressions_2018_12_advertiser_27 USING btree (campaign_id);


--
-- Name: impressions_2018_12_advertiser_27_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_27_campaign_name_idx ON public.impressions_2018_12_advertiser_27 USING btree (campaign_name);


--
-- Name: impressions_2018_12_advertiser_27_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_27_country_code_idx ON public.impressions_2018_12_advertiser_27 USING btree (country_code);


--
-- Name: impressions_2018_12_advertiser_27_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_27_date_trunc_idx ON public.impressions_2018_12_advertiser_27 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_12_advertiser_27_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_27_displayed_at_date_idx ON public.impressions_2018_12_advertiser_27 USING btree (displayed_at_date);


--
-- Name: impressions_2018_12_advertiser_27_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_27_payable_idx ON public.impressions_2018_12_advertiser_27 USING btree (payable);


--
-- Name: impressions_2018_12_advertiser_27_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_27_property_id_idx ON public.impressions_2018_12_advertiser_27 USING btree (property_id);


--
-- Name: impressions_2018_12_advertiser_27_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_27_property_name_idx ON public.impressions_2018_12_advertiser_27 USING btree (property_name);


--
-- Name: impressions_2018_12_advertiser_2_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_2_advertiser_id_idx ON public.impressions_2018_12_advertiser_2 USING btree (advertiser_id);


--
-- Name: impressions_2018_12_advertiser_2_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_2_campaign_id_idx ON public.impressions_2018_12_advertiser_2 USING btree (campaign_id);


--
-- Name: impressions_2018_12_advertiser_2_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_2_campaign_name_idx ON public.impressions_2018_12_advertiser_2 USING btree (campaign_name);


--
-- Name: impressions_2018_12_advertiser_2_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_2_country_code_idx ON public.impressions_2018_12_advertiser_2 USING btree (country_code);


--
-- Name: impressions_2018_12_advertiser_2_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_2_date_trunc_idx ON public.impressions_2018_12_advertiser_2 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_12_advertiser_2_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_2_displayed_at_date_idx ON public.impressions_2018_12_advertiser_2 USING btree (displayed_at_date);


--
-- Name: impressions_2018_12_advertiser_2_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_2_payable_idx ON public.impressions_2018_12_advertiser_2 USING btree (payable);


--
-- Name: impressions_2018_12_advertiser_2_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_2_property_id_idx ON public.impressions_2018_12_advertiser_2 USING btree (property_id);


--
-- Name: impressions_2018_12_advertiser_2_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_2_property_name_idx ON public.impressions_2018_12_advertiser_2 USING btree (property_name);


--
-- Name: impressions_2018_12_advertiser_37_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_37_advertiser_id_idx ON public.impressions_2018_12_advertiser_37 USING btree (advertiser_id);


--
-- Name: impressions_2018_12_advertiser_37_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_37_campaign_id_idx ON public.impressions_2018_12_advertiser_37 USING btree (campaign_id);


--
-- Name: impressions_2018_12_advertiser_37_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_37_campaign_name_idx ON public.impressions_2018_12_advertiser_37 USING btree (campaign_name);


--
-- Name: impressions_2018_12_advertiser_37_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_37_country_code_idx ON public.impressions_2018_12_advertiser_37 USING btree (country_code);


--
-- Name: impressions_2018_12_advertiser_37_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_37_date_trunc_idx ON public.impressions_2018_12_advertiser_37 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_12_advertiser_37_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_37_displayed_at_date_idx ON public.impressions_2018_12_advertiser_37 USING btree (displayed_at_date);


--
-- Name: impressions_2018_12_advertiser_37_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_37_payable_idx ON public.impressions_2018_12_advertiser_37 USING btree (payable);


--
-- Name: impressions_2018_12_advertiser_37_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_37_property_id_idx ON public.impressions_2018_12_advertiser_37 USING btree (property_id);


--
-- Name: impressions_2018_12_advertiser_37_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_37_property_name_idx ON public.impressions_2018_12_advertiser_37 USING btree (property_name);


--
-- Name: impressions_2018_12_advertiser_43_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_43_advertiser_id_idx ON public.impressions_2018_12_advertiser_43 USING btree (advertiser_id);


--
-- Name: impressions_2018_12_advertiser_43_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_43_campaign_id_idx ON public.impressions_2018_12_advertiser_43 USING btree (campaign_id);


--
-- Name: impressions_2018_12_advertiser_43_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_43_campaign_name_idx ON public.impressions_2018_12_advertiser_43 USING btree (campaign_name);


--
-- Name: impressions_2018_12_advertiser_43_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_43_country_code_idx ON public.impressions_2018_12_advertiser_43 USING btree (country_code);


--
-- Name: impressions_2018_12_advertiser_43_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_43_date_trunc_idx ON public.impressions_2018_12_advertiser_43 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_12_advertiser_43_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_43_displayed_at_date_idx ON public.impressions_2018_12_advertiser_43 USING btree (displayed_at_date);


--
-- Name: impressions_2018_12_advertiser_43_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_43_payable_idx ON public.impressions_2018_12_advertiser_43 USING btree (payable);


--
-- Name: impressions_2018_12_advertiser_43_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_43_property_id_idx ON public.impressions_2018_12_advertiser_43 USING btree (property_id);


--
-- Name: impressions_2018_12_advertiser_43_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_43_property_name_idx ON public.impressions_2018_12_advertiser_43 USING btree (property_name);


--
-- Name: impressions_2018_12_advertiser_45_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_45_advertiser_id_idx ON public.impressions_2018_12_advertiser_45 USING btree (advertiser_id);


--
-- Name: impressions_2018_12_advertiser_45_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_45_campaign_id_idx ON public.impressions_2018_12_advertiser_45 USING btree (campaign_id);


--
-- Name: impressions_2018_12_advertiser_45_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_45_campaign_name_idx ON public.impressions_2018_12_advertiser_45 USING btree (campaign_name);


--
-- Name: impressions_2018_12_advertiser_45_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_45_country_code_idx ON public.impressions_2018_12_advertiser_45 USING btree (country_code);


--
-- Name: impressions_2018_12_advertiser_45_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_45_date_trunc_idx ON public.impressions_2018_12_advertiser_45 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_12_advertiser_45_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_45_displayed_at_date_idx ON public.impressions_2018_12_advertiser_45 USING btree (displayed_at_date);


--
-- Name: impressions_2018_12_advertiser_45_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_45_payable_idx ON public.impressions_2018_12_advertiser_45 USING btree (payable);


--
-- Name: impressions_2018_12_advertiser_45_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_45_property_id_idx ON public.impressions_2018_12_advertiser_45 USING btree (property_id);


--
-- Name: impressions_2018_12_advertiser_45_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_45_property_name_idx ON public.impressions_2018_12_advertiser_45 USING btree (property_name);


--
-- Name: impressions_2018_12_advertiser_47_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_47_advertiser_id_idx ON public.impressions_2018_12_advertiser_47 USING btree (advertiser_id);


--
-- Name: impressions_2018_12_advertiser_47_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_47_campaign_id_idx ON public.impressions_2018_12_advertiser_47 USING btree (campaign_id);


--
-- Name: impressions_2018_12_advertiser_47_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_47_campaign_name_idx ON public.impressions_2018_12_advertiser_47 USING btree (campaign_name);


--
-- Name: impressions_2018_12_advertiser_47_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_47_country_code_idx ON public.impressions_2018_12_advertiser_47 USING btree (country_code);


--
-- Name: impressions_2018_12_advertiser_47_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_47_date_trunc_idx ON public.impressions_2018_12_advertiser_47 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_12_advertiser_47_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_47_displayed_at_date_idx ON public.impressions_2018_12_advertiser_47 USING btree (displayed_at_date);


--
-- Name: impressions_2018_12_advertiser_47_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_47_payable_idx ON public.impressions_2018_12_advertiser_47 USING btree (payable);


--
-- Name: impressions_2018_12_advertiser_47_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_47_property_id_idx ON public.impressions_2018_12_advertiser_47 USING btree (property_id);


--
-- Name: impressions_2018_12_advertiser_47_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_47_property_name_idx ON public.impressions_2018_12_advertiser_47 USING btree (property_name);


--
-- Name: impressions_2018_12_advertiser_53_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_53_advertiser_id_idx ON public.impressions_2018_12_advertiser_53 USING btree (advertiser_id);


--
-- Name: impressions_2018_12_advertiser_53_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_53_campaign_id_idx ON public.impressions_2018_12_advertiser_53 USING btree (campaign_id);


--
-- Name: impressions_2018_12_advertiser_53_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_53_campaign_name_idx ON public.impressions_2018_12_advertiser_53 USING btree (campaign_name);


--
-- Name: impressions_2018_12_advertiser_53_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_53_country_code_idx ON public.impressions_2018_12_advertiser_53 USING btree (country_code);


--
-- Name: impressions_2018_12_advertiser_53_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_53_date_trunc_idx ON public.impressions_2018_12_advertiser_53 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_12_advertiser_53_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_53_displayed_at_date_idx ON public.impressions_2018_12_advertiser_53 USING btree (displayed_at_date);


--
-- Name: impressions_2018_12_advertiser_53_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_53_payable_idx ON public.impressions_2018_12_advertiser_53 USING btree (payable);


--
-- Name: impressions_2018_12_advertiser_53_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_53_property_id_idx ON public.impressions_2018_12_advertiser_53 USING btree (property_id);


--
-- Name: impressions_2018_12_advertiser_53_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_53_property_name_idx ON public.impressions_2018_12_advertiser_53 USING btree (property_name);


--
-- Name: impressions_2018_12_advertiser_61_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_61_advertiser_id_idx ON public.impressions_2018_12_advertiser_61 USING btree (advertiser_id);


--
-- Name: impressions_2018_12_advertiser_61_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_61_campaign_id_idx ON public.impressions_2018_12_advertiser_61 USING btree (campaign_id);


--
-- Name: impressions_2018_12_advertiser_61_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_61_campaign_name_idx ON public.impressions_2018_12_advertiser_61 USING btree (campaign_name);


--
-- Name: impressions_2018_12_advertiser_61_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_61_country_code_idx ON public.impressions_2018_12_advertiser_61 USING btree (country_code);


--
-- Name: impressions_2018_12_advertiser_61_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_61_date_trunc_idx ON public.impressions_2018_12_advertiser_61 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_12_advertiser_61_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_61_displayed_at_date_idx ON public.impressions_2018_12_advertiser_61 USING btree (displayed_at_date);


--
-- Name: impressions_2018_12_advertiser_61_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_61_payable_idx ON public.impressions_2018_12_advertiser_61 USING btree (payable);


--
-- Name: impressions_2018_12_advertiser_61_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_61_property_id_idx ON public.impressions_2018_12_advertiser_61 USING btree (property_id);


--
-- Name: impressions_2018_12_advertiser_61_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_61_property_name_idx ON public.impressions_2018_12_advertiser_61 USING btree (property_name);


--
-- Name: impressions_2018_12_advertiser_69_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_69_advertiser_id_idx ON public.impressions_2018_12_advertiser_69 USING btree (advertiser_id);


--
-- Name: impressions_2018_12_advertiser_69_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_69_campaign_id_idx ON public.impressions_2018_12_advertiser_69 USING btree (campaign_id);


--
-- Name: impressions_2018_12_advertiser_69_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_69_campaign_name_idx ON public.impressions_2018_12_advertiser_69 USING btree (campaign_name);


--
-- Name: impressions_2018_12_advertiser_69_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_69_country_code_idx ON public.impressions_2018_12_advertiser_69 USING btree (country_code);


--
-- Name: impressions_2018_12_advertiser_69_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_69_date_trunc_idx ON public.impressions_2018_12_advertiser_69 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_12_advertiser_69_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_69_displayed_at_date_idx ON public.impressions_2018_12_advertiser_69 USING btree (displayed_at_date);


--
-- Name: impressions_2018_12_advertiser_69_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_69_payable_idx ON public.impressions_2018_12_advertiser_69 USING btree (payable);


--
-- Name: impressions_2018_12_advertiser_69_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_69_property_id_idx ON public.impressions_2018_12_advertiser_69 USING btree (property_id);


--
-- Name: impressions_2018_12_advertiser_69_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_69_property_name_idx ON public.impressions_2018_12_advertiser_69 USING btree (property_name);


--
-- Name: impressions_2018_12_advertiser_74_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_74_advertiser_id_idx ON public.impressions_2018_12_advertiser_74 USING btree (advertiser_id);


--
-- Name: impressions_2018_12_advertiser_74_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_74_campaign_id_idx ON public.impressions_2018_12_advertiser_74 USING btree (campaign_id);


--
-- Name: impressions_2018_12_advertiser_74_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_74_campaign_name_idx ON public.impressions_2018_12_advertiser_74 USING btree (campaign_name);


--
-- Name: impressions_2018_12_advertiser_74_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_74_country_code_idx ON public.impressions_2018_12_advertiser_74 USING btree (country_code);


--
-- Name: impressions_2018_12_advertiser_74_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_74_date_trunc_idx ON public.impressions_2018_12_advertiser_74 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_12_advertiser_74_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_74_displayed_at_date_idx ON public.impressions_2018_12_advertiser_74 USING btree (displayed_at_date);


--
-- Name: impressions_2018_12_advertiser_74_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_74_payable_idx ON public.impressions_2018_12_advertiser_74 USING btree (payable);


--
-- Name: impressions_2018_12_advertiser_74_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_74_property_id_idx ON public.impressions_2018_12_advertiser_74 USING btree (property_id);


--
-- Name: impressions_2018_12_advertiser_74_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_74_property_name_idx ON public.impressions_2018_12_advertiser_74 USING btree (property_name);


--
-- Name: impressions_2018_12_advertiser_87_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_87_advertiser_id_idx ON public.impressions_2018_12_advertiser_87 USING btree (advertiser_id);


--
-- Name: impressions_2018_12_advertiser_87_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_87_campaign_id_idx ON public.impressions_2018_12_advertiser_87 USING btree (campaign_id);


--
-- Name: impressions_2018_12_advertiser_87_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_87_campaign_name_idx ON public.impressions_2018_12_advertiser_87 USING btree (campaign_name);


--
-- Name: impressions_2018_12_advertiser_87_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_87_country_code_idx ON public.impressions_2018_12_advertiser_87 USING btree (country_code);


--
-- Name: impressions_2018_12_advertiser_87_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_87_date_trunc_idx ON public.impressions_2018_12_advertiser_87 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_12_advertiser_87_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_87_displayed_at_date_idx ON public.impressions_2018_12_advertiser_87 USING btree (displayed_at_date);


--
-- Name: impressions_2018_12_advertiser_87_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_87_payable_idx ON public.impressions_2018_12_advertiser_87 USING btree (payable);


--
-- Name: impressions_2018_12_advertiser_87_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_87_property_id_idx ON public.impressions_2018_12_advertiser_87 USING btree (property_id);


--
-- Name: impressions_2018_12_advertiser_87_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_87_property_name_idx ON public.impressions_2018_12_advertiser_87 USING btree (property_name);


--
-- Name: impressions_2018_12_advertiser_88_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_88_advertiser_id_idx ON public.impressions_2018_12_advertiser_88 USING btree (advertiser_id);


--
-- Name: impressions_2018_12_advertiser_88_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_88_campaign_id_idx ON public.impressions_2018_12_advertiser_88 USING btree (campaign_id);


--
-- Name: impressions_2018_12_advertiser_88_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_88_campaign_name_idx ON public.impressions_2018_12_advertiser_88 USING btree (campaign_name);


--
-- Name: impressions_2018_12_advertiser_88_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_88_country_code_idx ON public.impressions_2018_12_advertiser_88 USING btree (country_code);


--
-- Name: impressions_2018_12_advertiser_88_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_88_date_trunc_idx ON public.impressions_2018_12_advertiser_88 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_12_advertiser_88_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_88_displayed_at_date_idx ON public.impressions_2018_12_advertiser_88 USING btree (displayed_at_date);


--
-- Name: impressions_2018_12_advertiser_88_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_88_payable_idx ON public.impressions_2018_12_advertiser_88 USING btree (payable);


--
-- Name: impressions_2018_12_advertiser_88_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_88_property_id_idx ON public.impressions_2018_12_advertiser_88 USING btree (property_id);


--
-- Name: impressions_2018_12_advertiser_88_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_88_property_name_idx ON public.impressions_2018_12_advertiser_88 USING btree (property_name);


--
-- Name: impressions_2018_12_advertiser_89_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_89_advertiser_id_idx ON public.impressions_2018_12_advertiser_89 USING btree (advertiser_id);


--
-- Name: impressions_2018_12_advertiser_89_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_89_campaign_id_idx ON public.impressions_2018_12_advertiser_89 USING btree (campaign_id);


--
-- Name: impressions_2018_12_advertiser_89_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_89_campaign_name_idx ON public.impressions_2018_12_advertiser_89 USING btree (campaign_name);


--
-- Name: impressions_2018_12_advertiser_89_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_89_country_code_idx ON public.impressions_2018_12_advertiser_89 USING btree (country_code);


--
-- Name: impressions_2018_12_advertiser_89_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_89_date_trunc_idx ON public.impressions_2018_12_advertiser_89 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_12_advertiser_89_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_89_displayed_at_date_idx ON public.impressions_2018_12_advertiser_89 USING btree (displayed_at_date);


--
-- Name: impressions_2018_12_advertiser_89_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_89_payable_idx ON public.impressions_2018_12_advertiser_89 USING btree (payable);


--
-- Name: impressions_2018_12_advertiser_89_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_89_property_id_idx ON public.impressions_2018_12_advertiser_89 USING btree (property_id);


--
-- Name: impressions_2018_12_advertiser_89_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_89_property_name_idx ON public.impressions_2018_12_advertiser_89 USING btree (property_name);


--
-- Name: impressions_2018_12_advertiser_91_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_91_advertiser_id_idx ON public.impressions_2018_12_advertiser_91 USING btree (advertiser_id);


--
-- Name: impressions_2018_12_advertiser_91_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_91_campaign_id_idx ON public.impressions_2018_12_advertiser_91 USING btree (campaign_id);


--
-- Name: impressions_2018_12_advertiser_91_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_91_campaign_name_idx ON public.impressions_2018_12_advertiser_91 USING btree (campaign_name);


--
-- Name: impressions_2018_12_advertiser_91_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_91_country_code_idx ON public.impressions_2018_12_advertiser_91 USING btree (country_code);


--
-- Name: impressions_2018_12_advertiser_91_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_91_date_trunc_idx ON public.impressions_2018_12_advertiser_91 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_12_advertiser_91_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_91_displayed_at_date_idx ON public.impressions_2018_12_advertiser_91 USING btree (displayed_at_date);


--
-- Name: impressions_2018_12_advertiser_91_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_91_payable_idx ON public.impressions_2018_12_advertiser_91 USING btree (payable);


--
-- Name: impressions_2018_12_advertiser_91_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_91_property_id_idx ON public.impressions_2018_12_advertiser_91 USING btree (property_id);


--
-- Name: impressions_2018_12_advertiser_91_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_91_property_name_idx ON public.impressions_2018_12_advertiser_91 USING btree (property_name);


--
-- Name: impressions_2018_12_advertiser_98_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_98_advertiser_id_idx ON public.impressions_2018_12_advertiser_98 USING btree (advertiser_id);


--
-- Name: impressions_2018_12_advertiser_98_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_98_campaign_id_idx ON public.impressions_2018_12_advertiser_98 USING btree (campaign_id);


--
-- Name: impressions_2018_12_advertiser_98_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_98_campaign_name_idx ON public.impressions_2018_12_advertiser_98 USING btree (campaign_name);


--
-- Name: impressions_2018_12_advertiser_98_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_98_country_code_idx ON public.impressions_2018_12_advertiser_98 USING btree (country_code);


--
-- Name: impressions_2018_12_advertiser_98_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_98_date_trunc_idx ON public.impressions_2018_12_advertiser_98 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_12_advertiser_98_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_98_displayed_at_date_idx ON public.impressions_2018_12_advertiser_98 USING btree (displayed_at_date);


--
-- Name: impressions_2018_12_advertiser_98_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_98_payable_idx ON public.impressions_2018_12_advertiser_98 USING btree (payable);


--
-- Name: impressions_2018_12_advertiser_98_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_98_property_id_idx ON public.impressions_2018_12_advertiser_98 USING btree (property_id);


--
-- Name: impressions_2018_12_advertiser_98_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_98_property_name_idx ON public.impressions_2018_12_advertiser_98 USING btree (property_name);


--
-- Name: impressions_2018_12_advertiser_9_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_9_advertiser_id_idx ON public.impressions_2018_12_advertiser_9 USING btree (advertiser_id);


--
-- Name: impressions_2018_12_advertiser_9_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_9_campaign_id_idx ON public.impressions_2018_12_advertiser_9 USING btree (campaign_id);


--
-- Name: impressions_2018_12_advertiser_9_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_9_campaign_name_idx ON public.impressions_2018_12_advertiser_9 USING btree (campaign_name);


--
-- Name: impressions_2018_12_advertiser_9_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_9_country_code_idx ON public.impressions_2018_12_advertiser_9 USING btree (country_code);


--
-- Name: impressions_2018_12_advertiser_9_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_9_date_trunc_idx ON public.impressions_2018_12_advertiser_9 USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_2018_12_advertiser_9_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_9_displayed_at_date_idx ON public.impressions_2018_12_advertiser_9 USING btree (displayed_at_date);


--
-- Name: impressions_2018_12_advertiser_9_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_9_payable_idx ON public.impressions_2018_12_advertiser_9 USING btree (payable);


--
-- Name: impressions_2018_12_advertiser_9_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_9_property_id_idx ON public.impressions_2018_12_advertiser_9 USING btree (property_id);


--
-- Name: impressions_2018_12_advertiser_9_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_9_property_name_idx ON public.impressions_2018_12_advertiser_9 USING btree (property_name);


--
-- Name: impressions_2018_12_advertiser__campaign_name_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser__campaign_name_property_name_idx ON public.impressions_2018_12_advertiser_19 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_12_advertiser_campaign_name_property_name_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_campaign_name_property_name_idx1 ON public.impressions_2018_12_advertiser_53 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_12_advertiser_campaign_name_property_name_idx2; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_campaign_name_property_name_idx2 ON public.impressions_2018_12_advertiser_61 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_12_advertiser_campaign_name_property_name_idx3; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_campaign_name_property_name_idx3 ON public.impressions_2018_12_advertiser_2 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_12_advertiser_campaign_name_property_name_idx4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_campaign_name_property_name_idx4 ON public.impressions_2018_12_advertiser_87 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_12_advertiser_campaign_name_property_name_idx5; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_campaign_name_property_name_idx5 ON public.impressions_2018_12_advertiser_27 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_12_advertiser_campaign_name_property_name_idx6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_campaign_name_property_name_idx6 ON public.impressions_2018_12_advertiser_45 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_12_advertiser_campaign_name_property_name_idx7; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_campaign_name_property_name_idx7 ON public.impressions_2018_12_advertiser_22 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_12_advertiser_campaign_name_property_name_idx8; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_campaign_name_property_name_idx8 ON public.impressions_2018_12_advertiser_74 USING btree (campaign_name, property_name);


--
-- Name: impressions_2018_12_advertiser_campaign_name_property_name_idx9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_2018_12_advertiser_campaign_name_property_name_idx9 ON public.impressions_2018_12_advertiser_88 USING btree (campaign_name, property_name);


--
-- Name: impressions_default_advertiser_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_advertiser_id_idx ON public.impressions_default USING btree (advertiser_id);


--
-- Name: impressions_default_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_campaign_id_idx ON public.impressions_default USING btree (campaign_id);


--
-- Name: impressions_default_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_campaign_name_idx ON public.impressions_default USING btree (campaign_name);


--
-- Name: impressions_default_campaign_name_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_campaign_name_property_name_idx ON public.impressions_default USING btree (campaign_name, property_name);


--
-- Name: impressions_default_country_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_country_code_idx ON public.impressions_default USING btree (country_code);


--
-- Name: impressions_default_date_trunc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_date_trunc_idx ON public.impressions_default USING btree (date_trunc('hour'::text, displayed_at));


--
-- Name: impressions_default_displayed_at_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_displayed_at_date_idx ON public.impressions_default USING btree (displayed_at_date);


--
-- Name: impressions_default_payable_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_payable_idx ON public.impressions_default USING btree (payable);


--
-- Name: impressions_default_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_property_id_idx ON public.impressions_default USING btree (property_id);


--
-- Name: impressions_default_property_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_property_name_idx ON public.impressions_default USING btree (property_name);


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
-- Name: index_comments_on_commentable_id_and_commentable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_commentable_id_and_commentable_type ON public.comments USING btree (commentable_id, commentable_type);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_user_id ON public.comments USING btree (user_id);


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
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_item_type_and_item_id ON public.versions USING btree (item_type, item_id);


--
-- Name: impressions_2018_03_advertise_campaign_name_property_name_idx10; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_03_advertise_campaign_name_property_name_idx10;


--
-- Name: impressions_2018_03_advertise_campaign_name_property_name_idx11; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_03_advertise_campaign_name_property_name_idx11;


--
-- Name: impressions_2018_03_advertise_campaign_name_property_name_idx12; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_03_advertise_campaign_name_property_name_idx12;


--
-- Name: impressions_2018_03_advertise_campaign_name_property_name_idx13; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_03_advertise_campaign_name_property_name_idx13;


--
-- Name: impressions_2018_03_advertiser_15_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_03_advertiser_15_advertiser_id_idx;


--
-- Name: impressions_2018_03_advertiser_15_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_03_advertiser_15_campaign_id_idx;


--
-- Name: impressions_2018_03_advertiser_15_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_03_advertiser_15_campaign_name_idx;


--
-- Name: impressions_2018_03_advertiser_15_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_03_advertiser_15_country_code_idx;


--
-- Name: impressions_2018_03_advertiser_15_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_03_advertiser_15_date_trunc_idx;


--
-- Name: impressions_2018_03_advertiser_15_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_03_advertiser_15_displayed_at_date_idx;


--
-- Name: impressions_2018_03_advertiser_15_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_03_advertiser_15_payable_idx;


--
-- Name: impressions_2018_03_advertiser_15_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_03_advertiser_15_property_id_idx;


--
-- Name: impressions_2018_03_advertiser_15_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_03_advertiser_15_property_name_idx;


--
-- Name: impressions_2018_03_advertiser_16_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_03_advertiser_16_advertiser_id_idx;


--
-- Name: impressions_2018_03_advertiser_16_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_03_advertiser_16_campaign_id_idx;


--
-- Name: impressions_2018_03_advertiser_16_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_03_advertiser_16_campaign_name_idx;


--
-- Name: impressions_2018_03_advertiser_16_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_03_advertiser_16_country_code_idx;


--
-- Name: impressions_2018_03_advertiser_16_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_03_advertiser_16_date_trunc_idx;


--
-- Name: impressions_2018_03_advertiser_16_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_03_advertiser_16_displayed_at_date_idx;


--
-- Name: impressions_2018_03_advertiser_16_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_03_advertiser_16_payable_idx;


--
-- Name: impressions_2018_03_advertiser_16_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_03_advertiser_16_property_id_idx;


--
-- Name: impressions_2018_03_advertiser_16_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_03_advertiser_16_property_name_idx;


--
-- Name: impressions_2018_03_advertiser_24_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_03_advertiser_24_advertiser_id_idx;


--
-- Name: impressions_2018_03_advertiser_24_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_03_advertiser_24_campaign_id_idx;


--
-- Name: impressions_2018_03_advertiser_24_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_03_advertiser_24_campaign_name_idx;


--
-- Name: impressions_2018_03_advertiser_24_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_03_advertiser_24_country_code_idx;


--
-- Name: impressions_2018_03_advertiser_24_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_03_advertiser_24_date_trunc_idx;


--
-- Name: impressions_2018_03_advertiser_24_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_03_advertiser_24_displayed_at_date_idx;


--
-- Name: impressions_2018_03_advertiser_24_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_03_advertiser_24_payable_idx;


--
-- Name: impressions_2018_03_advertiser_24_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_03_advertiser_24_property_id_idx;


--
-- Name: impressions_2018_03_advertiser_24_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_03_advertiser_24_property_name_idx;


--
-- Name: impressions_2018_03_advertiser_27_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_03_advertiser_27_advertiser_id_idx;


--
-- Name: impressions_2018_03_advertiser_27_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_03_advertiser_27_campaign_id_idx;


--
-- Name: impressions_2018_03_advertiser_27_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_03_advertiser_27_campaign_name_idx;


--
-- Name: impressions_2018_03_advertiser_27_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_03_advertiser_27_country_code_idx;


--
-- Name: impressions_2018_03_advertiser_27_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_03_advertiser_27_date_trunc_idx;


--
-- Name: impressions_2018_03_advertiser_27_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_03_advertiser_27_displayed_at_date_idx;


--
-- Name: impressions_2018_03_advertiser_27_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_03_advertiser_27_payable_idx;


--
-- Name: impressions_2018_03_advertiser_27_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_03_advertiser_27_property_id_idx;


--
-- Name: impressions_2018_03_advertiser_27_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_03_advertiser_27_property_name_idx;


--
-- Name: impressions_2018_03_advertiser_33_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_03_advertiser_33_advertiser_id_idx;


--
-- Name: impressions_2018_03_advertiser_33_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_03_advertiser_33_campaign_id_idx;


--
-- Name: impressions_2018_03_advertiser_33_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_03_advertiser_33_campaign_name_idx;


--
-- Name: impressions_2018_03_advertiser_33_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_03_advertiser_33_country_code_idx;


--
-- Name: impressions_2018_03_advertiser_33_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_03_advertiser_33_date_trunc_idx;


--
-- Name: impressions_2018_03_advertiser_33_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_03_advertiser_33_displayed_at_date_idx;


--
-- Name: impressions_2018_03_advertiser_33_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_03_advertiser_33_payable_idx;


--
-- Name: impressions_2018_03_advertiser_33_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_03_advertiser_33_property_id_idx;


--
-- Name: impressions_2018_03_advertiser_33_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_03_advertiser_33_property_name_idx;


--
-- Name: impressions_2018_03_advertiser_59_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_03_advertiser_59_advertiser_id_idx;


--
-- Name: impressions_2018_03_advertiser_59_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_03_advertiser_59_campaign_id_idx;


--
-- Name: impressions_2018_03_advertiser_59_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_03_advertiser_59_campaign_name_idx;


--
-- Name: impressions_2018_03_advertiser_59_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_03_advertiser_59_country_code_idx;


--
-- Name: impressions_2018_03_advertiser_59_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_03_advertiser_59_date_trunc_idx;


--
-- Name: impressions_2018_03_advertiser_59_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_03_advertiser_59_displayed_at_date_idx;


--
-- Name: impressions_2018_03_advertiser_59_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_03_advertiser_59_payable_idx;


--
-- Name: impressions_2018_03_advertiser_59_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_03_advertiser_59_property_id_idx;


--
-- Name: impressions_2018_03_advertiser_59_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_03_advertiser_59_property_name_idx;


--
-- Name: impressions_2018_03_advertiser_66_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_03_advertiser_66_advertiser_id_idx;


--
-- Name: impressions_2018_03_advertiser_66_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_03_advertiser_66_campaign_id_idx;


--
-- Name: impressions_2018_03_advertiser_66_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_03_advertiser_66_campaign_name_idx;


--
-- Name: impressions_2018_03_advertiser_66_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_03_advertiser_66_country_code_idx;


--
-- Name: impressions_2018_03_advertiser_66_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_03_advertiser_66_date_trunc_idx;


--
-- Name: impressions_2018_03_advertiser_66_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_03_advertiser_66_displayed_at_date_idx;


--
-- Name: impressions_2018_03_advertiser_66_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_03_advertiser_66_payable_idx;


--
-- Name: impressions_2018_03_advertiser_66_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_03_advertiser_66_property_id_idx;


--
-- Name: impressions_2018_03_advertiser_66_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_03_advertiser_66_property_name_idx;


--
-- Name: impressions_2018_03_advertiser_74_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_03_advertiser_74_advertiser_id_idx;


--
-- Name: impressions_2018_03_advertiser_74_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_03_advertiser_74_campaign_id_idx;


--
-- Name: impressions_2018_03_advertiser_74_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_03_advertiser_74_campaign_name_idx;


--
-- Name: impressions_2018_03_advertiser_74_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_03_advertiser_74_country_code_idx;


--
-- Name: impressions_2018_03_advertiser_74_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_03_advertiser_74_date_trunc_idx;


--
-- Name: impressions_2018_03_advertiser_74_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_03_advertiser_74_displayed_at_date_idx;


--
-- Name: impressions_2018_03_advertiser_74_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_03_advertiser_74_payable_idx;


--
-- Name: impressions_2018_03_advertiser_74_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_03_advertiser_74_property_id_idx;


--
-- Name: impressions_2018_03_advertiser_74_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_03_advertiser_74_property_name_idx;


--
-- Name: impressions_2018_03_advertiser_75_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_03_advertiser_75_advertiser_id_idx;


--
-- Name: impressions_2018_03_advertiser_75_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_03_advertiser_75_campaign_id_idx;


--
-- Name: impressions_2018_03_advertiser_75_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_03_advertiser_75_campaign_name_idx;


--
-- Name: impressions_2018_03_advertiser_75_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_03_advertiser_75_country_code_idx;


--
-- Name: impressions_2018_03_advertiser_75_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_03_advertiser_75_date_trunc_idx;


--
-- Name: impressions_2018_03_advertiser_75_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_03_advertiser_75_displayed_at_date_idx;


--
-- Name: impressions_2018_03_advertiser_75_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_03_advertiser_75_payable_idx;


--
-- Name: impressions_2018_03_advertiser_75_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_03_advertiser_75_property_id_idx;


--
-- Name: impressions_2018_03_advertiser_75_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_03_advertiser_75_property_name_idx;


--
-- Name: impressions_2018_03_advertiser_82_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_03_advertiser_82_advertiser_id_idx;


--
-- Name: impressions_2018_03_advertiser_82_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_03_advertiser_82_campaign_id_idx;


--
-- Name: impressions_2018_03_advertiser_82_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_03_advertiser_82_campaign_name_idx;


--
-- Name: impressions_2018_03_advertiser_82_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_03_advertiser_82_country_code_idx;


--
-- Name: impressions_2018_03_advertiser_82_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_03_advertiser_82_date_trunc_idx;


--
-- Name: impressions_2018_03_advertiser_82_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_03_advertiser_82_displayed_at_date_idx;


--
-- Name: impressions_2018_03_advertiser_82_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_03_advertiser_82_payable_idx;


--
-- Name: impressions_2018_03_advertiser_82_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_03_advertiser_82_property_id_idx;


--
-- Name: impressions_2018_03_advertiser_82_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_03_advertiser_82_property_name_idx;


--
-- Name: impressions_2018_03_advertiser_87_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_03_advertiser_87_advertiser_id_idx;


--
-- Name: impressions_2018_03_advertiser_87_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_03_advertiser_87_campaign_id_idx;


--
-- Name: impressions_2018_03_advertiser_87_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_03_advertiser_87_campaign_name_idx;


--
-- Name: impressions_2018_03_advertiser_87_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_03_advertiser_87_country_code_idx;


--
-- Name: impressions_2018_03_advertiser_87_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_03_advertiser_87_date_trunc_idx;


--
-- Name: impressions_2018_03_advertiser_87_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_03_advertiser_87_displayed_at_date_idx;


--
-- Name: impressions_2018_03_advertiser_87_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_03_advertiser_87_payable_idx;


--
-- Name: impressions_2018_03_advertiser_87_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_03_advertiser_87_property_id_idx;


--
-- Name: impressions_2018_03_advertiser_87_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_03_advertiser_87_property_name_idx;


--
-- Name: impressions_2018_03_advertiser_92_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_03_advertiser_92_advertiser_id_idx;


--
-- Name: impressions_2018_03_advertiser_92_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_03_advertiser_92_campaign_id_idx;


--
-- Name: impressions_2018_03_advertiser_92_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_03_advertiser_92_campaign_name_idx;


--
-- Name: impressions_2018_03_advertiser_92_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_03_advertiser_92_country_code_idx;


--
-- Name: impressions_2018_03_advertiser_92_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_03_advertiser_92_date_trunc_idx;


--
-- Name: impressions_2018_03_advertiser_92_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_03_advertiser_92_displayed_at_date_idx;


--
-- Name: impressions_2018_03_advertiser_92_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_03_advertiser_92_payable_idx;


--
-- Name: impressions_2018_03_advertiser_92_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_03_advertiser_92_property_id_idx;


--
-- Name: impressions_2018_03_advertiser_92_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_03_advertiser_92_property_name_idx;


--
-- Name: impressions_2018_03_advertiser_95_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_03_advertiser_95_advertiser_id_idx;


--
-- Name: impressions_2018_03_advertiser_95_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_03_advertiser_95_campaign_id_idx;


--
-- Name: impressions_2018_03_advertiser_95_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_03_advertiser_95_campaign_name_idx;


--
-- Name: impressions_2018_03_advertiser_95_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_03_advertiser_95_country_code_idx;


--
-- Name: impressions_2018_03_advertiser_95_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_03_advertiser_95_date_trunc_idx;


--
-- Name: impressions_2018_03_advertiser_95_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_03_advertiser_95_displayed_at_date_idx;


--
-- Name: impressions_2018_03_advertiser_95_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_03_advertiser_95_payable_idx;


--
-- Name: impressions_2018_03_advertiser_95_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_03_advertiser_95_property_id_idx;


--
-- Name: impressions_2018_03_advertiser_95_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_03_advertiser_95_property_name_idx;


--
-- Name: impressions_2018_03_advertiser_97_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_03_advertiser_97_advertiser_id_idx;


--
-- Name: impressions_2018_03_advertiser_97_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_03_advertiser_97_campaign_id_idx;


--
-- Name: impressions_2018_03_advertiser_97_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_03_advertiser_97_campaign_name_idx;


--
-- Name: impressions_2018_03_advertiser_97_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_03_advertiser_97_country_code_idx;


--
-- Name: impressions_2018_03_advertiser_97_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_03_advertiser_97_date_trunc_idx;


--
-- Name: impressions_2018_03_advertiser_97_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_03_advertiser_97_displayed_at_date_idx;


--
-- Name: impressions_2018_03_advertiser_97_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_03_advertiser_97_payable_idx;


--
-- Name: impressions_2018_03_advertiser_97_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_03_advertiser_97_property_id_idx;


--
-- Name: impressions_2018_03_advertiser_97_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_03_advertiser_97_property_name_idx;


--
-- Name: impressions_2018_03_advertiser__campaign_name_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_03_advertiser__campaign_name_property_name_idx;


--
-- Name: impressions_2018_03_advertiser_campaign_name_property_name_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_03_advertiser_campaign_name_property_name_idx1;


--
-- Name: impressions_2018_03_advertiser_campaign_name_property_name_idx2; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_03_advertiser_campaign_name_property_name_idx2;


--
-- Name: impressions_2018_03_advertiser_campaign_name_property_name_idx3; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_03_advertiser_campaign_name_property_name_idx3;


--
-- Name: impressions_2018_03_advertiser_campaign_name_property_name_idx4; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_03_advertiser_campaign_name_property_name_idx4;


--
-- Name: impressions_2018_03_advertiser_campaign_name_property_name_idx5; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_03_advertiser_campaign_name_property_name_idx5;


--
-- Name: impressions_2018_03_advertiser_campaign_name_property_name_idx6; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_03_advertiser_campaign_name_property_name_idx6;


--
-- Name: impressions_2018_03_advertiser_campaign_name_property_name_idx7; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_03_advertiser_campaign_name_property_name_idx7;


--
-- Name: impressions_2018_03_advertiser_campaign_name_property_name_idx8; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_03_advertiser_campaign_name_property_name_idx8;


--
-- Name: impressions_2018_03_advertiser_campaign_name_property_name_idx9; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_03_advertiser_campaign_name_property_name_idx9;


--
-- Name: impressions_2018_04_advertise_campaign_name_property_name_idx10; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_04_advertise_campaign_name_property_name_idx10;


--
-- Name: impressions_2018_04_advertiser_15_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_04_advertiser_15_advertiser_id_idx;


--
-- Name: impressions_2018_04_advertiser_15_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_04_advertiser_15_campaign_id_idx;


--
-- Name: impressions_2018_04_advertiser_15_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_04_advertiser_15_campaign_name_idx;


--
-- Name: impressions_2018_04_advertiser_15_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_04_advertiser_15_country_code_idx;


--
-- Name: impressions_2018_04_advertiser_15_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_04_advertiser_15_date_trunc_idx;


--
-- Name: impressions_2018_04_advertiser_15_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_04_advertiser_15_displayed_at_date_idx;


--
-- Name: impressions_2018_04_advertiser_15_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_04_advertiser_15_payable_idx;


--
-- Name: impressions_2018_04_advertiser_15_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_04_advertiser_15_property_id_idx;


--
-- Name: impressions_2018_04_advertiser_15_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_04_advertiser_15_property_name_idx;


--
-- Name: impressions_2018_04_advertiser_18_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_04_advertiser_18_advertiser_id_idx;


--
-- Name: impressions_2018_04_advertiser_18_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_04_advertiser_18_campaign_id_idx;


--
-- Name: impressions_2018_04_advertiser_18_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_04_advertiser_18_campaign_name_idx;


--
-- Name: impressions_2018_04_advertiser_18_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_04_advertiser_18_country_code_idx;


--
-- Name: impressions_2018_04_advertiser_18_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_04_advertiser_18_date_trunc_idx;


--
-- Name: impressions_2018_04_advertiser_18_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_04_advertiser_18_displayed_at_date_idx;


--
-- Name: impressions_2018_04_advertiser_18_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_04_advertiser_18_payable_idx;


--
-- Name: impressions_2018_04_advertiser_18_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_04_advertiser_18_property_id_idx;


--
-- Name: impressions_2018_04_advertiser_18_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_04_advertiser_18_property_name_idx;


--
-- Name: impressions_2018_04_advertiser_27_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_04_advertiser_27_advertiser_id_idx;


--
-- Name: impressions_2018_04_advertiser_27_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_04_advertiser_27_campaign_id_idx;


--
-- Name: impressions_2018_04_advertiser_27_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_04_advertiser_27_campaign_name_idx;


--
-- Name: impressions_2018_04_advertiser_27_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_04_advertiser_27_country_code_idx;


--
-- Name: impressions_2018_04_advertiser_27_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_04_advertiser_27_date_trunc_idx;


--
-- Name: impressions_2018_04_advertiser_27_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_04_advertiser_27_displayed_at_date_idx;


--
-- Name: impressions_2018_04_advertiser_27_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_04_advertiser_27_payable_idx;


--
-- Name: impressions_2018_04_advertiser_27_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_04_advertiser_27_property_id_idx;


--
-- Name: impressions_2018_04_advertiser_27_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_04_advertiser_27_property_name_idx;


--
-- Name: impressions_2018_04_advertiser_33_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_04_advertiser_33_advertiser_id_idx;


--
-- Name: impressions_2018_04_advertiser_33_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_04_advertiser_33_campaign_id_idx;


--
-- Name: impressions_2018_04_advertiser_33_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_04_advertiser_33_campaign_name_idx;


--
-- Name: impressions_2018_04_advertiser_33_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_04_advertiser_33_country_code_idx;


--
-- Name: impressions_2018_04_advertiser_33_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_04_advertiser_33_date_trunc_idx;


--
-- Name: impressions_2018_04_advertiser_33_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_04_advertiser_33_displayed_at_date_idx;


--
-- Name: impressions_2018_04_advertiser_33_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_04_advertiser_33_payable_idx;


--
-- Name: impressions_2018_04_advertiser_33_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_04_advertiser_33_property_id_idx;


--
-- Name: impressions_2018_04_advertiser_33_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_04_advertiser_33_property_name_idx;


--
-- Name: impressions_2018_04_advertiser_46_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_04_advertiser_46_advertiser_id_idx;


--
-- Name: impressions_2018_04_advertiser_46_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_04_advertiser_46_campaign_id_idx;


--
-- Name: impressions_2018_04_advertiser_46_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_04_advertiser_46_campaign_name_idx;


--
-- Name: impressions_2018_04_advertiser_46_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_04_advertiser_46_country_code_idx;


--
-- Name: impressions_2018_04_advertiser_46_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_04_advertiser_46_date_trunc_idx;


--
-- Name: impressions_2018_04_advertiser_46_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_04_advertiser_46_displayed_at_date_idx;


--
-- Name: impressions_2018_04_advertiser_46_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_04_advertiser_46_payable_idx;


--
-- Name: impressions_2018_04_advertiser_46_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_04_advertiser_46_property_id_idx;


--
-- Name: impressions_2018_04_advertiser_46_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_04_advertiser_46_property_name_idx;


--
-- Name: impressions_2018_04_advertiser_48_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_04_advertiser_48_advertiser_id_idx;


--
-- Name: impressions_2018_04_advertiser_48_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_04_advertiser_48_campaign_id_idx;


--
-- Name: impressions_2018_04_advertiser_48_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_04_advertiser_48_campaign_name_idx;


--
-- Name: impressions_2018_04_advertiser_48_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_04_advertiser_48_country_code_idx;


--
-- Name: impressions_2018_04_advertiser_48_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_04_advertiser_48_date_trunc_idx;


--
-- Name: impressions_2018_04_advertiser_48_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_04_advertiser_48_displayed_at_date_idx;


--
-- Name: impressions_2018_04_advertiser_48_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_04_advertiser_48_payable_idx;


--
-- Name: impressions_2018_04_advertiser_48_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_04_advertiser_48_property_id_idx;


--
-- Name: impressions_2018_04_advertiser_48_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_04_advertiser_48_property_name_idx;


--
-- Name: impressions_2018_04_advertiser_49_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_04_advertiser_49_advertiser_id_idx;


--
-- Name: impressions_2018_04_advertiser_49_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_04_advertiser_49_campaign_id_idx;


--
-- Name: impressions_2018_04_advertiser_49_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_04_advertiser_49_campaign_name_idx;


--
-- Name: impressions_2018_04_advertiser_49_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_04_advertiser_49_country_code_idx;


--
-- Name: impressions_2018_04_advertiser_49_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_04_advertiser_49_date_trunc_idx;


--
-- Name: impressions_2018_04_advertiser_49_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_04_advertiser_49_displayed_at_date_idx;


--
-- Name: impressions_2018_04_advertiser_49_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_04_advertiser_49_payable_idx;


--
-- Name: impressions_2018_04_advertiser_49_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_04_advertiser_49_property_id_idx;


--
-- Name: impressions_2018_04_advertiser_49_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_04_advertiser_49_property_name_idx;


--
-- Name: impressions_2018_04_advertiser_74_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_04_advertiser_74_advertiser_id_idx;


--
-- Name: impressions_2018_04_advertiser_74_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_04_advertiser_74_campaign_id_idx;


--
-- Name: impressions_2018_04_advertiser_74_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_04_advertiser_74_campaign_name_idx;


--
-- Name: impressions_2018_04_advertiser_74_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_04_advertiser_74_country_code_idx;


--
-- Name: impressions_2018_04_advertiser_74_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_04_advertiser_74_date_trunc_idx;


--
-- Name: impressions_2018_04_advertiser_74_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_04_advertiser_74_displayed_at_date_idx;


--
-- Name: impressions_2018_04_advertiser_74_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_04_advertiser_74_payable_idx;


--
-- Name: impressions_2018_04_advertiser_74_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_04_advertiser_74_property_id_idx;


--
-- Name: impressions_2018_04_advertiser_74_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_04_advertiser_74_property_name_idx;


--
-- Name: impressions_2018_04_advertiser_75_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_04_advertiser_75_advertiser_id_idx;


--
-- Name: impressions_2018_04_advertiser_75_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_04_advertiser_75_campaign_id_idx;


--
-- Name: impressions_2018_04_advertiser_75_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_04_advertiser_75_campaign_name_idx;


--
-- Name: impressions_2018_04_advertiser_75_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_04_advertiser_75_country_code_idx;


--
-- Name: impressions_2018_04_advertiser_75_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_04_advertiser_75_date_trunc_idx;


--
-- Name: impressions_2018_04_advertiser_75_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_04_advertiser_75_displayed_at_date_idx;


--
-- Name: impressions_2018_04_advertiser_75_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_04_advertiser_75_payable_idx;


--
-- Name: impressions_2018_04_advertiser_75_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_04_advertiser_75_property_id_idx;


--
-- Name: impressions_2018_04_advertiser_75_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_04_advertiser_75_property_name_idx;


--
-- Name: impressions_2018_04_advertiser_96_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_04_advertiser_96_advertiser_id_idx;


--
-- Name: impressions_2018_04_advertiser_96_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_04_advertiser_96_campaign_id_idx;


--
-- Name: impressions_2018_04_advertiser_96_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_04_advertiser_96_campaign_name_idx;


--
-- Name: impressions_2018_04_advertiser_96_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_04_advertiser_96_country_code_idx;


--
-- Name: impressions_2018_04_advertiser_96_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_04_advertiser_96_date_trunc_idx;


--
-- Name: impressions_2018_04_advertiser_96_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_04_advertiser_96_displayed_at_date_idx;


--
-- Name: impressions_2018_04_advertiser_96_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_04_advertiser_96_payable_idx;


--
-- Name: impressions_2018_04_advertiser_96_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_04_advertiser_96_property_id_idx;


--
-- Name: impressions_2018_04_advertiser_96_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_04_advertiser_96_property_name_idx;


--
-- Name: impressions_2018_04_advertiser_97_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_04_advertiser_97_advertiser_id_idx;


--
-- Name: impressions_2018_04_advertiser_97_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_04_advertiser_97_campaign_id_idx;


--
-- Name: impressions_2018_04_advertiser_97_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_04_advertiser_97_campaign_name_idx;


--
-- Name: impressions_2018_04_advertiser_97_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_04_advertiser_97_country_code_idx;


--
-- Name: impressions_2018_04_advertiser_97_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_04_advertiser_97_date_trunc_idx;


--
-- Name: impressions_2018_04_advertiser_97_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_04_advertiser_97_displayed_at_date_idx;


--
-- Name: impressions_2018_04_advertiser_97_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_04_advertiser_97_payable_idx;


--
-- Name: impressions_2018_04_advertiser_97_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_04_advertiser_97_property_id_idx;


--
-- Name: impressions_2018_04_advertiser_97_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_04_advertiser_97_property_name_idx;


--
-- Name: impressions_2018_04_advertiser__campaign_name_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_04_advertiser__campaign_name_property_name_idx;


--
-- Name: impressions_2018_04_advertiser_campaign_name_property_name_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_04_advertiser_campaign_name_property_name_idx1;


--
-- Name: impressions_2018_04_advertiser_campaign_name_property_name_idx2; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_04_advertiser_campaign_name_property_name_idx2;


--
-- Name: impressions_2018_04_advertiser_campaign_name_property_name_idx3; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_04_advertiser_campaign_name_property_name_idx3;


--
-- Name: impressions_2018_04_advertiser_campaign_name_property_name_idx4; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_04_advertiser_campaign_name_property_name_idx4;


--
-- Name: impressions_2018_04_advertiser_campaign_name_property_name_idx5; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_04_advertiser_campaign_name_property_name_idx5;


--
-- Name: impressions_2018_04_advertiser_campaign_name_property_name_idx6; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_04_advertiser_campaign_name_property_name_idx6;


--
-- Name: impressions_2018_04_advertiser_campaign_name_property_name_idx7; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_04_advertiser_campaign_name_property_name_idx7;


--
-- Name: impressions_2018_04_advertiser_campaign_name_property_name_idx8; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_04_advertiser_campaign_name_property_name_idx8;


--
-- Name: impressions_2018_04_advertiser_campaign_name_property_name_idx9; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_04_advertiser_campaign_name_property_name_idx9;


--
-- Name: impressions_2018_06_advertise_campaign_name_property_name_idx10; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_06_advertise_campaign_name_property_name_idx10;


--
-- Name: impressions_2018_06_advertiser_18_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_06_advertiser_18_advertiser_id_idx;


--
-- Name: impressions_2018_06_advertiser_18_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_06_advertiser_18_campaign_id_idx;


--
-- Name: impressions_2018_06_advertiser_18_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_06_advertiser_18_campaign_name_idx;


--
-- Name: impressions_2018_06_advertiser_18_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_06_advertiser_18_country_code_idx;


--
-- Name: impressions_2018_06_advertiser_18_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_06_advertiser_18_date_trunc_idx;


--
-- Name: impressions_2018_06_advertiser_18_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_06_advertiser_18_displayed_at_date_idx;


--
-- Name: impressions_2018_06_advertiser_18_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_06_advertiser_18_payable_idx;


--
-- Name: impressions_2018_06_advertiser_18_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_06_advertiser_18_property_id_idx;


--
-- Name: impressions_2018_06_advertiser_18_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_06_advertiser_18_property_name_idx;


--
-- Name: impressions_2018_06_advertiser_19_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_06_advertiser_19_advertiser_id_idx;


--
-- Name: impressions_2018_06_advertiser_19_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_06_advertiser_19_campaign_id_idx;


--
-- Name: impressions_2018_06_advertiser_19_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_06_advertiser_19_campaign_name_idx;


--
-- Name: impressions_2018_06_advertiser_19_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_06_advertiser_19_country_code_idx;


--
-- Name: impressions_2018_06_advertiser_19_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_06_advertiser_19_date_trunc_idx;


--
-- Name: impressions_2018_06_advertiser_19_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_06_advertiser_19_displayed_at_date_idx;


--
-- Name: impressions_2018_06_advertiser_19_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_06_advertiser_19_payable_idx;


--
-- Name: impressions_2018_06_advertiser_19_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_06_advertiser_19_property_id_idx;


--
-- Name: impressions_2018_06_advertiser_19_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_06_advertiser_19_property_name_idx;


--
-- Name: impressions_2018_06_advertiser_52_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_06_advertiser_52_advertiser_id_idx;


--
-- Name: impressions_2018_06_advertiser_52_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_06_advertiser_52_campaign_id_idx;


--
-- Name: impressions_2018_06_advertiser_52_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_06_advertiser_52_campaign_name_idx;


--
-- Name: impressions_2018_06_advertiser_52_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_06_advertiser_52_country_code_idx;


--
-- Name: impressions_2018_06_advertiser_52_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_06_advertiser_52_date_trunc_idx;


--
-- Name: impressions_2018_06_advertiser_52_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_06_advertiser_52_displayed_at_date_idx;


--
-- Name: impressions_2018_06_advertiser_52_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_06_advertiser_52_payable_idx;


--
-- Name: impressions_2018_06_advertiser_52_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_06_advertiser_52_property_id_idx;


--
-- Name: impressions_2018_06_advertiser_52_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_06_advertiser_52_property_name_idx;


--
-- Name: impressions_2018_06_advertiser_55_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_06_advertiser_55_advertiser_id_idx;


--
-- Name: impressions_2018_06_advertiser_55_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_06_advertiser_55_campaign_id_idx;


--
-- Name: impressions_2018_06_advertiser_55_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_06_advertiser_55_campaign_name_idx;


--
-- Name: impressions_2018_06_advertiser_55_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_06_advertiser_55_country_code_idx;


--
-- Name: impressions_2018_06_advertiser_55_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_06_advertiser_55_date_trunc_idx;


--
-- Name: impressions_2018_06_advertiser_55_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_06_advertiser_55_displayed_at_date_idx;


--
-- Name: impressions_2018_06_advertiser_55_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_06_advertiser_55_payable_idx;


--
-- Name: impressions_2018_06_advertiser_55_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_06_advertiser_55_property_id_idx;


--
-- Name: impressions_2018_06_advertiser_55_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_06_advertiser_55_property_name_idx;


--
-- Name: impressions_2018_06_advertiser_62_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_06_advertiser_62_advertiser_id_idx;


--
-- Name: impressions_2018_06_advertiser_62_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_06_advertiser_62_campaign_id_idx;


--
-- Name: impressions_2018_06_advertiser_62_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_06_advertiser_62_campaign_name_idx;


--
-- Name: impressions_2018_06_advertiser_62_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_06_advertiser_62_country_code_idx;


--
-- Name: impressions_2018_06_advertiser_62_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_06_advertiser_62_date_trunc_idx;


--
-- Name: impressions_2018_06_advertiser_62_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_06_advertiser_62_displayed_at_date_idx;


--
-- Name: impressions_2018_06_advertiser_62_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_06_advertiser_62_payable_idx;


--
-- Name: impressions_2018_06_advertiser_62_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_06_advertiser_62_property_id_idx;


--
-- Name: impressions_2018_06_advertiser_62_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_06_advertiser_62_property_name_idx;


--
-- Name: impressions_2018_06_advertiser_64_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_06_advertiser_64_advertiser_id_idx;


--
-- Name: impressions_2018_06_advertiser_64_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_06_advertiser_64_campaign_id_idx;


--
-- Name: impressions_2018_06_advertiser_64_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_06_advertiser_64_campaign_name_idx;


--
-- Name: impressions_2018_06_advertiser_64_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_06_advertiser_64_country_code_idx;


--
-- Name: impressions_2018_06_advertiser_64_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_06_advertiser_64_date_trunc_idx;


--
-- Name: impressions_2018_06_advertiser_64_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_06_advertiser_64_displayed_at_date_idx;


--
-- Name: impressions_2018_06_advertiser_64_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_06_advertiser_64_payable_idx;


--
-- Name: impressions_2018_06_advertiser_64_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_06_advertiser_64_property_id_idx;


--
-- Name: impressions_2018_06_advertiser_64_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_06_advertiser_64_property_name_idx;


--
-- Name: impressions_2018_06_advertiser_72_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_06_advertiser_72_advertiser_id_idx;


--
-- Name: impressions_2018_06_advertiser_72_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_06_advertiser_72_campaign_id_idx;


--
-- Name: impressions_2018_06_advertiser_72_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_06_advertiser_72_campaign_name_idx;


--
-- Name: impressions_2018_06_advertiser_72_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_06_advertiser_72_country_code_idx;


--
-- Name: impressions_2018_06_advertiser_72_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_06_advertiser_72_date_trunc_idx;


--
-- Name: impressions_2018_06_advertiser_72_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_06_advertiser_72_displayed_at_date_idx;


--
-- Name: impressions_2018_06_advertiser_72_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_06_advertiser_72_payable_idx;


--
-- Name: impressions_2018_06_advertiser_72_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_06_advertiser_72_property_id_idx;


--
-- Name: impressions_2018_06_advertiser_72_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_06_advertiser_72_property_name_idx;


--
-- Name: impressions_2018_06_advertiser_7_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_06_advertiser_7_advertiser_id_idx;


--
-- Name: impressions_2018_06_advertiser_7_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_06_advertiser_7_campaign_id_idx;


--
-- Name: impressions_2018_06_advertiser_7_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_06_advertiser_7_campaign_name_idx;


--
-- Name: impressions_2018_06_advertiser_7_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_06_advertiser_7_country_code_idx;


--
-- Name: impressions_2018_06_advertiser_7_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_06_advertiser_7_date_trunc_idx;


--
-- Name: impressions_2018_06_advertiser_7_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_06_advertiser_7_displayed_at_date_idx;


--
-- Name: impressions_2018_06_advertiser_7_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_06_advertiser_7_payable_idx;


--
-- Name: impressions_2018_06_advertiser_7_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_06_advertiser_7_property_id_idx;


--
-- Name: impressions_2018_06_advertiser_7_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_06_advertiser_7_property_name_idx;


--
-- Name: impressions_2018_06_advertiser_85_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_06_advertiser_85_advertiser_id_idx;


--
-- Name: impressions_2018_06_advertiser_85_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_06_advertiser_85_campaign_id_idx;


--
-- Name: impressions_2018_06_advertiser_85_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_06_advertiser_85_campaign_name_idx;


--
-- Name: impressions_2018_06_advertiser_85_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_06_advertiser_85_country_code_idx;


--
-- Name: impressions_2018_06_advertiser_85_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_06_advertiser_85_date_trunc_idx;


--
-- Name: impressions_2018_06_advertiser_85_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_06_advertiser_85_displayed_at_date_idx;


--
-- Name: impressions_2018_06_advertiser_85_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_06_advertiser_85_payable_idx;


--
-- Name: impressions_2018_06_advertiser_85_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_06_advertiser_85_property_id_idx;


--
-- Name: impressions_2018_06_advertiser_85_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_06_advertiser_85_property_name_idx;


--
-- Name: impressions_2018_06_advertiser_89_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_06_advertiser_89_advertiser_id_idx;


--
-- Name: impressions_2018_06_advertiser_89_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_06_advertiser_89_campaign_id_idx;


--
-- Name: impressions_2018_06_advertiser_89_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_06_advertiser_89_campaign_name_idx;


--
-- Name: impressions_2018_06_advertiser_89_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_06_advertiser_89_country_code_idx;


--
-- Name: impressions_2018_06_advertiser_89_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_06_advertiser_89_date_trunc_idx;


--
-- Name: impressions_2018_06_advertiser_89_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_06_advertiser_89_displayed_at_date_idx;


--
-- Name: impressions_2018_06_advertiser_89_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_06_advertiser_89_payable_idx;


--
-- Name: impressions_2018_06_advertiser_89_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_06_advertiser_89_property_id_idx;


--
-- Name: impressions_2018_06_advertiser_89_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_06_advertiser_89_property_name_idx;


--
-- Name: impressions_2018_06_advertiser_98_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_06_advertiser_98_advertiser_id_idx;


--
-- Name: impressions_2018_06_advertiser_98_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_06_advertiser_98_campaign_id_idx;


--
-- Name: impressions_2018_06_advertiser_98_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_06_advertiser_98_campaign_name_idx;


--
-- Name: impressions_2018_06_advertiser_98_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_06_advertiser_98_country_code_idx;


--
-- Name: impressions_2018_06_advertiser_98_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_06_advertiser_98_date_trunc_idx;


--
-- Name: impressions_2018_06_advertiser_98_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_06_advertiser_98_displayed_at_date_idx;


--
-- Name: impressions_2018_06_advertiser_98_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_06_advertiser_98_payable_idx;


--
-- Name: impressions_2018_06_advertiser_98_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_06_advertiser_98_property_id_idx;


--
-- Name: impressions_2018_06_advertiser_98_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_06_advertiser_98_property_name_idx;


--
-- Name: impressions_2018_06_advertiser__campaign_name_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_06_advertiser__campaign_name_property_name_idx;


--
-- Name: impressions_2018_06_advertiser_campaign_name_property_name_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_06_advertiser_campaign_name_property_name_idx1;


--
-- Name: impressions_2018_06_advertiser_campaign_name_property_name_idx2; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_06_advertiser_campaign_name_property_name_idx2;


--
-- Name: impressions_2018_06_advertiser_campaign_name_property_name_idx3; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_06_advertiser_campaign_name_property_name_idx3;


--
-- Name: impressions_2018_06_advertiser_campaign_name_property_name_idx4; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_06_advertiser_campaign_name_property_name_idx4;


--
-- Name: impressions_2018_06_advertiser_campaign_name_property_name_idx5; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_06_advertiser_campaign_name_property_name_idx5;


--
-- Name: impressions_2018_06_advertiser_campaign_name_property_name_idx6; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_06_advertiser_campaign_name_property_name_idx6;


--
-- Name: impressions_2018_06_advertiser_campaign_name_property_name_idx7; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_06_advertiser_campaign_name_property_name_idx7;


--
-- Name: impressions_2018_06_advertiser_campaign_name_property_name_idx8; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_06_advertiser_campaign_name_property_name_idx8;


--
-- Name: impressions_2018_06_advertiser_campaign_name_property_name_idx9; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_06_advertiser_campaign_name_property_name_idx9;


--
-- Name: impressions_2018_07_advertise_campaign_name_property_name_idx10; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_07_advertise_campaign_name_property_name_idx10;


--
-- Name: impressions_2018_07_advertiser_19_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_07_advertiser_19_advertiser_id_idx;


--
-- Name: impressions_2018_07_advertiser_19_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_07_advertiser_19_campaign_id_idx;


--
-- Name: impressions_2018_07_advertiser_19_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_07_advertiser_19_campaign_name_idx;


--
-- Name: impressions_2018_07_advertiser_19_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_07_advertiser_19_country_code_idx;


--
-- Name: impressions_2018_07_advertiser_19_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_07_advertiser_19_date_trunc_idx;


--
-- Name: impressions_2018_07_advertiser_19_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_07_advertiser_19_displayed_at_date_idx;


--
-- Name: impressions_2018_07_advertiser_19_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_07_advertiser_19_payable_idx;


--
-- Name: impressions_2018_07_advertiser_19_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_07_advertiser_19_property_id_idx;


--
-- Name: impressions_2018_07_advertiser_19_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_07_advertiser_19_property_name_idx;


--
-- Name: impressions_2018_07_advertiser_23_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_07_advertiser_23_advertiser_id_idx;


--
-- Name: impressions_2018_07_advertiser_23_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_07_advertiser_23_campaign_id_idx;


--
-- Name: impressions_2018_07_advertiser_23_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_07_advertiser_23_campaign_name_idx;


--
-- Name: impressions_2018_07_advertiser_23_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_07_advertiser_23_country_code_idx;


--
-- Name: impressions_2018_07_advertiser_23_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_07_advertiser_23_date_trunc_idx;


--
-- Name: impressions_2018_07_advertiser_23_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_07_advertiser_23_displayed_at_date_idx;


--
-- Name: impressions_2018_07_advertiser_23_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_07_advertiser_23_payable_idx;


--
-- Name: impressions_2018_07_advertiser_23_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_07_advertiser_23_property_id_idx;


--
-- Name: impressions_2018_07_advertiser_23_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_07_advertiser_23_property_name_idx;


--
-- Name: impressions_2018_07_advertiser_39_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_07_advertiser_39_advertiser_id_idx;


--
-- Name: impressions_2018_07_advertiser_39_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_07_advertiser_39_campaign_id_idx;


--
-- Name: impressions_2018_07_advertiser_39_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_07_advertiser_39_campaign_name_idx;


--
-- Name: impressions_2018_07_advertiser_39_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_07_advertiser_39_country_code_idx;


--
-- Name: impressions_2018_07_advertiser_39_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_07_advertiser_39_date_trunc_idx;


--
-- Name: impressions_2018_07_advertiser_39_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_07_advertiser_39_displayed_at_date_idx;


--
-- Name: impressions_2018_07_advertiser_39_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_07_advertiser_39_payable_idx;


--
-- Name: impressions_2018_07_advertiser_39_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_07_advertiser_39_property_id_idx;


--
-- Name: impressions_2018_07_advertiser_39_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_07_advertiser_39_property_name_idx;


--
-- Name: impressions_2018_07_advertiser_62_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_07_advertiser_62_advertiser_id_idx;


--
-- Name: impressions_2018_07_advertiser_62_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_07_advertiser_62_campaign_id_idx;


--
-- Name: impressions_2018_07_advertiser_62_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_07_advertiser_62_campaign_name_idx;


--
-- Name: impressions_2018_07_advertiser_62_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_07_advertiser_62_country_code_idx;


--
-- Name: impressions_2018_07_advertiser_62_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_07_advertiser_62_date_trunc_idx;


--
-- Name: impressions_2018_07_advertiser_62_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_07_advertiser_62_displayed_at_date_idx;


--
-- Name: impressions_2018_07_advertiser_62_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_07_advertiser_62_payable_idx;


--
-- Name: impressions_2018_07_advertiser_62_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_07_advertiser_62_property_id_idx;


--
-- Name: impressions_2018_07_advertiser_62_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_07_advertiser_62_property_name_idx;


--
-- Name: impressions_2018_07_advertiser_64_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_07_advertiser_64_advertiser_id_idx;


--
-- Name: impressions_2018_07_advertiser_64_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_07_advertiser_64_campaign_id_idx;


--
-- Name: impressions_2018_07_advertiser_64_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_07_advertiser_64_campaign_name_idx;


--
-- Name: impressions_2018_07_advertiser_64_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_07_advertiser_64_country_code_idx;


--
-- Name: impressions_2018_07_advertiser_64_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_07_advertiser_64_date_trunc_idx;


--
-- Name: impressions_2018_07_advertiser_64_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_07_advertiser_64_displayed_at_date_idx;


--
-- Name: impressions_2018_07_advertiser_64_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_07_advertiser_64_payable_idx;


--
-- Name: impressions_2018_07_advertiser_64_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_07_advertiser_64_property_id_idx;


--
-- Name: impressions_2018_07_advertiser_64_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_07_advertiser_64_property_name_idx;


--
-- Name: impressions_2018_07_advertiser_84_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_07_advertiser_84_advertiser_id_idx;


--
-- Name: impressions_2018_07_advertiser_84_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_07_advertiser_84_campaign_id_idx;


--
-- Name: impressions_2018_07_advertiser_84_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_07_advertiser_84_campaign_name_idx;


--
-- Name: impressions_2018_07_advertiser_84_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_07_advertiser_84_country_code_idx;


--
-- Name: impressions_2018_07_advertiser_84_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_07_advertiser_84_date_trunc_idx;


--
-- Name: impressions_2018_07_advertiser_84_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_07_advertiser_84_displayed_at_date_idx;


--
-- Name: impressions_2018_07_advertiser_84_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_07_advertiser_84_payable_idx;


--
-- Name: impressions_2018_07_advertiser_84_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_07_advertiser_84_property_id_idx;


--
-- Name: impressions_2018_07_advertiser_84_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_07_advertiser_84_property_name_idx;


--
-- Name: impressions_2018_07_advertiser_85_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_07_advertiser_85_advertiser_id_idx;


--
-- Name: impressions_2018_07_advertiser_85_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_07_advertiser_85_campaign_id_idx;


--
-- Name: impressions_2018_07_advertiser_85_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_07_advertiser_85_campaign_name_idx;


--
-- Name: impressions_2018_07_advertiser_85_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_07_advertiser_85_country_code_idx;


--
-- Name: impressions_2018_07_advertiser_85_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_07_advertiser_85_date_trunc_idx;


--
-- Name: impressions_2018_07_advertiser_85_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_07_advertiser_85_displayed_at_date_idx;


--
-- Name: impressions_2018_07_advertiser_85_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_07_advertiser_85_payable_idx;


--
-- Name: impressions_2018_07_advertiser_85_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_07_advertiser_85_property_id_idx;


--
-- Name: impressions_2018_07_advertiser_85_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_07_advertiser_85_property_name_idx;


--
-- Name: impressions_2018_07_advertiser_87_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_07_advertiser_87_advertiser_id_idx;


--
-- Name: impressions_2018_07_advertiser_87_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_07_advertiser_87_campaign_id_idx;


--
-- Name: impressions_2018_07_advertiser_87_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_07_advertiser_87_campaign_name_idx;


--
-- Name: impressions_2018_07_advertiser_87_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_07_advertiser_87_country_code_idx;


--
-- Name: impressions_2018_07_advertiser_87_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_07_advertiser_87_date_trunc_idx;


--
-- Name: impressions_2018_07_advertiser_87_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_07_advertiser_87_displayed_at_date_idx;


--
-- Name: impressions_2018_07_advertiser_87_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_07_advertiser_87_payable_idx;


--
-- Name: impressions_2018_07_advertiser_87_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_07_advertiser_87_property_id_idx;


--
-- Name: impressions_2018_07_advertiser_87_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_07_advertiser_87_property_name_idx;


--
-- Name: impressions_2018_07_advertiser_89_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_07_advertiser_89_advertiser_id_idx;


--
-- Name: impressions_2018_07_advertiser_89_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_07_advertiser_89_campaign_id_idx;


--
-- Name: impressions_2018_07_advertiser_89_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_07_advertiser_89_campaign_name_idx;


--
-- Name: impressions_2018_07_advertiser_89_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_07_advertiser_89_country_code_idx;


--
-- Name: impressions_2018_07_advertiser_89_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_07_advertiser_89_date_trunc_idx;


--
-- Name: impressions_2018_07_advertiser_89_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_07_advertiser_89_displayed_at_date_idx;


--
-- Name: impressions_2018_07_advertiser_89_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_07_advertiser_89_payable_idx;


--
-- Name: impressions_2018_07_advertiser_89_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_07_advertiser_89_property_id_idx;


--
-- Name: impressions_2018_07_advertiser_89_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_07_advertiser_89_property_name_idx;


--
-- Name: impressions_2018_07_advertiser_95_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_07_advertiser_95_advertiser_id_idx;


--
-- Name: impressions_2018_07_advertiser_95_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_07_advertiser_95_campaign_id_idx;


--
-- Name: impressions_2018_07_advertiser_95_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_07_advertiser_95_campaign_name_idx;


--
-- Name: impressions_2018_07_advertiser_95_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_07_advertiser_95_country_code_idx;


--
-- Name: impressions_2018_07_advertiser_95_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_07_advertiser_95_date_trunc_idx;


--
-- Name: impressions_2018_07_advertiser_95_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_07_advertiser_95_displayed_at_date_idx;


--
-- Name: impressions_2018_07_advertiser_95_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_07_advertiser_95_payable_idx;


--
-- Name: impressions_2018_07_advertiser_95_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_07_advertiser_95_property_id_idx;


--
-- Name: impressions_2018_07_advertiser_95_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_07_advertiser_95_property_name_idx;


--
-- Name: impressions_2018_07_advertiser_96_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_07_advertiser_96_advertiser_id_idx;


--
-- Name: impressions_2018_07_advertiser_96_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_07_advertiser_96_campaign_id_idx;


--
-- Name: impressions_2018_07_advertiser_96_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_07_advertiser_96_campaign_name_idx;


--
-- Name: impressions_2018_07_advertiser_96_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_07_advertiser_96_country_code_idx;


--
-- Name: impressions_2018_07_advertiser_96_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_07_advertiser_96_date_trunc_idx;


--
-- Name: impressions_2018_07_advertiser_96_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_07_advertiser_96_displayed_at_date_idx;


--
-- Name: impressions_2018_07_advertiser_96_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_07_advertiser_96_payable_idx;


--
-- Name: impressions_2018_07_advertiser_96_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_07_advertiser_96_property_id_idx;


--
-- Name: impressions_2018_07_advertiser_96_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_07_advertiser_96_property_name_idx;


--
-- Name: impressions_2018_07_advertiser__campaign_name_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_07_advertiser__campaign_name_property_name_idx;


--
-- Name: impressions_2018_07_advertiser_campaign_name_property_name_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_07_advertiser_campaign_name_property_name_idx1;


--
-- Name: impressions_2018_07_advertiser_campaign_name_property_name_idx2; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_07_advertiser_campaign_name_property_name_idx2;


--
-- Name: impressions_2018_07_advertiser_campaign_name_property_name_idx3; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_07_advertiser_campaign_name_property_name_idx3;


--
-- Name: impressions_2018_07_advertiser_campaign_name_property_name_idx4; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_07_advertiser_campaign_name_property_name_idx4;


--
-- Name: impressions_2018_07_advertiser_campaign_name_property_name_idx5; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_07_advertiser_campaign_name_property_name_idx5;


--
-- Name: impressions_2018_07_advertiser_campaign_name_property_name_idx6; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_07_advertiser_campaign_name_property_name_idx6;


--
-- Name: impressions_2018_07_advertiser_campaign_name_property_name_idx7; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_07_advertiser_campaign_name_property_name_idx7;


--
-- Name: impressions_2018_07_advertiser_campaign_name_property_name_idx8; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_07_advertiser_campaign_name_property_name_idx8;


--
-- Name: impressions_2018_07_advertiser_campaign_name_property_name_idx9; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_07_advertiser_campaign_name_property_name_idx9;


--
-- Name: impressions_2018_08_advertiser_39_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_08_advertiser_39_advertiser_id_idx;


--
-- Name: impressions_2018_08_advertiser_39_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_08_advertiser_39_campaign_id_idx;


--
-- Name: impressions_2018_08_advertiser_39_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_08_advertiser_39_campaign_name_idx;


--
-- Name: impressions_2018_08_advertiser_39_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_08_advertiser_39_country_code_idx;


--
-- Name: impressions_2018_08_advertiser_39_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_08_advertiser_39_date_trunc_idx;


--
-- Name: impressions_2018_08_advertiser_39_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_08_advertiser_39_displayed_at_date_idx;


--
-- Name: impressions_2018_08_advertiser_39_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_08_advertiser_39_payable_idx;


--
-- Name: impressions_2018_08_advertiser_39_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_08_advertiser_39_property_id_idx;


--
-- Name: impressions_2018_08_advertiser_39_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_08_advertiser_39_property_name_idx;


--
-- Name: impressions_2018_08_advertiser_46_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_08_advertiser_46_advertiser_id_idx;


--
-- Name: impressions_2018_08_advertiser_46_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_08_advertiser_46_campaign_id_idx;


--
-- Name: impressions_2018_08_advertiser_46_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_08_advertiser_46_campaign_name_idx;


--
-- Name: impressions_2018_08_advertiser_46_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_08_advertiser_46_country_code_idx;


--
-- Name: impressions_2018_08_advertiser_46_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_08_advertiser_46_date_trunc_idx;


--
-- Name: impressions_2018_08_advertiser_46_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_08_advertiser_46_displayed_at_date_idx;


--
-- Name: impressions_2018_08_advertiser_46_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_08_advertiser_46_payable_idx;


--
-- Name: impressions_2018_08_advertiser_46_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_08_advertiser_46_property_id_idx;


--
-- Name: impressions_2018_08_advertiser_46_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_08_advertiser_46_property_name_idx;


--
-- Name: impressions_2018_08_advertiser_55_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_08_advertiser_55_advertiser_id_idx;


--
-- Name: impressions_2018_08_advertiser_55_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_08_advertiser_55_campaign_id_idx;


--
-- Name: impressions_2018_08_advertiser_55_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_08_advertiser_55_campaign_name_idx;


--
-- Name: impressions_2018_08_advertiser_55_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_08_advertiser_55_country_code_idx;


--
-- Name: impressions_2018_08_advertiser_55_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_08_advertiser_55_date_trunc_idx;


--
-- Name: impressions_2018_08_advertiser_55_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_08_advertiser_55_displayed_at_date_idx;


--
-- Name: impressions_2018_08_advertiser_55_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_08_advertiser_55_payable_idx;


--
-- Name: impressions_2018_08_advertiser_55_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_08_advertiser_55_property_id_idx;


--
-- Name: impressions_2018_08_advertiser_55_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_08_advertiser_55_property_name_idx;


--
-- Name: impressions_2018_08_advertiser_57_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_08_advertiser_57_advertiser_id_idx;


--
-- Name: impressions_2018_08_advertiser_57_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_08_advertiser_57_campaign_id_idx;


--
-- Name: impressions_2018_08_advertiser_57_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_08_advertiser_57_campaign_name_idx;


--
-- Name: impressions_2018_08_advertiser_57_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_08_advertiser_57_country_code_idx;


--
-- Name: impressions_2018_08_advertiser_57_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_08_advertiser_57_date_trunc_idx;


--
-- Name: impressions_2018_08_advertiser_57_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_08_advertiser_57_displayed_at_date_idx;


--
-- Name: impressions_2018_08_advertiser_57_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_08_advertiser_57_payable_idx;


--
-- Name: impressions_2018_08_advertiser_57_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_08_advertiser_57_property_id_idx;


--
-- Name: impressions_2018_08_advertiser_57_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_08_advertiser_57_property_name_idx;


--
-- Name: impressions_2018_08_advertiser_58_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_08_advertiser_58_advertiser_id_idx;


--
-- Name: impressions_2018_08_advertiser_58_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_08_advertiser_58_campaign_id_idx;


--
-- Name: impressions_2018_08_advertiser_58_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_08_advertiser_58_campaign_name_idx;


--
-- Name: impressions_2018_08_advertiser_58_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_08_advertiser_58_country_code_idx;


--
-- Name: impressions_2018_08_advertiser_58_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_08_advertiser_58_date_trunc_idx;


--
-- Name: impressions_2018_08_advertiser_58_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_08_advertiser_58_displayed_at_date_idx;


--
-- Name: impressions_2018_08_advertiser_58_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_08_advertiser_58_payable_idx;


--
-- Name: impressions_2018_08_advertiser_58_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_08_advertiser_58_property_id_idx;


--
-- Name: impressions_2018_08_advertiser_58_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_08_advertiser_58_property_name_idx;


--
-- Name: impressions_2018_08_advertiser_72_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_08_advertiser_72_advertiser_id_idx;


--
-- Name: impressions_2018_08_advertiser_72_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_08_advertiser_72_campaign_id_idx;


--
-- Name: impressions_2018_08_advertiser_72_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_08_advertiser_72_campaign_name_idx;


--
-- Name: impressions_2018_08_advertiser_72_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_08_advertiser_72_country_code_idx;


--
-- Name: impressions_2018_08_advertiser_72_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_08_advertiser_72_date_trunc_idx;


--
-- Name: impressions_2018_08_advertiser_72_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_08_advertiser_72_displayed_at_date_idx;


--
-- Name: impressions_2018_08_advertiser_72_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_08_advertiser_72_payable_idx;


--
-- Name: impressions_2018_08_advertiser_72_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_08_advertiser_72_property_id_idx;


--
-- Name: impressions_2018_08_advertiser_72_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_08_advertiser_72_property_name_idx;


--
-- Name: impressions_2018_08_advertiser_84_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_08_advertiser_84_advertiser_id_idx;


--
-- Name: impressions_2018_08_advertiser_84_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_08_advertiser_84_campaign_id_idx;


--
-- Name: impressions_2018_08_advertiser_84_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_08_advertiser_84_campaign_name_idx;


--
-- Name: impressions_2018_08_advertiser_84_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_08_advertiser_84_country_code_idx;


--
-- Name: impressions_2018_08_advertiser_84_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_08_advertiser_84_date_trunc_idx;


--
-- Name: impressions_2018_08_advertiser_84_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_08_advertiser_84_displayed_at_date_idx;


--
-- Name: impressions_2018_08_advertiser_84_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_08_advertiser_84_payable_idx;


--
-- Name: impressions_2018_08_advertiser_84_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_08_advertiser_84_property_id_idx;


--
-- Name: impressions_2018_08_advertiser_84_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_08_advertiser_84_property_name_idx;


--
-- Name: impressions_2018_08_advertiser_89_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_08_advertiser_89_advertiser_id_idx;


--
-- Name: impressions_2018_08_advertiser_89_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_08_advertiser_89_campaign_id_idx;


--
-- Name: impressions_2018_08_advertiser_89_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_08_advertiser_89_campaign_name_idx;


--
-- Name: impressions_2018_08_advertiser_89_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_08_advertiser_89_country_code_idx;


--
-- Name: impressions_2018_08_advertiser_89_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_08_advertiser_89_date_trunc_idx;


--
-- Name: impressions_2018_08_advertiser_89_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_08_advertiser_89_displayed_at_date_idx;


--
-- Name: impressions_2018_08_advertiser_89_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_08_advertiser_89_payable_idx;


--
-- Name: impressions_2018_08_advertiser_89_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_08_advertiser_89_property_id_idx;


--
-- Name: impressions_2018_08_advertiser_89_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_08_advertiser_89_property_name_idx;


--
-- Name: impressions_2018_08_advertiser_95_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_08_advertiser_95_advertiser_id_idx;


--
-- Name: impressions_2018_08_advertiser_95_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_08_advertiser_95_campaign_id_idx;


--
-- Name: impressions_2018_08_advertiser_95_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_08_advertiser_95_campaign_name_idx;


--
-- Name: impressions_2018_08_advertiser_95_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_08_advertiser_95_country_code_idx;


--
-- Name: impressions_2018_08_advertiser_95_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_08_advertiser_95_date_trunc_idx;


--
-- Name: impressions_2018_08_advertiser_95_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_08_advertiser_95_displayed_at_date_idx;


--
-- Name: impressions_2018_08_advertiser_95_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_08_advertiser_95_payable_idx;


--
-- Name: impressions_2018_08_advertiser_95_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_08_advertiser_95_property_id_idx;


--
-- Name: impressions_2018_08_advertiser_95_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_08_advertiser_95_property_name_idx;


--
-- Name: impressions_2018_08_advertiser_96_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_08_advertiser_96_advertiser_id_idx;


--
-- Name: impressions_2018_08_advertiser_96_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_08_advertiser_96_campaign_id_idx;


--
-- Name: impressions_2018_08_advertiser_96_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_08_advertiser_96_campaign_name_idx;


--
-- Name: impressions_2018_08_advertiser_96_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_08_advertiser_96_country_code_idx;


--
-- Name: impressions_2018_08_advertiser_96_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_08_advertiser_96_date_trunc_idx;


--
-- Name: impressions_2018_08_advertiser_96_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_08_advertiser_96_displayed_at_date_idx;


--
-- Name: impressions_2018_08_advertiser_96_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_08_advertiser_96_payable_idx;


--
-- Name: impressions_2018_08_advertiser_96_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_08_advertiser_96_property_id_idx;


--
-- Name: impressions_2018_08_advertiser_96_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_08_advertiser_96_property_name_idx;


--
-- Name: impressions_2018_08_advertiser__campaign_name_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_08_advertiser__campaign_name_property_name_idx;


--
-- Name: impressions_2018_08_advertiser_campaign_name_property_name_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_08_advertiser_campaign_name_property_name_idx1;


--
-- Name: impressions_2018_08_advertiser_campaign_name_property_name_idx2; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_08_advertiser_campaign_name_property_name_idx2;


--
-- Name: impressions_2018_08_advertiser_campaign_name_property_name_idx3; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_08_advertiser_campaign_name_property_name_idx3;


--
-- Name: impressions_2018_08_advertiser_campaign_name_property_name_idx4; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_08_advertiser_campaign_name_property_name_idx4;


--
-- Name: impressions_2018_08_advertiser_campaign_name_property_name_idx5; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_08_advertiser_campaign_name_property_name_idx5;


--
-- Name: impressions_2018_08_advertiser_campaign_name_property_name_idx6; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_08_advertiser_campaign_name_property_name_idx6;


--
-- Name: impressions_2018_08_advertiser_campaign_name_property_name_idx7; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_08_advertiser_campaign_name_property_name_idx7;


--
-- Name: impressions_2018_08_advertiser_campaign_name_property_name_idx8; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_08_advertiser_campaign_name_property_name_idx8;


--
-- Name: impressions_2018_08_advertiser_campaign_name_property_name_idx9; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_08_advertiser_campaign_name_property_name_idx9;


--
-- Name: impressions_2018_10_advertiser_31_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_10_advertiser_31_advertiser_id_idx;


--
-- Name: impressions_2018_10_advertiser_31_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_10_advertiser_31_campaign_id_idx;


--
-- Name: impressions_2018_10_advertiser_31_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_10_advertiser_31_campaign_name_idx;


--
-- Name: impressions_2018_10_advertiser_31_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_10_advertiser_31_country_code_idx;


--
-- Name: impressions_2018_10_advertiser_31_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_10_advertiser_31_date_trunc_idx;


--
-- Name: impressions_2018_10_advertiser_31_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_10_advertiser_31_displayed_at_date_idx;


--
-- Name: impressions_2018_10_advertiser_31_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_10_advertiser_31_payable_idx;


--
-- Name: impressions_2018_10_advertiser_31_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_10_advertiser_31_property_id_idx;


--
-- Name: impressions_2018_10_advertiser_31_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_10_advertiser_31_property_name_idx;


--
-- Name: impressions_2018_10_advertiser_53_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_10_advertiser_53_advertiser_id_idx;


--
-- Name: impressions_2018_10_advertiser_53_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_10_advertiser_53_campaign_id_idx;


--
-- Name: impressions_2018_10_advertiser_53_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_10_advertiser_53_campaign_name_idx;


--
-- Name: impressions_2018_10_advertiser_53_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_10_advertiser_53_country_code_idx;


--
-- Name: impressions_2018_10_advertiser_53_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_10_advertiser_53_date_trunc_idx;


--
-- Name: impressions_2018_10_advertiser_53_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_10_advertiser_53_displayed_at_date_idx;


--
-- Name: impressions_2018_10_advertiser_53_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_10_advertiser_53_payable_idx;


--
-- Name: impressions_2018_10_advertiser_53_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_10_advertiser_53_property_id_idx;


--
-- Name: impressions_2018_10_advertiser_53_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_10_advertiser_53_property_name_idx;


--
-- Name: impressions_2018_10_advertiser_55_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_10_advertiser_55_advertiser_id_idx;


--
-- Name: impressions_2018_10_advertiser_55_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_10_advertiser_55_campaign_id_idx;


--
-- Name: impressions_2018_10_advertiser_55_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_10_advertiser_55_campaign_name_idx;


--
-- Name: impressions_2018_10_advertiser_55_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_10_advertiser_55_country_code_idx;


--
-- Name: impressions_2018_10_advertiser_55_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_10_advertiser_55_date_trunc_idx;


--
-- Name: impressions_2018_10_advertiser_55_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_10_advertiser_55_displayed_at_date_idx;


--
-- Name: impressions_2018_10_advertiser_55_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_10_advertiser_55_payable_idx;


--
-- Name: impressions_2018_10_advertiser_55_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_10_advertiser_55_property_id_idx;


--
-- Name: impressions_2018_10_advertiser_55_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_10_advertiser_55_property_name_idx;


--
-- Name: impressions_2018_10_advertiser_56_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_10_advertiser_56_advertiser_id_idx;


--
-- Name: impressions_2018_10_advertiser_56_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_10_advertiser_56_campaign_id_idx;


--
-- Name: impressions_2018_10_advertiser_56_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_10_advertiser_56_campaign_name_idx;


--
-- Name: impressions_2018_10_advertiser_56_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_10_advertiser_56_country_code_idx;


--
-- Name: impressions_2018_10_advertiser_56_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_10_advertiser_56_date_trunc_idx;


--
-- Name: impressions_2018_10_advertiser_56_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_10_advertiser_56_displayed_at_date_idx;


--
-- Name: impressions_2018_10_advertiser_56_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_10_advertiser_56_payable_idx;


--
-- Name: impressions_2018_10_advertiser_56_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_10_advertiser_56_property_id_idx;


--
-- Name: impressions_2018_10_advertiser_56_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_10_advertiser_56_property_name_idx;


--
-- Name: impressions_2018_10_advertiser_70_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_10_advertiser_70_advertiser_id_idx;


--
-- Name: impressions_2018_10_advertiser_70_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_10_advertiser_70_campaign_id_idx;


--
-- Name: impressions_2018_10_advertiser_70_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_10_advertiser_70_campaign_name_idx;


--
-- Name: impressions_2018_10_advertiser_70_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_10_advertiser_70_country_code_idx;


--
-- Name: impressions_2018_10_advertiser_70_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_10_advertiser_70_date_trunc_idx;


--
-- Name: impressions_2018_10_advertiser_70_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_10_advertiser_70_displayed_at_date_idx;


--
-- Name: impressions_2018_10_advertiser_70_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_10_advertiser_70_payable_idx;


--
-- Name: impressions_2018_10_advertiser_70_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_10_advertiser_70_property_id_idx;


--
-- Name: impressions_2018_10_advertiser_70_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_10_advertiser_70_property_name_idx;


--
-- Name: impressions_2018_10_advertiser_71_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_10_advertiser_71_advertiser_id_idx;


--
-- Name: impressions_2018_10_advertiser_71_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_10_advertiser_71_campaign_id_idx;


--
-- Name: impressions_2018_10_advertiser_71_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_10_advertiser_71_campaign_name_idx;


--
-- Name: impressions_2018_10_advertiser_71_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_10_advertiser_71_country_code_idx;


--
-- Name: impressions_2018_10_advertiser_71_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_10_advertiser_71_date_trunc_idx;


--
-- Name: impressions_2018_10_advertiser_71_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_10_advertiser_71_displayed_at_date_idx;


--
-- Name: impressions_2018_10_advertiser_71_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_10_advertiser_71_payable_idx;


--
-- Name: impressions_2018_10_advertiser_71_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_10_advertiser_71_property_id_idx;


--
-- Name: impressions_2018_10_advertiser_71_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_10_advertiser_71_property_name_idx;


--
-- Name: impressions_2018_10_advertiser_76_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_10_advertiser_76_advertiser_id_idx;


--
-- Name: impressions_2018_10_advertiser_76_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_10_advertiser_76_campaign_id_idx;


--
-- Name: impressions_2018_10_advertiser_76_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_10_advertiser_76_campaign_name_idx;


--
-- Name: impressions_2018_10_advertiser_76_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_10_advertiser_76_country_code_idx;


--
-- Name: impressions_2018_10_advertiser_76_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_10_advertiser_76_date_trunc_idx;


--
-- Name: impressions_2018_10_advertiser_76_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_10_advertiser_76_displayed_at_date_idx;


--
-- Name: impressions_2018_10_advertiser_76_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_10_advertiser_76_payable_idx;


--
-- Name: impressions_2018_10_advertiser_76_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_10_advertiser_76_property_id_idx;


--
-- Name: impressions_2018_10_advertiser_76_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_10_advertiser_76_property_name_idx;


--
-- Name: impressions_2018_10_advertiser__campaign_name_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_10_advertiser__campaign_name_property_name_idx;


--
-- Name: impressions_2018_10_advertiser_campaign_name_property_name_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_10_advertiser_campaign_name_property_name_idx1;


--
-- Name: impressions_2018_10_advertiser_campaign_name_property_name_idx2; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_10_advertiser_campaign_name_property_name_idx2;


--
-- Name: impressions_2018_10_advertiser_campaign_name_property_name_idx3; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_10_advertiser_campaign_name_property_name_idx3;


--
-- Name: impressions_2018_10_advertiser_campaign_name_property_name_idx4; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_10_advertiser_campaign_name_property_name_idx4;


--
-- Name: impressions_2018_10_advertiser_campaign_name_property_name_idx5; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_10_advertiser_campaign_name_property_name_idx5;


--
-- Name: impressions_2018_10_advertiser_campaign_name_property_name_idx6; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_10_advertiser_campaign_name_property_name_idx6;


--
-- Name: impressions_2018_11_advertise_campaign_name_property_name_idx10; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_11_advertise_campaign_name_property_name_idx10;


--
-- Name: impressions_2018_11_advertise_campaign_name_property_name_idx11; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_11_advertise_campaign_name_property_name_idx11;


--
-- Name: impressions_2018_11_advertise_campaign_name_property_name_idx12; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_11_advertise_campaign_name_property_name_idx12;


--
-- Name: impressions_2018_11_advertiser_10_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_11_advertiser_10_advertiser_id_idx;


--
-- Name: impressions_2018_11_advertiser_10_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_11_advertiser_10_campaign_id_idx;


--
-- Name: impressions_2018_11_advertiser_10_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_11_advertiser_10_campaign_name_idx;


--
-- Name: impressions_2018_11_advertiser_10_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_11_advertiser_10_country_code_idx;


--
-- Name: impressions_2018_11_advertiser_10_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_11_advertiser_10_date_trunc_idx;


--
-- Name: impressions_2018_11_advertiser_10_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_11_advertiser_10_displayed_at_date_idx;


--
-- Name: impressions_2018_11_advertiser_10_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_11_advertiser_10_payable_idx;


--
-- Name: impressions_2018_11_advertiser_10_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_11_advertiser_10_property_id_idx;


--
-- Name: impressions_2018_11_advertiser_10_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_11_advertiser_10_property_name_idx;


--
-- Name: impressions_2018_11_advertiser_15_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_11_advertiser_15_advertiser_id_idx;


--
-- Name: impressions_2018_11_advertiser_15_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_11_advertiser_15_campaign_id_idx;


--
-- Name: impressions_2018_11_advertiser_15_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_11_advertiser_15_campaign_name_idx;


--
-- Name: impressions_2018_11_advertiser_15_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_11_advertiser_15_country_code_idx;


--
-- Name: impressions_2018_11_advertiser_15_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_11_advertiser_15_date_trunc_idx;


--
-- Name: impressions_2018_11_advertiser_15_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_11_advertiser_15_displayed_at_date_idx;


--
-- Name: impressions_2018_11_advertiser_15_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_11_advertiser_15_payable_idx;


--
-- Name: impressions_2018_11_advertiser_15_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_11_advertiser_15_property_id_idx;


--
-- Name: impressions_2018_11_advertiser_15_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_11_advertiser_15_property_name_idx;


--
-- Name: impressions_2018_11_advertiser_19_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_11_advertiser_19_advertiser_id_idx;


--
-- Name: impressions_2018_11_advertiser_19_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_11_advertiser_19_campaign_id_idx;


--
-- Name: impressions_2018_11_advertiser_19_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_11_advertiser_19_campaign_name_idx;


--
-- Name: impressions_2018_11_advertiser_19_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_11_advertiser_19_country_code_idx;


--
-- Name: impressions_2018_11_advertiser_19_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_11_advertiser_19_date_trunc_idx;


--
-- Name: impressions_2018_11_advertiser_19_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_11_advertiser_19_displayed_at_date_idx;


--
-- Name: impressions_2018_11_advertiser_19_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_11_advertiser_19_payable_idx;


--
-- Name: impressions_2018_11_advertiser_19_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_11_advertiser_19_property_id_idx;


--
-- Name: impressions_2018_11_advertiser_19_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_11_advertiser_19_property_name_idx;


--
-- Name: impressions_2018_11_advertiser_37_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_11_advertiser_37_advertiser_id_idx;


--
-- Name: impressions_2018_11_advertiser_37_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_11_advertiser_37_campaign_id_idx;


--
-- Name: impressions_2018_11_advertiser_37_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_11_advertiser_37_campaign_name_idx;


--
-- Name: impressions_2018_11_advertiser_37_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_11_advertiser_37_country_code_idx;


--
-- Name: impressions_2018_11_advertiser_37_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_11_advertiser_37_date_trunc_idx;


--
-- Name: impressions_2018_11_advertiser_37_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_11_advertiser_37_displayed_at_date_idx;


--
-- Name: impressions_2018_11_advertiser_37_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_11_advertiser_37_payable_idx;


--
-- Name: impressions_2018_11_advertiser_37_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_11_advertiser_37_property_id_idx;


--
-- Name: impressions_2018_11_advertiser_37_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_11_advertiser_37_property_name_idx;


--
-- Name: impressions_2018_11_advertiser_47_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_11_advertiser_47_advertiser_id_idx;


--
-- Name: impressions_2018_11_advertiser_47_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_11_advertiser_47_campaign_id_idx;


--
-- Name: impressions_2018_11_advertiser_47_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_11_advertiser_47_campaign_name_idx;


--
-- Name: impressions_2018_11_advertiser_47_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_11_advertiser_47_country_code_idx;


--
-- Name: impressions_2018_11_advertiser_47_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_11_advertiser_47_date_trunc_idx;


--
-- Name: impressions_2018_11_advertiser_47_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_11_advertiser_47_displayed_at_date_idx;


--
-- Name: impressions_2018_11_advertiser_47_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_11_advertiser_47_payable_idx;


--
-- Name: impressions_2018_11_advertiser_47_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_11_advertiser_47_property_id_idx;


--
-- Name: impressions_2018_11_advertiser_47_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_11_advertiser_47_property_name_idx;


--
-- Name: impressions_2018_11_advertiser_53_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_11_advertiser_53_advertiser_id_idx;


--
-- Name: impressions_2018_11_advertiser_53_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_11_advertiser_53_campaign_id_idx;


--
-- Name: impressions_2018_11_advertiser_53_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_11_advertiser_53_campaign_name_idx;


--
-- Name: impressions_2018_11_advertiser_53_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_11_advertiser_53_country_code_idx;


--
-- Name: impressions_2018_11_advertiser_53_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_11_advertiser_53_date_trunc_idx;


--
-- Name: impressions_2018_11_advertiser_53_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_11_advertiser_53_displayed_at_date_idx;


--
-- Name: impressions_2018_11_advertiser_53_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_11_advertiser_53_payable_idx;


--
-- Name: impressions_2018_11_advertiser_53_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_11_advertiser_53_property_id_idx;


--
-- Name: impressions_2018_11_advertiser_53_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_11_advertiser_53_property_name_idx;


--
-- Name: impressions_2018_11_advertiser_56_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_11_advertiser_56_advertiser_id_idx;


--
-- Name: impressions_2018_11_advertiser_56_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_11_advertiser_56_campaign_id_idx;


--
-- Name: impressions_2018_11_advertiser_56_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_11_advertiser_56_campaign_name_idx;


--
-- Name: impressions_2018_11_advertiser_56_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_11_advertiser_56_country_code_idx;


--
-- Name: impressions_2018_11_advertiser_56_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_11_advertiser_56_date_trunc_idx;


--
-- Name: impressions_2018_11_advertiser_56_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_11_advertiser_56_displayed_at_date_idx;


--
-- Name: impressions_2018_11_advertiser_56_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_11_advertiser_56_payable_idx;


--
-- Name: impressions_2018_11_advertiser_56_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_11_advertiser_56_property_id_idx;


--
-- Name: impressions_2018_11_advertiser_56_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_11_advertiser_56_property_name_idx;


--
-- Name: impressions_2018_11_advertiser_61_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_11_advertiser_61_advertiser_id_idx;


--
-- Name: impressions_2018_11_advertiser_61_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_11_advertiser_61_campaign_id_idx;


--
-- Name: impressions_2018_11_advertiser_61_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_11_advertiser_61_campaign_name_idx;


--
-- Name: impressions_2018_11_advertiser_61_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_11_advertiser_61_country_code_idx;


--
-- Name: impressions_2018_11_advertiser_61_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_11_advertiser_61_date_trunc_idx;


--
-- Name: impressions_2018_11_advertiser_61_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_11_advertiser_61_displayed_at_date_idx;


--
-- Name: impressions_2018_11_advertiser_61_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_11_advertiser_61_payable_idx;


--
-- Name: impressions_2018_11_advertiser_61_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_11_advertiser_61_property_id_idx;


--
-- Name: impressions_2018_11_advertiser_61_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_11_advertiser_61_property_name_idx;


--
-- Name: impressions_2018_11_advertiser_69_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_11_advertiser_69_advertiser_id_idx;


--
-- Name: impressions_2018_11_advertiser_69_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_11_advertiser_69_campaign_id_idx;


--
-- Name: impressions_2018_11_advertiser_69_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_11_advertiser_69_campaign_name_idx;


--
-- Name: impressions_2018_11_advertiser_69_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_11_advertiser_69_country_code_idx;


--
-- Name: impressions_2018_11_advertiser_69_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_11_advertiser_69_date_trunc_idx;


--
-- Name: impressions_2018_11_advertiser_69_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_11_advertiser_69_displayed_at_date_idx;


--
-- Name: impressions_2018_11_advertiser_69_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_11_advertiser_69_payable_idx;


--
-- Name: impressions_2018_11_advertiser_69_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_11_advertiser_69_property_id_idx;


--
-- Name: impressions_2018_11_advertiser_69_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_11_advertiser_69_property_name_idx;


--
-- Name: impressions_2018_11_advertiser_74_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_11_advertiser_74_advertiser_id_idx;


--
-- Name: impressions_2018_11_advertiser_74_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_11_advertiser_74_campaign_id_idx;


--
-- Name: impressions_2018_11_advertiser_74_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_11_advertiser_74_campaign_name_idx;


--
-- Name: impressions_2018_11_advertiser_74_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_11_advertiser_74_country_code_idx;


--
-- Name: impressions_2018_11_advertiser_74_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_11_advertiser_74_date_trunc_idx;


--
-- Name: impressions_2018_11_advertiser_74_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_11_advertiser_74_displayed_at_date_idx;


--
-- Name: impressions_2018_11_advertiser_74_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_11_advertiser_74_payable_idx;


--
-- Name: impressions_2018_11_advertiser_74_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_11_advertiser_74_property_id_idx;


--
-- Name: impressions_2018_11_advertiser_74_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_11_advertiser_74_property_name_idx;


--
-- Name: impressions_2018_11_advertiser_89_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_11_advertiser_89_advertiser_id_idx;


--
-- Name: impressions_2018_11_advertiser_89_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_11_advertiser_89_campaign_id_idx;


--
-- Name: impressions_2018_11_advertiser_89_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_11_advertiser_89_campaign_name_idx;


--
-- Name: impressions_2018_11_advertiser_89_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_11_advertiser_89_country_code_idx;


--
-- Name: impressions_2018_11_advertiser_89_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_11_advertiser_89_date_trunc_idx;


--
-- Name: impressions_2018_11_advertiser_89_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_11_advertiser_89_displayed_at_date_idx;


--
-- Name: impressions_2018_11_advertiser_89_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_11_advertiser_89_payable_idx;


--
-- Name: impressions_2018_11_advertiser_89_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_11_advertiser_89_property_id_idx;


--
-- Name: impressions_2018_11_advertiser_89_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_11_advertiser_89_property_name_idx;


--
-- Name: impressions_2018_11_advertiser_94_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_11_advertiser_94_advertiser_id_idx;


--
-- Name: impressions_2018_11_advertiser_94_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_11_advertiser_94_campaign_id_idx;


--
-- Name: impressions_2018_11_advertiser_94_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_11_advertiser_94_campaign_name_idx;


--
-- Name: impressions_2018_11_advertiser_94_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_11_advertiser_94_country_code_idx;


--
-- Name: impressions_2018_11_advertiser_94_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_11_advertiser_94_date_trunc_idx;


--
-- Name: impressions_2018_11_advertiser_94_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_11_advertiser_94_displayed_at_date_idx;


--
-- Name: impressions_2018_11_advertiser_94_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_11_advertiser_94_payable_idx;


--
-- Name: impressions_2018_11_advertiser_94_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_11_advertiser_94_property_id_idx;


--
-- Name: impressions_2018_11_advertiser_94_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_11_advertiser_94_property_name_idx;


--
-- Name: impressions_2018_11_advertiser_97_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_11_advertiser_97_advertiser_id_idx;


--
-- Name: impressions_2018_11_advertiser_97_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_11_advertiser_97_campaign_id_idx;


--
-- Name: impressions_2018_11_advertiser_97_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_11_advertiser_97_campaign_name_idx;


--
-- Name: impressions_2018_11_advertiser_97_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_11_advertiser_97_country_code_idx;


--
-- Name: impressions_2018_11_advertiser_97_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_11_advertiser_97_date_trunc_idx;


--
-- Name: impressions_2018_11_advertiser_97_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_11_advertiser_97_displayed_at_date_idx;


--
-- Name: impressions_2018_11_advertiser_97_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_11_advertiser_97_payable_idx;


--
-- Name: impressions_2018_11_advertiser_97_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_11_advertiser_97_property_id_idx;


--
-- Name: impressions_2018_11_advertiser_97_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_11_advertiser_97_property_name_idx;


--
-- Name: impressions_2018_11_advertiser__campaign_name_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_11_advertiser__campaign_name_property_name_idx;


--
-- Name: impressions_2018_11_advertiser_campaign_name_property_name_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_11_advertiser_campaign_name_property_name_idx1;


--
-- Name: impressions_2018_11_advertiser_campaign_name_property_name_idx2; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_11_advertiser_campaign_name_property_name_idx2;


--
-- Name: impressions_2018_11_advertiser_campaign_name_property_name_idx3; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_11_advertiser_campaign_name_property_name_idx3;


--
-- Name: impressions_2018_11_advertiser_campaign_name_property_name_idx4; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_11_advertiser_campaign_name_property_name_idx4;


--
-- Name: impressions_2018_11_advertiser_campaign_name_property_name_idx5; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_11_advertiser_campaign_name_property_name_idx5;


--
-- Name: impressions_2018_11_advertiser_campaign_name_property_name_idx6; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_11_advertiser_campaign_name_property_name_idx6;


--
-- Name: impressions_2018_11_advertiser_campaign_name_property_name_idx7; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_11_advertiser_campaign_name_property_name_idx7;


--
-- Name: impressions_2018_11_advertiser_campaign_name_property_name_idx8; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_11_advertiser_campaign_name_property_name_idx8;


--
-- Name: impressions_2018_11_advertiser_campaign_name_property_name_idx9; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_11_advertiser_campaign_name_property_name_idx9;


--
-- Name: impressions_2018_12_advertise_campaign_name_property_name_idx10; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_12_advertise_campaign_name_property_name_idx10;


--
-- Name: impressions_2018_12_advertise_campaign_name_property_name_idx11; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_12_advertise_campaign_name_property_name_idx11;


--
-- Name: impressions_2018_12_advertise_campaign_name_property_name_idx12; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_12_advertise_campaign_name_property_name_idx12;


--
-- Name: impressions_2018_12_advertise_campaign_name_property_name_idx13; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_12_advertise_campaign_name_property_name_idx13;


--
-- Name: impressions_2018_12_advertise_campaign_name_property_name_idx14; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_12_advertise_campaign_name_property_name_idx14;


--
-- Name: impressions_2018_12_advertise_campaign_name_property_name_idx15; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_12_advertise_campaign_name_property_name_idx15;


--
-- Name: impressions_2018_12_advertise_campaign_name_property_name_idx16; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_12_advertise_campaign_name_property_name_idx16;


--
-- Name: impressions_2018_12_advertise_campaign_name_property_name_idx17; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_12_advertise_campaign_name_property_name_idx17;


--
-- Name: impressions_2018_12_advertise_campaign_name_property_name_idx18; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_12_advertise_campaign_name_property_name_idx18;


--
-- Name: impressions_2018_12_advertise_campaign_name_property_name_idx19; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_12_advertise_campaign_name_property_name_idx19;


--
-- Name: impressions_2018_12_advertise_campaign_name_property_name_idx20; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_12_advertise_campaign_name_property_name_idx20;


--
-- Name: impressions_2018_12_advertiser_10_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_12_advertiser_10_advertiser_id_idx;


--
-- Name: impressions_2018_12_advertiser_10_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_12_advertiser_10_campaign_id_idx;


--
-- Name: impressions_2018_12_advertiser_10_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_12_advertiser_10_campaign_name_idx;


--
-- Name: impressions_2018_12_advertiser_10_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_12_advertiser_10_country_code_idx;


--
-- Name: impressions_2018_12_advertiser_10_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_12_advertiser_10_date_trunc_idx;


--
-- Name: impressions_2018_12_advertiser_10_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_12_advertiser_10_displayed_at_date_idx;


--
-- Name: impressions_2018_12_advertiser_10_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_12_advertiser_10_payable_idx;


--
-- Name: impressions_2018_12_advertiser_10_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_12_advertiser_10_property_id_idx;


--
-- Name: impressions_2018_12_advertiser_10_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_10_property_name_idx;


--
-- Name: impressions_2018_12_advertiser_15_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_12_advertiser_15_advertiser_id_idx;


--
-- Name: impressions_2018_12_advertiser_15_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_12_advertiser_15_campaign_id_idx;


--
-- Name: impressions_2018_12_advertiser_15_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_12_advertiser_15_campaign_name_idx;


--
-- Name: impressions_2018_12_advertiser_15_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_12_advertiser_15_country_code_idx;


--
-- Name: impressions_2018_12_advertiser_15_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_12_advertiser_15_date_trunc_idx;


--
-- Name: impressions_2018_12_advertiser_15_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_12_advertiser_15_displayed_at_date_idx;


--
-- Name: impressions_2018_12_advertiser_15_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_12_advertiser_15_payable_idx;


--
-- Name: impressions_2018_12_advertiser_15_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_12_advertiser_15_property_id_idx;


--
-- Name: impressions_2018_12_advertiser_15_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_15_property_name_idx;


--
-- Name: impressions_2018_12_advertiser_19_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_12_advertiser_19_advertiser_id_idx;


--
-- Name: impressions_2018_12_advertiser_19_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_12_advertiser_19_campaign_id_idx;


--
-- Name: impressions_2018_12_advertiser_19_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_12_advertiser_19_campaign_name_idx;


--
-- Name: impressions_2018_12_advertiser_19_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_12_advertiser_19_country_code_idx;


--
-- Name: impressions_2018_12_advertiser_19_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_12_advertiser_19_date_trunc_idx;


--
-- Name: impressions_2018_12_advertiser_19_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_12_advertiser_19_displayed_at_date_idx;


--
-- Name: impressions_2018_12_advertiser_19_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_12_advertiser_19_payable_idx;


--
-- Name: impressions_2018_12_advertiser_19_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_12_advertiser_19_property_id_idx;


--
-- Name: impressions_2018_12_advertiser_19_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_19_property_name_idx;


--
-- Name: impressions_2018_12_advertiser_22_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_12_advertiser_22_advertiser_id_idx;


--
-- Name: impressions_2018_12_advertiser_22_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_12_advertiser_22_campaign_id_idx;


--
-- Name: impressions_2018_12_advertiser_22_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_12_advertiser_22_campaign_name_idx;


--
-- Name: impressions_2018_12_advertiser_22_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_12_advertiser_22_country_code_idx;


--
-- Name: impressions_2018_12_advertiser_22_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_12_advertiser_22_date_trunc_idx;


--
-- Name: impressions_2018_12_advertiser_22_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_12_advertiser_22_displayed_at_date_idx;


--
-- Name: impressions_2018_12_advertiser_22_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_12_advertiser_22_payable_idx;


--
-- Name: impressions_2018_12_advertiser_22_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_12_advertiser_22_property_id_idx;


--
-- Name: impressions_2018_12_advertiser_22_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_22_property_name_idx;


--
-- Name: impressions_2018_12_advertiser_25_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_12_advertiser_25_advertiser_id_idx;


--
-- Name: impressions_2018_12_advertiser_25_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_12_advertiser_25_campaign_id_idx;


--
-- Name: impressions_2018_12_advertiser_25_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_12_advertiser_25_campaign_name_idx;


--
-- Name: impressions_2018_12_advertiser_25_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_12_advertiser_25_country_code_idx;


--
-- Name: impressions_2018_12_advertiser_25_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_12_advertiser_25_date_trunc_idx;


--
-- Name: impressions_2018_12_advertiser_25_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_12_advertiser_25_displayed_at_date_idx;


--
-- Name: impressions_2018_12_advertiser_25_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_12_advertiser_25_payable_idx;


--
-- Name: impressions_2018_12_advertiser_25_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_12_advertiser_25_property_id_idx;


--
-- Name: impressions_2018_12_advertiser_25_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_25_property_name_idx;


--
-- Name: impressions_2018_12_advertiser_27_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_12_advertiser_27_advertiser_id_idx;


--
-- Name: impressions_2018_12_advertiser_27_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_12_advertiser_27_campaign_id_idx;


--
-- Name: impressions_2018_12_advertiser_27_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_12_advertiser_27_campaign_name_idx;


--
-- Name: impressions_2018_12_advertiser_27_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_12_advertiser_27_country_code_idx;


--
-- Name: impressions_2018_12_advertiser_27_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_12_advertiser_27_date_trunc_idx;


--
-- Name: impressions_2018_12_advertiser_27_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_12_advertiser_27_displayed_at_date_idx;


--
-- Name: impressions_2018_12_advertiser_27_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_12_advertiser_27_payable_idx;


--
-- Name: impressions_2018_12_advertiser_27_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_12_advertiser_27_property_id_idx;


--
-- Name: impressions_2018_12_advertiser_27_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_27_property_name_idx;


--
-- Name: impressions_2018_12_advertiser_2_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_12_advertiser_2_advertiser_id_idx;


--
-- Name: impressions_2018_12_advertiser_2_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_12_advertiser_2_campaign_id_idx;


--
-- Name: impressions_2018_12_advertiser_2_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_12_advertiser_2_campaign_name_idx;


--
-- Name: impressions_2018_12_advertiser_2_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_12_advertiser_2_country_code_idx;


--
-- Name: impressions_2018_12_advertiser_2_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_12_advertiser_2_date_trunc_idx;


--
-- Name: impressions_2018_12_advertiser_2_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_12_advertiser_2_displayed_at_date_idx;


--
-- Name: impressions_2018_12_advertiser_2_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_12_advertiser_2_payable_idx;


--
-- Name: impressions_2018_12_advertiser_2_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_12_advertiser_2_property_id_idx;


--
-- Name: impressions_2018_12_advertiser_2_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_2_property_name_idx;


--
-- Name: impressions_2018_12_advertiser_37_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_12_advertiser_37_advertiser_id_idx;


--
-- Name: impressions_2018_12_advertiser_37_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_12_advertiser_37_campaign_id_idx;


--
-- Name: impressions_2018_12_advertiser_37_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_12_advertiser_37_campaign_name_idx;


--
-- Name: impressions_2018_12_advertiser_37_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_12_advertiser_37_country_code_idx;


--
-- Name: impressions_2018_12_advertiser_37_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_12_advertiser_37_date_trunc_idx;


--
-- Name: impressions_2018_12_advertiser_37_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_12_advertiser_37_displayed_at_date_idx;


--
-- Name: impressions_2018_12_advertiser_37_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_12_advertiser_37_payable_idx;


--
-- Name: impressions_2018_12_advertiser_37_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_12_advertiser_37_property_id_idx;


--
-- Name: impressions_2018_12_advertiser_37_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_37_property_name_idx;


--
-- Name: impressions_2018_12_advertiser_43_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_12_advertiser_43_advertiser_id_idx;


--
-- Name: impressions_2018_12_advertiser_43_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_12_advertiser_43_campaign_id_idx;


--
-- Name: impressions_2018_12_advertiser_43_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_12_advertiser_43_campaign_name_idx;


--
-- Name: impressions_2018_12_advertiser_43_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_12_advertiser_43_country_code_idx;


--
-- Name: impressions_2018_12_advertiser_43_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_12_advertiser_43_date_trunc_idx;


--
-- Name: impressions_2018_12_advertiser_43_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_12_advertiser_43_displayed_at_date_idx;


--
-- Name: impressions_2018_12_advertiser_43_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_12_advertiser_43_payable_idx;


--
-- Name: impressions_2018_12_advertiser_43_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_12_advertiser_43_property_id_idx;


--
-- Name: impressions_2018_12_advertiser_43_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_43_property_name_idx;


--
-- Name: impressions_2018_12_advertiser_45_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_12_advertiser_45_advertiser_id_idx;


--
-- Name: impressions_2018_12_advertiser_45_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_12_advertiser_45_campaign_id_idx;


--
-- Name: impressions_2018_12_advertiser_45_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_12_advertiser_45_campaign_name_idx;


--
-- Name: impressions_2018_12_advertiser_45_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_12_advertiser_45_country_code_idx;


--
-- Name: impressions_2018_12_advertiser_45_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_12_advertiser_45_date_trunc_idx;


--
-- Name: impressions_2018_12_advertiser_45_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_12_advertiser_45_displayed_at_date_idx;


--
-- Name: impressions_2018_12_advertiser_45_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_12_advertiser_45_payable_idx;


--
-- Name: impressions_2018_12_advertiser_45_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_12_advertiser_45_property_id_idx;


--
-- Name: impressions_2018_12_advertiser_45_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_45_property_name_idx;


--
-- Name: impressions_2018_12_advertiser_47_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_12_advertiser_47_advertiser_id_idx;


--
-- Name: impressions_2018_12_advertiser_47_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_12_advertiser_47_campaign_id_idx;


--
-- Name: impressions_2018_12_advertiser_47_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_12_advertiser_47_campaign_name_idx;


--
-- Name: impressions_2018_12_advertiser_47_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_12_advertiser_47_country_code_idx;


--
-- Name: impressions_2018_12_advertiser_47_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_12_advertiser_47_date_trunc_idx;


--
-- Name: impressions_2018_12_advertiser_47_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_12_advertiser_47_displayed_at_date_idx;


--
-- Name: impressions_2018_12_advertiser_47_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_12_advertiser_47_payable_idx;


--
-- Name: impressions_2018_12_advertiser_47_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_12_advertiser_47_property_id_idx;


--
-- Name: impressions_2018_12_advertiser_47_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_47_property_name_idx;


--
-- Name: impressions_2018_12_advertiser_53_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_12_advertiser_53_advertiser_id_idx;


--
-- Name: impressions_2018_12_advertiser_53_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_12_advertiser_53_campaign_id_idx;


--
-- Name: impressions_2018_12_advertiser_53_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_12_advertiser_53_campaign_name_idx;


--
-- Name: impressions_2018_12_advertiser_53_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_12_advertiser_53_country_code_idx;


--
-- Name: impressions_2018_12_advertiser_53_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_12_advertiser_53_date_trunc_idx;


--
-- Name: impressions_2018_12_advertiser_53_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_12_advertiser_53_displayed_at_date_idx;


--
-- Name: impressions_2018_12_advertiser_53_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_12_advertiser_53_payable_idx;


--
-- Name: impressions_2018_12_advertiser_53_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_12_advertiser_53_property_id_idx;


--
-- Name: impressions_2018_12_advertiser_53_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_53_property_name_idx;


--
-- Name: impressions_2018_12_advertiser_61_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_12_advertiser_61_advertiser_id_idx;


--
-- Name: impressions_2018_12_advertiser_61_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_12_advertiser_61_campaign_id_idx;


--
-- Name: impressions_2018_12_advertiser_61_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_12_advertiser_61_campaign_name_idx;


--
-- Name: impressions_2018_12_advertiser_61_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_12_advertiser_61_country_code_idx;


--
-- Name: impressions_2018_12_advertiser_61_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_12_advertiser_61_date_trunc_idx;


--
-- Name: impressions_2018_12_advertiser_61_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_12_advertiser_61_displayed_at_date_idx;


--
-- Name: impressions_2018_12_advertiser_61_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_12_advertiser_61_payable_idx;


--
-- Name: impressions_2018_12_advertiser_61_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_12_advertiser_61_property_id_idx;


--
-- Name: impressions_2018_12_advertiser_61_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_61_property_name_idx;


--
-- Name: impressions_2018_12_advertiser_69_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_12_advertiser_69_advertiser_id_idx;


--
-- Name: impressions_2018_12_advertiser_69_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_12_advertiser_69_campaign_id_idx;


--
-- Name: impressions_2018_12_advertiser_69_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_12_advertiser_69_campaign_name_idx;


--
-- Name: impressions_2018_12_advertiser_69_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_12_advertiser_69_country_code_idx;


--
-- Name: impressions_2018_12_advertiser_69_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_12_advertiser_69_date_trunc_idx;


--
-- Name: impressions_2018_12_advertiser_69_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_12_advertiser_69_displayed_at_date_idx;


--
-- Name: impressions_2018_12_advertiser_69_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_12_advertiser_69_payable_idx;


--
-- Name: impressions_2018_12_advertiser_69_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_12_advertiser_69_property_id_idx;


--
-- Name: impressions_2018_12_advertiser_69_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_69_property_name_idx;


--
-- Name: impressions_2018_12_advertiser_74_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_12_advertiser_74_advertiser_id_idx;


--
-- Name: impressions_2018_12_advertiser_74_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_12_advertiser_74_campaign_id_idx;


--
-- Name: impressions_2018_12_advertiser_74_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_12_advertiser_74_campaign_name_idx;


--
-- Name: impressions_2018_12_advertiser_74_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_12_advertiser_74_country_code_idx;


--
-- Name: impressions_2018_12_advertiser_74_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_12_advertiser_74_date_trunc_idx;


--
-- Name: impressions_2018_12_advertiser_74_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_12_advertiser_74_displayed_at_date_idx;


--
-- Name: impressions_2018_12_advertiser_74_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_12_advertiser_74_payable_idx;


--
-- Name: impressions_2018_12_advertiser_74_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_12_advertiser_74_property_id_idx;


--
-- Name: impressions_2018_12_advertiser_74_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_74_property_name_idx;


--
-- Name: impressions_2018_12_advertiser_87_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_12_advertiser_87_advertiser_id_idx;


--
-- Name: impressions_2018_12_advertiser_87_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_12_advertiser_87_campaign_id_idx;


--
-- Name: impressions_2018_12_advertiser_87_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_12_advertiser_87_campaign_name_idx;


--
-- Name: impressions_2018_12_advertiser_87_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_12_advertiser_87_country_code_idx;


--
-- Name: impressions_2018_12_advertiser_87_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_12_advertiser_87_date_trunc_idx;


--
-- Name: impressions_2018_12_advertiser_87_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_12_advertiser_87_displayed_at_date_idx;


--
-- Name: impressions_2018_12_advertiser_87_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_12_advertiser_87_payable_idx;


--
-- Name: impressions_2018_12_advertiser_87_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_12_advertiser_87_property_id_idx;


--
-- Name: impressions_2018_12_advertiser_87_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_87_property_name_idx;


--
-- Name: impressions_2018_12_advertiser_88_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_12_advertiser_88_advertiser_id_idx;


--
-- Name: impressions_2018_12_advertiser_88_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_12_advertiser_88_campaign_id_idx;


--
-- Name: impressions_2018_12_advertiser_88_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_12_advertiser_88_campaign_name_idx;


--
-- Name: impressions_2018_12_advertiser_88_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_12_advertiser_88_country_code_idx;


--
-- Name: impressions_2018_12_advertiser_88_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_12_advertiser_88_date_trunc_idx;


--
-- Name: impressions_2018_12_advertiser_88_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_12_advertiser_88_displayed_at_date_idx;


--
-- Name: impressions_2018_12_advertiser_88_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_12_advertiser_88_payable_idx;


--
-- Name: impressions_2018_12_advertiser_88_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_12_advertiser_88_property_id_idx;


--
-- Name: impressions_2018_12_advertiser_88_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_88_property_name_idx;


--
-- Name: impressions_2018_12_advertiser_89_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_12_advertiser_89_advertiser_id_idx;


--
-- Name: impressions_2018_12_advertiser_89_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_12_advertiser_89_campaign_id_idx;


--
-- Name: impressions_2018_12_advertiser_89_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_12_advertiser_89_campaign_name_idx;


--
-- Name: impressions_2018_12_advertiser_89_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_12_advertiser_89_country_code_idx;


--
-- Name: impressions_2018_12_advertiser_89_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_12_advertiser_89_date_trunc_idx;


--
-- Name: impressions_2018_12_advertiser_89_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_12_advertiser_89_displayed_at_date_idx;


--
-- Name: impressions_2018_12_advertiser_89_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_12_advertiser_89_payable_idx;


--
-- Name: impressions_2018_12_advertiser_89_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_12_advertiser_89_property_id_idx;


--
-- Name: impressions_2018_12_advertiser_89_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_89_property_name_idx;


--
-- Name: impressions_2018_12_advertiser_91_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_12_advertiser_91_advertiser_id_idx;


--
-- Name: impressions_2018_12_advertiser_91_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_12_advertiser_91_campaign_id_idx;


--
-- Name: impressions_2018_12_advertiser_91_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_12_advertiser_91_campaign_name_idx;


--
-- Name: impressions_2018_12_advertiser_91_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_12_advertiser_91_country_code_idx;


--
-- Name: impressions_2018_12_advertiser_91_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_12_advertiser_91_date_trunc_idx;


--
-- Name: impressions_2018_12_advertiser_91_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_12_advertiser_91_displayed_at_date_idx;


--
-- Name: impressions_2018_12_advertiser_91_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_12_advertiser_91_payable_idx;


--
-- Name: impressions_2018_12_advertiser_91_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_12_advertiser_91_property_id_idx;


--
-- Name: impressions_2018_12_advertiser_91_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_91_property_name_idx;


--
-- Name: impressions_2018_12_advertiser_98_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_12_advertiser_98_advertiser_id_idx;


--
-- Name: impressions_2018_12_advertiser_98_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_12_advertiser_98_campaign_id_idx;


--
-- Name: impressions_2018_12_advertiser_98_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_12_advertiser_98_campaign_name_idx;


--
-- Name: impressions_2018_12_advertiser_98_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_12_advertiser_98_country_code_idx;


--
-- Name: impressions_2018_12_advertiser_98_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_12_advertiser_98_date_trunc_idx;


--
-- Name: impressions_2018_12_advertiser_98_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_12_advertiser_98_displayed_at_date_idx;


--
-- Name: impressions_2018_12_advertiser_98_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_12_advertiser_98_payable_idx;


--
-- Name: impressions_2018_12_advertiser_98_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_12_advertiser_98_property_id_idx;


--
-- Name: impressions_2018_12_advertiser_98_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_98_property_name_idx;


--
-- Name: impressions_2018_12_advertiser_9_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_2018_12_advertiser_9_advertiser_id_idx;


--
-- Name: impressions_2018_12_advertiser_9_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_2018_12_advertiser_9_campaign_id_idx;


--
-- Name: impressions_2018_12_advertiser_9_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_2018_12_advertiser_9_campaign_name_idx;


--
-- Name: impressions_2018_12_advertiser_9_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_2018_12_advertiser_9_country_code_idx;


--
-- Name: impressions_2018_12_advertiser_9_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_2018_12_advertiser_9_date_trunc_idx;


--
-- Name: impressions_2018_12_advertiser_9_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_2018_12_advertiser_9_displayed_at_date_idx;


--
-- Name: impressions_2018_12_advertiser_9_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_2018_12_advertiser_9_payable_idx;


--
-- Name: impressions_2018_12_advertiser_9_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_2018_12_advertiser_9_property_id_idx;


--
-- Name: impressions_2018_12_advertiser_9_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_9_property_name_idx;


--
-- Name: impressions_2018_12_advertiser__campaign_name_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_12_advertiser__campaign_name_property_name_idx;


--
-- Name: impressions_2018_12_advertiser_campaign_name_property_name_idx1; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_campaign_name_property_name_idx1;


--
-- Name: impressions_2018_12_advertiser_campaign_name_property_name_idx2; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_campaign_name_property_name_idx2;


--
-- Name: impressions_2018_12_advertiser_campaign_name_property_name_idx3; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_campaign_name_property_name_idx3;


--
-- Name: impressions_2018_12_advertiser_campaign_name_property_name_idx4; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_campaign_name_property_name_idx4;


--
-- Name: impressions_2018_12_advertiser_campaign_name_property_name_idx5; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_campaign_name_property_name_idx5;


--
-- Name: impressions_2018_12_advertiser_campaign_name_property_name_idx6; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_campaign_name_property_name_idx6;


--
-- Name: impressions_2018_12_advertiser_campaign_name_property_name_idx7; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_campaign_name_property_name_idx7;


--
-- Name: impressions_2018_12_advertiser_campaign_name_property_name_idx8; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_campaign_name_property_name_idx8;


--
-- Name: impressions_2018_12_advertiser_campaign_name_property_name_idx9; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_2018_12_advertiser_campaign_name_property_name_idx9;


--
-- Name: impressions_default_advertiser_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_advertiser_id ATTACH PARTITION public.impressions_default_advertiser_id_idx;


--
-- Name: impressions_default_campaign_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_id ATTACH PARTITION public.impressions_default_campaign_id_idx;


--
-- Name: impressions_default_campaign_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name ATTACH PARTITION public.impressions_default_campaign_name_idx;


--
-- Name: impressions_default_campaign_name_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_campaign_name_and_property_name ATTACH PARTITION public.impressions_default_campaign_name_property_name_idx;


--
-- Name: impressions_default_country_code_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_country_code ATTACH PARTITION public.impressions_default_country_code_idx;


--
-- Name: impressions_default_date_trunc_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_hour ATTACH PARTITION public.impressions_default_date_trunc_idx;


--
-- Name: impressions_default_displayed_at_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_displayed_at_date ATTACH PARTITION public.impressions_default_displayed_at_date_idx;


--
-- Name: impressions_default_payable_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_payable ATTACH PARTITION public.impressions_default_payable_idx;


--
-- Name: impressions_default_property_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_id ATTACH PARTITION public.impressions_default_property_id_idx;


--
-- Name: impressions_default_property_name_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.index_impressions_on_property_name ATTACH PARTITION public.impressions_default_property_name_idx;


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20181017152837'),
('20181123143528'),
('20181126182831'),
('20181126220213'),
('20181126220214'),
('20181130175815'),
('20181201120915');


