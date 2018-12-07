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
-- Name: events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events (
    id bigint NOT NULL,
    eventable_id integer NOT NULL,
    eventable_type character varying NOT NULL,
    tags character varying[] DEFAULT '{}'::character varying[],
    body text NOT NULL,
    user_id integer NOT NULL,
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
    campaign_name character varying NOT NULL,
    property_name character varying NOT NULL,
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
    fallback_campaign boolean DEFAULT false NOT NULL
)
PARTITION BY RANGE (advertiser_id, displayed_at_date);


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
    prohibited_advertiser_ids bigint[] DEFAULT '{}'::bigint[] NOT NULL,
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
-- Name: events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- Name: impressions_default id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impressions_default ALTER COLUMN id SET DEFAULT public.gen_random_uuid();


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
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


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
-- Name: index_impressions_on_campaign_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_campaign_name ON ONLY public.impressions USING btree (campaign_name);


--
-- Name: impressions_default_campaign_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_campaign_name_idx ON public.impressions_default USING btree (campaign_name);


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
-- Name: index_impressions_on_property_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_property_id ON ONLY public.impressions USING btree (property_id);


--
-- Name: impressions_default_property_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX impressions_default_property_id_idx ON public.impressions_default USING btree (property_id);


--
-- Name: index_impressions_on_property_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_impressions_on_property_name ON ONLY public.impressions USING btree (property_name);


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
-- Name: index_events_on_eventable_id_and_eventable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_events_on_eventable_id_and_eventable_type ON public.events USING btree (eventable_id, eventable_type);


--
-- Name: index_events_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_events_on_user_id ON public.events USING btree (user_id);


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
('20181126182831'),
('20181126220213'),
('20181126220214'),
('20181130175815'),
('20181201120915'),
('20181206210405');


