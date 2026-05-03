--
-- PostgreSQL database dump
--

\restrict SYAMAAJiE0u9sCSKVktyg9mLeUqsbJNriacbEs9s1ieJuFTF7h1bYnWQfi4dd68

-- Dumped from database version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customers (
    customer_id character varying(10) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(100),
    city character varying(50),
    state character varying(50),
    signup_date date,
    account_status character varying(20)
);


--
-- Name: flagged_order_totals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.flagged_order_totals (
    order_id character varying(12),
    recorded_total numeric(14,2),
    computed_total numeric,
    difference numeric
);


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_items (
    item_id integer NOT NULL,
    order_id character varying(12),
    product_id character varying(10),
    quantity integer,
    unit_price numeric(12,2),
    line_total numeric(14,2)
);


--
-- Name: order_items_item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_items_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_items_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_items_item_id_seq OWNED BY public.order_items.item_id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    order_id character varying(12) NOT NULL,
    customer_id character varying(10),
    seller_id character varying(10),
    order_date date,
    delivery_date date,
    order_status character varying(20),
    total_amount numeric(14,2)
);


--
-- Name: payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payments (
    payment_id character varying(12) NOT NULL,
    order_id character varying(12),
    payment_method character varying(30),
    amount numeric(14,2),
    payment_date timestamp without time zone
);


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    product_id character varying(10) NOT NULL,
    product_name character varying(200) NOT NULL,
    category character varying(50),
    unit_price numeric(12,2),
    seller_id character varying(10)
);


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reviews (
    review_id character varying(12) NOT NULL,
    product_id character varying(10),
    customer_id character varying(10),
    order_id character varying(12),
    rating integer,
    review_date date
);


--
-- Name: sellers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sellers (
    seller_id character varying(10) NOT NULL,
    seller_name character varying(100) NOT NULL,
    onboarding_date date,
    product_category character varying(50),
    city character varying(50),
    state character varying(50),
    account_status character varying(20)
);


--
-- Name: order_items item_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items ALTER COLUMN item_id SET DEFAULT nextval('public.order_items_item_id_seq'::regclass);


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.customers (customer_id, first_name, last_name, email, city, state, signup_date, account_status) FROM stdin;
CUST0077	Ibrahim	Ibrahim	ibrahim.ibrahim851@gmail.com	Kano	Kano	2024-04-06	Active
CUST0078	Lola	Chukwu	lola.chukwu345@yahoo.com	Kano	Kano	2023-07-06	Active
CUST0079	Ibrahim	Nwosu	ibrahim.nwosu902@gmail.com	Port Harcourt	Rivers	2024-07-23	Inactive
CUST0080	Titi	Adegoke	titi.adegoke501@gmail.com	Lagos	Lagos	2024-05-02	Active
CUST0081	Emeka	Musa	emeka.musa302@yahoo.com	Abuja	FCT	2023-11-10	Active
CUST0082	Segun	Obi	segun.obi436@gmail.com	Abuja	FCT	2023-12-27	Active
CUST0083	Funmi	Bello	funmi.bello739@yahoo.com	Lagos	Lagos	2024-07-02	Active
CUST0084	Yemi	Babangida	yemi.babangida284@gmail.com	Lagos	Lagos	2024-06-21	Active
CUST0085	Sade	Ibrahim	\N	Port Harcourt	Rivers	2024-06-30	Active
CUST0086	Tobi	Oluwole	tobi.oluwole715@gmail.com	Ibadan	Oyo	2024-05-17	Active
CUST0087	Ada	Babangida	ada.babangida452@gmail.com	Kano	Kano	2023-09-16	Active
CUST0088	Chidi	Chukwu	chidi.chukwu504@yahoo.com	Lagos	Lagos	2023-02-24	Active
CUST0089	Chidi	Ibrahim	chidi.ibrahim122@gmail.com	Ibadan	Oyo	2024-09-02	Active
CUST0090	Musa	Nnamdi	musa.nnamdi931@gmail.com	Port Harcourt	Rivers	2024-03-15	Active
CUST0091	Titi	Bello	titi.bello971@gmail.com	Lagos	Lagos	2023-09-28	Active
CUST0092	Tobi	Musa	tobi.musa161@yahoo.com	Lagos	Lagos	2024-08-31	Active
CUST0093	Gbenga	Oluwole	gbenga.oluwole720@gmail.com	Lagos	Lagos	2023-08-28	Active
CUST0094	Chioma	Adeyemi	chioma.adeyemi436@yahoo.com	Kano	Kano	2023-06-02	Active
CUST0095	Bisi	Oluwole	bisi.oluwole610@gmail.com	Lagos	Lagos	2023-10-23	Active
CUST0096	Gbenga	Chukwu	gbenga.chukwu966@yahoo.com	Kano	Kano	2024-03-24	Active
CUST0097	Titi	Abubakar	titi.abubakar619@yahoo.com	Ibadan	Oyo	2024-11-21	Active
CUST0098	Lola	Nwosu	lola.nwosu591@yahoo.com	Ibadan	Oyo	2024-04-26	Active
CUST0099	Bisi	Fagbemi	bisi.fagbemi447@gmail.com	Ibadan	Oyo	2023-04-04	Active
CUST0100	Lola	Bello	lola.bello879@yahoo.com	Lagos	Lagos	2024-05-22	Active
CUST0101	Tobi	Adeleke	tobi.adeleke466@yahoo.com	Port Harcourt	Rivers	2023-04-29	Active
CUST0102	Obinna	Okafor	obinna.okafor674@gmail.com	Ibadan	Oyo	2023-02-25	Active
CUST0103	Ada	Nnamdi	ada.nnamdi779@yahoo.com	Kano	Kano	2023-05-15	Active
CUST0104	Ada	Bello	ada.bello30@gmail.com	Ibadan	Oyo	2023-09-03	Active
CUST0105	Tobi	Adegoke	tobi.adegoke96@yahoo.com	Kano	Kano	2023-04-27	Active
CUST0106	Tunde	Babangida	tunde.babangida956@gmail.com	Kano	Kano	2023-10-07	Active
CUST0107	Funmi	Nnamdi	funmi.nnamdi565@yahoo.com	Ibadan	Oyo	2024-09-05	Active
CUST0108	Kola	Adegoke	kola.adegoke349@gmail.com	Ibadan	Oyo	2023-01-03	Active
CUST0109	Ayo	Babangida	ayo.babangida887@yahoo.com	Port Harcourt	Rivers	2023-12-20	Active
CUST0110	Blessing	Abubakar	blessing.abubakar891@yahoo.com	Abuja	FCT	2024-08-08	Active
CUST0111	Titi	Babangida	titi.babangida723@gmail.com	Lagos	Lagos	2024-11-10	Active
CUST0112	Ada	Adeleke	ada.adeleke130@gmail.com	Ibadan	Oyo	2023-04-13	Active
CUST0113	Blessing	Nnamdi	blessing.nnamdi16@gmail.com	Lagos	Lagos	2024-11-01	Active
CUST0114	Kola	Abubakar	kola.abubakar639@gmail.com	Abuja	FCT	2023-12-03	Active
CUST0115	Femi	Babangida	femi.babangida894@gmail.com	Ibadan	Oyo	2023-08-29	Active
CUST0116	Titi	Musa	titi.musa445@gmail.com	Ibadan	Oyo	2023-04-13	Active
CUST0117	Ngozi	Abubakar	ngozi.abubakar816@yahoo.com	Ibadan	Oyo	2024-03-17	Active
CUST0118	Chioma	Okonkwo	chioma.okonkwo175@yahoo.com	Kano	Kano	2024-01-27	Active
CUST0119	Ayo	Eze	ayo.eze238@gmail.com	Abuja	FCT	2023-09-19	Active
CUST0120	Lola	Taiwo	lola.taiwo162@yahoo.com	Ibadan	Oyo	2024-08-24	Active
CUST0121	Chukwu	Oluwole	chukwu.oluwole204@gmail.com	Kano	Kano	2023-04-20	Active
CUST0122	Gbenga	Oluwole	gbenga.oluwole23@gmail.com	Kano	Kano	2023-10-09	Inactive
CUST0123	Titi	Babangida	titi.babangida853@gmail.com	Ibadan	Oyo	2023-08-24	Active
CUST0124	Yemi	Okorie	yemi.okorie257@gmail.com	Lagos	Lagos	2024-11-06	Active
CUST0125	Oluwaseun	Adeleke	oluwaseun.adeleke317@gmail.com	Kano	Kano	2024-01-09	Active
CUST0126	Ibrahim	Adegoke	ibrahim.adegoke180@yahoo.com	Ibadan	Oyo	2024-01-10	Active
CUST0127	Kola	Babangida	kola.babangida991@gmail.com	Port Harcourt	Rivers	2023-12-13	Active
CUST0128	Tunde	Ibrahim	tunde.ibrahim881@gmail.com	Ibadan	Oyo	2024-02-11	Active
CUST0129	Musa	Okafor	musa.okafor271@gmail.com	Lagos	Lagos	2024-11-19	Active
CUST0130	Obinna	Obi	obinna.obi111@gmail.com	Kano	Kano	2024-09-26	Active
CUST0131	Funmi	Musa	funmi.musa651@gmail.com	Ibadan	Oyo	2023-11-06	Active
CUST0132	Ngozi	Oluwole	ngozi.oluwole505@yahoo.com	Lagos	Lagos	2024-07-04	Active
CUST0133	Titi	Taiwo	titi.taiwo430@gmail.com	Abuja	FCT	2024-02-29	Active
CUST0134	Kola	Adeleke	kola.adeleke707@gmail.com	Kano	Kano	2023-08-30	Active
CUST0135	Fatima	Taiwo	fatima.taiwo924@gmail.com	Ibadan	Oyo	2024-02-12	Active
CUST0136	Obinna	Nnamdi	obinna.nnamdi94@gmail.com	Ibadan	Oyo	2024-09-03	Active
CUST0137	Funmi	Eze	funmi.eze806@gmail.com	Port Harcourt	Rivers	2024-07-21	Active
CUST0138	Funmi	Abubakar	funmi.abubakar793@yahoo.com	Port Harcourt	Rivers	2023-01-03	Active
CUST0139	Tobi	Nwosu	tobi.nwosu818@yahoo.com	Ibadan	Oyo	2023-01-27	Active
CUST0140	Funmi	Fagbemi	funmi.fagbemi332@yahoo.com	Port Harcourt	Rivers	2023-05-10	Active
CUST0141	Chidi	Babangida	chidi.babangida460@gmail.com	Lagos	Lagos	2023-04-22	Active
CUST0142	Ngozi	Lawal	ngozi.lawal309@gmail.com	Ibadan	Oyo	2023-03-04	Active
CUST0143	Amaka	Babangida	amaka.babangida730@gmail.com	Abuja	FCT	2023-03-24	Active
CUST0144	Kola	Okorie	kola.okorie649@gmail.com	Lagos	Lagos	2024-01-26	Active
CUST0145	Segun	Okorie	segun.okorie441@yahoo.com	Lagos	Lagos	2024-11-01	Active
CUST0146	Yemi	Adegoke	yemi.adegoke463@gmail.com	Port Harcourt	Rivers	2024-04-09	Active
CUST0147	Ibrahim	Nwosu	ibrahim.nwosu384@gmail.com	Lagos	Lagos	2024-04-30	Inactive
CUST0148	Amaka	Obi	amaka.obi832@yahoo.com	Lagos	Lagos	2024-07-29	Active
CUST0149	Fatima	Adegoke	fatima.adegoke889@gmail.com	Lagos	Lagos	2023-10-22	Active
CUST0150	Segun	Adeyemi	segun.adeyemi159@gmail.com	Lagos	Lagos	2023-04-21	Active
CUST0151	Uche	Nwosu	uche.nwosu588@yahoo.com	Abuja	FCT	2024-07-28	Active
CUST0152	Lola	Nwosu	lola.nwosu30@yahoo.com	Kano	Kano	2023-11-13	Active
CUST0154	Yemi	Chukwu	yemi.chukwu430@gmail.com	Port Harcourt	Rivers	2023-11-16	Active
CUST0155	Oluwaseun	Adeleke	oluwaseun.adeleke160@yahoo.com	Kano	Kano	2024-11-21	Active
CUST0156	Ada	Okorie	ada.okorie453@gmail.com	Kano	Kano	2024-06-08	Active
CUST0157	Lola	Fagbemi	lola.fagbemi499@gmail.com	Lagos	Lagos	2023-08-14	Active
CUST0158	Yemi	Oluwole	yemi.oluwole969@yahoo.com	Lagos	Lagos	2023-09-19	Active
CUST0159	Titi	Adegoke	titi.adegoke180@yahoo.com	Lagos	Lagos	2023-08-24	Active
CUST0160	Chidi	Chukwu	chidi.chukwu883@gmail.com	Port Harcourt	Rivers	2024-04-15	Active
CUST0161	Ayo	Chukwu	ayo.chukwu727@gmail.com	Kano	Kano	2024-02-19	Inactive
CUST0162	Dayo	Nnamdi	dayo.nnamdi852@gmail.com	Lagos	Lagos	2024-03-23	Active
CUST0163	Musa	Lawal	musa.lawal81@gmail.com	Abuja	FCT	2023-12-14	Active
CUST0164	Femi	Bello	femi.bello544@gmail.com	Lagos	Lagos	2023-12-24	Active
CUST0165	Funmi	Bello	funmi.bello150@yahoo.com	Port Harcourt	Rivers	2023-06-06	Active
CUST0166	Uche	Babangida	uche.babangida476@gmail.com	Lagos	Lagos	2024-04-04	Active
CUST0167	Dayo	Abubakar	dayo.abubakar885@gmail.com	Kano	Kano	2024-03-26	Inactive
CUST0168	Chioma	Nwosu	chioma.nwosu606@yahoo.com	Kano	Kano	2023-11-14	Active
CUST0169	Obinna	Oluwole	obinna.oluwole79@gmail.com	Lagos	Lagos	2023-04-03	Active
CUST0170	Ayo	Taiwo	ayo.taiwo978@gmail.com	Abuja	FCT	2024-04-05	Active
CUST0171	Ada	Lawal	ada.lawal155@gmail.com	Lagos	Lagos	2023-12-18	Active
CUST0172	Bisi	Adeleke	bisi.adeleke254@gmail.com	Abuja	FCT	2024-06-20	Active
CUST0173	Blessing	Oluwole	blessing.oluwole397@gmail.com	Abuja	FCT	2024-09-04	Inactive
CUST0174	Amaka	Taiwo	amaka.taiwo695@gmail.com	Lagos	Lagos	2024-11-03	Active
CUST0175	Ibrahim	Musa	ibrahim.musa597@gmail.com	Ibadan	Oyo	2023-11-14	Active
CUST0176	Gbenga	Musa	gbenga.musa318@gmail.com	Lagos	Lagos	2023-12-03	Active
CUST0177	Titi	Lawal	titi.lawal96@gmail.com	Port Harcourt	Rivers	2024-01-06	Inactive
CUST0178	Yemi	Abubakar	yemi.abubakar971@gmail.com	Lagos	Lagos	2023-05-21	Active
CUST0179	Amaka	Lawal	amaka.lawal790@gmail.com	Port Harcourt	Rivers	2024-06-23	Inactive
CUST0180	Dayo	Eze	dayo.eze612@gmail.com	Ibadan	Oyo	2024-10-01	Active
CUST0181	Ngozi	Adegoke	ngozi.adegoke374@gmail.com	Port Harcourt	Rivers	2024-03-30	Active
CUST0182	Funmi	Oluwole	funmi.oluwole989@gmail.com	Lagos	Lagos	2023-07-18	Active
CUST0183	Chukwu	Oluwole	chukwu.oluwole797@gmail.com	Ibadan	Oyo	2023-06-15	Active
CUST0184	Ngozi	Babangida	ngozi.babangida896@gmail.com	Ibadan	Oyo	2024-06-12	Active
CUST0185	Bisi	Nwosu	bisi.nwosu461@gmail.com	Lagos	Lagos	2024-03-23	Active
CUST0186	Oluwaseun	Obi	oluwaseun.obi953@yahoo.com	Port Harcourt	Rivers	2024-05-29	Active
CUST0187	Fatima	Ibrahim	fatima.ibrahim29@gmail.com	Ibadan	Oyo	2024-10-27	Active
CUST0188	Sade	Babangida	sade.babangida713@gmail.com	Lagos	Lagos	2024-04-25	Active
CUST0189	Emeka	Nwosu	emeka.nwosu221@gmail.com	Ibadan	Oyo	2024-09-15	Active
CUST0190	Funmi	Oluwole	funmi.oluwole125@yahoo.com	Port Harcourt	Rivers	2024-09-29	Active
CUST0191	Ada	Okorie	ada.okorie549@yahoo.com	Port Harcourt	Rivers	2023-09-05	Active
CUST0192	Dayo	Obi	dayo.obi247@gmail.com	Abuja	FCT	2024-11-15	Active
CUST0193	Segun	Taiwo	segun.taiwo520@gmail.com	Lagos	Lagos	2023-01-21	Active
CUST0194	Musa	Obi	musa.obi260@gmail.com	Lagos	Lagos	2023-03-11	Active
CUST0195	Amaka	Fagbemi	amaka.fagbemi753@gmail.com	Kano	Kano	2023-12-27	Active
CUST0196	Lola	Nnamdi	lola.nnamdi713@gmail.com	Port Harcourt	Rivers	2023-05-19	Inactive
CUST0197	Yemi	Adeleke	yemi.adeleke811@yahoo.com	Lagos	Lagos	2023-11-14	Active
CUST0198	Ngozi	Adeyemi	ngozi.adeyemi293@gmail.com	Abuja	FCT	2024-11-02	Active
CUST0199	Aisha	Chukwu	aisha.chukwu762@gmail.com	Port Harcourt	Rivers	2023-12-14	Active
CUST0200	Fatima	Lawal	fatima.lawal274@gmail.com	Kano	Kano	2023-03-22	Active
CUST0201	Ibrahim	Bello	ibrahim.bello82@gmail.com	Abuja	FCT	2024-04-01	Active
CUST0202	Chukwu	Obi	chukwu.obi458@yahoo.com	Lagos	Lagos	2023-12-28	Active
CUST0203	Chioma	Adeleke	chioma.adeleke77@gmail.com	Lagos	Lagos	2024-06-09	Active
CUST0204	Emeka	Eze	emeka.eze870@gmail.com	Lagos	Lagos	2023-02-05	Active
CUST0205	Fatima	Obi	fatima.obi393@gmail.com	Port Harcourt	Rivers	2023-06-07	Active
CUST0206	Uche	Musa	uche.musa588@yahoo.com	Abuja	FCT	2023-11-18	Active
CUST0207	Emeka	Okonkwo	emeka.okonkwo512@gmail.com	Ibadan	Oyo	2023-05-01	Active
CUST0208	Yemi	Okorie	yemi.okorie293@gmail.com	Port Harcourt	Rivers	2023-07-24	Active
CUST0209	Oluwaseun	Nnamdi	oluwaseun.nnamdi90@gmail.com	Abuja	FCT	2023-11-24	Active
CUST0210	Sade	Oluwole	sade.oluwole872@yahoo.com	Abuja	FCT	2024-10-15	Active
CUST0211	Amaka	Adeyemi	amaka.adeyemi812@yahoo.com	Abuja	FCT	2023-01-27	Active
CUST0212	Tobi	Eze	tobi.eze627@gmail.com	Abuja	FCT	2024-02-12	Active
CUST0213	Uche	Adegoke	uche.adegoke844@gmail.com	Abuja	FCT	2023-11-21	Active
CUST0214	Segun	Obi	segun.obi132@gmail.com	Abuja	FCT	2024-10-17	Active
CUST0215	Blessing	Adeleke	blessing.adeleke852@yahoo.com	Abuja	FCT	2023-06-18	Active
CUST0216	Segun	Oluwole	segun.oluwole867@yahoo.com	Lagos	Lagos	2024-07-18	Active
CUST0217	Tobi	Musa	tobi.musa515@gmail.com	Lagos	Lagos	2024-08-17	Active
CUST0218	Oluwaseun	Okorie	oluwaseun.okorie346@gmail.com	Kano	Kano	2023-01-30	Active
CUST0219	Uche	Fagbemi	uche.fagbemi427@gmail.com	Kano	Kano	2024-10-04	Active
CUST0220	Chioma	Chukwu	chioma.chukwu305@gmail.com	Abuja	FCT	2023-06-11	Active
CUST0221	Ibrahim	Okorie	ibrahim.okorie148@gmail.com	Abuja	FCT	2023-12-20	Active
CUST0222	Segun	Taiwo	segun.taiwo109@gmail.com	Port Harcourt	Rivers	2023-10-01	Active
CUST0223	Sade	Chukwu	sade.chukwu885@gmail.com	Lagos	Lagos	2023-06-13	Active
CUST0224	Yemi	Okonkwo	yemi.okonkwo511@gmail.com	Port Harcourt	Rivers	2023-11-12	Active
CUST0225	Segun	Nnamdi	segun.nnamdi990@yahoo.com	Ibadan	Oyo	2023-02-19	Inactive
CUST0226	Obinna	Babangida	obinna.babangida293@gmail.com	Kano	Kano	2024-03-17	Active
CUST0227	Uche	Chukwu	uche.chukwu375@yahoo.com	Port Harcourt	Rivers	2024-07-29	Active
CUST0228	Musa	Lawal	musa.lawal462@gmail.com	Lagos	Lagos	2024-09-30	Active
CUST0229	Amaka	Chukwu	amaka.chukwu383@gmail.com	Lagos	Lagos	2024-01-10	Active
CUST0230	Musa	Lawal	musa.lawal42@yahoo.com	Kano	Kano	2023-12-08	Active
CUST0231	Oluwaseun	Lawal	oluwaseun.lawal144@gmail.com	Lagos	Lagos	2023-06-16	Active
CUST0232	Sade	Fagbemi	sade.fagbemi345@gmail.com	Port Harcourt	Rivers	2024-05-16	Active
CUST0233	Emeka	Obi	emeka.obi340@gmail.com	Abuja	FCT	2024-08-20	Active
CUST0234	Kola	Fagbemi	kola.fagbemi592@yahoo.com	Kano	Kano	2024-05-06	Active
CUST0235	Lola	Ibrahim	lola.ibrahim33@gmail.com	Lagos	Lagos	2023-07-15	Inactive
CUST0236	Aisha	Adeyemi	aisha.adeyemi421@gmail.com	Abuja	FCT	2024-04-27	Active
CUST0237	Segun	Adeyemi	segun.adeyemi575@gmail.com	Port Harcourt	Rivers	2024-06-22	Active
CUST0238	Tobi	Abubakar	tobi.abubakar560@gmail.com	Abuja	FCT	2024-11-28	Active
CUST0239	Yemi	Ibrahim	yemi.ibrahim286@gmail.com	Kano	Kano	2023-11-01	Active
CUST0240	Ada	Abubakar	ada.abubakar492@gmail.com	Kano	Kano	2023-10-08	Active
CUST0241	Musa	Obi	musa.obi978@gmail.com	Ibadan	Oyo	2023-02-13	Active
CUST0242	Chukwu	Nwosu	chukwu.nwosu766@gmail.com	Lagos	Lagos	2024-07-05	Active
CUST0243	Tunde	Bello	tunde.bello631@gmail.com	Kano	Kano	2023-02-21	Active
CUST0244	Ngozi	Bello	ngozi.bello424@gmail.com	Kano	Kano	2024-11-28	Active
CUST0245	Blessing	Okonkwo	blessing.okonkwo417@gmail.com	Ibadan	Oyo	2024-05-02	Active
CUST0246	Sade	Abubakar	sade.abubakar293@gmail.com	Port Harcourt	Rivers	2023-04-02	Active
CUST0247	Titi	Adeleke	titi.adeleke936@gmail.com	Abuja	FCT	2023-06-30	Active
CUST0248	Musa	Babangida	musa.babangida191@gmail.com	Ibadan	Oyo	2023-10-24	Active
CUST0249	Dayo	Bello	dayo.bello951@gmail.com	Lagos	Lagos	2024-10-18	Active
CUST0250	Tunde	Lawal	tunde.lawal480@yahoo.com	Ibadan	Oyo	2023-12-05	Active
CUST0251	Gbenga	Okonkwo	gbenga.okonkwo15@gmail.com	Kano	Kano	2024-08-04	Active
CUST0252	Nkechi	Chukwu	nkechi.chukwu847@gmail.com	Lagos	Lagos	2024-02-15	Active
CUST0253	Ada	Abubakar	ada.abubakar959@yahoo.com	Ibadan	Oyo	2023-08-30	Active
CUST0254	Sade	Fagbemi	sade.fagbemi741@gmail.com	Ibadan	Oyo	2024-01-04	Active
CUST0255	Chukwu	Oluwole	chukwu.oluwole164@gmail.com	Kano	Kano	2023-11-15	Active
CUST0256	Funmi	Ibrahim	funmi.ibrahim981@yahoo.com	Abuja	FCT	2024-09-12	Active
CUST0257	Chioma	Adeyemi	chioma.adeyemi781@yahoo.com	Port Harcourt	Rivers	2023-03-25	Active
CUST0258	Chidi	Fagbemi	chidi.fagbemi115@yahoo.com	Port Harcourt	Rivers	2024-06-01	Active
CUST0259	Ibrahim	Lawal	ibrahim.lawal453@yahoo.com	Lagos	Lagos	2024-08-20	Active
CUST0260	Ngozi	Nnamdi	ngozi.nnamdi136@gmail.com	Abuja	FCT	2023-03-01	Active
CUST0261	Musa	Nwosu	musa.nwosu837@yahoo.com	Port Harcourt	Rivers	2023-03-16	Inactive
CUST0262	Tobi	Adeleke	tobi.adeleke958@gmail.com	Port Harcourt	Rivers	2024-04-28	Inactive
CUST0263	Tunde	Adegoke	tunde.adegoke384@gmail.com	Lagos	Lagos	2024-01-22	Active
CUST0264	Nkechi	Taiwo	nkechi.taiwo137@gmail.com	Ibadan	Oyo	2023-07-02	Active
CUST0265	Titi	Ibrahim	\N	Abuja	FCT	2023-11-02	Active
CUST0266	Obinna	Ibrahim	obinna.ibrahim254@gmail.com	Abuja	FCT	2023-07-13	Active
CUST0267	Lola	Adegoke	lola.adegoke630@gmail.com	Lagos	Lagos	2023-01-17	Active
CUST0268	Ngozi	Nnamdi	ngozi.nnamdi613@gmail.com	Lagos	Lagos	2023-09-08	Active
CUST0269	Tobi	Adeyemi	tobi.adeyemi773@gmail.com	Abuja	FCT	2024-05-30	Active
CUST0270	Titi	Fagbemi	titi.fagbemi327@gmail.com	Port Harcourt	Rivers	2023-11-25	Active
CUST0271	Segun	Ibrahim	segun.ibrahim424@gmail.com	Ibadan	Oyo	2024-08-28	Active
CUST0272	Aisha	Taiwo	aisha.taiwo508@yahoo.com	Kano	Kano	2024-10-20	Active
CUST0273	Aisha	Eze	aisha.eze308@gmail.com	Kano	Kano	2024-04-29	Active
CUST0274	Gbenga	Eze	gbenga.eze826@gmail.com	Lagos	Lagos	2024-02-27	Active
CUST0275	Musa	Ibrahim	musa.ibrahim262@yahoo.com	Abuja	FCT	2024-04-05	Active
CUST0276	Obinna	Adeyemi	obinna.adeyemi53@yahoo.com	Abuja	FCT	2024-09-09	Inactive
CUST0277	Uche	Fagbemi	uche.fagbemi742@gmail.com	Lagos	Lagos	2023-08-02	Active
CUST0278	Blessing	Okafor	blessing.okafor217@gmail.com	Lagos	Lagos	2023-05-01	Active
CUST0279	Gbenga	Okorie	gbenga.okorie721@yahoo.com	Ibadan	Oyo	2024-07-19	Active
CUST0280	Tobi	Obi	tobi.obi316@yahoo.com	Abuja	FCT	2024-05-24	Active
CUST0281	Ibrahim	Adeyemi	ibrahim.adeyemi380@gmail.com	Port Harcourt	Rivers	2023-08-15	Active
CUST0282	Blessing	Fagbemi	blessing.fagbemi594@gmail.com	Lagos	Lagos	2023-07-20	Active
CUST0283	Funmi	Babangida	funmi.babangida564@gmail.com	Kano	Kano	2023-09-21	Active
CUST0284	Femi	Babangida	femi.babangida472@yahoo.com	Ibadan	Oyo	2023-06-23	Active
CUST0285	Oluwaseun	Taiwo	oluwaseun.taiwo658@gmail.com	Lagos	Lagos	2023-03-18	Active
CUST0286	Emeka	Adegoke	emeka.adegoke141@gmail.com	Lagos	Lagos	2023-06-04	Inactive
CUST0287	Ngozi	Okorie	ngozi.okorie654@gmail.com	Abuja	FCT	2024-05-09	Active
CUST0288	Tobi	Adegoke	tobi.adegoke13@yahoo.com	Lagos	Lagos	2024-07-02	Active
CUST0289	Gbenga	Adegoke	gbenga.adegoke826@gmail.com	Abuja	FCT	2023-04-09	Active
CUST0290	Segun	Nwosu	segun.nwosu835@gmail.com	Lagos	Lagos	2023-03-22	Active
CUST0291	Funmi	Ibrahim	funmi.ibrahim308@gmail.com	Abuja	FCT	2024-10-31	Active
CUST0292	Musa	Chukwu	musa.chukwu566@gmail.com	Lagos	Lagos	2023-06-25	Active
CUST0293	Ibrahim	Fagbemi	ibrahim.fagbemi879@gmail.com	Kano	Kano	2023-02-13	Active
CUST0294	Blessing	Musa	blessing.musa701@gmail.com	Lagos	Lagos	2024-07-31	Active
CUST0295	Ibrahim	Okafor	ibrahim.okafor985@yahoo.com	Ibadan	Oyo	2024-02-12	Active
CUST0296	Funmi	Fagbemi	funmi.fagbemi855@gmail.com	Lagos	Lagos	2024-07-07	Active
CUST0297	Gbenga	Musa	gbenga.musa513@gmail.com	Lagos	Lagos	2023-04-11	Active
CUST0298	Uche	Okorie	uche.okorie978@gmail.com	Lagos	Lagos	2023-12-01	Inactive
CUST0299	Chukwu	Babangida	chukwu.babangida234@gmail.com	Port Harcourt	Rivers	2024-03-18	Active
CUST0300	Chidi	Okorie	chidi.okorie303@gmail.com	Kano	Kano	2023-03-26	Active
CUST0301	Femi	Eze	femi.eze758@gmail.com	Port Harcourt	Rivers	2023-04-04	Inactive
CUST0302	Uche	Nwosu	uche.nwosu105@yahoo.com	Abuja	FCT	2024-04-04	Active
CUST0303	Chidi	Obi	chidi.obi568@yahoo.com	Lagos	Lagos	2023-11-29	Active
CUST0304	Musa	Musa	musa.musa743@gmail.com	Lagos	Lagos	2023-09-06	Active
CUST0305	Bisi	Eze	bisi.eze276@gmail.com	Kano	Kano	2023-03-06	Active
CUST0306	Ada	Musa	ada.musa370@yahoo.com	Abuja	FCT	2024-10-02	Active
CUST0307	Tunde	Oluwole	tunde.oluwole7@gmail.com	Abuja	FCT	2024-09-27	Active
CUST0308	Aisha	Okorie	aisha.okorie140@gmail.com	Abuja	FCT	2023-07-25	Active
CUST0309	Ibrahim	Oluwole	ibrahim.oluwole753@gmail.com	Ibadan	Oyo	2024-08-12	Active
CUST0310	Obinna	Chukwu	obinna.chukwu374@yahoo.com	Abuja	FCT	2024-08-29	Active
CUST0311	Tobi	Okafor	tobi.okafor976@gmail.com	Kano	Kano	2023-08-03	Active
CUST0312	Chidi	Adegoke	chidi.adegoke690@gmail.com	Port Harcourt	Rivers	2023-09-05	Active
CUST0313	Chioma	Chukwu	chioma.chukwu76@gmail.com	Port Harcourt	Rivers	2024-08-19	Active
CUST0314	Nkechi	Adegoke	nkechi.adegoke557@yahoo.com	Ibadan	Oyo	2024-07-03	Active
CUST0315	Funmi	Obi	funmi.obi171@gmail.com	Lagos	Lagos	2024-10-22	Active
CUST0316	Ibrahim	Adegoke	ibrahim.adegoke109@yahoo.com	Ibadan	Oyo	2024-06-06	Active
CUST0317	Musa	Nnamdi	musa.nnamdi791@gmail.com	Abuja	FCT	2023-06-04	Active
CUST0318	Sade	Adegoke	sade.adegoke943@gmail.com	Abuja	FCT	2023-05-26	Active
CUST0319	Yemi	Lawal	yemi.lawal495@gmail.com	Abuja	FCT	2024-04-08	Active
CUST0320	Gbenga	Bello	gbenga.bello24@gmail.com	Lagos	Lagos	2024-11-24	Active
CUST0321	Bisi	Taiwo	bisi.taiwo164@gmail.com	Lagos	Lagos	2024-04-18	Active
CUST0322	Bisi	Adegoke	bisi.adegoke406@yahoo.com	Kano	Kano	2023-07-22	Active
CUST0323	Gbenga	Adeyemi	gbenga.adeyemi211@yahoo.com	Abuja	FCT	2023-03-06	Active
CUST0324	Yemi	Nnamdi	yemi.nnamdi117@yahoo.com	Abuja	FCT	2024-06-24	Active
CUST0325	Dayo	Chukwu	dayo.chukwu602@yahoo.com	Kano	Kano	2024-04-13	Active
CUST0326	Ayo	Musa	ayo.musa689@yahoo.com	Ibadan	Oyo	2023-11-09	Active
CUST0327	Segun	Chukwu	segun.chukwu429@gmail.com	Kano	Kano	2024-03-09	Active
CUST0328	Ada	Oluwole	ada.oluwole144@yahoo.com	Kano	Kano	2024-09-26	Inactive
CUST0329	Ada	Eze	ada.eze200@gmail.com	Ibadan	Oyo	2024-06-01	Active
CUST0330	Aisha	Nnamdi	aisha.nnamdi501@yahoo.com	Kano	Kano	2023-08-14	Active
CUST0331	Sade	Okonkwo	sade.okonkwo800@gmail.com	Lagos	Lagos	2024-05-22	Active
CUST0332	Kola	Taiwo	kola.taiwo844@gmail.com	Kano	Kano	2023-02-12	Active
CUST0333	Aisha	Bello	aisha.bello754@gmail.com	Abuja	FCT	2023-11-01	Active
CUST0334	Fatima	Musa	fatima.musa450@gmail.com	Abuja	FCT	2023-08-31	Active
CUST0335	Dayo	Adegoke	dayo.adegoke170@gmail.com	Ibadan	Oyo	2023-07-31	Active
CUST0336	Dayo	Taiwo	dayo.taiwo173@gmail.com	Abuja	FCT	2023-10-24	Active
CUST0337	Uche	Adegoke	uche.adegoke941@yahoo.com	Lagos	Lagos	2024-11-02	Active
CUST0338	Gbenga	Abubakar	gbenga.abubakar849@yahoo.com	Lagos	Lagos	2024-02-07	Active
CUST0339	Femi	Adegoke	femi.adegoke385@gmail.com	Kano	Kano	2023-04-06	Active
CUST0340	Oluwaseun	Obi	oluwaseun.obi466@gmail.com	Kano	Kano	2023-01-03	Active
CUST0341	Chukwu	Obi	chukwu.obi871@yahoo.com	Port Harcourt	Rivers	2023-08-12	Active
CUST0342	Ibrahim	Oluwole	ibrahim.oluwole346@gmail.com	Abuja	FCT	2024-05-11	Active
CUST0343	Femi	Nnamdi	femi.nnamdi17@yahoo.com	Lagos	Lagos	2024-03-27	Active
CUST0344	Gbenga	Eze	gbenga.eze904@gmail.com	Lagos	Lagos	2023-10-08	Active
CUST0345	Fatima	Okonkwo	fatima.okonkwo54@gmail.com	Lagos	Lagos	2023-08-28	Active
CUST0346	Emeka	Adeyemi	emeka.adeyemi489@yahoo.com	Port Harcourt	Rivers	2024-06-15	Active
CUST0347	Ibrahim	Bello	ibrahim.bello881@gmail.com	Lagos	Lagos	2023-03-14	Active
CUST0348	Amaka	Bello	amaka.bello321@gmail.com	Port Harcourt	Rivers	2024-01-27	Active
CUST0349	Lola	Eze	\N	Kano	Kano	2024-10-27	Active
CUST0350	Femi	Eze	femi.eze942@gmail.com	Port Harcourt	Rivers	2023-08-11	Active
CUST0351	Amaka	Fagbemi	amaka.fagbemi748@gmail.com	Lagos	Lagos	2023-11-19	Active
CUST0352	Chidi	Ibrahim	chidi.ibrahim567@gmail.com	Lagos	Lagos	2023-10-19	Active
CUST0353	Nkechi	Oluwole	nkechi.oluwole211@gmail.com	Lagos	Lagos	2024-02-06	Active
CUST0354	Chioma	Ibrahim	chioma.ibrahim507@gmail.com	Port Harcourt	Rivers	2024-10-15	Active
CUST0355	Emeka	Obi	emeka.obi957@gmail.com	Ibadan	Oyo	2024-08-05	Active
CUST0356	Uche	Musa	\N	Port Harcourt	Rivers	2023-08-09	Inactive
CUST0357	Musa	Lawal	musa.lawal294@gmail.com	Ibadan	Oyo	2024-03-01	Active
CUST0358	Tobi	Taiwo	tobi.taiwo631@yahoo.com	Lagos	Lagos	2023-03-22	Active
CUST0359	Tunde	Taiwo	tunde.taiwo335@gmail.com	Ibadan	Oyo	2024-10-27	Active
CUST0360	Aisha	Ibrahim	aisha.ibrahim60@yahoo.com	Lagos	Lagos	2023-04-29	Active
CUST0361	Lola	Okonkwo	lola.okonkwo123@yahoo.com	Lagos	Lagos	2023-01-12	Active
CUST0362	Chioma	Nwosu	chioma.nwosu171@gmail.com	Abuja	FCT	2023-10-03	Active
CUST0363	Emeka	Abubakar	emeka.abubakar827@gmail.com	Port Harcourt	Rivers	2023-09-27	Active
CUST0364	Ada	Nnamdi	ada.nnamdi524@gmail.com	Kano	Kano	2024-08-03	Active
CUST0365	Amaka	Fagbemi	amaka.fagbemi691@gmail.com	Lagos	Lagos	2024-06-05	Inactive
CUST0366	Ada	Obi	ada.obi393@gmail.com	Lagos	Lagos	2023-02-06	Active
CUST0367	Aisha	Ibrahim	aisha.ibrahim330@yahoo.com	Port Harcourt	Rivers	2023-11-24	Active
CUST0368	Amaka	Lawal	amaka.lawal690@gmail.com	Kano	Kano	2024-06-12	Active
CUST0369	Chukwu	Oluwole	chukwu.oluwole793@gmail.com	Lagos	Lagos	2024-07-20	Active
CUST0370	Ayo	Oluwole	ayo.oluwole758@gmail.com	Lagos	Lagos	2024-08-28	Active
CUST0371	Tobi	Ibrahim	tobi.ibrahim155@yahoo.com	Port Harcourt	Rivers	2023-08-27	Active
CUST0372	Emeka	Chukwu	emeka.chukwu870@gmail.com	Ibadan	Oyo	2023-07-30	Active
CUST0373	Ngozi	Eze	ngozi.eze729@yahoo.com	Abuja	FCT	2023-08-26	Active
CUST0374	Fatima	Nnamdi	fatima.nnamdi998@gmail.com	Port Harcourt	Rivers	2024-06-01	Active
CUST0375	Ayo	Adeleke	ayo.adeleke446@gmail.com	Lagos	Lagos	2023-10-26	Active
CUST0376	Musa	Abubakar	musa.abubakar326@gmail.com	Ibadan	Oyo	2023-07-27	Active
CUST0377	Bisi	Nnamdi	bisi.nnamdi478@gmail.com	Lagos	Lagos	2024-01-02	Active
CUST0378	Chukwu	Nwosu	chukwu.nwosu873@yahoo.com	Abuja	FCT	2023-11-08	Active
CUST0379	Nkechi	Abubakar	nkechi.abubakar152@yahoo.com	Lagos	Lagos	2023-12-31	Active
CUST0380	Kola	Okonkwo	kola.okonkwo32@gmail.com	Kano	Kano	2024-07-23	Active
CUST0381	Amaka	Eze	amaka.eze125@yahoo.com	Lagos	Lagos	2023-08-16	Active
CUST0382	Femi	Musa	femi.musa597@gmail.com	Abuja	FCT	2023-03-18	Inactive
CUST0383	Femi	Nnamdi	femi.nnamdi829@yahoo.com	Lagos	Lagos	2023-12-06	Active
CUST0384	Blessing	Fagbemi	blessing.fagbemi444@gmail.com	Lagos	Lagos	2023-01-31	Active
CUST0385	Yemi	Okonkwo	yemi.okonkwo282@yahoo.com	Lagos	Lagos	2023-02-05	Active
CUST0386	Sade	Babangida	sade.babangida422@gmail.com	Lagos	Lagos	2023-03-31	Active
CUST0387	Femi	Lawal	femi.lawal256@gmail.com	Abuja	FCT	2023-01-20	Active
CUST0388	Chioma	Babangida	chioma.babangida353@gmail.com	Abuja	FCT	2024-02-02	Active
CUST0389	Funmi	Okafor	funmi.okafor918@gmail.com	Lagos	Lagos	2024-04-28	Active
CUST0390	Bisi	Bello	bisi.bello254@gmail.com	Ibadan	Oyo	2023-02-27	Active
CUST0391	Chioma	Chukwu	chioma.chukwu364@gmail.com	Kano	Kano	2023-06-27	Active
CUST0392	Gbenga	Obi	gbenga.obi936@gmail.com	Port Harcourt	Rivers	2023-12-27	Active
CUST0393	Yemi	Babangida	yemi.babangida556@gmail.com	Lagos	Lagos	2023-04-03	Inactive
CUST0394	Segun	Babangida	segun.babangida1@gmail.com	Lagos	Lagos	2023-05-14	Active
CUST0395	Nkechi	Abubakar	nkechi.abubakar61@yahoo.com	Ibadan	Oyo	2023-05-26	Active
CUST0396	Fatima	Chukwu	fatima.chukwu601@yahoo.com	Ibadan	Oyo	2023-05-20	Active
CUST0397	Ada	Abubakar	ada.abubakar179@gmail.com	Port Harcourt	Rivers	2024-09-20	Active
CUST0398	Obinna	Okonkwo	obinna.okonkwo388@gmail.com	Kano	Kano	2023-05-11	Active
CUST0399	Ayo	Chukwu	ayo.chukwu872@gmail.com	Ibadan	Oyo	2023-02-03	Active
CUST0400	Dayo	Ibrahim	dayo.ibrahim655@gmail.com	Ibadan	Oyo	2023-05-25	Active
CUST0401	Ibrahim	Okonkwo	ibrahim.okonkwo652@gmail.com	Lagos	Lagos	2024-11-17	Active
CUST0402	Kola	Adeyemi	kola.adeyemi256@gmail.com	Abuja	FCT	2023-04-21	Active
CUST0403	Titi	Adegoke	titi.adegoke993@yahoo.com	Abuja	FCT	2024-01-23	Active
CUST0404	Ada	Fagbemi	ada.fagbemi667@gmail.com	Lagos	Lagos	2024-04-07	Inactive
CUST0405	Ibrahim	Nwosu	ibrahim.nwosu975@yahoo.com	Lagos	Lagos	2024-01-20	Active
CUST0406	Oluwaseun	Musa	oluwaseun.musa347@gmail.com	Abuja	FCT	2024-05-09	Active
CUST0407	Bisi	Okorie	bisi.okorie912@gmail.com	Ibadan	Oyo	2023-12-06	Active
CUST0408	Tobi	Taiwo	tobi.taiwo272@gmail.com	Abuja	FCT	2023-04-09	Inactive
CUST0409	Fatima	Okafor	fatima.okafor438@yahoo.com	Lagos	Lagos	2024-10-02	Active
CUST0410	Yemi	Okonkwo	yemi.okonkwo654@yahoo.com	Lagos	Lagos	2023-04-29	Active
CUST0411	Oluwaseun	Nwosu	oluwaseun.nwosu94@gmail.com	Abuja	FCT	2024-01-15	Active
CUST0412	Ngozi	Nwosu	ngozi.nwosu451@gmail.com	Lagos	Lagos	2023-10-03	Active
CUST0413	Lola	Bello	lola.bello88@gmail.com	Port Harcourt	Rivers	2024-02-28	Active
CUST0414	Ngozi	Chukwu	ngozi.chukwu839@gmail.com	Lagos	Lagos	2024-05-01	Active
CUST0415	Chidi	Chukwu	chidi.chukwu925@gmail.com	Abuja	FCT	2024-08-07	Active
CUST0416	Uche	Nnamdi	uche.nnamdi178@gmail.com	Lagos	Lagos	2023-08-05	Active
CUST0417	Chidi	Adegoke	chidi.adegoke207@gmail.com	Lagos	Lagos	2024-09-01	Active
CUST0418	Chidi	Musa	chidi.musa398@gmail.com	Ibadan	Oyo	2023-10-10	Active
CUST0419	Dayo	Fagbemi	dayo.fagbemi536@gmail.com	Port Harcourt	Rivers	2023-06-03	Active
CUST0420	Amaka	Bello	amaka.bello577@gmail.com	Kano	Kano	2024-07-02	Active
CUST0421	Femi	Babangida	femi.babangida586@gmail.com	Lagos	Lagos	2023-10-10	Active
CUST0422	Gbenga	Chukwu	gbenga.chukwu40@gmail.com	Kano	Kano	2023-09-01	Inactive
CUST0423	Oluwaseun	Obi	oluwaseun.obi21@gmail.com	Ibadan	Oyo	2023-11-15	Active
CUST0424	Lola	Bello	lola.bello996@gmail.com	Ibadan	Oyo	2024-03-29	Active
CUST0425	Aisha	Okorie	aisha.okorie662@yahoo.com	Lagos	Lagos	2024-02-21	Active
CUST0426	Obinna	Adeleke	obinna.adeleke528@gmail.com	Ibadan	Oyo	2024-06-02	Active
CUST0427	Oluwaseun	Adeyemi	oluwaseun.adeyemi858@yahoo.com	Lagos	Lagos	2023-02-21	Active
CUST0428	Fatima	Nnamdi	fatima.nnamdi518@gmail.com	Lagos	Lagos	2024-11-28	Inactive
CUST0429	Chukwu	Okonkwo	chukwu.okonkwo984@gmail.com	Abuja	FCT	2023-12-25	Active
CUST0430	Gbenga	Musa	gbenga.musa292@yahoo.com	Port Harcourt	Rivers	2024-08-08	Active
CUST0431	Femi	Ibrahim	femi.ibrahim694@yahoo.com	Ibadan	Oyo	2024-06-09	Inactive
CUST0432	Tunde	Okonkwo	tunde.okonkwo616@gmail.com	Abuja	FCT	2024-09-14	Active
CUST0433	Gbenga	Nwosu	gbenga.nwosu434@gmail.com	Port Harcourt	Rivers	2024-04-15	Active
CUST0434	Segun	Okorie	\N	Lagos	Lagos	2024-11-09	Active
CUST0435	Dayo	Okorie	dayo.okorie290@yahoo.com	Kano	Kano	2023-03-07	Active
CUST0436	Nkechi	Nwosu	nkechi.nwosu268@gmail.com	Kano	Kano	2024-10-29	Active
CUST0437	Funmi	Adeleke	funmi.adeleke825@gmail.com	Abuja	FCT	2024-02-18	Active
CUST0438	Femi	Babangida	femi.babangida303@yahoo.com	Port Harcourt	Rivers	2024-02-02	Active
CUST0439	Ayo	Adeyemi	ayo.adeyemi352@gmail.com	Port Harcourt	Rivers	2024-07-01	Active
CUST0440	Lola	Obi	lola.obi520@gmail.com	Ibadan	Oyo	2024-11-04	Active
CUST0441	Ada	Eze	ada.eze759@yahoo.com	Lagos	Lagos	2023-07-07	Active
CUST0442	Funmi	Obi	funmi.obi229@gmail.com	Kano	Kano	2023-12-06	Active
CUST0443	Amaka	Babangida	amaka.babangida55@gmail.com	Abuja	FCT	2024-09-27	Inactive
CUST0444	Nkechi	Chukwu	nkechi.chukwu543@yahoo.com	Abuja	FCT	2023-06-04	Active
CUST0445	Ayo	Nnamdi	ayo.nnamdi147@gmail.com	Lagos	Lagos	2023-03-24	Active
CUST0446	Ibrahim	Adeleke	ibrahim.adeleke5@gmail.com	Ibadan	Oyo	2023-06-22	Active
CUST0447	Uche	Musa	uche.musa133@gmail.com	Abuja	FCT	2024-02-18	Active
CUST0448	Ngozi	Taiwo	ngozi.taiwo205@gmail.com	Abuja	FCT	2023-11-26	Active
CUST0449	Emeka	Ibrahim	emeka.ibrahim232@gmail.com	Lagos	Lagos	2023-05-13	Active
CUST0450	Bisi	Musa	bisi.musa844@yahoo.com	Kano	Kano	2024-04-11	Active
CUST0451	Lola	Eze	lola.eze351@gmail.com	Abuja	FCT	2023-07-12	Active
CUST0452	Funmi	Eze	funmi.eze217@gmail.com	Lagos	Lagos	2023-06-23	Active
CUST0453	Ngozi	Chukwu	ngozi.chukwu898@gmail.com	Kano	Kano	2024-09-30	Inactive
CUST0454	Femi	Okafor	femi.okafor50@gmail.com	Kano	Kano	2024-01-25	Active
CUST0455	Tunde	Adeyemi	\N	Abuja	FCT	2024-03-06	Active
CUST0456	Gbenga	Eze	gbenga.eze429@gmail.com	Kano	Kano	2024-09-24	Active
CUST0457	Ada	Adeyemi	ada.adeyemi624@yahoo.com	Port Harcourt	Rivers	2024-06-19	Active
CUST0458	Sade	Okonkwo	sade.okonkwo41@gmail.com	Port Harcourt	Rivers	2024-05-07	Active
CUST0459	Chidi	Bello	chidi.bello856@gmail.com	Lagos	Lagos	2023-04-03	Active
CUST0460	Amaka	Nwosu	amaka.nwosu660@yahoo.com	Port Harcourt	Rivers	2023-10-31	Active
CUST0461	Bisi	Adeleke	bisi.adeleke873@yahoo.com	Lagos	Lagos	2023-11-17	Active
CUST0462	Uche	Adeleke	uche.adeleke10@gmail.com	Lagos	Lagos	2023-06-24	Active
CUST0463	Kola	Musa	kola.musa382@gmail.com	Ibadan	Oyo	2024-02-15	Active
CUST0464	Musa	Babangida	musa.babangida820@gmail.com	Lagos	Lagos	2023-06-20	Active
CUST0465	Nkechi	Okonkwo	nkechi.okonkwo107@gmail.com	Port Harcourt	Rivers	2024-08-05	Active
CUST0466	Uche	Obi	uche.obi627@yahoo.com	Kano	Kano	2023-05-14	Active
CUST0467	Aisha	Nnamdi	aisha.nnamdi48@yahoo.com	Lagos	Lagos	2023-01-13	Active
CUST0468	Titi	Fagbemi	titi.fagbemi742@gmail.com	Abuja	FCT	2024-11-16	Active
CUST0469	Titi	Ibrahim	titi.ibrahim494@gmail.com	Abuja	FCT	2024-01-30	Active
CUST0628	Funmi	Eze	funmi.eze52@gmail.com	Abuja	FCT	2024-04-01	Active
CUST0470	Blessing	Okonkwo	blessing.okonkwo518@gmail.com	Lagos	Lagos	2023-06-19	Inactive
CUST0471	Ibrahim	Nwosu	ibrahim.nwosu52@gmail.com	Lagos	Lagos	2024-01-23	Active
CUST0472	Chukwu	Fagbemi	chukwu.fagbemi459@yahoo.com	Lagos	Lagos	2023-11-20	Active
CUST0473	Emeka	Bello	emeka.bello414@gmail.com	Port Harcourt	Rivers	2023-01-01	Active
CUST0474	Femi	Oluwole	femi.oluwole912@gmail.com	Ibadan	Oyo	2024-11-18	Active
CUST0475	Ngozi	Ibrahim	ngozi.ibrahim865@gmail.com	Abuja	FCT	2024-09-26	Active
CUST0476	Amaka	Bello	\N	Port Harcourt	Rivers	2023-12-30	Active
CUST0477	Fatima	Bello	fatima.bello47@gmail.com	Abuja	FCT	2024-02-24	Active
CUST0478	Blessing	Chukwu	blessing.chukwu221@gmail.com	Lagos	Lagos	2023-12-13	Active
CUST0479	Femi	Fagbemi	femi.fagbemi127@gmail.com	Lagos	Lagos	2024-11-05	Active
CUST0480	Ada	Okafor	ada.okafor544@gmail.com	Lagos	Lagos	2024-03-19	Active
CUST0481	Uche	Okonkwo	uche.okonkwo709@gmail.com	Ibadan	Oyo	2023-05-12	Active
CUST0482	Musa	Adegoke	musa.adegoke624@gmail.com	Abuja	FCT	2023-10-08	Active
CUST0483	Chukwu	Eze	chukwu.eze142@gmail.com	Ibadan	Oyo	2024-06-08	Active
CUST0484	Blessing	Taiwo	blessing.taiwo648@yahoo.com	Port Harcourt	Rivers	2023-10-25	Active
CUST0485	Femi	Okonkwo	femi.okonkwo516@gmail.com	Ibadan	Oyo	2023-04-29	Active
CUST0486	Lola	Adegoke	lola.adegoke691@gmail.com	Kano	Kano	2023-10-20	Active
CUST0487	Segun	Bello	segun.bello26@gmail.com	Port Harcourt	Rivers	2023-02-27	Active
CUST0488	Lola	Nwosu	lola.nwosu150@gmail.com	Ibadan	Oyo	2023-10-30	Active
CUST0489	Chukwu	Bello	chukwu.bello631@gmail.com	Abuja	FCT	2023-08-18	Active
CUST0490	Chioma	Oluwole	chioma.oluwole710@gmail.com	Lagos	Lagos	2024-02-01	Active
CUST0491	Tobi	Adeleke	tobi.adeleke14@gmail.com	Lagos	Lagos	2024-03-29	Active
CUST0492	Femi	Obi	femi.obi774@gmail.com	Port Harcourt	Rivers	2023-07-21	Active
CUST0493	Bisi	Musa	bisi.musa192@gmail.com	Lagos	Lagos	2023-05-03	Active
CUST0494	Kola	Eze	kola.eze165@gmail.com	Lagos	Lagos	2023-12-05	Active
CUST0495	Blessing	Abubakar	blessing.abubakar612@yahoo.com	Lagos	Lagos	2024-09-22	Active
CUST0496	Ayo	Taiwo	ayo.taiwo367@yahoo.com	Abuja	FCT	2024-06-22	Active
CUST0497	Chioma	Lawal	chioma.lawal164@gmail.com	Abuja	FCT	2023-04-05	Active
CUST0498	Ibrahim	Obi	ibrahim.obi301@yahoo.com	Kano	Kano	2024-06-27	Active
CUST0499	Fatima	Nnamdi	fatima.nnamdi247@gmail.com	Lagos	Lagos	2024-09-28	Active
CUST0500	Ibrahim	Chukwu	ibrahim.chukwu938@gmail.com	Kano	Kano	2023-09-20	Active
CUST0501	Segun	Obi	segun.obi527@gmail.com	Lagos	Lagos	2023-02-14	Active
CUST0502	Segun	Musa	segun.musa971@yahoo.com	Lagos	Lagos	2024-07-04	Active
CUST0503	Lola	Adeyemi	lola.adeyemi886@gmail.com	Lagos	Lagos	2023-07-30	Active
CUST0504	Titi	Adegoke	titi.adegoke663@gmail.com	Ibadan	Oyo	2023-06-07	Inactive
CUST0505	Chidi	Adeleke	chidi.adeleke183@gmail.com	Lagos	Lagos	2024-08-11	Active
CUST0506	Chukwu	Chukwu	chukwu.chukwu444@gmail.com	Abuja	FCT	2023-05-02	Active
CUST0507	Ayo	Adeleke	ayo.adeleke718@gmail.com	Port Harcourt	Rivers	2024-05-29	Active
CUST0508	Sade	Nnamdi	sade.nnamdi391@gmail.com	Kano	Kano	2024-04-30	Active
CUST0509	Musa	Taiwo	musa.taiwo303@gmail.com	Lagos	Lagos	2024-11-24	Active
CUST0510	Emeka	Taiwo	emeka.taiwo896@gmail.com	Kano	Kano	2023-01-06	Active
CUST0511	Chidi	Oluwole	chidi.oluwole216@gmail.com	Abuja	FCT	2023-12-19	Active
CUST0512	Funmi	Okorie	funmi.okorie855@yahoo.com	Lagos	Lagos	2024-11-18	Active
CUST0513	Blessing	Taiwo	blessing.taiwo473@gmail.com	Ibadan	Oyo	2024-11-18	Inactive
CUST0514	Ayo	Babangida	ayo.babangida975@gmail.com	Lagos	Lagos	2024-11-02	Active
CUST0515	Oluwaseun	Adeyemi	oluwaseun.adeyemi326@gmail.com	Kano	Kano	2024-11-06	Active
CUST0516	Fatima	Abubakar	\N	Kano	Kano	2023-09-10	Active
CUST0517	Fatima	Eze	fatima.eze696@gmail.com	Lagos	Lagos	2024-04-18	Active
CUST0518	Amaka	Okonkwo	amaka.okonkwo662@gmail.com	Abuja	FCT	2023-05-24	Active
CUST0519	Oluwaseun	Musa	\N	Lagos	Lagos	2024-06-03	Active
CUST0520	Uche	Fagbemi	uche.fagbemi218@gmail.com	Kano	Kano	2024-07-10	Active
CUST0521	Tunde	Obi	tunde.obi402@yahoo.com	Kano	Kano	2023-10-25	Active
CUST0522	Segun	Okafor	segun.okafor679@yahoo.com	Abuja	FCT	2024-09-20	Active
CUST0523	Bisi	Fagbemi	bisi.fagbemi972@gmail.com	Abuja	FCT	2023-05-30	Active
CUST0524	Ngozi	Ibrahim	ngozi.ibrahim780@gmail.com	Ibadan	Oyo	2024-01-14	Active
CUST0525	Chioma	Obi	chioma.obi398@gmail.com	Abuja	FCT	2023-02-17	Inactive
CUST0526	Segun	Nwosu	segun.nwosu855@gmail.com	Lagos	Lagos	2024-08-06	Active
CUST0527	Ayo	Musa	ayo.musa530@yahoo.com	Abuja	FCT	2023-08-17	Active
CUST0528	Fatima	Babangida	fatima.babangida812@gmail.com	Port Harcourt	Rivers	2024-05-28	Active
CUST0529	Chidi	Lawal	chidi.lawal659@yahoo.com	Lagos	Lagos	2023-06-11	Active
CUST0530	Lola	Ibrahim	lola.ibrahim425@gmail.com	Port Harcourt	Rivers	2024-05-08	Active
CUST0531	Bisi	Adegoke	bisi.adegoke23@yahoo.com	Lagos	Lagos	2024-08-29	Active
CUST0532	Oluwaseun	Fagbemi	oluwaseun.fagbemi151@yahoo.com	Abuja	FCT	2023-07-04	Active
CUST0533	Ayo	Okafor	ayo.okafor900@gmail.com	Kano	Kano	2023-10-18	Active
CUST0534	Ada	Babangida	ada.babangida175@yahoo.com	Abuja	FCT	2023-05-27	Active
CUST0535	Segun	Nwosu	segun.nwosu172@gmail.com	Kano	Kano	2024-04-09	Active
CUST0536	Musa	Eze	musa.eze112@yahoo.com	Lagos	Lagos	2024-05-31	Active
CUST0537	Bisi	Babangida	bisi.babangida924@gmail.com	Kano	Kano	2024-06-28	Active
CUST0538	Lola	Eze	lola.eze924@gmail.com	Lagos	Lagos	2024-11-25	Active
CUST0539	Nkechi	Adeleke	nkechi.adeleke715@gmail.com	Abuja	FCT	2024-05-08	Active
CUST0540	Chioma	Fagbemi	chioma.fagbemi101@gmail.com	Abuja	FCT	2023-08-27	Active
CUST0541	Oluwaseun	Taiwo	\N	Lagos	Lagos	2023-01-08	Active
CUST0542	Musa	Adeyemi	musa.adeyemi705@gmail.com	Abuja	FCT	2023-04-20	Active
CUST0543	Tobi	Adegoke	tobi.adegoke579@gmail.com	Lagos	Lagos	2024-11-27	Active
CUST0544	Chioma	Taiwo	chioma.taiwo495@yahoo.com	Abuja	FCT	2024-05-10	Active
CUST0545	Uche	Chukwu	uche.chukwu754@yahoo.com	Kano	Kano	2023-05-02	Active
CUST0546	Bisi	Bello	bisi.bello220@gmail.com	Port Harcourt	Rivers	2024-07-17	Active
CUST0547	Femi	Okafor	femi.okafor824@yahoo.com	Lagos	Lagos	2024-09-06	Active
CUST0548	Fatima	Musa	fatima.musa624@yahoo.com	Lagos	Lagos	2024-02-15	Active
CUST0549	Dayo	Adeleke	dayo.adeleke969@gmail.com	Lagos	Lagos	2024-05-21	Active
CUST0550	Blessing	Lawal	blessing.lawal293@yahoo.com	Ibadan	Oyo	2024-06-06	Active
CUST0552	Fatima	Chukwu	fatima.chukwu416@gmail.com	Port Harcourt	Rivers	2023-03-12	Active
CUST0553	Obinna	Taiwo	obinna.taiwo937@gmail.com	Lagos	Lagos	2023-10-11	Active
CUST0554	Musa	Fagbemi	musa.fagbemi5@yahoo.com	Abuja	FCT	2023-04-20	Active
CUST0555	Amaka	Lawal	amaka.lawal980@yahoo.com	Lagos	Lagos	2024-08-11	Active
CUST0556	Ayo	Babangida	ayo.babangida789@yahoo.com	Ibadan	Oyo	2024-04-14	Active
CUST0557	Kola	Musa	kola.musa392@gmail.com	Abuja	FCT	2024-11-24	Active
CUST0558	Fatima	Lawal	fatima.lawal549@yahoo.com	Abuja	FCT	2023-09-12	Active
CUST0559	Obinna	Abubakar	obinna.abubakar78@gmail.com	Kano	Kano	2023-11-18	Active
CUST0560	Titi	Adeyemi	titi.adeyemi511@gmail.com	Lagos	Lagos	2023-09-05	Active
CUST0561	Obinna	Ibrahim	obinna.ibrahim857@gmail.com	Lagos	Lagos	2023-04-20	Active
CUST0562	Lola	Babangida	lola.babangida629@yahoo.com	Kano	Kano	2023-02-13	Active
CUST0563	Ada	Fagbemi	ada.fagbemi890@yahoo.com	Kano	Kano	2024-06-07	Active
CUST0564	Tunde	Adeleke	tunde.adeleke539@gmail.com	Port Harcourt	Rivers	2024-07-07	Inactive
CUST0565	Lola	Okonkwo	lola.okonkwo469@gmail.com	Abuja	FCT	2024-04-16	Active
CUST0566	Yemi	Chukwu	yemi.chukwu595@yahoo.com	Lagos	Lagos	2023-09-23	Active
CUST0567	Ada	Okorie	ada.okorie352@gmail.com	Lagos	Lagos	2023-08-04	Active
CUST0568	Musa	Nwosu	musa.nwosu462@yahoo.com	Abuja	FCT	2024-08-12	Active
CUST0569	Chioma	Ibrahim	chioma.ibrahim569@gmail.com	Port Harcourt	Rivers	2023-05-30	Active
CUST0570	Emeka	Okonkwo	emeka.okonkwo432@gmail.com	Abuja	FCT	2024-10-07	Active
CUST0571	Sade	Nwosu	sade.nwosu576@gmail.com	Port Harcourt	Rivers	2023-04-12	Active
CUST0572	Kola	Babangida	kola.babangida860@gmail.com	Lagos	Lagos	2023-12-09	Active
CUST0573	Blessing	Nwosu	blessing.nwosu353@yahoo.com	Kano	Kano	2024-11-26	Active
CUST0574	Femi	Taiwo	femi.taiwo179@gmail.com	Kano	Kano	2023-11-29	Active
CUST0575	Chukwu	Musa	chukwu.musa391@gmail.com	Port Harcourt	Rivers	2023-05-29	Active
CUST0576	Dayo	Fagbemi	dayo.fagbemi415@gmail.com	Abuja	FCT	2023-06-15	Active
CUST0577	Sade	Nwosu	sade.nwosu620@gmail.com	Lagos	Lagos	2024-03-31	Active
CUST0578	Segun	Nnamdi	segun.nnamdi424@yahoo.com	Port Harcourt	Rivers	2023-05-09	Active
CUST0579	Gbenga	Musa	gbenga.musa216@yahoo.com	Ibadan	Oyo	2023-03-07	Active
CUST0580	Emeka	Chukwu	emeka.chukwu537@gmail.com	Abuja	FCT	2023-09-26	Active
CUST0581	Oluwaseun	Chukwu	oluwaseun.chukwu317@yahoo.com	Kano	Kano	2024-03-29	Active
CUST0582	Bisi	Okafor	bisi.okafor36@gmail.com	Abuja	FCT	2023-11-30	Active
CUST0583	Tobi	Nwosu	tobi.nwosu562@gmail.com	Ibadan	Oyo	2024-07-06	Active
CUST0584	Femi	Fagbemi	femi.fagbemi446@gmail.com	Kano	Kano	2023-11-14	Active
CUST0585	Chioma	Musa	chioma.musa453@gmail.com	Abuja	FCT	2023-06-09	Active
CUST0586	Uche	Eze	uche.eze353@yahoo.com	Abuja	FCT	2024-05-18	Active
CUST0587	Uche	Adegoke	uche.adegoke818@yahoo.com	Lagos	Lagos	2023-01-08	Active
CUST0588	Tobi	Adegoke	tobi.adegoke405@yahoo.com	Abuja	FCT	2024-10-23	Active
CUST0589	Chidi	Adegoke	chidi.adegoke641@yahoo.com	Lagos	Lagos	2024-09-19	Active
CUST0590	Femi	Taiwo	femi.taiwo829@yahoo.com	Lagos	Lagos	2023-03-12	Active
CUST0591	Chukwu	Okorie	chukwu.okorie464@yahoo.com	Lagos	Lagos	2023-07-12	Active
CUST0592	Tobi	Okafor	tobi.okafor191@gmail.com	Lagos	Lagos	2023-05-09	Active
CUST0593	Chidi	Eze	chidi.eze16@gmail.com	Lagos	Lagos	2023-11-16	Active
CUST0594	Chukwu	Adeleke	chukwu.adeleke339@yahoo.com	Ibadan	Oyo	2023-05-30	Inactive
CUST0595	Ada	Okonkwo	ada.okonkwo197@gmail.com	Lagos	Lagos	2024-01-26	Active
CUST0596	Gbenga	Ibrahim	gbenga.ibrahim395@gmail.com	Ibadan	Oyo	2023-02-04	Active
CUST0597	Yemi	Babangida	yemi.babangida399@gmail.com	Abuja	FCT	2023-11-27	Active
CUST0598	Tobi	Lawal	tobi.lawal126@yahoo.com	Port Harcourt	Rivers	2023-07-23	Active
CUST0599	Yemi	Bello	yemi.bello242@gmail.com	Ibadan	Oyo	2023-06-21	Active
CUST0600	Funmi	Okafor	funmi.okafor993@yahoo.com	Abuja	FCT	2024-05-01	Active
CUST0601	Chidi	Ibrahim	chidi.ibrahim162@gmail.com	Abuja	FCT	2023-12-13	Active
CUST0602	Femi	Eze	femi.eze719@gmail.com	Lagos	Lagos	2024-05-14	Active
CUST0603	Uche	Obi	uche.obi825@gmail.com	Port Harcourt	Rivers	2023-01-22	Active
CUST0604	Kola	Adeleke	kola.adeleke497@gmail.com	Port Harcourt	Rivers	2024-07-09	Active
CUST0605	Tobi	Obi	tobi.obi332@gmail.com	Kano	Kano	2024-09-05	Active
CUST0606	Tunde	Nnamdi	tunde.nnamdi303@gmail.com	Lagos	Lagos	2024-04-09	Inactive
CUST0607	Titi	Okonkwo	titi.okonkwo905@yahoo.com	Abuja	FCT	2024-09-27	Active
CUST0608	Tobi	Chukwu	tobi.chukwu195@gmail.com	Kano	Kano	2024-07-18	Active
CUST0609	Femi	Abubakar	femi.abubakar114@yahoo.com	Lagos	Lagos	2023-02-14	Active
CUST0610	Ngozi	Adeyemi	ngozi.adeyemi110@gmail.com	Lagos	Lagos	2024-08-07	Active
CUST0611	Segun	Okorie	segun.okorie719@gmail.com	Kano	Kano	2023-08-15	Active
CUST0612	Blessing	Adeyemi	blessing.adeyemi672@gmail.com	Lagos	Lagos	2023-03-23	Active
CUST0613	Tobi	Adegoke	tobi.adegoke842@gmail.com	Lagos	Lagos	2024-09-23	Active
CUST0614	Obinna	Oluwole	obinna.oluwole80@gmail.com	Port Harcourt	Rivers	2023-04-10	Active
CUST0615	Yemi	Adeyemi	yemi.adeyemi539@gmail.com	Abuja	FCT	2023-07-03	Active
CUST0616	Uche	Fagbemi	uche.fagbemi367@gmail.com	Port Harcourt	Rivers	2024-03-13	Active
CUST0617	Tobi	Chukwu	tobi.chukwu517@gmail.com	Port Harcourt	Rivers	2024-09-06	Active
CUST0618	Tobi	Abubakar	tobi.abubakar866@gmail.com	Ibadan	Oyo	2024-03-16	Active
CUST0619	Ayo	Taiwo	ayo.taiwo220@gmail.com	Kano	Kano	2023-09-18	Active
CUST0620	Musa	Okafor	musa.okafor744@yahoo.com	Abuja	FCT	2023-01-17	Active
CUST0621	Funmi	Adeyemi	funmi.adeyemi877@gmail.com	Lagos	Lagos	2023-10-10	Active
CUST0622	Blessing	Fagbemi	blessing.fagbemi159@yahoo.com	Kano	Kano	2023-06-09	Active
CUST0623	Funmi	Ibrahim	funmi.ibrahim263@gmail.com	Ibadan	Oyo	2024-02-14	Active
CUST0624	Titi	Abubakar	titi.abubakar812@gmail.com	Port Harcourt	Rivers	2024-08-13	Active
CUST0625	Sade	Adeleke	sade.adeleke749@gmail.com	Kano	Kano	2023-02-27	Active
CUST0626	Obinna	Adegoke	obinna.adegoke427@gmail.com	Lagos	Lagos	2023-08-21	Active
CUST0627	Femi	Chukwu	femi.chukwu56@gmail.com	Ibadan	Oyo	2024-07-06	Active
CUST0629	Sade	Chukwu	sade.chukwu152@yahoo.com	Lagos	Lagos	2024-08-08	Active
CUST0630	Chidi	Chukwu	chidi.chukwu514@gmail.com	Abuja	FCT	2023-05-19	Active
CUST0631	Femi	Fagbemi	femi.fagbemi201@gmail.com	Abuja	FCT	2024-06-20	Active
CUST0632	Aisha	Abubakar	aisha.abubakar702@gmail.com	Lagos	Lagos	2024-11-18	Active
CUST0633	Ibrahim	Obi	ibrahim.obi609@gmail.com	Lagos	Lagos	2023-06-23	Active
CUST0634	Chioma	Nnamdi	chioma.nnamdi639@yahoo.com	Port Harcourt	Rivers	2023-08-28	Active
CUST0635	Titi	Musa	titi.musa116@gmail.com	Lagos	Lagos	2024-09-27	Active
CUST0636	Gbenga	Bello	\N	Lagos	Lagos	2023-08-03	Active
CUST0637	Segun	Nwosu	segun.nwosu562@gmail.com	Lagos	Lagos	2023-05-25	Active
CUST0638	Ayo	Lawal	ayo.lawal45@yahoo.com	Lagos	Lagos	2023-07-25	Active
CUST0639	Chukwu	Okafor	chukwu.okafor69@gmail.com	Lagos	Lagos	2024-11-06	Active
CUST0640	Nkechi	Chukwu	nkechi.chukwu237@gmail.com	Lagos	Lagos	2023-04-12	Active
CUST0641	Tobi	Musa	tobi.musa191@yahoo.com	Ibadan	Oyo	2024-07-28	Active
CUST0642	Blessing	Lawal	blessing.lawal313@gmail.com	Lagos	Lagos	2023-06-10	Inactive
CUST0643	Femi	Oluwole	femi.oluwole242@gmail.com	Abuja	FCT	2023-10-10	Active
CUST0644	Oluwaseun	Okafor	oluwaseun.okafor967@gmail.com	Ibadan	Oyo	2023-06-05	Active
CUST0645	Chidi	Chukwu	chidi.chukwu534@gmail.com	Kano	Kano	2024-10-02	Active
CUST0646	Tunde	Adegoke	tunde.adegoke994@gmail.com	Lagos	Lagos	2024-04-04	Active
CUST0647	Ayo	Taiwo	ayo.taiwo701@gmail.com	Kano	Kano	2023-11-13	Active
CUST0648	Blessing	Eze	blessing.eze672@gmail.com	Abuja	FCT	2023-11-22	Inactive
CUST0649	Obinna	Eze	obinna.eze745@yahoo.com	Lagos	Lagos	2024-02-28	Active
CUST0650	Blessing	Nwosu	blessing.nwosu156@gmail.com	Abuja	FCT	2023-07-09	Inactive
CUST0651	Dayo	Ibrahim	dayo.ibrahim611@yahoo.com	Kano	Kano	2024-01-03	Inactive
CUST0652	Nkechi	Okorie	nkechi.okorie481@gmail.com	Lagos	Lagos	2024-02-01	Active
CUST0653	Funmi	Adeleke	\N	Lagos	Lagos	2023-10-04	Active
CUST0654	Yemi	Adeyemi	yemi.adeyemi68@yahoo.com	Port Harcourt	Rivers	2024-03-25	Active
CUST0655	Nkechi	Nnamdi	nkechi.nnamdi909@yahoo.com	Kano	Kano	2023-02-12	Active
CUST0656	Musa	Okorie	musa.okorie962@gmail.com	Port Harcourt	Rivers	2024-06-21	Active
CUST0657	Chukwu	Nnamdi	chukwu.nnamdi847@gmail.com	Abuja	FCT	2023-09-09	Active
CUST0658	Ngozi	Taiwo	ngozi.taiwo397@gmail.com	Ibadan	Oyo	2023-02-20	Active
CUST0659	Sade	Oluwole	sade.oluwole473@yahoo.com	Abuja	FCT	2023-02-25	Active
CUST0660	Femi	Nnamdi	femi.nnamdi93@gmail.com	Abuja	FCT	2024-08-22	Active
CUST0661	Ibrahim	Nnamdi	ibrahim.nnamdi26@yahoo.com	Abuja	FCT	2023-07-26	Active
CUST0662	Gbenga	Okonkwo	gbenga.okonkwo736@gmail.com	Lagos	Lagos	2024-04-05	Active
CUST0663	Musa	Lawal	musa.lawal627@gmail.com	Abuja	FCT	2024-01-25	Inactive
CUST0664	Ayo	Eze	ayo.eze167@gmail.com	Ibadan	Oyo	2023-02-22	Active
CUST0665	Chukwu	Oluwole	chukwu.oluwole642@yahoo.com	Port Harcourt	Rivers	2023-07-27	Inactive
CUST0666	Ada	Babangida	ada.babangida557@gmail.com	Lagos	Lagos	2024-05-20	Active
CUST0667	Chukwu	Adegoke	chukwu.adegoke453@yahoo.com	Kano	Kano	2023-09-08	Active
CUST0668	Tobi	Adeyemi	tobi.adeyemi51@yahoo.com	Kano	Kano	2023-12-24	Inactive
CUST0669	Obinna	Okorie	obinna.okorie306@gmail.com	Kano	Kano	2023-04-22	Active
CUST0670	Sade	Okorie	sade.okorie677@gmail.com	Lagos	Lagos	2024-07-29	Active
CUST0671	Fatima	Adeleke	fatima.adeleke96@gmail.com	Port Harcourt	Rivers	2024-01-24	Active
CUST0672	Chidi	Oluwole	chidi.oluwole483@yahoo.com	Port Harcourt	Rivers	2023-10-09	Active
CUST0673	Gbenga	Adeyemi	gbenga.adeyemi627@yahoo.com	Abuja	FCT	2024-10-06	Active
CUST0674	Gbenga	Okorie	gbenga.okorie957@gmail.com	Abuja	FCT	2024-03-13	Active
CUST0675	Ayo	Okorie	ayo.okorie363@gmail.com	Lagos	Lagos	2024-05-23	Active
CUST0676	Chioma	Okonkwo	chioma.okonkwo905@gmail.com	Abuja	FCT	2023-07-18	Inactive
CUST0677	Chioma	Bello	chioma.bello756@gmail.com	Abuja	FCT	2024-02-29	Active
CUST0678	Chioma	Adeyemi	chioma.adeyemi12@gmail.com	Lagos	Lagos	2023-09-18	Active
CUST0679	Tobi	Abubakar	tobi.abubakar786@yahoo.com	Lagos	Lagos	2023-12-16	Active
CUST0680	Emeka	Okonkwo	emeka.okonkwo199@gmail.com	Kano	Kano	2024-11-19	Active
CUST0681	Femi	Eze	femi.eze494@yahoo.com	Port Harcourt	Rivers	2024-07-03	Active
CUST0682	Aisha	Adeleke	aisha.adeleke856@gmail.com	Port Harcourt	Rivers	2024-11-25	Active
CUST0683	Ayo	Abubakar	ayo.abubakar819@gmail.com	Lagos	Lagos	2023-03-09	Active
CUST0684	Ibrahim	Chukwu	ibrahim.chukwu642@gmail.com	Port Harcourt	Rivers	2024-09-12	Active
CUST0685	Chioma	Oluwole	chioma.oluwole723@gmail.com	Lagos	Lagos	2023-10-06	Active
CUST0686	Fatima	Nnamdi	fatima.nnamdi850@gmail.com	Ibadan	Oyo	2023-11-06	Active
CUST0687	Uche	Adeyemi	uche.adeyemi936@yahoo.com	Port Harcourt	Rivers	2024-05-09	Active
CUST0688	Blessing	Babangida	blessing.babangida751@gmail.com	Lagos	Lagos	2023-12-02	Active
CUST0689	Segun	Eze	segun.eze211@gmail.com	Port Harcourt	Rivers	2024-06-18	Active
CUST0690	Lola	Okorie	lola.okorie893@yahoo.com	Ibadan	Oyo	2023-02-17	Active
CUST0691	Uche	Oluwole	uche.oluwole655@gmail.com	Lagos	Lagos	2023-07-17	Active
CUST0692	Chukwu	Bello	chukwu.bello280@yahoo.com	Lagos	Lagos	2023-01-16	Active
CUST0693	Yemi	Taiwo	yemi.taiwo359@gmail.com	Abuja	FCT	2023-10-18	Active
CUST0694	Dayo	Abubakar	dayo.abubakar554@gmail.com	Lagos	Lagos	2024-04-27	Active
CUST0695	Ngozi	Musa	ngozi.musa437@gmail.com	Lagos	Lagos	2024-08-29	Active
CUST0696	Dayo	Obi	dayo.obi320@gmail.com	Kano	Kano	2024-11-17	Active
CUST0697	Uche	Nnamdi	uche.nnamdi582@yahoo.com	Ibadan	Oyo	2024-04-24	Active
CUST0698	Gbenga	Nnamdi	gbenga.nnamdi482@yahoo.com	Kano	Kano	2024-09-23	Active
CUST0699	Gbenga	Abubakar	gbenga.abubakar808@gmail.com	Abuja	FCT	2024-05-14	Inactive
CUST0700	Ada	Nnamdi	ada.nnamdi867@yahoo.com	Lagos	Lagos	2024-09-10	Active
CUST0701	Obinna	Bello	obinna.bello334@gmail.com	Lagos	Lagos	2023-11-06	Active
CUST0702	Funmi	Okorie	funmi.okorie250@gmail.com	Kano	Kano	2024-01-29	Inactive
CUST0703	Ayo	Adegoke	ayo.adegoke804@gmail.com	Port Harcourt	Rivers	2023-12-17	Active
CUST0704	Lola	Musa	lola.musa758@gmail.com	Lagos	Lagos	2024-05-13	Active
CUST0705	Tobi	Bello	tobi.bello842@gmail.com	Abuja	FCT	2024-02-20	Inactive
CUST0706	Dayo	Chukwu	dayo.chukwu336@gmail.com	Kano	Kano	2023-04-03	Active
CUST0707	Oluwaseun	Okafor	oluwaseun.okafor776@yahoo.com	Ibadan	Oyo	2024-06-28	Active
CUST0708	Lola	Abubakar	lola.abubakar307@gmail.com	Lagos	Lagos	2023-11-08	Active
CUST0709	Blessing	Obi	blessing.obi92@gmail.com	Port Harcourt	Rivers	2024-06-06	Active
CUST0710	Ngozi	Obi	ngozi.obi923@gmail.com	Ibadan	Oyo	2024-07-27	Active
CUST0711	Sade	Okafor	sade.okafor241@gmail.com	Lagos	Lagos	2024-10-02	Active
CUST0712	Aisha	Taiwo	aisha.taiwo217@gmail.com	Abuja	FCT	2023-07-12	Active
CUST0713	Tunde	Oluwole	tunde.oluwole894@gmail.com	Port Harcourt	Rivers	2023-03-15	Active
CUST0714	Ada	Adegoke	ada.adegoke999@gmail.com	Port Harcourt	Rivers	2024-10-19	Active
CUST0715	Gbenga	Okorie	gbenga.okorie953@gmail.com	Ibadan	Oyo	2024-06-05	Active
CUST0716	Funmi	Okonkwo	funmi.okonkwo435@gmail.com	Abuja	FCT	2023-08-31	Active
CUST0717	Tobi	Fagbemi	tobi.fagbemi376@yahoo.com	Abuja	FCT	2024-05-09	Active
CUST0718	Gbenga	Musa	gbenga.musa146@gmail.com	Kano	Kano	2023-10-14	Active
CUST0719	Dayo	Musa	dayo.musa252@gmail.com	Abuja	FCT	2024-11-15	Inactive
CUST0720	Oluwaseun	Abubakar	oluwaseun.abubakar548@gmail.com	Kano	Kano	2024-06-08	Active
CUST0721	Chioma	Oluwole	chioma.oluwole297@yahoo.com	Abuja	FCT	2024-09-03	Active
CUST0722	Ada	Fagbemi	ada.fagbemi174@gmail.com	Lagos	Lagos	2023-10-26	Active
CUST0723	Ada	Musa	ada.musa130@gmail.com	Lagos	Lagos	2023-10-12	Active
CUST0724	Nkechi	Nwosu	nkechi.nwosu15@gmail.com	Lagos	Lagos	2024-08-28	Active
CUST0725	Chioma	Okonkwo	chioma.okonkwo268@gmail.com	Abuja	FCT	2023-07-05	Active
CUST0726	Chidi	Eze	chidi.eze610@gmail.com	Lagos	Lagos	2024-05-22	Active
CUST0727	Funmi	Nnamdi	funmi.nnamdi744@gmail.com	Port Harcourt	Rivers	2023-12-20	Inactive
CUST0728	Amaka	Adeleke	amaka.adeleke172@gmail.com	Port Harcourt	Rivers	2024-05-02	Active
CUST0729	Lola	Chukwu	lola.chukwu486@yahoo.com	Lagos	Lagos	2024-03-21	Inactive
CUST0730	Ibrahim	Lawal	ibrahim.lawal700@gmail.com	Abuja	FCT	2024-06-28	Active
CUST0731	Femi	Nwosu	femi.nwosu344@yahoo.com	Kano	Kano	2023-09-19	Active
CUST0732	Lola	Ibrahim	lola.ibrahim752@gmail.com	Abuja	FCT	2024-06-16	Active
CUST0733	Emeka	Okafor	emeka.okafor852@yahoo.com	Lagos	Lagos	2024-06-21	Active
CUST0735	Femi	Bello	femi.bello726@gmail.com	Ibadan	Oyo	2024-09-11	Active
CUST0736	Gbenga	Okonkwo	gbenga.okonkwo260@yahoo.com	Ibadan	Oyo	2023-03-19	Active
CUST0737	Gbenga	Abubakar	gbenga.abubakar264@yahoo.com	Port Harcourt	Rivers	2023-03-05	Active
CUST0738	Kola	Nwosu	kola.nwosu183@gmail.com	Ibadan	Oyo	2023-07-25	Active
CUST0739	Amaka	Eze	amaka.eze554@gmail.com	Kano	Kano	2024-10-20	Active
CUST0740	Amaka	Adeleke	amaka.adeleke75@yahoo.com	Port Harcourt	Rivers	2024-04-01	Inactive
CUST0741	Femi	Okafor	femi.okafor956@yahoo.com	Lagos	Lagos	2023-06-05	Active
CUST0742	Segun	Babangida	segun.babangida490@gmail.com	Kano	Kano	2023-03-13	Active
CUST0743	Gbenga	Babangida	gbenga.babangida125@gmail.com	Abuja	FCT	2024-01-03	Active
CUST0744	Femi	Musa	femi.musa375@gmail.com	Abuja	FCT	2023-03-24	Active
CUST0745	Bisi	Taiwo	bisi.taiwo41@gmail.com	Kano	Kano	2023-11-03	Active
CUST0746	Fatima	Babangida	fatima.babangida87@gmail.com	Kano	Kano	2023-07-14	Active
CUST0747	Ayo	Ibrahim	ayo.ibrahim501@gmail.com	Lagos	Lagos	2024-10-20	Active
CUST0748	Chioma	Nnamdi	chioma.nnamdi990@gmail.com	Ibadan	Oyo	2023-02-27	Active
CUST0749	Yemi	Lawal	yemi.lawal470@gmail.com	Abuja	FCT	2024-07-03	Active
CUST0750	Ngozi	Eze	ngozi.eze501@gmail.com	Ibadan	Oyo	2024-09-25	Inactive
CUST0751	Femi	Adeleke	femi.adeleke927@gmail.com	Lagos	Lagos	2024-04-12	Active
CUST0752	Obinna	Bello	obinna.bello117@gmail.com	Lagos	Lagos	2023-08-14	Inactive
CUST0753	Chioma	Chukwu	chioma.chukwu333@yahoo.com	Abuja	FCT	2024-07-12	Active
CUST0754	Ayo	Okonkwo	ayo.okonkwo344@yahoo.com	Port Harcourt	Rivers	2024-03-01	Active
CUST0755	Chukwu	Ibrahim	chukwu.ibrahim948@gmail.com	Kano	Kano	2024-10-09	Active
CUST0756	Ada	Musa	ada.musa7@yahoo.com	Lagos	Lagos	2024-10-29	Active
CUST0757	Chioma	Babangida	chioma.babangida709@yahoo.com	Abuja	FCT	2023-10-05	Active
CUST0758	Bisi	Okorie	bisi.okorie709@yahoo.com	Lagos	Lagos	2024-05-26	Active
CUST0759	Chioma	Oluwole	chioma.oluwole357@gmail.com	Kano	Kano	2023-07-16	Active
CUST0760	Nkechi	Taiwo	nkechi.taiwo520@yahoo.com	Kano	Kano	2024-11-06	Active
CUST0761	Chioma	Eze	chioma.eze702@gmail.com	Lagos	Lagos	2024-05-24	Active
CUST0762	Ngozi	Obi	ngozi.obi292@yahoo.com	Ibadan	Oyo	2024-09-23	Active
CUST0763	Titi	Adeleke	titi.adeleke948@gmail.com	Lagos	Lagos	2023-01-30	Active
CUST0764	Funmi	Nnamdi	funmi.nnamdi607@gmail.com	Lagos	Lagos	2024-11-24	Active
CUST0765	Ibrahim	Ibrahim	ibrahim.ibrahim101@yahoo.com	Port Harcourt	Rivers	2023-07-24	Active
CUST0766	Ayo	Babangida	ayo.babangida56@gmail.com	Lagos	Lagos	2024-09-16	Active
CUST0767	Chukwu	Adeyemi	chukwu.adeyemi648@gmail.com	Abuja	FCT	2023-12-10	Active
CUST0768	Amaka	Nnamdi	amaka.nnamdi470@gmail.com	Lagos	Lagos	2023-08-14	Active
CUST0769	Chioma	Okorie	chioma.okorie928@yahoo.com	Lagos	Lagos	2023-08-24	Active
CUST0770	Yemi	Fagbemi	yemi.fagbemi485@gmail.com	Abuja	FCT	2024-03-14	Active
CUST0771	Aisha	Fagbemi	aisha.fagbemi228@gmail.com	Lagos	Lagos	2023-06-02	Active
CUST0772	Ngozi	Adeleke	ngozi.adeleke482@gmail.com	Abuja	FCT	2024-03-11	Active
CUST0773	Gbenga	Bello	gbenga.bello464@gmail.com	Port Harcourt	Rivers	2023-01-13	Active
CUST0774	Tunde	Obi	tunde.obi303@yahoo.com	Ibadan	Oyo	2023-01-17	Active
CUST0775	Chukwu	Fagbemi	chukwu.fagbemi766@gmail.com	Lagos	Lagos	2024-04-19	Active
CUST0776	Chioma	Obi	chioma.obi642@gmail.com	Abuja	FCT	2024-10-04	Inactive
CUST0777	Sade	Adegoke	sade.adegoke771@yahoo.com	Abuja	FCT	2024-07-09	Active
CUST0778	Chidi	Okorie	chidi.okorie902@gmail.com	Port Harcourt	Rivers	2024-06-11	Active
CUST0551	Lola	Adeleke	\N	Kano	Kano	2023-06-11	Active
CUST0779	Amaka	Chukwu	amaka.chukwu375@gmail.com	Ibadan	Oyo	2024-01-11	Active
CUST0780	Uche	Adeyemi	uche.adeyemi142@gmail.com	Kano	Kano	2023-04-27	Active
CUST0781	Uche	Ibrahim	uche.ibrahim329@gmail.com	Port Harcourt	Rivers	2024-11-27	Active
CUST0782	Fatima	Nnamdi	fatima.nnamdi498@gmail.com	Lagos	Lagos	2024-04-26	Active
CUST0783	Oluwaseun	Oluwole	oluwaseun.oluwole463@gmail.com	Port Harcourt	Rivers	2023-03-09	Active
CUST0784	Musa	Okonkwo	musa.okonkwo296@gmail.com	Lagos	Lagos	2023-06-18	Active
CUST0786	Ada	Obi	ada.obi431@gmail.com	Ibadan	Oyo	2023-10-26	Active
CUST0153	Nkechi	Eze	nkechi.eze580@gmail.com	Lagos	Lagos	2024-10-10	Active
CUST0787	Funmi	Lawal	funmi.lawal661@gmail.com	Ibadan	Oyo	2024-11-02	Active
CUST0788	Lola	Lawal	lola.lawal863@gmail.com	Abuja	FCT	2024-08-03	Active
CUST0789	Kola	Ibrahim	kola.ibrahim496@gmail.com	Lagos	Lagos	2023-02-18	Active
CUST0790	Bisi	Okorie	bisi.okorie947@yahoo.com	Abuja	FCT	2023-07-06	Active
CUST0791	Amaka	Adeleke	amaka.adeleke325@gmail.com	Lagos	Lagos	2024-01-14	Active
CUST0792	Lola	Abubakar	lola.abubakar353@yahoo.com	Port Harcourt	Rivers	2023-06-16	Active
CUST0793	Musa	Babangida	musa.babangida787@yahoo.com	Ibadan	Oyo	2023-11-24	Active
CUST0794	Sade	Babangida	sade.babangida918@yahoo.com	Kano	Kano	2024-08-10	Active
CUST0795	Amaka	Babangida	amaka.babangida922@yahoo.com	Lagos	Lagos	2023-04-30	Active
CUST0796	Funmi	Nnamdi	funmi.nnamdi366@yahoo.com	Kano	Kano	2024-10-18	Active
CUST0797	Uche	Nwosu	uche.nwosu201@yahoo.com	Port Harcourt	Rivers	2024-04-01	Active
CUST0798	Musa	Adeyemi	musa.adeyemi503@gmail.com	Ibadan	Oyo	2023-02-27	Active
CUST0799	Gbenga	Adegoke	\N	Abuja	FCT	2023-12-20	Active
CUST0800	Chidi	Adeyemi	chidi.adeyemi746@gmail.com	Ibadan	Oyo	2024-03-01	Active
CUST0801	Titi	Adegoke	titi.adegoke747@gmail.com	Lagos	Lagos	2024-08-24	Active
CUST0802	Ada	Lawal	ada.lawal344@yahoo.com	Lagos	Lagos	2024-01-20	Active
CUST0803	Kola	Adegoke	kola.adegoke180@gmail.com	Kano	Kano	2023-05-21	Active
CUST0804	Ada	Adeleke	ada.adeleke843@gmail.com	Lagos	Lagos	2023-11-08	Active
CUST0805	Emeka	Okafor	emeka.okafor158@yahoo.com	Abuja	FCT	2024-10-13	Active
CUST0806	Ada	Ibrahim	ada.ibrahim30@yahoo.com	Abuja	FCT	2023-03-10	Active
CUST0807	Ayo	Adegoke	ayo.adegoke890@yahoo.com	Kano	Kano	2023-05-03	Active
CUST0808	Bisi	Fagbemi	bisi.fagbemi60@yahoo.com	Port Harcourt	Rivers	2023-05-19	Active
CUST0809	Aisha	Obi	aisha.obi50@yahoo.com	Lagos	Lagos	2023-03-20	Active
CUST0810	Amaka	Okorie	amaka.okorie771@yahoo.com	Lagos	Lagos	2023-11-20	Active
CUST0811	Kola	Obi	kola.obi99@gmail.com	Port Harcourt	Rivers	2023-05-28	Inactive
CUST0812	Uche	Babangida	uche.babangida422@gmail.com	Lagos	Lagos	2023-04-15	Active
CUST0813	Yemi	Taiwo	yemi.taiwo629@gmail.com	Lagos	Lagos	2024-06-28	Active
CUST0814	Amaka	Adegoke	amaka.adegoke472@gmail.com	Port Harcourt	Rivers	2023-05-15	Active
CUST0815	Gbenga	Obi	gbenga.obi143@gmail.com	Lagos	Lagos	2024-09-03	Active
CUST0816	Sade	Okafor	sade.okafor763@gmail.com	Lagos	Lagos	2023-05-26	Active
CUST0817	Tunde	Musa	tunde.musa436@gmail.com	Lagos	Lagos	2023-03-21	Inactive
CUST0818	Ngozi	Adeyemi	ngozi.adeyemi111@yahoo.com	Port Harcourt	Rivers	2024-08-30	Inactive
CUST0819	Ngozi	Musa	ngozi.musa309@gmail.com	Ibadan	Oyo	2023-05-07	Active
CUST0820	Yemi	Okonkwo	yemi.okonkwo687@gmail.com	Kano	Kano	2023-10-12	Active
CUST0821	Nkechi	Lawal	nkechi.lawal800@gmail.com	Abuja	FCT	2024-08-06	Inactive
CUST0822	Gbenga	Adeyemi	gbenga.adeyemi988@yahoo.com	Abuja	FCT	2024-07-04	Inactive
CUST0823	Blessing	Lawal	blessing.lawal872@gmail.com	Ibadan	Oyo	2024-08-26	Active
CUST0824	Fatima	Chukwu	fatima.chukwu435@yahoo.com	Lagos	Lagos	2023-04-26	Active
CUST0825	Amaka	Lawal	amaka.lawal140@gmail.com	Lagos	Lagos	2023-10-23	Active
CUST0826	Ada	Bello	ada.bello395@yahoo.com	Lagos	Lagos	2023-11-16	Active
CUST0827	Aisha	Oluwole	aisha.oluwole876@gmail.com	Lagos	Lagos	2024-05-02	Active
CUST0828	Lola	Babangida	lola.babangida689@yahoo.com	Lagos	Lagos	2024-11-05	Active
CUST0829	Musa	Fagbemi	musa.fagbemi105@gmail.com	Lagos	Lagos	2023-06-22	Inactive
CUST0830	Dayo	Chukwu	dayo.chukwu126@yahoo.com	Lagos	Lagos	2024-05-26	Active
CUST0831	Ayo	Nwosu	ayo.nwosu775@gmail.com	Port Harcourt	Rivers	2024-02-14	Active
CUST0832	Ada	Lawal	ada.lawal286@yahoo.com	Ibadan	Oyo	2023-05-06	Active
CUST0833	Tunde	Okafor	tunde.okafor102@gmail.com	Lagos	Lagos	2024-05-25	Active
CUST0834	Lola	Abubakar	lola.abubakar157@gmail.com	Abuja	FCT	2023-03-20	Active
CUST0835	Yemi	Oluwole	yemi.oluwole678@gmail.com	Port Harcourt	Rivers	2024-07-09	Active
CUST0836	Uche	Adeleke	uche.adeleke441@gmail.com	Abuja	FCT	2024-04-05	Active
CUST0837	Ngozi	Adeleke	ngozi.adeleke182@gmail.com	Abuja	FCT	2023-11-07	Active
CUST0838	Tunde	Oluwole	tunde.oluwole733@gmail.com	Abuja	FCT	2024-08-05	Active
CUST0839	Nkechi	Okonkwo	nkechi.okonkwo519@yahoo.com	Abuja	FCT	2024-08-28	Active
CUST0840	Sade	Abubakar	sade.abubakar63@yahoo.com	Port Harcourt	Rivers	2024-01-11	Active
CUST0841	Oluwaseun	Abubakar	oluwaseun.abubakar390@yahoo.com	Lagos	Lagos	2024-01-01	Active
CUST0842	Funmi	Ibrahim	funmi.ibrahim664@gmail.com	Kano	Kano	2023-03-09	Active
CUST0843	Emeka	Taiwo	emeka.taiwo334@yahoo.com	Lagos	Lagos	2024-03-08	Active
CUST0844	Gbenga	Babangida	gbenga.babangida603@yahoo.com	Lagos	Lagos	2024-08-07	Active
CUST0845	Ada	Bello	ada.bello708@gmail.com	Lagos	Lagos	2024-05-29	Active
CUST0846	Dayo	Oluwole	dayo.oluwole373@gmail.com	Lagos	Lagos	2024-10-12	Active
CUST0847	Tobi	Adeyemi	tobi.adeyemi295@yahoo.com	Port Harcourt	Rivers	2024-08-10	Active
CUST0848	Chidi	Fagbemi	chidi.fagbemi98@gmail.com	Kano	Kano	2024-08-03	Active
CUST0849	Fatima	Musa	fatima.musa668@gmail.com	Abuja	FCT	2023-11-04	Active
CUST0850	Musa	Nwosu	musa.nwosu640@gmail.com	Lagos	Lagos	2024-07-14	Active
CUST0851	Blessing	Adegoke	oluwaseun.obi953@yahoo.com	Ibadan	Oyo	2024-06-18	Active
CUST0852	Chukwu	Eze	chioma.nnamdi639@yahoo.com	Lagos	Lagos	2023-06-04	Active
CUST0853	Uche	Oluwole	ayo.nwosu775@gmail.com	Port Harcourt	Rivers	2024-02-25	Active
CUST0854	Obinna	Musa	uche.nnamdi178@gmail.com	Lagos	Lagos	2023-07-28	Active
CUST0855	Kola	Oluwole	fatima.okonkwo54@gmail.com	Port Harcourt	Rivers	2023-09-20	Active
CUST0856	Funmi	Chukwu	ayo.nnamdi147@gmail.com	Kano	Kano	2023-04-27	Active
CUST0857	Emeka	Ibrahim	titi.abubakar619@yahoo.com	Lagos	Lagos	2024-04-20	Active
CUST0858	Aisha	Adegoke	uche.chukwu285@gmail.com	Abuja	FCT	2023-07-26	Active
CUST0859	Tunde	Okafor	gbenga.obi936@gmail.com	Lagos	Lagos	2023-10-12	Active
CUST0860	Bisi	Adeleke	tunde.ibrahim881@gmail.com	Kano	Kano	2023-01-21	Active
CUST0861	Oluwaseun	Musa	tunde.oluwole733@gmail.com	Lagos	Lagos	2024-09-08	Active
CUST0862	Chidi	Adegoke	amaka.babangida922@yahoo.com	Lagos	Lagos	2024-11-18	Active
CUST0863	Chidi	Chukwu	bisi.nwosu461@gmail.com	Kano	Kano	2023-08-30	Active
CUST0864	Titi	Lawal	tunde.oluwole894@gmail.com	Lagos	Lagos	2024-06-18	Active
CUST0865	Ayo	Lawal	uche.obi627@yahoo.com	Kano	Kano	2024-05-23	Active
CUST0001	Emeka	Nwosu	emeka.nwosu251@yahoo.com	Kano	Kano	2024-11-23	Active
CUST0002	Ngozi	Okafor	ngozi.okafor96@yahoo.com	Kano	Kano	2023-01-28	Active
CUST0003	Ayo	Nwosu	ayo.nwosu829@gmail.com	Lagos	Lagos	2023-06-13	Active
CUST0004	Yemi	Abubakar	yemi.abubakar105@yahoo.com	Lagos	Lagos	2023-12-19	Active
CUST0734	Titi	Oluwole	\N	Abuja	FCT	2023-04-05	Inactive
CUST0011	Blessing	Nnamdi	blessing.nnamdi147@yahoo.com	Abuja	FCT	2024-07-28	Active
CUST0012	Musa	Obi	musa.obi225@gmail.com	Ibadan	Oyo	2024-05-20	Active
CUST0013	Tunde	Okonkwo	tunde.okonkwo812@gmail.com	Ibadan	Oyo	2024-01-30	Active
CUST0014	Tobi	Okafor	tobi.okafor697@gmail.com	Abuja	FCT	2024-07-03	Active
CUST0015	Aisha	Okonkwo	aisha.okonkwo465@yahoo.com	Lagos	Lagos	2023-09-27	Active
CUST0016	Amaka	Oluwole	amaka.oluwole862@gmail.com	Abuja	FCT	2023-06-06	Active
CUST0017	Uche	Lawal	uche.lawal941@yahoo.com	Abuja	FCT	2023-01-20	Active
CUST0018	Obinna	Oluwole	obinna.oluwole246@yahoo.com	Ibadan	Oyo	2023-03-22	Active
CUST0019	Uche	Taiwo	uche.taiwo785@yahoo.com	Port Harcourt	Rivers	2024-07-16	Active
CUST0020	Aisha	Adeyemi	aisha.adeyemi952@gmail.com	Ibadan	Oyo	2023-07-25	Active
CUST0021	Femi	Obi	femi.obi449@gmail.com	Ibadan	Oyo	2023-09-11	Active
CUST0022	Tobi	Ibrahim	tobi.ibrahim603@yahoo.com	Lagos	Lagos	2024-10-08	Inactive
CUST0023	Nkechi	Abubakar	nkechi.abubakar73@gmail.com	Ibadan	Oyo	2024-05-12	Active
CUST0024	Oluwaseun	Fagbemi	oluwaseun.fagbemi591@gmail.com	Port Harcourt	Rivers	2024-02-21	Active
CUST0025	Fatima	Adegoke	fatima.adegoke421@gmail.com	Kano	Kano	2024-11-20	Active
CUST0026	Titi	Abubakar	titi.abubakar820@gmail.com	Lagos	Lagos	2023-07-14	Active
CUST0027	Kola	Nnamdi	kola.nnamdi256@gmail.com	Abuja	FCT	2024-07-17	Active
CUST0028	Blessing	Ibrahim	blessing.ibrahim171@gmail.com	Ibadan	Oyo	2024-02-15	Active
CUST0029	Musa	Nwosu	musa.nwosu949@gmail.com	Abuja	FCT	2024-03-09	Active
CUST0030	Sade	Adeyemi	sade.adeyemi992@yahoo.com	Lagos	Lagos	2023-03-04	Active
CUST0031	Ada	Lawal	ada.lawal942@gmail.com	Lagos	Lagos	2024-06-04	Active
CUST0032	Chidi	Ibrahim	chidi.ibrahim414@yahoo.com	Lagos	Lagos	2023-09-10	Active
CUST0033	Aisha	Fagbemi	aisha.fagbemi579@gmail.com	Kano	Kano	2023-07-29	Active
CUST0034	Musa	Eze	musa.eze688@gmail.com	Lagos	Lagos	2023-03-16	Inactive
CUST0035	Amaka	Musa	amaka.musa551@yahoo.com	Ibadan	Oyo	2023-12-24	Active
CUST0036	Bisi	Nnamdi	bisi.nnamdi854@gmail.com	Abuja	FCT	2024-10-31	Active
CUST0037	Amaka	Eze	amaka.eze271@yahoo.com	Ibadan	Oyo	2024-07-20	Active
CUST0038	Gbenga	Abubakar	gbenga.abubakar209@gmail.com	Kano	Kano	2024-06-01	Active
CUST0039	Aisha	Nwosu	aisha.nwosu46@yahoo.com	Lagos	Lagos	2024-10-14	Active
CUST0040	Tobi	Adegoke	tobi.adegoke575@yahoo.com	Port Harcourt	Rivers	2023-06-02	Active
CUST0041	Tunde	Adegoke	tunde.adegoke131@yahoo.com	Kano	Kano	2023-02-10	Active
CUST0042	Lola	Bello	lola.bello363@gmail.com	Kano	Kano	2024-02-21	Active
CUST0043	Funmi	Okonkwo	funmi.okonkwo820@gmail.com	Ibadan	Oyo	2023-01-26	Active
CUST0044	Aisha	Ibrahim	aisha.ibrahim274@yahoo.com	Port Harcourt	Rivers	2024-01-27	Active
CUST0045	Obinna	Nnamdi	obinna.nnamdi359@gmail.com	Lagos	Lagos	2023-08-22	Active
CUST0046	Ibrahim	Nwosu	ibrahim.nwosu886@yahoo.com	Lagos	Lagos	2023-12-26	Active
CUST0047	Obinna	Taiwo	obinna.taiwo340@gmail.com	Kano	Kano	2023-09-25	Active
CUST0048	Dayo	Adegoke	dayo.adegoke354@gmail.com	Lagos	Lagos	2024-09-12	Active
CUST0049	Ayo	Adeyemi	ayo.adeyemi261@yahoo.com	Abuja	FCT	2024-06-16	Active
CUST0050	Chidi	Abubakar	chidi.abubakar639@gmail.com	Abuja	FCT	2023-11-04	Active
CUST0051	Gbenga	Oluwole	gbenga.oluwole568@yahoo.com	Lagos	Lagos	2024-01-24	Active
CUST0052	Sade	Chukwu	sade.chukwu562@gmail.com	Kano	Kano	2023-08-04	Active
CUST0053	Chukwu	Adeyemi	chukwu.adeyemi524@gmail.com	Abuja	FCT	2023-06-23	Active
CUST0054	Femi	Okorie	femi.okorie344@yahoo.com	Abuja	FCT	2023-08-29	Active
CUST0055	Tunde	Okafor	tunde.okafor48@yahoo.com	Port Harcourt	Rivers	2023-03-16	Active
CUST0056	Gbenga	Chukwu	gbenga.chukwu507@gmail.com	Lagos	Lagos	2023-01-06	Active
CUST0057	Funmi	Okonkwo	funmi.okonkwo824@gmail.com	Port Harcourt	Rivers	2023-02-21	Active
CUST0058	Chioma	Nnamdi	chioma.nnamdi684@gmail.com	Abuja	FCT	2023-11-21	Active
CUST0059	Titi	Lawal	titi.lawal437@gmail.com	Kano	Kano	2023-06-12	Active
CUST0060	Uche	Ibrahim	uche.ibrahim861@gmail.com	Abuja	FCT	2024-06-17	Active
CUST0061	Chidi	Oluwole	chidi.oluwole241@yahoo.com	Lagos	Lagos	2024-07-07	Active
CUST0062	Gbenga	Eze	gbenga.eze724@yahoo.com	Lagos	Lagos	2023-12-05	Active
CUST0063	Obinna	Adegoke	obinna.adegoke399@gmail.com	Lagos	Lagos	2023-01-21	Active
CUST0064	Emeka	Obi	emeka.obi306@gmail.com	Abuja	FCT	2024-03-05	Active
CUST0065	Kola	Adegoke	kola.adegoke498@yahoo.com	Abuja	FCT	2024-11-26	Active
CUST0066	Blessing	Eze	blessing.eze638@gmail.com	Port Harcourt	Rivers	2024-08-29	Active
CUST0067	Aisha	Eze	aisha.eze888@gmail.com	Lagos	Lagos	2024-01-24	Active
CUST0068	Uche	Chukwu	uche.chukwu285@gmail.com	Lagos	Lagos	2023-09-16	Active
CUST0069	Tobi	Adeleke	tobi.adeleke975@gmail.com	Lagos	Lagos	2024-10-29	Inactive
CUST0070	Yemi	Okafor	yemi.okafor637@yahoo.com	Ibadan	Oyo	2024-11-16	Active
CUST0071	Kola	Obi	kola.obi172@gmail.com	Abuja	FCT	2023-04-28	Active
CUST0072	Amaka	Fagbemi	amaka.fagbemi27@gmail.com	Ibadan	Oyo	2024-01-20	Active
CUST0073	Gbenga	Ibrahim	gbenga.ibrahim105@gmail.com	Lagos	Lagos	2024-12-01	Active
CUST0074	Ayo	Adeleke	ayo.adeleke356@gmail.com	Port Harcourt	Rivers	2023-03-12	Active
CUST0785	Tunde	Adeyemi	\N	Lagos	Lagos	2024-03-02	Active
CUST0075	Aisha	Babangida	aisha.babangida109@gmail.com	Lagos	Lagos	2024-04-15	Active
CUST0076	Segun	Nwosu	segun.nwosu631@gmail.com	Lagos	Lagos	2024-05-10	Active
CUST0005	Tobi	Bello	tobi.bello997@gmail.com	Port Harcourt	Rivers	2023-10-28	Active
CUST0006	Fatima	Fagbemi	fatima.fagbemi197@gmail.com	Ibadan	Oyo	2023-08-22	Active
CUST0007	Nkechi	Bello	nkechi.bello390@yahoo.com	Ibadan	Oyo	2024-01-09	Active
CUST0008	Kola	Musa	kola.musa624@gmail.com	Lagos	Lagos	2023-09-08	Active
CUST0009	Blessing	Taiwo	blessing.taiwo225@gmail.com	Lagos	Lagos	2023-02-27	Active
CUST0010	Musa	Nwosu	musa.nwosu68@yahoo.com	Port Harcourt	Rivers	2023-11-19	Active
\.


--
-- Data for Name: flagged_order_totals; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.flagged_order_totals (order_id, recorded_total, computed_total, difference) FROM stdin;
ORD02090	5261.71	5914.40	652.69
ORD00168	229974.35	277183.97	47209.62
ORD01959	868327.05	1084462.88	216135.83
ORD00466	553086.42	463066.70	90019.72
ORD02812	5994.32	5323.48	670.84
ORD00648	167249.52	135442.10	31807.42
ORD02697	45877.96	54346.36	8468.40
ORD00139	61679.19	52523.95	9155.24
ORD03007	854934.30	1169173.77	314239.47
ORD01598	2277.57	2019.05	258.52
ORD01602	978096.05	975801.34	2294.71
ORD00902	24376.32	32407.34	8031.02
ORD00633	469525.69	490263.70	20738.01
ORD02066	140129.81	192264.39	52134.58
ORD00697	53290.52	43407.94	9882.58
ORD01462	842568.75	1043635.10	201066.35
ORD00912	14095.84	19060.11	4964.27
ORD02278	32284.63	45420.18	13135.55
ORD02282	1192014.28	1379808.28	187794.00
ORD00065	568676.24	512015.30	56660.94
ORD01224	80161.95	108503.68	28341.73
ORD01985	47930.68	56636.17	8705.49
ORD02954	456816.78	425860.46	30956.32
ORD00156	28748.14	25829.99	2918.15
ORD00598	17607.17	18690.33	1083.16
ORD01054	1038425.47	1298476.46	260050.99
ORD00491	437038.04	542560.30	105522.26
ORD02419	16693.05	14239.20	2453.85
ORD02510	337634.60	425074.03	87439.43
ORD00062	841181.08	683806.02	157375.06
ORD00891	114528.20	102715.97	11812.23
ORD02937	45902.74	46511.08	608.34
ORD01219	147534.54	207723.27	60188.73
ORD02966	782053.66	871926.90	89873.24
ORD00597	754309.18	991492.36	237183.18
ORD02266	9866.86	11510.60	1643.74
ORD02863	64321.19	90782.07	26460.88
ORD01475	296286.45	332267.85	35981.40
ORD01627	767003.95	1007882.64	240878.69
ORD01572	25061.13	19741.12	5320.01
ORD02746	494280.20	485239.34	9040.86
ORD01147	900.70	801.07	99.63
ORD00036	37673.59	48928.23	11254.64
ORD00807	103538.61	99257.60	4281.01
ORD02778	298987.09	275843.36	23143.73
ORD02331	40185.68	45909.51	5723.83
ORD02067	127505.15	115415.52	12089.63
ORD00686	179162.29	226826.43	47664.14
ORD01836	58338.32	78337.96	19999.64
ORD01925	109521.65	92850.43	16671.22
ORD01433	1061234.59	1376344.51	315109.92
ORD02997	126350.44	134586.05	8235.61
ORD01681	48648.69	47472.78	1175.91
ORD01071	412524.16	326946.63	85577.53
ORD01385	604011.00	547309.36	56701.64
ORD02638	586313.81	685206.45	98892.64
ORD02437	54574.89	72722.46	18147.57
ORD01431	58923.21	48703.52	10219.69
ORD02957	554133.17	617350.82	63217.65
ORD02062	1517372.93	1353020.49	164352.44
ORD01153	16326.25	18117.48	1791.23
ORD00232	114557.57	129569.92	15012.35
ORD02762	671864.12	811948.38	140084.26
ORD03003	29754.99	33288.69	3533.70
ORD02454	16768.75	16199.28	569.47
ORD02730	6965.45	8236.30	1270.85
ORD01743	1416912.17	1090164.01	326748.16
ORD00093	150879.51	180783.30	29903.79
ORD02546	38469.79	35720.73	2749.06
ORD00475	458822.98	366441.86	92381.12
ORD00520	463130.71	552857.50	89726.79
ORD01953	122712.27	95128.44	27583.83
ORD01816	638398.91	838831.71	200432.80
ORD01582	260280.99	203783.94	56497.05
ORD02208	12989.38	16447.04	3457.66
ORD00877	104703.44	82655.59	22047.85
ORD02049	620872.37	688095.89	67223.52
ORD00306	23581.39	30657.87	7076.48
ORD00083	221349.29	243648.72	22299.43
ORD03000	1071290.74	1125135.88	53845.14
ORD01040	48710.76	56475.46	7764.70
ORD00994	556868.36	785986.95	229118.59
ORD01912	15003.67	15172.98	169.31
ORD02465	1456956.16	1225957.14	230999.02
ORD02703	38061.27	39482.24	1420.97
ORD00236	1007027.79	834351.60	172676.19
ORD01036	75976.50	84595.66	8619.16
ORD00618	30160.29	41020.52	10860.23
ORD00419	687984.41	732509.53	44525.12
ORD00383	8999.40	8480.78	518.62
ORD00543	871730.60	778067.67	93662.93
ORD01775	58586.40	47233.84	11352.56
ORD01607	96615.35	103367.99	6752.64
ORD01109	94241.74	112350.27	18108.53
ORD02926	1337.62	1215.86	121.76
ORD00593	76726.04	77318.85	592.81
ORD00544	92772.76	93476.73	703.97
ORD02981	140213.78	190519.17	50305.39
ORD01664	1158907.10	991771.17	167135.93
ORD01365	191900.83	231257.82	39356.99
ORD02970	16010.80	18503.27	2492.47
ORD01202	10088.47	7958.84	2129.63
ORD02460	157895.28	130265.75	27629.53
ORD01276	73629.38	58850.00	14779.38
ORD01172	11470.51	9010.85	2459.66
ORD00192	51341.16	44257.26	7083.90
ORD02294	886785.03	736809.40	149975.63
ORD00454	1300172.97	1037439.54	262733.43
ORD00882	109517.52	87439.17	22078.35
ORD02623	687279.15	638551.43	48727.72
ORD01154	1310091.95	1450213.79	140121.84
ORD02009	275127.81	267645.17	7482.64
ORD01449	695495.94	982509.92	287013.98
ORD02038	369351.72	390169.63	20817.91
ORD01322	49812.90	39819.28	9993.62
ORD02230	46853.29	51276.11	4422.82
ORD01937	616829.11	839586.42	222757.31
ORD00638	439020.25	362196.93	76823.32
ORD00888	15006.39	19909.64	4903.25
ORD02833	841978.87	870948.69	28969.82
ORD00664	808297.13	633872.57	174424.56
ORD00827	29001.62	39482.24	10480.62
ORD00762	135330.44	174643.52	39313.08
ORD02111	204410.76	215725.96	11315.20
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_items (item_id, order_id, product_id, quantity, unit_price, line_total) FROM stdin;
1	ORD00001	PROD0160	2	12278.28	24556.56
2	ORD00001	PROD0085	4	89243.32	356973.28
3	ORD00001	PROD0102	2	45021.16	90042.32
4	ORD00002	PROD0247	1	5416.29	5416.29
5	ORD00003	PROD0247	4	5416.29	21665.16
6	ORD00003	PROD0011	1	314229.61	314229.61
7	ORD00003	PROD0196	3	2511.26	7533.78
8	ORD00004	PROD0193	1	9954.82	9954.82
9	ORD00004	PROD0247	3	5416.29	16248.87
10	ORD00005	PROD0257	3	2248.73	6746.19
11	ORD00006	PROD0037	5	266180.98	1330904.90
12	ORD00006	PROD0210	2	14712.50	29425.00
13	ORD00006	PROD0020	2	293010.61	586021.22
14	ORD00006	PROD0064	4	34644.88	138579.52
15	ORD00006	PROD0198	3	57432.47	172297.41
16	ORD00007	PROD0189	4	96833.78	387335.12
17	ORD00007	PROD0030	4	253935.11	1015740.44
18	ORD00008	PROD0015	3	222324.51	666973.53
19	ORD00008	PROD0076	5	27116.85	135584.25
20	ORD00009	PROD0007	4	290642.30	1162569.20
21	ORD00009	PROD0060	4	10877.79	43511.16
22	ORD00009	PROD0048	5	10843.12	54215.60
23	ORD00010	PROD0130	5	1182.88	5914.40
24	ORD00010	PROD0155	4	17522.15	70088.60
25	ORD00010	PROD0257	5	2248.73	11243.65
26	ORD00011	PROD0177	3	102403.06	307209.18
27	ORD00011	PROD0074	2	13460.87	26921.74
28	ORD00012	PROD0036	4	78738.41	314953.64
29	ORD00013	PROD0069	2	39168.98	78337.96
30	ORD00014	PROD0031	2	290316.23	580632.46
31	ORD00015	PROD0086	4	49202.47	196809.88
32	ORD00015	PROD0041	1	14461.31	14461.31
33	ORD00015	PROD0151	3	24271.64	72814.92
34	ORD00015	PROD0044	1	32574.27	32574.27
35	ORD00016	PROD0137	1	2019.05	2019.05
36	ORD00017	PROD0267	3	6230.11	18690.33
37	ORD00018	PROD0185	5	112356.62	561783.10
38	ORD00018	PROD0205	1	\N	\N
39	ORD00018	PROD0194	3	24802.59	74407.77
40	ORD00019	PROD0072	5	43142.24	215711.20
41	ORD00019	PROD0014	3	289145.53	867436.59
42	ORD00019	PROD0063	2	35488.70	70977.40
43	ORD00020	PROD0165	1	22136.37	22136.37
44	ORD00021	PROD0120	4	35341.43	141365.72
45	ORD00021	PROD0249	5	774.24	3871.20
46	ORD00022	PROD0052	5	23501.69	117508.45
47	ORD00022	PROD0198	5	57432.47	287162.35
48	ORD00022	PROD0151	5	24271.64	121358.20
49	ORD00022	PROD0100	1	110269.71	110269.71
50	ORD00022	PROD0074	2	13460.87	26921.74
51	ORD00023	PROD0240	5	10219.29	51096.45
52	ORD00023	PROD0087	2	12717.02	25434.04
53	ORD00023	PROD0229	2	4112.45	8224.90
54	ORD00023	PROD0060	2	10877.79	21755.58
55	ORD00023	PROD0247	2	5416.29	10832.58
56	ORD00024	PROD0113	1	145706.19	145706.19
57	ORD00024	PROD0132	2	23990.67	47981.34
58	ORD00024	PROD0244	5	1664.99	8324.95
59	ORD00025	PROD0034	5	272513.12	1362565.60
60	ORD00025	PROD0176	4	30789.84	123159.36
61	ORD00025	PROD0194	2	24802.59	49605.18
62	ORD00025	PROD0196	2	2511.26	5022.52
63	ORD00026	PROD0060	4	10877.79	43511.16
64	ORD00026	PROD0189	5	96833.78	484168.90
65	ORD00026	PROD0066	1	36291.81	36291.81
66	ORD00026	PROD0161	3	25829.99	77489.97
67	ORD00027	PROD0065	1	30524.10	30524.10
68	ORD00027	PROD0267	4	6230.11	24920.44
69	ORD00027	PROD0114	1	7586.49	7586.49
70	ORD00028	PROD0075	5	5182.19	25910.95
71	ORD00028	PROD0018	3	120439.60	361318.80
72	ORD00029	PROD0193	3	9954.82	29864.46
73	ORD00029	PROD0031	2	290316.23	580632.46
74	ORD00030	PROD0027	4	26206.57	104826.28
75	ORD00030	PROD0092	3	140982.24	422946.72
76	ORD00030	PROD0250	2	4620.81	9241.62
77	ORD00031	PROD0271	3	1989.71	5969.13
78	ORD00032	PROD0028	2	316366.34	632732.68
79	ORD00032	PROD0156	5	21374.21	106871.05
80	ORD00032	PROD0235	2	1609.74	3219.48
81	ORD00033	PROD0053	2	43609.38	87218.76
82	ORD00034	PROD0243	2	10094.25	20188.50
83	ORD00035	PROD0077	2	20510.26	41020.52
84	ORD00035	PROD0207	1	11561.20	11561.20
85	ORD00036	PROD0046	3	5762.47	17287.41
86	ORD00036	PROD0238	4	6026.76	24107.04
87	ORD00036	PROD0196	3	2511.26	7533.78
88	ORD00037	PROD0246	4	5399.76	21599.04
89	ORD00037	PROD0141	4	11608.58	46434.32
90	ORD00037	PROD0049	3	27088.42	81265.26
91	ORD00037	PROD0093	5	8480.78	42403.90
92	ORD00037	PROD0197	2	113579.08	227158.16
93	ORD00038	PROD0275	5	10193.83	50969.15
94	ORD00039	PROD0107	1	97418.23	97418.23
95	ORD00040	PROD0066	5	36291.81	181459.05
96	ORD00041	PROD0279	2	962.48	1924.96
97	ORD00042	PROD0151	5	24271.64	121358.20
98	ORD00042	PROD0274	4	7846.95	31387.80
99	ORD00042	PROD0228	3	6170.81	18512.43
100	ORD00042	PROD0072	5	43142.24	215711.20
101	ORD00043	PROD0023	1	276589.43	276589.43
102	ORD00043	PROD0122	2	16203.67	32407.34
103	ORD00044	PROD0143	5	13171.72	65858.60
104	ORD00044	PROD0066	4	36291.81	145167.24
105	ORD00045	PROD0074	2	13460.87	26921.74
106	ORD00045	PROD0275	1	10193.83	10193.83
107	ORD00046	PROD0262	2	3172.89	6345.78
108	ORD00046	PROD0084	3	37258.14	111774.42
109	ORD00046	PROD0215	4	3385.48	13541.92
110	ORD00047	PROD0034	1	272513.12	272513.12
111	ORD00047	PROD0169	3	41598.42	124795.26
112	ORD00048	PROD0064	1	34644.88	34644.88
113	ORD00048	PROD0090	5	102715.97	513579.85
114	ORD00048	PROD0270	3	907.09	2721.27
115	ORD00048	PROD0157	5	10758.03	53790.15
116	ORD00048	PROD0251	3	5175.86	15527.58
117	ORD00049	PROD0273	5	1784.35	8921.75
118	ORD00050	PROD0263	2	8199.23	16398.46
119	ORD00051	PROD0190	2	22778.54	45557.08
120	ORD00051	PROD0128	4	24463.34	97853.36
121	ORD00051	PROD0215	3	3385.48	10156.44
122	ORD00051	PROD0235	4	1609.74	6438.96
123	ORD00052	PROD0045	3	15761.34	47284.02
124	ORD00053	PROD0048	1	10843.12	10843.12
125	ORD00053	PROD0085	3	89243.32	267729.96
126	ORD00053	PROD0030	5	253935.11	1269675.55
127	ORD00054	PROD0070	4	25905.43	103621.72
128	ORD00054	PROD0246	5	5399.76	26998.80
129	ORD00055	PROD0098	1	54814.26	54814.26
130	ORD00056	PROD0230	5	6077.64	30388.20
131	ORD00056	PROD0087	2	12717.02	25434.04
132	ORD00057	PROD0058	3	14691.81	44075.43
133	ORD00058	PROD0151	3	24271.64	72814.92
134	ORD00059	PROD0019	5	339524.65	1697623.25
135	ORD00059	PROD0238	4	6026.76	24107.04
136	ORD00060	PROD0096	4	179864.29	719457.16
137	ORD00061	PROD0250	2	4620.81	9241.62
138	ORD00061	PROD0004	3	39811.79	119435.37
139	ORD00062	PROD0056	2	6299.62	12599.24
140	ORD00062	PROD0225	3	9270.30	27810.90
141	ORD00062	PROD0083	4	160848.97	643395.88
142	ORD00063	PROD0102	4	45021.16	180084.64
143	ORD00064	PROD0205	5	\N	\N
144	ORD00065	PROD0177	5	102403.06	512015.30
145	ORD00066	PROD0149	4	8124.11	32496.44
146	ORD00066	PROD0145	1	22657.06	22657.06
147	ORD00067	PROD0059	3	35594.97	106784.91
148	ORD00068	PROD0258	5	4792.40	23962.00
149	ORD00068	PROD0093	2	8480.78	16961.56
150	ORD00068	PROD0097	2	9141.77	18283.54
151	ORD00069	PROD0103	1	83304.08	83304.08
152	ORD00069	PROD0047	4	5512.81	22051.24
153	ORD00070	PROD0219	1	14849.13	14849.13
154	ORD00071	PROD0025	2	330590.39	661180.78
155	ORD00072	PROD0130	3	1182.88	3548.64
156	ORD00072	PROD0252	3	8223.52	24670.56
157	ORD00073	PROD0186	5	17418.14	87090.70
158	ORD00074	PROD0055	2	42567.03	85134.06
159	ORD00075	PROD0099	1	130788.21	130788.21
160	ORD00075	PROD0229	5	4112.45	20562.25
161	ORD00075	PROD0051	5	33329.69	166648.45
162	ORD00076	PROD0099	4	130788.21	523152.84
163	ORD00077	PROD0061	1	6821.26	6821.26
164	ORD00077	PROD0224	4	607.93	2431.72
165	ORD00078	PROD0067	1	11627.77	11627.77
166	ORD00078	PROD0149	5	8124.11	40620.55
167	ORD00079	PROD0273	1	1784.35	1784.35
168	ORD00079	PROD0263	2	8199.23	16398.46
169	ORD00080	PROD0106	1	137481.28	137481.28
170	ORD00080	PROD0095	2	49921.23	99842.46
171	ORD00081	PROD0269	3	2989.48	8968.44
172	ORD00081	PROD0133	2	23616.92	47233.84
173	ORD00082	PROD0021	2	34405.68	68811.36
174	ORD00083	PROD0128	5	24463.34	122316.70
175	ORD00083	PROD0108	1	121332.02	121332.02
176	ORD00084	PROD0069	4	39168.98	156675.92
177	ORD00085	PROD0113	3	145706.19	437118.57
178	ORD00085	PROD0144	1	801.07	801.07
179	ORD00085	PROD0091	5	141135.80	705679.00
180	ORD00086	PROD0132	5	23990.67	119953.35
181	ORD00087	PROD0119	4	47472.78	189891.12
182	ORD00088	PROD0091	2	141135.80	282271.60
183	ORD00088	PROD0097	3	9141.77	27425.31
184	ORD00088	PROD0252	1	8223.52	8223.52
185	ORD00089	PROD0207	1	11561.20	11561.20
186	ORD00090	PROD0057	1	24240.82	24240.82
187	ORD00091	PROD0007	1	290642.30	290642.30
188	ORD00092	PROD0084	2	37258.14	74516.28
189	ORD00092	PROD0158	2	12650.30	25300.60
190	ORD00092	PROD0170	1	45302.42	45302.42
191	ORD00092	PROD0246	5	5399.76	26998.80
192	ORD00093	PROD0053	4	43609.38	174437.52
193	ORD00093	PROD0262	2	3172.89	6345.78
194	ORD00094	PROD0197	1	113579.08	113579.08
195	ORD00095	PROD0171	1	105588.96	105588.96
196	ORD00096	PROD0220	5	11275.57	56377.85
197	ORD00097	PROD0147	3	5055.12	15165.36
198	ORD00098	PROD0077	2	20510.26	41020.52
199	ORD00098	PROD0076	4	27116.85	108467.40
200	ORD00098	PROD0164	4	6702.72	26810.88
201	ORD00099	PROD0143	1	13171.72	13171.72
202	ORD00099	PROD0075	3	5182.19	15546.57
203	ORD00100	PROD0171	5	105588.96	527944.80
204	ORD00100	PROD0071	4	9870.56	39482.24
205	ORD00100	PROD0126	5	13544.05	67720.25
206	ORD00100	PROD0197	5	113579.08	567895.40
207	ORD00100	PROD0215	4	3385.48	13541.92
208	ORD00101	PROD0113	2	145706.19	291412.38
209	ORD00101	PROD0045	3	15761.34	47284.02
210	ORD00102	PROD0185	2	112356.62	224713.24
211	ORD00102	PROD0072	5	43142.24	215711.20
212	ORD00102	PROD0151	4	24271.64	97086.56
213	ORD00102	PROD0236	2	7038.57	14077.14
214	ORD00103	PROD0218	1	5238.20	5238.20
215	ORD00103	PROD0191	5	44052.51	220262.55
216	ORD00103	PROD0028	1	316366.34	316366.34
217	ORD00104	PROD0040	1	47715.49	47715.49
218	ORD00105	PROD0173	1	39177.27	39177.27
219	ORD00105	PROD0228	3	6170.81	18512.43
220	ORD00106	PROD0006	4	308912.61	1235650.44
221	ORD00106	PROD0203	4	3538.98	14155.92
222	ORD00107	PROD0140	2	2847.84	5695.68
223	ORD00107	PROD0048	2	10843.12	21686.24
224	ORD00107	PROD0268	4	2944.75	11779.00
225	ORD00107	PROD0194	5	24802.59	124012.95
226	ORD00108	PROD0240	4	10219.29	40877.16
227	ORD00108	PROD0245	4	\N	\N
228	ORD00108	PROD0161	2	25829.99	51659.98
229	ORD00109	PROD0172	1	95695.43	95695.43
230	ORD00110	PROD0104	1	\N	\N
231	ORD00111	PROD0162	1	2672.21	2672.21
232	ORD00112	PROD0162	3	2672.21	8016.63
233	ORD00112	PROD0201	2	10976.40	21952.80
234	ORD00113	PROD0077	1	20510.26	20510.26
235	ORD00114	PROD0048	2	10843.12	21686.24
236	ORD00114	PROD0119	2	47472.78	94945.56
237	ORD00115	PROD0068	3	43176.46	129529.38
238	ORD00115	PROD0174	3	110640.11	331920.33
239	ORD00116	PROD0107	5	97418.23	487091.15
240	ORD00117	PROD0008	2	121518.49	243036.98
241	ORD00118	PROD0152	2	1904.28	3808.56
242	ORD00119	PROD0243	3	10094.25	30282.75
243	ORD00120	PROD0187	4	28776.04	115104.16
244	ORD00120	PROD0147	4	5055.12	20220.48
245	ORD00121	PROD0192	3	94625.99	283877.97
246	ORD00121	PROD0043	1	16739.67	16739.67
247	ORD00121	PROD0212	5	8757.97	43789.85
248	ORD00121	PROD0260	1	5050.94	5050.94
249	ORD00121	PROD0231	2	6206.49	12412.98
250	ORD00122	PROD0237	1	7201.43	7201.43
251	ORD00123	PROD0204	3	5933.15	17799.45
252	ORD00123	PROD0222	1	2802.33	2802.33
253	ORD00123	PROD0103	3	83304.08	249912.24
254	ORD00123	PROD0206	3	5427.42	16282.26
255	ORD00124	PROD0241	2	1174.07	2348.14
256	ORD00124	PROD0075	3	5182.19	15546.57
257	ORD00125	PROD0243	2	10094.25	20188.50
258	ORD00125	PROD0110	1	23332.73	23332.73
259	ORD00125	PROD0028	4	316366.34	1265465.36
260	ORD00126	PROD0232	4	4469.76	17879.04
261	ORD00127	PROD0153	2	10840.50	21681.00
262	ORD00128	PROD0200	5	29196.20	145981.00
263	ORD00128	PROD0006	5	308912.61	1544563.05
264	ORD00129	PROD0163	2	18374.63	36749.26
265	ORD00129	PROD0008	4	121518.49	486073.96
266	ORD00130	PROD0002	4	102447.74	409790.96
267	ORD00131	PROD0097	4	9141.77	36567.08
268	ORD00132	PROD0008	3	121518.49	364555.47
269	ORD00132	PROD0190	1	22778.54	22778.54
270	ORD00133	PROD0234	4	6463.53	25854.12
271	ORD00133	PROD0212	3	8757.97	26273.91
272	ORD00134	PROD0091	5	141135.80	705679.00
273	ORD00134	PROD0084	4	37258.14	149032.56
274	ORD00135	PROD0051	1	33329.69	33329.69
275	ORD00136	PROD0279	4	962.48	3849.92
276	ORD00136	PROD0052	5	23501.69	117508.45
277	ORD00137	PROD0233	5	10621.64	53108.20
278	ORD00138	PROD0203	3	3538.98	10616.94
279	ORD00138	PROD0004	2	39811.79	79623.58
280	ORD00139	PROD0003	1	49538.31	49538.31
281	ORD00139	PROD0213	1	2985.64	2985.64
282	ORD00140	PROD0221	2	13121.51	26243.02
283	ORD00141	PROD0220	2	11275.57	22551.14
284	ORD00141	PROD0066	4	36291.81	145167.24
285	ORD00141	PROD0200	3	29196.20	87588.60
286	ORD00142	PROD0201	5	10976.40	54882.00
287	ORD00142	PROD0134	2	19220.41	38440.82
288	ORD00143	PROD0279	1	962.48	962.48
289	ORD00144	PROD0275	2	10193.83	20387.66
290	ORD00145	PROD0043	2	16739.67	33479.34
291	ORD00146	PROD0145	3	22657.06	67971.18
292	ORD00147	PROD0252	1	8223.52	8223.52
293	ORD00148	PROD0231	1	6206.49	6206.49
294	ORD00148	PROD0083	2	160848.97	321697.94
295	ORD00148	PROD0093	5	8480.78	42403.90
296	ORD00148	PROD0153	5	10840.50	54202.50
297	ORD00149	PROD0082	3	54346.36	163039.08
298	ORD00149	PROD0268	1	2944.75	2944.75
299	ORD00150	PROD0016	1	256280.50	256280.50
300	ORD00150	PROD0168	2	100026.32	200052.64
301	ORD00150	PROD0071	3	9870.56	29611.68
302	ORD00150	PROD0113	3	145706.19	437118.57
303	ORD00151	PROD0254	4	9824.37	39297.48
304	ORD00152	PROD0160	2	12278.28	24556.56
305	ORD00152	PROD0085	4	89243.32	356973.28
306	ORD00153	PROD0197	2	113579.08	227158.16
307	ORD00153	PROD0220	5	11275.57	56377.85
308	ORD00154	PROD0210	3	14712.50	44137.50
309	ORD00155	PROD0166	4	101932.80	407731.20
310	ORD00156	PROD0161	1	25829.99	25829.99
311	ORD00157	PROD0034	5	272513.12	1362565.60
312	ORD00157	PROD0198	2	57432.47	114864.94
313	ORD00157	PROD0146	1	9207.08	9207.08
314	ORD00157	PROD0109	5	70228.44	351142.20
315	ORD00158	PROD0223	3	7785.89	23357.67
316	ORD00158	PROD0163	2	18374.63	36749.26
317	ORD00159	PROD0232	2	4469.76	8939.52
318	ORD00160	PROD0003	4	49538.31	198153.24
319	ORD00161	PROD0009	1	198883.60	198883.60
320	ORD00162	PROD0178	4	87684.88	350739.52
321	ORD00163	PROD0063	5	35488.70	177443.50
5788	ORD02716	PROD0205	3	\N	\N
322	ORD00163	PROD0192	1	94625.99	94625.99
323	ORD00164	PROD0116	2	20859.43	41718.86
324	ORD00164	PROD0088	3	\N	\N
325	ORD00164	PROD0046	5	5762.47	28812.35
326	ORD00165	PROD0195	3	24091.13	72273.39
327	ORD00166	PROD0212	5	8757.97	43789.85
328	ORD00166	PROD0229	2	4112.45	8224.90
329	ORD00166	PROD0063	5	35488.70	177443.50
330	ORD00166	PROD0268	4	2944.75	11779.00
331	ORD00167	PROD0136	3	8175.35	24526.05
332	ORD00168	PROD0039	1	257535.23	257535.23
333	ORD00168	PROD0254	2	9824.37	19648.74
334	ORD00169	PROD0271	3	1989.71	5969.13
335	ORD00169	PROD0264	4	4118.15	16472.60
336	ORD00169	PROD0161	2	25829.99	51659.98
337	ORD00170	PROD0263	3	8199.23	24597.69
338	ORD00170	PROD0104	4	\N	\N
339	ORD00170	PROD0205	2	\N	\N
340	ORD00170	PROD0097	3	9141.77	27425.31
341	ORD00170	PROD0036	5	78738.41	393692.05
342	ORD00171	PROD0236	2	7038.57	14077.14
343	ORD00172	PROD0109	2	70228.44	140456.88
344	ORD00173	PROD0196	4	2511.26	10045.04
345	ORD00174	PROD0266	1	408.26	408.26
346	ORD00174	PROD0222	1	2802.33	2802.33
347	ORD00175	PROD0034	5	272513.12	1362565.60
348	ORD00176	PROD0138	2	15463.10	30926.20
349	ORD00176	PROD0254	2	9824.37	19648.74
350	ORD00176	PROD0106	3	137481.28	412443.84
351	ORD00177	PROD0245	3	\N	\N
352	ORD00178	PROD0234	2	6463.53	12927.06
353	ORD00179	PROD0088	5	\N	\N
354	ORD00179	PROD0005	1	85978.02	85978.02
355	ORD00179	PROD0181	4	63768.87	255075.48
356	ORD00179	PROD0243	2	10094.25	20188.50
357	ORD00180	PROD0269	2	2989.48	5978.96
358	ORD00180	PROD0258	1	4792.40	4792.40
359	ORD00180	PROD0086	1	49202.47	49202.47
360	ORD00181	PROD0250	3	4620.81	13862.43
361	ORD00182	PROD0248	1	4809.30	4809.30
362	ORD00182	PROD0058	2	14691.81	29383.62
363	ORD00182	PROD0139	4	14201.82	56807.28
364	ORD00182	PROD0266	2	408.26	816.52
365	ORD00183	PROD0185	1	112356.62	112356.62
366	ORD00183	PROD0106	3	137481.28	412443.84
367	ORD00183	PROD0046	5	5762.47	28812.35
368	ORD00183	PROD0100	4	110269.71	441078.84
369	ORD00183	PROD0194	5	24802.59	124012.95
370	ORD00184	PROD0022	5	222156.94	1110784.70
371	ORD00185	PROD0178	2	87684.88	175369.76
372	ORD00185	PROD0148	4	3628.18	14512.72
373	ORD00185	PROD0057	2	24240.82	48481.64
374	ORD00185	PROD0005	5	85978.02	429890.10
375	ORD00185	PROD0256	3	1625.49	4876.47
376	ORD00186	PROD0021	2	34405.68	68811.36
377	ORD00187	PROD0001	1	279610.57	279610.57
378	ORD00188	PROD0045	3	15761.34	47284.02
379	ORD00189	PROD0017	4	257730.40	1030921.60
380	ORD00190	PROD0155	3	17522.15	52566.45
381	ORD00190	PROD0160	5	12278.28	61391.40
382	ORD00190	PROD0089	2	45090.58	90181.16
383	ORD00190	PROD0224	2	607.93	1215.86
384	ORD00191	PROD0193	1	9954.82	9954.82
385	ORD00191	PROD0224	2	607.93	1215.86
386	ORD00192	PROD0211	1	8250.11	8250.11
387	ORD00192	PROD0237	5	7201.43	36007.15
388	ORD00193	PROD0263	5	8199.23	40996.15
389	ORD00193	PROD0192	5	94625.99	473129.95
390	ORD00193	PROD0066	5	36291.81	181459.05
391	ORD00194	PROD0266	4	408.26	1633.04
392	ORD00195	PROD0050	3	26917.21	80751.63
393	ORD00196	PROD0028	5	316366.34	1581831.70
394	ORD00196	PROD0105	2	162358.65	324717.30
395	ORD00197	PROD0103	1	83304.08	83304.08
396	ORD00197	PROD0059	2	35594.97	71189.94
397	ORD00197	PROD0035	5	190414.55	952072.75
398	ORD00198	PROD0228	1	6170.81	6170.81
399	ORD00198	PROD0201	3	10976.40	32929.20
400	ORD00198	PROD0029	4	149660.33	598641.32
401	ORD00199	PROD0225	5	9270.30	46351.50
402	ORD00200	PROD0262	5	3172.89	15864.45
403	ORD00201	PROD0141	4	11608.58	46434.32
404	ORD00201	PROD0201	1	10976.40	10976.40
405	ORD00202	PROD0006	1	308912.61	308912.61
406	ORD00202	PROD0156	5	21374.21	106871.05
407	ORD00203	PROD0235	3	1609.74	4829.22
408	ORD00203	PROD0142	5	8820.60	44103.00
409	ORD00203	PROD0005	5	85978.02	429890.10
410	ORD00203	PROD0082	2	54346.36	108692.72
411	ORD00204	PROD0181	4	63768.87	255075.48
412	ORD00204	PROD0174	2	110640.11	221280.22
413	ORD00205	PROD0093	3	8480.78	25442.34
414	ORD00205	PROD0260	5	5050.94	25254.70
415	ORD00205	PROD0270	5	907.09	4535.45
416	ORD00205	PROD0133	3	23616.92	70850.76
417	ORD00205	PROD0067	5	11627.77	58138.85
418	ORD00206	PROD0244	2	1664.99	3329.98
419	ORD00206	PROD0166	2	101932.80	203865.60
420	ORD00207	PROD0032	1	246601.80	246601.80
421	ORD00207	PROD0129	4	5323.48	21293.92
422	ORD00207	PROD0059	3	35594.97	106784.91
423	ORD00207	PROD0020	5	293010.61	1465053.05
424	ORD00208	PROD0101	4	114695.41	458781.64
425	ORD00208	PROD0130	4	1182.88	4731.52
426	ORD00209	PROD0013	1	337113.25	337113.25
427	ORD00210	PROD0037	2	266180.98	532361.96
428	ORD00210	PROD0175	5	102750.60	513753.00
429	ORD00211	PROD0071	1	9870.56	9870.56
430	ORD00212	PROD0153	4	10840.50	43362.00
431	ORD00212	PROD0052	2	23501.69	47003.38
432	ORD00212	PROD0061	1	6821.26	6821.26
433	ORD00213	PROD0129	2	5323.48	10646.96
434	ORD00213	PROD0200	3	29196.20	87588.60
435	ORD00213	PROD0184	1	48414.15	48414.15
436	ORD00213	PROD0035	5	190414.55	952072.75
437	ORD00214	PROD0280	5	7685.53	38427.65
438	ORD00214	PROD0057	4	24240.82	96963.28
439	ORD00215	PROD0031	1	290316.23	290316.23
440	ORD00215	PROD0072	2	43142.24	86284.48
441	ORD00215	PROD0105	4	162358.65	649434.60
442	ORD00215	PROD0169	1	41598.42	41598.42
443	ORD00216	PROD0042	2	44258.35	88516.70
444	ORD00216	PROD0246	3	5399.76	16199.28
445	ORD00217	PROD0245	3	\N	\N
446	ORD00218	PROD0010	1	270434.00	270434.00
447	ORD00218	PROD0247	4	5416.29	21665.16
448	ORD00219	PROD0225	1	9270.30	9270.30
449	ORD00220	PROD0122	2	16203.67	32407.34
450	ORD00220	PROD0119	4	47472.78	189891.12
451	ORD00220	PROD0048	5	10843.12	54215.60
452	ORD00220	PROD0006	5	308912.61	1544563.05
453	ORD00221	PROD0065	4	30524.10	122096.40
454	ORD00222	PROD0067	1	11627.77	11627.77
455	ORD00222	PROD0204	3	5933.15	17799.45
456	ORD00222	PROD0246	5	5399.76	26998.80
457	ORD00222	PROD0063	2	35488.70	70977.40
458	ORD00222	PROD0040	4	47715.49	190861.96
459	ORD00223	PROD0150	3	12003.33	36009.99
460	ORD00223	PROD0126	3	13544.05	40632.15
461	ORD00223	PROD0270	5	907.09	4535.45
462	ORD00224	PROD0041	2	14461.31	28922.62
463	ORD00224	PROD0105	5	162358.65	811793.25
464	ORD00225	PROD0121	4	17176.67	68706.68
465	ORD00226	PROD0197	3	113579.08	340737.24
466	ORD00227	PROD0196	4	2511.26	10045.04
467	ORD00227	PROD0197	1	113579.08	113579.08
468	ORD00228	PROD0278	3	6353.37	19060.11
469	ORD00229	PROD0111	5	2676.03	13380.15
470	ORD00229	PROD0015	4	222324.51	889298.04
471	ORD00229	PROD0175	4	102750.60	411002.40
472	ORD00230	PROD0148	5	3628.18	18140.90
473	ORD00231	PROD0122	3	16203.67	48611.01
474	ORD00231	PROD0068	3	43176.46	129529.38
475	ORD00231	PROD0008	1	121518.49	121518.49
476	ORD00232	PROD0186	3	17418.14	52254.42
477	ORD00232	PROD0138	5	15463.10	77315.50
478	ORD00233	PROD0226	4	7172.97	28691.88
479	ORD00233	PROD0005	1	85978.02	85978.02
480	ORD00234	PROD0161	3	25829.99	77489.97
481	ORD00234	PROD0033	3	245627.48	736882.44
482	ORD00234	PROD0226	3	7172.97	21518.91
483	ORD00234	PROD0093	4	8480.78	33923.12
484	ORD00235	PROD0059	1	35594.97	35594.97
485	ORD00236	PROD0117	3	31515.40	94546.20
486	ORD00236	PROD0032	3	246601.80	739805.40
487	ORD00237	PROD0056	1	6299.62	6299.62
488	ORD00238	PROD0213	1	2985.64	2985.64
489	ORD00239	PROD0209	3	2728.52	8185.56
490	ORD00240	PROD0109	3	70228.44	210685.32
491	ORD00241	PROD0194	1	24802.59	24802.59
492	ORD00241	PROD0017	1	257730.40	257730.40
493	ORD00241	PROD0077	2	20510.26	41020.52
494	ORD00241	PROD0196	5	2511.26	12556.30
495	ORD00242	PROD0271	5	1989.71	9948.55
496	ORD00242	PROD0027	5	26206.57	131032.85
497	ORD00242	PROD0242	4	5755.30	23021.20
498	ORD00243	PROD0186	2	17418.14	34836.28
499	ORD00244	PROD0181	5	63768.87	318844.35
500	ORD00245	PROD0065	2	30524.10	61048.20
501	ORD00245	PROD0276	4	6563.88	26255.52
502	ORD00246	PROD0076	2	27116.85	54233.70
503	ORD00246	PROD0254	2	9824.37	19648.74
504	ORD00247	PROD0241	1	1174.07	1174.07
505	ORD00247	PROD0052	4	23501.69	94006.76
506	ORD00247	PROD0065	1	30524.10	30524.10
507	ORD00248	PROD0217	5	7092.62	35463.10
508	ORD00248	PROD0182	2	33297.75	66595.50
509	ORD00248	PROD0066	3	36291.81	108875.43
510	ORD00248	PROD0206	1	5427.42	5427.42
511	ORD00249	PROD0024	1	321716.92	321716.92
512	ORD00250	PROD0245	2	\N	\N
513	ORD00251	PROD0004	5	39811.79	199058.95
514	ORD00252	PROD0050	2	26917.21	53834.42
515	ORD00253	PROD0219	3	14849.13	44547.39
516	ORD00253	PROD0147	4	5055.12	20220.48
517	ORD00254	PROD0143	1	13171.72	13171.72
518	ORD00254	PROD0161	3	25829.99	77489.97
519	ORD00255	PROD0133	2	23616.92	47233.84
520	ORD00255	PROD0055	1	42567.03	42567.03
521	ORD00255	PROD0119	2	47472.78	94945.56
522	ORD00255	PROD0143	5	13171.72	65858.60
523	ORD00256	PROD0277	1	9657.13	9657.13
524	ORD00256	PROD0276	3	6563.88	19691.64
525	ORD00256	PROD0100	2	110269.71	220539.42
526	ORD00256	PROD0004	3	39811.79	119435.37
527	ORD00256	PROD0251	5	5175.86	25879.30
528	ORD00257	PROD0222	3	2802.33	8406.99
529	ORD00257	PROD0253	1	8743.34	8743.34
530	ORD00258	PROD0168	3	100026.32	300078.96
531	ORD00258	PROD0081	3	110991.10	332973.30
532	ORD00258	PROD0260	4	5050.94	20203.76
533	ORD00259	PROD0020	3	293010.61	879031.83
534	ORD00259	PROD0222	2	2802.33	5604.66
535	ORD00259	PROD0052	5	23501.69	117508.45
536	ORD00259	PROD0267	1	6230.11	6230.11
537	ORD00260	PROD0136	2	8175.35	16350.70
538	ORD00260	PROD0241	4	1174.07	4696.28
539	ORD00261	PROD0110	5	23332.73	116663.65
540	ORD00261	PROD0002	5	102447.74	512238.70
541	ORD00261	PROD0223	2	7785.89	15571.78
542	ORD00261	PROD0035	2	190414.55	380829.10
543	ORD00261	PROD0252	1	8223.52	8223.52
544	ORD00262	PROD0248	2	4809.30	9618.60
545	ORD00262	PROD0272	3	11096.23	33288.69
546	ORD00263	PROD0050	1	26917.21	26917.21
547	ORD00263	PROD0113	3	145706.19	437118.57
548	ORD00264	PROD0164	1	6702.72	6702.72
549	ORD00265	PROD0121	3	17176.67	51530.01
550	ORD00265	PROD0015	3	222324.51	666973.53
551	ORD00266	PROD0227	4	9871.34	39485.36
552	ORD00267	PROD0024	4	321716.92	1286867.68
553	ORD00267	PROD0158	4	12650.30	50601.20
554	ORD00268	PROD0169	1	41598.42	41598.42
555	ORD00268	PROD0067	4	11627.77	46511.08
556	ORD00268	PROD0277	1	9657.13	9657.13
557	ORD00268	PROD0011	3	314229.61	942688.83
558	ORD00269	PROD0275	2	10193.83	20387.66
559	ORD00270	PROD0111	5	2676.03	13380.15
560	ORD00271	PROD0204	4	5933.15	23732.60
561	ORD00272	PROD0068	1	43176.46	43176.46
562	ORD00272	PROD0139	1	14201.82	14201.82
563	ORD00273	PROD0049	3	27088.42	81265.26
564	ORD00273	PROD0201	4	10976.40	43905.60
565	ORD00273	PROD0100	5	110269.71	551348.55
566	ORD00273	PROD0160	1	12278.28	12278.28
567	ORD00274	PROD0048	2	10843.12	21686.24
568	ORD00275	PROD0009	4	198883.60	795534.40
569	ORD00276	PROD0119	4	47472.78	189891.12
570	ORD00277	PROD0049	1	27088.42	27088.42
571	ORD00277	PROD0087	2	12717.02	25434.04
572	ORD00277	PROD0107	4	97418.23	389672.92
573	ORD00277	PROD0251	5	5175.86	25879.30
574	ORD00277	PROD0128	4	24463.34	97853.36
575	ORD00278	PROD0160	3	12278.28	36834.84
576	ORD00279	PROD0138	4	15463.10	61852.40
577	ORD00279	PROD0108	3	121332.02	363996.06
578	ORD00279	PROD0251	2	5175.86	10351.72
579	ORD00279	PROD0280	3	7685.53	23056.59
580	ORD00280	PROD0218	1	5238.20	5238.20
581	ORD00280	PROD0040	2	47715.49	95430.98
582	ORD00280	PROD0193	5	9954.82	49774.10
583	ORD00280	PROD0066	1	36291.81	36291.81
584	ORD00281	PROD0269	4	2989.48	11957.92
585	ORD00282	PROD0151	5	24271.64	121358.20
586	ORD00282	PROD0139	3	14201.82	42605.46
587	ORD00283	PROD0191	4	44052.51	176210.04
588	ORD00283	PROD0266	4	408.26	1633.04
589	ORD00283	PROD0129	2	5323.48	10646.96
590	ORD00284	PROD0214	2	12483.89	24967.78
591	ORD00285	PROD0276	3	6563.88	19691.64
592	ORD00285	PROD0235	1	1609.74	1609.74
593	ORD00286	PROD0177	3	102403.06	307209.18
594	ORD00286	PROD0008	4	121518.49	486073.96
595	ORD00286	PROD0099	5	130788.21	653941.05
596	ORD00286	PROD0141	3	11608.58	34825.74
597	ORD00287	PROD0079	1	13912.80	13912.80
598	ORD00288	PROD0197	5	113579.08	567895.40
599	ORD00288	PROD0170	4	45302.42	181209.68
600	ORD00288	PROD0142	2	8820.60	17641.20
601	ORD00289	PROD0001	3	279610.57	838831.71
602	ORD00290	PROD0242	3	5755.30	17265.90
603	ORD00290	PROD0168	5	100026.32	500131.60
604	ORD00291	PROD0268	3	2944.75	8834.25
605	ORD00292	PROD0074	4	13460.87	53843.48
606	ORD00292	PROD0224	3	607.93	1823.79
607	ORD00292	PROD0227	1	9871.34	9871.34
608	ORD00293	PROD0178	5	87684.88	438424.40
609	ORD00293	PROD0218	5	5238.20	26191.00
610	ORD00293	PROD0110	2	23332.73	46665.46
611	ORD00294	PROD0159	3	17483.90	52451.70
612	ORD00295	PROD0018	4	120439.60	481758.40
613	ORD00295	PROD0141	4	11608.58	46434.32
614	ORD00296	PROD0242	2	5755.30	11510.60
615	ORD00296	PROD0233	4	10621.64	42486.56
616	ORD00296	PROD0252	5	8223.52	41117.60
617	ORD00297	PROD0032	1	246601.80	246601.80
618	ORD00297	PROD0161	5	25829.99	129149.95
619	ORD00298	PROD0087	4	12717.02	50868.08
620	ORD00298	PROD0188	4	51993.13	207972.52
621	ORD00298	PROD0265	1	11740.65	11740.65
622	ORD00298	PROD0008	1	121518.49	121518.49
623	ORD00299	PROD0023	3	276589.43	829768.29
624	ORD00300	PROD0180	1	60582.65	60582.65
625	ORD00301	PROD0096	2	179864.29	359728.58
626	ORD00301	PROD0163	1	18374.63	18374.63
627	ORD00301	PROD0011	2	314229.61	628459.22
628	ORD00302	PROD0195	3	24091.13	72273.39
629	ORD00303	PROD0091	3	141135.80	423407.40
630	ORD00303	PROD0152	1	1904.28	1904.28
631	ORD00303	PROD0133	4	23616.92	94467.68
632	ORD00303	PROD0226	3	7172.97	21518.91
633	ORD00304	PROD0088	5	\N	\N
634	ORD00304	PROD0019	4	339524.65	1358098.60
635	ORD00305	PROD0258	5	4792.40	23962.00
636	ORD00306	PROD0240	3	10219.29	30657.87
637	ORD00307	PROD0194	5	24802.59	124012.95
638	ORD00308	PROD0244	3	1664.99	4994.97
639	ORD00309	PROD0280	2	7685.53	15371.06
640	ORD00310	PROD0243	3	10094.25	30282.75
641	ORD00310	PROD0125	5	22153.16	110765.80
642	ORD00310	PROD0130	3	1182.88	3548.64
643	ORD00311	PROD0260	4	5050.94	20203.76
644	ORD00311	PROD0056	3	6299.62	18898.86
645	ORD00311	PROD0216	5	3485.44	17427.20
646	ORD00312	PROD0269	1	2989.48	2989.48
647	ORD00312	PROD0102	1	45021.16	45021.16
648	ORD00312	PROD0072	3	43142.24	129426.72
649	ORD00312	PROD0067	2	11627.77	23255.54
650	ORD00312	PROD0171	3	105588.96	316766.88
651	ORD00313	PROD0105	4	162358.65	649434.60
652	ORD00314	PROD0202	4	12764.12	51056.48
653	ORD00314	PROD0109	4	70228.44	280913.76
654	ORD00315	PROD0069	4	39168.98	156675.92
655	ORD00316	PROD0274	3	7846.95	23540.85
656	ORD00316	PROD0037	4	266180.98	1064723.92
657	ORD00317	PROD0189	5	96833.78	484168.90
658	ORD00317	PROD0186	1	17418.14	17418.14
659	ORD00317	PROD0175	5	102750.60	513753.00
660	ORD00318	PROD0023	3	276589.43	829768.29
661	ORD00318	PROD0109	4	70228.44	280913.76
662	ORD00319	PROD0216	2	3485.44	6970.88
663	ORD00320	PROD0052	1	23501.69	23501.69
664	ORD00320	PROD0208	2	9010.85	18021.70
665	ORD00321	PROD0206	1	5427.42	5427.42
666	ORD00321	PROD0217	3	7092.62	21277.86
667	ORD00322	PROD0243	5	10094.25	50471.25
668	ORD00322	PROD0172	3	95695.43	287086.29
669	ORD00323	PROD0041	5	14461.31	72306.55
670	ORD00323	PROD0077	3	20510.26	61530.78
671	ORD00323	PROD0004	2	39811.79	79623.58
672	ORD00323	PROD0173	5	39177.27	195886.35
673	ORD00324	PROD0251	4	5175.86	20703.44
674	ORD00325	PROD0013	3	337113.25	1011339.75
675	ORD00325	PROD0278	2	6353.37	12706.74
676	ORD00326	PROD0019	5	339524.65	1697623.25
677	ORD00327	PROD0253	3	8743.34	26230.02
678	ORD00327	PROD0221	4	13121.51	52486.04
679	ORD00327	PROD0141	5	11608.58	58042.90
680	ORD00328	PROD0191	1	44052.51	44052.51
681	ORD00329	PROD0155	2	17522.15	35044.30
682	ORD00329	PROD0217	3	7092.62	21277.86
683	ORD00329	PROD0206	1	5427.42	5427.42
684	ORD00329	PROD0012	4	248709.70	994838.80
685	ORD00330	PROD0125	3	22153.16	66459.48
686	ORD00330	PROD0026	5	34248.48	171242.40
687	ORD00331	PROD0024	2	321716.92	643433.84
688	ORD00331	PROD0205	3	\N	\N
689	ORD00332	PROD0137	4	2019.05	8076.20
690	ORD00333	PROD0114	5	7586.49	37932.45
691	ORD00333	PROD0033	4	245627.48	982509.92
692	ORD00333	PROD0148	5	3628.18	18140.90
693	ORD00334	PROD0164	3	6702.72	20108.16
694	ORD00335	PROD0207	1	11561.20	11561.20
695	ORD00336	PROD0043	3	16739.67	50219.01
696	ORD00336	PROD0107	3	97418.23	292254.69
697	ORD00336	PROD0272	4	11096.23	44384.92
698	ORD00336	PROD0190	4	22778.54	91114.16
699	ORD00336	PROD0156	1	21374.21	21374.21
700	ORD00337	PROD0252	4	8223.52	32894.08
701	ORD00337	PROD0121	5	17176.67	85883.35
702	ORD00338	PROD0092	4	140982.24	563928.96
703	ORD00338	PROD0082	5	54346.36	271731.80
704	ORD00339	PROD0186	1	17418.14	17418.14
705	ORD00340	PROD0273	2	1784.35	3568.70
706	ORD00340	PROD0201	4	10976.40	43905.60
707	ORD00341	PROD0091	5	141135.80	705679.00
708	ORD00341	PROD0205	3	\N	\N
709	ORD00341	PROD0148	4	3628.18	14512.72
710	ORD00341	PROD0002	2	102447.74	204895.48
711	ORD00342	PROD0015	2	222324.51	444649.02
712	ORD00342	PROD0115	5	2277.24	11386.20
713	ORD00343	PROD0167	1	22365.17	22365.17
714	ORD00343	PROD0128	3	24463.34	73390.02
715	ORD00343	PROD0086	1	49202.47	49202.47
716	ORD00343	PROD0242	5	5755.30	28776.50
717	ORD00344	PROD0123	4	11097.43	44389.72
718	ORD00344	PROD0090	2	102715.97	205431.94
719	ORD00345	PROD0228	2	6170.81	12341.62
720	ORD00346	PROD0082	1	54346.36	54346.36
721	ORD00346	PROD0126	1	13544.05	13544.05
722	ORD00346	PROD0237	1	7201.43	7201.43
723	ORD00347	PROD0276	4	6563.88	26255.52
724	ORD00347	PROD0062	4	22431.17	89724.68
725	ORD00347	PROD0274	1	7846.95	7846.95
726	ORD00347	PROD0013	3	337113.25	1011339.75
727	ORD00348	PROD0220	1	11275.57	11275.57
728	ORD00348	PROD0064	2	34644.88	69289.76
729	ORD00349	PROD0188	2	51993.13	103986.26
730	ORD00349	PROD0212	2	8757.97	17515.94
731	ORD00349	PROD0174	4	110640.11	442560.44
732	ORD00350	PROD0252	3	8223.52	24670.56
733	ORD00350	PROD0126	4	13544.05	54176.20
734	ORD00350	PROD0134	3	19220.41	57661.23
735	ORD00350	PROD0176	4	30789.84	123159.36
736	ORD00351	PROD0014	3	289145.53	867436.59
737	ORD00351	PROD0114	5	7586.49	37932.45
738	ORD00352	PROD0226	2	7172.97	14345.94
739	ORD00352	PROD0151	2	24271.64	48543.28
740	ORD00353	PROD0156	3	21374.21	64122.63
741	ORD00353	PROD0076	5	27116.85	135584.25
742	ORD00353	PROD0007	5	290642.30	1453211.50
743	ORD00353	PROD0133	4	23616.92	94467.68
744	ORD00354	PROD0161	4	25829.99	103319.96
745	ORD00354	PROD0268	2	2944.75	5889.50
746	ORD00354	PROD0192	5	94625.99	473129.95
747	ORD00354	PROD0194	4	24802.59	99210.36
748	ORD00355	PROD0159	2	17483.90	34967.80
749	ORD00356	PROD0183	4	26053.15	104212.60
750	ORD00356	PROD0256	5	1625.49	8127.45
751	ORD00357	PROD0104	1	\N	\N
752	ORD00357	PROD0187	3	28776.04	86328.12
753	ORD00357	PROD0017	5	257730.40	1288652.00
754	ORD00357	PROD0205	1	\N	\N
755	ORD00358	PROD0029	3	149660.33	448980.99
756	ORD00358	PROD0229	2	4112.45	8224.90
757	ORD00358	PROD0268	2	2944.75	5889.50
758	ORD00358	PROD0127	2	8700.29	17400.58
759	ORD00358	PROD0126	4	13544.05	54176.20
760	ORD00359	PROD0033	3	245627.48	736882.44
761	ORD00359	PROD0068	1	43176.46	43176.46
762	ORD00359	PROD0268	2	2944.75	5889.50
763	ORD00360	PROD0027	4	26206.57	104826.28
764	ORD00360	PROD0164	1	6702.72	6702.72
765	ORD00360	PROD0038	4	88262.22	353048.88
766	ORD00360	PROD0101	1	114695.41	114695.41
767	ORD00361	PROD0221	4	13121.51	52486.04
768	ORD00361	PROD0058	2	14691.81	29383.62
769	ORD00362	PROD0091	3	141135.80	423407.40
770	ORD00363	PROD0141	5	11608.58	58042.90
771	ORD00364	PROD0164	4	6702.72	26810.88
772	ORD00364	PROD0261	4	8607.87	34431.48
773	ORD00365	PROD0227	2	9871.34	19742.68
774	ORD00365	PROD0176	1	30789.84	30789.84
775	ORD00365	PROD0276	2	6563.88	13127.76
776	ORD00365	PROD0094	2	117897.53	235795.06
777	ORD00366	PROD0108	3	121332.02	363996.06
778	ORD00366	PROD0080	2	14845.55	29691.10
779	ORD00367	PROD0214	2	12483.89	24967.78
780	ORD00367	PROD0138	3	15463.10	46389.30
781	ORD00368	PROD0162	4	2672.21	10688.84
782	ORD00368	PROD0231	5	6206.49	31032.45
783	ORD00368	PROD0158	4	12650.30	50601.20
784	ORD00369	PROD0072	3	43142.24	129426.72
785	ORD00369	PROD0234	1	6463.53	6463.53
786	ORD00370	PROD0196	3	2511.26	7533.78
787	ORD00371	PROD0055	3	42567.03	127701.09
788	ORD00371	PROD0039	4	257535.23	1030140.92
789	ORD00371	PROD0125	5	22153.16	110765.80
790	ORD00371	PROD0083	4	160848.97	643395.88
791	ORD00372	PROD0193	1	9954.82	9954.82
792	ORD00373	PROD0057	3	24240.82	72722.46
793	ORD00373	PROD0242	4	5755.30	23021.20
794	ORD00373	PROD0069	2	39168.98	78337.96
795	ORD00373	PROD0038	2	88262.22	176524.44
796	ORD00374	PROD0134	3	19220.41	57661.23
797	ORD00374	PROD0272	1	11096.23	11096.23
798	ORD00375	PROD0229	4	4112.45	16449.80
799	ORD00375	PROD0110	2	23332.73	46665.46
800	ORD00375	PROD0095	4	49921.23	199684.92
801	ORD00375	PROD0165	3	22136.37	66409.11
802	ORD00376	PROD0211	4	8250.11	33000.44
803	ORD00377	PROD0263	1	8199.23	8199.23
804	ORD00377	PROD0192	5	94625.99	473129.95
805	ORD00377	PROD0009	3	198883.60	596650.80
806	ORD00377	PROD0224	5	607.93	3039.65
807	ORD00378	PROD0058	5	14691.81	73459.05
808	ORD00379	PROD0098	4	54814.26	219257.04
809	ORD00379	PROD0038	3	88262.22	264786.66
810	ORD00380	PROD0174	4	110640.11	442560.44
811	ORD00381	PROD0004	1	39811.79	39811.79
812	ORD00381	PROD0200	1	29196.20	29196.20
813	ORD00382	PROD0168	4	100026.32	400105.28
814	ORD00382	PROD0273	2	1784.35	3568.70
815	ORD00383	PROD0093	1	8480.78	8480.78
816	ORD00384	PROD0162	2	2672.21	5344.42
817	ORD00385	PROD0112	4	35280.59	141122.36
818	ORD00385	PROD0182	1	33297.75	33297.75
819	ORD00385	PROD0014	4	289145.53	1156582.12
820	ORD00385	PROD0071	1	9870.56	9870.56
821	ORD00386	PROD0106	4	137481.28	549925.12
822	ORD00387	PROD0108	1	121332.02	121332.02
823	ORD00388	PROD0108	5	121332.02	606660.10
824	ORD00388	PROD0047	3	5512.81	16538.43
825	ORD00389	PROD0052	3	23501.69	70505.07
826	ORD00389	PROD0182	3	33297.75	99893.25
827	ORD00390	PROD0200	1	29196.20	29196.20
828	ORD00390	PROD0242	3	5755.30	17265.90
829	ORD00391	PROD0066	2	36291.81	72583.62
830	ORD00391	PROD0266	2	408.26	816.52
831	ORD00392	PROD0151	4	24271.64	97086.56
832	ORD00392	PROD0191	2	44052.51	88105.02
833	ORD00392	PROD0213	2	2985.64	5971.28
834	ORD00392	PROD0081	5	110991.10	554955.50
835	ORD00393	PROD0105	3	162358.65	487075.95
836	ORD00394	PROD0241	1	1174.07	1174.07
837	ORD00395	PROD0087	1	12717.02	12717.02
838	ORD00395	PROD0081	3	110991.10	332973.30
839	ORD00395	PROD0052	2	23501.69	47003.38
840	ORD00396	PROD0275	4	10193.83	40775.32
841	ORD00396	PROD0226	4	7172.97	28691.88
842	ORD00396	PROD0069	3	39168.98	117506.94
843	ORD00396	PROD0001	2	279610.57	559221.14
844	ORD00396	PROD0160	3	12278.28	36834.84
845	ORD00397	PROD0101	2	114695.41	229390.82
846	ORD00397	PROD0065	5	30524.10	152620.50
847	ORD00398	PROD0145	2	22657.06	45314.12
848	ORD00398	PROD0054	3	31709.48	95128.44
849	ORD00398	PROD0128	2	24463.34	48926.68
850	ORD00399	PROD0265	2	11740.65	23481.30
851	ORD00399	PROD0137	3	2019.05	6057.15
852	ORD00400	PROD0008	4	121518.49	486073.96
853	ORD00400	PROD0074	3	13460.87	40382.61
854	ORD00400	PROD0018	1	120439.60	120439.60
855	ORD00400	PROD0122	5	16203.67	81018.35
856	ORD00400	PROD0083	4	160848.97	643395.88
857	ORD00401	PROD0110	5	23332.73	116663.65
858	ORD00401	PROD0233	3	10621.64	31864.92
859	ORD00402	PROD0173	4	39177.27	156709.08
860	ORD00402	PROD0096	5	179864.29	899321.45
861	ORD00402	PROD0131	4	21092.44	84369.76
862	ORD00402	PROD0175	1	102750.60	102750.60
863	ORD00403	PROD0279	1	962.48	962.48
864	ORD00403	PROD0065	2	30524.10	61048.20
865	ORD00404	PROD0178	3	87684.88	263054.64
866	ORD00405	PROD0262	2	3172.89	6345.78
867	ORD00406	PROD0078	5	18117.48	90587.40
868	ORD00406	PROD0272	1	11096.23	11096.23
869	ORD00407	PROD0082	1	54346.36	54346.36
870	ORD00408	PROD0218	3	5238.20	15714.60
871	ORD00408	PROD0104	1	\N	\N
872	ORD00409	PROD0240	1	10219.29	10219.29
873	ORD00409	PROD0165	1	22136.37	22136.37
874	ORD00409	PROD0070	3	25905.43	77716.29
875	ORD00409	PROD0154	5	19738.96	98694.80
876	ORD00410	PROD0072	2	43142.24	86284.48
877	ORD00410	PROD0074	2	13460.87	26921.74
878	ORD00410	PROD0247	4	5416.29	21665.16
879	ORD00411	PROD0037	2	266180.98	532361.96
880	ORD00411	PROD0116	4	20859.43	83437.72
881	ORD00411	PROD0142	1	8820.60	8820.60
882	ORD00412	PROD0168	1	100026.32	100026.32
883	ORD00413	PROD0153	5	10840.50	54202.50
884	ORD00413	PROD0064	5	34644.88	173224.40
885	ORD00414	PROD0131	1	21092.44	21092.44
886	ORD00415	PROD0046	2	5762.47	11524.94
887	ORD00415	PROD0186	4	17418.14	69672.56
888	ORD00416	PROD0142	3	8820.60	26461.80
889	ORD00416	PROD0129	4	5323.48	21293.92
890	ORD00416	PROD0261	3	8607.87	25823.61
891	ORD00417	PROD0254	2	9824.37	19648.74
892	ORD00418	PROD0193	4	9954.82	39819.28
893	ORD00418	PROD0266	1	408.26	408.26
894	ORD00419	PROD0123	3	11097.43	33292.29
895	ORD00419	PROD0185	4	112356.62	449426.48
896	ORD00419	PROD0216	4	3485.44	13941.76
897	ORD00419	PROD0202	5	12764.12	63820.60
898	ORD00419	PROD0021	5	34405.68	172028.40
899	ORD00420	PROD0093	1	8480.78	8480.78
900	ORD00421	PROD0130	3	1182.88	3548.64
901	ORD00421	PROD0184	2	48414.15	96828.30
902	ORD00421	PROD0177	3	102403.06	307209.18
903	ORD00422	PROD0083	2	160848.97	321697.94
904	ORD00423	PROD0089	3	45090.58	135271.74
905	ORD00423	PROD0256	3	1625.49	4876.47
906	ORD00423	PROD0046	5	5762.47	28812.35
907	ORD00424	PROD0047	2	5512.81	11025.62
908	ORD00424	PROD0208	4	9010.85	36043.40
909	ORD00424	PROD0161	2	25829.99	51659.98
910	ORD00424	PROD0255	3	7571.15	22713.45
911	ORD00425	PROD0087	1	12717.02	12717.02
912	ORD00425	PROD0166	2	101932.80	203865.60
913	ORD00425	PROD0009	5	198883.60	994418.00
914	ORD00426	PROD0204	2	5933.15	11866.30
915	ORD00426	PROD0039	1	257535.23	257535.23
916	ORD00427	PROD0273	2	1784.35	3568.70
917	ORD00427	PROD0182	4	33297.75	133191.00
918	ORD00427	PROD0204	1	5933.15	5933.15
919	ORD00428	PROD0116	4	20859.43	83437.72
920	ORD00429	PROD0115	2	2277.24	4554.48
921	ORD00430	PROD0125	1	22153.16	22153.16
922	ORD00431	PROD0096	5	179864.29	899321.45
923	ORD00432	PROD0135	3	2595.60	7786.80
924	ORD00432	PROD0221	2	13121.51	26243.02
925	ORD00432	PROD0190	3	22778.54	68335.62
926	ORD00433	PROD0050	4	26917.21	107668.84
927	ORD00433	PROD0260	5	5050.94	25254.70
928	ORD00434	PROD0115	5	2277.24	11386.20
929	ORD00434	PROD0239	4	1047.73	4190.92
930	ORD00434	PROD0138	4	15463.10	61852.40
931	ORD00434	PROD0028	5	316366.34	1581831.70
932	ORD00434	PROD0236	4	7038.57	28154.28
933	ORD00435	PROD0178	2	87684.88	175369.76
934	ORD00435	PROD0245	1	\N	\N
935	ORD00436	PROD0252	4	8223.52	32894.08
936	ORD00436	PROD0221	2	13121.51	26243.02
937	ORD00436	PROD0069	4	39168.98	156675.92
938	ORD00437	PROD0074	5	13460.87	67304.35
939	ORD00437	PROD0277	1	9657.13	9657.13
940	ORD00437	PROD0162	3	2672.21	8016.63
941	ORD00437	PROD0004	5	39811.79	199058.95
942	ORD00438	PROD0128	1	24463.34	24463.34
943	ORD00438	PROD0092	4	140982.24	563928.96
944	ORD00438	PROD0093	1	8480.78	8480.78
945	ORD00439	PROD0071	2	9870.56	19741.12
946	ORD00439	PROD0176	1	30789.84	30789.84
947	ORD00440	PROD0134	4	19220.41	76881.64
948	ORD00441	PROD0011	5	314229.61	1571148.05
949	ORD00441	PROD0032	1	246601.80	246601.80
950	ORD00442	PROD0168	4	100026.32	400105.28
951	ORD00443	PROD0256	2	1625.49	3250.98
952	ORD00444	PROD0091	2	141135.80	282271.60
953	ORD00444	PROD0226	5	7172.97	35864.85
954	ORD00445	PROD0062	3	22431.17	67293.51
955	ORD00445	PROD0160	2	12278.28	24556.56
956	ORD00445	PROD0150	5	12003.33	60016.65
957	ORD00445	PROD0056	5	6299.62	31498.10
958	ORD00446	PROD0200	1	29196.20	29196.20
959	ORD00446	PROD0230	5	6077.64	30388.20
960	ORD00447	PROD0207	1	11561.20	11561.20
961	ORD00448	PROD0267	1	6230.11	6230.11
962	ORD00449	PROD0202	2	12764.12	25528.24
963	ORD00449	PROD0280	3	7685.53	23056.59
964	ORD00450	PROD0194	4	24802.59	99210.36
965	ORD00450	PROD0043	1	16739.67	16739.67
966	ORD00451	PROD0148	5	3628.18	18140.90
967	ORD00451	PROD0029	1	149660.33	149660.33
968	ORD00452	PROD0161	5	25829.99	129149.95
969	ORD00452	PROD0025	1	330590.39	330590.39
970	ORD00453	PROD0223	2	7785.89	15571.78
971	ORD00453	PROD0261	5	8607.87	43039.35
972	ORD00453	PROD0269	3	2989.48	8968.44
973	ORD00454	PROD0038	2	88262.22	176524.44
974	ORD00454	PROD0105	5	162358.65	811793.25
975	ORD00454	PROD0254	5	9824.37	49121.85
976	ORD00455	PROD0170	3	45302.42	135907.26
977	ORD00455	PROD0091	4	141135.80	564543.20
978	ORD00455	PROD0200	1	29196.20	29196.20
979	ORD00455	PROD0117	2	31515.40	63030.80
980	ORD00456	PROD0159	3	17483.90	52451.70
981	ORD00456	PROD0105	4	162358.65	649434.60
982	ORD00457	PROD0250	4	4620.81	18483.24
983	ORD00457	PROD0130	1	1182.88	1182.88
984	ORD00457	PROD0006	4	308912.61	1235650.44
985	ORD00458	PROD0132	3	23990.67	71972.01
986	ORD00458	PROD0204	3	5933.15	17799.45
987	ORD00458	PROD0146	5	9207.08	46035.40
988	ORD00458	PROD0275	3	10193.83	30581.49
989	ORD00459	PROD0103	1	83304.08	83304.08
990	ORD00459	PROD0066	4	36291.81	145167.24
991	ORD00459	PROD0266	4	408.26	1633.04
992	ORD00460	PROD0124	4	17164.25	68657.00
993	ORD00460	PROD0224	2	607.93	1215.86
994	ORD00460	PROD0190	4	22778.54	91114.16
995	ORD00461	PROD0163	2	18374.63	36749.26
996	ORD00461	PROD0023	3	276589.43	829768.29
997	ORD00461	PROD0008	3	121518.49	364555.47
998	ORD00462	PROD0079	3	13912.80	41738.40
999	ORD00463	PROD0226	1	7172.97	7172.97
1000	ORD00464	PROD0163	1	18374.63	18374.63
1001	ORD00464	PROD0030	1	253935.11	253935.11
1002	ORD00465	PROD0074	1	13460.87	13460.87
1003	ORD00466	PROD0062	5	22431.17	112155.85
1004	ORD00466	PROD0115	5	2277.24	11386.20
1005	ORD00466	PROD0019	1	339524.65	339524.65
1006	ORD00467	PROD0122	5	16203.67	81018.35
1007	ORD00467	PROD0252	3	8223.52	24670.56
1008	ORD00468	PROD0185	2	112356.62	224713.24
1009	ORD00468	PROD0115	3	2277.24	6831.72
1010	ORD00469	PROD0011	4	314229.61	1256918.44
1011	ORD00470	PROD0065	4	30524.10	122096.40
1012	ORD00470	PROD0181	4	63768.87	255075.48
1013	ORD00470	PROD0107	4	97418.23	389672.92
1014	ORD00470	PROD0208	4	9010.85	36043.40
1015	ORD00470	PROD0216	4	3485.44	13941.76
1016	ORD00471	PROD0187	5	28776.04	143880.20
1017	ORD00471	PROD0238	4	6026.76	24107.04
1018	ORD00472	PROD0154	1	19738.96	19738.96
1019	ORD00472	PROD0212	2	8757.97	17515.94
1020	ORD00473	PROD0227	2	9871.34	19742.68
1021	ORD00473	PROD0013	4	337113.25	1348453.00
1022	ORD00474	PROD0102	4	45021.16	180084.64
1023	ORD00474	PROD0078	3	18117.48	54352.44
1024	ORD00475	PROD0019	1	339524.65	339524.65
1025	ORD00475	PROD0050	1	26917.21	26917.21
1026	ORD00476	PROD0183	3	26053.15	78159.45
1027	ORD00476	PROD0104	1	\N	\N
1028	ORD00476	PROD0078	3	18117.48	54352.44
1029	ORD00476	PROD0110	5	23332.73	116663.65
1030	ORD00477	PROD0052	5	23501.69	117508.45
1031	ORD00478	PROD0241	2	1174.07	2348.14
1032	ORD00478	PROD0144	1	801.07	801.07
1033	ORD00479	PROD0243	1	10094.25	10094.25
1034	ORD00479	PROD0195	5	24091.13	120455.65
1035	ORD00479	PROD0245	3	\N	\N
1036	ORD00479	PROD0088	4	\N	\N
1037	ORD00480	PROD0174	3	110640.11	331920.33
1038	ORD00480	PROD0044	1	32574.27	32574.27
1039	ORD00481	PROD0101	5	114695.41	573477.05
1040	ORD00481	PROD0165	4	22136.37	88545.48
1041	ORD00481	PROD0150	1	12003.33	12003.33
1042	ORD00481	PROD0043	5	16739.67	83698.35
1043	ORD00481	PROD0182	5	33297.75	166488.75
1044	ORD00482	PROD0013	1	337113.25	337113.25
1045	ORD00482	PROD0251	2	5175.86	10351.72
1046	ORD00482	PROD0164	3	6702.72	20108.16
1047	ORD00482	PROD0086	3	49202.47	147607.41
1048	ORD00483	PROD0067	5	11627.77	58138.85
1049	ORD00483	PROD0006	1	308912.61	308912.61
1050	ORD00484	PROD0193	3	9954.82	29864.46
1051	ORD00484	PROD0172	5	95695.43	478477.15
1052	ORD00485	PROD0251	3	5175.86	15527.58
1053	ORD00485	PROD0145	1	22657.06	22657.06
1054	ORD00486	PROD0059	2	35594.97	71189.94
1055	ORD00486	PROD0012	1	248709.70	248709.70
1056	ORD00486	PROD0066	2	36291.81	72583.62
1057	ORD00486	PROD0055	3	42567.03	127701.09
1058	ORD00487	PROD0007	3	290642.30	871926.90
1059	ORD00488	PROD0063	1	35488.70	35488.70
1060	ORD00489	PROD0047	1	5512.81	5512.81
1061	ORD00490	PROD0272	2	11096.23	22192.46
1062	ORD00491	PROD0032	2	246601.80	493203.60
1063	ORD00491	PROD0227	5	9871.34	49356.70
1064	ORD00492	PROD0064	2	34644.88	69289.76
1065	ORD00492	PROD0039	2	257535.23	515070.46
1066	ORD00492	PROD0097	4	9141.77	36567.08
1067	ORD00492	PROD0096	5	179864.29	899321.45
1068	ORD00492	PROD0165	3	22136.37	66409.11
1069	ORD00493	PROD0272	3	11096.23	33288.69
1070	ORD00493	PROD0004	2	39811.79	79623.58
1071	ORD00493	PROD0129	1	5323.48	5323.48
1072	ORD00494	PROD0229	1	4112.45	4112.45
1073	ORD00494	PROD0007	3	290642.30	871926.90
1074	ORD00495	PROD0034	3	272513.12	817539.36
1075	ORD00495	PROD0135	4	2595.60	10382.40
1076	ORD00496	PROD0088	1	\N	\N
1077	ORD00497	PROD0238	2	6026.76	12053.52
1078	ORD00497	PROD0232	2	4469.76	8939.52
1079	ORD00498	PROD0077	4	20510.26	82041.04
1080	ORD00499	PROD0009	4	198883.60	795534.40
1081	ORD00500	PROD0143	2	13171.72	26343.44
1082	ORD00501	PROD0031	1	290316.23	290316.23
1083	ORD00501	PROD0181	1	63768.87	63768.87
1084	ORD00502	PROD0111	3	2676.03	8028.09
1085	ORD00502	PROD0214	2	12483.89	24967.78
1086	ORD00502	PROD0252	3	8223.52	24670.56
1087	ORD00502	PROD0007	3	290642.30	871926.90
1088	ORD00503	PROD0192	2	94625.99	189251.98
1089	ORD00504	PROD0168	2	100026.32	200052.64
1090	ORD00505	PROD0100	5	110269.71	551348.55
1091	ORD00505	PROD0066	2	36291.81	72583.62
1092	ORD00505	PROD0165	5	22136.37	110681.85
1093	ORD00506	PROD0049	4	27088.42	108353.68
1094	ORD00507	PROD0137	4	2019.05	8076.20
1095	ORD00507	PROD0035	4	190414.55	761658.20
1096	ORD00508	PROD0031	2	290316.23	580632.46
1097	ORD00508	PROD0243	1	10094.25	10094.25
1098	ORD00508	PROD0127	3	8700.29	26100.87
1099	ORD00509	PROD0161	2	25829.99	51659.98
1100	ORD00509	PROD0275	2	10193.83	20387.66
1101	ORD00510	PROD0193	4	9954.82	39819.28
1102	ORD00511	PROD0216	1	3485.44	3485.44
1103	ORD00512	PROD0161	3	25829.99	77489.97
1104	ORD00512	PROD0056	4	6299.62	25198.48
1105	ORD00513	PROD0009	1	198883.60	198883.60
1106	ORD00514	PROD0223	4	7785.89	31143.56
1107	ORD00514	PROD0166	2	101932.80	203865.60
1108	ORD00515	PROD0021	1	34405.68	34405.68
1109	ORD00515	PROD0262	2	3172.89	6345.78
1110	ORD00516	PROD0121	3	17176.67	51530.01
1111	ORD00516	PROD0048	1	10843.12	10843.12
1112	ORD00516	PROD0185	4	112356.62	449426.48
1113	ORD00516	PROD0183	3	26053.15	78159.45
1114	ORD00517	PROD0080	4	14845.55	59382.20
1115	ORD00517	PROD0046	2	5762.47	11524.94
1116	ORD00517	PROD0107	1	97418.23	97418.23
1117	ORD00518	PROD0027	4	26206.57	104826.28
1118	ORD00518	PROD0116	1	20859.43	20859.43
1119	ORD00519	PROD0166	4	101932.80	407731.20
1120	ORD00519	PROD0199	1	28468.05	28468.05
1121	ORD00520	PROD0035	2	190414.55	380829.10
1122	ORD00520	PROD0021	5	34405.68	172028.40
1123	ORD00521	PROD0261	2	8607.87	17215.74
1124	ORD00521	PROD0085	5	89243.32	446216.60
1125	ORD00521	PROD0204	1	5933.15	5933.15
1126	ORD00521	PROD0109	5	70228.44	351142.20
1127	ORD00522	PROD0132	3	23990.67	71972.01
1128	ORD00522	PROD0172	3	95695.43	287086.29
1129	ORD00522	PROD0101	4	114695.41	458781.64
1130	ORD00523	PROD0208	2	9010.85	18021.70
1131	ORD00523	PROD0105	1	162358.65	162358.65
1132	ORD00524	PROD0110	4	23332.73	93330.92
1133	ORD00524	PROD0156	1	21374.21	21374.21
1134	ORD00524	PROD0185	2	112356.62	224713.24
1135	ORD00525	PROD0171	4	105588.96	422355.84
1136	ORD00525	PROD0106	3	137481.28	412443.84
1137	ORD00525	PROD0256	4	1625.49	6501.96
1138	ORD00526	PROD0128	1	24463.34	24463.34
1139	ORD00526	PROD0040	1	47715.49	47715.49
1140	ORD00526	PROD0055	5	42567.03	212835.15
1141	ORD00527	PROD0050	4	26917.21	107668.84
1142	ORD00527	PROD0028	3	316366.34	949099.02
1143	ORD00527	PROD0189	1	96833.78	96833.78
1144	ORD00527	PROD0111	3	2676.03	8028.09
1145	ORD00527	PROD0098	4	54814.26	219257.04
1146	ORD00528	PROD0244	1	1664.99	1664.99
1147	ORD00528	PROD0090	1	102715.97	102715.97
1148	ORD00528	PROD0008	2	121518.49	243036.98
1149	ORD00529	PROD0079	2	13912.80	27825.60
1150	ORD00530	PROD0007	1	290642.30	290642.30
1151	ORD00530	PROD0023	3	276589.43	829768.29
1152	ORD00531	PROD0097	4	9141.77	36567.08
1153	ORD00531	PROD0121	1	17176.67	17176.67
1154	ORD00532	PROD0251	1	5175.86	5175.86
1155	ORD00532	PROD0119	3	47472.78	142418.34
1156	ORD00533	PROD0191	5	44052.51	220262.55
1157	ORD00534	PROD0178	2	87684.88	175369.76
1158	ORD00534	PROD0150	4	12003.33	48013.32
1159	ORD00535	PROD0184	4	48414.15	193656.60
1160	ORD00536	PROD0075	5	5182.19	25910.95
1161	ORD00536	PROD0175	2	102750.60	205501.20
1162	ORD00537	PROD0215	1	3385.48	3385.48
1163	ORD00538	PROD0117	3	31515.40	94546.20
1164	ORD00538	PROD0172	3	95695.43	287086.29
1165	ORD00538	PROD0251	5	5175.86	25879.30
1166	ORD00538	PROD0060	4	10877.79	43511.16
1167	ORD00539	PROD0055	4	42567.03	170268.12
1168	ORD00539	PROD0116	2	20859.43	41718.86
1169	ORD00540	PROD0254	3	9824.37	29473.11
1170	ORD00540	PROD0074	2	13460.87	26921.74
1171	ORD00540	PROD0037	4	266180.98	1064723.92
1172	ORD00541	PROD0016	3	256280.50	768841.50
1173	ORD00542	PROD0217	3	7092.62	21277.86
1174	ORD00542	PROD0184	4	48414.15	193656.60
1175	ORD00542	PROD0207	3	11561.20	34683.60
1176	ORD00542	PROD0006	2	308912.61	617825.22
1177	ORD00542	PROD0154	3	19738.96	59216.88
1178	ORD00543	PROD0017	3	257730.40	773191.20
1179	ORD00543	PROD0256	3	1625.49	4876.47
1180	ORD00544	PROD0180	1	60582.65	60582.65
1181	ORD00544	PROD0252	4	8223.52	32894.08
1182	ORD00545	PROD0233	5	10621.64	53108.20
1183	ORD00545	PROD0195	4	24091.13	96364.52
1184	ORD00545	PROD0173	1	39177.27	39177.27
1185	ORD00545	PROD0124	3	17164.25	51492.75
1186	ORD00546	PROD0066	5	36291.81	181459.05
1187	ORD00547	PROD0199	5	28468.05	142340.25
1188	ORD00548	PROD0232	3	4469.76	13409.28
1189	ORD00549	PROD0040	2	47715.49	95430.98
1190	ORD00550	PROD0193	2	9954.82	19909.64
1191	ORD00550	PROD0023	3	276589.43	829768.29
1192	ORD00550	PROD0155	5	17522.15	87610.75
1193	ORD00550	PROD0094	4	117897.53	471590.12
1194	ORD00551	PROD0072	2	43142.24	86284.48
1195	ORD00552	PROD0221	3	13121.51	39364.53
1196	ORD00552	PROD0011	5	314229.61	1571148.05
1197	ORD00552	PROD0269	1	2989.48	2989.48
1198	ORD00553	PROD0045	3	15761.34	47284.02
1199	ORD00554	PROD0083	1	160848.97	160848.97
1200	ORD00555	PROD0135	4	2595.60	10382.40
1201	ORD00556	PROD0119	2	47472.78	94945.56
1202	ORD00556	PROD0104	3	\N	\N
1203	ORD00557	PROD0137	5	2019.05	10095.25
1204	ORD00558	PROD0097	4	9141.77	36567.08
1205	ORD00558	PROD0244	2	1664.99	3329.98
1206	ORD00558	PROD0245	1	\N	\N
1207	ORD00559	PROD0066	5	36291.81	181459.05
1208	ORD00560	PROD0127	3	8700.29	26100.87
1209	ORD00560	PROD0212	2	8757.97	17515.94
1210	ORD00561	PROD0192	4	94625.99	378503.96
1211	ORD00562	PROD0261	2	8607.87	17215.74
1212	ORD00562	PROD0209	2	2728.52	5457.04
1213	ORD00563	PROD0044	2	32574.27	65148.54
1214	ORD00564	PROD0275	5	10193.83	50969.15
1215	ORD00565	PROD0071	1	9870.56	9870.56
1216	ORD00565	PROD0241	4	1174.07	4696.28
1217	ORD00565	PROD0173	3	39177.27	117531.81
1218	ORD00566	PROD0166	2	101932.80	203865.60
1219	ORD00567	PROD0143	5	13171.72	65858.60
1220	ORD00567	PROD0136	4	8175.35	32701.40
1221	ORD00568	PROD0186	5	17418.14	87090.70
1222	ORD00569	PROD0150	2	12003.33	24006.66
1223	ORD00570	PROD0201	4	10976.40	43905.60
1224	ORD00571	PROD0193	5	9954.82	49774.10
1225	ORD00572	PROD0233	2	10621.64	21243.28
1226	ORD00572	PROD0142	3	8820.60	26461.80
1227	ORD00572	PROD0262	1	3172.89	3172.89
1228	ORD00572	PROD0216	4	3485.44	13941.76
1229	ORD00573	PROD0028	3	316366.34	949099.02
1230	ORD00573	PROD0022	1	222156.94	222156.94
1231	ORD00573	PROD0036	5	78738.41	393692.05
1232	ORD00574	PROD0021	1	34405.68	34405.68
1233	ORD00574	PROD0031	1	290316.23	290316.23
1234	ORD00575	PROD0137	5	2019.05	10095.25
1235	ORD00576	PROD0197	5	113579.08	567895.40
1236	ORD00576	PROD0105	1	162358.65	162358.65
1237	ORD00576	PROD0278	2	6353.37	12706.74
1238	ORD00577	PROD0209	2	2728.52	5457.04
1239	ORD00578	PROD0223	4	7785.89	31143.56
1240	ORD00578	PROD0198	2	57432.47	114864.94
1241	ORD00579	PROD0197	5	113579.08	567895.40
1242	ORD00580	PROD0269	1	2989.48	2989.48
1243	ORD00580	PROD0176	4	30789.84	123159.36
1244	ORD00580	PROD0165	5	22136.37	110681.85
1245	ORD00581	PROD0194	2	24802.59	49605.18
1246	ORD00581	PROD0087	2	12717.02	25434.04
1247	ORD00581	PROD0207	3	11561.20	34683.60
1248	ORD00582	PROD0241	5	1174.07	5870.35
1249	ORD00582	PROD0013	2	337113.25	674226.50
1250	ORD00583	PROD0252	4	8223.52	32894.08
1251	ORD00584	PROD0134	4	19220.41	76881.64
1252	ORD00585	PROD0196	2	2511.26	5022.52
1253	ORD00585	PROD0187	1	28776.04	28776.04
1254	ORD00585	PROD0025	2	330590.39	661180.78
1255	ORD00586	PROD0096	2	179864.29	359728.58
1256	ORD00587	PROD0121	1	17176.67	17176.67
1257	ORD00587	PROD0009	1	198883.60	198883.60
1258	ORD00587	PROD0101	3	114695.41	344086.23
1259	ORD00587	PROD0040	2	47715.49	95430.98
1260	ORD00588	PROD0096	1	179864.29	179864.29
1261	ORD00588	PROD0126	3	13544.05	40632.15
1262	ORD00589	PROD0086	1	49202.47	49202.47
1263	ORD00590	PROD0143	2	13171.72	26343.44
1264	ORD00590	PROD0237	4	7201.43	28805.72
1265	ORD00591	PROD0070	4	25905.43	103621.72
1266	ORD00591	PROD0001	4	279610.57	1118442.28
1267	ORD00591	PROD0148	5	3628.18	18140.90
1268	ORD00591	PROD0236	5	7038.57	35192.85
1269	ORD00591	PROD0271	4	1989.71	7958.84
1270	ORD00592	PROD0208	4	9010.85	36043.40
1271	ORD00592	PROD0129	2	5323.48	10646.96
1272	ORD00592	PROD0269	5	2989.48	14947.40
1273	ORD00593	PROD0060	4	10877.79	43511.16
1274	ORD00593	PROD0212	3	8757.97	26273.91
1275	ORD00593	PROD0196	3	2511.26	7533.78
1276	ORD00594	PROD0072	4	43142.24	172568.96
1277	ORD00594	PROD0155	2	17522.15	35044.30
1278	ORD00595	PROD0105	4	162358.65	649434.60
1279	ORD00596	PROD0152	4	1904.28	7617.12
1280	ORD00596	PROD0192	4	94625.99	378503.96
1281	ORD00596	PROD0028	4	316366.34	1265465.36
1282	ORD00596	PROD0180	1	60582.65	60582.65
1283	ORD00597	PROD0246	2	5399.76	10799.52
1284	ORD00597	PROD0035	3	190414.55	571243.65
1285	ORD00597	PROD0181	5	63768.87	318844.35
1286	ORD00597	PROD0170	2	45302.42	90604.84
1287	ORD00598	PROD0267	3	6230.11	18690.33
1288	ORD00599	PROD0265	5	11740.65	58703.25
1289	ORD00600	PROD0260	2	5050.94	10101.88
1290	ORD00600	PROD0035	4	190414.55	761658.20
1291	ORD00601	PROD0101	1	114695.41	114695.41
1292	ORD00602	PROD0100	5	110269.71	551348.55
1293	ORD00602	PROD0215	5	3385.48	16927.40
1294	ORD00602	PROD0214	3	12483.89	37451.67
1295	ORD00602	PROD0078	2	18117.48	36234.96
1296	ORD00602	PROD0219	1	14849.13	14849.13
1297	ORD00603	PROD0041	3	14461.31	43383.93
1298	ORD00603	PROD0236	5	7038.57	35192.85
1299	ORD00604	PROD0170	5	45302.42	226512.10
1300	ORD00604	PROD0168	2	100026.32	200052.64
1301	ORD00605	PROD0126	4	13544.05	54176.20
1302	ORD00605	PROD0116	4	20859.43	83437.72
1303	ORD00605	PROD0012	3	248709.70	746129.10
1304	ORD00606	PROD0154	3	19738.96	59216.88
1305	ORD00607	PROD0128	5	24463.34	122316.70
1306	ORD00607	PROD0238	5	6026.76	30133.80
1307	ORD00607	PROD0079	3	13912.80	41738.40
1308	ORD00607	PROD0051	4	33329.69	133318.76
1309	ORD00608	PROD0161	1	25829.99	25829.99
1310	ORD00609	PROD0250	4	4620.81	18483.24
1311	ORD00610	PROD0168	5	100026.32	500131.60
1312	ORD00611	PROD0220	4	11275.57	45102.28
1313	ORD00612	PROD0017	3	257730.40	773191.20
1314	ORD00612	PROD0069	3	39168.98	117506.94
1315	ORD00613	PROD0159	3	17483.90	52451.70
1316	ORD00614	PROD0099	2	130788.21	261576.42
1317	ORD00615	PROD0270	5	907.09	4535.45
1318	ORD00615	PROD0037	3	266180.98	798542.94
1319	ORD00616	PROD0255	3	7571.15	22713.45
1320	ORD00616	PROD0115	1	2277.24	2277.24
1321	ORD00617	PROD0206	4	5427.42	21709.68
1322	ORD00618	PROD0077	2	20510.26	41020.52
1323	ORD00619	PROD0038	3	88262.22	264786.66
1324	ORD00620	PROD0155	4	17522.15	70088.60
1325	ORD00620	PROD0108	1	121332.02	121332.02
1326	ORD00621	PROD0255	4	7571.15	30284.60
1327	ORD00622	PROD0168	4	100026.32	400105.28
1328	ORD00623	PROD0085	3	89243.32	267729.96
1329	ORD00624	PROD0254	2	9824.37	19648.74
1330	ORD00624	PROD0143	2	13171.72	26343.44
1331	ORD00625	PROD0002	1	102447.74	102447.74
1332	ORD00626	PROD0259	5	7869.35	39346.75
1333	ORD00626	PROD0141	4	11608.58	46434.32
1334	ORD00627	PROD0021	5	34405.68	172028.40
1335	ORD00627	PROD0233	5	10621.64	53108.20
1336	ORD00628	PROD0033	4	245627.48	982509.92
1337	ORD00628	PROD0243	4	10094.25	40377.00
1338	ORD00629	PROD0136	3	8175.35	24526.05
1339	ORD00630	PROD0021	4	34405.68	137622.72
1340	ORD00630	PROD0114	2	7586.49	15172.98
1341	ORD00631	PROD0280	1	7685.53	7685.53
1342	ORD00631	PROD0214	5	12483.89	62419.45
1343	ORD00632	PROD0255	5	7571.15	37855.75
1344	ORD00632	PROD0110	5	23332.73	116663.65
1345	ORD00633	PROD0169	5	41598.42	207992.10
1346	ORD00633	PROD0091	2	141135.80	282271.60
1347	ORD00634	PROD0133	2	23616.92	47233.84
1348	ORD00635	PROD0186	3	17418.14	52254.42
1349	ORD00635	PROD0050	5	26917.21	134586.05
1350	ORD00635	PROD0148	5	3628.18	18140.90
1351	ORD00636	PROD0034	3	272513.12	817539.36
1352	ORD00636	PROD0139	1	14201.82	14201.82
1353	ORD00636	PROD0092	5	140982.24	704911.20
1354	ORD00636	PROD0059	5	35594.97	177974.85
1355	ORD00636	PROD0232	4	4469.76	17879.04
1356	ORD00637	PROD0181	2	63768.87	127537.74
1357	ORD00637	PROD0091	5	141135.80	705679.00
1358	ORD00637	PROD0199	3	28468.05	85404.15
1359	ORD00638	PROD0274	4	7846.95	31387.80
1360	ORD00638	PROD0100	3	110269.71	330809.13
1361	ORD00639	PROD0098	5	54814.26	274071.30
1362	ORD00640	PROD0254	3	9824.37	29473.11
1363	ORD00640	PROD0235	3	1609.74	4829.22
1364	ORD00640	PROD0199	2	28468.05	56936.10
1365	ORD00641	PROD0004	3	39811.79	119435.37
1366	ORD00642	PROD0070	5	25905.43	129527.15
1367	ORD00642	PROD0243	5	10094.25	50471.25
1368	ORD00642	PROD0254	3	9824.37	29473.11
1369	ORD00643	PROD0151	1	24271.64	24271.64
1370	ORD00643	PROD0020	3	293010.61	879031.83
1371	ORD00643	PROD0055	2	42567.03	85134.06
1372	ORD00644	PROD0187	4	28776.04	115104.16
1373	ORD00644	PROD0039	1	257535.23	257535.23
1374	ORD00644	PROD0256	1	1625.49	1625.49
1375	ORD00644	PROD0158	3	12650.30	37950.90
1376	ORD00644	PROD0154	3	19738.96	59216.88
1377	ORD00645	PROD0052	1	23501.69	23501.69
1378	ORD00645	PROD0186	1	17418.14	17418.14
1379	ORD00646	PROD0041	1	14461.31	14461.31
1380	ORD00646	PROD0119	3	47472.78	142418.34
1381	ORD00647	PROD0280	4	7685.53	30742.12
1382	ORD00647	PROD0153	1	10840.50	10840.50
1383	ORD00647	PROD0052	3	23501.69	70505.07
1384	ORD00648	PROD0049	5	27088.42	135442.10
1385	ORD00649	PROD0127	1	8700.29	8700.29
1386	ORD00650	PROD0009	2	198883.60	397767.20
1387	ORD00650	PROD0241	2	1174.07	2348.14
1388	ORD00651	PROD0268	3	2944.75	8834.25
1389	ORD00652	PROD0199	5	28468.05	142340.25
1390	ORD00652	PROD0099	3	130788.21	392364.63
1391	ORD00653	PROD0064	4	34644.88	138579.52
1392	ORD00654	PROD0130	5	1182.88	5914.40
1393	ORD00654	PROD0066	2	36291.81	72583.62
1394	ORD00655	PROD0128	1	24463.34	24463.34
1395	ORD00656	PROD0002	1	102447.74	102447.74
1396	ORD00656	PROD0108	3	121332.02	363996.06
1397	ORD00656	PROD0057	2	24240.82	48481.64
1398	ORD00656	PROD0008	4	121518.49	486073.96
1399	ORD00656	PROD0212	2	8757.97	17515.94
1400	ORD00657	PROD0141	2	11608.58	23217.16
1401	ORD00657	PROD0228	2	6170.81	12341.62
1402	ORD00658	PROD0002	4	102447.74	409790.96
1403	ORD00659	PROD0212	1	8757.97	8757.97
1404	ORD00660	PROD0272	3	11096.23	33288.69
1405	ORD00660	PROD0034	3	272513.12	817539.36
1406	ORD00660	PROD0233	2	10621.64	21243.28
1407	ORD00661	PROD0246	2	5399.76	10799.52
1408	ORD00662	PROD0261	2	8607.87	17215.74
1409	ORD00663	PROD0265	1	11740.65	11740.65
1410	ORD00663	PROD0159	5	17483.90	87419.50
1411	ORD00663	PROD0207	1	11561.20	11561.20
1412	ORD00663	PROD0011	2	314229.61	628459.22
1413	ORD00664	PROD0272	4	11096.23	44384.92
1414	ORD00664	PROD0094	5	117897.53	589487.65
1415	ORD00665	PROD0096	3	179864.29	539592.87
1416	ORD00665	PROD0056	4	6299.62	25198.48
1417	ORD00666	PROD0183	4	26053.15	104212.60
1418	ORD00666	PROD0050	5	26917.21	134586.05
1419	ORD00666	PROD0195	2	24091.13	48182.26
1420	ORD00667	PROD0117	4	31515.40	126061.60
1421	ORD00668	PROD0023	4	276589.43	1106357.72
1422	ORD00668	PROD0105	4	162358.65	649434.60
1423	ORD00669	PROD0112	1	35280.59	35280.59
1424	ORD00669	PROD0190	3	22778.54	68335.62
1425	ORD00669	PROD0050	1	26917.21	26917.21
1426	ORD00670	PROD0048	1	10843.12	10843.12
1427	ORD00670	PROD0175	3	102750.60	308251.80
1428	ORD00670	PROD0122	5	16203.67	81018.35
1429	ORD00670	PROD0061	5	6821.26	34106.30
1430	ORD00671	PROD0004	2	39811.79	79623.58
1431	ORD00671	PROD0251	4	5175.86	20703.44
1432	ORD00672	PROD0219	3	14849.13	44547.39
1433	ORD00673	PROD0011	2	314229.61	628459.22
1434	ORD00673	PROD0141	2	11608.58	23217.16
1435	ORD00673	PROD0099	2	130788.21	261576.42
1436	ORD00674	PROD0236	1	7038.57	7038.57
1437	ORD00675	PROD0154	4	19738.96	78955.84
1438	ORD00676	PROD0273	2	1784.35	3568.70
1439	ORD00677	PROD0213	1	2985.64	2985.64
1440	ORD00678	PROD0272	5	11096.23	55481.15
1441	ORD00678	PROD0169	5	41598.42	207992.10
1442	ORD00678	PROD0232	5	4469.76	22348.80
1443	ORD00678	PROD0081	2	110991.10	221982.20
1444	ORD00679	PROD0134	5	19220.41	96102.05
1445	ORD00680	PROD0193	4	9954.82	39819.28
1446	ORD00680	PROD0275	1	10193.83	10193.83
1447	ORD00681	PROD0058	1	14691.81	14691.81
1448	ORD00681	PROD0246	5	5399.76	26998.80
1449	ORD00681	PROD0203	2	3538.98	7077.96
1450	ORD00681	PROD0070	5	25905.43	129527.15
1451	ORD00682	PROD0279	5	962.48	4812.40
1452	ORD00682	PROD0038	1	88262.22	88262.22
1453	ORD00682	PROD0124	3	17164.25	51492.75
1454	ORD00682	PROD0276	5	6563.88	32819.40
1455	ORD00683	PROD0252	2	8223.52	16447.04
1456	ORD00684	PROD0217	1	7092.62	7092.62
1457	ORD00684	PROD0280	3	7685.53	23056.59
1458	ORD00685	PROD0013	3	337113.25	1011339.75
1459	ORD00685	PROD0016	2	256280.50	512561.00
1460	ORD00685	PROD0043	5	16739.67	83698.35
1461	ORD00686	PROD0276	1	6563.88	6563.88
1462	ORD00686	PROD0191	5	44052.51	220262.55
1463	ORD00687	PROD0150	2	12003.33	24006.66
1464	ORD00687	PROD0134	1	19220.41	19220.41
1465	ORD00688	PROD0268	1	2944.75	2944.75
1466	ORD00689	PROD0241	1	1174.07	1174.07
1467	ORD00690	PROD0126	3	13544.05	40632.15
1468	ORD00690	PROD0194	3	24802.59	74407.77
1469	ORD00691	PROD0063	2	35488.70	70977.40
1470	ORD00692	PROD0188	2	51993.13	103986.26
1471	ORD00692	PROD0159	5	17483.90	87419.50
1472	ORD00693	PROD0124	5	17164.25	85821.25
1473	ORD00693	PROD0211	5	8250.11	41250.55
1474	ORD00694	PROD0270	3	907.09	2721.27
1475	ORD00694	PROD0095	1	49921.23	49921.23
1476	ORD00694	PROD0065	1	30524.10	30524.10
1477	ORD00694	PROD0034	4	272513.12	1090052.48
1478	ORD00694	PROD0032	3	246601.80	739805.40
1479	ORD00695	PROD0133	2	23616.92	47233.84
1480	ORD00696	PROD0097	4	9141.77	36567.08
1481	ORD00696	PROD0271	3	1989.71	5969.13
1482	ORD00696	PROD0033	2	245627.48	491254.96
1483	ORD00697	PROD0158	3	12650.30	37950.90
1484	ORD00697	PROD0209	2	2728.52	5457.04
1485	ORD00698	PROD0054	3	31709.48	95128.44
1486	ORD00698	PROD0159	1	17483.90	17483.90
1487	ORD00699	PROD0192	3	94625.99	283877.97
1488	ORD00700	PROD0279	2	962.48	1924.96
1489	ORD00701	PROD0211	3	8250.11	24750.33
1490	ORD00702	PROD0056	5	6299.62	31498.10
1491	ORD00702	PROD0189	5	96833.78	484168.90
1492	ORD00702	PROD0124	5	17164.25	85821.25
1493	ORD00703	PROD0032	1	246601.80	246601.80
1494	ORD00703	PROD0175	3	102750.60	308251.80
1495	ORD00704	PROD0182	1	33297.75	33297.75
1496	ORD00704	PROD0100	4	110269.71	441078.84
1497	ORD00704	PROD0270	2	907.09	1814.18
1498	ORD00704	PROD0132	2	23990.67	47981.34
1499	ORD00704	PROD0162	1	2672.21	2672.21
1500	ORD00705	PROD0102	5	45021.16	225105.80
1501	ORD00705	PROD0124	1	17164.25	17164.25
1502	ORD00706	PROD0021	5	34405.68	172028.40
1503	ORD00706	PROD0209	5	2728.52	13642.60
1504	ORD00706	PROD0018	4	120439.60	481758.40
1505	ORD00706	PROD0040	3	47715.49	143146.47
1506	ORD00706	PROD0043	4	16739.67	66958.68
1507	ORD00707	PROD0006	1	308912.61	308912.61
1508	ORD00707	PROD0095	5	49921.23	249606.15
1509	ORD00707	PROD0107	1	97418.23	97418.23
1510	ORD00707	PROD0014	3	289145.53	867436.59
1511	ORD00708	PROD0126	4	13544.05	54176.20
1512	ORD00708	PROD0194	3	24802.59	74407.77
1513	ORD00708	PROD0171	3	105588.96	316766.88
1514	ORD00708	PROD0242	5	5755.30	28776.50
1515	ORD00709	PROD0189	5	96833.78	484168.90
1516	ORD00710	PROD0270	5	907.09	4535.45
1517	ORD00710	PROD0147	3	5055.12	15165.36
1518	ORD00710	PROD0056	2	6299.62	12599.24
1519	ORD00711	PROD0081	2	110991.10	221982.20
1520	ORD00712	PROD0019	3	339524.65	1018573.95
1521	ORD00713	PROD0203	4	3538.98	14155.92
1522	ORD00714	PROD0066	4	36291.81	145167.24
1523	ORD00715	PROD0105	4	162358.65	649434.60
1524	ORD00715	PROD0185	4	112356.62	449426.48
1525	ORD00716	PROD0109	1	70228.44	70228.44
1526	ORD00717	PROD0221	5	13121.51	65607.55
1527	ORD00718	PROD0074	5	13460.87	67304.35
1528	ORD00718	PROD0108	3	121332.02	363996.06
1529	ORD00719	PROD0230	3	6077.64	18232.92
1530	ORD00719	PROD0100	2	110269.71	220539.42
1531	ORD00719	PROD0176	4	30789.84	123159.36
1532	ORD00720	PROD0192	5	94625.99	473129.95
1533	ORD00721	PROD0025	3	330590.39	991771.17
1534	ORD00721	PROD0260	5	5050.94	25254.70
1535	ORD00722	PROD0232	4	4469.76	17879.04
1536	ORD00722	PROD0131	5	21092.44	105462.20
1537	ORD00722	PROD0085	5	89243.32	446216.60
1538	ORD00723	PROD0234	1	6463.53	6463.53
1539	ORD00724	PROD0128	2	24463.34	48926.68
1540	ORD00725	PROD0115	3	2277.24	6831.72
1541	ORD00726	PROD0012	2	248709.70	497419.40
1542	ORD00726	PROD0243	4	10094.25	40377.00
1543	ORD00727	PROD0090	3	102715.97	308147.91
1544	ORD00727	PROD0111	5	2676.03	13380.15
1545	ORD00728	PROD0186	5	17418.14	87090.70
1546	ORD00728	PROD0125	2	22153.16	44306.32
1547	ORD00729	PROD0177	2	102403.06	204806.12
1548	ORD00729	PROD0209	5	2728.52	13642.60
1549	ORD00729	PROD0061	5	6821.26	34106.30
1550	ORD00730	PROD0076	3	27116.85	81350.55
1551	ORD00730	PROD0223	1	7785.89	7785.89
1552	ORD00731	PROD0111	1	2676.03	2676.03
1553	ORD00731	PROD0008	2	121518.49	243036.98
1554	ORD00731	PROD0247	2	5416.29	10832.58
1555	ORD00731	PROD0219	5	14849.13	74245.65
1556	ORD00732	PROD0077	2	20510.26	41020.52
1557	ORD00733	PROD0085	1	89243.32	89243.32
1558	ORD00733	PROD0245	5	\N	\N
1559	ORD00733	PROD0115	4	2277.24	9108.96
1560	ORD00733	PROD0001	5	279610.57	1398052.85
1561	ORD00734	PROD0199	1	28468.05	28468.05
1562	ORD00734	PROD0258	1	4792.40	4792.40
1563	ORD00734	PROD0104	2	\N	\N
1564	ORD00735	PROD0143	3	13171.72	39515.16
1565	ORD00735	PROD0042	5	44258.35	221291.75
1566	ORD00736	PROD0268	2	2944.75	5889.50
1567	ORD00736	PROD0101	1	114695.41	114695.41
1568	ORD00736	PROD0227	3	9871.34	29614.02
1569	ORD00736	PROD0211	2	8250.11	16500.22
1570	ORD00737	PROD0030	4	253935.11	1015740.44
1571	ORD00738	PROD0010	5	270434.00	1352170.00
1572	ORD00739	PROD0083	4	160848.97	643395.88
1573	ORD00739	PROD0035	5	190414.55	952072.75
1574	ORD00739	PROD0135	5	2595.60	12978.00
1575	ORD00739	PROD0012	3	248709.70	746129.10
1576	ORD00740	PROD0161	4	25829.99	103319.96
1577	ORD00740	PROD0184	1	48414.15	48414.15
1578	ORD00740	PROD0088	4	\N	\N
1579	ORD00740	PROD0104	5	\N	\N
1580	ORD00740	PROD0177	1	102403.06	102403.06
1581	ORD00741	PROD0113	4	145706.19	582824.76
1582	ORD00742	PROD0177	1	102403.06	102403.06
1583	ORD00742	PROD0193	2	9954.82	19909.64
1584	ORD00743	PROD0087	5	12717.02	63585.10
1585	ORD00744	PROD0146	2	9207.08	18414.16
1586	ORD00744	PROD0028	4	316366.34	1265465.36
1587	ORD00745	PROD0238	2	6026.76	12053.52
1588	ORD00745	PROD0256	1	1625.49	1625.49
1589	ORD00745	PROD0263	1	8199.23	8199.23
1590	ORD00745	PROD0088	2	\N	\N
1591	ORD00746	PROD0134	4	19220.41	76881.64
1592	ORD00746	PROD0266	2	408.26	816.52
1593	ORD00747	PROD0120	2	35341.43	70682.86
1594	ORD00747	PROD0219	5	14849.13	74245.65
1595	ORD00748	PROD0174	5	110640.11	553200.55
1596	ORD00748	PROD0118	4	12699.55	50798.20
1597	ORD00749	PROD0061	4	6821.26	27285.04
1598	ORD00749	PROD0233	1	10621.64	10621.64
1599	ORD00750	PROD0076	1	27116.85	27116.85
1600	ORD00750	PROD0008	4	121518.49	486073.96
1601	ORD00750	PROD0187	5	28776.04	143880.20
1602	ORD00751	PROD0082	1	54346.36	54346.36
1603	ORD00752	PROD0054	5	31709.48	158547.40
1604	ORD00752	PROD0136	2	8175.35	16350.70
1605	ORD00752	PROD0208	1	9010.85	9010.85
1606	ORD00752	PROD0077	5	20510.26	102551.30
1607	ORD00752	PROD0038	2	88262.22	176524.44
1608	ORD00753	PROD0138	4	15463.10	61852.40
1609	ORD00753	PROD0121	5	17176.67	85883.35
1610	ORD00754	PROD0020	3	293010.61	879031.83
1611	ORD00755	PROD0129	3	5323.48	15970.44
1612	ORD00755	PROD0260	2	5050.94	10101.88
1613	ORD00756	PROD0044	3	32574.27	97722.81
1614	ORD00757	PROD0047	2	5512.81	11025.62
1615	ORD00757	PROD0183	2	26053.15	52106.30
1616	ORD00758	PROD0232	3	4469.76	13409.28
1617	ORD00759	PROD0077	5	20510.26	102551.30
1618	ORD00760	PROD0067	5	11627.77	58138.85
1619	ORD00760	PROD0164	2	6702.72	13405.44
1620	ORD00760	PROD0265	4	11740.65	46962.60
1621	ORD00761	PROD0096	2	179864.29	359728.58
1622	ORD00762	PROD0200	4	29196.20	116784.80
1623	ORD00762	PROD0196	5	2511.26	12556.30
1624	ORD00762	PROD0170	1	45302.42	45302.42
1625	ORD00763	PROD0138	4	15463.10	61852.40
1626	ORD00763	PROD0129	4	5323.48	21293.92
1627	ORD00763	PROD0094	5	117897.53	589487.65
1628	ORD00763	PROD0269	4	2989.48	11957.92
1629	ORD00764	PROD0273	5	1784.35	8921.75
1630	ORD00764	PROD0138	5	15463.10	77315.50
1631	ORD00764	PROD0201	1	10976.40	10976.40
1632	ORD00764	PROD0114	3	7586.49	22759.47
1633	ORD00764	PROD0100	4	110269.71	441078.84
1634	ORD00765	PROD0173	2	39177.27	78354.54
1635	ORD00765	PROD0248	3	4809.30	14427.90
1636	ORD00766	PROD0114	1	7586.49	7586.49
1637	ORD00766	PROD0176	2	30789.84	61579.68
1638	ORD00766	PROD0272	5	11096.23	55481.15
1639	ORD00766	PROD0190	1	22778.54	22778.54
1640	ORD00767	PROD0198	1	57432.47	57432.47
1641	ORD00767	PROD0167	5	22365.17	111825.85
1642	ORD00768	PROD0157	5	10758.03	53790.15
1643	ORD00769	PROD0058	1	14691.81	14691.81
1644	ORD00769	PROD0247	2	5416.29	10832.58
1645	ORD00769	PROD0248	5	4809.30	24046.50
1646	ORD00769	PROD0085	3	89243.32	267729.96
1647	ORD00770	PROD0046	3	5762.47	17287.41
1648	ORD00771	PROD0110	4	23332.73	93330.92
1649	ORD00771	PROD0215	5	3385.48	16927.40
1650	ORD00772	PROD0137	2	2019.05	4038.10
1651	ORD00773	PROD0182	2	33297.75	66595.50
1652	ORD00774	PROD0031	4	290316.23	1161264.92
1653	ORD00774	PROD0068	1	43176.46	43176.46
1654	ORD00775	PROD0071	5	9870.56	49352.80
1655	ORD00775	PROD0170	4	45302.42	181209.68
1656	ORD00776	PROD0144	2	801.07	1602.14
1657	ORD00776	PROD0153	2	10840.50	21681.00
1658	ORD00777	PROD0187	5	28776.04	143880.20
1659	ORD00777	PROD0163	3	18374.63	55123.89
1660	ORD00778	PROD0171	2	105588.96	211177.92
1661	ORD00778	PROD0014	1	289145.53	289145.53
1662	ORD00779	PROD0119	2	47472.78	94945.56
1663	ORD00779	PROD0038	2	88262.22	176524.44
1664	ORD00780	PROD0003	3	49538.31	148614.93
1665	ORD00781	PROD0094	3	117897.53	353692.59
1666	ORD00781	PROD0052	3	23501.69	70505.07
1667	ORD00782	PROD0114	4	7586.49	30345.96
1668	ORD00783	PROD0077	2	20510.26	41020.52
1669	ORD00783	PROD0004	3	39811.79	119435.37
1670	ORD00784	PROD0036	5	78738.41	393692.05
1671	ORD00785	PROD0098	2	54814.26	109628.52
1672	ORD00785	PROD0033	5	245627.48	1228137.40
1673	ORD00785	PROD0065	2	30524.10	61048.20
1674	ORD00786	PROD0267	4	6230.11	24920.44
1675	ORD00786	PROD0126	2	13544.05	27088.10
1676	ORD00786	PROD0213	2	2985.64	5971.28
1677	ORD00786	PROD0135	5	2595.60	12978.00
1678	ORD00787	PROD0045	2	15761.34	31522.68
1679	ORD00787	PROD0234	2	6463.53	12927.06
1680	ORD00788	PROD0248	4	4809.30	19237.20
1681	ORD00788	PROD0070	2	25905.43	51810.86
1682	ORD00789	PROD0233	1	10621.64	10621.64
1683	ORD00789	PROD0196	4	2511.26	10045.04
1684	ORD00789	PROD0124	1	17164.25	17164.25
1685	ORD00790	PROD0111	2	2676.03	5352.06
1686	ORD00791	PROD0096	3	179864.29	539592.87
1687	ORD00791	PROD0015	2	222324.51	444649.02
1688	ORD00792	PROD0039	5	257535.23	1287676.15
1689	ORD00792	PROD0156	5	21374.21	106871.05
1690	ORD00792	PROD0121	2	17176.67	34353.34
1691	ORD00793	PROD0277	5	9657.13	48285.65
1692	ORD00793	PROD0105	3	162358.65	487075.95
1693	ORD00793	PROD0164	3	6702.72	20108.16
1694	ORD00794	PROD0202	3	12764.12	38292.36
1695	ORD00795	PROD0256	4	1625.49	6501.96
1696	ORD00795	PROD0060	5	10877.79	54388.95
1697	ORD00795	PROD0093	5	8480.78	42403.90
1698	ORD00796	PROD0240	5	10219.29	51096.45
1699	ORD00797	PROD0266	2	408.26	816.52
1700	ORD00798	PROD0028	1	316366.34	316366.34
1701	ORD00798	PROD0097	1	9141.77	9141.77
1702	ORD00798	PROD0089	3	45090.58	135271.74
1703	ORD00799	PROD0225	2	9270.30	18540.60
1704	ORD00799	PROD0179	3	21340.87	64022.61
1705	ORD00800	PROD0021	3	34405.68	103217.04
1706	ORD00800	PROD0104	2	\N	\N
1707	ORD00800	PROD0009	4	198883.60	795534.40
1708	ORD00800	PROD0143	1	13171.72	13171.72
1709	ORD00801	PROD0084	2	37258.14	74516.28
1710	ORD00802	PROD0179	1	21340.87	21340.87
1711	ORD00802	PROD0013	3	337113.25	1011339.75
1712	ORD00803	PROD0213	5	2985.64	14928.20
1713	ORD00803	PROD0241	4	1174.07	4696.28
1714	ORD00803	PROD0043	1	16739.67	16739.67
1715	ORD00803	PROD0108	5	121332.02	606660.10
1716	ORD00804	PROD0081	1	110991.10	110991.10
1717	ORD00805	PROD0059	5	35594.97	177974.85
1718	ORD00806	PROD0093	1	8480.78	8480.78
1719	ORD00807	PROD0271	2	1989.71	3979.42
1720	ORD00807	PROD0225	5	9270.30	46351.50
1721	ORD00807	PROD0128	2	24463.34	48926.68
1722	ORD00808	PROD0155	5	17522.15	87610.75
1723	ORD00809	PROD0203	5	3538.98	17694.90
1724	ORD00810	PROD0188	3	51993.13	155979.39
1725	ORD00811	PROD0066	1	36291.81	36291.81
1726	ORD00811	PROD0255	1	7571.15	7571.15
1727	ORD00812	PROD0277	4	9657.13	38628.52
1728	ORD00812	PROD0188	3	51993.13	155979.39
1729	ORD00813	PROD0247	1	5416.29	5416.29
1730	ORD00814	PROD0086	5	49202.47	246012.35
1731	ORD00815	PROD0065	3	30524.10	91572.30
1732	ORD00816	PROD0004	1	39811.79	39811.79
1733	ORD00816	PROD0114	2	7586.49	15172.98
1734	ORD00816	PROD0147	1	5055.12	5055.12
1735	ORD00817	PROD0232	4	4469.76	17879.04
1736	ORD00817	PROD0189	3	96833.78	290501.34
1737	ORD00818	PROD0218	2	5238.20	10476.40
1738	ORD00819	PROD0057	5	24240.82	121204.10
1739	ORD00819	PROD0023	1	276589.43	276589.43
1740	ORD00820	PROD0231	4	6206.49	24825.96
1741	ORD00821	PROD0265	3	11740.65	35221.95
1742	ORD00821	PROD0050	4	26917.21	107668.84
1743	ORD00822	PROD0101	1	114695.41	114695.41
1744	ORD00822	PROD0261	4	8607.87	34431.48
1745	ORD00823	PROD0272	3	11096.23	33288.69
1746	ORD00824	PROD0223	2	7785.89	15571.78
1747	ORD00825	PROD0016	2	256280.50	512561.00
1748	ORD00826	PROD0081	3	110991.10	332973.30
1749	ORD00826	PROD0226	4	7172.97	28691.88
1750	ORD00827	PROD0071	4	9870.56	39482.24
1751	ORD00828	PROD0013	1	337113.25	337113.25
1752	ORD00828	PROD0035	1	190414.55	190414.55
1753	ORD00829	PROD0279	5	962.48	4812.40
1754	ORD00829	PROD0035	3	190414.55	571243.65
1755	ORD00830	PROD0257	1	2248.73	2248.73
1756	ORD00831	PROD0271	1	1989.71	1989.71
1757	ORD00831	PROD0253	2	8743.34	17486.68
1758	ORD00831	PROD0115	4	2277.24	9108.96
1759	ORD00832	PROD0196	1	2511.26	2511.26
1760	ORD00833	PROD0090	3	102715.97	308147.91
1761	ORD00834	PROD0149	5	8124.11	40620.55
1762	ORD00834	PROD0059	4	35594.97	142379.88
1763	ORD00835	PROD0110	4	23332.73	93330.92
1764	ORD00836	PROD0029	2	149660.33	299320.66
1765	ORD00837	PROD0280	1	7685.53	7685.53
1766	ORD00838	PROD0076	1	27116.85	27116.85
1767	ORD00838	PROD0058	4	14691.81	58767.24
1768	ORD00839	PROD0261	3	8607.87	25823.61
1769	ORD00839	PROD0016	3	256280.50	768841.50
1770	ORD00839	PROD0037	5	266180.98	1330904.90
1771	ORD00839	PROD0280	2	7685.53	15371.06
1772	ORD00839	PROD0205	2	\N	\N
1773	ORD00840	PROD0226	3	7172.97	21518.91
1774	ORD00840	PROD0260	4	5050.94	20203.76
1775	ORD00841	PROD0215	3	3385.48	10156.44
1776	ORD00841	PROD0243	4	10094.25	40377.00
1777	ORD00842	PROD0154	1	19738.96	19738.96
1778	ORD00842	PROD0207	1	11561.20	11561.20
1779	ORD00843	PROD0085	5	89243.32	446216.60
1780	ORD00844	PROD0245	3	\N	\N
1781	ORD00844	PROD0026	1	34248.48	34248.48
1782	ORD00845	PROD0217	4	7092.62	28370.48
1783	ORD00845	PROD0058	1	14691.81	14691.81
1784	ORD00845	PROD0182	4	33297.75	133191.00
1785	ORD00846	PROD0115	4	2277.24	9108.96
1786	ORD00846	PROD0171	3	105588.96	316766.88
1787	ORD00847	PROD0204	3	5933.15	17799.45
1788	ORD00847	PROD0094	1	117897.53	117897.53
1789	ORD00848	PROD0128	3	24463.34	73390.02
1790	ORD00849	PROD0174	1	110640.11	110640.11
1791	ORD00850	PROD0278	2	6353.37	12706.74
1792	ORD00850	PROD0280	1	7685.53	7685.53
1793	ORD00851	PROD0117	4	31515.40	126061.60
1794	ORD00851	PROD0022	2	222156.94	444313.88
1795	ORD00852	PROD0035	1	190414.55	190414.55
1796	ORD00852	PROD0218	5	5238.20	26191.00
1797	ORD00853	PROD0128	4	24463.34	97853.36
1798	ORD00853	PROD0184	1	48414.15	48414.15
1799	ORD00853	PROD0084	2	37258.14	74516.28
1800	ORD00853	PROD0105	2	162358.65	324717.30
1801	ORD00854	PROD0165	3	22136.37	66409.11
1802	ORD00854	PROD0262	1	3172.89	3172.89
1803	ORD00854	PROD0049	2	27088.42	54176.84
1804	ORD00854	PROD0206	3	5427.42	16282.26
1805	ORD00855	PROD0220	1	11275.57	11275.57
1806	ORD00855	PROD0163	2	18374.63	36749.26
1807	ORD00856	PROD0248	2	4809.30	9618.60
1808	ORD00856	PROD0034	3	272513.12	817539.36
1809	ORD00856	PROD0265	5	11740.65	58703.25
1810	ORD00857	PROD0237	1	7201.43	7201.43
1811	ORD00857	PROD0075	4	5182.19	20728.76
1812	ORD00857	PROD0050	3	26917.21	80751.63
1813	ORD00857	PROD0140	4	2847.84	11391.36
1814	ORD00858	PROD0202	4	12764.12	51056.48
1815	ORD00859	PROD0128	3	24463.34	73390.02
1816	ORD00859	PROD0203	5	3538.98	17694.90
1817	ORD00859	PROD0226	4	7172.97	28691.88
1818	ORD00860	PROD0026	5	34248.48	171242.40
1819	ORD00860	PROD0057	2	24240.82	48481.64
1820	ORD00860	PROD0064	5	34644.88	173224.40
1821	ORD00861	PROD0196	1	2511.26	2511.26
1822	ORD00862	PROD0276	5	6563.88	32819.40
1823	ORD00863	PROD0264	5	4118.15	20590.75
1824	ORD00864	PROD0070	5	25905.43	129527.15
1825	ORD00864	PROD0153	5	10840.50	54202.50
1826	ORD00865	PROD0223	1	7785.89	7785.89
1827	ORD00865	PROD0221	3	13121.51	39364.53
1828	ORD00865	PROD0255	4	7571.15	30284.60
1829	ORD00865	PROD0211	3	8250.11	24750.33
1830	ORD00866	PROD0175	5	102750.60	513753.00
1831	ORD00866	PROD0276	4	6563.88	26255.52
1832	ORD00866	PROD0015	3	222324.51	666973.53
1833	ORD00867	PROD0067	2	11627.77	23255.54
1834	ORD00868	PROD0095	1	49921.23	49921.23
1835	ORD00868	PROD0215	1	3385.48	3385.48
1836	ORD00868	PROD0173	4	39177.27	156709.08
1837	ORD00868	PROD0149	3	8124.11	24372.33
1838	ORD00869	PROD0096	1	179864.29	179864.29
1839	ORD00870	PROD0245	3	\N	\N
1840	ORD00870	PROD0243	5	10094.25	50471.25
1841	ORD00870	PROD0160	1	12278.28	12278.28
1842	ORD00870	PROD0206	4	5427.42	21709.68
1843	ORD00870	PROD0069	1	39168.98	39168.98
1844	ORD00871	PROD0258	3	4792.40	14377.20
1845	ORD00872	PROD0275	4	10193.83	40775.32
1846	ORD00872	PROD0008	5	121518.49	607592.45
1847	ORD00872	PROD0056	5	6299.62	31498.10
1848	ORD00873	PROD0041	2	14461.31	28922.62
1849	ORD00874	PROD0140	3	2847.84	8543.52
1850	ORD00874	PROD0229	2	4112.45	8224.90
1851	ORD00874	PROD0070	4	25905.43	103621.72
1852	ORD00874	PROD0210	1	14712.50	14712.50
1853	ORD00875	PROD0246	3	5399.76	16199.28
1854	ORD00876	PROD0180	2	60582.65	121165.30
1855	ORD00877	PROD0258	3	4792.40	14377.20
1856	ORD00877	PROD0167	3	22365.17	67095.51
1857	ORD00877	PROD0130	1	1182.88	1182.88
1858	ORD00878	PROD0101	2	114695.41	229390.82
1859	ORD00878	PROD0040	2	47715.49	95430.98
1860	ORD00878	PROD0058	2	14691.81	29383.62
1861	ORD00879	PROD0252	4	8223.52	32894.08
1862	ORD00879	PROD0044	4	32574.27	130297.08
1863	ORD00879	PROD0231	2	6206.49	12412.98
1864	ORD00880	PROD0276	4	6563.88	26255.52
1865	ORD00880	PROD0195	3	24091.13	72273.39
1866	ORD00880	PROD0087	1	12717.02	12717.02
1867	ORD00880	PROD0038	5	88262.22	441311.10
1868	ORD00881	PROD0100	1	110269.71	110269.71
1869	ORD00882	PROD0137	2	2019.05	4038.10
1870	ORD00882	PROD0118	3	12699.55	38098.65
1871	ORD00882	PROD0170	1	45302.42	45302.42
1872	ORD00883	PROD0203	4	3538.98	14155.92
1873	ORD00884	PROD0185	3	112356.62	337069.86
1874	ORD00885	PROD0244	4	1664.99	6659.96
1875	ORD00885	PROD0112	5	35280.59	176402.95
1876	ORD00886	PROD0258	3	4792.40	14377.20
1877	ORD00886	PROD0263	5	8199.23	40996.15
1878	ORD00887	PROD0080	3	14845.55	44536.65
1879	ORD00887	PROD0032	3	246601.80	739805.40
1880	ORD00888	PROD0193	2	9954.82	19909.64
1881	ORD00889	PROD0090	2	102715.97	205431.94
1882	ORD00889	PROD0138	5	15463.10	77315.50
1883	ORD00889	PROD0068	2	43176.46	86352.92
1884	ORD00890	PROD0256	2	1625.49	3250.98
1885	ORD00890	PROD0016	5	256280.50	1281402.50
1886	ORD00890	PROD0201	5	10976.40	54882.00
1887	ORD00890	PROD0081	1	110991.10	110991.10
1888	ORD00890	PROD0108	5	121332.02	606660.10
1889	ORD00891	PROD0090	1	102715.97	102715.97
1890	ORD00892	PROD0247	1	5416.29	5416.29
1891	ORD00892	PROD0198	5	57432.47	287162.35
1892	ORD00892	PROD0063	1	35488.70	35488.70
1893	ORD00893	PROD0121	5	17176.67	85883.35
1894	ORD00894	PROD0142	2	8820.60	17641.20
1895	ORD00894	PROD0216	3	3485.44	10456.32
1896	ORD00894	PROD0071	3	9870.56	29611.68
1897	ORD00895	PROD0207	1	11561.20	11561.20
1898	ORD00895	PROD0094	3	117897.53	353692.59
1899	ORD00896	PROD0170	4	45302.42	181209.68
1900	ORD00896	PROD0011	4	314229.61	1256918.44
1901	ORD00896	PROD0024	4	321716.92	1286867.68
1902	ORD00897	PROD0116	4	20859.43	83437.72
1903	ORD00897	PROD0145	5	22657.06	113285.30
1904	ORD00897	PROD0001	3	279610.57	838831.71
1905	ORD00898	PROD0008	3	121518.49	364555.47
1906	ORD00899	PROD0194	5	24802.59	124012.95
1907	ORD00899	PROD0274	5	7846.95	39234.75
1908	ORD00900	PROD0222	5	2802.33	14011.65
1909	ORD00901	PROD0249	3	774.24	2322.72
1910	ORD00901	PROD0038	1	88262.22	88262.22
1911	ORD00902	PROD0122	2	16203.67	32407.34
1912	ORD00903	PROD0096	1	179864.29	179864.29
1913	ORD00903	PROD0195	3	24091.13	72273.39
1914	ORD00904	PROD0072	1	43142.24	43142.24
1915	ORD00905	PROD0149	2	8124.11	16248.22
1916	ORD00905	PROD0047	4	5512.81	22051.24
1917	ORD00906	PROD0075	5	5182.19	25910.95
1918	ORD00906	PROD0144	5	801.07	4005.35
1919	ORD00906	PROD0048	4	10843.12	43372.48
1920	ORD00907	PROD0136	3	8175.35	24526.05
1921	ORD00908	PROD0024	4	321716.92	1286867.68
1922	ORD00908	PROD0164	5	6702.72	33513.60
1923	ORD00909	PROD0010	4	270434.00	1081736.00
1924	ORD00909	PROD0026	2	34248.48	68496.96
1925	ORD00909	PROD0033	3	245627.48	736882.44
1926	ORD00910	PROD0241	2	1174.07	2348.14
1927	ORD00910	PROD0091	5	141135.80	705679.00
1928	ORD00910	PROD0258	5	4792.40	23962.00
1929	ORD00911	PROD0265	2	11740.65	23481.30
1930	ORD00911	PROD0094	3	117897.53	353692.59
1931	ORD00912	PROD0278	3	6353.37	19060.11
1932	ORD00913	PROD0191	1	44052.51	44052.51
1933	ORD00914	PROD0096	4	179864.29	719457.16
1934	ORD00915	PROD0070	2	25905.43	51810.86
1935	ORD00916	PROD0248	3	4809.30	14427.90
1936	ORD00917	PROD0168	2	100026.32	200052.64
1937	ORD00917	PROD0151	5	24271.64	121358.20
1938	ORD00917	PROD0117	5	31515.40	157577.00
1939	ORD00918	PROD0132	3	23990.67	71972.01
1940	ORD00919	PROD0243	1	10094.25	10094.25
1941	ORD00919	PROD0104	2	\N	\N
1942	ORD00919	PROD0160	1	12278.28	12278.28
1943	ORD00919	PROD0276	1	6563.88	6563.88
1944	ORD00920	PROD0114	1	7586.49	7586.49
1945	ORD00920	PROD0094	4	117897.53	471590.12
1946	ORD00921	PROD0078	4	18117.48	72469.92
1947	ORD00922	PROD0220	4	11275.57	45102.28
1948	ORD00923	PROD0156	3	21374.21	64122.63
1949	ORD00923	PROD0091	2	141135.80	282271.60
1950	ORD00924	PROD0172	1	95695.43	95695.43
1951	ORD00925	PROD0172	3	95695.43	287086.29
1952	ORD00926	PROD0277	3	9657.13	28971.39
1953	ORD00926	PROD0171	1	105588.96	105588.96
1954	ORD00927	PROD0053	5	43609.38	218046.90
1955	ORD00927	PROD0120	4	35341.43	141365.72
1956	ORD00927	PROD0052	1	23501.69	23501.69
1957	ORD00927	PROD0043	5	16739.67	83698.35
1958	ORD00927	PROD0237	1	7201.43	7201.43
1959	ORD00928	PROD0091	1	141135.80	141135.80
1960	ORD00928	PROD0087	4	12717.02	50868.08
1961	ORD00929	PROD0091	2	141135.80	282271.60
1962	ORD00929	PROD0001	4	279610.57	1118442.28
1963	ORD00929	PROD0043	3	16739.67	50219.01
1964	ORD00929	PROD0070	5	25905.43	129527.15
1965	ORD00930	PROD0041	2	14461.31	28922.62
1966	ORD00930	PROD0164	2	6702.72	13405.44
1967	ORD00930	PROD0057	3	24240.82	72722.46
1968	ORD00930	PROD0173	5	39177.27	195886.35
1969	ORD00931	PROD0253	4	8743.34	34973.36
1970	ORD00931	PROD0052	5	23501.69	117508.45
1971	ORD00931	PROD0227	5	9871.34	49356.70
1972	ORD00931	PROD0098	1	54814.26	54814.26
1973	ORD00931	PROD0067	3	11627.77	34883.31
1974	ORD00932	PROD0034	1	272513.12	272513.12
1975	ORD00932	PROD0025	4	330590.39	1322361.56
1976	ORD00933	PROD0061	1	6821.26	6821.26
1977	ORD00934	PROD0146	1	9207.08	9207.08
1978	ORD00935	PROD0090	5	102715.97	513579.85
1979	ORD00936	PROD0076	3	27116.85	81350.55
1980	ORD00936	PROD0024	4	321716.92	1286867.68
1981	ORD00937	PROD0010	4	270434.00	1081736.00
1982	ORD00938	PROD0023	4	276589.43	1106357.72
1983	ORD00938	PROD0124	5	17164.25	85821.25
1984	ORD00939	PROD0158	1	12650.30	12650.30
1985	ORD00939	PROD0192	1	94625.99	94625.99
1986	ORD00939	PROD0116	4	20859.43	83437.72
1987	ORD00940	PROD0179	1	21340.87	21340.87
1988	ORD00941	PROD0055	4	42567.03	170268.12
1989	ORD00942	PROD0077	3	20510.26	61530.78
1990	ORD00942	PROD0113	1	145706.19	145706.19
1991	ORD00942	PROD0114	1	7586.49	7586.49
1992	ORD00942	PROD0158	1	12650.30	12650.30
1993	ORD00943	PROD0024	1	321716.92	321716.92
1994	ORD00943	PROD0183	5	26053.15	130265.75
1995	ORD00943	PROD0126	5	13544.05	67720.25
1996	ORD00944	PROD0228	2	6170.81	12341.62
1997	ORD00945	PROD0234	5	6463.53	32317.65
1998	ORD00945	PROD0172	2	95695.43	191390.86
1999	ORD00945	PROD0279	1	962.48	962.48
2000	ORD00945	PROD0231	2	6206.49	12412.98
2001	ORD00945	PROD0166	5	101932.80	509664.00
2002	ORD00946	PROD0124	4	17164.25	68657.00
2003	ORD00946	PROD0215	3	3385.48	10156.44
2004	ORD00946	PROD0092	3	140982.24	422946.72
2005	ORD00946	PROD0005	5	85978.02	429890.10
2006	ORD00946	PROD0073	2	6732.32	13464.64
2007	ORD00947	PROD0001	1	279610.57	279610.57
2008	ORD00947	PROD0228	1	6170.81	6170.81
2009	ORD00948	PROD0051	1	33329.69	33329.69
2010	ORD00948	PROD0088	5	\N	\N
2011	ORD00948	PROD0035	5	190414.55	952072.75
2012	ORD00948	PROD0181	4	63768.87	255075.48
2013	ORD00948	PROD0269	1	2989.48	2989.48
2014	ORD00949	PROD0275	3	10193.83	30581.49
2015	ORD00949	PROD0191	5	44052.51	220262.55
2016	ORD00950	PROD0241	1	1174.07	1174.07
2017	ORD00950	PROD0086	4	49202.47	196809.88
2018	ORD00951	PROD0111	5	2676.03	13380.15
2019	ORD00951	PROD0035	4	190414.55	761658.20
2020	ORD00952	PROD0160	1	12278.28	12278.28
2021	ORD00953	PROD0028	2	316366.34	632732.68
2022	ORD00954	PROD0080	1	14845.55	14845.55
2023	ORD00955	PROD0068	5	43176.46	215882.30
2024	ORD00956	PROD0065	1	30524.10	30524.10
2025	ORD00956	PROD0007	2	290642.30	581284.60
2026	ORD00956	PROD0066	1	36291.81	36291.81
2027	ORD00957	PROD0255	1	7571.15	7571.15
2028	ORD00957	PROD0184	2	48414.15	96828.30
2029	ORD00957	PROD0066	3	36291.81	108875.43
2030	ORD00958	PROD0172	1	95695.43	95695.43
2031	ORD00959	PROD0119	4	47472.78	189891.12
2032	ORD00960	PROD0037	1	266180.98	266180.98
2033	ORD00961	PROD0038	2	88262.22	176524.44
2034	ORD00961	PROD0241	5	1174.07	5870.35
2035	ORD00961	PROD0153	5	10840.50	54202.50
2036	ORD00961	PROD0194	2	24802.59	49605.18
2037	ORD00961	PROD0021	1	34405.68	34405.68
2038	ORD00962	PROD0035	2	190414.55	380829.10
2039	ORD00962	PROD0199	2	28468.05	56936.10
2040	ORD00962	PROD0201	5	10976.40	54882.00
2041	ORD00963	PROD0189	4	96833.78	387335.12
2042	ORD00964	PROD0202	2	12764.12	25528.24
2043	ORD00965	PROD0131	1	21092.44	21092.44
2044	ORD00965	PROD0154	4	19738.96	78955.84
2045	ORD00966	PROD0116	1	20859.43	20859.43
2046	ORD00966	PROD0214	3	12483.89	37451.67
2047	ORD00966	PROD0177	5	102403.06	512015.30
2048	ORD00967	PROD0061	1	6821.26	6821.26
2049	ORD00968	PROD0176	5	30789.84	153949.20
2050	ORD00969	PROD0021	4	34405.68	137622.72
2051	ORD00969	PROD0274	5	7846.95	39234.75
2052	ORD00970	PROD0123	3	11097.43	33292.29
2053	ORD00971	PROD0113	2	145706.19	291412.38
2054	ORD00972	PROD0096	2	179864.29	359728.58
2055	ORD00972	PROD0188	2	51993.13	103986.26
2056	ORD00972	PROD0030	2	253935.11	507870.22
2057	ORD00972	PROD0187	3	28776.04	86328.12
2058	ORD00972	PROD0273	2	1784.35	3568.70
2059	ORD00973	PROD0271	1	1989.71	1989.71
2060	ORD00973	PROD0256	3	1625.49	4876.47
2061	ORD00973	PROD0208	3	9010.85	27032.55
2062	ORD00974	PROD0256	4	1625.49	6501.96
2063	ORD00974	PROD0170	4	45302.42	181209.68
2064	ORD00975	PROD0103	3	83304.08	249912.24
2065	ORD00976	PROD0258	4	4792.40	19169.60
2066	ORD00977	PROD0157	1	10758.03	10758.03
2067	ORD00977	PROD0261	3	8607.87	25823.61
2068	ORD00978	PROD0123	1	11097.43	11097.43
2069	ORD00979	PROD0063	3	35488.70	106466.10
2070	ORD00980	PROD0081	4	110991.10	443964.40
2071	ORD00981	PROD0029	2	149660.33	299320.66
2072	ORD00981	PROD0232	4	4469.76	17879.04
2073	ORD00981	PROD0212	2	8757.97	17515.94
2074	ORD00982	PROD0254	2	9824.37	19648.74
2075	ORD00982	PROD0272	2	11096.23	22192.46
2076	ORD00982	PROD0183	1	26053.15	26053.15
2077	ORD00983	PROD0144	2	801.07	1602.14
2078	ORD00984	PROD0256	1	1625.49	1625.49
2079	ORD00984	PROD0025	4	330590.39	1322361.56
2080	ORD00985	PROD0076	4	27116.85	108467.40
2081	ORD00985	PROD0114	4	7586.49	30345.96
2082	ORD00985	PROD0228	2	6170.81	12341.62
2083	ORD00986	PROD0143	1	13171.72	13171.72
2084	ORD00987	PROD0275	3	10193.83	30581.49
2085	ORD00987	PROD0033	3	245627.48	736882.44
2086	ORD00987	PROD0013	5	337113.25	1685566.25
2087	ORD00988	PROD0092	2	140982.24	281964.48
2088	ORD00988	PROD0066	3	36291.81	108875.43
2089	ORD00988	PROD0034	4	272513.12	1090052.48
2090	ORD00988	PROD0159	2	17483.90	34967.80
2091	ORD00989	PROD0112	1	35280.59	35280.59
2092	ORD00989	PROD0204	4	5933.15	23732.60
2093	ORD00989	PROD0271	2	1989.71	3979.42
2094	ORD00990	PROD0266	1	408.26	408.26
2095	ORD00990	PROD0201	5	10976.40	54882.00
2096	ORD00990	PROD0091	2	141135.80	282271.60
2097	ORD00991	PROD0192	5	94625.99	473129.95
2098	ORD00992	PROD0227	2	9871.34	19742.68
2099	ORD00993	PROD0114	2	7586.49	15172.98
2100	ORD00993	PROD0182	4	33297.75	133191.00
2101	ORD00993	PROD0116	4	20859.43	83437.72
2102	ORD00993	PROD0067	1	11627.77	11627.77
2103	ORD00994	PROD0024	1	321716.92	321716.92
2104	ORD00994	PROD0262	5	3172.89	15864.45
2105	ORD00994	PROD0096	2	179864.29	359728.58
2106	ORD00994	PROD0200	2	29196.20	58392.40
2107	ORD00994	PROD0255	4	7571.15	30284.60
2108	ORD00995	PROD0094	1	117897.53	117897.53
2109	ORD00996	PROD0133	4	23616.92	94467.68
2110	ORD00996	PROD0207	2	11561.20	23122.40
2111	ORD00997	PROD0073	5	6732.32	33661.60
2112	ORD00997	PROD0083	3	160848.97	482546.91
2113	ORD00997	PROD0261	3	8607.87	25823.61
2114	ORD00997	PROD0009	2	198883.60	397767.20
2115	ORD00997	PROD0055	3	42567.03	127701.09
2116	ORD00998	PROD0095	4	49921.23	199684.92
2117	ORD00998	PROD0092	2	140982.24	281964.48
2118	ORD00998	PROD0182	5	33297.75	166488.75
2119	ORD00998	PROD0208	3	9010.85	27032.55
2120	ORD00998	PROD0030	2	253935.11	507870.22
2121	ORD00999	PROD0126	1	13544.05	13544.05
2122	ORD00999	PROD0035	3	190414.55	571243.65
2123	ORD00999	PROD0059	4	35594.97	142379.88
2124	ORD00999	PROD0273	4	1784.35	7137.40
2125	ORD01000	PROD0157	1	10758.03	10758.03
2126	ORD01000	PROD0063	1	35488.70	35488.70
2127	ORD01000	PROD0166	2	101932.80	203865.60
2128	ORD01000	PROD0077	4	20510.26	82041.04
2129	ORD01001	PROD0243	3	10094.25	30282.75
2130	ORD01002	PROD0129	5	5323.48	26617.40
2131	ORD01003	PROD0176	3	30789.84	92369.52
2132	ORD01004	PROD0109	4	70228.44	280913.76
2133	ORD01004	PROD0165	5	22136.37	110681.85
2134	ORD01005	PROD0087	4	12717.02	50868.08
2135	ORD01006	PROD0158	1	12650.30	12650.30
2136	ORD01007	PROD0273	4	1784.35	7137.40
2137	ORD01007	PROD0233	1	10621.64	10621.64
2138	ORD01008	PROD0095	2	49921.23	99842.46
2139	ORD01009	PROD0244	4	1664.99	6659.96
2140	ORD01009	PROD0279	3	962.48	2887.44
2141	ORD01010	PROD0159	1	17483.90	17483.90
2142	ORD01010	PROD0104	5	\N	\N
2143	ORD01011	PROD0172	2	95695.43	191390.86
2144	ORD01011	PROD0094	1	117897.53	117897.53
2145	ORD01012	PROD0249	3	774.24	2322.72
2146	ORD01012	PROD0194	5	24802.59	124012.95
2147	ORD01012	PROD0140	4	2847.84	11391.36
2148	ORD01013	PROD0238	4	6026.76	24107.04
2149	ORD01014	PROD0231	1	6206.49	6206.49
2150	ORD01014	PROD0159	4	17483.90	69935.60
2151	ORD01015	PROD0126	3	13544.05	40632.15
2152	ORD01016	PROD0219	1	14849.13	14849.13
2153	ORD01016	PROD0096	5	179864.29	899321.45
2154	ORD01016	PROD0238	3	6026.76	18080.28
2155	ORD01016	PROD0226	2	7172.97	14345.94
2156	ORD01016	PROD0041	5	14461.31	72306.55
2157	ORD01017	PROD0005	3	85978.02	257934.06
2158	ORD01017	PROD0092	3	140982.24	422946.72
2159	ORD01018	PROD0149	3	8124.11	24372.33
2160	ORD01018	PROD0269	3	2989.48	8968.44
2161	ORD01018	PROD0172	4	95695.43	382781.72
2162	ORD01018	PROD0202	4	12764.12	51056.48
2163	ORD01019	PROD0132	1	23990.67	23990.67
2164	ORD01020	PROD0125	3	22153.16	66459.48
2165	ORD01021	PROD0136	2	8175.35	16350.70
2166	ORD01021	PROD0009	2	198883.60	397767.20
2167	ORD01021	PROD0270	1	907.09	907.09
2168	ORD01021	PROD0088	5	\N	\N
2169	ORD01022	PROD0268	2	2944.75	5889.50
2170	ORD01022	PROD0139	2	14201.82	28403.64
2171	ORD01022	PROD0052	1	23501.69	23501.69
2172	ORD01023	PROD0246	1	5399.76	5399.76
2173	ORD01024	PROD0212	4	8757.97	35031.88
2174	ORD01024	PROD0190	5	22778.54	113892.70
2175	ORD01024	PROD0173	2	39177.27	78354.54
2176	ORD01025	PROD0156	1	21374.21	21374.21
2177	ORD01025	PROD0196	2	2511.26	5022.52
2178	ORD01026	PROD0237	3	7201.43	21604.29
2179	ORD01027	PROD0173	4	39177.27	156709.08
2180	ORD01028	PROD0112	5	35280.59	176402.95
2181	ORD01028	PROD0036	3	78738.41	236215.23
2182	ORD01028	PROD0134	2	19220.41	38440.82
2183	ORD01028	PROD0185	3	112356.62	337069.86
2184	ORD01029	PROD0025	3	330590.39	991771.17
2185	ORD01029	PROD0105	2	162358.65	324717.30
2186	ORD01030	PROD0150	2	12003.33	24006.66
2187	ORD01031	PROD0203	1	3538.98	3538.98
2188	ORD01031	PROD0277	1	9657.13	9657.13
2189	ORD01032	PROD0144	5	801.07	4005.35
2190	ORD01032	PROD0196	1	2511.26	2511.26
2191	ORD01033	PROD0147	4	5055.12	20220.48
2192	ORD01033	PROD0033	3	245627.48	736882.44
2193	ORD01034	PROD0275	3	10193.83	30581.49
2194	ORD01035	PROD0174	4	110640.11	442560.44
2195	ORD01035	PROD0093	3	8480.78	25442.34
2196	ORD01036	PROD0079	1	13912.80	13912.80
2197	ORD01036	PROD0120	2	35341.43	70682.86
2198	ORD01037	PROD0102	3	45021.16	135063.48
2199	ORD01038	PROD0234	4	6463.53	25854.12
2200	ORD01038	PROD0187	2	28776.04	57552.08
2201	ORD01038	PROD0006	4	308912.61	1235650.44
2202	ORD01038	PROD0225	5	9270.30	46351.50
2203	ORD01039	PROD0190	2	22778.54	45557.08
2204	ORD01040	PROD0133	2	23616.92	47233.84
2205	ORD01040	PROD0250	2	4620.81	9241.62
2206	ORD01041	PROD0035	5	190414.55	952072.75
2207	ORD01042	PROD0084	3	37258.14	111774.42
2208	ORD01042	PROD0068	1	43176.46	43176.46
2209	ORD01043	PROD0280	1	7685.53	7685.53
2210	ORD01043	PROD0237	4	7201.43	28805.72
2211	ORD01044	PROD0094	3	117897.53	353692.59
2212	ORD01045	PROD0241	5	1174.07	5870.35
2213	ORD01045	PROD0076	1	27116.85	27116.85
2214	ORD01045	PROD0174	2	110640.11	221280.22
2215	ORD01046	PROD0274	3	7846.95	23540.85
2216	ORD01047	PROD0097	4	9141.77	36567.08
2217	ORD01048	PROD0062	2	22431.17	44862.34
2218	ORD01048	PROD0272	3	11096.23	33288.69
2219	ORD01048	PROD0235	5	1609.74	8048.70
2220	ORD01048	PROD0263	4	8199.23	32796.92
2221	ORD01048	PROD0022	5	222156.94	1110784.70
2222	ORD01049	PROD0019	2	339524.65	679049.30
2223	ORD01050	PROD0182	2	33297.75	66595.50
2224	ORD01051	PROD0253	4	8743.34	34973.36
2225	ORD01052	PROD0058	4	14691.81	58767.24
2226	ORD01053	PROD0196	5	2511.26	12556.30
2227	ORD01053	PROD0099	2	130788.21	261576.42
2228	ORD01053	PROD0100	2	110269.71	220539.42
2229	ORD01053	PROD0001	3	279610.57	838831.71
2230	ORD01054	PROD0170	3	45302.42	135907.26
2231	ORD01054	PROD0007	4	290642.30	1162569.20
2232	ORD01055	PROD0161	2	25829.99	51659.98
2233	ORD01056	PROD0108	2	121332.02	242664.04
2234	ORD01057	PROD0255	3	7571.15	22713.45
2235	ORD01057	PROD0243	2	10094.25	20188.50
2236	ORD01058	PROD0069	1	39168.98	39168.98
2237	ORD01059	PROD0166	4	101932.80	407731.20
2238	ORD01060	PROD0079	2	13912.80	27825.60
2239	ORD01060	PROD0210	5	14712.50	73562.50
2240	ORD01061	PROD0133	5	23616.92	118084.60
2241	ORD01062	PROD0115	1	2277.24	2277.24
2242	ORD01062	PROD0276	3	6563.88	19691.64
2243	ORD01062	PROD0021	5	34405.68	172028.40
2244	ORD01063	PROD0043	1	16739.67	16739.67
2245	ORD01063	PROD0091	2	141135.80	282271.60
2246	ORD01063	PROD0078	1	18117.48	18117.48
2247	ORD01064	PROD0275	4	10193.83	40775.32
2248	ORD01064	PROD0256	3	1625.49	4876.47
2249	ORD01065	PROD0030	3	253935.11	761805.33
2250	ORD01065	PROD0200	3	29196.20	87588.60
2251	ORD01066	PROD0258	4	4792.40	19169.60
2252	ORD01066	PROD0255	5	7571.15	37855.75
2253	ORD01067	PROD0145	3	22657.06	67971.18
2254	ORD01067	PROD0205	1	\N	\N
2255	ORD01068	PROD0092	2	140982.24	281964.48
2256	ORD01068	PROD0039	1	257535.23	257535.23
2257	ORD01068	PROD0099	3	130788.21	392364.63
2258	ORD01069	PROD0262	4	3172.89	12691.56
2259	ORD01069	PROD0058	5	14691.81	73459.05
2260	ORD01069	PROD0047	4	5512.81	22051.24
2261	ORD01070	PROD0270	2	907.09	1814.18
2262	ORD01070	PROD0050	5	26917.21	134586.05
2263	ORD01071	PROD0011	1	314229.61	314229.61
2264	ORD01071	PROD0087	1	12717.02	12717.02
2265	ORD01072	PROD0050	1	26917.21	26917.21
2266	ORD01073	PROD0001	5	279610.57	1398052.85
2267	ORD01073	PROD0182	2	33297.75	66595.50
2268	ORD01074	PROD0032	4	246601.80	986407.20
2269	ORD01074	PROD0031	5	290316.23	1451581.15
2270	ORD01074	PROD0231	4	6206.49	24825.96
2271	ORD01075	PROD0106	5	137481.28	687406.40
2272	ORD01076	PROD0043	5	16739.67	83698.35
2273	ORD01076	PROD0259	4	7869.35	31477.40
2274	ORD01076	PROD0173	2	39177.27	78354.54
2275	ORD01076	PROD0059	4	35594.97	142379.88
2276	ORD01077	PROD0039	2	257535.23	515070.46
2277	ORD01078	PROD0277	5	9657.13	48285.65
2278	ORD01079	PROD0167	4	22365.17	89460.68
2279	ORD01079	PROD0011	4	314229.61	1256918.44
2280	ORD01080	PROD0086	5	49202.47	246012.35
2281	ORD01080	PROD0004	1	39811.79	39811.79
2282	ORD01080	PROD0276	3	6563.88	19691.64
2283	ORD01081	PROD0258	1	4792.40	4792.40
2284	ORD01082	PROD0180	2	60582.65	121165.30
2285	ORD01082	PROD0255	1	7571.15	7571.15
2286	ORD01083	PROD0205	5	\N	\N
2287	ORD01084	PROD0230	2	6077.64	12155.28
2288	ORD01085	PROD0115	5	2277.24	11386.20
2289	ORD01086	PROD0012	2	248709.70	497419.40
2290	ORD01086	PROD0228	5	6170.81	30854.05
2291	ORD01086	PROD0138	4	15463.10	61852.40
2292	ORD01086	PROD0244	4	1664.99	6659.96
2293	ORD01087	PROD0235	4	1609.74	6438.96
2294	ORD01087	PROD0158	3	12650.30	37950.90
2295	ORD01088	PROD0100	4	110269.71	441078.84
2296	ORD01088	PROD0259	2	7869.35	15738.70
2297	ORD01088	PROD0155	3	17522.15	52566.45
2298	ORD01088	PROD0058	4	14691.81	58767.24
2299	ORD01088	PROD0211	5	8250.11	41250.55
2300	ORD01089	PROD0055	5	42567.03	212835.15
2301	ORD01089	PROD0195	5	24091.13	120455.65
2302	ORD01089	PROD0150	1	12003.33	12003.33
2303	ORD01090	PROD0006	1	308912.61	308912.61
2304	ORD01090	PROD0168	1	100026.32	100026.32
2305	ORD01090	PROD0088	2	\N	\N
2306	ORD01091	PROD0279	2	962.48	1924.96
2307	ORD01092	PROD0022	4	222156.94	888627.76
2308	ORD01092	PROD0169	3	41598.42	124795.26
2309	ORD01093	PROD0055	2	42567.03	85134.06
2310	ORD01093	PROD0178	1	87684.88	87684.88
2311	ORD01093	PROD0213	2	2985.64	5971.28
2312	ORD01094	PROD0200	1	29196.20	29196.20
2313	ORD01094	PROD0207	5	11561.20	57806.00
2314	ORD01095	PROD0184	5	48414.15	242070.75
2315	ORD01095	PROD0199	3	28468.05	85404.15
2316	ORD01095	PROD0150	5	12003.33	60016.65
2317	ORD01095	PROD0050	2	26917.21	53834.42
2318	ORD01096	PROD0010	4	270434.00	1081736.00
2319	ORD01096	PROD0061	2	6821.26	13642.52
2320	ORD01096	PROD0272	4	11096.23	44384.92
2321	ORD01097	PROD0063	1	35488.70	35488.70
2322	ORD01098	PROD0176	5	30789.84	153949.20
2323	ORD01098	PROD0217	4	7092.62	28370.48
2324	ORD01099	PROD0245	3	\N	\N
2325	ORD01099	PROD0071	4	9870.56	39482.24
2326	ORD01100	PROD0151	4	24271.64	97086.56
2327	ORD01101	PROD0167	5	22365.17	111825.85
2328	ORD01101	PROD0191	2	44052.51	88105.02
2329	ORD01102	PROD0161	4	25829.99	103319.96
2330	ORD01102	PROD0004	1	39811.79	39811.79
2331	ORD01103	PROD0029	4	149660.33	598641.32
2332	ORD01103	PROD0002	2	102447.74	204895.48
2333	ORD01103	PROD0128	2	24463.34	48926.68
2334	ORD01104	PROD0074	4	13460.87	53843.48
2335	ORD01105	PROD0178	2	87684.88	175369.76
2336	ORD01105	PROD0165	2	22136.37	44272.74
2337	ORD01105	PROD0167	5	22365.17	111825.85
2338	ORD01106	PROD0258	4	4792.40	19169.60
2339	ORD01106	PROD0168	3	100026.32	300078.96
2340	ORD01107	PROD0025	3	330590.39	991771.17
2341	ORD01107	PROD0186	4	17418.14	69672.56
2342	ORD01107	PROD0158	4	12650.30	50601.20
2343	ORD01107	PROD0048	3	10843.12	32529.36
2344	ORD01108	PROD0153	3	10840.50	32521.50
2345	ORD01108	PROD0225	1	9270.30	9270.30
2346	ORD01108	PROD0271	4	1989.71	7958.84
2347	ORD01109	PROD0134	5	19220.41	96102.05
2348	ORD01109	PROD0149	2	8124.11	16248.22
2349	ORD01110	PROD0043	1	16739.67	16739.67
2350	ORD01111	PROD0274	5	7846.95	39234.75
2351	ORD01111	PROD0090	1	102715.97	102715.97
2352	ORD01112	PROD0223	1	7785.89	7785.89
2353	ORD01112	PROD0095	3	49921.23	149763.69
2354	ORD01112	PROD0162	2	2672.21	5344.42
2355	ORD01113	PROD0116	1	20859.43	20859.43
2356	ORD01113	PROD0248	5	4809.30	24046.50
2357	ORD01113	PROD0263	5	8199.23	40996.15
2358	ORD01113	PROD0026	1	34248.48	34248.48
2359	ORD01114	PROD0246	4	5399.76	21599.04
2360	ORD01114	PROD0227	2	9871.34	19742.68
2361	ORD01115	PROD0203	2	3538.98	7077.96
2362	ORD01116	PROD0175	1	102750.60	102750.60
2363	ORD01117	PROD0246	5	5399.76	26998.80
2364	ORD01117	PROD0117	1	31515.40	31515.40
2365	ORD01118	PROD0210	3	14712.50	44137.50
2366	ORD01118	PROD0268	3	2944.75	8834.25
2367	ORD01119	PROD0235	4	1609.74	6438.96
2368	ORD01119	PROD0190	2	22778.54	45557.08
2369	ORD01120	PROD0267	2	6230.11	12460.22
2370	ORD01121	PROD0226	5	7172.97	35864.85
2371	ORD01122	PROD0071	5	9870.56	49352.80
2372	ORD01122	PROD0154	2	19738.96	39477.92
2373	ORD01122	PROD0271	5	1989.71	9948.55
2374	ORD01123	PROD0135	1	2595.60	2595.60
2375	ORD01123	PROD0169	3	41598.42	124795.26
2376	ORD01124	PROD0201	1	10976.40	10976.40
2377	ORD01124	PROD0268	1	2944.75	2944.75
2378	ORD01125	PROD0275	5	10193.83	50969.15
2379	ORD01125	PROD0059	2	35594.97	71189.94
2380	ORD01125	PROD0042	5	44258.35	221291.75
2381	ORD01126	PROD0012	1	248709.70	248709.70
2382	ORD01126	PROD0086	4	49202.47	196809.88
2383	ORD01127	PROD0114	1	7586.49	7586.49
2384	ORD01127	PROD0192	3	94625.99	283877.97
2385	ORD01128	PROD0007	1	290642.30	290642.30
2386	ORD01128	PROD0164	1	6702.72	6702.72
2387	ORD01128	PROD0100	1	110269.71	110269.71
2388	ORD01128	PROD0065	5	30524.10	152620.50
2389	ORD01128	PROD0203	2	3538.98	7077.96
2390	ORD01129	PROD0162	3	2672.21	8016.63
2391	ORD01130	PROD0022	1	222156.94	222156.94
2392	ORD01130	PROD0146	2	9207.08	18414.16
2393	ORD01130	PROD0168	3	100026.32	300078.96
2394	ORD01131	PROD0272	4	11096.23	44384.92
2395	ORD01131	PROD0255	4	7571.15	30284.60
2396	ORD01131	PROD0106	2	137481.28	274962.56
2397	ORD01132	PROD0126	3	13544.05	40632.15
2398	ORD01132	PROD0108	2	121332.02	242664.04
2399	ORD01133	PROD0221	1	13121.51	13121.51
2400	ORD01134	PROD0198	2	57432.47	114864.94
2401	ORD01134	PROD0193	5	9954.82	49774.10
2402	ORD01135	PROD0261	4	8607.87	34431.48
2403	ORD01135	PROD0123	4	11097.43	44389.72
2404	ORD01136	PROD0267	1	6230.11	6230.11
2405	ORD01137	PROD0018	5	120439.60	602198.00
2406	ORD01137	PROD0054	4	31709.48	126837.92
2407	ORD01138	PROD0210	1	14712.50	14712.50
2408	ORD01138	PROD0136	1	8175.35	8175.35
2409	ORD01138	PROD0022	2	222156.94	444313.88
2410	ORD01138	PROD0192	5	94625.99	473129.95
2411	ORD01139	PROD0217	5	7092.62	35463.10
2412	ORD01139	PROD0069	1	39168.98	39168.98
2413	ORD01140	PROD0163	2	18374.63	36749.26
2414	ORD01141	PROD0002	5	102447.74	512238.70
2415	ORD01141	PROD0089	3	45090.58	135271.74
2416	ORD01141	PROD0259	5	7869.35	39346.75
2417	ORD01142	PROD0122	2	16203.67	32407.34
2418	ORD01142	PROD0169	4	41598.42	166393.68
2419	ORD01142	PROD0276	1	6563.88	6563.88
2420	ORD01142	PROD0233	4	10621.64	42486.56
2421	ORD01143	PROD0062	2	22431.17	44862.34
2422	ORD01143	PROD0055	3	42567.03	127701.09
2423	ORD01143	PROD0197	2	113579.08	227158.16
2424	ORD01143	PROD0139	5	14201.82	71009.10
2425	ORD01143	PROD0018	5	120439.60	602198.00
2426	ORD01144	PROD0114	4	7586.49	30345.96
2427	ORD01144	PROD0120	4	35341.43	141365.72
2428	ORD01144	PROD0110	1	23332.73	23332.73
2429	ORD01144	PROD0208	3	9010.85	27032.55
2430	ORD01144	PROD0146	1	9207.08	9207.08
2431	ORD01145	PROD0179	1	21340.87	21340.87
2432	ORD01145	PROD0099	2	130788.21	261576.42
2433	ORD01145	PROD0263	5	8199.23	40996.15
2434	ORD01145	PROD0215	2	3385.48	6770.96
2435	ORD01146	PROD0088	2	\N	\N
2436	ORD01147	PROD0144	1	801.07	801.07
2437	ORD01148	PROD0111	2	2676.03	5352.06
2438	ORD01149	PROD0248	5	4809.30	24046.50
2439	ORD01150	PROD0015	5	222324.51	1111622.55
2440	ORD01150	PROD0244	4	1664.99	6659.96
2441	ORD01150	PROD0078	2	18117.48	36234.96
2442	ORD01150	PROD0200	2	29196.20	58392.40
2443	ORD01150	PROD0131	2	21092.44	42184.88
2444	ORD01151	PROD0136	2	8175.35	16350.70
2445	ORD01152	PROD0051	2	33329.69	66659.38
2446	ORD01152	PROD0196	1	2511.26	2511.26
2447	ORD01153	PROD0078	1	18117.48	18117.48
2448	ORD01154	PROD0036	4	78738.41	314953.64
2449	ORD01154	PROD0185	5	112356.62	561783.10
2450	ORD01154	PROD0101	5	114695.41	573477.05
2451	ORD01155	PROD0171	5	105588.96	527944.80
2452	ORD01156	PROD0018	4	120439.60	481758.40
2453	ORD01157	PROD0039	4	257535.23	1030140.92
2454	ORD01157	PROD0200	2	29196.20	58392.40
2455	ORD01158	PROD0057	4	24240.82	96963.28
2456	ORD01158	PROD0086	3	49202.47	147607.41
2457	ORD01158	PROD0036	3	78738.41	236215.23
2458	ORD01158	PROD0243	2	10094.25	20188.50
2459	ORD01158	PROD0004	4	39811.79	159247.16
2460	ORD01159	PROD0068	1	43176.46	43176.46
2461	ORD01159	PROD0095	4	49921.23	199684.92
2462	ORD01159	PROD0185	1	112356.62	112356.62
2463	ORD01159	PROD0074	2	13460.87	26921.74
2464	ORD01160	PROD0009	2	198883.60	397767.20
2465	ORD01160	PROD0140	4	2847.84	11391.36
2466	ORD01160	PROD0157	5	10758.03	53790.15
2467	ORD01160	PROD0229	1	4112.45	4112.45
2468	ORD01160	PROD0243	2	10094.25	20188.50
2469	ORD01161	PROD0041	5	14461.31	72306.55
2470	ORD01161	PROD0239	3	1047.73	3143.19
2471	ORD01162	PROD0277	3	9657.13	28971.39
2472	ORD01163	PROD0275	4	10193.83	40775.32
2473	ORD01163	PROD0047	3	5512.81	16538.43
2474	ORD01163	PROD0088	5	\N	\N
2475	ORD01163	PROD0221	5	13121.51	65607.55
2476	ORD01163	PROD0277	4	9657.13	38628.52
2477	ORD01164	PROD0065	4	30524.10	122096.40
2478	ORD01164	PROD0110	4	23332.73	93330.92
2479	ORD01165	PROD0013	2	337113.25	674226.50
2480	ORD01165	PROD0262	4	3172.89	12691.56
2481	ORD01166	PROD0252	5	8223.52	41117.60
2482	ORD01166	PROD0150	5	12003.33	60016.65
2483	ORD01167	PROD0066	2	36291.81	72583.62
2484	ORD01168	PROD0230	5	6077.64	30388.20
2485	ORD01168	PROD0021	2	34405.68	68811.36
2486	ORD01169	PROD0005	2	85978.02	171956.04
2487	ORD01170	PROD0076	1	27116.85	27116.85
2488	ORD01170	PROD0008	2	121518.49	243036.98
2489	ORD01170	PROD0184	2	48414.15	96828.30
2490	ORD01170	PROD0169	1	41598.42	41598.42
2491	ORD01171	PROD0057	1	24240.82	24240.82
2492	ORD01171	PROD0003	5	49538.31	247691.55
2493	ORD01172	PROD0208	1	9010.85	9010.85
2494	ORD01173	PROD0121	2	17176.67	34353.34
2495	ORD01174	PROD0023	5	276589.43	1382947.15
2496	ORD01174	PROD0199	3	28468.05	85404.15
2497	ORD01174	PROD0005	3	85978.02	257934.06
2498	ORD01175	PROD0133	2	23616.92	47233.84
2499	ORD01175	PROD0199	1	28468.05	28468.05
2500	ORD01176	PROD0223	1	7785.89	7785.89
2501	ORD01177	PROD0268	5	2944.75	14723.75
2502	ORD01177	PROD0044	5	32574.27	162871.35
2503	ORD01177	PROD0163	3	18374.63	55123.89
2504	ORD01177	PROD0048	3	10843.12	32529.36
2505	ORD01178	PROD0007	3	290642.30	871926.90
2506	ORD01178	PROD0036	2	78738.41	157476.82
2507	ORD01179	PROD0129	3	5323.48	15970.44
2508	ORD01180	PROD0071	3	9870.56	29611.68
2509	ORD01181	PROD0260	5	5050.94	25254.70
2510	ORD01181	PROD0078	4	18117.48	72469.92
2511	ORD01181	PROD0071	5	9870.56	49352.80
2512	ORD01181	PROD0114	3	7586.49	22759.47
2513	ORD01182	PROD0255	4	7571.15	30284.60
2514	ORD01182	PROD0135	2	2595.60	5191.20
2515	ORD01182	PROD0167	3	22365.17	67095.51
2516	ORD01182	PROD0070	2	25905.43	51810.86
2517	ORD01183	PROD0045	2	15761.34	31522.68
2518	ORD01184	PROD0055	1	42567.03	42567.03
2519	ORD01184	PROD0060	2	10877.79	21755.58
2520	ORD01184	PROD0215	3	3385.48	10156.44
2521	ORD01185	PROD0089	1	45090.58	45090.58
2522	ORD01185	PROD0113	3	145706.19	437118.57
2523	ORD01186	PROD0045	1	15761.34	15761.34
2524	ORD01187	PROD0219	1	14849.13	14849.13
2525	ORD01187	PROD0036	2	78738.41	157476.82
2526	ORD01187	PROD0180	1	60582.65	60582.65
2527	ORD01188	PROD0220	3	11275.57	33826.71
2528	ORD01188	PROD0223	2	7785.89	15571.78
2529	ORD01189	PROD0157	2	10758.03	21516.06
2530	ORD01189	PROD0091	3	141135.80	423407.40
2531	ORD01189	PROD0074	4	13460.87	53843.48
2532	ORD01189	PROD0226	1	7172.97	7172.97
2533	ORD01189	PROD0215	1	3385.48	3385.48
2534	ORD01190	PROD0077	2	20510.26	41020.52
2535	ORD01190	PROD0133	3	23616.92	70850.76
2536	ORD01191	PROD0052	4	23501.69	94006.76
2537	ORD01191	PROD0065	4	30524.10	122096.40
2538	ORD01191	PROD0235	1	1609.74	1609.74
2539	ORD01191	PROD0094	5	117897.53	589487.65
2540	ORD01192	PROD0079	1	13912.80	13912.80
2541	ORD01192	PROD0067	5	11627.77	58138.85
2542	ORD01192	PROD0142	4	8820.60	35282.40
2543	ORD01193	PROD0151	1	24271.64	24271.64
2544	ORD01193	PROD0243	2	10094.25	20188.50
2545	ORD01193	PROD0240	5	10219.29	51096.45
2546	ORD01194	PROD0248	3	4809.30	14427.90
2547	ORD01195	PROD0158	4	12650.30	50601.20
2548	ORD01196	PROD0130	2	1182.88	2365.76
2549	ORD01196	PROD0183	3	26053.15	78159.45
2550	ORD01197	PROD0145	1	22657.06	22657.06
2551	ORD01197	PROD0046	1	5762.47	5762.47
2552	ORD01198	PROD0238	1	6026.76	6026.76
2553	ORD01198	PROD0128	4	24463.34	97853.36
2554	ORD01199	PROD0034	3	272513.12	817539.36
2555	ORD01199	PROD0271	5	1989.71	9948.55
2556	ORD01199	PROD0265	4	11740.65	46962.60
2557	ORD01200	PROD0051	1	33329.69	33329.69
2558	ORD01201	PROD0143	1	13171.72	13171.72
2559	ORD01202	PROD0271	4	1989.71	7958.84
2560	ORD01203	PROD0198	2	57432.47	114864.94
2561	ORD01203	PROD0028	1	316366.34	316366.34
2562	ORD01203	PROD0030	2	253935.11	507870.22
2563	ORD01203	PROD0104	1	\N	\N
2564	ORD01204	PROD0108	2	121332.02	242664.04
2565	ORD01204	PROD0153	1	10840.50	10840.50
2566	ORD01204	PROD0244	4	1664.99	6659.96
2567	ORD01204	PROD0060	1	10877.79	10877.79
2568	ORD01205	PROD0080	5	14845.55	74227.75
2569	ORD01205	PROD0182	3	33297.75	99893.25
2570	ORD01205	PROD0027	1	26206.57	26206.57
2571	ORD01206	PROD0005	4	85978.02	343912.08
2572	ORD01206	PROD0062	3	22431.17	67293.51
2573	ORD01206	PROD0040	2	47715.49	95430.98
2574	ORD01206	PROD0106	3	137481.28	412443.84
2575	ORD01207	PROD0240	2	10219.29	20438.58
2576	ORD01207	PROD0029	4	149660.33	598641.32
2577	ORD01208	PROD0241	2	1174.07	2348.14
2578	ORD01209	PROD0197	4	113579.08	454316.32
2579	ORD01209	PROD0129	4	5323.48	21293.92
2580	ORD01210	PROD0215	1	3385.48	3385.48
2581	ORD01210	PROD0055	2	42567.03	85134.06
2582	ORD01211	PROD0181	4	63768.87	255075.48
2583	ORD01212	PROD0203	2	3538.98	7077.96
2584	ORD01213	PROD0196	4	2511.26	10045.04
2585	ORD01213	PROD0181	3	63768.87	191306.61
2586	ORD01214	PROD0034	5	272513.12	1362565.60
2587	ORD01214	PROD0224	1	607.93	607.93
2588	ORD01215	PROD0029	1	149660.33	149660.33
2589	ORD01216	PROD0005	2	85978.02	171956.04
2590	ORD01216	PROD0112	3	35280.59	105841.77
2591	ORD01217	PROD0081	5	110991.10	554955.50
2592	ORD01217	PROD0145	5	22657.06	113285.30
2593	ORD01217	PROD0109	2	70228.44	140456.88
2594	ORD01217	PROD0058	5	14691.81	73459.05
2595	ORD01218	PROD0039	3	257535.23	772605.69
2596	ORD01218	PROD0008	2	121518.49	243036.98
2597	ORD01219	PROD0149	2	8124.11	16248.22
2598	ORD01219	PROD0207	3	11561.20	34683.60
2599	ORD01219	PROD0126	5	13544.05	67720.25
2600	ORD01219	PROD0119	1	47472.78	47472.78
2601	ORD01219	PROD0169	1	41598.42	41598.42
2602	ORD01220	PROD0080	4	14845.55	59382.20
2603	ORD01221	PROD0127	5	8700.29	43501.45
2604	ORD01222	PROD0253	2	8743.34	17486.68
2605	ORD01222	PROD0169	5	41598.42	207992.10
2606	ORD01222	PROD0051	3	33329.69	99989.07
2607	ORD01222	PROD0069	5	39168.98	195844.90
2608	ORD01223	PROD0237	2	7201.43	14402.86
2609	ORD01224	PROD0190	4	22778.54	91114.16
2610	ORD01224	PROD0144	4	801.07	3204.28
2611	ORD01224	PROD0217	2	7092.62	14185.24
2612	ORD01225	PROD0186	3	17418.14	52254.42
2613	ORD01225	PROD0197	4	113579.08	454316.32
2614	ORD01226	PROD0250	3	4620.81	13862.43
2615	ORD01227	PROD0038	3	88262.22	264786.66
2616	ORD01228	PROD0133	4	23616.92	94467.68
2617	ORD01229	PROD0154	4	19738.96	78955.84
2618	ORD01229	PROD0024	4	321716.92	1286867.68
2619	ORD01230	PROD0107	2	97418.23	194836.46
2620	ORD01230	PROD0206	3	5427.42	16282.26
2621	ORD01230	PROD0244	5	1664.99	8324.95
2622	ORD01230	PROD0214	2	12483.89	24967.78
2623	ORD01231	PROD0016	3	256280.50	768841.50
2624	ORD01232	PROD0172	3	95695.43	287086.29
2625	ORD01233	PROD0075	2	5182.19	10364.38
2626	ORD01233	PROD0243	5	10094.25	50471.25
2627	ORD01234	PROD0165	4	22136.37	88545.48
2628	ORD01235	PROD0174	3	110640.11	331920.33
2629	ORD01235	PROD0177	2	102403.06	204806.12
2630	ORD01236	PROD0270	2	907.09	1814.18
2631	ORD01236	PROD0133	4	23616.92	94467.68
2632	ORD01236	PROD0076	2	27116.85	54233.70
2633	ORD01237	PROD0091	2	141135.80	282271.60
2634	ORD01238	PROD0251	4	5175.86	20703.44
2635	ORD01238	PROD0219	1	14849.13	14849.13
2636	ORD01238	PROD0062	4	22431.17	89724.68
2637	ORD01239	PROD0148	3	3628.18	10884.54
2638	ORD01240	PROD0218	2	5238.20	10476.40
2639	ORD01240	PROD0005	1	85978.02	85978.02
2640	ORD01240	PROD0107	2	97418.23	194836.46
2641	ORD01240	PROD0092	4	140982.24	563928.96
2642	ORD01241	PROD0137	1	2019.05	2019.05
2643	ORD01241	PROD0095	1	49921.23	49921.23
2644	ORD01241	PROD0204	4	5933.15	23732.60
2645	ORD01241	PROD0138	5	15463.10	77315.50
2646	ORD01241	PROD0254	1	9824.37	9824.37
2647	ORD01242	PROD0042	1	44258.35	44258.35
2648	ORD01242	PROD0205	3	\N	\N
2649	ORD01242	PROD0100	1	110269.71	110269.71
2650	ORD01242	PROD0229	1	4112.45	4112.45
2651	ORD01243	PROD0144	4	801.07	3204.28
2652	ORD01244	PROD0124	5	17164.25	85821.25
2653	ORD01244	PROD0003	2	49538.31	99076.62
2654	ORD01245	PROD0081	3	110991.10	332973.30
2655	ORD01246	PROD0237	2	7201.43	14402.86
2656	ORD01247	PROD0061	1	6821.26	6821.26
2657	ORD01247	PROD0199	3	28468.05	85404.15
2658	ORD01247	PROD0114	5	7586.49	37932.45
2659	ORD01247	PROD0179	4	21340.87	85363.48
2660	ORD01248	PROD0088	4	\N	\N
2661	ORD01249	PROD0192	4	94625.99	378503.96
2662	ORD01249	PROD0012	1	248709.70	248709.70
2663	ORD01250	PROD0012	5	248709.70	1243548.50
2664	ORD01250	PROD0087	1	12717.02	12717.02
2665	ORD01250	PROD0023	1	276589.43	276589.43
2666	ORD01251	PROD0122	5	16203.67	81018.35
2667	ORD01251	PROD0017	5	257730.40	1288652.00
2668	ORD01251	PROD0144	1	801.07	801.07
2669	ORD01251	PROD0133	5	23616.92	118084.60
2670	ORD01252	PROD0004	2	39811.79	79623.58
2671	ORD01253	PROD0177	5	102403.06	512015.30
2672	ORD01253	PROD0031	2	290316.23	580632.46
2673	ORD01253	PROD0059	3	35594.97	106784.91
2674	ORD01254	PROD0259	2	7869.35	15738.70
2675	ORD01254	PROD0146	2	9207.08	18414.16
2676	ORD01254	PROD0107	2	97418.23	194836.46
2677	ORD01254	PROD0100	3	110269.71	330809.13
2678	ORD01255	PROD0276	1	6563.88	6563.88
2679	ORD01256	PROD0138	3	15463.10	46389.30
2680	ORD01257	PROD0069	1	39168.98	39168.98
2681	ORD01257	PROD0029	2	149660.33	299320.66
2682	ORD01258	PROD0143	1	13171.72	13171.72
2683	ORD01258	PROD0082	1	54346.36	54346.36
2684	ORD01259	PROD0230	3	6077.64	18232.92
2685	ORD01260	PROD0118	1	12699.55	12699.55
2686	ORD01261	PROD0078	4	18117.48	72469.92
2687	ORD01261	PROD0261	3	8607.87	25823.61
2688	ORD01262	PROD0230	1	6077.64	6077.64
2689	ORD01262	PROD0118	1	12699.55	12699.55
2690	ORD01263	PROD0139	1	14201.82	14201.82
2691	ORD01263	PROD0032	1	246601.80	246601.80
2692	ORD01263	PROD0098	3	54814.26	164442.78
2693	ORD01263	PROD0086	2	49202.47	98404.94
2694	ORD01264	PROD0054	3	31709.48	95128.44
2695	ORD01265	PROD0134	5	19220.41	96102.05
2696	ORD01265	PROD0239	2	1047.73	2095.46
2697	ORD01266	PROD0131	5	21092.44	105462.20
2698	ORD01266	PROD0165	1	22136.37	22136.37
2699	ORD01267	PROD0221	4	13121.51	52486.04
2700	ORD01267	PROD0253	5	8743.34	43716.70
2701	ORD01268	PROD0221	1	13121.51	13121.51
2702	ORD01268	PROD0182	3	33297.75	99893.25
2703	ORD01269	PROD0267	3	6230.11	18690.33
2704	ORD01270	PROD0278	2	6353.37	12706.74
2705	ORD01271	PROD0089	1	45090.58	45090.58
2706	ORD01272	PROD0111	3	2676.03	8028.09
2707	ORD01273	PROD0180	1	60582.65	60582.65
2708	ORD01274	PROD0208	2	9010.85	18021.70
2709	ORD01274	PROD0087	5	12717.02	63585.10
2710	ORD01274	PROD0154	4	19738.96	78955.84
2711	ORD01274	PROD0229	2	4112.45	8224.90
2712	ORD01275	PROD0006	1	308912.61	308912.61
2713	ORD01276	PROD0210	4	14712.50	58850.00
2714	ORD01277	PROD0095	4	49921.23	199684.92
2715	ORD01277	PROD0035	3	190414.55	571243.65
2716	ORD01278	PROD0044	3	32574.27	97722.81
2717	ORD01278	PROD0113	2	145706.19	291412.38
2718	ORD01278	PROD0126	5	13544.05	67720.25
2719	ORD01279	PROD0114	4	7586.49	30345.96
2720	ORD01280	PROD0205	3	\N	\N
2721	ORD01281	PROD0224	4	607.93	2431.72
2722	ORD01281	PROD0067	3	11627.77	34883.31
2723	ORD01282	PROD0103	4	83304.08	333216.32
2724	ORD01282	PROD0139	1	14201.82	14201.82
2725	ORD01283	PROD0102	4	45021.16	180084.64
2726	ORD01284	PROD0154	3	19738.96	59216.88
2727	ORD01284	PROD0071	3	9870.56	29611.68
2728	ORD01284	PROD0103	3	83304.08	249912.24
2729	ORD01284	PROD0051	1	33329.69	33329.69
2730	ORD01284	PROD0200	2	29196.20	58392.40
2731	ORD01285	PROD0017	2	257730.40	515460.80
2732	ORD01285	PROD0217	5	7092.62	35463.10
2733	ORD01285	PROD0107	1	97418.23	97418.23
2734	ORD01285	PROD0129	3	5323.48	15970.44
2735	ORD01285	PROD0150	4	12003.33	48013.32
2736	ORD01286	PROD0045	4	15761.34	63045.36
2737	ORD01287	PROD0147	3	5055.12	15165.36
2738	ORD01287	PROD0113	3	145706.19	437118.57
2739	ORD01287	PROD0228	1	6170.81	6170.81
2740	ORD01287	PROD0158	4	12650.30	50601.20
2741	ORD01288	PROD0200	4	29196.20	116784.80
2742	ORD01288	PROD0131	5	21092.44	105462.20
2743	ORD01289	PROD0116	4	20859.43	83437.72
2744	ORD01290	PROD0089	5	45090.58	225452.90
2745	ORD01290	PROD0102	4	45021.16	180084.64
2746	ORD01291	PROD0117	3	31515.40	94546.20
2747	ORD01291	PROD0257	3	2248.73	6746.19
2748	ORD01292	PROD0017	4	257730.40	1030921.60
2749	ORD01292	PROD0113	5	145706.19	728530.95
2750	ORD01293	PROD0049	2	27088.42	54176.84
2751	ORD01293	PROD0151	4	24271.64	97086.56
2752	ORD01294	PROD0232	3	4469.76	13409.28
2753	ORD01295	PROD0035	3	190414.55	571243.65
2754	ORD01295	PROD0189	1	96833.78	96833.78
2755	ORD01296	PROD0244	2	1664.99	3329.98
2756	ORD01297	PROD0198	2	57432.47	114864.94
2757	ORD01297	PROD0011	3	314229.61	942688.83
2758	ORD01297	PROD0149	4	8124.11	32496.44
2759	ORD01298	PROD0228	5	6170.81	30854.05
2760	ORD01298	PROD0137	5	2019.05	10095.25
2761	ORD01298	PROD0218	2	5238.20	10476.40
2762	ORD01299	PROD0242	2	5755.30	11510.60
2763	ORD01299	PROD0062	2	22431.17	44862.34
2764	ORD01299	PROD0070	4	25905.43	103621.72
2765	ORD01300	PROD0263	4	8199.23	32796.92
2766	ORD01301	PROD0024	4	321716.92	1286867.68
2767	ORD01301	PROD0199	2	28468.05	56936.10
2768	ORD01302	PROD0258	4	4792.40	19169.60
2769	ORD01302	PROD0247	1	5416.29	5416.29
2770	ORD01303	PROD0071	1	9870.56	9870.56
2771	ORD01303	PROD0072	4	43142.24	172568.96
2772	ORD01304	PROD0206	1	5427.42	5427.42
2773	ORD01304	PROD0227	4	9871.34	39485.36
2774	ORD01305	PROD0008	5	121518.49	607592.45
2775	ORD01305	PROD0243	5	10094.25	50471.25
2776	ORD01305	PROD0099	2	130788.21	261576.42
2777	ORD01306	PROD0252	3	8223.52	24670.56
2778	ORD01306	PROD0062	2	22431.17	44862.34
2779	ORD01306	PROD0079	2	13912.80	27825.60
2780	ORD01306	PROD0215	4	3385.48	13541.92
2781	ORD01307	PROD0088	5	\N	\N
2782	ORD01307	PROD0208	3	9010.85	27032.55
2783	ORD01308	PROD0121	5	17176.67	85883.35
2784	ORD01308	PROD0045	1	15761.34	15761.34
2785	ORD01308	PROD0122	1	16203.67	16203.67
2786	ORD01308	PROD0168	3	100026.32	300078.96
2787	ORD01308	PROD0155	3	17522.15	52566.45
2788	ORD01309	PROD0175	5	102750.60	513753.00
2789	ORD01310	PROD0263	2	8199.23	16398.46
2790	ORD01310	PROD0143	1	13171.72	13171.72
2791	ORD01311	PROD0258	4	4792.40	19169.60
2792	ORD01311	PROD0003	4	49538.31	198153.24
2793	ORD01312	PROD0271	3	1989.71	5969.13
2794	ORD01312	PROD0027	5	26206.57	131032.85
2795	ORD01312	PROD0053	2	43609.38	87218.76
2796	ORD01312	PROD0195	5	24091.13	120455.65
2797	ORD01313	PROD0153	4	10840.50	43362.00
2798	ORD01313	PROD0022	1	222156.94	222156.94
2799	ORD01314	PROD0206	5	5427.42	27137.10
2800	ORD01314	PROD0077	2	20510.26	41020.52
2801	ORD01315	PROD0270	1	907.09	907.09
2802	ORD01315	PROD0168	4	100026.32	400105.28
2803	ORD01315	PROD0016	2	256280.50	512561.00
2804	ORD01316	PROD0240	1	10219.29	10219.29
2805	ORD01316	PROD0142	1	8820.60	8820.60
2806	ORD01317	PROD0088	2	\N	\N
2807	ORD01317	PROD0242	1	5755.30	5755.30
2808	ORD01317	PROD0208	5	9010.85	45054.25
2809	ORD01317	PROD0201	1	10976.40	10976.40
2810	ORD01318	PROD0090	4	102715.97	410863.88
2811	ORD01319	PROD0196	3	2511.26	7533.78
2812	ORD01319	PROD0095	5	49921.23	249606.15
2813	ORD01319	PROD0130	4	1182.88	4731.52
2814	ORD01320	PROD0074	3	13460.87	40382.61
2815	ORD01320	PROD0153	2	10840.50	21681.00
2816	ORD01320	PROD0084	4	37258.14	149032.56
2817	ORD01321	PROD0005	2	85978.02	171956.04
2818	ORD01322	PROD0193	4	9954.82	39819.28
2819	ORD01323	PROD0181	3	63768.87	191306.61
2820	ORD01324	PROD0226	3	7172.97	21518.91
2821	ORD01324	PROD0189	1	96833.78	96833.78
2822	ORD01325	PROD0061	5	6821.26	34106.30
2823	ORD01325	PROD0181	4	63768.87	255075.48
2824	ORD01326	PROD0102	2	45021.16	90042.32
2825	ORD01327	PROD0271	5	1989.71	9948.55
2826	ORD01327	PROD0209	1	2728.52	2728.52
2827	ORD01327	PROD0146	2	9207.08	18414.16
2828	ORD01328	PROD0070	5	25905.43	129527.15
2829	ORD01328	PROD0026	5	34248.48	171242.40
2830	ORD01328	PROD0132	4	23990.67	95962.68
2831	ORD01328	PROD0096	2	179864.29	359728.58
2832	ORD01329	PROD0233	5	10621.64	53108.20
2833	ORD01330	PROD0127	4	8700.29	34801.16
2834	ORD01330	PROD0111	5	2676.03	13380.15
2835	ORD01330	PROD0165	5	22136.37	110681.85
2836	ORD01330	PROD0245	4	\N	\N
2837	ORD01331	PROD0026	3	34248.48	102745.44
2838	ORD01331	PROD0268	5	2944.75	14723.75
2839	ORD01332	PROD0044	1	32574.27	32574.27
2840	ORD01332	PROD0080	1	14845.55	14845.55
2841	ORD01332	PROD0065	1	30524.10	30524.10
2842	ORD01332	PROD0207	3	11561.20	34683.60
2843	ORD01332	PROD0006	3	308912.61	926737.83
2844	ORD01333	PROD0035	1	190414.55	190414.55
2845	ORD01333	PROD0157	3	10758.03	32274.09
2846	ORD01333	PROD0117	5	31515.40	157577.00
2847	ORD01334	PROD0279	4	962.48	3849.92
2848	ORD01335	PROD0082	2	54346.36	108692.72
2849	ORD01336	PROD0119	1	47472.78	47472.78
2850	ORD01337	PROD0134	2	19220.41	38440.82
2851	ORD01337	PROD0206	5	5427.42	27137.10
2852	ORD01338	PROD0190	5	22778.54	113892.70
2853	ORD01338	PROD0206	2	5427.42	10854.84
2854	ORD01339	PROD0210	5	14712.50	73562.50
2855	ORD01339	PROD0052	4	23501.69	94006.76
2856	ORD01340	PROD0149	3	8124.11	24372.33
2857	ORD01340	PROD0004	4	39811.79	159247.16
2858	ORD01340	PROD0159	3	17483.90	52451.70
2859	ORD01340	PROD0127	1	8700.29	8700.29
2860	ORD01341	PROD0162	1	2672.21	2672.21
2861	ORD01341	PROD0208	1	9010.85	9010.85
2862	ORD01342	PROD0180	2	60582.65	121165.30
2863	ORD01342	PROD0032	4	246601.80	986407.20
2864	ORD01343	PROD0037	4	266180.98	1064723.92
2865	ORD01343	PROD0102	2	45021.16	90042.32
2866	ORD01343	PROD0265	2	11740.65	23481.30
2867	ORD01344	PROD0230	3	6077.64	18232.92
2868	ORD01345	PROD0274	2	7846.95	15693.90
2869	ORD01345	PROD0213	3	2985.64	8956.92
2870	ORD01345	PROD0066	1	36291.81	36291.81
2871	ORD01346	PROD0242	1	5755.30	5755.30
2872	ORD01347	PROD0086	3	49202.47	147607.41
2873	ORD01347	PROD0276	4	6563.88	26255.52
2874	ORD01347	PROD0178	2	87684.88	175369.76
2875	ORD01347	PROD0041	3	14461.31	43383.93
2876	ORD01347	PROD0138	1	15463.10	15463.10
2877	ORD01348	PROD0041	1	14461.31	14461.31
2878	ORD01349	PROD0188	2	51993.13	103986.26
2879	ORD01350	PROD0146	1	9207.08	9207.08
2880	ORD01351	PROD0061	2	6821.26	13642.52
2881	ORD01351	PROD0277	5	9657.13	48285.65
2882	ORD01351	PROD0142	5	8820.60	44103.00
2883	ORD01351	PROD0010	2	270434.00	540868.00
2884	ORD01352	PROD0083	1	160848.97	160848.97
2885	ORD01353	PROD0011	2	314229.61	628459.22
2886	ORD01353	PROD0228	4	6170.81	24683.24
2887	ORD01353	PROD0274	3	7846.95	23540.85
2888	ORD01353	PROD0277	2	9657.13	19314.26
2889	ORD01353	PROD0007	5	290642.30	1453211.50
2890	ORD01354	PROD0105	2	162358.65	324717.30
2891	ORD01355	PROD0154	1	19738.96	19738.96
2892	ORD01355	PROD0135	4	2595.60	10382.40
2893	ORD01355	PROD0011	4	314229.61	1256918.44
2894	ORD01355	PROD0258	1	4792.40	4792.40
2895	ORD01355	PROD0260	5	5050.94	25254.70
2896	ORD01356	PROD0022	5	222156.94	1110784.70
2897	ORD01356	PROD0061	5	6821.26	34106.30
2898	ORD01357	PROD0041	4	14461.31	57845.24
2899	ORD01357	PROD0048	4	10843.12	43372.48
2900	ORD01357	PROD0103	1	83304.08	83304.08
2901	ORD01357	PROD0075	1	5182.19	5182.19
2902	ORD01358	PROD0205	2	\N	\N
2903	ORD01359	PROD0082	1	54346.36	54346.36
2904	ORD01359	PROD0076	3	27116.85	81350.55
2905	ORD01360	PROD0152	5	1904.28	9521.40
2906	ORD01360	PROD0246	2	5399.76	10799.52
2907	ORD01360	PROD0030	2	253935.11	507870.22
2908	ORD01361	PROD0125	4	22153.16	88612.64
2909	ORD01361	PROD0140	4	2847.84	11391.36
2910	ORD01362	PROD0193	1	9954.82	9954.82
2911	ORD01363	PROD0192	4	94625.99	378503.96
2912	ORD01364	PROD0022	4	222156.94	888627.76
2913	ORD01365	PROD0045	5	15761.34	78806.70
2914	ORD01365	PROD0220	5	11275.57	56377.85
2915	ORD01365	PROD0137	5	2019.05	10095.25
2916	ORD01365	PROD0005	1	85978.02	85978.02
2917	ORD01366	PROD0122	3	16203.67	48611.01
2918	ORD01366	PROD0015	2	222324.51	444649.02
2919	ORD01366	PROD0074	1	13460.87	13460.87
2920	ORD01367	PROD0188	1	51993.13	51993.13
2921	ORD01367	PROD0119	5	47472.78	237363.90
2922	ORD01368	PROD0238	3	6026.76	18080.28
2923	ORD01369	PROD0071	3	9870.56	29611.68
2924	ORD01369	PROD0023	5	276589.43	1382947.15
2925	ORD01369	PROD0164	5	6702.72	33513.60
2926	ORD01370	PROD0062	3	22431.17	67293.51
2927	ORD01370	PROD0200	3	29196.20	87588.60
2928	ORD01371	PROD0081	4	110991.10	443964.40
2929	ORD01371	PROD0086	5	49202.47	246012.35
2930	ORD01371	PROD0190	4	22778.54	91114.16
2931	ORD01371	PROD0077	1	20510.26	20510.26
2932	ORD01371	PROD0064	3	34644.88	103934.64
2933	ORD01372	PROD0217	1	7092.62	7092.62
2934	ORD01373	PROD0101	3	114695.41	344086.23
2935	ORD01374	PROD0003	4	49538.31	198153.24
2936	ORD01374	PROD0035	4	190414.55	761658.20
2937	ORD01374	PROD0226	1	7172.97	7172.97
2938	ORD01374	PROD0118	3	12699.55	38098.65
2939	ORD01374	PROD0047	4	5512.81	22051.24
2940	ORD01375	PROD0039	2	257535.23	515070.46
2941	ORD01376	PROD0136	1	8175.35	8175.35
2942	ORD01376	PROD0188	3	51993.13	155979.39
2943	ORD01376	PROD0110	4	23332.73	93330.92
2944	ORD01377	PROD0269	4	2989.48	11957.92
2945	ORD01377	PROD0273	3	1784.35	5353.05
2946	ORD01377	PROD0204	4	5933.15	23732.60
2947	ORD01378	PROD0166	5	101932.80	509664.00
2948	ORD01379	PROD0026	2	34248.48	68496.96
2949	ORD01379	PROD0096	4	179864.29	719457.16
2950	ORD01380	PROD0052	5	23501.69	117508.45
2951	ORD01380	PROD0096	3	179864.29	539592.87
2952	ORD01380	PROD0084	4	37258.14	149032.56
2953	ORD01380	PROD0014	4	289145.53	1156582.12
2954	ORD01381	PROD0109	2	70228.44	140456.88
2955	ORD01381	PROD0069	5	39168.98	195844.90
2956	ORD01382	PROD0165	4	22136.37	88545.48
2957	ORD01382	PROD0123	4	11097.43	44389.72
2958	ORD01382	PROD0084	5	37258.14	186290.70
2959	ORD01382	PROD0203	5	3538.98	17694.90
2960	ORD01383	PROD0274	3	7846.95	23540.85
2961	ORD01384	PROD0129	1	5323.48	5323.48
2962	ORD01384	PROD0001	4	279610.57	1118442.28
2963	ORD01385	PROD0037	2	266180.98	532361.96
2964	ORD01385	PROD0269	5	2989.48	14947.40
2965	ORD01386	PROD0176	1	30789.84	30789.84
2966	ORD01386	PROD0065	4	30524.10	122096.40
2967	ORD01386	PROD0200	3	29196.20	87588.60
2968	ORD01387	PROD0002	4	102447.74	409790.96
2969	ORD01388	PROD0222	4	2802.33	11209.32
2970	ORD01388	PROD0078	4	18117.48	72469.92
2971	ORD01388	PROD0066	4	36291.81	145167.24
2972	ORD01389	PROD0018	4	120439.60	481758.40
2973	ORD01389	PROD0204	3	5933.15	17799.45
2974	ORD01390	PROD0122	4	16203.67	64814.68
2975	ORD01391	PROD0148	1	3628.18	3628.18
2976	ORD01392	PROD0139	3	14201.82	42605.46
2977	ORD01392	PROD0010	5	270434.00	1352170.00
2978	ORD01392	PROD0223	2	7785.89	15571.78
2979	ORD01392	PROD0243	4	10094.25	40377.00
2980	ORD01393	PROD0008	4	121518.49	486073.96
2981	ORD01393	PROD0021	2	34405.68	68811.36
2982	ORD01393	PROD0126	5	13544.05	67720.25
2983	ORD01394	PROD0037	3	266180.98	798542.94
2984	ORD01394	PROD0145	5	22657.06	113285.30
2985	ORD01394	PROD0230	4	6077.64	24310.56
2986	ORD01394	PROD0137	5	2019.05	10095.25
2987	ORD01395	PROD0249	5	774.24	3871.20
2988	ORD01395	PROD0278	1	6353.37	6353.37
2989	ORD01395	PROD0143	3	13171.72	39515.16
2990	ORD01396	PROD0008	2	121518.49	243036.98
2991	ORD01396	PROD0145	4	22657.06	90628.24
2992	ORD01396	PROD0107	4	97418.23	389672.92
2993	ORD01397	PROD0052	1	23501.69	23501.69
2994	ORD01397	PROD0067	1	11627.77	11627.77
2995	ORD01397	PROD0081	3	110991.10	332973.30
2996	ORD01397	PROD0274	5	7846.95	39234.75
2997	ORD01398	PROD0231	4	6206.49	24825.96
2998	ORD01399	PROD0156	3	21374.21	64122.63
2999	ORD01399	PROD0255	4	7571.15	30284.60
3000	ORD01399	PROD0154	4	19738.96	78955.84
3001	ORD01399	PROD0089	5	45090.58	225452.90
3002	ORD01399	PROD0083	4	160848.97	643395.88
3003	ORD01400	PROD0270	5	907.09	4535.45
3004	ORD01401	PROD0268	1	2944.75	2944.75
3005	ORD01402	PROD0190	3	22778.54	68335.62
3006	ORD01402	PROD0206	4	5427.42	21709.68
3007	ORD01403	PROD0228	5	6170.81	30854.05
3008	ORD01403	PROD0138	4	15463.10	61852.40
3009	ORD01404	PROD0228	1	6170.81	6170.81
3010	ORD01404	PROD0079	1	13912.80	13912.80
3011	ORD01404	PROD0104	5	\N	\N
3012	ORD01404	PROD0203	1	3538.98	3538.98
3013	ORD01405	PROD0166	3	101932.80	305798.40
3014	ORD01406	PROD0268	3	2944.75	8834.25
3015	ORD01406	PROD0205	3	\N	\N
3016	ORD01407	PROD0027	4	26206.57	104826.28
3017	ORD01408	PROD0150	4	12003.33	48013.32
3018	ORD01408	PROD0030	4	253935.11	1015740.44
3019	ORD01408	PROD0183	3	26053.15	78159.45
3020	ORD01408	PROD0037	3	266180.98	798542.94
3021	ORD01409	PROD0242	1	5755.30	5755.30
3022	ORD01409	PROD0152	2	1904.28	3808.56
3023	ORD01410	PROD0009	1	198883.60	198883.60
3024	ORD01410	PROD0263	1	8199.23	8199.23
3025	ORD01410	PROD0120	4	35341.43	141365.72
3026	ORD01410	PROD0163	1	18374.63	18374.63
3027	ORD01410	PROD0241	2	1174.07	2348.14
3028	ORD01411	PROD0263	1	8199.23	8199.23
3029	ORD01411	PROD0211	3	8250.11	24750.33
3030	ORD01411	PROD0032	1	246601.80	246601.80
3031	ORD01411	PROD0089	5	45090.58	225452.90
3032	ORD01412	PROD0109	5	70228.44	351142.20
3033	ORD01412	PROD0138	4	15463.10	61852.40
3034	ORD01412	PROD0007	1	290642.30	290642.30
3035	ORD01413	PROD0070	5	25905.43	129527.15
3036	ORD01413	PROD0140	3	2847.84	8543.52
3037	ORD01413	PROD0173	1	39177.27	39177.27
3038	ORD01413	PROD0079	2	13912.80	27825.60
3039	ORD01414	PROD0182	4	33297.75	133191.00
3040	ORD01414	PROD0194	3	24802.59	74407.77
3041	ORD01415	PROD0115	1	2277.24	2277.24
3042	ORD01415	PROD0129	3	5323.48	15970.44
3043	ORD01416	PROD0129	3	5323.48	15970.44
3044	ORD01417	PROD0072	4	43142.24	172568.96
3045	ORD01417	PROD0171	2	105588.96	211177.92
3046	ORD01417	PROD0267	3	6230.11	18690.33
3047	ORD01417	PROD0144	2	801.07	1602.14
3048	ORD01417	PROD0009	1	198883.60	198883.60
3049	ORD01418	PROD0224	4	607.93	2431.72
3050	ORD01419	PROD0218	5	5238.20	26191.00
3051	ORD01419	PROD0137	2	2019.05	4038.10
3052	ORD01420	PROD0267	3	6230.11	18690.33
3053	ORD01420	PROD0203	1	3538.98	3538.98
3054	ORD01420	PROD0264	5	4118.15	20590.75
3055	ORD01421	PROD0185	2	112356.62	224713.24
3056	ORD01421	PROD0193	4	9954.82	39819.28
3057	ORD01421	PROD0144	4	801.07	3204.28
3058	ORD01422	PROD0002	4	102447.74	409790.96
3059	ORD01423	PROD0047	2	5512.81	11025.62
3060	ORD01423	PROD0240	3	10219.29	30657.87
3061	ORD01423	PROD0277	2	9657.13	19314.26
3062	ORD01423	PROD0257	4	2248.73	8994.92
3063	ORD01424	PROD0012	2	248709.70	497419.40
3064	ORD01424	PROD0216	2	3485.44	6970.88
3065	ORD01425	PROD0258	2	4792.40	9584.80
3066	ORD01425	PROD0014	2	289145.53	578291.06
3067	ORD01426	PROD0140	5	2847.84	14239.20
3068	ORD01427	PROD0229	1	4112.45	4112.45
3069	ORD01427	PROD0166	4	101932.80	407731.20
3070	ORD01427	PROD0133	4	23616.92	94467.68
3071	ORD01428	PROD0021	2	34405.68	68811.36
3072	ORD01428	PROD0232	4	4469.76	17879.04
3073	ORD01429	PROD0155	5	17522.15	87610.75
3074	ORD01429	PROD0190	5	22778.54	113892.70
3075	ORD01430	PROD0263	4	8199.23	32796.92
3076	ORD01430	PROD0227	2	9871.34	19742.68
3077	ORD01431	PROD0056	1	6299.62	6299.62
3078	ORD01431	PROD0093	5	8480.78	42403.90
3079	ORD01432	PROD0277	5	9657.13	48285.65
3080	ORD01433	PROD0014	4	289145.53	1156582.12
3081	ORD01433	PROD0251	4	5175.86	20703.44
3082	ORD01433	PROD0004	5	39811.79	199058.95
3083	ORD01434	PROD0199	2	28468.05	56936.10
3084	ORD01434	PROD0119	3	47472.78	142418.34
3085	ORD01435	PROD0233	1	10621.64	10621.64
3086	ORD01436	PROD0266	2	408.26	816.52
3087	ORD01436	PROD0116	3	20859.43	62578.29
3088	ORD01437	PROD0112	3	35280.59	105841.77
3089	ORD01437	PROD0052	3	23501.69	70505.07
3090	ORD01437	PROD0166	1	101932.80	101932.80
3091	ORD01438	PROD0114	3	7586.49	22759.47
3092	ORD01438	PROD0265	3	11740.65	35221.95
3093	ORD01439	PROD0160	1	12278.28	12278.28
3094	ORD01439	PROD0033	2	245627.48	491254.96
3095	ORD01439	PROD0158	2	12650.30	25300.60
3096	ORD01439	PROD0248	3	4809.30	14427.90
3097	ORD01439	PROD0027	1	26206.57	26206.57
3098	ORD01440	PROD0274	5	7846.95	39234.75
3099	ORD01440	PROD0039	4	257535.23	1030140.92
3100	ORD01440	PROD0020	4	293010.61	1172042.44
3101	ORD01441	PROD0219	5	14849.13	74245.65
3102	ORD01442	PROD0217	1	7092.62	7092.62
3103	ORD01442	PROD0219	1	14849.13	14849.13
3104	ORD01442	PROD0153	4	10840.50	43362.00
3105	ORD01443	PROD0107	3	97418.23	292254.69
3106	ORD01443	PROD0061	5	6821.26	34106.30
3107	ORD01444	PROD0225	2	9270.30	18540.60
3108	ORD01445	PROD0046	5	5762.47	28812.35
3109	ORD01445	PROD0170	3	45302.42	135907.26
3110	ORD01446	PROD0047	4	5512.81	22051.24
3111	ORD01447	PROD0276	4	6563.88	26255.52
3112	ORD01447	PROD0127	1	8700.29	8700.29
3113	ORD01447	PROD0222	4	2802.33	11209.32
3114	ORD01448	PROD0183	5	26053.15	130265.75
3115	ORD01449	PROD0033	4	245627.48	982509.92
3116	ORD01450	PROD0037	1	266180.98	266180.98
3117	ORD01450	PROD0147	2	5055.12	10110.24
3118	ORD01451	PROD0030	5	253935.11	1269675.55
3119	ORD01451	PROD0131	2	21092.44	42184.88
3120	ORD01452	PROD0065	3	30524.10	91572.30
3121	ORD01452	PROD0275	2	10193.83	20387.66
3122	ORD01452	PROD0208	2	9010.85	18021.70
3123	ORD01453	PROD0016	5	256280.50	1281402.50
3124	ORD01454	PROD0232	1	4469.76	4469.76
3125	ORD01454	PROD0236	5	7038.57	35192.85
3126	ORD01455	PROD0161	4	25829.99	103319.96
3127	ORD01456	PROD0113	3	145706.19	437118.57
3128	ORD01457	PROD0217	4	7092.62	28370.48
3129	ORD01457	PROD0114	3	7586.49	22759.47
3130	ORD01457	PROD0216	5	3485.44	17427.20
3131	ORD01458	PROD0207	1	11561.20	11561.20
3132	ORD01459	PROD0156	4	21374.21	85496.84
3133	ORD01460	PROD0057	4	24240.82	96963.28
3134	ORD01460	PROD0197	2	113579.08	227158.16
3135	ORD01460	PROD0127	4	8700.29	34801.16
3136	ORD01461	PROD0172	3	95695.43	287086.29
3137	ORD01462	PROD0135	1	2595.60	2595.60
3138	ORD01462	PROD0048	2	10843.12	21686.24
3139	ORD01462	PROD0153	5	10840.50	54202.50
3140	ORD01462	PROD0024	3	321716.92	965150.76
3141	ORD01463	PROD0139	5	14201.82	71009.10
3142	ORD01463	PROD0148	4	3628.18	14512.72
3143	ORD01463	PROD0131	4	21092.44	84369.76
3144	ORD01464	PROD0185	3	112356.62	337069.86
3145	ORD01465	PROD0102	3	45021.16	135063.48
3146	ORD01465	PROD0077	1	20510.26	20510.26
3147	ORD01466	PROD0163	1	18374.63	18374.63
3148	ORD01466	PROD0110	2	23332.73	46665.46
3149	ORD01467	PROD0264	1	4118.15	4118.15
3150	ORD01467	PROD0100	5	110269.71	551348.55
3151	ORD01468	PROD0044	3	32574.27	97722.81
3152	ORD01469	PROD0054	1	31709.48	31709.48
3153	ORD01470	PROD0164	3	6702.72	20108.16
3154	ORD01470	PROD0217	2	7092.62	14185.24
3155	ORD01471	PROD0074	2	13460.87	26921.74
3156	ORD01471	PROD0220	1	11275.57	11275.57
3157	ORD01471	PROD0102	3	45021.16	135063.48
3158	ORD01472	PROD0100	1	110269.71	110269.71
3159	ORD01473	PROD0071	3	9870.56	29611.68
3160	ORD01473	PROD0087	1	12717.02	12717.02
3161	ORD01474	PROD0039	3	257535.23	772605.69
3162	ORD01475	PROD0106	2	137481.28	274962.56
3163	ORD01475	PROD0266	2	408.26	816.52
3164	ORD01475	PROD0073	3	6732.32	20196.96
3165	ORD01475	PROD0066	1	36291.81	36291.81
3166	ORD01476	PROD0194	2	24802.59	49605.18
3167	ORD01477	PROD0107	3	97418.23	292254.69
3168	ORD01478	PROD0194	1	24802.59	24802.59
3169	ORD01479	PROD0211	2	8250.11	16500.22
3170	ORD01479	PROD0146	2	9207.08	18414.16
3171	ORD01479	PROD0171	3	105588.96	316766.88
3172	ORD01480	PROD0089	4	45090.58	180362.32
3173	ORD01480	PROD0136	4	8175.35	32701.40
3174	ORD01480	PROD0263	2	8199.23	16398.46
3175	ORD01481	PROD0233	2	10621.64	21243.28
3176	ORD01481	PROD0243	3	10094.25	30282.75
3177	ORD01482	PROD0048	3	10843.12	32529.36
3178	ORD01483	PROD0137	2	2019.05	4038.10
3179	ORD01483	PROD0250	3	4620.81	13862.43
3180	ORD01483	PROD0200	2	29196.20	58392.40
3181	ORD01484	PROD0190	2	22778.54	45557.08
3182	ORD01484	PROD0113	4	145706.19	582824.76
3183	ORD01485	PROD0163	3	18374.63	55123.89
3184	ORD01485	PROD0120	2	35341.43	70682.86
3185	ORD01486	PROD0174	2	110640.11	221280.22
3186	ORD01486	PROD0128	3	24463.34	73390.02
3187	ORD01487	PROD0174	4	110640.11	442560.44
3188	ORD01488	PROD0115	4	2277.24	9108.96
3189	ORD01488	PROD0166	5	101932.80	509664.00
3190	ORD01488	PROD0139	3	14201.82	42605.46
3191	ORD01488	PROD0109	5	70228.44	351142.20
3192	ORD01488	PROD0147	4	5055.12	20220.48
3193	ORD01489	PROD0076	5	27116.85	135584.25
3194	ORD01489	PROD0152	2	1904.28	3808.56
3195	ORD01489	PROD0241	5	1174.07	5870.35
3196	ORD01490	PROD0182	5	33297.75	166488.75
3197	ORD01490	PROD0115	1	2277.24	2277.24
3198	ORD01491	PROD0012	4	248709.70	994838.80
3199	ORD01492	PROD0141	5	11608.58	58042.90
3200	ORD01492	PROD0275	1	10193.83	10193.83
3201	ORD01492	PROD0217	5	7092.62	35463.10
3202	ORD01492	PROD0247	2	5416.29	10832.58
3203	ORD01493	PROD0101	5	114695.41	573477.05
3204	ORD01494	PROD0085	3	89243.32	267729.96
3205	ORD01494	PROD0199	4	28468.05	113872.20
3206	ORD01494	PROD0152	2	1904.28	3808.56
3207	ORD01495	PROD0154	5	19738.96	98694.80
3208	ORD01495	PROD0006	3	308912.61	926737.83
3209	ORD01495	PROD0111	5	2676.03	13380.15
3210	ORD01495	PROD0203	1	3538.98	3538.98
3211	ORD01496	PROD0210	1	14712.50	14712.50
3212	ORD01496	PROD0232	4	4469.76	17879.04
3213	ORD01497	PROD0200	1	29196.20	29196.20
3214	ORD01498	PROD0140	1	2847.84	2847.84
3215	ORD01498	PROD0018	2	120439.60	240879.20
3216	ORD01499	PROD0106	1	137481.28	137481.28
3217	ORD01499	PROD0141	3	11608.58	34825.74
3218	ORD01499	PROD0274	1	7846.95	7846.95
3219	ORD01500	PROD0253	3	8743.34	26230.02
3220	ORD01500	PROD0111	5	2676.03	13380.15
3221	ORD01500	PROD0020	1	293010.61	293010.61
3222	ORD01500	PROD0038	1	88262.22	88262.22
3223	ORD01501	PROD0025	1	330590.39	330590.39
3224	ORD01501	PROD0160	2	12278.28	24556.56
3225	ORD01501	PROD0083	5	160848.97	804244.85
3226	ORD01502	PROD0017	3	257730.40	773191.20
3227	ORD01502	PROD0038	2	88262.22	176524.44
3228	ORD01502	PROD0021	1	34405.68	34405.68
3229	ORD01502	PROD0127	2	8700.29	17400.58
3230	ORD01503	PROD0108	1	121332.02	121332.02
3231	ORD01503	PROD0164	4	6702.72	26810.88
3232	ORD01503	PROD0102	5	45021.16	225105.80
3233	ORD01503	PROD0039	1	257535.23	257535.23
3234	ORD01503	PROD0218	4	5238.20	20952.80
3235	ORD01504	PROD0166	4	101932.80	407731.20
3236	ORD01505	PROD0070	1	25905.43	25905.43
3237	ORD01506	PROD0003	3	49538.31	148614.93
3238	ORD01506	PROD0083	1	160848.97	160848.97
3239	ORD01506	PROD0267	1	6230.11	6230.11
3240	ORD01506	PROD0046	2	5762.47	11524.94
3241	ORD01507	PROD0110	4	23332.73	93330.92
3242	ORD01508	PROD0123	1	11097.43	11097.43
3243	ORD01508	PROD0041	4	14461.31	57845.24
3244	ORD01509	PROD0078	1	18117.48	18117.48
3245	ORD01510	PROD0112	5	35280.59	176402.95
3246	ORD01510	PROD0170	4	45302.42	181209.68
3247	ORD01510	PROD0027	2	26206.57	52413.14
3248	ORD01510	PROD0211	4	8250.11	33000.44
3249	ORD01511	PROD0255	1	7571.15	7571.15
3250	ORD01511	PROD0160	2	12278.28	24556.56
3251	ORD01511	PROD0039	3	257535.23	772605.69
3252	ORD01512	PROD0270	3	907.09	2721.27
3253	ORD01513	PROD0030	1	253935.11	253935.11
3254	ORD01514	PROD0179	2	21340.87	42681.74
3255	ORD01514	PROD0206	3	5427.42	16282.26
3256	ORD01515	PROD0045	2	15761.34	31522.68
3257	ORD01515	PROD0234	4	6463.53	25854.12
3258	ORD01516	PROD0022	3	222156.94	666470.82
3259	ORD01516	PROD0043	3	16739.67	50219.01
3260	ORD01517	PROD0134	1	19220.41	19220.41
3261	ORD01517	PROD0021	1	34405.68	34405.68
3262	ORD01517	PROD0263	1	8199.23	8199.23
3263	ORD01517	PROD0228	4	6170.81	24683.24
3264	ORD01518	PROD0275	1	10193.83	10193.83
3265	ORD01518	PROD0073	4	6732.32	26929.28
3266	ORD01519	PROD0118	2	12699.55	25399.10
3267	ORD01520	PROD0080	2	14845.55	29691.10
3268	ORD01520	PROD0270	3	907.09	2721.27
3269	ORD01521	PROD0138	4	15463.10	61852.40
3270	ORD01522	PROD0127	3	8700.29	26100.87
3271	ORD01522	PROD0178	2	87684.88	175369.76
3272	ORD01522	PROD0016	3	256280.50	768841.50
3273	ORD01523	PROD0004	3	39811.79	119435.37
3274	ORD01523	PROD0224	1	607.93	607.93
3275	ORD01524	PROD0238	5	6026.76	30133.80
3276	ORD01524	PROD0269	1	2989.48	2989.48
3277	ORD01524	PROD0124	1	17164.25	17164.25
3278	ORD01524	PROD0015	1	222324.51	222324.51
3279	ORD01524	PROD0066	3	36291.81	108875.43
3280	ORD01525	PROD0065	5	30524.10	152620.50
3281	ORD01526	PROD0148	2	3628.18	7256.36
3282	ORD01526	PROD0066	1	36291.81	36291.81
3283	ORD01526	PROD0019	5	339524.65	1697623.25
3284	ORD01527	PROD0013	4	337113.25	1348453.00
3285	ORD01527	PROD0117	5	31515.40	157577.00
3286	ORD01528	PROD0228	2	6170.81	12341.62
3287	ORD01528	PROD0129	4	5323.48	21293.92
3288	ORD01529	PROD0191	3	44052.51	132157.53
3289	ORD01529	PROD0157	2	10758.03	21516.06
3290	ORD01529	PROD0011	5	314229.61	1571148.05
3291	ORD01529	PROD0279	1	962.48	962.48
3292	ORD01530	PROD0184	5	48414.15	242070.75
3293	ORD01530	PROD0079	5	13912.80	69564.00
3294	ORD01531	PROD0232	3	4469.76	13409.28
3295	ORD01532	PROD0115	5	2277.24	11386.20
3296	ORD01532	PROD0215	1	3385.48	3385.48
3297	ORD01533	PROD0144	2	801.07	1602.14
3298	ORD01534	PROD0155	4	17522.15	70088.60
3299	ORD01535	PROD0073	3	6732.32	20196.96
3300	ORD01536	PROD0065	3	30524.10	91572.30
3301	ORD01537	PROD0168	3	100026.32	300078.96
3302	ORD01537	PROD0274	3	7846.95	23540.85
3303	ORD01538	PROD0256	5	1625.49	8127.45
3304	ORD01539	PROD0110	2	23332.73	46665.46
3305	ORD01540	PROD0114	1	7586.49	7586.49
3306	ORD01541	PROD0072	5	43142.24	215711.20
3307	ORD01541	PROD0223	5	7785.89	38929.45
3308	ORD01541	PROD0201	1	10976.40	10976.40
3309	ORD01541	PROD0095	4	49921.23	199684.92
3310	ORD01542	PROD0045	4	15761.34	63045.36
3311	ORD01543	PROD0091	4	141135.80	564543.20
3312	ORD01543	PROD0208	5	9010.85	45054.25
3313	ORD01544	PROD0111	5	2676.03	13380.15
3314	ORD01544	PROD0063	2	35488.70	70977.40
3315	ORD01544	PROD0119	5	47472.78	237363.90
3316	ORD01545	PROD0025	5	330590.39	1652951.95
3317	ORD01545	PROD0055	2	42567.03	85134.06
3318	ORD01546	PROD0002	1	102447.74	102447.74
3319	ORD01546	PROD0030	2	253935.11	507870.22
3320	ORD01547	PROD0193	1	9954.82	9954.82
3321	ORD01547	PROD0144	5	801.07	4005.35
3322	ORD01547	PROD0253	3	8743.34	26230.02
3323	ORD01548	PROD0074	2	13460.87	26921.74
3324	ORD01548	PROD0117	2	31515.40	63030.80
3325	ORD01548	PROD0001	2	279610.57	559221.14
3326	ORD01548	PROD0147	1	5055.12	5055.12
3327	ORD01548	PROD0177	4	102403.06	409612.24
3328	ORD01549	PROD0149	4	8124.11	32496.44
3329	ORD01550	PROD0256	4	1625.49	6501.96
3330	ORD01550	PROD0220	4	11275.57	45102.28
3331	ORD01551	PROD0045	3	15761.34	47284.02
3332	ORD01552	PROD0068	2	43176.46	86352.92
3333	ORD01553	PROD0013	2	337113.25	674226.50
3334	ORD01553	PROD0198	3	57432.47	172297.41
3335	ORD01553	PROD0245	2	\N	\N
3336	ORD01553	PROD0219	2	14849.13	29698.26
3337	ORD01554	PROD0071	4	9870.56	39482.24
3338	ORD01555	PROD0255	1	7571.15	7571.15
3339	ORD01555	PROD0043	3	16739.67	50219.01
3340	ORD01556	PROD0173	5	39177.27	195886.35
3341	ORD01556	PROD0126	5	13544.05	67720.25
3342	ORD01557	PROD0224	3	607.93	1823.79
3343	ORD01558	PROD0275	4	10193.83	40775.32
3344	ORD01558	PROD0133	4	23616.92	94467.68
3345	ORD01558	PROD0053	3	43609.38	130828.14
3346	ORD01558	PROD0252	5	8223.52	41117.60
3347	ORD01558	PROD0104	1	\N	\N
3348	ORD01559	PROD0051	3	33329.69	99989.07
3349	ORD01560	PROD0202	4	12764.12	51056.48
3350	ORD01560	PROD0150	4	12003.33	48013.32
3351	ORD01560	PROD0095	2	49921.23	99842.46
3352	ORD01561	PROD0177	2	102403.06	204806.12
3353	ORD01562	PROD0161	5	25829.99	129149.95
3354	ORD01562	PROD0198	4	57432.47	229729.88
3355	ORD01563	PROD0085	5	89243.32	446216.60
3356	ORD01563	PROD0143	3	13171.72	39515.16
3357	ORD01564	PROD0212	5	8757.97	43789.85
3358	ORD01565	PROD0028	4	316366.34	1265465.36
3359	ORD01565	PROD0216	4	3485.44	13941.76
3360	ORD01565	PROD0065	4	30524.10	122096.40
3361	ORD01566	PROD0111	3	2676.03	8028.09
3362	ORD01566	PROD0132	2	23990.67	47981.34
3363	ORD01567	PROD0003	2	49538.31	99076.62
3364	ORD01568	PROD0238	1	6026.76	6026.76
3365	ORD01568	PROD0071	5	9870.56	49352.80
3366	ORD01568	PROD0192	3	94625.99	283877.97
3367	ORD01569	PROD0048	4	10843.12	43372.48
3368	ORD01569	PROD0150	5	12003.33	60016.65
3369	ORD01570	PROD0080	5	14845.55	74227.75
3370	ORD01570	PROD0029	3	149660.33	448980.99
3371	ORD01571	PROD0101	4	114695.41	458781.64
3372	ORD01572	PROD0071	2	9870.56	19741.12
3373	ORD01573	PROD0130	5	1182.88	5914.40
3374	ORD01574	PROD0012	2	248709.70	497419.40
3375	ORD01574	PROD0261	5	8607.87	43039.35
3376	ORD01575	PROD0172	3	95695.43	287086.29
3377	ORD01576	PROD0190	4	22778.54	91114.16
3378	ORD01577	PROD0111	1	2676.03	2676.03
3379	ORD01577	PROD0192	1	94625.99	94625.99
3380	ORD01577	PROD0026	3	34248.48	102745.44
3381	ORD01577	PROD0001	3	279610.57	838831.71
3382	ORD01578	PROD0025	2	330590.39	661180.78
3383	ORD01579	PROD0032	3	246601.80	739805.40
3384	ORD01580	PROD0110	3	23332.73	69998.19
3385	ORD01581	PROD0235	3	1609.74	4829.22
3386	ORD01581	PROD0164	5	6702.72	33513.60
3387	ORD01582	PROD0196	4	2511.26	10045.04
3388	ORD01582	PROD0145	4	22657.06	90628.24
3389	ORD01582	PROD0230	5	6077.64	30388.20
3390	ORD01582	PROD0057	3	24240.82	72722.46
3391	ORD01583	PROD0248	1	4809.30	4809.30
3392	ORD01583	PROD0053	1	43609.38	43609.38
3393	ORD01583	PROD0224	3	607.93	1823.79
3394	ORD01584	PROD0241	4	1174.07	4696.28
3395	ORD01585	PROD0244	3	1664.99	4994.97
3396	ORD01585	PROD0022	1	222156.94	222156.94
3397	ORD01586	PROD0035	4	190414.55	761658.20
3398	ORD01586	PROD0179	3	21340.87	64022.61
3399	ORD01587	PROD0261	3	8607.87	25823.61
3400	ORD01587	PROD0084	2	37258.14	74516.28
3401	ORD01588	PROD0023	3	276589.43	829768.29
3402	ORD01588	PROD0035	5	190414.55	952072.75
3403	ORD01589	PROD0104	1	\N	\N
3404	ORD01590	PROD0197	4	113579.08	454316.32
3405	ORD01591	PROD0065	5	30524.10	152620.50
3406	ORD01592	PROD0240	5	10219.29	51096.45
3407	ORD01592	PROD0098	5	54814.26	274071.30
3408	ORD01592	PROD0004	4	39811.79	159247.16
3409	ORD01593	PROD0244	5	1664.99	8324.95
3410	ORD01593	PROD0241	3	1174.07	3522.21
3411	ORD01593	PROD0234	2	6463.53	12927.06
3412	ORD01593	PROD0060	3	10877.79	32633.37
3413	ORD01593	PROD0062	2	22431.17	44862.34
3414	ORD01594	PROD0043	2	16739.67	33479.34
3415	ORD01595	PROD0149	4	8124.11	32496.44
3416	ORD01596	PROD0229	5	4112.45	20562.25
3417	ORD01596	PROD0241	4	1174.07	4696.28
3418	ORD01596	PROD0049	1	27088.42	27088.42
3419	ORD01597	PROD0205	4	\N	\N
3420	ORD01597	PROD0207	4	11561.20	46244.80
3421	ORD01598	PROD0137	1	2019.05	2019.05
3422	ORD01599	PROD0187	2	28776.04	57552.08
3423	ORD01600	PROD0133	5	23616.92	118084.60
3424	ORD01600	PROD0125	1	22153.16	22153.16
3425	ORD01601	PROD0059	3	35594.97	106784.91
3426	ORD01602	PROD0050	4	26917.21	107668.84
3427	ORD01602	PROD0023	2	276589.43	553178.86
3428	ORD01602	PROD0036	4	78738.41	314953.64
3429	ORD01603	PROD0240	5	10219.29	51096.45
3430	ORD01603	PROD0173	4	39177.27	156709.08
3431	ORD01604	PROD0046	5	5762.47	28812.35
3432	ORD01605	PROD0259	4	7869.35	31477.40
3433	ORD01606	PROD0012	4	248709.70	994838.80
3434	ORD01606	PROD0107	2	97418.23	194836.46
3435	ORD01606	PROD0047	4	5512.81	22051.24
3436	ORD01607	PROD0086	1	49202.47	49202.47
3437	ORD01607	PROD0256	1	1625.49	1625.49
3438	ORD01607	PROD0066	1	36291.81	36291.81
3439	ORD01607	PROD0149	2	8124.11	16248.22
3440	ORD01608	PROD0164	5	6702.72	33513.60
3441	ORD01608	PROD0045	3	15761.34	47284.02
3442	ORD01608	PROD0013	3	337113.25	1011339.75
3443	ORD01609	PROD0102	2	45021.16	90042.32
3444	ORD01609	PROD0121	4	17176.67	68706.68
3445	ORD01609	PROD0164	5	6702.72	33513.60
3446	ORD01609	PROD0216	2	3485.44	6970.88
3447	ORD01610	PROD0034	5	272513.12	1362565.60
3448	ORD01610	PROD0228	1	6170.81	6170.81
3449	ORD01611	PROD0089	1	45090.58	45090.58
3450	ORD01611	PROD0270	3	907.09	2721.27
3451	ORD01611	PROD0119	5	47472.78	237363.90
3452	ORD01611	PROD0172	5	95695.43	478477.15
3453	ORD01611	PROD0143	2	13171.72	26343.44
3454	ORD01612	PROD0214	1	12483.89	12483.89
3455	ORD01612	PROD0218	2	5238.20	10476.40
3456	ORD01613	PROD0043	2	16739.67	33479.34
3457	ORD01613	PROD0072	4	43142.24	172568.96
3458	ORD01614	PROD0235	1	1609.74	1609.74
3459	ORD01614	PROD0002	1	102447.74	102447.74
3460	ORD01614	PROD0178	3	87684.88	263054.64
3461	ORD01614	PROD0113	5	145706.19	728530.95
3462	ORD01614	PROD0038	2	88262.22	176524.44
3463	ORD01615	PROD0104	5	\N	\N
3464	ORD01615	PROD0230	5	6077.64	30388.20
3465	ORD01616	PROD0072	4	43142.24	172568.96
3466	ORD01616	PROD0217	4	7092.62	28370.48
3467	ORD01616	PROD0120	3	35341.43	106024.29
3468	ORD01617	PROD0246	2	5399.76	10799.52
3469	ORD01617	PROD0204	5	5933.15	29665.75
3470	ORD01618	PROD0013	4	337113.25	1348453.00
3471	ORD01618	PROD0045	2	15761.34	31522.68
3472	ORD01619	PROD0264	5	4118.15	20590.75
3473	ORD01619	PROD0006	2	308912.61	617825.22
3474	ORD01620	PROD0276	4	6563.88	26255.52
3475	ORD01620	PROD0001	3	279610.57	838831.71
3476	ORD01621	PROD0175	5	102750.60	513753.00
3477	ORD01622	PROD0097	5	9141.77	45708.85
3478	ORD01623	PROD0226	1	7172.97	7172.97
3479	ORD01624	PROD0072	5	43142.24	215711.20
3480	ORD01625	PROD0042	3	44258.35	132775.05
3481	ORD01625	PROD0059	5	35594.97	177974.85
3482	ORD01626	PROD0095	5	49921.23	249606.15
3483	ORD01626	PROD0135	2	2595.60	5191.20
3484	ORD01626	PROD0139	5	14201.82	71009.10
3485	ORD01627	PROD0009	5	198883.60	994418.00
3486	ORD01627	PROD0073	2	6732.32	13464.64
3487	ORD01628	PROD0201	4	10976.40	43905.60
3488	ORD01628	PROD0019	3	339524.65	1018573.95
3489	ORD01629	PROD0083	1	160848.97	160848.97
3490	ORD01629	PROD0117	5	31515.40	157577.00
3491	ORD01629	PROD0097	1	9141.77	9141.77
3492	ORD01629	PROD0209	4	2728.52	10914.08
3493	ORD01629	PROD0108	2	121332.02	242664.04
3494	ORD01630	PROD0198	3	57432.47	172297.41
3495	ORD01630	PROD0217	5	7092.62	35463.10
3496	ORD01630	PROD0072	4	43142.24	172568.96
3497	ORD01631	PROD0168	4	100026.32	400105.28
3498	ORD01631	PROD0254	5	9824.37	49121.85
3499	ORD01631	PROD0048	3	10843.12	32529.36
3500	ORD01631	PROD0142	4	8820.60	35282.40
3501	ORD01631	PROD0157	4	10758.03	43032.12
3502	ORD01632	PROD0156	3	21374.21	64122.63
3503	ORD01633	PROD0220	5	11275.57	56377.85
3504	ORD01634	PROD0138	5	15463.10	77315.50
3505	ORD01635	PROD0181	4	63768.87	255075.48
3506	ORD01635	PROD0220	2	11275.57	22551.14
3507	ORD01635	PROD0082	4	54346.36	217385.44
3508	ORD01635	PROD0214	4	12483.89	49935.56
3509	ORD01636	PROD0243	4	10094.25	40377.00
3510	ORD01636	PROD0187	1	28776.04	28776.04
3511	ORD01636	PROD0269	5	2989.48	14947.40
3512	ORD01637	PROD0112	3	35280.59	105841.77
3513	ORD01637	PROD0129	2	5323.48	10646.96
3514	ORD01638	PROD0013	3	337113.25	1011339.75
3515	ORD01639	PROD0238	2	6026.76	12053.52
3516	ORD01640	PROD0240	4	10219.29	40877.16
3517	ORD01641	PROD0177	1	102403.06	102403.06
3518	ORD01642	PROD0003	3	49538.31	148614.93
3519	ORD01642	PROD0154	1	19738.96	19738.96
3520	ORD01643	PROD0136	5	8175.35	40876.75
3521	ORD01643	PROD0120	3	35341.43	106024.29
3522	ORD01643	PROD0115	2	2277.24	4554.48
3523	ORD01643	PROD0252	1	8223.52	8223.52
3524	ORD01644	PROD0086	3	49202.47	147607.41
3525	ORD01644	PROD0206	2	5427.42	10854.84
3526	ORD01644	PROD0184	5	48414.15	242070.75
3527	ORD01644	PROD0095	4	49921.23	199684.92
3528	ORD01644	PROD0236	4	7038.57	28154.28
3529	ORD01645	PROD0115	5	2277.24	11386.20
3530	ORD01646	PROD0221	5	13121.51	65607.55
3531	ORD01646	PROD0021	1	34405.68	34405.68
3532	ORD01647	PROD0161	1	25829.99	25829.99
3533	ORD01647	PROD0113	4	145706.19	582824.76
3534	ORD01647	PROD0233	2	10621.64	21243.28
3535	ORD01648	PROD0198	2	57432.47	114864.94
3536	ORD01648	PROD0049	1	27088.42	27088.42
3537	ORD01649	PROD0132	4	23990.67	95962.68
3538	ORD01649	PROD0052	1	23501.69	23501.69
3539	ORD01649	PROD0089	5	45090.58	225452.90
3540	ORD01650	PROD0031	5	290316.23	1451581.15
3541	ORD01650	PROD0218	2	5238.20	10476.40
3542	ORD01651	PROD0031	1	290316.23	290316.23
3543	ORD01651	PROD0160	3	12278.28	36834.84
3544	ORD01651	PROD0172	5	95695.43	478477.15
3545	ORD01652	PROD0052	2	23501.69	47003.38
3546	ORD01652	PROD0089	3	45090.58	135271.74
3547	ORD01653	PROD0158	2	12650.30	25300.60
3548	ORD01653	PROD0258	1	4792.40	4792.40
3549	ORD01653	PROD0177	2	102403.06	204806.12
3550	ORD01653	PROD0047	3	5512.81	16538.43
3551	ORD01653	PROD0150	5	12003.33	60016.65
3552	ORD01654	PROD0122	2	16203.67	32407.34
3553	ORD01654	PROD0055	3	42567.03	127701.09
3554	ORD01655	PROD0033	3	245627.48	736882.44
3555	ORD01655	PROD0057	3	24240.82	72722.46
3556	ORD01656	PROD0104	5	\N	\N
3557	ORD01656	PROD0154	3	19738.96	59216.88
3558	ORD01656	PROD0128	2	24463.34	48926.68
3559	ORD01656	PROD0224	1	607.93	607.93
3560	ORD01657	PROD0061	3	6821.26	20463.78
3561	ORD01657	PROD0055	1	42567.03	42567.03
3562	ORD01658	PROD0200	1	29196.20	29196.20
3563	ORD01658	PROD0174	4	110640.11	442560.44
3564	ORD01659	PROD0043	5	16739.67	83698.35
3565	ORD01659	PROD0028	4	316366.34	1265465.36
3566	ORD01660	PROD0227	4	9871.34	39485.36
3567	ORD01660	PROD0112	4	35280.59	141122.36
3568	ORD01660	PROD0236	1	7038.57	7038.57
3569	ORD01661	PROD0227	3	9871.34	29614.02
3570	ORD01661	PROD0150	5	12003.33	60016.65
3571	ORD01662	PROD0091	1	141135.80	141135.80
3572	ORD01663	PROD0110	3	23332.73	69998.19
3573	ORD01663	PROD0159	1	17483.90	17483.90
3574	ORD01664	PROD0025	3	330590.39	991771.17
3575	ORD01665	PROD0153	5	10840.50	54202.50
3576	ORD01665	PROD0036	2	78738.41	157476.82
3577	ORD01666	PROD0068	1	43176.46	43176.46
3578	ORD01666	PROD0229	1	4112.45	4112.45
3579	ORD01666	PROD0089	3	45090.58	135271.74
3580	ORD01667	PROD0002	1	102447.74	102447.74
3581	ORD01668	PROD0199	2	28468.05	56936.10
3582	ORD01668	PROD0268	4	2944.75	11779.00
3583	ORD01668	PROD0063	1	35488.70	35488.70
3584	ORD01668	PROD0211	2	8250.11	16500.22
3585	ORD01669	PROD0195	4	24091.13	96364.52
3586	ORD01669	PROD0007	4	290642.30	1162569.20
3587	ORD01669	PROD0239	4	1047.73	4190.92
3588	ORD01669	PROD0262	2	3172.89	6345.78
3589	ORD01669	PROD0157	1	10758.03	10758.03
3590	ORD01670	PROD0124	3	17164.25	51492.75
3591	ORD01671	PROD0165	2	22136.37	44272.74
3592	ORD01671	PROD0054	2	31709.48	63418.96
3593	ORD01672	PROD0136	3	8175.35	24526.05
3594	ORD01672	PROD0156	3	21374.21	64122.63
3595	ORD01672	PROD0186	4	17418.14	69672.56
3596	ORD01673	PROD0233	4	10621.64	42486.56
3597	ORD01673	PROD0220	1	11275.57	11275.57
3598	ORD01674	PROD0073	2	6732.32	13464.64
3599	ORD01674	PROD0218	5	5238.20	26191.00
3600	ORD01675	PROD0226	3	7172.97	21518.91
3601	ORD01675	PROD0279	3	962.48	2887.44
3602	ORD01675	PROD0113	4	145706.19	582824.76
3603	ORD01675	PROD0013	2	337113.25	674226.50
3604	ORD01676	PROD0072	2	43142.24	86284.48
3605	ORD01677	PROD0201	4	10976.40	43905.60
3606	ORD01678	PROD0235	4	1609.74	6438.96
3607	ORD01679	PROD0152	5	1904.28	9521.40
3608	ORD01680	PROD0129	3	5323.48	15970.44
3609	ORD01680	PROD0199	4	28468.05	113872.20
3610	ORD01681	PROD0119	1	47472.78	47472.78
3611	ORD01682	PROD0177	5	102403.06	512015.30
3612	ORD01682	PROD0093	1	8480.78	8480.78
3613	ORD01682	PROD0075	2	5182.19	10364.38
3614	ORD01683	PROD0075	5	5182.19	25910.95
3615	ORD01684	PROD0045	5	15761.34	78806.70
3616	ORD01685	PROD0230	5	6077.64	30388.20
3617	ORD01686	PROD0230	2	6077.64	12155.28
3618	ORD01686	PROD0030	1	253935.11	253935.11
3619	ORD01686	PROD0162	4	2672.21	10688.84
3620	ORD01686	PROD0083	1	160848.97	160848.97
3621	ORD01687	PROD0049	5	27088.42	135442.10
3622	ORD01688	PROD0161	2	25829.99	51659.98
3623	ORD01688	PROD0209	1	2728.52	2728.52
3624	ORD01689	PROD0230	1	6077.64	6077.64
3625	ORD01689	PROD0092	4	140982.24	563928.96
3626	ORD01689	PROD0213	5	2985.64	14928.20
3627	ORD01690	PROD0109	5	70228.44	351142.20
3628	ORD01691	PROD0059	1	35594.97	35594.97
3629	ORD01691	PROD0107	4	97418.23	389672.92
3630	ORD01692	PROD0100	4	110269.71	441078.84
3631	ORD01693	PROD0019	1	339524.65	339524.65
3632	ORD01694	PROD0152	3	1904.28	5712.84
3633	ORD01695	PROD0143	2	13171.72	26343.44
3634	ORD01696	PROD0140	1	2847.84	2847.84
3635	ORD01697	PROD0216	2	3485.44	6970.88
3636	ORD01697	PROD0092	2	140982.24	281964.48
3637	ORD01697	PROD0055	4	42567.03	170268.12
3638	ORD01698	PROD0133	1	23616.92	23616.92
3639	ORD01699	PROD0112	1	35280.59	35280.59
3640	ORD01700	PROD0173	5	39177.27	195886.35
3641	ORD01700	PROD0024	4	321716.92	1286867.68
3642	ORD01701	PROD0017	1	257730.40	257730.40
3643	ORD01701	PROD0091	4	141135.80	564543.20
3644	ORD01702	PROD0261	1	8607.87	8607.87
3645	ORD01702	PROD0033	2	245627.48	491254.96
3646	ORD01703	PROD0070	1	25905.43	25905.43
3647	ORD01704	PROD0088	2	\N	\N
3648	ORD01705	PROD0032	2	246601.80	493203.60
3649	ORD01705	PROD0211	2	8250.11	16500.22
3650	ORD01705	PROD0126	4	13544.05	54176.20
3651	ORD01706	PROD0159	3	17483.90	52451.70
3652	ORD01706	PROD0149	2	8124.11	16248.22
3653	ORD01707	PROD0126	1	13544.05	13544.05
3654	ORD01707	PROD0189	5	96833.78	484168.90
3655	ORD01708	PROD0173	3	39177.27	117531.81
3656	ORD01708	PROD0214	1	12483.89	12483.89
3657	ORD01709	PROD0034	4	272513.12	1090052.48
3658	ORD01709	PROD0099	1	130788.21	130788.21
3659	ORD01710	PROD0029	2	149660.33	299320.66
3660	ORD01710	PROD0261	4	8607.87	34431.48
3661	ORD01711	PROD0137	2	2019.05	4038.10
3662	ORD01712	PROD0196	5	2511.26	12556.30
3663	ORD01712	PROD0222	4	2802.33	11209.32
3664	ORD01713	PROD0129	1	5323.48	5323.48
3665	ORD01714	PROD0009	3	198883.60	596650.80
3666	ORD01714	PROD0119	2	47472.78	94945.56
3667	ORD01715	PROD0118	3	12699.55	38098.65
3668	ORD01715	PROD0122	2	16203.67	32407.34
3669	ORD01716	PROD0260	3	5050.94	15152.82
3670	ORD01716	PROD0223	2	7785.89	15571.78
3671	ORD01716	PROD0186	3	17418.14	52254.42
3672	ORD01717	PROD0176	4	30789.84	123159.36
3673	ORD01717	PROD0011	3	314229.61	942688.83
3674	ORD01718	PROD0268	5	2944.75	14723.75
3675	ORD01719	PROD0219	5	14849.13	74245.65
3676	ORD01720	PROD0241	1	1174.07	1174.07
3677	ORD01720	PROD0208	3	9010.85	27032.55
3678	ORD01720	PROD0169	4	41598.42	166393.68
3679	ORD01721	PROD0175	5	102750.60	513753.00
3680	ORD01721	PROD0141	5	11608.58	58042.90
3681	ORD01721	PROD0070	4	25905.43	103621.72
3682	ORD01722	PROD0194	4	24802.59	99210.36
3683	ORD01722	PROD0265	4	11740.65	46962.60
3684	ORD01723	PROD0012	4	248709.70	994838.80
3685	ORD01724	PROD0111	5	2676.03	13380.15
3686	ORD01725	PROD0215	1	3385.48	3385.48
3687	ORD01725	PROD0222	3	2802.33	8406.99
3688	ORD01725	PROD0167	1	22365.17	22365.17
3689	ORD01726	PROD0093	2	8480.78	16961.56
3690	ORD01727	PROD0265	1	11740.65	11740.65
3691	ORD01727	PROD0168	3	100026.32	300078.96
3692	ORD01727	PROD0010	4	270434.00	1081736.00
3693	ORD01727	PROD0143	4	13171.72	52686.88
3694	ORD01727	PROD0166	5	101932.80	509664.00
3695	ORD01728	PROD0223	5	7785.89	38929.45
3696	ORD01728	PROD0037	2	266180.98	532361.96
3697	ORD01728	PROD0242	3	5755.30	17265.90
3698	ORD01728	PROD0275	4	10193.83	40775.32
3699	ORD01729	PROD0276	2	6563.88	13127.76
3700	ORD01729	PROD0166	4	101932.80	407731.20
3701	ORD01729	PROD0252	3	8223.52	24670.56
3702	ORD01729	PROD0220	5	11275.57	56377.85
3703	ORD01730	PROD0148	4	3628.18	14512.72
3704	ORD01730	PROD0126	5	13544.05	67720.25
3705	ORD01731	PROD0044	1	32574.27	32574.27
3706	ORD01732	PROD0044	1	32574.27	32574.27
3707	ORD01732	PROD0107	3	97418.23	292254.69
3708	ORD01733	PROD0269	4	2989.48	11957.92
3709	ORD01733	PROD0193	1	9954.82	9954.82
3710	ORD01734	PROD0156	3	21374.21	64122.63
3711	ORD01735	PROD0126	2	13544.05	27088.10
3712	ORD01736	PROD0046	1	5762.47	5762.47
3713	ORD01736	PROD0245	4	\N	\N
3714	ORD01737	PROD0220	4	11275.57	45102.28
3715	ORD01737	PROD0089	2	45090.58	90181.16
3716	ORD01738	PROD0251	5	5175.86	25879.30
3717	ORD01738	PROD0254	3	9824.37	29473.11
3718	ORD01738	PROD0136	3	8175.35	24526.05
3719	ORD01738	PROD0192	2	94625.99	189251.98
3720	ORD01739	PROD0236	1	7038.57	7038.57
3721	ORD01739	PROD0130	2	1182.88	2365.76
3722	ORD01740	PROD0012	3	248709.70	746129.10
3723	ORD01740	PROD0246	1	5399.76	5399.76
3724	ORD01740	PROD0216	3	3485.44	10456.32
3725	ORD01740	PROD0240	5	10219.29	51096.45
3726	ORD01741	PROD0107	1	97418.23	97418.23
3727	ORD01741	PROD0031	1	290316.23	290316.23
3728	ORD01741	PROD0030	5	253935.11	1269675.55
3729	ORD01742	PROD0077	3	20510.26	61530.78
3730	ORD01742	PROD0124	3	17164.25	51492.75
3731	ORD01742	PROD0149	2	8124.11	16248.22
3732	ORD01743	PROD0067	1	11627.77	11627.77
3733	ORD01743	PROD0211	1	8250.11	8250.11
3734	ORD01743	PROD0221	3	13121.51	39364.53
3735	ORD01743	PROD0017	4	257730.40	1030921.60
3736	ORD01744	PROD0216	1	3485.44	3485.44
3737	ORD01745	PROD0161	5	25829.99	129149.95
3738	ORD01745	PROD0042	1	44258.35	44258.35
3739	ORD01745	PROD0045	3	15761.34	47284.02
3740	ORD01746	PROD0040	3	47715.49	143146.47
3741	ORD01746	PROD0160	4	12278.28	49113.12
3742	ORD01747	PROD0250	3	4620.81	13862.43
3743	ORD01747	PROD0001	4	279610.57	1118442.28
3744	ORD01748	PROD0076	3	27116.85	81350.55
3745	ORD01748	PROD0009	2	198883.60	397767.20
3746	ORD01749	PROD0085	2	89243.32	178486.64
3747	ORD01750	PROD0147	3	5055.12	15165.36
3748	ORD01750	PROD0009	3	198883.60	596650.80
3749	ORD01751	PROD0182	1	33297.75	33297.75
3750	ORD01752	PROD0125	2	22153.16	44306.32
3751	ORD01753	PROD0234	3	6463.53	19390.59
3752	ORD01754	PROD0086	2	49202.47	98404.94
3753	ORD01754	PROD0116	3	20859.43	62578.29
3754	ORD01754	PROD0259	1	7869.35	7869.35
3755	ORD01754	PROD0247	5	5416.29	27081.45
3756	ORD01755	PROD0049	1	27088.42	27088.42
3757	ORD01755	PROD0105	2	162358.65	324717.30
3758	ORD01756	PROD0137	4	2019.05	8076.20
3759	ORD01757	PROD0187	4	28776.04	115104.16
3760	ORD01757	PROD0086	5	49202.47	246012.35
3761	ORD01757	PROD0061	5	6821.26	34106.30
3762	ORD01758	PROD0039	2	257535.23	515070.46
3763	ORD01759	PROD0057	3	24240.82	72722.46
3764	ORD01759	PROD0193	5	9954.82	49774.10
3765	ORD01759	PROD0236	2	7038.57	14077.14
3766	ORD01760	PROD0047	1	5512.81	5512.81
3767	ORD01760	PROD0022	2	222156.94	444313.88
3768	ORD01761	PROD0089	5	45090.58	225452.90
3769	ORD01761	PROD0160	4	12278.28	49113.12
3770	ORD01761	PROD0081	2	110991.10	221982.20
3771	ORD01761	PROD0053	1	43609.38	43609.38
3772	ORD01761	PROD0190	5	22778.54	113892.70
3773	ORD01762	PROD0099	1	130788.21	130788.21
3774	ORD01762	PROD0152	1	1904.28	1904.28
3775	ORD01763	PROD0165	3	22136.37	66409.11
3776	ORD01763	PROD0115	3	2277.24	6831.72
3777	ORD01763	PROD0020	1	293010.61	293010.61
3778	ORD01763	PROD0098	4	54814.26	219257.04
3779	ORD01763	PROD0031	4	290316.23	1161264.92
3780	ORD01764	PROD0161	4	25829.99	103319.96
3781	ORD01764	PROD0164	4	6702.72	26810.88
3782	ORD01765	PROD0156	1	21374.21	21374.21
3783	ORD01766	PROD0137	3	2019.05	6057.15
3784	ORD01767	PROD0195	1	24091.13	24091.13
3785	ORD01767	PROD0048	5	10843.12	54215.60
3786	ORD01767	PROD0009	2	198883.60	397767.20
3787	ORD01768	PROD0065	4	30524.10	122096.40
3788	ORD01768	PROD0078	3	18117.48	54352.44
3789	ORD01768	PROD0043	4	16739.67	66958.68
3790	ORD01769	PROD0016	5	256280.50	1281402.50
3791	ORD01769	PROD0271	1	1989.71	1989.71
3792	ORD01769	PROD0100	1	110269.71	110269.71
3793	ORD01769	PROD0139	1	14201.82	14201.82
3794	ORD01769	PROD0255	3	7571.15	22713.45
3795	ORD01770	PROD0067	2	11627.77	23255.54
3796	ORD01771	PROD0238	3	6026.76	18080.28
3797	ORD01772	PROD0063	5	35488.70	177443.50
3798	ORD01772	PROD0075	3	5182.19	15546.57
3799	ORD01773	PROD0263	2	8199.23	16398.46
3800	ORD01773	PROD0012	5	248709.70	1243548.50
3801	ORD01774	PROD0135	1	2595.60	2595.60
3802	ORD01774	PROD0231	5	6206.49	31032.45
3803	ORD01774	PROD0205	1	\N	\N
3804	ORD01774	PROD0175	3	102750.60	308251.80
3805	ORD01775	PROD0133	2	23616.92	47233.84
3806	ORD01776	PROD0252	5	8223.52	41117.60
3807	ORD01777	PROD0122	2	16203.67	32407.34
3808	ORD01777	PROD0038	4	88262.22	353048.88
3809	ORD01778	PROD0046	1	5762.47	5762.47
3810	ORD01779	PROD0142	5	8820.60	44103.00
3811	ORD01779	PROD0229	5	4112.45	20562.25
3812	ORD01779	PROD0041	1	14461.31	14461.31
3813	ORD01780	PROD0267	5	6230.11	31150.55
3814	ORD01780	PROD0166	3	101932.80	305798.40
3815	ORD01780	PROD0126	3	13544.05	40632.15
3816	ORD01780	PROD0087	1	12717.02	12717.02
3817	ORD01781	PROD0120	5	35341.43	176707.15
3818	ORD01781	PROD0158	3	12650.30	37950.90
3819	ORD01781	PROD0226	1	7172.97	7172.97
3820	ORD01781	PROD0066	4	36291.81	145167.24
3821	ORD01781	PROD0123	4	11097.43	44389.72
3822	ORD01782	PROD0202	1	12764.12	12764.12
3823	ORD01782	PROD0253	5	8743.34	43716.70
3824	ORD01783	PROD0212	2	8757.97	17515.94
3825	ORD01783	PROD0170	5	45302.42	226512.10
3826	ORD01783	PROD0195	2	24091.13	48182.26
3827	ORD01784	PROD0082	1	54346.36	54346.36
3828	ORD01784	PROD0270	1	907.09	907.09
3829	ORD01784	PROD0085	5	89243.32	446216.60
3830	ORD01784	PROD0275	2	10193.83	20387.66
3831	ORD01785	PROD0275	3	10193.83	30581.49
3832	ORD01786	PROD0010	3	270434.00	811302.00
3833	ORD01786	PROD0205	3	\N	\N
3834	ORD01787	PROD0076	2	27116.85	54233.70
3835	ORD01787	PROD0041	3	14461.31	43383.93
3836	ORD01788	PROD0169	5	41598.42	207992.10
3837	ORD01788	PROD0082	4	54346.36	217385.44
3838	ORD01788	PROD0258	3	4792.40	14377.20
3839	ORD01789	PROD0150	2	12003.33	24006.66
3840	ORD01789	PROD0270	4	907.09	3628.36
3841	ORD01789	PROD0198	4	57432.47	229729.88
3842	ORD01790	PROD0132	2	23990.67	47981.34
3843	ORD01790	PROD0172	3	95695.43	287086.29
3844	ORD01791	PROD0058	4	14691.81	58767.24
3845	ORD01791	PROD0207	5	11561.20	57806.00
3846	ORD01792	PROD0106	5	137481.28	687406.40
3847	ORD01792	PROD0180	2	60582.65	121165.30
3848	ORD01793	PROD0168	2	100026.32	200052.64
3849	ORD01793	PROD0244	3	1664.99	4994.97
3850	ORD01793	PROD0080	2	14845.55	29691.10
3851	ORD01794	PROD0086	4	49202.47	196809.88
3852	ORD01795	PROD0026	5	34248.48	171242.40
3853	ORD01795	PROD0043	1	16739.67	16739.67
3854	ORD01796	PROD0171	2	105588.96	211177.92
3855	ORD01797	PROD0178	3	87684.88	263054.64
3856	ORD01798	PROD0021	4	34405.68	137622.72
3857	ORD01798	PROD0224	2	607.93	1215.86
3858	ORD01798	PROD0249	4	774.24	3096.96
3859	ORD01798	PROD0137	2	2019.05	4038.10
3860	ORD01799	PROD0033	5	245627.48	1228137.40
3861	ORD01799	PROD0055	2	42567.03	85134.06
3862	ORD01800	PROD0079	2	13912.80	27825.60
3863	ORD01800	PROD0257	1	2248.73	2248.73
3864	ORD01800	PROD0187	3	28776.04	86328.12
3865	ORD01800	PROD0022	3	222156.94	666470.82
3866	ORD01801	PROD0233	3	10621.64	31864.92
3867	ORD01801	PROD0175	5	102750.60	513753.00
3868	ORD01802	PROD0190	3	22778.54	68335.62
3869	ORD01802	PROD0204	3	5933.15	17799.45
3870	ORD01802	PROD0245	4	\N	\N
3871	ORD01802	PROD0263	1	8199.23	8199.23
3872	ORD01803	PROD0052	5	23501.69	117508.45
3873	ORD01804	PROD0142	1	8820.60	8820.60
3874	ORD01804	PROD0154	3	19738.96	59216.88
3875	ORD01805	PROD0267	5	6230.11	31150.55
3876	ORD01805	PROD0126	3	13544.05	40632.15
3877	ORD01806	PROD0019	1	339524.65	339524.65
3878	ORD01806	PROD0247	3	5416.29	16248.87
3879	ORD01807	PROD0157	4	10758.03	43032.12
3880	ORD01807	PROD0114	5	7586.49	37932.45
3881	ORD01808	PROD0137	4	2019.05	8076.20
3882	ORD01808	PROD0028	2	316366.34	632732.68
3883	ORD01808	PROD0250	3	4620.81	13862.43
3884	ORD01809	PROD0027	1	26206.57	26206.57
3885	ORD01810	PROD0135	3	2595.60	7786.80
3886	ORD01810	PROD0124	5	17164.25	85821.25
3887	ORD01810	PROD0037	4	266180.98	1064723.92
3888	ORD01811	PROD0054	3	31709.48	95128.44
3889	ORD01811	PROD0115	3	2277.24	6831.72
3890	ORD01812	PROD0192	4	94625.99	378503.96
3891	ORD01813	PROD0191	3	44052.51	132157.53
3892	ORD01814	PROD0155	3	17522.15	52566.45
3893	ORD01814	PROD0250	5	4620.81	23104.05
3894	ORD01815	PROD0061	4	6821.26	27285.04
3895	ORD01815	PROD0100	2	110269.71	220539.42
3896	ORD01816	PROD0001	3	279610.57	838831.71
3897	ORD01817	PROD0050	4	26917.21	107668.84
3898	ORD01817	PROD0131	5	21092.44	105462.20
3899	ORD01818	PROD0179	3	21340.87	64022.61
3900	ORD01819	PROD0191	4	44052.51	176210.04
3901	ORD01819	PROD0207	1	11561.20	11561.20
3902	ORD01819	PROD0019	2	339524.65	679049.30
3903	ORD01819	PROD0063	5	35488.70	177443.50
3904	ORD01820	PROD0054	4	31709.48	126837.92
3905	ORD01820	PROD0225	4	9270.30	37081.20
3906	ORD01820	PROD0019	5	339524.65	1697623.25
3907	ORD01821	PROD0161	1	25829.99	25829.99
3908	ORD01821	PROD0051	3	33329.69	99989.07
3909	ORD01821	PROD0204	5	5933.15	29665.75
3910	ORD01821	PROD0080	2	14845.55	29691.10
3911	ORD01822	PROD0102	4	45021.16	180084.64
3912	ORD01823	PROD0251	4	5175.86	20703.44
3913	ORD01823	PROD0030	2	253935.11	507870.22
3914	ORD01824	PROD0177	1	102403.06	102403.06
3915	ORD01825	PROD0159	4	17483.90	69935.60
3916	ORD01825	PROD0085	3	89243.32	267729.96
3917	ORD01826	PROD0212	4	8757.97	35031.88
3918	ORD01827	PROD0006	2	308912.61	617825.22
3919	ORD01827	PROD0027	3	26206.57	78619.71
3920	ORD01827	PROD0234	4	6463.53	25854.12
3921	ORD01828	PROD0176	2	30789.84	61579.68
3922	ORD01829	PROD0136	5	8175.35	40876.75
3923	ORD01829	PROD0035	5	190414.55	952072.75
3924	ORD01829	PROD0073	4	6732.32	26929.28
3925	ORD01830	PROD0101	2	114695.41	229390.82
3926	ORD01831	PROD0076	5	27116.85	135584.25
3927	ORD01831	PROD0171	3	105588.96	316766.88
3928	ORD01832	PROD0194	2	24802.59	49605.18
3929	ORD01832	PROD0191	2	44052.51	88105.02
3930	ORD01833	PROD0273	1	1784.35	1784.35
3931	ORD01833	PROD0176	2	30789.84	61579.68
3932	ORD01834	PROD0030	2	253935.11	507870.22
3933	ORD01835	PROD0220	3	11275.57	33826.71
3934	ORD01835	PROD0263	1	8199.23	8199.23
3935	ORD01836	PROD0069	2	39168.98	78337.96
3936	ORD01837	PROD0227	2	9871.34	19742.68
3937	ORD01838	PROD0024	4	321716.92	1286867.68
3938	ORD01838	PROD0006	1	308912.61	308912.61
3939	ORD01838	PROD0216	5	3485.44	17427.20
3940	ORD01838	PROD0248	2	4809.30	9618.60
3941	ORD01839	PROD0034	2	272513.12	545026.24
3942	ORD01839	PROD0214	1	12483.89	12483.89
3943	ORD01840	PROD0257	4	2248.73	8994.92
3944	ORD01841	PROD0153	3	10840.50	32521.50
3945	ORD01842	PROD0206	3	5427.42	16282.26
3946	ORD01842	PROD0019	2	339524.65	679049.30
3947	ORD01843	PROD0250	1	4620.81	4620.81
3948	ORD01844	PROD0028	5	316366.34	1581831.70
3949	ORD01844	PROD0064	1	34644.88	34644.88
3950	ORD01845	PROD0201	4	10976.40	43905.60
3951	ORD01846	PROD0128	4	24463.34	97853.36
3952	ORD01847	PROD0072	4	43142.24	172568.96
3953	ORD01847	PROD0090	5	102715.97	513579.85
3954	ORD01847	PROD0058	1	14691.81	14691.81
3955	ORD01848	PROD0119	2	47472.78	94945.56
3956	ORD01849	PROD0043	1	16739.67	16739.67
3957	ORD01850	PROD0130	4	1182.88	4731.52
3958	ORD01851	PROD0156	2	21374.21	42748.42
3959	ORD01851	PROD0025	5	330590.39	1652951.95
3960	ORD01851	PROD0046	2	5762.47	11524.94
3961	ORD01852	PROD0247	2	5416.29	10832.58
3962	ORD01852	PROD0007	3	290642.30	871926.90
3963	ORD01853	PROD0014	4	289145.53	1156582.12
3964	ORD01853	PROD0099	5	130788.21	653941.05
3965	ORD01853	PROD0017	4	257730.40	1030921.60
3966	ORD01853	PROD0177	1	102403.06	102403.06
3967	ORD01854	PROD0048	4	10843.12	43372.48
3968	ORD01855	PROD0107	4	97418.23	389672.92
3969	ORD01855	PROD0123	4	11097.43	44389.72
3970	ORD01856	PROD0224	1	607.93	607.93
3971	ORD01856	PROD0032	4	246601.80	986407.20
3972	ORD01857	PROD0233	4	10621.64	42486.56
3973	ORD01857	PROD0120	2	35341.43	70682.86
3974	ORD01857	PROD0041	1	14461.31	14461.31
3975	ORD01858	PROD0256	3	1625.49	4876.47
3976	ORD01859	PROD0225	1	9270.30	9270.30
3977	ORD01859	PROD0112	5	35280.59	176402.95
3978	ORD01860	PROD0027	4	26206.57	104826.28
3979	ORD01861	PROD0154	1	19738.96	19738.96
3980	ORD01861	PROD0245	1	\N	\N
3981	ORD01861	PROD0212	1	8757.97	8757.97
3982	ORD01862	PROD0180	4	60582.65	242330.60
3983	ORD01863	PROD0108	3	121332.02	363996.06
3984	ORD01864	PROD0260	3	5050.94	15152.82
3985	ORD01865	PROD0094	2	117897.53	235795.06
3986	ORD01865	PROD0209	5	2728.52	13642.60
3987	ORD01865	PROD0035	2	190414.55	380829.10
3988	ORD01866	PROD0234	1	6463.53	6463.53
3989	ORD01866	PROD0225	2	9270.30	18540.60
3990	ORD01866	PROD0192	5	94625.99	473129.95
3991	ORD01866	PROD0240	5	10219.29	51096.45
3992	ORD01867	PROD0228	1	6170.81	6170.81
3993	ORD01868	PROD0215	2	3385.48	6770.96
3994	ORD01869	PROD0148	2	3628.18	7256.36
3995	ORD01869	PROD0104	2	\N	\N
3996	ORD01869	PROD0084	1	37258.14	37258.14
3997	ORD01869	PROD0119	2	47472.78	94945.56
3998	ORD01870	PROD0015	2	222324.51	444649.02
3999	ORD01870	PROD0194	1	24802.59	24802.59
4000	ORD01870	PROD0133	4	23616.92	94467.68
4001	ORD01871	PROD0072	5	43142.24	215711.20
4002	ORD01872	PROD0196	3	2511.26	7533.78
4003	ORD01873	PROD0267	1	6230.11	6230.11
4004	ORD01874	PROD0228	4	6170.81	24683.24
4005	ORD01875	PROD0218	4	5238.20	20952.80
4006	ORD01875	PROD0272	5	11096.23	55481.15
4007	ORD01876	PROD0128	1	24463.34	24463.34
4008	ORD01877	PROD0213	5	2985.64	14928.20
4009	ORD01877	PROD0107	5	97418.23	487091.15
4010	ORD01878	PROD0266	4	408.26	1633.04
4011	ORD01879	PROD0210	5	14712.50	73562.50
4012	ORD01879	PROD0089	1	45090.58	45090.58
4013	ORD01880	PROD0100	2	110269.71	220539.42
4014	ORD01881	PROD0092	3	140982.24	422946.72
4015	ORD01881	PROD0270	3	907.09	2721.27
4016	ORD01881	PROD0250	1	4620.81	4620.81
4017	ORD01882	PROD0043	3	16739.67	50219.01
4018	ORD01882	PROD0251	3	5175.86	15527.58
4019	ORD01882	PROD0185	3	112356.62	337069.86
4020	ORD01883	PROD0138	4	15463.10	61852.40
4021	ORD01884	PROD0183	5	26053.15	130265.75
4022	ORD01884	PROD0088	4	\N	\N
4023	ORD01884	PROD0208	3	9010.85	27032.55
4024	ORD01885	PROD0278	2	6353.37	12706.74
4025	ORD01886	PROD0204	1	5933.15	5933.15
4026	ORD01886	PROD0274	4	7846.95	31387.80
4027	ORD01887	PROD0206	4	5427.42	21709.68
4028	ORD01888	PROD0236	1	7038.57	7038.57
4029	ORD01888	PROD0004	3	39811.79	119435.37
4030	ORD01889	PROD0180	5	60582.65	302913.25
4031	ORD01889	PROD0038	2	88262.22	176524.44
4032	ORD01890	PROD0117	2	31515.40	63030.80
4033	ORD01891	PROD0102	5	45021.16	225105.80
4034	ORD01891	PROD0245	3	\N	\N
4035	ORD01892	PROD0064	5	34644.88	173224.40
4036	ORD01892	PROD0040	4	47715.49	190861.96
4037	ORD01892	PROD0220	1	11275.57	11275.57
4038	ORD01892	PROD0109	3	70228.44	210685.32
4039	ORD01893	PROD0057	2	24240.82	48481.64
4040	ORD01893	PROD0159	3	17483.90	52451.70
4041	ORD01894	PROD0178	5	87684.88	438424.40
4042	ORD01895	PROD0241	4	1174.07	4696.28
4043	ORD01896	PROD0133	2	23616.92	47233.84
4044	ORD01896	PROD0153	3	10840.50	32521.50
4045	ORD01897	PROD0085	3	89243.32	267729.96
4046	ORD01897	PROD0193	4	9954.82	39819.28
4047	ORD01898	PROD0081	2	110991.10	221982.20
4048	ORD01898	PROD0025	3	330590.39	991771.17
4049	ORD01899	PROD0026	5	34248.48	171242.40
4050	ORD01899	PROD0016	1	256280.50	256280.50
4051	ORD01899	PROD0147	4	5055.12	20220.48
4052	ORD01899	PROD0005	3	85978.02	257934.06
4053	ORD01900	PROD0071	2	9870.56	19741.12
4054	ORD01901	PROD0044	1	32574.27	32574.27
4055	ORD01901	PROD0138	1	15463.10	15463.10
4056	ORD01902	PROD0094	4	117897.53	471590.12
4057	ORD01903	PROD0007	1	290642.30	290642.30
4058	ORD01903	PROD0006	5	308912.61	1544563.05
4059	ORD01904	PROD0140	3	2847.84	8543.52
4060	ORD01904	PROD0230	2	6077.64	12155.28
4061	ORD01905	PROD0214	4	12483.89	49935.56
4062	ORD01905	PROD0213	1	2985.64	2985.64
4063	ORD01905	PROD0247	3	5416.29	16248.87
4064	ORD01906	PROD0121	3	17176.67	51530.01
4065	ORD01906	PROD0207	1	11561.20	11561.20
4066	ORD01907	PROD0154	4	19738.96	78955.84
4067	ORD01908	PROD0167	3	22365.17	67095.51
4068	ORD01908	PROD0163	1	18374.63	18374.63
4069	ORD01909	PROD0032	4	246601.80	986407.20
4070	ORD01910	PROD0157	5	10758.03	53790.15
4071	ORD01910	PROD0119	4	47472.78	189891.12
4072	ORD01911	PROD0094	2	117897.53	235795.06
4073	ORD01911	PROD0178	5	87684.88	438424.40
4074	ORD01912	PROD0114	2	7586.49	15172.98
4075	ORD01913	PROD0092	2	140982.24	281964.48
4076	ORD01914	PROD0235	2	1609.74	3219.48
4077	ORD01914	PROD0081	2	110991.10	221982.20
4078	ORD01914	PROD0029	3	149660.33	448980.99
4079	ORD01915	PROD0015	4	222324.51	889298.04
4080	ORD01916	PROD0137	1	2019.05	2019.05
4081	ORD01917	PROD0041	5	14461.31	72306.55
4082	ORD01918	PROD0265	3	11740.65	35221.95
4083	ORD01918	PROD0039	1	257535.23	257535.23
4084	ORD01918	PROD0047	3	5512.81	16538.43
4085	ORD01918	PROD0128	2	24463.34	48926.68
4086	ORD01919	PROD0255	3	7571.15	22713.45
4087	ORD01920	PROD0068	4	43176.46	172705.84
4088	ORD01920	PROD0143	1	13171.72	13171.72
4089	ORD01920	PROD0210	4	14712.50	58850.00
4090	ORD01920	PROD0126	2	13544.05	27088.10
4091	ORD01920	PROD0009	1	198883.60	198883.60
4092	ORD01921	PROD0068	1	43176.46	43176.46
4093	ORD01922	PROD0079	1	13912.80	13912.80
4094	ORD01923	PROD0216	4	3485.44	13941.76
4095	ORD01923	PROD0229	1	4112.45	4112.45
4096	ORD01924	PROD0020	1	293010.61	293010.61
4097	ORD01924	PROD0056	3	6299.62	18898.86
4098	ORD01924	PROD0023	4	276589.43	1106357.72
4099	ORD01925	PROD0269	5	2989.48	14947.40
4100	ORD01925	PROD0257	5	2248.73	11243.65
4101	ORD01925	PROD0051	2	33329.69	66659.38
4102	ORD01926	PROD0209	4	2728.52	10914.08
4103	ORD01926	PROD0261	5	8607.87	43039.35
4104	ORD01927	PROD0180	1	60582.65	60582.65
4105	ORD01928	PROD0195	5	24091.13	120455.65
4106	ORD01928	PROD0246	1	5399.76	5399.76
4107	ORD01928	PROD0091	1	141135.80	141135.80
4108	ORD01929	PROD0149	4	8124.11	32496.44
4109	ORD01930	PROD0115	5	2277.24	11386.20
4110	ORD01930	PROD0015	2	222324.51	444649.02
4111	ORD01931	PROD0105	4	162358.65	649434.60
4112	ORD01931	PROD0211	4	8250.11	33000.44
4113	ORD01931	PROD0237	3	7201.43	21604.29
4114	ORD01931	PROD0041	5	14461.31	72306.55
4115	ORD01931	PROD0134	1	19220.41	19220.41
4116	ORD01932	PROD0173	4	39177.27	156709.08
4117	ORD01933	PROD0188	2	51993.13	103986.26
4118	ORD01933	PROD0206	3	5427.42	16282.26
4119	ORD01934	PROD0076	1	27116.85	27116.85
4120	ORD01934	PROD0009	2	198883.60	397767.20
4121	ORD01935	PROD0241	4	1174.07	4696.28
4122	ORD01936	PROD0083	4	160848.97	643395.88
4123	ORD01937	PROD0074	3	13460.87	40382.61
4124	ORD01937	PROD0135	3	2595.60	7786.80
4125	ORD01937	PROD0030	3	253935.11	761805.33
4126	ORD01937	PROD0071	3	9870.56	29611.68
4127	ORD01938	PROD0019	2	339524.65	679049.30
4128	ORD01938	PROD0107	5	97418.23	487091.15
4129	ORD01938	PROD0254	5	9824.37	49121.85
4130	ORD01938	PROD0206	4	5427.42	21709.68
4131	ORD01938	PROD0235	2	1609.74	3219.48
4132	ORD01939	PROD0031	1	290316.23	290316.23
4133	ORD01939	PROD0015	5	222324.51	1111622.55
4134	ORD01940	PROD0212	3	8757.97	26273.91
4135	ORD01941	PROD0184	5	48414.15	242070.75
4136	ORD01941	PROD0052	5	23501.69	117508.45
4137	ORD01942	PROD0029	2	149660.33	299320.66
4138	ORD01942	PROD0003	2	49538.31	99076.62
4139	ORD01943	PROD0053	3	43609.38	130828.14
4140	ORD01943	PROD0095	1	49921.23	49921.23
4141	ORD01944	PROD0085	1	89243.32	89243.32
4142	ORD01944	PROD0260	4	5050.94	20203.76
4143	ORD01944	PROD0007	4	290642.30	1162569.20
4144	ORD01944	PROD0173	4	39177.27	156709.08
4145	ORD01945	PROD0250	5	4620.81	23104.05
4146	ORD01945	PROD0270	3	907.09	2721.27
4147	ORD01946	PROD0214	2	12483.89	24967.78
4148	ORD01946	PROD0043	4	16739.67	66958.68
4149	ORD01946	PROD0168	4	100026.32	400105.28
4150	ORD01947	PROD0133	5	23616.92	118084.60
4151	ORD01948	PROD0121	3	17176.67	51530.01
4152	ORD01948	PROD0237	1	7201.43	7201.43
4153	ORD01948	PROD0040	2	47715.49	95430.98
4154	ORD01948	PROD0154	1	19738.96	19738.96
4155	ORD01949	PROD0063	1	35488.70	35488.70
4156	ORD01949	PROD0135	5	2595.60	12978.00
4157	ORD01950	PROD0048	5	10843.12	54215.60
4158	ORD01951	PROD0162	4	2672.21	10688.84
4159	ORD01952	PROD0024	2	321716.92	643433.84
4160	ORD01953	PROD0054	3	31709.48	95128.44
4161	ORD01954	PROD0002	3	102447.74	307343.22
4162	ORD01954	PROD0159	4	17483.90	69935.60
4163	ORD01955	PROD0152	4	1904.28	7617.12
4164	ORD01955	PROD0258	5	4792.40	23962.00
4165	ORD01956	PROD0200	4	29196.20	116784.80
4166	ORD01956	PROD0140	2	2847.84	5695.68
4167	ORD01956	PROD0162	2	2672.21	5344.42
4168	ORD01957	PROD0138	2	15463.10	30926.20
4169	ORD01957	PROD0014	2	289145.53	578291.06
4170	ORD01958	PROD0118	5	12699.55	63497.75
4171	ORD01958	PROD0127	1	8700.29	8700.29
4172	ORD01959	PROD0154	1	19738.96	19738.96
4173	ORD01959	PROD0037	4	266180.98	1064723.92
4174	ORD01960	PROD0024	4	321716.92	1286867.68
4175	ORD01960	PROD0179	4	21340.87	85363.48
4176	ORD01961	PROD0049	3	27088.42	81265.26
4177	ORD01961	PROD0085	2	89243.32	178486.64
4178	ORD01962	PROD0267	4	6230.11	24920.44
4179	ORD01963	PROD0261	5	8607.87	43039.35
4180	ORD01963	PROD0130	1	1182.88	1182.88
4181	ORD01964	PROD0234	4	6463.53	25854.12
4182	ORD01964	PROD0240	2	10219.29	20438.58
4183	ORD01964	PROD0003	4	49538.31	198153.24
4184	ORD01964	PROD0037	3	266180.98	798542.94
4185	ORD01964	PROD0228	5	6170.81	30854.05
4186	ORD01965	PROD0053	1	43609.38	43609.38
4187	ORD01965	PROD0057	4	24240.82	96963.28
4188	ORD01966	PROD0013	2	337113.25	674226.50
4189	ORD01967	PROD0217	4	7092.62	28370.48
4190	ORD01968	PROD0176	4	30789.84	123159.36
4191	ORD01968	PROD0192	1	94625.99	94625.99
4192	ORD01968	PROD0083	2	160848.97	321697.94
4193	ORD01968	PROD0118	2	12699.55	25399.10
4194	ORD01968	PROD0056	3	6299.62	18898.86
4195	ORD01969	PROD0197	3	113579.08	340737.24
4196	ORD01969	PROD0207	2	11561.20	23122.40
4197	ORD01970	PROD0233	2	10621.64	21243.28
4198	ORD01971	PROD0254	2	9824.37	19648.74
4199	ORD01972	PROD0125	5	22153.16	110765.80
4200	ORD01972	PROD0079	4	13912.80	55651.20
4201	ORD01972	PROD0246	1	5399.76	5399.76
4202	ORD01972	PROD0199	3	28468.05	85404.15
4203	ORD01973	PROD0247	4	5416.29	21665.16
4204	ORD01973	PROD0200	1	29196.20	29196.20
4205	ORD01973	PROD0226	3	7172.97	21518.91
4206	ORD01973	PROD0018	3	120439.60	361318.80
4207	ORD01974	PROD0063	1	35488.70	35488.70
4208	ORD01974	PROD0199	4	28468.05	113872.20
4209	ORD01974	PROD0070	5	25905.43	129527.15
4210	ORD01974	PROD0174	5	110640.11	553200.55
4211	ORD01975	PROD0107	5	97418.23	487091.15
4212	ORD01976	PROD0168	5	100026.32	500131.60
4213	ORD01976	PROD0185	2	112356.62	224713.24
4214	ORD01976	PROD0249	3	774.24	2322.72
4215	ORD01976	PROD0003	2	49538.31	99076.62
4216	ORD01976	PROD0119	4	47472.78	189891.12
4217	ORD01977	PROD0078	3	18117.48	54352.44
4218	ORD01977	PROD0186	1	17418.14	17418.14
4219	ORD01977	PROD0165	5	22136.37	110681.85
4220	ORD01977	PROD0065	2	30524.10	61048.20
4221	ORD01977	PROD0029	4	149660.33	598641.32
4222	ORD01978	PROD0029	3	149660.33	448980.99
4223	ORD01978	PROD0043	4	16739.67	66958.68
4224	ORD01979	PROD0264	1	4118.15	4118.15
4225	ORD01979	PROD0042	2	44258.35	88516.70
4226	ORD01979	PROD0072	1	43142.24	43142.24
4227	ORD01980	PROD0156	5	21374.21	106871.05
4228	ORD01980	PROD0193	5	9954.82	49774.10
4229	ORD01981	PROD0112	1	35280.59	35280.59
4230	ORD01982	PROD0126	4	13544.05	54176.20
4231	ORD01982	PROD0212	1	8757.97	8757.97
4232	ORD01982	PROD0186	5	17418.14	87090.70
4233	ORD01982	PROD0163	2	18374.63	36749.26
4234	ORD01983	PROD0042	4	44258.35	177033.40
4235	ORD01983	PROD0270	3	907.09	2721.27
4236	ORD01984	PROD0080	3	14845.55	44536.65
4237	ORD01984	PROD0098	1	54814.26	54814.26
4238	ORD01984	PROD0212	4	8757.97	35031.88
4239	ORD01985	PROD0212	4	8757.97	35031.88
4240	ORD01985	PROD0237	3	7201.43	21604.29
4241	ORD01986	PROD0092	5	140982.24	704911.20
4242	ORD01986	PROD0176	2	30789.84	61579.68
4243	ORD01986	PROD0072	4	43142.24	172568.96
4244	ORD01987	PROD0134	2	19220.41	38440.82
4245	ORD01987	PROD0165	2	22136.37	44272.74
4246	ORD01988	PROD0267	3	6230.11	18690.33
4247	ORD01989	PROD0058	1	14691.81	14691.81
4248	ORD01989	PROD0060	3	10877.79	32633.37
4249	ORD01990	PROD0013	4	337113.25	1348453.00
4250	ORD01990	PROD0165	1	22136.37	22136.37
4251	ORD01990	PROD0256	3	1625.49	4876.47
4252	ORD01991	PROD0199	2	28468.05	56936.10
4253	ORD01992	PROD0078	1	18117.48	18117.48
4254	ORD01993	PROD0212	2	8757.97	17515.94
4255	ORD01994	PROD0166	5	101932.80	509664.00
4256	ORD01995	PROD0251	2	5175.86	10351.72
4257	ORD01995	PROD0240	4	10219.29	40877.16
4258	ORD01996	PROD0162	4	2672.21	10688.84
4259	ORD01996	PROD0178	3	87684.88	263054.64
4260	ORD01996	PROD0035	1	190414.55	190414.55
4261	ORD01996	PROD0075	1	5182.19	5182.19
4262	ORD01996	PROD0131	1	21092.44	21092.44
4263	ORD01997	PROD0182	4	33297.75	133191.00
4264	ORD01998	PROD0150	1	12003.33	12003.33
4265	ORD01998	PROD0083	1	160848.97	160848.97
4266	ORD01998	PROD0106	5	137481.28	687406.40
4267	ORD01998	PROD0107	1	97418.23	97418.23
4268	ORD01999	PROD0072	4	43142.24	172568.96
4269	ORD01999	PROD0262	2	3172.89	6345.78
4270	ORD02000	PROD0268	2	2944.75	5889.50
4271	ORD02000	PROD0269	4	2989.48	11957.92
4272	ORD02000	PROD0104	2	\N	\N
4273	ORD02000	PROD0043	4	16739.67	66958.68
4274	ORD02001	PROD0033	5	245627.48	1228137.40
4275	ORD02002	PROD0083	4	160848.97	643395.88
4276	ORD02003	PROD0168	1	100026.32	100026.32
4277	ORD02003	PROD0181	1	63768.87	63768.87
4278	ORD02003	PROD0170	1	45302.42	45302.42
4279	ORD02004	PROD0276	3	6563.88	19691.64
4280	ORD02005	PROD0006	4	308912.61	1235650.44
4281	ORD02006	PROD0098	3	54814.26	164442.78
4282	ORD02007	PROD0059	5	35594.97	177974.85
4283	ORD02007	PROD0223	1	7785.89	7785.89
4284	ORD02007	PROD0073	5	6732.32	33661.60
4285	ORD02008	PROD0242	1	5755.30	5755.30
4286	ORD02008	PROD0157	2	10758.03	21516.06
4287	ORD02009	PROD0200	3	29196.20	87588.60
4288	ORD02009	PROD0051	5	33329.69	166648.45
4289	ORD02009	PROD0224	4	607.93	2431.72
4290	ORD02009	PROD0201	1	10976.40	10976.40
4291	ORD02010	PROD0049	4	27088.42	108353.68
4292	ORD02011	PROD0050	1	26917.21	26917.21
4293	ORD02012	PROD0213	2	2985.64	5971.28
4294	ORD02012	PROD0051	1	33329.69	33329.69
4295	ORD02013	PROD0025	3	330590.39	991771.17
4296	ORD02014	PROD0180	3	60582.65	181747.95
4297	ORD02015	PROD0102	1	45021.16	45021.16
4298	ORD02015	PROD0187	1	28776.04	28776.04
4299	ORD02015	PROD0024	3	321716.92	965150.76
4300	ORD02015	PROD0055	2	42567.03	85134.06
4301	ORD02016	PROD0279	2	962.48	1924.96
4302	ORD02016	PROD0276	4	6563.88	26255.52
4303	ORD02017	PROD0184	5	48414.15	242070.75
4304	ORD02018	PROD0159	2	17483.90	34967.80
4305	ORD02019	PROD0187	3	28776.04	86328.12
4306	ORD02019	PROD0093	3	8480.78	25442.34
4307	ORD02019	PROD0024	5	321716.92	1608584.60
4308	ORD02020	PROD0097	4	9141.77	36567.08
4309	ORD02021	PROD0074	3	13460.87	40382.61
4310	ORD02021	PROD0227	3	9871.34	29614.02
4311	ORD02022	PROD0238	2	6026.76	12053.52
4312	ORD02022	PROD0020	1	293010.61	293010.61
4313	ORD02022	PROD0056	2	6299.62	12599.24
4314	ORD02022	PROD0179	2	21340.87	42681.74
4315	ORD02022	PROD0086	4	49202.47	196809.88
4316	ORD02023	PROD0222	1	2802.33	2802.33
4317	ORD02024	PROD0117	4	31515.40	126061.60
4318	ORD02024	PROD0004	3	39811.79	119435.37
4319	ORD02025	PROD0246	4	5399.76	21599.04
4320	ORD02025	PROD0065	1	30524.10	30524.10
4321	ORD02026	PROD0249	5	774.24	3871.20
4322	ORD02027	PROD0263	2	8199.23	16398.46
4323	ORD02027	PROD0204	5	5933.15	29665.75
4324	ORD02027	PROD0054	4	31709.48	126837.92
4325	ORD02027	PROD0280	4	7685.53	30742.12
4326	ORD02027	PROD0133	2	23616.92	47233.84
4327	ORD02028	PROD0146	5	9207.08	46035.40
4328	ORD02029	PROD0130	3	1182.88	3548.64
4329	ORD02030	PROD0176	3	30789.84	92369.52
4330	ORD02030	PROD0146	4	9207.08	36828.32
4331	ORD02030	PROD0119	3	47472.78	142418.34
4332	ORD02031	PROD0108	4	121332.02	485328.08
4333	ORD02031	PROD0265	5	11740.65	58703.25
4334	ORD02031	PROD0169	5	41598.42	207992.10
4335	ORD02031	PROD0028	4	316366.34	1265465.36
4336	ORD02032	PROD0255	4	7571.15	30284.60
4337	ORD02032	PROD0169	4	41598.42	166393.68
4338	ORD02032	PROD0214	5	12483.89	62419.45
4339	ORD02032	PROD0037	3	266180.98	798542.94
4340	ORD02033	PROD0108	1	121332.02	121332.02
4341	ORD02033	PROD0030	4	253935.11	1015740.44
4342	ORD02033	PROD0227	4	9871.34	39485.36
4343	ORD02034	PROD0252	5	8223.52	41117.60
4344	ORD02034	PROD0261	2	8607.87	17215.74
4345	ORD02035	PROD0175	5	102750.60	513753.00
4346	ORD02035	PROD0067	3	11627.77	34883.31
4347	ORD02036	PROD0170	1	45302.42	45302.42
4348	ORD02037	PROD0066	2	36291.81	72583.62
4349	ORD02038	PROD0125	3	22153.16	66459.48
4350	ORD02038	PROD0183	4	26053.15	104212.60
4351	ORD02038	PROD0161	1	25829.99	25829.99
4352	ORD02038	PROD0189	2	96833.78	193667.56
4353	ORD02039	PROD0185	1	112356.62	112356.62
4354	ORD02039	PROD0141	2	11608.58	23217.16
4355	ORD02039	PROD0241	1	1174.07	1174.07
4356	ORD02039	PROD0201	5	10976.40	54882.00
4357	ORD02040	PROD0008	3	121518.49	364555.47
4358	ORD02040	PROD0215	1	3385.48	3385.48
4359	ORD02041	PROD0014	3	289145.53	867436.59
4360	ORD02042	PROD0132	3	23990.67	71972.01
4361	ORD02042	PROD0190	3	22778.54	68335.62
4362	ORD02043	PROD0220	4	11275.57	45102.28
4363	ORD02043	PROD0004	4	39811.79	159247.16
4364	ORD02043	PROD0256	5	1625.49	8127.45
4365	ORD02044	PROD0250	2	4620.81	9241.62
4366	ORD02044	PROD0210	5	14712.50	73562.50
4367	ORD02045	PROD0092	2	140982.24	281964.48
4368	ORD02046	PROD0218	1	5238.20	5238.20
4369	ORD02046	PROD0009	5	198883.60	994418.00
4370	ORD02046	PROD0095	4	49921.23	199684.92
4371	ORD02046	PROD0077	3	20510.26	61530.78
4372	ORD02047	PROD0237	1	7201.43	7201.43
4373	ORD02047	PROD0013	3	337113.25	1011339.75
4374	ORD02048	PROD0244	1	1664.99	1664.99
4375	ORD02048	PROD0084	4	37258.14	149032.56
4376	ORD02049	PROD0038	5	88262.22	441311.10
4377	ORD02049	PROD0081	2	110991.10	221982.20
4378	ORD02049	PROD0194	1	24802.59	24802.59
4379	ORD02050	PROD0075	5	5182.19	25910.95
4380	ORD02051	PROD0166	4	101932.80	407731.20
4381	ORD02052	PROD0032	2	246601.80	493203.60
4382	ORD02052	PROD0205	5	\N	\N
4383	ORD02052	PROD0100	1	110269.71	110269.71
4384	ORD02052	PROD0078	1	18117.48	18117.48
4385	ORD02053	PROD0215	3	3385.48	10156.44
4386	ORD02054	PROD0010	3	270434.00	811302.00
4387	ORD02054	PROD0219	4	14849.13	59396.52
4388	ORD02055	PROD0239	4	1047.73	4190.92
4389	ORD02055	PROD0129	4	5323.48	21293.92
4390	ORD02056	PROD0240	4	10219.29	40877.16
4391	ORD02057	PROD0079	3	13912.80	41738.40
4392	ORD02057	PROD0280	2	7685.53	15371.06
4393	ORD02058	PROD0037	4	266180.98	1064723.92
4394	ORD02058	PROD0194	1	24802.59	24802.59
4395	ORD02058	PROD0132	1	23990.67	23990.67
4396	ORD02058	PROD0062	3	22431.17	67293.51
4397	ORD02059	PROD0204	5	5933.15	29665.75
4398	ORD02060	PROD0157	5	10758.03	53790.15
4399	ORD02060	PROD0242	3	5755.30	17265.90
4400	ORD02061	PROD0135	2	2595.60	5191.20
4401	ORD02061	PROD0069	3	39168.98	117506.94
4402	ORD02061	PROD0185	3	112356.62	337069.86
4403	ORD02062	PROD0134	5	19220.41	96102.05
4404	ORD02062	PROD0011	4	314229.61	1256918.44
4405	ORD02063	PROD0053	2	43609.38	87218.76
4406	ORD02063	PROD0188	1	51993.13	51993.13
4407	ORD02064	PROD0116	4	20859.43	83437.72
4408	ORD02065	PROD0151	1	24271.64	24271.64
4409	ORD02065	PROD0212	1	8757.97	8757.97
4410	ORD02066	PROD0027	5	26206.57	131032.85
4411	ORD02066	PROD0241	3	1174.07	3522.21
4412	ORD02066	PROD0055	1	42567.03	42567.03
4413	ORD02066	PROD0255	2	7571.15	15142.30
4414	ORD02067	PROD0118	1	12699.55	12699.55
4415	ORD02067	PROD0090	1	102715.97	102715.97
4416	ORD02068	PROD0171	5	105588.96	527944.80
4417	ORD02068	PROD0118	4	12699.55	50798.20
4418	ORD02069	PROD0133	2	23616.92	47233.84
4419	ORD02070	PROD0188	1	51993.13	51993.13
4420	ORD02071	PROD0203	5	3538.98	17694.90
4421	ORD02071	PROD0230	1	6077.64	6077.64
4422	ORD02071	PROD0195	4	24091.13	96364.52
4423	ORD02072	PROD0235	3	1609.74	4829.22
4424	ORD02072	PROD0155	5	17522.15	87610.75
4425	ORD02072	PROD0024	3	321716.92	965150.76
4426	ORD02073	PROD0264	2	4118.15	8236.30
4427	ORD02073	PROD0030	3	253935.11	761805.33
4428	ORD02074	PROD0170	1	45302.42	45302.42
4429	ORD02075	PROD0163	5	18374.63	91873.15
4430	ORD02075	PROD0075	1	5182.19	5182.19
4431	ORD02075	PROD0226	1	7172.97	7172.97
4432	ORD02076	PROD0037	5	266180.98	1330904.90
4433	ORD02077	PROD0165	3	22136.37	66409.11
4434	ORD02077	PROD0114	5	7586.49	37932.45
4435	ORD02077	PROD0085	4	89243.32	356973.28
4436	ORD02077	PROD0040	1	47715.49	47715.49
4437	ORD02077	PROD0125	5	22153.16	110765.80
4438	ORD02078	PROD0273	1	1784.35	1784.35
4439	ORD02078	PROD0005	2	85978.02	171956.04
4440	ORD02079	PROD0005	5	85978.02	429890.10
4441	ORD02079	PROD0172	2	95695.43	191390.86
4442	ORD02079	PROD0170	5	45302.42	226512.10
4443	ORD02079	PROD0152	5	1904.28	9521.40
4444	ORD02080	PROD0033	3	245627.48	736882.44
4445	ORD02081	PROD0234	4	6463.53	25854.12
4446	ORD02081	PROD0054	5	31709.48	158547.40
4447	ORD02082	PROD0173	5	39177.27	195886.35
4448	ORD02083	PROD0220	5	11275.57	56377.85
4449	ORD02083	PROD0258	5	4792.40	23962.00
4450	ORD02084	PROD0169	5	41598.42	207992.10
4451	ORD02085	PROD0060	5	10877.79	54388.95
4452	ORD02086	PROD0002	5	102447.74	512238.70
4453	ORD02086	PROD0169	4	41598.42	166393.68
4454	ORD02087	PROD0129	2	5323.48	10646.96
4455	ORD02087	PROD0193	5	9954.82	49774.10
4456	ORD02088	PROD0246	3	5399.76	16199.28
4457	ORD02088	PROD0125	4	22153.16	88612.64
4458	ORD02088	PROD0217	1	7092.62	7092.62
4459	ORD02089	PROD0068	2	43176.46	86352.92
4460	ORD02090	PROD0130	5	1182.88	5914.40
4461	ORD02091	PROD0154	2	19738.96	39477.92
4462	ORD02091	PROD0124	1	17164.25	17164.25
4463	ORD02092	PROD0212	2	8757.97	17515.94
4464	ORD02093	PROD0054	2	31709.48	63418.96
4465	ORD02093	PROD0067	5	11627.77	58138.85
4466	ORD02093	PROD0040	1	47715.49	47715.49
4467	ORD02094	PROD0214	3	12483.89	37451.67
4468	ORD02094	PROD0040	5	47715.49	238577.45
4469	ORD02094	PROD0164	5	6702.72	33513.60
4470	ORD02094	PROD0153	3	10840.50	32521.50
4471	ORD02095	PROD0015	2	222324.51	444649.02
4472	ORD02096	PROD0268	5	2944.75	14723.75
4473	ORD02096	PROD0277	1	9657.13	9657.13
4474	ORD02096	PROD0196	3	2511.26	7533.78
4475	ORD02096	PROD0222	5	2802.33	14011.65
4476	ORD02097	PROD0081	3	110991.10	332973.30
4477	ORD02097	PROD0273	4	1784.35	7137.40
4478	ORD02098	PROD0277	5	9657.13	48285.65
4479	ORD02099	PROD0222	4	2802.33	11209.32
4480	ORD02100	PROD0070	5	25905.43	129527.15
4481	ORD02100	PROD0219	3	14849.13	44547.39
4482	ORD02101	PROD0116	4	20859.43	83437.72
4483	ORD02101	PROD0138	1	15463.10	15463.10
4484	ORD02102	PROD0137	4	2019.05	8076.20
4485	ORD02102	PROD0178	2	87684.88	175369.76
4486	ORD02102	PROD0189	3	96833.78	290501.34
4487	ORD02103	PROD0019	3	339524.65	1018573.95
4488	ORD02103	PROD0029	3	149660.33	448980.99
4489	ORD02104	PROD0065	4	30524.10	122096.40
4490	ORD02105	PROD0230	2	6077.64	12155.28
4491	ORD02105	PROD0012	3	248709.70	746129.10
4492	ORD02105	PROD0160	1	12278.28	12278.28
4493	ORD02106	PROD0115	4	2277.24	9108.96
4494	ORD02106	PROD0231	1	6206.49	6206.49
4495	ORD02107	PROD0036	4	78738.41	314953.64
4496	ORD02107	PROD0185	4	112356.62	449426.48
4497	ORD02107	PROD0216	2	3485.44	6970.88
4498	ORD02107	PROD0147	5	5055.12	25275.60
4499	ORD02108	PROD0143	5	13171.72	65858.60
4500	ORD02109	PROD0107	5	97418.23	487091.15
4501	ORD02109	PROD0096	1	179864.29	179864.29
4502	ORD02109	PROD0092	2	140982.24	281964.48
4503	ORD02110	PROD0006	2	308912.61	617825.22
4504	ORD02110	PROD0217	2	7092.62	14185.24
4505	ORD02111	PROD0143	4	13171.72	52686.88
4506	ORD02111	PROD0082	3	54346.36	163039.08
4507	ORD02112	PROD0025	2	330590.39	661180.78
4508	ORD02113	PROD0259	4	7869.35	31477.40
4509	ORD02113	PROD0256	2	1625.49	3250.98
4510	ORD02113	PROD0047	5	5512.81	27564.05
4511	ORD02114	PROD0039	1	257535.23	257535.23
4512	ORD02114	PROD0020	3	293010.61	879031.83
4513	ORD02114	PROD0277	2	9657.13	19314.26
4514	ORD02114	PROD0009	2	198883.60	397767.20
4515	ORD02115	PROD0262	1	3172.89	3172.89
4516	ORD02115	PROD0236	3	7038.57	21115.71
4517	ORD02116	PROD0152	4	1904.28	7617.12
4518	ORD02116	PROD0181	3	63768.87	191306.61
4519	ORD02117	PROD0123	4	11097.43	44389.72
4520	ORD02117	PROD0199	1	28468.05	28468.05
4521	ORD02117	PROD0069	3	39168.98	117506.94
4522	ORD02117	PROD0043	5	16739.67	83698.35
4523	ORD02118	PROD0177	2	102403.06	204806.12
4524	ORD02119	PROD0272	4	11096.23	44384.92
4525	ORD02119	PROD0257	3	2248.73	6746.19
4526	ORD02119	PROD0084	1	37258.14	37258.14
4527	ORD02119	PROD0039	1	257535.23	257535.23
4528	ORD02120	PROD0031	2	290316.23	580632.46
4529	ORD02121	PROD0238	5	6026.76	30133.80
4530	ORD02121	PROD0104	2	\N	\N
4531	ORD02121	PROD0014	3	289145.53	867436.59
4532	ORD02121	PROD0263	1	8199.23	8199.23
4533	ORD02122	PROD0047	3	5512.81	16538.43
4534	ORD02122	PROD0087	1	12717.02	12717.02
4535	ORD02122	PROD0146	2	9207.08	18414.16
4536	ORD02123	PROD0047	1	5512.81	5512.81
4537	ORD02123	PROD0091	5	141135.80	705679.00
4538	ORD02124	PROD0032	1	246601.80	246601.80
4539	ORD02125	PROD0122	2	16203.67	32407.34
4540	ORD02126	PROD0155	2	17522.15	35044.30
4541	ORD02127	PROD0222	4	2802.33	11209.32
4542	ORD02127	PROD0091	4	141135.80	564543.20
4543	ORD02128	PROD0085	5	89243.32	446216.60
4544	ORD02129	PROD0149	5	8124.11	40620.55
4545	ORD02130	PROD0280	5	7685.53	38427.65
4546	ORD02131	PROD0056	5	6299.62	31498.10
4547	ORD02132	PROD0106	1	137481.28	137481.28
4548	ORD02133	PROD0154	1	19738.96	19738.96
4549	ORD02134	PROD0048	5	10843.12	54215.60
4550	ORD02134	PROD0059	4	35594.97	142379.88
4551	ORD02135	PROD0128	3	24463.34	73390.02
4552	ORD02136	PROD0266	4	408.26	1633.04
4553	ORD02137	PROD0236	2	7038.57	14077.14
4554	ORD02138	PROD0258	1	4792.40	4792.40
4555	ORD02138	PROD0040	1	47715.49	47715.49
4556	ORD02139	PROD0195	4	24091.13	96364.52
4557	ORD02139	PROD0106	1	137481.28	137481.28
4558	ORD02139	PROD0031	1	290316.23	290316.23
4559	ORD02139	PROD0218	3	5238.20	15714.60
4560	ORD02139	PROD0205	5	\N	\N
4561	ORD02140	PROD0126	2	13544.05	27088.10
4562	ORD02141	PROD0005	1	85978.02	85978.02
4563	ORD02142	PROD0128	2	24463.34	48926.68
4564	ORD02142	PROD0094	3	117897.53	353692.59
4565	ORD02143	PROD0278	5	6353.37	31766.85
4566	ORD02144	PROD0253	5	8743.34	43716.70
4567	ORD02144	PROD0096	3	179864.29	539592.87
4568	ORD02144	PROD0073	5	6732.32	33661.60
4569	ORD02145	PROD0059	5	35594.97	177974.85
4570	ORD02146	PROD0121	5	17176.67	85883.35
4571	ORD02146	PROD0220	2	11275.57	22551.14
4572	ORD02146	PROD0254	5	9824.37	49121.85
4573	ORD02146	PROD0278	4	6353.37	25413.48
4574	ORD02147	PROD0133	2	23616.92	47233.84
4575	ORD02148	PROD0246	1	5399.76	5399.76
4576	ORD02148	PROD0137	4	2019.05	8076.20
4577	ORD02149	PROD0177	5	102403.06	512015.30
4578	ORD02149	PROD0087	4	12717.02	50868.08
4579	ORD02150	PROD0057	3	24240.82	72722.46
4580	ORD02150	PROD0138	1	15463.10	15463.10
4581	ORD02151	PROD0036	5	78738.41	393692.05
4582	ORD02151	PROD0038	4	88262.22	353048.88
4583	ORD02151	PROD0213	1	2985.64	2985.64
4584	ORD02152	PROD0012	3	248709.70	746129.10
4585	ORD02153	PROD0204	5	5933.15	29665.75
4586	ORD02154	PROD0046	1	5762.47	5762.47
4587	ORD02154	PROD0137	2	2019.05	4038.10
4588	ORD02155	PROD0174	5	110640.11	553200.55
4589	ORD02156	PROD0048	4	10843.12	43372.48
4590	ORD02156	PROD0212	2	8757.97	17515.94
4591	ORD02156	PROD0071	2	9870.56	19741.12
4592	ORD02156	PROD0078	5	18117.48	90587.40
4593	ORD02157	PROD0228	2	6170.81	12341.62
4594	ORD02158	PROD0167	3	22365.17	67095.51
4595	ORD02158	PROD0231	1	6206.49	6206.49
4596	ORD02158	PROD0011	5	314229.61	1571148.05
4597	ORD02158	PROD0100	5	110269.71	551348.55
4598	ORD02159	PROD0133	1	23616.92	23616.92
4599	ORD02160	PROD0216	2	3485.44	6970.88
4600	ORD02161	PROD0064	3	34644.88	103934.64
4601	ORD02162	PROD0151	1	24271.64	24271.64
4602	ORD02162	PROD0071	4	9870.56	39482.24
4603	ORD02163	PROD0087	1	12717.02	12717.02
4604	ORD02163	PROD0257	1	2248.73	2248.73
4605	ORD02164	PROD0157	4	10758.03	43032.12
4606	ORD02165	PROD0061	4	6821.26	27285.04
4607	ORD02166	PROD0047	1	5512.81	5512.81
4608	ORD02166	PROD0024	1	321716.92	321716.92
4609	ORD02167	PROD0173	4	39177.27	156709.08
4610	ORD02168	PROD0145	1	22657.06	22657.06
4611	ORD02169	PROD0126	2	13544.05	27088.10
4612	ORD02169	PROD0161	5	25829.99	129149.95
4613	ORD02169	PROD0180	2	60582.65	121165.30
4614	ORD02170	PROD0252	2	8223.52	16447.04
4615	ORD02170	PROD0064	4	34644.88	138579.52
4616	ORD02170	PROD0107	3	97418.23	292254.69
4617	ORD02170	PROD0025	4	330590.39	1322361.56
4618	ORD02171	PROD0067	5	11627.77	58138.85
4619	ORD02171	PROD0034	4	272513.12	1090052.48
4620	ORD02172	PROD0002	4	102447.74	409790.96
4621	ORD02173	PROD0196	1	2511.26	2511.26
4622	ORD02174	PROD0235	2	1609.74	3219.48
4623	ORD02174	PROD0186	3	17418.14	52254.42
4624	ORD02174	PROD0156	4	21374.21	85496.84
4625	ORD02175	PROD0095	4	49921.23	199684.92
4626	ORD02175	PROD0124	3	17164.25	51492.75
4627	ORD02175	PROD0255	5	7571.15	37855.75
4628	ORD02176	PROD0062	3	22431.17	67293.51
4629	ORD02176	PROD0076	2	27116.85	54233.70
4630	ORD02177	PROD0084	4	37258.14	149032.56
4631	ORD02177	PROD0085	4	89243.32	356973.28
4632	ORD02178	PROD0076	3	27116.85	81350.55
4633	ORD02178	PROD0278	2	6353.37	12706.74
4634	ORD02178	PROD0221	5	13121.51	65607.55
4635	ORD02179	PROD0272	1	11096.23	11096.23
4636	ORD02179	PROD0069	1	39168.98	39168.98
4637	ORD02180	PROD0011	2	314229.61	628459.22
4638	ORD02180	PROD0229	4	4112.45	16449.80
4639	ORD02180	PROD0024	5	321716.92	1608584.60
4640	ORD02181	PROD0223	4	7785.89	31143.56
4641	ORD02181	PROD0116	1	20859.43	20859.43
4642	ORD02181	PROD0085	5	89243.32	446216.60
4643	ORD02181	PROD0019	5	339524.65	1697623.25
4644	ORD02182	PROD0156	4	21374.21	85496.84
4645	ORD02182	PROD0277	4	9657.13	38628.52
4646	ORD02183	PROD0138	4	15463.10	61852.40
4647	ORD02183	PROD0175	3	102750.60	308251.80
4648	ORD02184	PROD0262	1	3172.89	3172.89
4649	ORD02184	PROD0083	4	160848.97	643395.88
4650	ORD02184	PROD0258	5	4792.40	23962.00
4651	ORD02185	PROD0068	2	43176.46	86352.92
4652	ORD02186	PROD0200	3	29196.20	87588.60
4653	ORD02187	PROD0017	4	257730.40	1030921.60
4654	ORD02188	PROD0222	5	2802.33	14011.65
4655	ORD02189	PROD0065	3	30524.10	91572.30
4656	ORD02190	PROD0108	5	121332.02	606660.10
4657	ORD02190	PROD0205	2	\N	\N
4658	ORD02190	PROD0209	2	2728.52	5457.04
4659	ORD02191	PROD0182	4	33297.75	133191.00
4660	ORD02192	PROD0091	3	141135.80	423407.40
4661	ORD02192	PROD0096	5	179864.29	899321.45
4662	ORD02193	PROD0028	5	316366.34	1581831.70
4663	ORD02193	PROD0004	3	39811.79	119435.37
4664	ORD02193	PROD0279	2	962.48	1924.96
4665	ORD02194	PROD0098	2	54814.26	109628.52
4666	ORD02195	PROD0264	3	4118.15	12354.45
4667	ORD02195	PROD0108	4	121332.02	485328.08
4668	ORD02195	PROD0274	1	7846.95	7846.95
4669	ORD02195	PROD0144	2	801.07	1602.14
4670	ORD02196	PROD0269	3	2989.48	8968.44
4671	ORD02197	PROD0152	3	1904.28	5712.84
4672	ORD02197	PROD0190	3	22778.54	68335.62
4673	ORD02198	PROD0114	5	7586.49	37932.45
4674	ORD02198	PROD0238	2	6026.76	12053.52
4675	ORD02199	PROD0102	5	45021.16	225105.80
4676	ORD02199	PROD0220	3	11275.57	33826.71
4677	ORD02199	PROD0268	5	2944.75	14723.75
4678	ORD02200	PROD0234	5	6463.53	32317.65
4679	ORD02201	PROD0191	1	44052.51	44052.51
4680	ORD02202	PROD0016	1	256280.50	256280.50
4681	ORD02202	PROD0066	4	36291.81	145167.24
4682	ORD02202	PROD0170	4	45302.42	181209.68
4683	ORD02203	PROD0235	3	1609.74	4829.22
4684	ORD02203	PROD0115	4	2277.24	9108.96
4685	ORD02204	PROD0220	2	11275.57	22551.14
4686	ORD02204	PROD0127	5	8700.29	43501.45
4687	ORD02205	PROD0079	1	13912.80	13912.80
4688	ORD02206	PROD0213	2	2985.64	5971.28
4689	ORD02207	PROD0147	4	5055.12	20220.48
4690	ORD02208	PROD0252	2	8223.52	16447.04
4691	ORD02209	PROD0195	3	24091.13	72273.39
4692	ORD02209	PROD0193	4	9954.82	39819.28
4693	ORD02209	PROD0114	4	7586.49	30345.96
4694	ORD02209	PROD0086	2	49202.47	98404.94
4695	ORD02210	PROD0110	5	23332.73	116663.65
4696	ORD02211	PROD0006	3	308912.61	926737.83
4697	ORD02212	PROD0079	5	13912.80	69564.00
4698	ORD02212	PROD0212	5	8757.97	43789.85
4699	ORD02212	PROD0159	2	17483.90	34967.80
4700	ORD02212	PROD0156	4	21374.21	85496.84
4701	ORD02212	PROD0230	5	6077.64	30388.20
4702	ORD02213	PROD0012	1	248709.70	248709.70
4703	ORD02213	PROD0102	4	45021.16	180084.64
4704	ORD02213	PROD0254	3	9824.37	29473.11
4705	ORD02214	PROD0056	4	6299.62	25198.48
4706	ORD02214	PROD0008	2	121518.49	243036.98
4707	ORD02214	PROD0147	3	5055.12	15165.36
4708	ORD02214	PROD0180	4	60582.65	242330.60
4709	ORD02215	PROD0120	4	35341.43	141365.72
4710	ORD02215	PROD0277	5	9657.13	48285.65
4711	ORD02216	PROD0170	4	45302.42	181209.68
4712	ORD02217	PROD0156	4	21374.21	85496.84
4713	ORD02217	PROD0231	1	6206.49	6206.49
4714	ORD02218	PROD0136	3	8175.35	24526.05
4715	ORD02219	PROD0081	3	110991.10	332973.30
4716	ORD02220	PROD0200	4	29196.20	116784.80
4717	ORD02220	PROD0144	5	801.07	4005.35
4718	ORD02221	PROD0208	5	9010.85	45054.25
4719	ORD02222	PROD0017	2	257730.40	515460.80
4720	ORD02223	PROD0149	4	8124.11	32496.44
4721	ORD02223	PROD0196	1	2511.26	2511.26
4722	ORD02224	PROD0236	5	7038.57	35192.85
4723	ORD02224	PROD0221	1	13121.51	13121.51
4724	ORD02225	PROD0023	3	276589.43	829768.29
4725	ORD02225	PROD0122	3	16203.67	48611.01
4726	ORD02225	PROD0208	5	9010.85	45054.25
4727	ORD02226	PROD0155	1	17522.15	17522.15
4728	ORD02227	PROD0206	1	5427.42	5427.42
4729	ORD02227	PROD0001	2	279610.57	559221.14
4730	ORD02228	PROD0174	4	110640.11	442560.44
4731	ORD02229	PROD0151	3	24271.64	72814.92
4732	ORD02230	PROD0047	2	5512.81	11025.62
4733	ORD02230	PROD0152	4	1904.28	7617.12
4734	ORD02230	PROD0060	3	10877.79	32633.37
4735	ORD02231	PROD0211	5	8250.11	41250.55
4736	ORD02232	PROD0160	5	12278.28	61391.40
4737	ORD02233	PROD0188	5	51993.13	259965.65
4738	ORD02233	PROD0009	4	198883.60	795534.40
4739	ORD02233	PROD0252	1	8223.52	8223.52
4740	ORD02233	PROD0052	2	23501.69	47003.38
4741	ORD02234	PROD0084	1	37258.14	37258.14
4742	ORD02234	PROD0070	5	25905.43	129527.15
4743	ORD02235	PROD0038	4	88262.22	353048.88
4744	ORD02235	PROD0242	3	5755.30	17265.90
4745	ORD02236	PROD0199	1	28468.05	28468.05
4746	ORD02236	PROD0205	1	\N	\N
4747	ORD02237	PROD0118	5	12699.55	63497.75
4748	ORD02237	PROD0031	3	290316.23	870948.69
4749	ORD02237	PROD0199	1	28468.05	28468.05
4750	ORD02238	PROD0033	1	245627.48	245627.48
4751	ORD02238	PROD0278	1	6353.37	6353.37
4752	ORD02239	PROD0114	2	7586.49	15172.98
4753	ORD02239	PROD0101	3	114695.41	344086.23
4754	ORD02239	PROD0031	3	290316.23	870948.69
4755	ORD02240	PROD0146	3	9207.08	27621.24
4756	ORD02241	PROD0199	5	28468.05	142340.25
4757	ORD02241	PROD0056	1	6299.62	6299.62
4758	ORD02241	PROD0208	3	9010.85	27032.55
4759	ORD02242	PROD0217	1	7092.62	7092.62
4760	ORD02242	PROD0004	4	39811.79	159247.16
4761	ORD02242	PROD0266	3	408.26	1224.78
4762	ORD02243	PROD0278	1	6353.37	6353.37
4763	ORD02243	PROD0039	3	257535.23	772605.69
4764	ORD02243	PROD0256	1	1625.49	1625.49
4765	ORD02244	PROD0181	1	63768.87	63768.87
4766	ORD02245	PROD0068	4	43176.46	172705.84
4767	ORD02246	PROD0179	4	21340.87	85363.48
4768	ORD02246	PROD0021	3	34405.68	103217.04
4769	ORD02247	PROD0227	2	9871.34	19742.68
4770	ORD02247	PROD0221	5	13121.51	65607.55
4771	ORD02247	PROD0092	3	140982.24	422946.72
4772	ORD02247	PROD0162	4	2672.21	10688.84
4773	ORD02248	PROD0050	4	26917.21	107668.84
4774	ORD02249	PROD0151	5	24271.64	121358.20
4775	ORD02249	PROD0193	3	9954.82	29864.46
4776	ORD02250	PROD0044	5	32574.27	162871.35
4777	ORD02250	PROD0062	4	22431.17	89724.68
4778	ORD02250	PROD0200	4	29196.20	116784.80
4779	ORD02250	PROD0199	1	28468.05	28468.05
4780	ORD02250	PROD0071	2	9870.56	19741.12
4781	ORD02251	PROD0212	4	8757.97	35031.88
4782	ORD02251	PROD0248	3	4809.30	14427.90
4783	ORD02251	PROD0024	4	321716.92	1286867.68
4784	ORD02251	PROD0064	2	34644.88	69289.76
4785	ORD02252	PROD0187	4	28776.04	115104.16
4786	ORD02253	PROD0092	2	140982.24	281964.48
4787	ORD02254	PROD0268	5	2944.75	14723.75
4788	ORD02254	PROD0159	4	17483.90	69935.60
4789	ORD02255	PROD0077	1	20510.26	20510.26
4790	ORD02256	PROD0061	5	6821.26	34106.30
4791	ORD02257	PROD0077	2	20510.26	41020.52
4792	ORD02258	PROD0139	3	14201.82	42605.46
4793	ORD02258	PROD0133	1	23616.92	23616.92
4794	ORD02258	PROD0116	3	20859.43	62578.29
4795	ORD02258	PROD0056	1	6299.62	6299.62
4796	ORD02259	PROD0101	4	114695.41	458781.64
4797	ORD02259	PROD0239	5	1047.73	5238.65
4798	ORD02260	PROD0059	4	35594.97	142379.88
4799	ORD02261	PROD0265	1	11740.65	11740.65
4800	ORD02261	PROD0042	1	44258.35	44258.35
4801	ORD02261	PROD0258	5	4792.40	23962.00
4802	ORD02261	PROD0056	4	6299.62	25198.48
4803	ORD02262	PROD0223	3	7785.89	23357.67
4804	ORD02262	PROD0112	5	35280.59	176402.95
4805	ORD02262	PROD0171	4	105588.96	422355.84
4806	ORD02263	PROD0154	5	19738.96	98694.80
4807	ORD02264	PROD0077	3	20510.26	61530.78
4808	ORD02264	PROD0162	2	2672.21	5344.42
4809	ORD02264	PROD0160	2	12278.28	24556.56
4810	ORD02265	PROD0096	3	179864.29	539592.87
4811	ORD02265	PROD0013	1	337113.25	337113.25
4812	ORD02266	PROD0242	2	5755.30	11510.60
4813	ORD02267	PROD0277	4	9657.13	38628.52
4814	ORD02267	PROD0280	3	7685.53	23056.59
4815	ORD02268	PROD0242	3	5755.30	17265.90
4816	ORD02269	PROD0098	1	54814.26	54814.26
4817	ORD02270	PROD0247	1	5416.29	5416.29
4818	ORD02270	PROD0152	3	1904.28	5712.84
4819	ORD02271	PROD0199	1	28468.05	28468.05
4820	ORD02272	PROD0246	1	5399.76	5399.76
4821	ORD02273	PROD0231	1	6206.49	6206.49
4822	ORD02273	PROD0085	1	89243.32	89243.32
4823	ORD02273	PROD0222	1	2802.33	2802.33
4824	ORD02273	PROD0240	1	10219.29	10219.29
4825	ORD02274	PROD0187	3	28776.04	86328.12
4826	ORD02274	PROD0278	5	6353.37	31766.85
4827	ORD02275	PROD0067	3	11627.77	34883.31
4828	ORD02275	PROD0060	5	10877.79	54388.95
4829	ORD02276	PROD0252	5	8223.52	41117.60
4830	ORD02276	PROD0148	1	3628.18	3628.18
4831	ORD02277	PROD0165	1	22136.37	22136.37
4832	ORD02277	PROD0136	3	8175.35	24526.05
4833	ORD02277	PROD0021	4	34405.68	137622.72
4834	ORD02277	PROD0225	2	9270.30	18540.60
4835	ORD02278	PROD0236	4	7038.57	28154.28
4836	ORD02278	PROD0242	3	5755.30	17265.90
4837	ORD02279	PROD0002	4	102447.74	409790.96
4838	ORD02279	PROD0231	2	6206.49	12412.98
4839	ORD02280	PROD0066	5	36291.81	181459.05
4840	ORD02280	PROD0062	2	22431.17	44862.34
4841	ORD02281	PROD0069	2	39168.98	78337.96
4842	ORD02281	PROD0219	5	14849.13	74245.65
4843	ORD02281	PROD0134	2	19220.41	38440.82
4844	ORD02282	PROD0019	4	339524.65	1358098.60
4845	ORD02282	PROD0206	4	5427.42	21709.68
4846	ORD02283	PROD0136	3	8175.35	24526.05
4847	ORD02283	PROD0106	5	137481.28	687406.40
4848	ORD02284	PROD0222	3	2802.33	8406.99
4849	ORD02285	PROD0240	1	10219.29	10219.29
4850	ORD02285	PROD0046	3	5762.47	17287.41
4851	ORD02285	PROD0243	5	10094.25	50471.25
4852	ORD02286	PROD0211	3	8250.11	24750.33
4853	ORD02287	PROD0133	1	23616.92	23616.92
4854	ORD02287	PROD0086	5	49202.47	246012.35
4855	ORD02288	PROD0210	3	14712.50	44137.50
4856	ORD02288	PROD0100	5	110269.71	551348.55
4857	ORD02288	PROD0202	4	12764.12	51056.48
4858	ORD02289	PROD0108	5	121332.02	606660.10
4859	ORD02289	PROD0185	4	112356.62	449426.48
4860	ORD02290	PROD0178	2	87684.88	175369.76
4861	ORD02291	PROD0153	4	10840.50	43362.00
4862	ORD02291	PROD0092	4	140982.24	563928.96
4863	ORD02292	PROD0059	1	35594.97	35594.97
4864	ORD02292	PROD0187	1	28776.04	28776.04
4865	ORD02292	PROD0015	1	222324.51	222324.51
4866	ORD02293	PROD0102	4	45021.16	180084.64
4867	ORD02294	PROD0007	1	290642.30	290642.30
4868	ORD02294	PROD0045	4	15761.34	63045.36
4869	ORD02294	PROD0002	3	102447.74	307343.22
4870	ORD02294	PROD0269	4	2989.48	11957.92
4871	ORD02294	PROD0202	5	12764.12	63820.60
4872	ORD02295	PROD0014	4	289145.53	1156582.12
4873	ORD02295	PROD0196	5	2511.26	12556.30
4874	ORD02296	PROD0202	4	12764.12	51056.48
4875	ORD02296	PROD0061	2	6821.26	13642.52
4876	ORD02296	PROD0024	4	321716.92	1286867.68
4877	ORD02296	PROD0093	3	8480.78	25442.34
4878	ORD02296	PROD0100	2	110269.71	220539.42
4879	ORD02297	PROD0082	3	54346.36	163039.08
4880	ORD02297	PROD0137	5	2019.05	10095.25
4881	ORD02298	PROD0228	5	6170.81	30854.05
4882	ORD02299	PROD0158	4	12650.30	50601.20
4883	ORD02299	PROD0050	4	26917.21	107668.84
4884	ORD02300	PROD0218	5	5238.20	26191.00
4885	ORD02301	PROD0269	3	2989.48	8968.44
4886	ORD02301	PROD0176	5	30789.84	153949.20
4887	ORD02301	PROD0243	4	10094.25	40377.00
4888	ORD02301	PROD0103	4	83304.08	333216.32
4889	ORD02302	PROD0211	1	8250.11	8250.11
4890	ORD02302	PROD0141	2	11608.58	23217.16
4891	ORD02302	PROD0140	4	2847.84	11391.36
4892	ORD02302	PROD0255	2	7571.15	15142.30
4893	ORD02303	PROD0136	5	8175.35	40876.75
4894	ORD02303	PROD0172	4	95695.43	382781.72
4895	ORD02304	PROD0227	1	9871.34	9871.34
4896	ORD02305	PROD0019	3	339524.65	1018573.95
4897	ORD02305	PROD0067	2	11627.77	23255.54
4898	ORD02305	PROD0130	4	1182.88	4731.52
4899	ORD02305	PROD0013	4	337113.25	1348453.00
4900	ORD02306	PROD0269	2	2989.48	5978.96
4901	ORD02306	PROD0204	5	5933.15	29665.75
4902	ORD02306	PROD0162	3	2672.21	8016.63
4903	ORD02307	PROD0017	4	257730.40	1030921.60
4904	ORD02308	PROD0207	5	11561.20	57806.00
4905	ORD02309	PROD0269	1	2989.48	2989.48
4906	ORD02310	PROD0141	1	11608.58	11608.58
4907	ORD02311	PROD0161	2	25829.99	51659.98
4908	ORD02311	PROD0053	4	43609.38	174437.52
4909	ORD02311	PROD0024	3	321716.92	965150.76
4910	ORD02312	PROD0150	4	12003.33	48013.32
4911	ORD02313	PROD0070	4	25905.43	103621.72
4912	ORD02314	PROD0028	1	316366.34	316366.34
4913	ORD02314	PROD0146	1	9207.08	9207.08
4914	ORD02315	PROD0168	4	100026.32	400105.28
4915	ORD02315	PROD0059	3	35594.97	106784.91
4916	ORD02316	PROD0101	2	114695.41	229390.82
4917	ORD02317	PROD0191	5	44052.51	220262.55
4918	ORD02317	PROD0139	2	14201.82	28403.64
4919	ORD02317	PROD0243	3	10094.25	30282.75
4920	ORD02317	PROD0271	1	1989.71	1989.71
4921	ORD02318	PROD0207	5	11561.20	57806.00
4922	ORD02319	PROD0278	5	6353.37	31766.85
4923	ORD02319	PROD0062	2	22431.17	44862.34
4924	ORD02319	PROD0082	2	54346.36	108692.72
4925	ORD02320	PROD0097	4	9141.77	36567.08
4926	ORD02321	PROD0107	2	97418.23	194836.46
4927	ORD02322	PROD0006	1	308912.61	308912.61
4928	ORD02322	PROD0251	4	5175.86	20703.44
4929	ORD02322	PROD0034	3	272513.12	817539.36
4930	ORD02323	PROD0271	5	1989.71	9948.55
4931	ORD02323	PROD0105	3	162358.65	487075.95
4932	ORD02323	PROD0276	5	6563.88	32819.40
4933	ORD02323	PROD0155	2	17522.15	35044.30
4934	ORD02323	PROD0226	1	7172.97	7172.97
4935	ORD02324	PROD0004	3	39811.79	119435.37
4936	ORD02324	PROD0150	5	12003.33	60016.65
4937	ORD02325	PROD0232	5	4469.76	22348.80
4938	ORD02326	PROD0043	4	16739.67	66958.68
4939	ORD02327	PROD0137	1	2019.05	2019.05
4940	ORD02327	PROD0022	2	222156.94	444313.88
4941	ORD02327	PROD0162	2	2672.21	5344.42
4942	ORD02327	PROD0111	1	2676.03	2676.03
4943	ORD02328	PROD0028	1	316366.34	316366.34
4944	ORD02329	PROD0206	1	5427.42	5427.42
4945	ORD02329	PROD0196	5	2511.26	12556.30
4946	ORD02329	PROD0101	2	114695.41	229390.82
4947	ORD02329	PROD0113	2	145706.19	291412.38
4948	ORD02330	PROD0181	1	63768.87	63768.87
4949	ORD02330	PROD0141	2	11608.58	23217.16
4950	ORD02331	PROD0111	5	2676.03	13380.15
4951	ORD02331	PROD0048	3	10843.12	32529.36
4952	ORD02332	PROD0265	5	11740.65	58703.25
4953	ORD02332	PROD0065	1	30524.10	30524.10
4954	ORD02332	PROD0029	1	149660.33	149660.33
4955	ORD02332	PROD0155	5	17522.15	87610.75
4956	ORD02333	PROD0265	3	11740.65	35221.95
4957	ORD02334	PROD0077	3	20510.26	61530.78
4958	ORD02334	PROD0139	2	14201.82	28403.64
4959	ORD02334	PROD0169	5	41598.42	207992.10
4960	ORD02335	PROD0097	5	9141.77	45708.85
4961	ORD02336	PROD0051	5	33329.69	166648.45
4962	ORD02337	PROD0271	1	1989.71	1989.71
4963	ORD02337	PROD0270	3	907.09	2721.27
4964	ORD02338	PROD0156	3	21374.21	64122.63
4965	ORD02339	PROD0059	1	35594.97	35594.97
4966	ORD02339	PROD0167	5	22365.17	111825.85
4967	ORD02340	PROD0171	1	105588.96	105588.96
4968	ORD02341	PROD0108	5	121332.02	606660.10
4969	ORD02341	PROD0189	5	96833.78	484168.90
4970	ORD02341	PROD0171	1	105588.96	105588.96
4971	ORD02342	PROD0169	4	41598.42	166393.68
4972	ORD02342	PROD0154	4	19738.96	78955.84
4973	ORD02343	PROD0061	2	6821.26	13642.52
4974	ORD02344	PROD0241	1	1174.07	1174.07
4975	ORD02344	PROD0020	4	293010.61	1172042.44
4976	ORD02345	PROD0159	4	17483.90	69935.60
4977	ORD02345	PROD0214	4	12483.89	49935.56
4978	ORD02345	PROD0237	2	7201.43	14402.86
4979	ORD02345	PROD0136	2	8175.35	16350.70
4980	ORD02345	PROD0055	5	42567.03	212835.15
4981	ORD02346	PROD0176	2	30789.84	61579.68
4982	ORD02346	PROD0016	4	256280.50	1025122.00
4983	ORD02347	PROD0080	2	14845.55	29691.10
4984	ORD02348	PROD0058	1	14691.81	14691.81
4985	ORD02348	PROD0104	4	\N	\N
4986	ORD02348	PROD0142	1	8820.60	8820.60
4987	ORD02349	PROD0173	3	39177.27	117531.81
4988	ORD02350	PROD0191	4	44052.51	176210.04
4989	ORD02351	PROD0183	5	26053.15	130265.75
4990	ORD02351	PROD0004	1	39811.79	39811.79
4991	ORD02351	PROD0155	1	17522.15	17522.15
4992	ORD02352	PROD0169	4	41598.42	166393.68
4993	ORD02353	PROD0119	4	47472.78	189891.12
4994	ORD02353	PROD0115	5	2277.24	11386.20
4995	ORD02354	PROD0216	5	3485.44	17427.20
4996	ORD02354	PROD0019	5	339524.65	1697623.25
4997	ORD02354	PROD0269	3	2989.48	8968.44
4998	ORD02354	PROD0266	1	408.26	408.26
4999	ORD02355	PROD0041	1	14461.31	14461.31
5000	ORD02356	PROD0098	2	54814.26	109628.52
5001	ORD02357	PROD0121	2	17176.67	34353.34
5002	ORD02357	PROD0279	1	962.48	962.48
5003	ORD02357	PROD0230	5	6077.64	30388.20
5004	ORD02357	PROD0266	5	408.26	2041.30
5005	ORD02358	PROD0212	4	8757.97	35031.88
5006	ORD02358	PROD0232	4	4469.76	17879.04
5007	ORD02359	PROD0263	1	8199.23	8199.23
5008	ORD02360	PROD0016	3	256280.50	768841.50
5009	ORD02361	PROD0209	5	2728.52	13642.60
5010	ORD02361	PROD0123	3	11097.43	33292.29
5011	ORD02361	PROD0227	5	9871.34	49356.70
5012	ORD02362	PROD0087	3	12717.02	38151.06
5013	ORD02363	PROD0112	1	35280.59	35280.59
5014	ORD02363	PROD0172	3	95695.43	287086.29
5015	ORD02363	PROD0128	3	24463.34	73390.02
5016	ORD02364	PROD0194	5	24802.59	124012.95
5017	ORD02364	PROD0006	4	308912.61	1235650.44
5018	ORD02364	PROD0193	4	9954.82	39819.28
5019	ORD02364	PROD0138	4	15463.10	61852.40
5020	ORD02365	PROD0276	2	6563.88	13127.76
5021	ORD02365	PROD0094	5	117897.53	589487.65
5022	ORD02366	PROD0197	5	113579.08	567895.40
5023	ORD02367	PROD0139	4	14201.82	56807.28
5024	ORD02367	PROD0028	1	316366.34	316366.34
5025	ORD02368	PROD0254	3	9824.37	29473.11
5026	ORD02368	PROD0257	3	2248.73	6746.19
5027	ORD02368	PROD0126	5	13544.05	67720.25
5028	ORD02368	PROD0027	4	26206.57	104826.28
5029	ORD02368	PROD0136	3	8175.35	24526.05
5030	ORD02369	PROD0191	5	44052.51	220262.55
5031	ORD02369	PROD0236	1	7038.57	7038.57
5032	ORD02369	PROD0258	1	4792.40	4792.40
5033	ORD02369	PROD0198	3	57432.47	172297.41
5034	ORD02370	PROD0218	5	5238.20	26191.00
5035	ORD02370	PROD0134	3	19220.41	57661.23
5036	ORD02370	PROD0131	2	21092.44	42184.88
5037	ORD02371	PROD0223	3	7785.89	23357.67
5038	ORD02372	PROD0262	1	3172.89	3172.89
5039	ORD02372	PROD0221	3	13121.51	39364.53
5040	ORD02372	PROD0227	2	9871.34	19742.68
5041	ORD02372	PROD0129	1	5323.48	5323.48
5042	ORD02372	PROD0234	2	6463.53	12927.06
5043	ORD02373	PROD0175	4	102750.60	411002.40
5044	ORD02374	PROD0279	1	962.48	962.48
5045	ORD02375	PROD0211	5	8250.11	41250.55
5046	ORD02375	PROD0105	1	162358.65	162358.65
5047	ORD02375	PROD0096	3	179864.29	539592.87
5048	ORD02375	PROD0251	2	5175.86	10351.72
5049	ORD02376	PROD0040	1	47715.49	47715.49
5050	ORD02376	PROD0252	1	8223.52	8223.52
5051	ORD02377	PROD0152	3	1904.28	5712.84
5052	ORD02377	PROD0209	5	2728.52	13642.60
5053	ORD02378	PROD0220	1	11275.57	11275.57
5054	ORD02379	PROD0004	4	39811.79	159247.16
5055	ORD02380	PROD0006	2	308912.61	617825.22
5056	ORD02380	PROD0079	1	13912.80	13912.80
5057	ORD02381	PROD0229	2	4112.45	8224.90
5058	ORD02382	PROD0128	2	24463.34	48926.68
5059	ORD02382	PROD0045	4	15761.34	63045.36
5060	ORD02383	PROD0174	3	110640.11	331920.33
5061	ORD02383	PROD0262	4	3172.89	12691.56
5062	ORD02383	PROD0012	3	248709.70	746129.10
5063	ORD02383	PROD0215	3	3385.48	10156.44
5064	ORD02383	PROD0075	3	5182.19	15546.57
5065	ORD02384	PROD0243	1	10094.25	10094.25
5066	ORD02385	PROD0250	3	4620.81	13862.43
5067	ORD02385	PROD0022	4	222156.94	888627.76
5068	ORD02385	PROD0219	1	14849.13	14849.13
5069	ORD02385	PROD0002	1	102447.74	102447.74
5070	ORD02386	PROD0104	2	\N	\N
5071	ORD02386	PROD0093	5	8480.78	42403.90
5072	ORD02386	PROD0124	2	17164.25	34328.50
5073	ORD02386	PROD0187	2	28776.04	57552.08
5074	ORD02387	PROD0042	4	44258.35	177033.40
5075	ORD02388	PROD0117	3	31515.40	94546.20
5076	ORD02388	PROD0017	2	257730.40	515460.80
5077	ORD02388	PROD0076	4	27116.85	108467.40
5078	ORD02389	PROD0170	1	45302.42	45302.42
5079	ORD02389	PROD0057	3	24240.82	72722.46
5080	ORD02389	PROD0013	1	337113.25	337113.25
5081	ORD02389	PROD0074	1	13460.87	13460.87
5082	ORD02390	PROD0114	2	7586.49	15172.98
5083	ORD02391	PROD0004	3	39811.79	119435.37
5084	ORD02391	PROD0162	3	2672.21	8016.63
5085	ORD02391	PROD0247	2	5416.29	10832.58
5086	ORD02392	PROD0062	4	22431.17	89724.68
5087	ORD02392	PROD0208	4	9010.85	36043.40
5088	ORD02392	PROD0135	1	2595.60	2595.60
5089	ORD02392	PROD0120	2	35341.43	70682.86
5090	ORD02393	PROD0057	3	24240.82	72722.46
5091	ORD02393	PROD0095	5	49921.23	249606.15
5092	ORD02394	PROD0241	3	1174.07	3522.21
5093	ORD02394	PROD0048	4	10843.12	43372.48
5094	ORD02394	PROD0230	5	6077.64	30388.20
5095	ORD02394	PROD0277	1	9657.13	9657.13
5096	ORD02395	PROD0122	3	16203.67	48611.01
5097	ORD02395	PROD0123	3	11097.43	33292.29
5098	ORD02395	PROD0016	5	256280.50	1281402.50
5099	ORD02395	PROD0036	1	78738.41	78738.41
5100	ORD02395	PROD0030	4	253935.11	1015740.44
5101	ORD02396	PROD0132	1	23990.67	23990.67
5102	ORD02396	PROD0154	4	19738.96	78955.84
5103	ORD02397	PROD0172	4	95695.43	382781.72
5104	ORD02397	PROD0104	1	\N	\N
5105	ORD02397	PROD0189	4	96833.78	387335.12
5106	ORD02398	PROD0007	4	290642.30	1162569.20
5107	ORD02399	PROD0082	1	54346.36	54346.36
5108	ORD02399	PROD0211	2	8250.11	16500.22
5109	ORD02400	PROD0263	1	8199.23	8199.23
5110	ORD02400	PROD0011	1	314229.61	314229.61
5111	ORD02401	PROD0035	5	190414.55	952072.75
5112	ORD02401	PROD0143	1	13171.72	13171.72
5113	ORD02402	PROD0256	3	1625.49	4876.47
5114	ORD02402	PROD0208	5	9010.85	45054.25
5115	ORD02402	PROD0087	4	12717.02	50868.08
5116	ORD02402	PROD0271	4	1989.71	7958.84
5117	ORD02402	PROD0013	4	337113.25	1348453.00
5118	ORD02403	PROD0198	5	57432.47	287162.35
5119	ORD02404	PROD0206	4	5427.42	21709.68
5120	ORD02404	PROD0157	1	10758.03	10758.03
5121	ORD02405	PROD0058	5	14691.81	73459.05
5122	ORD02406	PROD0236	3	7038.57	21115.71
5123	ORD02406	PROD0145	1	22657.06	22657.06
5124	ORD02406	PROD0272	1	11096.23	11096.23
5125	ORD02406	PROD0090	4	102715.97	410863.88
5126	ORD02407	PROD0186	1	17418.14	17418.14
5127	ORD02407	PROD0278	5	6353.37	31766.85
5128	ORD02408	PROD0145	3	22657.06	67971.18
5129	ORD02408	PROD0256	5	1625.49	8127.45
5130	ORD02408	PROD0231	5	6206.49	31032.45
5131	ORD02408	PROD0123	3	11097.43	33292.29
5132	ORD02409	PROD0241	2	1174.07	2348.14
5133	ORD02409	PROD0064	3	34644.88	103934.64
5134	ORD02410	PROD0131	5	21092.44	105462.20
5135	ORD02410	PROD0219	1	14849.13	14849.13
5136	ORD02411	PROD0097	3	9141.77	27425.31
5137	ORD02411	PROD0108	2	121332.02	242664.04
5138	ORD02412	PROD0202	5	12764.12	63820.60
5139	ORD02413	PROD0169	3	41598.42	124795.26
5140	ORD02414	PROD0064	2	34644.88	69289.76
5141	ORD02414	PROD0059	5	35594.97	177974.85
5142	ORD02415	PROD0085	2	89243.32	178486.64
5143	ORD02415	PROD0066	5	36291.81	181459.05
5144	ORD02416	PROD0005	3	85978.02	257934.06
5145	ORD02416	PROD0126	1	13544.05	13544.05
5146	ORD02416	PROD0142	3	8820.60	26461.80
5147	ORD02416	PROD0225	3	9270.30	27810.90
5148	ORD02417	PROD0154	2	19738.96	39477.92
5149	ORD02418	PROD0258	1	4792.40	4792.40
5150	ORD02419	PROD0140	5	2847.84	14239.20
5151	ORD02420	PROD0214	5	12483.89	62419.45
5152	ORD02420	PROD0096	3	179864.29	539592.87
5153	ORD02421	PROD0267	4	6230.11	24920.44
5154	ORD02421	PROD0275	5	10193.83	50969.15
5155	ORD02421	PROD0162	3	2672.21	8016.63
5156	ORD02421	PROD0167	2	22365.17	44730.34
5157	ORD02421	PROD0009	5	198883.60	994418.00
5158	ORD02422	PROD0075	4	5182.19	20728.76
5159	ORD02423	PROD0001	5	279610.57	1398052.85
5160	ORD02423	PROD0055	5	42567.03	212835.15
5161	ORD02423	PROD0269	5	2989.48	14947.40
5162	ORD02423	PROD0037	4	266180.98	1064723.92
5163	ORD02424	PROD0190	3	22778.54	68335.62
5164	ORD02424	PROD0230	2	6077.64	12155.28
5165	ORD02425	PROD0097	3	9141.77	27425.31
5166	ORD02426	PROD0083	4	160848.97	643395.88
5167	ORD02427	PROD0084	2	37258.14	74516.28
5168	ORD02427	PROD0002	1	102447.74	102447.74
5169	ORD02428	PROD0128	5	24463.34	122316.70
5170	ORD02429	PROD0118	4	12699.55	50798.20
5171	ORD02429	PROD0142	4	8820.60	35282.40
5172	ORD02430	PROD0026	1	34248.48	34248.48
5173	ORD02430	PROD0214	2	12483.89	24967.78
5174	ORD02431	PROD0098	3	54814.26	164442.78
5175	ORD02432	PROD0085	3	89243.32	267729.96
5176	ORD02432	PROD0150	4	12003.33	48013.32
5177	ORD02432	PROD0055	1	42567.03	42567.03
5178	ORD02432	PROD0250	4	4620.81	18483.24
5179	ORD02433	PROD0172	1	95695.43	95695.43
5180	ORD02433	PROD0139	2	14201.82	28403.64
5181	ORD02434	PROD0175	5	102750.60	513753.00
5182	ORD02435	PROD0225	3	9270.30	27810.90
5183	ORD02435	PROD0051	4	33329.69	133318.76
5184	ORD02436	PROD0088	5	\N	\N
5185	ORD02436	PROD0044	1	32574.27	32574.27
5186	ORD02437	PROD0057	3	24240.82	72722.46
5187	ORD02438	PROD0098	4	54814.26	219257.04
5188	ORD02438	PROD0062	3	22431.17	67293.51
5189	ORD02438	PROD0146	2	9207.08	18414.16
5190	ORD02438	PROD0087	1	12717.02	12717.02
5191	ORD02439	PROD0260	3	5050.94	15152.82
5192	ORD02440	PROD0038	5	88262.22	441311.10
5193	ORD02441	PROD0168	3	100026.32	300078.96
5194	ORD02441	PROD0053	5	43609.38	218046.90
5195	ORD02441	PROD0214	1	12483.89	12483.89
5196	ORD02441	PROD0160	3	12278.28	36834.84
5197	ORD02442	PROD0051	3	33329.69	99989.07
5198	ORD02442	PROD0098	2	54814.26	109628.52
5199	ORD02442	PROD0032	2	246601.80	493203.60
5200	ORD02442	PROD0265	1	11740.65	11740.65
5201	ORD02443	PROD0279	3	962.48	2887.44
5202	ORD02444	PROD0202	4	12764.12	51056.48
5203	ORD02445	PROD0130	2	1182.88	2365.76
5204	ORD02446	PROD0160	2	12278.28	24556.56
5205	ORD02447	PROD0241	5	1174.07	5870.35
5206	ORD02447	PROD0155	4	17522.15	70088.60
5207	ORD02447	PROD0027	4	26206.57	104826.28
5208	ORD02448	PROD0027	2	26206.57	52413.14
5209	ORD02448	PROD0011	1	314229.61	314229.61
5210	ORD02448	PROD0124	3	17164.25	51492.75
5211	ORD02449	PROD0237	2	7201.43	14402.86
5212	ORD02450	PROD0273	4	1784.35	7137.40
5213	ORD02450	PROD0107	4	97418.23	389672.92
5214	ORD02450	PROD0092	2	140982.24	281964.48
5215	ORD02451	PROD0087	4	12717.02	50868.08
5216	ORD02451	PROD0262	2	3172.89	6345.78
5217	ORD02451	PROD0098	2	54814.26	109628.52
5218	ORD02452	PROD0021	3	34405.68	103217.04
5219	ORD02452	PROD0141	4	11608.58	46434.32
5220	ORD02452	PROD0093	2	8480.78	16961.56
5221	ORD02452	PROD0119	1	47472.78	47472.78
5222	ORD02453	PROD0096	2	179864.29	359728.58
5223	ORD02453	PROD0042	3	44258.35	132775.05
5224	ORD02454	PROD0246	3	5399.76	16199.28
5225	ORD02455	PROD0205	3	\N	\N
5226	ORD02455	PROD0102	4	45021.16	180084.64
5227	ORD02456	PROD0006	5	308912.61	1544563.05
5228	ORD02456	PROD0167	3	22365.17	67095.51
5229	ORD02457	PROD0088	2	\N	\N
5230	ORD02458	PROD0168	3	100026.32	300078.96
5231	ORD02458	PROD0035	1	190414.55	190414.55
5232	ORD02458	PROD0180	5	60582.65	302913.25
5233	ORD02459	PROD0211	4	8250.11	33000.44
5234	ORD02460	PROD0183	5	26053.15	130265.75
5235	ORD02461	PROD0250	4	4620.81	18483.24
5236	ORD02461	PROD0258	1	4792.40	4792.40
5237	ORD02462	PROD0042	4	44258.35	177033.40
5238	ORD02463	PROD0118	4	12699.55	50798.20
5239	ORD02463	PROD0181	3	63768.87	191306.61
5240	ORD02463	PROD0158	2	12650.30	25300.60
5241	ORD02464	PROD0255	1	7571.15	7571.15
5242	ORD02464	PROD0112	1	35280.59	35280.59
5243	ORD02465	PROD0258	4	4792.40	19169.60
5244	ORD02465	PROD0207	3	11561.20	34683.60
5245	ORD02465	PROD0083	5	160848.97	804244.85
5246	ORD02465	PROD0124	3	17164.25	51492.75
5247	ORD02465	PROD0028	1	316366.34	316366.34
5248	ORD02466	PROD0153	1	10840.50	10840.50
5249	ORD02466	PROD0191	1	44052.51	44052.51
5250	ORD02466	PROD0048	2	10843.12	21686.24
5251	ORD02467	PROD0230	2	6077.64	12155.28
5252	ORD02467	PROD0024	5	321716.92	1608584.60
5253	ORD02468	PROD0099	1	130788.21	130788.21
5254	ORD02468	PROD0095	3	49921.23	149763.69
5255	ORD02469	PROD0144	2	801.07	1602.14
5256	ORD02469	PROD0097	2	9141.77	18283.54
5257	ORD02469	PROD0160	3	12278.28	36834.84
5258	ORD02469	PROD0254	3	9824.37	29473.11
5259	ORD02469	PROD0131	2	21092.44	42184.88
5260	ORD02470	PROD0203	1	3538.98	3538.98
5261	ORD02471	PROD0234	5	6463.53	32317.65
5262	ORD02472	PROD0066	5	36291.81	181459.05
5263	ORD02472	PROD0119	3	47472.78	142418.34
5264	ORD02473	PROD0040	5	47715.49	238577.45
5265	ORD02473	PROD0268	5	2944.75	14723.75
5266	ORD02474	PROD0244	3	1664.99	4994.97
5267	ORD02474	PROD0225	1	9270.30	9270.30
5268	ORD02475	PROD0115	2	2277.24	4554.48
5269	ORD02475	PROD0234	1	6463.53	6463.53
5270	ORD02476	PROD0175	5	102750.60	513753.00
5271	ORD02477	PROD0115	5	2277.24	11386.20
5272	ORD02477	PROD0144	5	801.07	4005.35
5273	ORD02477	PROD0059	1	35594.97	35594.97
5274	ORD02478	PROD0055	3	42567.03	127701.09
5275	ORD02479	PROD0277	4	9657.13	38628.52
5276	ORD02479	PROD0167	2	22365.17	44730.34
5277	ORD02479	PROD0123	1	11097.43	11097.43
5278	ORD02480	PROD0230	5	6077.64	30388.20
5279	ORD02480	PROD0042	3	44258.35	132775.05
5280	ORD02481	PROD0005	1	85978.02	85978.02
5281	ORD02481	PROD0072	3	43142.24	129426.72
5282	ORD02481	PROD0028	2	316366.34	632732.68
5283	ORD02481	PROD0240	4	10219.29	40877.16
5284	ORD02482	PROD0179	3	21340.87	64022.61
5285	ORD02483	PROD0265	4	11740.65	46962.60
5286	ORD02483	PROD0212	4	8757.97	35031.88
5287	ORD02484	PROD0070	1	25905.43	25905.43
5288	ORD02484	PROD0055	4	42567.03	170268.12
5289	ORD02484	PROD0017	2	257730.40	515460.80
5290	ORD02485	PROD0035	1	190414.55	190414.55
5291	ORD02486	PROD0276	3	6563.88	19691.64
5292	ORD02486	PROD0008	1	121518.49	121518.49
5293	ORD02487	PROD0248	5	4809.30	24046.50
5294	ORD02487	PROD0042	4	44258.35	177033.40
5295	ORD02488	PROD0255	1	7571.15	7571.15
5296	ORD02489	PROD0239	2	1047.73	2095.46
5297	ORD02489	PROD0008	2	121518.49	243036.98
5298	ORD02490	PROD0015	4	222324.51	889298.04
5299	ORD02491	PROD0132	3	23990.67	71972.01
5300	ORD02491	PROD0031	2	290316.23	580632.46
5301	ORD02491	PROD0110	5	23332.73	116663.65
5302	ORD02491	PROD0030	1	253935.11	253935.11
5303	ORD02492	PROD0074	3	13460.87	40382.61
5304	ORD02492	PROD0134	4	19220.41	76881.64
5305	ORD02492	PROD0207	1	11561.20	11561.20
5306	ORD02492	PROD0083	3	160848.97	482546.91
5307	ORD02493	PROD0148	2	3628.18	7256.36
5308	ORD02493	PROD0126	2	13544.05	27088.10
5309	ORD02494	PROD0064	4	34644.88	138579.52
5310	ORD02494	PROD0086	3	49202.47	147607.41
5311	ORD02495	PROD0236	3	7038.57	21115.71
5312	ORD02496	PROD0170	2	45302.42	90604.84
5313	ORD02497	PROD0038	3	88262.22	264786.66
5314	ORD02498	PROD0015	1	222324.51	222324.51
5315	ORD02498	PROD0195	4	24091.13	96364.52
5316	ORD02499	PROD0091	2	141135.80	282271.60
5317	ORD02499	PROD0039	4	257535.23	1030140.92
5318	ORD02499	PROD0159	4	17483.90	69935.60
5319	ORD02499	PROD0136	2	8175.35	16350.70
5320	ORD02500	PROD0218	1	5238.20	5238.20
5321	ORD02501	PROD0160	2	12278.28	24556.56
5322	ORD02501	PROD0139	4	14201.82	56807.28
5323	ORD02502	PROD0225	3	9270.30	27810.90
5324	ORD02503	PROD0055	3	42567.03	127701.09
5325	ORD02504	PROD0069	5	39168.98	195844.90
5326	ORD02504	PROD0100	3	110269.71	330809.13
5327	ORD02504	PROD0178	5	87684.88	438424.40
5328	ORD02505	PROD0171	5	105588.96	527944.80
5329	ORD02505	PROD0088	1	\N	\N
5330	ORD02505	PROD0261	3	8607.87	25823.61
5331	ORD02506	PROD0231	3	6206.49	18619.47
5332	ORD02506	PROD0109	3	70228.44	210685.32
5333	ORD02507	PROD0243	4	10094.25	40377.00
5334	ORD02507	PROD0253	3	8743.34	26230.02
5335	ORD02507	PROD0251	3	5175.86	15527.58
5336	ORD02508	PROD0219	3	14849.13	44547.39
5337	ORD02509	PROD0200	2	29196.20	58392.40
5338	ORD02509	PROD0153	4	10840.50	43362.00
5339	ORD02509	PROD0280	3	7685.53	23056.59
5340	ORD02509	PROD0223	3	7785.89	23357.67
5341	ORD02510	PROD0149	2	8124.11	16248.22
5342	ORD02510	PROD0195	1	24091.13	24091.13
5343	ORD02510	PROD0011	1	314229.61	314229.61
5344	ORD02510	PROD0052	3	23501.69	70505.07
5345	ORD02511	PROD0048	1	10843.12	10843.12
5346	ORD02511	PROD0223	5	7785.89	38929.45
5347	ORD02512	PROD0226	4	7172.97	28691.88
5348	ORD02512	PROD0074	2	13460.87	26921.74
5349	ORD02513	PROD0202	1	12764.12	12764.12
5350	ORD02514	PROD0153	3	10840.50	32521.50
5351	ORD02514	PROD0127	2	8700.29	17400.58
5352	ORD02514	PROD0261	4	8607.87	34431.48
5353	ORD02514	PROD0272	5	11096.23	55481.15
5354	ORD02514	PROD0133	5	23616.92	118084.60
5355	ORD02515	PROD0136	3	8175.35	24526.05
5356	ORD02515	PROD0213	3	2985.64	8956.92
5357	ORD02516	PROD0182	1	33297.75	33297.75
5358	ORD02516	PROD0234	2	6463.53	12927.06
5359	ORD02516	PROD0260	4	5050.94	20203.76
5360	ORD02517	PROD0225	2	9270.30	18540.60
5361	ORD02517	PROD0055	2	42567.03	85134.06
5362	ORD02517	PROD0271	2	1989.71	3979.42
5363	ORD02518	PROD0067	4	11627.77	46511.08
5364	ORD02519	PROD0021	3	34405.68	103217.04
5365	ORD02520	PROD0041	1	14461.31	14461.31
5366	ORD02521	PROD0083	4	160848.97	643395.88
5367	ORD02521	PROD0020	3	293010.61	879031.83
5368	ORD02522	PROD0216	4	3485.44	13941.76
5369	ORD02522	PROD0252	3	8223.52	24670.56
5370	ORD02523	PROD0118	4	12699.55	50798.20
5371	ORD02523	PROD0234	5	6463.53	32317.65
5372	ORD02523	PROD0100	2	110269.71	220539.42
5373	ORD02523	PROD0069	5	39168.98	195844.90
5374	ORD02524	PROD0251	4	5175.86	20703.44
5375	ORD02525	PROD0268	4	2944.75	11779.00
5376	ORD02526	PROD0255	1	7571.15	7571.15
5377	ORD02527	PROD0100	1	110269.71	110269.71
5378	ORD02528	PROD0108	4	121332.02	485328.08
5379	ORD02528	PROD0120	4	35341.43	141365.72
5380	ORD02529	PROD0099	1	130788.21	130788.21
5381	ORD02529	PROD0141	3	11608.58	34825.74
5382	ORD02530	PROD0192	5	94625.99	473129.95
5383	ORD02530	PROD0014	2	289145.53	578291.06
5384	ORD02531	PROD0015	5	222324.51	1111622.55
5385	ORD02532	PROD0143	2	13171.72	26343.44
5386	ORD02532	PROD0178	2	87684.88	175369.76
5387	ORD02533	PROD0108	1	121332.02	121332.02
5388	ORD02534	PROD0059	5	35594.97	177974.85
5389	ORD02534	PROD0236	1	7038.57	7038.57
5390	ORD02534	PROD0185	2	112356.62	224713.24
5391	ORD02534	PROD0229	2	4112.45	8224.90
5392	ORD02535	PROD0002	4	102447.74	409790.96
5393	ORD02535	PROD0145	3	22657.06	67971.18
5394	ORD02535	PROD0035	1	190414.55	190414.55
5395	ORD02536	PROD0263	5	8199.23	40996.15
5396	ORD02537	PROD0278	3	6353.37	19060.11
5397	ORD02538	PROD0023	3	276589.43	829768.29
5398	ORD02539	PROD0150	2	12003.33	24006.66
5399	ORD02539	PROD0202	4	12764.12	51056.48
5400	ORD02540	PROD0069	2	39168.98	78337.96
5401	ORD02540	PROD0021	5	34405.68	172028.40
5402	ORD02540	PROD0158	3	12650.30	37950.90
5403	ORD02541	PROD0206	2	5427.42	10854.84
5404	ORD02542	PROD0147	4	5055.12	20220.48
5405	ORD02542	PROD0055	3	42567.03	127701.09
5406	ORD02542	PROD0218	1	5238.20	5238.20
5407	ORD02542	PROD0194	4	24802.59	99210.36
5408	ORD02543	PROD0185	3	112356.62	337069.86
5409	ORD02543	PROD0273	5	1784.35	8921.75
5410	ORD02543	PROD0162	1	2672.21	2672.21
5411	ORD02543	PROD0229	1	4112.45	4112.45
5412	ORD02544	PROD0259	5	7869.35	39346.75
5413	ORD02544	PROD0230	5	6077.64	30388.20
5414	ORD02544	PROD0121	3	17176.67	51530.01
5415	ORD02544	PROD0231	2	6206.49	12412.98
5416	ORD02545	PROD0137	5	2019.05	10095.25
5417	ORD02545	PROD0183	5	26053.15	130265.75
5418	ORD02546	PROD0139	1	14201.82	14201.82
5419	ORD02546	PROD0226	3	7172.97	21518.91
5420	ORD02547	PROD0092	4	140982.24	563928.96
5421	ORD02548	PROD0082	2	54346.36	108692.72
5422	ORD02548	PROD0241	3	1174.07	3522.21
5423	ORD02549	PROD0080	4	14845.55	59382.20
5424	ORD02549	PROD0128	5	24463.34	122316.70
5425	ORD02549	PROD0003	5	49538.31	247691.55
5426	ORD02549	PROD0014	3	289145.53	867436.59
5427	ORD02549	PROD0175	5	102750.60	513753.00
5428	ORD02550	PROD0004	5	39811.79	199058.95
5429	ORD02551	PROD0276	2	6563.88	13127.76
5430	ORD02551	PROD0109	1	70228.44	70228.44
5431	ORD02551	PROD0209	2	2728.52	5457.04
5432	ORD02551	PROD0024	3	321716.92	965150.76
5433	ORD02552	PROD0097	2	9141.77	18283.54
5434	ORD02553	PROD0228	1	6170.81	6170.81
5435	ORD02553	PROD0226	4	7172.97	28691.88
5436	ORD02554	PROD0123	1	11097.43	11097.43
5437	ORD02554	PROD0127	1	8700.29	8700.29
5438	ORD02554	PROD0228	3	6170.81	18512.43
5439	ORD02555	PROD0225	1	9270.30	9270.30
5440	ORD02556	PROD0041	4	14461.31	57845.24
5441	ORD02556	PROD0184	4	48414.15	193656.60
5442	ORD02557	PROD0063	2	35488.70	70977.40
5443	ORD02557	PROD0269	3	2989.48	8968.44
5444	ORD02558	PROD0120	3	35341.43	106024.29
5445	ORD02558	PROD0033	1	245627.48	245627.48
5446	ORD02559	PROD0089	2	45090.58	90181.16
5447	ORD02559	PROD0043	2	16739.67	33479.34
5448	ORD02559	PROD0083	2	160848.97	321697.94
5449	ORD02560	PROD0013	1	337113.25	337113.25
5450	ORD02561	PROD0004	3	39811.79	119435.37
5451	ORD02561	PROD0149	5	8124.11	40620.55
5452	ORD02562	PROD0200	3	29196.20	87588.60
5453	ORD02562	PROD0004	3	39811.79	119435.37
5454	ORD02563	PROD0159	4	17483.90	69935.60
5455	ORD02563	PROD0190	4	22778.54	91114.16
5456	ORD02564	PROD0243	3	10094.25	30282.75
5457	ORD02564	PROD0222	4	2802.33	11209.32
5458	ORD02564	PROD0198	4	57432.47	229729.88
5459	ORD02564	PROD0206	1	5427.42	5427.42
5460	ORD02565	PROD0072	3	43142.24	129426.72
5461	ORD02565	PROD0224	3	607.93	1823.79
5462	ORD02565	PROD0160	2	12278.28	24556.56
5463	ORD02566	PROD0271	5	1989.71	9948.55
5464	ORD02566	PROD0069	5	39168.98	195844.90
5465	ORD02567	PROD0003	4	49538.31	198153.24
5466	ORD02568	PROD0275	2	10193.83	20387.66
5467	ORD02568	PROD0240	5	10219.29	51096.45
5468	ORD02569	PROD0126	1	13544.05	13544.05
5469	ORD02569	PROD0084	3	37258.14	111774.42
5470	ORD02570	PROD0123	1	11097.43	11097.43
5471	ORD02570	PROD0124	1	17164.25	17164.25
5472	ORD02570	PROD0011	1	314229.61	314229.61
5473	ORD02571	PROD0176	4	30789.84	123159.36
5474	ORD02571	PROD0268	3	2944.75	8834.25
5475	ORD02572	PROD0142	2	8820.60	17641.20
5476	ORD02573	PROD0038	4	88262.22	353048.88
5477	ORD02574	PROD0046	3	5762.47	17287.41
5478	ORD02574	PROD0124	4	17164.25	68657.00
5479	ORD02574	PROD0169	4	41598.42	166393.68
5480	ORD02575	PROD0182	3	33297.75	99893.25
5481	ORD02575	PROD0276	1	6563.88	6563.88
5482	ORD02575	PROD0224	4	607.93	2431.72
5483	ORD02576	PROD0063	3	35488.70	106466.10
5484	ORD02576	PROD0057	4	24240.82	96963.28
5485	ORD02576	PROD0222	5	2802.33	14011.65
5486	ORD02576	PROD0067	3	11627.77	34883.31
5487	ORD02577	PROD0275	4	10193.83	40775.32
5488	ORD02577	PROD0146	5	9207.08	46035.40
5489	ORD02577	PROD0071	3	9870.56	29611.68
5490	ORD02578	PROD0025	1	330590.39	330590.39
5491	ORD02578	PROD0047	2	5512.81	11025.62
5492	ORD02579	PROD0161	2	25829.99	51659.98
5493	ORD02579	PROD0066	5	36291.81	181459.05
5494	ORD02579	PROD0005	4	85978.02	343912.08
5495	ORD02580	PROD0022	3	222156.94	666470.82
5496	ORD02580	PROD0141	4	11608.58	46434.32
5497	ORD02581	PROD0201	3	10976.40	32929.20
5498	ORD02582	PROD0268	2	2944.75	5889.50
5499	ORD02583	PROD0008	3	121518.49	364555.47
5500	ORD02583	PROD0121	5	17176.67	85883.35
5501	ORD02583	PROD0028	5	316366.34	1581831.70
5502	ORD02583	PROD0254	3	9824.37	29473.11
5503	ORD02583	PROD0161	1	25829.99	25829.99
5504	ORD02584	PROD0178	1	87684.88	87684.88
5505	ORD02585	PROD0264	2	4118.15	8236.30
5506	ORD02585	PROD0028	3	316366.34	949099.02
5507	ORD02585	PROD0239	3	1047.73	3143.19
5508	ORD02585	PROD0013	1	337113.25	337113.25
5509	ORD02586	PROD0090	3	102715.97	308147.91
5510	ORD02586	PROD0121	2	17176.67	34353.34
5511	ORD02587	PROD0176	4	30789.84	123159.36
5512	ORD02587	PROD0132	4	23990.67	95962.68
5513	ORD02588	PROD0055	3	42567.03	127701.09
5514	ORD02589	PROD0127	2	8700.29	17400.58
5515	ORD02589	PROD0112	4	35280.59	141122.36
5516	ORD02589	PROD0066	1	36291.81	36291.81
5517	ORD02589	PROD0137	2	2019.05	4038.10
5518	ORD02590	PROD0026	2	34248.48	68496.96
5519	ORD02590	PROD0224	4	607.93	2431.72
5520	ORD02591	PROD0243	5	10094.25	50471.25
5521	ORD02591	PROD0097	1	9141.77	9141.77
5522	ORD02591	PROD0111	2	2676.03	5352.06
5523	ORD02592	PROD0076	3	27116.85	81350.55
5524	ORD02592	PROD0227	5	9871.34	49356.70
5525	ORD02593	PROD0093	2	8480.78	16961.56
5526	ORD02593	PROD0044	2	32574.27	65148.54
5527	ORD02593	PROD0046	1	5762.47	5762.47
5528	ORD02593	PROD0216	4	3485.44	13941.76
5529	ORD02594	PROD0142	3	8820.60	26461.80
5530	ORD02595	PROD0083	5	160848.97	804244.85
5531	ORD02596	PROD0004	2	39811.79	79623.58
5532	ORD02596	PROD0029	2	149660.33	299320.66
5533	ORD02596	PROD0238	4	6026.76	24107.04
5534	ORD02597	PROD0260	3	5050.94	15152.82
5535	ORD02597	PROD0229	4	4112.45	16449.80
5536	ORD02597	PROD0280	1	7685.53	7685.53
5537	ORD02598	PROD0008	1	121518.49	121518.49
5538	ORD02599	PROD0218	4	5238.20	20952.80
5539	ORD02599	PROD0244	3	1664.99	4994.97
5540	ORD02600	PROD0015	2	222324.51	444649.02
5541	ORD02600	PROD0124	2	17164.25	34328.50
5542	ORD02600	PROD0149	2	8124.11	16248.22
5543	ORD02600	PROD0141	3	11608.58	34825.74
5544	ORD02600	PROD0216	4	3485.44	13941.76
5545	ORD02601	PROD0034	3	272513.12	817539.36
5546	ORD02602	PROD0161	5	25829.99	129149.95
5547	ORD02602	PROD0035	3	190414.55	571243.65
5548	ORD02603	PROD0185	5	112356.62	561783.10
5549	ORD02604	PROD0230	2	6077.64	12155.28
5550	ORD02604	PROD0162	5	2672.21	13361.05
5551	ORD02604	PROD0079	4	13912.80	55651.20
5552	ORD02605	PROD0066	3	36291.81	108875.43
5553	ORD02606	PROD0102	4	45021.16	180084.64
5554	ORD02607	PROD0220	3	11275.57	33826.71
5555	ORD02608	PROD0080	1	14845.55	14845.55
5556	ORD02608	PROD0092	1	140982.24	140982.24
5557	ORD02608	PROD0074	5	13460.87	67304.35
5558	ORD02609	PROD0086	1	49202.47	49202.47
5559	ORD02609	PROD0190	1	22778.54	22778.54
5560	ORD02610	PROD0014	4	289145.53	1156582.12
5561	ORD02610	PROD0236	5	7038.57	35192.85
5562	ORD02611	PROD0109	4	70228.44	280913.76
5563	ORD02611	PROD0151	4	24271.64	97086.56
5564	ORD02612	PROD0160	4	12278.28	49113.12
5565	ORD02612	PROD0156	4	21374.21	85496.84
5566	ORD02613	PROD0003	2	49538.31	99076.62
5567	ORD02613	PROD0159	5	17483.90	87419.50
5568	ORD02614	PROD0172	3	95695.43	287086.29
5569	ORD02614	PROD0093	4	8480.78	33923.12
5570	ORD02615	PROD0082	4	54346.36	217385.44
5571	ORD02616	PROD0243	4	10094.25	40377.00
5572	ORD02616	PROD0029	2	149660.33	299320.66
5573	ORD02616	PROD0139	2	14201.82	28403.64
5574	ORD02617	PROD0054	3	31709.48	95128.44
5575	ORD02617	PROD0024	1	321716.92	321716.92
5576	ORD02618	PROD0194	4	24802.59	99210.36
5577	ORD02618	PROD0263	2	8199.23	16398.46
5578	ORD02619	PROD0242	3	5755.30	17265.90
5579	ORD02619	PROD0087	3	12717.02	38151.06
5580	ORD02620	PROD0185	5	112356.62	561783.10
5581	ORD02620	PROD0043	3	16739.67	50219.01
5582	ORD02620	PROD0267	4	6230.11	24920.44
5583	ORD02620	PROD0219	1	14849.13	14849.13
5584	ORD02621	PROD0279	4	962.48	3849.92
5585	ORD02621	PROD0127	5	8700.29	43501.45
5586	ORD02621	PROD0015	2	222324.51	444649.02
5587	ORD02621	PROD0063	3	35488.70	106466.10
5588	ORD02622	PROD0253	5	8743.34	43716.70
5589	ORD02622	PROD0127	5	8700.29	43501.45
5590	ORD02623	PROD0015	1	222324.51	222324.51
5591	ORD02623	PROD0040	5	47715.49	238577.45
5592	ORD02623	PROD0198	3	57432.47	172297.41
5593	ORD02623	PROD0111	2	2676.03	5352.06
5594	ORD02624	PROD0125	3	22153.16	66459.48
5595	ORD02624	PROD0203	1	3538.98	3538.98
5596	ORD02624	PROD0112	5	35280.59	176402.95
5597	ORD02624	PROD0035	5	190414.55	952072.75
5598	ORD02625	PROD0219	2	14849.13	29698.26
5599	ORD02625	PROD0248	1	4809.30	4809.30
5600	ORD02626	PROD0164	5	6702.72	33513.60
5601	ORD02626	PROD0205	1	\N	\N
5602	ORD02627	PROD0193	3	9954.82	29864.46
5603	ORD02627	PROD0176	5	30789.84	153949.20
5604	ORD02627	PROD0109	2	70228.44	140456.88
5605	ORD02627	PROD0090	3	102715.97	308147.91
5606	ORD02627	PROD0151	2	24271.64	48543.28
5607	ORD02628	PROD0253	3	8743.34	26230.02
5608	ORD02629	PROD0232	2	4469.76	8939.52
5609	ORD02629	PROD0006	5	308912.61	1544563.05
5610	ORD02629	PROD0069	2	39168.98	78337.96
5611	ORD02629	PROD0248	1	4809.30	4809.30
5612	ORD02630	PROD0280	2	7685.53	15371.06
5613	ORD02631	PROD0007	1	290642.30	290642.30
5614	ORD02632	PROD0120	2	35341.43	70682.86
5615	ORD02633	PROD0084	1	37258.14	37258.14
5616	ORD02633	PROD0046	4	5762.47	23049.88
5617	ORD02633	PROD0113	4	145706.19	582824.76
5618	ORD02633	PROD0058	5	14691.81	73459.05
5619	ORD02634	PROD0052	4	23501.69	94006.76
5620	ORD02634	PROD0043	4	16739.67	66958.68
5621	ORD02635	PROD0275	5	10193.83	50969.15
5622	ORD02635	PROD0211	1	8250.11	8250.11
5623	ORD02635	PROD0070	2	25905.43	51810.86
5624	ORD02636	PROD0120	2	35341.43	70682.86
5625	ORD02636	PROD0009	2	198883.60	397767.20
5626	ORD02637	PROD0007	3	290642.30	871926.90
5627	ORD02638	PROD0015	3	222324.51	666973.53
5628	ORD02638	PROD0230	3	6077.64	18232.92
5629	ORD02639	PROD0224	5	607.93	3039.65
5630	ORD02639	PROD0232	4	4469.76	17879.04
5631	ORD02640	PROD0140	1	2847.84	2847.84
5632	ORD02640	PROD0151	3	24271.64	72814.92
5633	ORD02641	PROD0084	4	37258.14	149032.56
5634	ORD02642	PROD0014	5	289145.53	1445727.65
5635	ORD02642	PROD0061	2	6821.26	13642.52
5636	ORD02643	PROD0038	3	88262.22	264786.66
5637	ORD02643	PROD0021	1	34405.68	34405.68
5638	ORD02644	PROD0244	1	1664.99	1664.99
5639	ORD02644	PROD0040	4	47715.49	190861.96
5640	ORD02644	PROD0046	3	5762.47	17287.41
5641	ORD02644	PROD0236	5	7038.57	35192.85
5642	ORD02645	PROD0046	5	5762.47	28812.35
5643	ORD02645	PROD0084	1	37258.14	37258.14
5644	ORD02645	PROD0131	3	21092.44	63277.32
5645	ORD02645	PROD0029	3	149660.33	448980.99
5646	ORD02645	PROD0230	5	6077.64	30388.20
5647	ORD02646	PROD0032	1	246601.80	246601.80
5648	ORD02647	PROD0206	4	5427.42	21709.68
5649	ORD02647	PROD0238	4	6026.76	24107.04
5650	ORD02648	PROD0020	5	293010.61	1465053.05
5651	ORD02649	PROD0239	2	1047.73	2095.46
5652	ORD02649	PROD0021	5	34405.68	172028.40
5653	ORD02649	PROD0067	1	11627.77	11627.77
5654	ORD02649	PROD0079	3	13912.80	41738.40
5655	ORD02650	PROD0070	2	25905.43	51810.86
5656	ORD02650	PROD0166	2	101932.80	203865.60
5657	ORD02651	PROD0243	3	10094.25	30282.75
5658	ORD02651	PROD0121	5	17176.67	85883.35
5659	ORD02652	PROD0009	1	198883.60	198883.60
5660	ORD02652	PROD0084	5	37258.14	186290.70
5661	ORD02652	PROD0131	2	21092.44	42184.88
5662	ORD02653	PROD0197	3	113579.08	340737.24
5663	ORD02654	PROD0202	3	12764.12	38292.36
5664	ORD02655	PROD0233	2	10621.64	21243.28
5665	ORD02655	PROD0208	2	9010.85	18021.70
5666	ORD02656	PROD0200	4	29196.20	116784.80
5667	ORD02656	PROD0081	4	110991.10	443964.40
5668	ORD02656	PROD0029	2	149660.33	299320.66
5669	ORD02656	PROD0054	2	31709.48	63418.96
5670	ORD02657	PROD0204	2	5933.15	11866.30
5671	ORD02658	PROD0088	5	\N	\N
5672	ORD02659	PROD0137	3	2019.05	6057.15
5673	ORD02660	PROD0044	3	32574.27	97722.81
5674	ORD02660	PROD0040	3	47715.49	143146.47
5675	ORD02660	PROD0054	5	31709.48	158547.40
5676	ORD02660	PROD0240	3	10219.29	30657.87
5677	ORD02661	PROD0042	2	44258.35	88516.70
5678	ORD02661	PROD0273	3	1784.35	5353.05
5679	ORD02661	PROD0154	4	19738.96	78955.84
5680	ORD02662	PROD0089	3	45090.58	135271.74
5681	ORD02662	PROD0129	2	5323.48	10646.96
5682	ORD02662	PROD0199	5	28468.05	142340.25
5683	ORD02663	PROD0271	4	1989.71	7958.84
5684	ORD02664	PROD0062	3	22431.17	67293.51
5685	ORD02664	PROD0134	1	19220.41	19220.41
5686	ORD02665	PROD0025	3	330590.39	991771.17
5687	ORD02665	PROD0174	3	110640.11	331920.33
5688	ORD02665	PROD0239	2	1047.73	2095.46
5689	ORD02665	PROD0088	1	\N	\N
5690	ORD02666	PROD0274	3	7846.95	23540.85
5691	ORD02666	PROD0197	2	113579.08	227158.16
5692	ORD02666	PROD0087	1	12717.02	12717.02
5693	ORD02667	PROD0200	1	29196.20	29196.20
5694	ORD02667	PROD0059	4	35594.97	142379.88
5695	ORD02668	PROD0076	5	27116.85	135584.25
5696	ORD02668	PROD0033	4	245627.48	982509.92
5697	ORD02669	PROD0137	4	2019.05	8076.20
5698	ORD02670	PROD0023	1	276589.43	276589.43
5699	ORD02671	PROD0262	2	3172.89	6345.78
5700	ORD02671	PROD0117	1	31515.40	31515.40
5701	ORD02672	PROD0152	1	1904.28	1904.28
5702	ORD02672	PROD0073	4	6732.32	26929.28
5703	ORD02672	PROD0191	5	44052.51	220262.55
5704	ORD02673	PROD0134	1	19220.41	19220.41
5705	ORD02673	PROD0084	1	37258.14	37258.14
5706	ORD02674	PROD0008	4	121518.49	486073.96
5707	ORD02675	PROD0035	5	190414.55	952072.75
5708	ORD02675	PROD0182	3	33297.75	99893.25
5709	ORD02675	PROD0189	5	96833.78	484168.90
5710	ORD02675	PROD0087	5	12717.02	63585.10
5711	ORD02676	PROD0251	1	5175.86	5175.86
5712	ORD02676	PROD0258	3	4792.40	14377.20
5713	ORD02676	PROD0088	3	\N	\N
5714	ORD02676	PROD0118	4	12699.55	50798.20
5715	ORD02677	PROD0223	1	7785.89	7785.89
5716	ORD02678	PROD0275	1	10193.83	10193.83
5717	ORD02679	PROD0223	1	7785.89	7785.89
5718	ORD02680	PROD0197	1	113579.08	113579.08
5719	ORD02680	PROD0218	5	5238.20	26191.00
5720	ORD02681	PROD0168	1	100026.32	100026.32
5721	ORD02681	PROD0042	1	44258.35	44258.35
5722	ORD02681	PROD0088	5	\N	\N
5723	ORD02681	PROD0045	3	15761.34	47284.02
5724	ORD02682	PROD0067	3	11627.77	34883.31
5725	ORD02682	PROD0143	5	13171.72	65858.60
5726	ORD02683	PROD0124	2	17164.25	34328.50
5727	ORD02683	PROD0173	3	39177.27	117531.81
5728	ORD02684	PROD0229	4	4112.45	16449.80
5729	ORD02685	PROD0130	1	1182.88	1182.88
5730	ORD02685	PROD0181	2	63768.87	127537.74
5731	ORD02685	PROD0080	2	14845.55	29691.10
5732	ORD02685	PROD0170	3	45302.42	135907.26
5733	ORD02686	PROD0167	2	22365.17	44730.34
5734	ORD02686	PROD0087	4	12717.02	50868.08
5735	ORD02687	PROD0220	2	11275.57	22551.14
5736	ORD02687	PROD0168	2	100026.32	200052.64
5737	ORD02688	PROD0028	3	316366.34	949099.02
5738	ORD02688	PROD0073	3	6732.32	20196.96
5739	ORD02688	PROD0031	1	290316.23	290316.23
5740	ORD02688	PROD0115	4	2277.24	9108.96
5741	ORD02688	PROD0265	1	11740.65	11740.65
5742	ORD02689	PROD0213	5	2985.64	14928.20
5743	ORD02690	PROD0104	5	\N	\N
5744	ORD02691	PROD0067	4	11627.77	46511.08
5745	ORD02692	PROD0126	2	13544.05	27088.10
5746	ORD02693	PROD0097	2	9141.77	18283.54
5747	ORD02693	PROD0230	5	6077.64	30388.20
5748	ORD02694	PROD0260	3	5050.94	15152.82
5749	ORD02694	PROD0022	1	222156.94	222156.94
5750	ORD02695	PROD0192	3	94625.99	283877.97
5751	ORD02695	PROD0150	1	12003.33	12003.33
5752	ORD02696	PROD0093	1	8480.78	8480.78
5753	ORD02697	PROD0082	1	54346.36	54346.36
5754	ORD02698	PROD0214	4	12483.89	49935.56
5755	ORD02698	PROD0176	4	30789.84	123159.36
5756	ORD02699	PROD0259	1	7869.35	7869.35
5757	ORD02700	PROD0026	2	34248.48	68496.96
5758	ORD02701	PROD0070	2	25905.43	51810.86
5759	ORD02701	PROD0099	2	130788.21	261576.42
5760	ORD02702	PROD0267	3	6230.11	18690.33
5761	ORD02703	PROD0071	4	9870.56	39482.24
5762	ORD02704	PROD0153	4	10840.50	43362.00
5763	ORD02704	PROD0157	4	10758.03	43032.12
5764	ORD02704	PROD0260	2	5050.94	10101.88
5765	ORD02705	PROD0233	1	10621.64	10621.64
5766	ORD02705	PROD0128	2	24463.34	48926.68
5767	ORD02706	PROD0018	2	120439.60	240879.20
5768	ORD02707	PROD0058	3	14691.81	44075.43
5769	ORD02707	PROD0083	5	160848.97	804244.85
5770	ORD02708	PROD0154	5	19738.96	98694.80
5771	ORD02708	PROD0184	5	48414.15	242070.75
5772	ORD02708	PROD0043	1	16739.67	16739.67
5773	ORD02708	PROD0197	5	113579.08	567895.40
5774	ORD02708	PROD0171	3	105588.96	316766.88
5775	ORD02709	PROD0165	2	22136.37	44272.74
5776	ORD02710	PROD0080	5	14845.55	74227.75
5777	ORD02711	PROD0241	5	1174.07	5870.35
5778	ORD02711	PROD0250	3	4620.81	13862.43
5779	ORD02712	PROD0117	4	31515.40	126061.60
5780	ORD02712	PROD0217	2	7092.62	14185.24
5781	ORD02713	PROD0030	1	253935.11	253935.11
5782	ORD02713	PROD0159	4	17483.90	69935.60
5783	ORD02714	PROD0128	1	24463.34	24463.34
5784	ORD02715	PROD0045	3	15761.34	47284.02
5785	ORD02715	PROD0198	3	57432.47	172297.41
5786	ORD02716	PROD0104	4	\N	\N
5787	ORD02716	PROD0065	5	30524.10	152620.50
5789	ORD02717	PROD0036	1	78738.41	78738.41
5790	ORD02717	PROD0178	3	87684.88	263054.64
5791	ORD02717	PROD0184	3	48414.15	145242.45
5792	ORD02717	PROD0240	4	10219.29	40877.16
5793	ORD02718	PROD0216	4	3485.44	13941.76
5794	ORD02718	PROD0123	3	11097.43	33292.29
5795	ORD02719	PROD0212	1	8757.97	8757.97
5796	ORD02720	PROD0096	5	179864.29	899321.45
5797	ORD02720	PROD0068	2	43176.46	86352.92
5798	ORD02720	PROD0134	3	19220.41	57661.23
5799	ORD02720	PROD0191	4	44052.51	176210.04
5800	ORD02720	PROD0039	5	257535.23	1287676.15
5801	ORD02721	PROD0231	5	6206.49	31032.45
5802	ORD02721	PROD0160	4	12278.28	49113.12
5803	ORD02721	PROD0199	5	28468.05	142340.25
5804	ORD02722	PROD0044	1	32574.27	32574.27
5805	ORD02722	PROD0218	3	5238.20	15714.60
5806	ORD02722	PROD0115	2	2277.24	4554.48
5807	ORD02723	PROD0041	2	14461.31	28922.62
5808	ORD02723	PROD0217	2	7092.62	14185.24
5809	ORD02723	PROD0129	1	5323.48	5323.48
5810	ORD02724	PROD0105	5	162358.65	811793.25
5811	ORD02724	PROD0056	1	6299.62	6299.62
5812	ORD02725	PROD0178	2	87684.88	175369.76
5813	ORD02726	PROD0179	4	21340.87	85363.48
5814	ORD02726	PROD0214	2	12483.89	24967.78
5815	ORD02727	PROD0267	3	6230.11	18690.33
5816	ORD02728	PROD0082	4	54346.36	217385.44
5817	ORD02729	PROD0167	2	22365.17	44730.34
5818	ORD02730	PROD0264	2	4118.15	8236.30
5819	ORD02731	PROD0169	1	41598.42	41598.42
5820	ORD02731	PROD0259	5	7869.35	39346.75
5821	ORD02731	PROD0212	3	8757.97	26273.91
5822	ORD02731	PROD0072	2	43142.24	86284.48
5823	ORD02732	PROD0084	1	37258.14	37258.14
5824	ORD02732	PROD0258	4	4792.40	19169.60
5825	ORD02733	PROD0118	4	12699.55	50798.20
5826	ORD02734	PROD0213	3	2985.64	8956.92
5827	ORD02735	PROD0143	2	13171.72	26343.44
5828	ORD02735	PROD0016	4	256280.50	1025122.00
5829	ORD02736	PROD0080	3	14845.55	44536.65
5830	ORD02736	PROD0129	2	5323.48	10646.96
5831	ORD02737	PROD0025	1	330590.39	330590.39
5832	ORD02737	PROD0128	3	24463.34	73390.02
5833	ORD02738	PROD0204	3	5933.15	17799.45
5834	ORD02738	PROD0169	5	41598.42	207992.10
5835	ORD02738	PROD0078	3	18117.48	54352.44
5836	ORD02739	PROD0087	1	12717.02	12717.02
5837	ORD02739	PROD0003	3	49538.31	148614.93
5838	ORD02740	PROD0205	1	\N	\N
5839	ORD02741	PROD0086	4	49202.47	196809.88
5840	ORD02741	PROD0069	1	39168.98	39168.98
5841	ORD02742	PROD0013	5	337113.25	1685566.25
5842	ORD02742	PROD0068	3	43176.46	129529.38
5843	ORD02743	PROD0210	1	14712.50	14712.50
5844	ORD02743	PROD0203	2	3538.98	7077.96
5845	ORD02744	PROD0018	5	120439.60	602198.00
5846	ORD02744	PROD0047	3	5512.81	16538.43
5847	ORD02744	PROD0189	4	96833.78	387335.12
5848	ORD02745	PROD0187	4	28776.04	115104.16
5849	ORD02745	PROD0097	1	9141.77	9141.77
5850	ORD02746	PROD0055	2	42567.03	85134.06
5851	ORD02746	PROD0168	4	100026.32	400105.28
5852	ORD02747	PROD0115	2	2277.24	4554.48
5853	ORD02747	PROD0110	1	23332.73	23332.73
5854	ORD02747	PROD0052	5	23501.69	117508.45
5855	ORD02747	PROD0035	5	190414.55	952072.75
5856	ORD02748	PROD0009	2	198883.60	397767.20
5857	ORD02749	PROD0248	1	4809.30	4809.30
5858	ORD02750	PROD0167	3	22365.17	67095.51
5859	ORD02750	PROD0252	2	8223.52	16447.04
5860	ORD02751	PROD0125	1	22153.16	22153.16
5861	ORD02752	PROD0218	5	5238.20	26191.00
5862	ORD02753	PROD0265	5	11740.65	58703.25
5863	ORD02753	PROD0258	1	4792.40	4792.40
5864	ORD02753	PROD0220	1	11275.57	11275.57
5865	ORD02754	PROD0215	3	3385.48	10156.44
5866	ORD02754	PROD0066	4	36291.81	145167.24
5867	ORD02754	PROD0162	5	2672.21	13361.05
5868	ORD02755	PROD0047	3	5512.81	16538.43
5869	ORD02756	PROD0037	5	266180.98	1330904.90
5870	ORD02757	PROD0132	3	23990.67	71972.01
5871	ORD02757	PROD0201	4	10976.40	43905.60
5872	ORD02757	PROD0226	3	7172.97	21518.91
5873	ORD02757	PROD0119	2	47472.78	94945.56
5874	ORD02758	PROD0142	3	8820.60	26461.80
5875	ORD02758	PROD0054	5	31709.48	158547.40
5876	ORD02758	PROD0108	4	121332.02	485328.08
5877	ORD02758	PROD0055	4	42567.03	170268.12
5878	ORD02758	PROD0272	1	11096.23	11096.23
5879	ORD02759	PROD0090	1	102715.97	102715.97
5880	ORD02759	PROD0184	1	48414.15	48414.15
5881	ORD02759	PROD0035	5	190414.55	952072.75
5882	ORD02760	PROD0086	1	49202.47	49202.47
5883	ORD02760	PROD0145	2	22657.06	45314.12
5884	ORD02761	PROD0072	4	43142.24	172568.96
5885	ORD02761	PROD0127	4	8700.29	34801.16
5886	ORD02761	PROD0278	4	6353.37	25413.48
5887	ORD02762	PROD0164	2	6702.72	13405.44
5888	ORD02762	PROD0037	3	266180.98	798542.94
5889	ORD02763	PROD0149	1	8124.11	8124.11
5890	ORD02763	PROD0100	5	110269.71	551348.55
5891	ORD02764	PROD0230	2	6077.64	12155.28
5892	ORD02764	PROD0005	4	85978.02	343912.08
5893	ORD02765	PROD0159	5	17483.90	87419.50
5894	ORD02766	PROD0261	3	8607.87	25823.61
5895	ORD02766	PROD0213	4	2985.64	11942.56
5896	ORD02766	PROD0029	4	149660.33	598641.32
5897	ORD02767	PROD0070	2	25905.43	51810.86
5898	ORD02767	PROD0018	1	120439.60	120439.60
5899	ORD02768	PROD0258	5	4792.40	23962.00
5900	ORD02769	PROD0272	1	11096.23	11096.23
5901	ORD02769	PROD0247	5	5416.29	27081.45
5902	ORD02770	PROD0175	4	102750.60	411002.40
5903	ORD02771	PROD0133	1	23616.92	23616.92
5904	ORD02771	PROD0187	3	28776.04	86328.12
5905	ORD02772	PROD0266	2	408.26	816.52
5906	ORD02772	PROD0273	3	1784.35	5353.05
5907	ORD02773	PROD0054	1	31709.48	31709.48
5908	ORD02774	PROD0039	3	257535.23	772605.69
5909	ORD02774	PROD0164	4	6702.72	26810.88
5910	ORD02774	PROD0236	4	7038.57	28154.28
5911	ORD02774	PROD0220	1	11275.57	11275.57
5912	ORD02775	PROD0279	2	962.48	1924.96
5913	ORD02776	PROD0164	1	6702.72	6702.72
5914	ORD02776	PROD0261	2	8607.87	17215.74
5915	ORD02776	PROD0220	3	11275.57	33826.71
5916	ORD02777	PROD0078	5	18117.48	90587.40
5917	ORD02777	PROD0126	3	13544.05	40632.15
5918	ORD02777	PROD0154	2	19738.96	39477.92
5919	ORD02778	PROD0272	2	11096.23	22192.46
5920	ORD02778	PROD0069	5	39168.98	195844.90
5921	ORD02778	PROD0207	5	11561.20	57806.00
5922	ORD02779	PROD0200	5	29196.20	145981.00
5923	ORD02779	PROD0083	4	160848.97	643395.88
5924	ORD02780	PROD0111	3	2676.03	8028.09
5925	ORD02780	PROD0241	4	1174.07	4696.28
5926	ORD02780	PROD0013	5	337113.25	1685566.25
5927	ORD02780	PROD0108	4	121332.02	485328.08
5928	ORD02780	PROD0177	2	102403.06	204806.12
5929	ORD02781	PROD0144	1	801.07	801.07
5930	ORD02782	PROD0262	1	3172.89	3172.89
5931	ORD02783	PROD0049	3	27088.42	81265.26
5932	ORD02783	PROD0257	3	2248.73	6746.19
5933	ORD02784	PROD0002	1	102447.74	102447.74
5934	ORD02785	PROD0244	2	1664.99	3329.98
5935	ORD02786	PROD0280	4	7685.53	30742.12
5936	ORD02786	PROD0195	1	24091.13	24091.13
5937	ORD02786	PROD0185	4	112356.62	449426.48
5938	ORD02787	PROD0188	1	51993.13	51993.13
5939	ORD02788	PROD0108	3	121332.02	363996.06
5940	ORD02789	PROD0279	5	962.48	4812.40
5941	ORD02789	PROD0225	3	9270.30	27810.90
5942	ORD02789	PROD0091	4	141135.80	564543.20
5943	ORD02789	PROD0267	4	6230.11	24920.44
5944	ORD02790	PROD0151	4	24271.64	97086.56
5945	ORD02791	PROD0208	3	9010.85	27032.55
5946	ORD02791	PROD0160	4	12278.28	49113.12
5947	ORD02791	PROD0026	3	34248.48	102745.44
5948	ORD02791	PROD0264	5	4118.15	20590.75
5949	ORD02792	PROD0018	1	120439.60	120439.60
5950	ORD02792	PROD0118	4	12699.55	50798.20
5951	ORD02792	PROD0049	4	27088.42	108353.68
5952	ORD02792	PROD0032	2	246601.80	493203.60
5953	ORD02793	PROD0157	1	10758.03	10758.03
5954	ORD02793	PROD0038	5	88262.22	441311.10
5955	ORD02793	PROD0149	3	8124.11	24372.33
5956	ORD02794	PROD0054	1	31709.48	31709.48
5957	ORD02795	PROD0031	1	290316.23	290316.23
5958	ORD02795	PROD0094	3	117897.53	353692.59
5959	ORD02795	PROD0200	4	29196.20	116784.80
5960	ORD02796	PROD0195	2	24091.13	48182.26
5961	ORD02797	PROD0148	4	3628.18	14512.72
5962	ORD02797	PROD0164	2	6702.72	13405.44
5963	ORD02798	PROD0141	5	11608.58	58042.90
5964	ORD02798	PROD0079	2	13912.80	27825.60
5965	ORD02798	PROD0109	3	70228.44	210685.32
5966	ORD02798	PROD0269	3	2989.48	8968.44
5967	ORD02799	PROD0008	2	121518.49	243036.98
5968	ORD02799	PROD0238	5	6026.76	30133.80
5969	ORD02800	PROD0016	1	256280.50	256280.50
5970	ORD02800	PROD0218	3	5238.20	15714.60
5971	ORD02800	PROD0223	5	7785.89	38929.45
5972	ORD02800	PROD0228	3	6170.81	18512.43
5973	ORD02801	PROD0034	2	272513.12	545026.24
5974	ORD02802	PROD0003	2	49538.31	99076.62
5975	ORD02803	PROD0261	5	8607.87	43039.35
5976	ORD02804	PROD0062	4	22431.17	89724.68
5977	ORD02804	PROD0081	5	110991.10	554955.50
5978	ORD02805	PROD0070	2	25905.43	51810.86
5979	ORD02805	PROD0143	1	13171.72	13171.72
5980	ORD02805	PROD0033	2	245627.48	491254.96
5981	ORD02805	PROD0119	2	47472.78	94945.56
5982	ORD02805	PROD0152	3	1904.28	5712.84
5983	ORD02806	PROD0259	3	7869.35	23608.05
5984	ORD02806	PROD0145	1	22657.06	22657.06
5985	ORD02807	PROD0137	2	2019.05	4038.10
5986	ORD02808	PROD0014	5	289145.53	1445727.65
5987	ORD02809	PROD0066	5	36291.81	181459.05
5988	ORD02810	PROD0262	5	3172.89	15864.45
5989	ORD02810	PROD0254	1	9824.37	9824.37
5990	ORD02810	PROD0055	3	42567.03	127701.09
5991	ORD02810	PROD0172	1	95695.43	95695.43
5992	ORD02811	PROD0248	3	4809.30	14427.90
5993	ORD02811	PROD0130	3	1182.88	3548.64
5994	ORD02812	PROD0129	1	5323.48	5323.48
5995	ORD02813	PROD0272	3	11096.23	33288.69
5996	ORD02813	PROD0203	4	3538.98	14155.92
5997	ORD02814	PROD0003	4	49538.31	198153.24
5998	ORD02815	PROD0076	1	27116.85	27116.85
5999	ORD02816	PROD0079	2	13912.80	27825.60
6000	ORD02816	PROD0183	5	26053.15	130265.75
6001	ORD02817	PROD0010	2	270434.00	540868.00
6002	ORD02818	PROD0221	4	13121.51	52486.04
6003	ORD02819	PROD0236	2	7038.57	14077.14
6004	ORD02819	PROD0162	3	2672.21	8016.63
6005	ORD02820	PROD0081	1	110991.10	110991.10
6006	ORD02820	PROD0264	2	4118.15	8236.30
6007	ORD02820	PROD0118	5	12699.55	63497.75
6008	ORD02820	PROD0113	3	145706.19	437118.57
6009	ORD02821	PROD0097	1	9141.77	9141.77
6010	ORD02821	PROD0093	1	8480.78	8480.78
6011	ORD02821	PROD0240	1	10219.29	10219.29
6012	ORD02821	PROD0122	3	16203.67	48611.01
6013	ORD02821	PROD0149	5	8124.11	40620.55
6014	ORD02822	PROD0104	1	\N	\N
6015	ORD02822	PROD0231	3	6206.49	18619.47
6016	ORD02822	PROD0238	5	6026.76	30133.80
6017	ORD02823	PROD0200	3	29196.20	87588.60
6018	ORD02824	PROD0017	1	257730.40	257730.40
6019	ORD02824	PROD0103	3	83304.08	249912.24
6020	ORD02824	PROD0129	4	5323.48	21293.92
6021	ORD02825	PROD0027	5	26206.57	131032.85
6022	ORD02826	PROD0161	4	25829.99	103319.96
6023	ORD02826	PROD0220	2	11275.57	22551.14
6024	ORD02826	PROD0143	1	13171.72	13171.72
6025	ORD02826	PROD0110	5	23332.73	116663.65
6026	ORD02826	PROD0017	5	257730.40	1288652.00
6027	ORD02827	PROD0052	2	23501.69	47003.38
6028	ORD02827	PROD0199	2	28468.05	56936.10
6029	ORD02827	PROD0164	4	6702.72	26810.88
6030	ORD02827	PROD0260	2	5050.94	10101.88
6031	ORD02827	PROD0237	3	7201.43	21604.29
6032	ORD02828	PROD0215	1	3385.48	3385.48
6033	ORD02828	PROD0231	2	6206.49	12412.98
6034	ORD02829	PROD0086	5	49202.47	246012.35
6035	ORD02829	PROD0252	3	8223.52	24670.56
6036	ORD02829	PROD0274	2	7846.95	15693.90
6037	ORD02830	PROD0150	3	12003.33	36009.99
6038	ORD02830	PROD0052	5	23501.69	117508.45
6039	ORD02831	PROD0143	4	13171.72	52686.88
6040	ORD02831	PROD0110	2	23332.73	46665.46
6041	ORD02831	PROD0234	1	6463.53	6463.53
6042	ORD02832	PROD0064	5	34644.88	173224.40
6043	ORD02832	PROD0223	3	7785.89	23357.67
6044	ORD02833	PROD0031	3	290316.23	870948.69
6045	ORD02834	PROD0217	3	7092.62	21277.86
6046	ORD02835	PROD0091	3	141135.80	423407.40
6047	ORD02835	PROD0258	2	4792.40	9584.80
6048	ORD02835	PROD0170	4	45302.42	181209.68
6049	ORD02836	PROD0077	1	20510.26	20510.26
6050	ORD02836	PROD0192	5	94625.99	473129.95
6051	ORD02837	PROD0229	4	4112.45	16449.80
6052	ORD02837	PROD0188	1	51993.13	51993.13
6053	ORD02837	PROD0261	1	8607.87	8607.87
6054	ORD02837	PROD0237	3	7201.43	21604.29
6055	ORD02837	PROD0125	2	22153.16	44306.32
6056	ORD02838	PROD0221	4	13121.51	52486.04
6057	ORD02839	PROD0055	2	42567.03	85134.06
6058	ORD02839	PROD0244	1	1664.99	1664.99
6059	ORD02839	PROD0149	3	8124.11	24372.33
6060	ORD02840	PROD0062	2	22431.17	44862.34
6061	ORD02841	PROD0246	1	5399.76	5399.76
6062	ORD02842	PROD0167	3	22365.17	67095.51
6063	ORD02842	PROD0005	2	85978.02	171956.04
6064	ORD02842	PROD0211	4	8250.11	33000.44
6065	ORD02843	PROD0052	4	23501.69	94006.76
6066	ORD02843	PROD0250	4	4620.81	18483.24
6067	ORD02844	PROD0179	3	21340.87	64022.61
6068	ORD02845	PROD0216	4	3485.44	13941.76
6069	ORD02845	PROD0140	2	2847.84	5695.68
6070	ORD02846	PROD0023	2	276589.43	553178.86
6071	ORD02847	PROD0095	4	49921.23	199684.92
6072	ORD02848	PROD0070	2	25905.43	51810.86
6073	ORD02849	PROD0147	3	5055.12	15165.36
6074	ORD02849	PROD0003	2	49538.31	99076.62
6075	ORD02849	PROD0167	1	22365.17	22365.17
6076	ORD02849	PROD0120	4	35341.43	141365.72
6077	ORD02849	PROD0092	5	140982.24	704911.20
6078	ORD02850	PROD0038	3	88262.22	264786.66
6079	ORD02850	PROD0239	5	1047.73	5238.65
6080	ORD02850	PROD0007	1	290642.30	290642.30
6081	ORD02851	PROD0060	2	10877.79	21755.58
6082	ORD02852	PROD0152	3	1904.28	5712.84
6083	ORD02852	PROD0183	3	26053.15	78159.45
6084	ORD02853	PROD0255	3	7571.15	22713.45
6085	ORD02853	PROD0005	2	85978.02	171956.04
6086	ORD02854	PROD0065	2	30524.10	61048.20
6087	ORD02855	PROD0223	3	7785.89	23357.67
6088	ORD02855	PROD0089	5	45090.58	225452.90
6089	ORD02856	PROD0096	3	179864.29	539592.87
6090	ORD02857	PROD0039	5	257535.23	1287676.15
6091	ORD02857	PROD0103	3	83304.08	249912.24
6092	ORD02857	PROD0244	2	1664.99	3329.98
6093	ORD02857	PROD0267	1	6230.11	6230.11
6094	ORD02857	PROD0129	2	5323.48	10646.96
6095	ORD02858	PROD0011	5	314229.61	1571148.05
6096	ORD02858	PROD0034	4	272513.12	1090052.48
6097	ORD02859	PROD0204	1	5933.15	5933.15
6098	ORD02859	PROD0142	3	8820.60	26461.80
6099	ORD02859	PROD0193	2	9954.82	19909.64
6100	ORD02860	PROD0073	2	6732.32	13464.64
6101	ORD02861	PROD0002	2	102447.74	204895.48
6102	ORD02861	PROD0055	5	42567.03	212835.15
6103	ORD02861	PROD0139	4	14201.82	56807.28
6104	ORD02861	PROD0271	1	1989.71	1989.71
6105	ORD02861	PROD0056	5	6299.62	31498.10
6106	ORD02862	PROD0230	3	6077.64	18232.92
6107	ORD02863	PROD0206	4	5427.42	21709.68
6108	ORD02863	PROD0264	5	4118.15	20590.75
6109	ORD02863	PROD0057	2	24240.82	48481.64
6110	ORD02864	PROD0007	5	290642.30	1453211.50
6111	ORD02864	PROD0169	1	41598.42	41598.42
6112	ORD02865	PROD0018	5	120439.60	602198.00
6113	ORD02866	PROD0266	4	408.26	1633.04
6114	ORD02867	PROD0036	4	78738.41	314953.64
6115	ORD02867	PROD0050	5	26917.21	134586.05
6116	ORD02867	PROD0211	3	8250.11	24750.33
6117	ORD02868	PROD0217	2	7092.62	14185.24
6118	ORD02868	PROD0133	3	23616.92	70850.76
6119	ORD02868	PROD0074	5	13460.87	67304.35
6120	ORD02868	PROD0259	5	7869.35	39346.75
6121	ORD02868	PROD0059	2	35594.97	71189.94
6122	ORD02869	PROD0135	5	2595.60	12978.00
6123	ORD02869	PROD0165	1	22136.37	22136.37
6124	ORD02870	PROD0133	4	23616.92	94467.68
6125	ORD02870	PROD0222	3	2802.33	8406.99
6126	ORD02870	PROD0190	4	22778.54	91114.16
6127	ORD02871	PROD0109	3	70228.44	210685.32
6128	ORD02871	PROD0012	5	248709.70	1243548.50
6129	ORD02872	PROD0203	1	3538.98	3538.98
6130	ORD02872	PROD0149	4	8124.11	32496.44
6131	ORD02873	PROD0098	1	54814.26	54814.26
6132	ORD02873	PROD0067	4	11627.77	46511.08
6133	ORD02873	PROD0066	2	36291.81	72583.62
6134	ORD02873	PROD0116	3	20859.43	62578.29
6135	ORD02874	PROD0096	4	179864.29	719457.16
6136	ORD02875	PROD0165	4	22136.37	88545.48
6137	ORD02875	PROD0279	1	962.48	962.48
6138	ORD02876	PROD0019	3	339524.65	1018573.95
6139	ORD02876	PROD0266	3	408.26	1224.78
6140	ORD02876	PROD0113	2	145706.19	291412.38
6141	ORD02876	PROD0189	4	96833.78	387335.12
6142	ORD02877	PROD0197	4	113579.08	454316.32
6143	ORD02877	PROD0191	5	44052.51	220262.55
6144	ORD02878	PROD0084	2	37258.14	74516.28
6145	ORD02878	PROD0072	4	43142.24	172568.96
6146	ORD02879	PROD0106	5	137481.28	687406.40
6147	ORD02880	PROD0017	1	257730.40	257730.40
6148	ORD02880	PROD0083	4	160848.97	643395.88
6149	ORD02880	PROD0069	4	39168.98	156675.92
6150	ORD02880	PROD0264	1	4118.15	4118.15
6151	ORD02880	PROD0010	1	270434.00	270434.00
6152	ORD02881	PROD0198	5	57432.47	287162.35
6153	ORD02882	PROD0127	5	8700.29	43501.45
6154	ORD02883	PROD0271	4	1989.71	7958.84
6155	ORD02884	PROD0218	4	5238.20	20952.80
6156	ORD02885	PROD0027	1	26206.57	26206.57
6157	ORD02886	PROD0240	5	10219.29	51096.45
6158	ORD02887	PROD0244	2	1664.99	3329.98
6159	ORD02887	PROD0178	2	87684.88	175369.76
6160	ORD02888	PROD0067	3	11627.77	34883.31
6161	ORD02888	PROD0069	2	39168.98	78337.96
6162	ORD02889	PROD0025	1	330590.39	330590.39
6163	ORD02889	PROD0085	5	89243.32	446216.60
6164	ORD02890	PROD0018	2	120439.60	240879.20
6165	ORD02891	PROD0259	2	7869.35	15738.70
6166	ORD02891	PROD0153	1	10840.50	10840.50
6167	ORD02892	PROD0127	5	8700.29	43501.45
6168	ORD02892	PROD0189	5	96833.78	484168.90
6169	ORD02893	PROD0091	3	141135.80	423407.40
6170	ORD02893	PROD0270	2	907.09	1814.18
6171	ORD02894	PROD0243	4	10094.25	40377.00
6172	ORD02894	PROD0149	4	8124.11	32496.44
6173	ORD02894	PROD0211	5	8250.11	41250.55
6174	ORD02895	PROD0041	5	14461.31	72306.55
6175	ORD02895	PROD0116	3	20859.43	62578.29
6176	ORD02895	PROD0167	3	22365.17	67095.51
6177	ORD02896	PROD0172	2	95695.43	191390.86
6178	ORD02896	PROD0225	3	9270.30	27810.90
6179	ORD02896	PROD0089	1	45090.58	45090.58
6180	ORD02897	PROD0101	5	114695.41	573477.05
6181	ORD02898	PROD0253	5	8743.34	43716.70
6182	ORD02898	PROD0238	2	6026.76	12053.52
6183	ORD02898	PROD0044	2	32574.27	65148.54
6184	ORD02898	PROD0246	1	5399.76	5399.76
6185	ORD02899	PROD0092	4	140982.24	563928.96
6186	ORD02899	PROD0259	5	7869.35	39346.75
6187	ORD02899	PROD0209	1	2728.52	2728.52
6188	ORD02900	PROD0022	5	222156.94	1110784.70
6189	ORD02901	PROD0008	3	121518.49	364555.47
6190	ORD02901	PROD0262	5	3172.89	15864.45
6191	ORD02901	PROD0005	4	85978.02	343912.08
6192	ORD02901	PROD0001	2	279610.57	559221.14
6193	ORD02901	PROD0136	3	8175.35	24526.05
6194	ORD02902	PROD0202	5	12764.12	63820.60
6195	ORD02902	PROD0217	3	7092.62	21277.86
6196	ORD02902	PROD0179	5	21340.87	106704.35
6197	ORD02902	PROD0066	2	36291.81	72583.62
6198	ORD02903	PROD0170	2	45302.42	90604.84
6199	ORD02903	PROD0033	2	245627.48	491254.96
6200	ORD02904	PROD0222	4	2802.33	11209.32
6201	ORD02905	PROD0067	4	11627.77	46511.08
6202	ORD02905	PROD0199	3	28468.05	85404.15
6203	ORD02905	PROD0172	1	95695.43	95695.43
6204	ORD02905	PROD0273	2	1784.35	3568.70
6205	ORD02906	PROD0132	4	23990.67	95962.68
6206	ORD02906	PROD0001	4	279610.57	1118442.28
6207	ORD02907	PROD0212	4	8757.97	35031.88
6208	ORD02907	PROD0044	4	32574.27	130297.08
6209	ORD02907	PROD0019	4	339524.65	1358098.60
6210	ORD02907	PROD0247	5	5416.29	27081.45
6211	ORD02907	PROD0136	4	8175.35	32701.40
6212	ORD02908	PROD0088	2	\N	\N
6213	ORD02908	PROD0149	3	8124.11	24372.33
6214	ORD02909	PROD0191	2	44052.51	88105.02
6215	ORD02910	PROD0164	4	6702.72	26810.88
6216	ORD02910	PROD0006	5	308912.61	1544563.05
6217	ORD02911	PROD0153	4	10840.50	43362.00
6218	ORD02911	PROD0237	3	7201.43	21604.29
6219	ORD02912	PROD0105	4	162358.65	649434.60
6220	ORD02913	PROD0153	3	10840.50	32521.50
6221	ORD02914	PROD0173	4	39177.27	156709.08
6222	ORD02914	PROD0202	2	12764.12	25528.24
6223	ORD02915	PROD0028	4	316366.34	1265465.36
6224	ORD02915	PROD0184	3	48414.15	145242.45
6225	ORD02915	PROD0040	1	47715.49	47715.49
6226	ORD02916	PROD0105	3	162358.65	487075.95
6227	ORD02917	PROD0213	2	2985.64	5971.28
6228	ORD02917	PROD0187	4	28776.04	115104.16
6229	ORD02918	PROD0279	4	962.48	3849.92
6230	ORD02918	PROD0201	4	10976.40	43905.60
6231	ORD02919	PROD0019	2	339524.65	679049.30
6232	ORD02919	PROD0243	5	10094.25	50471.25
6233	ORD02919	PROD0046	5	5762.47	28812.35
6234	ORD02920	PROD0245	1	\N	\N
6235	ORD02921	PROD0066	4	36291.81	145167.24
6236	ORD02922	PROD0223	5	7785.89	38929.45
6237	ORD02923	PROD0035	5	190414.55	952072.75
6238	ORD02924	PROD0212	1	8757.97	8757.97
6239	ORD02925	PROD0189	3	96833.78	290501.34
6240	ORD02926	PROD0224	2	607.93	1215.86
6241	ORD02927	PROD0115	3	2277.24	6831.72
6242	ORD02927	PROD0121	2	17176.67	34353.34
6243	ORD02928	PROD0210	3	14712.50	44137.50
6244	ORD02929	PROD0142	3	8820.60	26461.80
6245	ORD02930	PROD0006	1	308912.61	308912.61
6246	ORD02931	PROD0246	3	5399.76	16199.28
6247	ORD02931	PROD0162	1	2672.21	2672.21
6248	ORD02931	PROD0207	3	11561.20	34683.60
6249	ORD02931	PROD0159	5	17483.90	87419.50
6250	ORD02932	PROD0216	5	3485.44	17427.20
6251	ORD02932	PROD0250	4	4620.81	18483.24
6252	ORD02933	PROD0219	2	14849.13	29698.26
6253	ORD02933	PROD0193	4	9954.82	39819.28
6254	ORD02934	PROD0228	4	6170.81	24683.24
6255	ORD02935	PROD0076	5	27116.85	135584.25
6256	ORD02935	PROD0080	1	14845.55	14845.55
6257	ORD02935	PROD0221	5	13121.51	65607.55
6258	ORD02935	PROD0088	1	\N	\N
6259	ORD02936	PROD0148	1	3628.18	3628.18
6260	ORD02936	PROD0161	3	25829.99	77489.97
6261	ORD02937	PROD0067	4	11627.77	46511.08
6262	ORD02938	PROD0250	4	4620.81	18483.24
6263	ORD02939	PROD0048	3	10843.12	32529.36
6264	ORD02939	PROD0225	4	9270.30	37081.20
6265	ORD02940	PROD0270	5	907.09	4535.45
6266	ORD02940	PROD0180	4	60582.65	242330.60
6267	ORD02941	PROD0126	5	13544.05	67720.25
6268	ORD02941	PROD0058	5	14691.81	73459.05
6269	ORD02942	PROD0164	4	6702.72	26810.88
6270	ORD02942	PROD0093	3	8480.78	25442.34
6271	ORD02942	PROD0174	4	110640.11	442560.44
6272	ORD02943	PROD0260	3	5050.94	15152.82
6273	ORD02944	PROD0042	3	44258.35	132775.05
6274	ORD02944	PROD0266	3	408.26	1224.78
6275	ORD02944	PROD0241	4	1174.07	4696.28
6276	ORD02945	PROD0015	1	222324.51	222324.51
6277	ORD02946	PROD0165	5	22136.37	110681.85
6278	ORD02947	PROD0095	3	49921.23	149763.69
6279	ORD02948	PROD0097	3	9141.77	27425.31
6280	ORD02948	PROD0120	2	35341.43	70682.86
6281	ORD02948	PROD0127	2	8700.29	17400.58
6282	ORD02948	PROD0029	3	149660.33	448980.99
6283	ORD02948	PROD0209	2	2728.52	5457.04
6284	ORD02949	PROD0011	2	314229.61	628459.22
6285	ORD02949	PROD0203	5	3538.98	17694.90
6286	ORD02950	PROD0251	4	5175.86	20703.44
6287	ORD02950	PROD0167	5	22365.17	111825.85
6288	ORD02951	PROD0239	4	1047.73	4190.92
6289	ORD02951	PROD0218	2	5238.20	10476.40
6290	ORD02951	PROD0127	5	8700.29	43501.45
6291	ORD02951	PROD0025	5	330590.39	1652951.95
6292	ORD02951	PROD0241	2	1174.07	2348.14
6293	ORD02952	PROD0167	1	22365.17	22365.17
6294	ORD02952	PROD0172	1	95695.43	95695.43
6295	ORD02953	PROD0205	1	\N	\N
6296	ORD02953	PROD0081	1	110991.10	110991.10
6297	ORD02953	PROD0014	4	289145.53	1156582.12
6298	ORD02954	PROD0177	4	102403.06	409612.24
6299	ORD02954	PROD0149	2	8124.11	16248.22
6300	ORD02955	PROD0227	3	9871.34	29614.02
6301	ORD02956	PROD0162	5	2672.21	13361.05
6302	ORD02957	PROD0018	5	120439.60	602198.00
6303	ORD02957	PROD0260	3	5050.94	15152.82
6304	ORD02958	PROD0245	2	\N	\N
6305	ORD02959	PROD0013	2	337113.25	674226.50
6306	ORD02959	PROD0179	1	21340.87	21340.87
6307	ORD02959	PROD0043	4	16739.67	66958.68
6308	ORD02960	PROD0199	5	28468.05	142340.25
6309	ORD02961	PROD0058	3	14691.81	44075.43
6310	ORD02961	PROD0148	1	3628.18	3628.18
6311	ORD02961	PROD0088	2	\N	\N
6312	ORD02962	PROD0019	3	339524.65	1018573.95
6313	ORD02962	PROD0271	5	1989.71	9948.55
6314	ORD02963	PROD0218	5	5238.20	26191.00
6315	ORD02964	PROD0212	1	8757.97	8757.97
6316	ORD02965	PROD0230	3	6077.64	18232.92
6317	ORD02965	PROD0125	3	22153.16	66459.48
6318	ORD02966	PROD0007	3	290642.30	871926.90
6319	ORD02967	PROD0014	3	289145.53	867436.59
6320	ORD02967	PROD0277	3	9657.13	28971.39
6321	ORD02968	PROD0077	1	20510.26	20510.26
6322	ORD02968	PROD0024	2	321716.92	643433.84
6323	ORD02968	PROD0270	3	907.09	2721.27
6324	ORD02969	PROD0156	4	21374.21	85496.84
6325	ORD02969	PROD0126	4	13544.05	54176.20
6326	ORD02969	PROD0060	1	10877.79	10877.79
6327	ORD02970	PROD0224	2	607.93	1215.86
6328	ORD02970	PROD0046	3	5762.47	17287.41
6329	ORD02971	PROD0155	1	17522.15	17522.15
6330	ORD02972	PROD0020	3	293010.61	879031.83
6331	ORD02972	PROD0197	5	113579.08	567895.40
6332	ORD02973	PROD0021	2	34405.68	68811.36
6333	ORD02973	PROD0116	5	20859.43	104297.15
6334	ORD02973	PROD0202	2	12764.12	25528.24
6335	ORD02974	PROD0050	2	26917.21	53834.42
6336	ORD02974	PROD0249	2	774.24	1548.48
6337	ORD02974	PROD0020	3	293010.61	879031.83
6338	ORD02974	PROD0269	1	2989.48	2989.48
6339	ORD02975	PROD0209	4	2728.52	10914.08
6340	ORD02976	PROD0279	4	962.48	3849.92
6341	ORD02977	PROD0057	1	24240.82	24240.82
6342	ORD02977	PROD0225	5	9270.30	46351.50
6343	ORD02978	PROD0060	4	10877.79	43511.16
6344	ORD02978	PROD0204	5	5933.15	29665.75
6345	ORD02979	PROD0056	2	6299.62	12599.24
6346	ORD02980	PROD0198	2	57432.47	114864.94
6347	ORD02980	PROD0079	1	13912.80	13912.80
6348	ORD02980	PROD0190	2	22778.54	45557.08
6349	ORD02980	PROD0225	3	9270.30	27810.90
6350	ORD02981	PROD0182	4	33297.75	133191.00
6351	ORD02981	PROD0256	3	1625.49	4876.47
6352	ORD02981	PROD0159	3	17483.90	52451.70
6353	ORD02982	PROD0119	2	47472.78	94945.56
6354	ORD02983	PROD0089	3	45090.58	135271.74
6355	ORD02983	PROD0196	4	2511.26	10045.04
6356	ORD02983	PROD0043	1	16739.67	16739.67
6357	ORD02983	PROD0136	4	8175.35	32701.40
6358	ORD02984	PROD0257	3	2248.73	6746.19
6359	ORD02984	PROD0074	1	13460.87	13460.87
6360	ORD02984	PROD0213	5	2985.64	14928.20
6361	ORD02984	PROD0147	1	5055.12	5055.12
6362	ORD02984	PROD0189	2	96833.78	193667.56
6363	ORD02985	PROD0070	5	25905.43	129527.15
6364	ORD02985	PROD0011	2	314229.61	628459.22
6365	ORD02985	PROD0097	4	9141.77	36567.08
6366	ORD02986	PROD0244	3	1664.99	4994.97
6367	ORD02986	PROD0214	1	12483.89	12483.89
6368	ORD02986	PROD0002	3	102447.74	307343.22
6369	ORD02986	PROD0249	4	774.24	3096.96
6370	ORD02987	PROD0098	2	54814.26	109628.52
6371	ORD02987	PROD0181	3	63768.87	191306.61
6372	ORD02988	PROD0107	1	97418.23	97418.23
6373	ORD02988	PROD0274	3	7846.95	23540.85
6374	ORD02988	PROD0131	3	21092.44	63277.32
6375	ORD02989	PROD0073	4	6732.32	26929.28
6376	ORD02990	PROD0141	2	11608.58	23217.16
6377	ORD02990	PROD0270	1	907.09	907.09
6378	ORD02991	PROD0095	5	49921.23	249606.15
6379	ORD02992	PROD0065	4	30524.10	122096.40
6380	ORD02992	PROD0230	3	6077.64	18232.92
6381	ORD02992	PROD0229	4	4112.45	16449.80
6382	ORD02992	PROD0220	5	11275.57	56377.85
6383	ORD02993	PROD0276	3	6563.88	19691.64
6384	ORD02993	PROD0229	5	4112.45	20562.25
6385	ORD02993	PROD0235	2	1609.74	3219.48
6386	ORD02994	PROD0251	3	5175.86	15527.58
6387	ORD02995	PROD0134	3	19220.41	57661.23
6388	ORD02995	PROD0003	2	49538.31	99076.62
6389	ORD02996	PROD0106	5	137481.28	687406.40
6390	ORD02996	PROD0055	1	42567.03	42567.03
6391	ORD02996	PROD0248	3	4809.30	14427.90
6392	ORD02996	PROD0231	2	6206.49	12412.98
6393	ORD02997	PROD0050	5	26917.21	134586.05
6394	ORD02998	PROD0062	5	22431.17	112155.85
6395	ORD02998	PROD0114	5	7586.49	37932.45
6396	ORD02999	PROD0142	2	8820.60	17641.20
6397	ORD03000	PROD0044	4	32574.27	130297.08
6398	ORD03000	PROD0012	4	248709.70	994838.80
6399	ORD03001	PROD0090	3	102715.97	308147.91
6400	ORD03001	PROD0074	4	13460.87	53843.48
6401	ORD03002	PROD0075	4	5182.19	20728.76
6402	ORD03003	PROD0272	3	11096.23	33288.69
6403	ORD03004	PROD0010	1	270434.00	270434.00
6404	ORD03004	PROD0203	1	3538.98	3538.98
6405	ORD03004	PROD0070	5	25905.43	129527.15
6406	ORD03004	PROD0269	5	2989.48	14947.40
6407	ORD03005	PROD0192	1	94625.99	94625.99
6408	ORD03006	PROD0084	4	37258.14	149032.56
6409	ORD03006	PROD0059	2	35594.97	71189.94
6410	ORD03006	PROD0149	4	8124.11	32496.44
6411	ORD03006	PROD0022	2	222156.94	444313.88
6412	ORD03007	PROD0100	5	110269.71	551348.55
6413	ORD03007	PROD0006	2	308912.61	617825.22
6414	ORD03008	PROD0091	3	141135.80	423407.40
6415	ORD03009	PROD0274	5	7846.95	39234.75
6416	ORD03009	PROD0272	2	11096.23	22192.46
6417	ORD03010	PROD0079	5	13912.80	69564.00
6418	ORD03010	PROD0107	4	97418.23	389672.92
6419	ORD03010	PROD0089	2	45090.58	90181.16
6420	ORD03010	PROD0070	3	25905.43	77716.29
6421	ORD03011	PROD0152	4	1904.28	7617.12
6422	ORD03012	PROD0160	5	12278.28	61391.40
6423	ORD03012	PROD0185	3	112356.62	337069.86
6424	ORD03013	PROD0139	4	14201.82	56807.28
6425	ORD03014	PROD0009	3	198883.60	596650.80
6426	ORD03015	PROD0256	4	1625.49	6501.96
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders (order_id, customer_id, seller_id, order_date, delivery_date, order_status, total_amount) FROM stdin;
ORD00001	CUST0002	SELL055	2023-09-27	\N	Cancelled	471572.16
ORD00002	CUST0002	SELL026	2024-09-10	2024-09-23	Delivered	5416.29
ORD00003	CUST0003	SELL056	2024-09-07	2024-09-12	Delivered	343428.55
ORD00004	CUST0003	SELL040	2023-12-10	2023-12-14	Delivered	26203.69
ORD00005	CUST0003	SELL001	2023-11-19	\N	Shipped	6746.19
ORD00006	CUST0004	SELL083	2024-06-28	2024-07-01	Delivered	2257228.05
ORD00007	CUST0004	SELL063	2024-06-15	\N	Cancelled	1403075.56
ORD00008	CUST0004	SELL047	2024-01-06	\N	Shipped	802557.78
ORD00009	CUST0004	SELL085	2024-04-28	2024-05-03	Delivered	1260295.96
ORD00010	CUST0004	SELL022	2024-03-25	\N	Shipped	87246.65
ORD00011	CUST0004	SELL014	2024-12-26	\N	Processing	334130.92
ORD00012	CUST0004	SELL063	2024-05-25	2024-05-27	Delivered	314953.64
ORD00013	CUST0004	SELL048	2024-12-29	2024-12-31	Delivered	78337.96
ORD00014	CUST0004	SELL028	2024-02-14	2024-02-21	Delivered	580632.46
ORD00015	CUST0004	SELL014	2024-07-16	2024-07-21	Delivered	316660.38
ORD00016	CUST0004	SELL013	2024-08-20	2024-08-27	Delivered	2019.05
ORD00017	CUST0004	SELL001	2024-01-10	2024-01-15	Delivered	18690.33
ORD00018	CUST0005	SELL041	2024-04-18	2024-04-21	Delivered	\N
ORD00019	CUST0005	SELL052	2023-10-30	2023-11-05	Delivered	1154125.19
ORD00020	CUST0006	SELL085	2024-04-22	\N	Cancelled	22136.37
ORD00021	CUST0006	SELL042	2024-12-31	\N	Processing	145236.92
ORD00022	CUST0006	SELL061	2024-12-15	\N	Shipped	663220.45
ORD00023	CUST0006	SELL071	2024-10-22	\N	Returned	117343.55
ORD00024	CUST0008	SELL050	2023-09-23	2023-09-26	Delivered	202012.48
ORD00025	CUST0008	SELL029	2024-10-20	\N	Returned	1540352.66
ORD00026	CUST0008	SELL076	2023-11-05	2023-11-11	Delivered	641461.84
ORD00027	CUST0008	SELL041	2024-11-15	2024-11-19	Delivered	63031.03
ORD00028	CUST0009	SELL019	2023-10-10	2023-10-14	Delivered	387229.75
ORD00029	CUST0010	SELL028	2024-09-08	2024-09-15	Delivered	610496.92
ORD00030	CUST0010	SELL029	2024-11-29	\N	Shipped	537014.62
ORD00031	CUST0011	SELL051	2024-11-27	\N	Shipped	5969.13
ORD00032	CUST0012	SELL042	2024-10-08	2024-10-12	Delivered	742823.21
ORD00033	CUST0012	SELL084	2024-06-27	2024-07-02	Delivered	87218.76
ORD00034	CUST0012	SELL008	2024-11-10	\N	Processing	20188.50
ORD00035	CUST0012	SELL076	2024-09-29	\N	Returned	52581.72
ORD00036	CUST0013	SELL084	2024-12-01	\N	Shipped	37673.59
ORD00037	CUST0014	SELL074	2024-11-11	2024-11-16	Delivered	418860.68
ORD00038	CUST0014	SELL090	2024-11-18	2024-11-25	Delivered	50969.15
ORD00039	CUST0014	SELL084	2024-11-30	\N	Cancelled	97418.23
ORD00040	CUST0014	SELL041	2024-08-19	2024-08-23	Delivered	181459.05
ORD00041	CUST0015	SELL065	2023-11-10	\N	Shipped	1924.96
ORD00042	CUST0015	SELL067	2023-09-28	2023-09-29	Delivered	386969.63
ORD00043	CUST0015	SELL027	2024-08-03	\N	Cancelled	308996.77
ORD00044	CUST0016	SELL028	2023-10-22	\N	Cancelled	211025.84
ORD00045	CUST0017	SELL033	2023-07-07	2023-07-08	Delivered	37115.57
ORD00046	CUST0017	SELL025	2024-10-30	\N	Returned	131662.12
ORD00047	CUST0018	SELL088	2023-12-24	2023-12-27	Delivered	397308.38
ORD00048	CUST0020	SELL049	2023-11-03	2023-11-08	Delivered	620263.73
ORD00049	CUST0021	SELL024	2023-12-08	2023-12-16	Delivered	8921.75
ORD00050	CUST0021	SELL034	2024-05-13	\N	Cancelled	16398.46
ORD00051	CUST0021	SELL007	2024-06-28	\N	Returned	160005.84
ORD00052	CUST0021	SELL030	2024-04-18	\N	Cancelled	47284.02
ORD00053	CUST0021	SELL010	2023-10-28	\N	Returned	1548248.63
ORD00054	CUST0021	SELL055	2023-09-17	\N	Shipped	130620.52
ORD00055	CUST0021	SELL052	2024-06-10	\N	Returned	54814.26
ORD00056	CUST0021	SELL088	2024-09-29	2024-10-09	Delivered	55822.24
ORD00057	CUST0022	SELL022	2024-10-15	2024-10-19	Delivered	44075.43
ORD00058	CUST0023	SELL038	2024-11-25	\N	Processing	72814.92
ORD00059	CUST0023	SELL083	2024-10-05	2024-10-11	Delivered	\N
ORD00060	CUST0023	SELL014	2024-09-07	2024-09-14	Delivered	719457.16
ORD00061	CUST0024	SELL020	2024-04-05	\N	Cancelled	128676.99
ORD00062	CUST0024	SELL069	2024-07-24	2024-07-28	Delivered	841181.08
ORD00063	CUST0026	SELL005	2024-09-18	\N	Returned	180084.64
ORD00064	CUST0028	SELL017	2024-10-26	\N	Processing	\N
ORD00065	CUST0028	SELL003	2024-09-02	2024-09-05	Delivered	568676.24
ORD00066	CUST0029	SELL002	2024-10-15	\N	Shipped	55153.50
ORD00067	CUST0029	SELL024	2024-05-27	\N	Returned	106784.91
ORD00068	CUST0029	SELL014	2024-10-15	2024-10-21	Delivered	59207.10
ORD00069	CUST0029	SELL019	2024-07-28	\N	Shipped	105355.32
ORD00070	CUST0029	SELL062	2024-07-06	2024-07-10	Delivered	14849.13
ORD00071	CUST0029	SELL054	2024-07-31	\N	Shipped	661180.78
ORD00072	CUST0030	SELL013	2023-12-22	2023-12-27	Delivered	28219.20
ORD00073	CUST0030	SELL017	2023-03-18	\N	Returned	87090.70
ORD00074	CUST0030	SELL050	2024-12-29	2025-01-03	Delivered	85134.06
ORD00075	CUST0030	SELL084	2023-04-16	\N	Cancelled	317998.91
ORD00076	CUST0030	SELL020	2023-09-27	\N	Cancelled	523152.84
ORD00077	CUST0031	SELL058	2024-09-01	\N	Shipped	9252.98
ORD00078	CUST0031	SELL022	2024-10-11	\N	Processing	52248.32
ORD00079	CUST0031	SELL051	2024-07-23	\N	Returned	18182.81
ORD00080	CUST0031	SELL052	2024-10-26	\N	Processing	237323.74
ORD00081	CUST0031	SELL066	2024-06-07	\N	Shipped	56202.28
ORD00082	CUST0031	SELL069	2024-07-05	2024-07-06	Delivered	68811.36
ORD00083	CUST0031	SELL007	2024-07-09	2024-07-16	Delivered	221349.29
ORD00084	CUST0031	SELL071	2024-09-07	2024-09-13	Delivered	156675.92
ORD00085	CUST0031	SELL002	2024-06-19	\N	Returned	1143598.64
ORD00086	CUST0031	SELL089	2024-12-21	\N	Cancelled	119953.35
ORD00087	CUST0032	SELL051	2023-12-24	\N	Cancelled	189891.12
ORD00088	CUST0032	SELL024	2023-10-28	2023-11-01	Delivered	317920.43
ORD00089	CUST0033	SELL055	2024-02-07	2024-02-11	Delivered	11561.20
ORD00090	CUST0033	SELL049	2023-08-11	\N	Cancelled	24240.82
ORD00091	CUST0033	SELL035	2023-09-12	2023-09-16	Delivered	290642.30
ORD00092	CUST0034	SELL073	2023-06-12	2023-06-16	Delivered	172118.10
ORD00093	CUST0034	SELL014	2023-07-21	2023-07-22	Delivered	150879.51
ORD00094	CUST0034	SELL037	2024-04-14	2024-04-20	Delivered	113579.08
ORD00095	CUST0034	SELL046	2023-11-01	2023-11-04	Delivered	105588.96
ORD00096	CUST0034	SELL078	2023-06-11	\N	Shipped	56377.85
ORD00097	CUST0034	SELL088	2024-05-25	2024-05-31	Delivered	15165.36
ORD00098	CUST0035	SELL010	2024-06-30	\N	Shipped	176298.80
ORD00099	CUST0035	SELL015	2024-08-25	\N	Processing	28718.29
ORD00100	CUST0036	SELL089	2024-11-21	2024-11-25	Delivered	1216584.61
ORD00101	CUST0036	SELL054	2024-11-25	2024-12-01	Delivered	\N
ORD00102	CUST0037	SELL008	2024-08-24	\N	Shipped	551588.14
ORD00103	CUST0037	SELL049	2024-08-25	2024-08-29	Delivered	541867.09
ORD00104	CUST0037	SELL019	2024-08-30	2024-09-06	Delivered	47715.49
ORD00105	CUST0039	SELL039	2024-12-21	\N	Returned	57689.70
ORD00106	CUST0039	SELL023	2024-10-19	\N	Cancelled	1249806.36
ORD00107	CUST0040	SELL055	2024-10-28	2024-11-02	Delivered	163173.87
ORD00108	CUST0040	SELL010	2024-12-26	\N	Cancelled	\N
ORD00109	CUST0040	SELL014	2024-08-10	2024-08-13	Delivered	95695.43
ORD00110	CUST0040	SELL040	2023-09-20	2023-09-22	Delivered	\N
ORD00111	CUST0040	SELL062	2023-07-18	\N	Cancelled	\N
ORD00112	CUST0040	SELL051	2024-06-02	\N	Processing	29969.43
ORD00113	CUST0040	SELL065	2024-07-24	\N	Shipped	20510.26
ORD00114	CUST0040	SELL088	2023-07-11	2023-07-15	Delivered	116631.80
ORD00115	CUST0041	SELL044	2024-10-26	\N	Returned	461449.71
ORD00116	CUST0041	SELL088	2023-03-23	\N	Shipped	487091.15
ORD00117	CUST0041	SELL064	2024-09-13	\N	Returned	243036.98
ORD00118	CUST0041	SELL041	2023-05-11	2023-05-21	Delivered	3808.56
ORD00119	CUST0041	SELL059	2024-02-07	2024-02-12	Delivered	30282.75
ORD00120	CUST0041	SELL073	2023-07-04	\N	Shipped	135324.64
ORD00121	CUST0041	SELL080	2023-06-23	2023-07-04	Delivered	361871.41
ORD00122	CUST0043	SELL010	2023-07-08	\N	Cancelled	7201.43
ORD00123	CUST0044	SELL014	2024-03-23	2024-03-29	Delivered	286796.28
ORD00124	CUST0044	SELL005	2024-09-27	2024-10-01	Delivered	17894.71
ORD00125	CUST0044	SELL047	2024-08-09	2024-08-16	Delivered	1308986.59
ORD00126	CUST0044	SELL052	2024-03-10	2024-03-13	Delivered	17879.04
ORD00127	CUST0045	SELL055	2023-10-09	\N	Shipped	21681.00
ORD00128	CUST0046	SELL090	2024-12-13	\N	Processing	1690544.05
ORD00129	CUST0046	SELL042	2024-10-18	\N	Cancelled	522823.22
ORD00130	CUST0046	SELL053	2024-06-06	2024-06-12	Delivered	409790.96
ORD00131	CUST0046	SELL013	2024-11-15	2024-11-20	Delivered	36567.08
ORD00132	CUST0047	SELL087	2024-03-22	2024-03-28	Delivered	387334.01
ORD00133	CUST0047	SELL090	2024-11-18	\N	Processing	52128.03
ORD00134	CUST0048	SELL059	2024-09-27	\N	Shipped	854711.56
ORD00135	CUST0048	SELL082	2024-12-10	\N	Returned	33329.69
ORD00136	CUST0048	SELL014	2024-12-05	2024-12-09	Delivered	121358.37
ORD00137	CUST0048	SELL028	2024-10-20	\N	Processing	53108.20
ORD00138	CUST0049	SELL060	2024-07-18	2024-07-25	Delivered	90240.52
ORD00139	CUST0049	SELL054	2024-12-02	2024-12-09	Delivered	61679.19
ORD00140	CUST0050	SELL043	2024-11-18	\N	Cancelled	26243.02
ORD00141	CUST0050	SELL007	2024-09-15	\N	Returned	255306.98
ORD00142	CUST0050	SELL017	2023-12-25	\N	Returned	93322.82
ORD00143	CUST0051	SELL076	2024-01-30	\N	Returned	962.48
ORD00144	CUST0052	SELL029	2024-08-05	2024-08-18	Delivered	20387.66
ORD00145	CUST0052	SELL085	2024-08-26	\N	Processing	33479.34
ORD00146	CUST0052	SELL016	2023-11-18	2023-11-30	Delivered	67971.18
ORD00147	CUST0053	SELL027	2024-06-28	\N	Shipped	8223.52
ORD00148	CUST0053	SELL049	2023-09-10	2023-09-14	Delivered	424510.83
ORD00149	CUST0054	SELL077	2024-02-23	2024-02-28	Delivered	165983.83
ORD00150	CUST0055	SELL015	2023-08-20	2023-08-23	Delivered	923063.39
ORD00151	CUST0055	SELL084	2024-03-07	\N	Returned	39297.48
ORD00152	CUST0058	SELL014	2024-11-23	2024-11-27	Delivered	381529.84
ORD00153	CUST0058	SELL041	2024-09-22	\N	Returned	283536.01
ORD00154	CUST0058	SELL066	2023-12-24	2023-12-25	Delivered	44137.50
ORD00155	CUST0058	SELL015	2024-08-19	2024-08-20	Delivered	407731.20
ORD00156	CUST0058	SELL048	2023-12-29	2024-01-01	Delivered	28748.14
ORD00157	CUST0058	SELL042	2024-03-10	2024-03-17	Delivered	1837779.82
ORD00158	CUST0059	SELL083	2023-08-28	\N	Cancelled	60106.93
ORD00159	CUST0059	SELL054	2024-11-04	2024-11-11	Delivered	8939.52
ORD00160	CUST0059	SELL037	2024-02-10	\N	Cancelled	198153.24
ORD00161	CUST0059	SELL068	2024-07-29	2024-08-09	Delivered	198883.60
ORD00162	CUST0059	SELL036	2024-08-11	\N	Returned	350739.52
ORD00163	CUST0060	SELL059	2024-06-30	2024-07-06	Delivered	\N
ORD00164	CUST0060	SELL089	2024-07-14	\N	Shipped	\N
ORD00165	CUST0061	SELL010	2024-07-19	2024-07-22	Delivered	72273.39
ORD00166	CUST0061	SELL041	2024-12-04	2024-12-06	Delivered	241237.25
ORD00167	CUST0061	SELL062	2024-09-28	\N	Processing	24526.05
ORD00168	CUST0061	SELL027	2024-09-08	\N	Returned	229974.35
ORD00169	CUST0061	SELL027	2024-08-25	2024-08-28	Delivered	74101.71
ORD00170	CUST0061	SELL050	2024-08-10	2024-08-13	Delivered	\N
ORD00171	CUST0061	SELL031	2024-08-04	\N	Returned	14077.14
ORD00172	CUST0062	SELL011	2024-04-19	2024-04-24	Delivered	140456.88
ORD00173	CUST0062	SELL048	2024-05-24	2024-05-27	Delivered	10045.04
ORD00174	CUST0062	SELL068	2024-03-05	\N	Cancelled	3210.59
ORD00175	CUST0062	SELL074	2024-03-27	2024-03-28	Delivered	1362565.60
ORD00176	CUST0063	SELL029	2024-03-11	2024-03-12	Delivered	463018.78
ORD00177	CUST0063	SELL013	2023-11-12	\N	Returned	\N
ORD00178	CUST0063	SELL022	2023-07-15	2023-07-16	Delivered	12927.06
ORD00179	CUST0063	SELL034	2024-04-04	2024-04-06	Delivered	\N
ORD00180	CUST0063	SELL038	2023-02-08	\N	Cancelled	59973.83
ORD00181	CUST0063	SELL070	2024-04-29	2024-05-02	Delivered	\N
ORD00182	CUST0064	SELL085	2024-08-23	\N	Shipped	91816.72
ORD00183	CUST0064	SELL090	2024-11-15	2024-11-20	Delivered	1118704.60
ORD00184	CUST0065	SELL036	2024-12-18	2024-12-22	Delivered	1110784.70
ORD00185	CUST0066	SELL073	2024-10-24	\N	Processing	673130.69
ORD00186	CUST0066	SELL038	2024-10-07	2024-10-10	Delivered	68811.36
ORD00187	CUST0066	SELL056	2024-09-05	2024-09-07	Delivered	279610.57
ORD00188	CUST0067	SELL072	2024-12-30	\N	Shipped	47284.02
ORD00189	CUST0067	SELL011	2024-09-02	\N	Cancelled	1030921.60
ORD00190	CUST0067	SELL013	2024-12-16	2024-12-20	Delivered	205354.87
ORD00191	CUST0068	SELL060	2023-10-30	2023-11-05	Delivered	11170.68
ORD00192	CUST0069	SELL055	2024-12-14	2024-12-17	Delivered	51341.16
ORD00193	CUST0069	SELL039	2024-11-07	\N	Cancelled	695585.15
ORD00194	CUST0069	SELL086	2024-12-23	2024-12-27	Delivered	1633.04
ORD00195	CUST0069	SELL084	2024-11-16	\N	Processing	80751.63
ORD00196	CUST0069	SELL075	2024-12-24	2024-12-30	Delivered	1906549.00
ORD00197	CUST0071	SELL001	2023-10-04	2023-10-07	Delivered	1106566.77
ORD00198	CUST0071	SELL004	2024-01-07	2024-01-11	Delivered	637741.33
ORD00199	CUST0071	SELL070	2023-12-25	\N	Processing	46351.50
ORD00200	CUST0071	SELL085	2023-05-21	2023-05-28	Delivered	15864.45
ORD00201	CUST0071	SELL076	2024-02-19	\N	Returned	57410.72
ORD00202	CUST0071	SELL016	2023-09-27	2023-10-01	Delivered	415783.66
ORD00203	CUST0071	SELL060	2024-04-26	\N	Shipped	587515.04
ORD00204	CUST0071	SELL023	2024-06-01	\N	Cancelled	476355.70
ORD00205	CUST0072	SELL049	2024-08-09	2024-08-18	Delivered	184222.10
ORD00206	CUST0073	SELL014	2024-12-07	2024-12-13	Delivered	207195.58
ORD00207	CUST0073	SELL054	2024-12-25	\N	Shipped	1839733.68
ORD00208	CUST0075	SELL074	2024-10-26	2024-11-01	Delivered	463513.16
ORD00209	CUST0076	SELL025	2024-12-05	\N	Cancelled	337113.25
ORD00210	CUST0076	SELL053	2024-12-25	2025-01-01	Delivered	1046114.96
ORD00211	CUST0076	SELL065	2024-10-04	\N	Processing	9870.56
ORD00212	CUST0076	SELL017	2024-12-20	2024-12-21	Delivered	97186.64
ORD00213	CUST0076	SELL038	2024-07-07	\N	Processing	1098722.46
ORD00214	CUST0076	SELL052	2024-10-14	\N	Cancelled	135390.93
ORD00215	CUST0077	SELL043	2024-09-27	2024-10-03	Delivered	1067633.73
ORD00216	CUST0077	SELL054	2024-04-25	2024-04-29	Delivered	104715.98
ORD00217	CUST0077	SELL084	2024-12-17	\N	Cancelled	\N
ORD00218	CUST0080	SELL049	2024-09-16	\N	Cancelled	292099.16
ORD00219	CUST0080	SELL071	2024-08-21	\N	Returned	9270.30
ORD00220	CUST0080	SELL056	2024-08-05	2024-08-08	Delivered	1821077.11
ORD00221	CUST0080	SELL008	2024-12-12	\N	Returned	122096.40
ORD00222	CUST0080	SELL032	2024-07-31	\N	Cancelled	318265.38
ORD00223	CUST0081	SELL047	2024-03-02	2024-03-05	Delivered	81177.59
ORD00224	CUST0081	SELL080	2024-06-08	\N	Returned	840715.87
ORD00225	CUST0081	SELL019	2024-02-26	2024-03-03	Delivered	68706.68
ORD00226	CUST0081	SELL005	2024-01-08	2024-01-15	Delivered	340737.24
ORD00227	CUST0081	SELL050	2024-04-01	\N	Processing	123624.12
ORD00228	CUST0081	SELL085	2024-10-13	2024-10-14	Delivered	19060.11
ORD00229	CUST0081	SELL034	2024-12-01	\N	Shipped	1313680.59
ORD00230	CUST0081	SELL071	2024-11-30	2024-12-01	Delivered	18140.90
ORD00231	CUST0082	SELL060	2024-09-18	2024-09-22	Delivered	299658.88
ORD00232	CUST0082	SELL005	2024-05-27	2024-05-31	Delivered	114557.57
ORD00233	CUST0082	SELL057	2024-05-11	\N	Processing	114669.90
ORD00234	CUST0083	SELL036	2024-10-15	2024-10-16	Delivered	869814.44
ORD00235	CUST0083	SELL084	2024-08-09	\N	Processing	35594.97
ORD00236	CUST0083	SELL006	2024-10-23	\N	Cancelled	1007027.79
ORD00237	CUST0083	SELL077	2024-11-18	\N	Returned	6299.62
ORD00238	CUST0083	SELL074	2024-07-22	2024-07-25	Delivered	2985.64
ORD00239	CUST0083	SELL047	2024-08-08	2024-08-13	Delivered	8185.56
ORD00240	CUST0084	SELL076	2024-09-24	2024-09-26	Delivered	210685.32
ORD00241	CUST0084	SELL045	2024-10-30	\N	Processing	336109.81
ORD00242	CUST0084	SELL069	2024-11-09	\N	Returned	164002.60
ORD00243	CUST0084	SELL043	2024-11-16	2024-11-18	Delivered	34836.28
ORD00244	CUST0086	SELL053	2024-11-21	\N	Shipped	318844.35
ORD00245	CUST0087	SELL030	2024-01-12	2024-01-21	Delivered	87303.72
ORD00246	CUST0088	SELL053	2024-02-09	2024-02-10	Delivered	\N
ORD00247	CUST0088	SELL071	2023-06-28	2023-07-05	Delivered	125704.93
ORD00248	CUST0088	SELL068	2023-07-10	\N	Cancelled	216361.45
ORD00249	CUST0088	SELL079	2024-02-04	\N	Cancelled	321716.92
ORD00250	CUST0089	SELL056	2024-10-25	\N	Returned	\N
ORD00251	CUST0089	SELL066	2024-11-17	\N	Shipped	199058.95
ORD00252	CUST0090	SELL076	2024-10-26	2024-11-01	Delivered	53834.42
ORD00253	CUST0090	SELL068	2024-12-29	\N	Cancelled	64767.87
ORD00254	CUST0090	SELL027	2024-05-28	2024-06-03	Delivered	90661.69
ORD00255	CUST0091	SELL037	2024-01-21	\N	Shipped	250605.03
ORD00256	CUST0091	SELL006	2023-10-13	\N	Cancelled	395202.86
ORD00257	CUST0092	SELL016	2024-10-08	\N	Shipped	17150.33
ORD00258	CUST0093	SELL029	2024-02-26	\N	Processing	653256.02
ORD00259	CUST0093	SELL041	2024-09-29	2024-10-05	Delivered	1008375.05
ORD00260	CUST0093	SELL029	2024-01-01	2024-01-05	Delivered	21046.98
ORD00261	CUST0093	SELL012	2024-01-20	2024-01-26	Delivered	1033526.75
ORD00262	CUST0093	SELL031	2024-03-10	\N	Returned	42907.29
ORD00263	CUST0094	SELL070	2024-07-08	\N	Cancelled	464035.78
ORD00264	CUST0094	SELL015	2024-02-11	\N	Returned	6702.72
ORD00265	CUST0095	SELL063	2024-12-27	\N	Processing	718503.54
ORD00266	CUST0096	SELL053	2024-09-06	2024-09-14	Delivered	39485.36
ORD00267	CUST0096	SELL044	2024-08-09	2024-08-15	Delivered	1337468.88
ORD00268	CUST0096	SELL015	2024-12-24	2025-01-06	Delivered	1040455.46
ORD00269	CUST0096	SELL067	2024-04-26	\N	Returned	20387.66
ORD00270	CUST0097	SELL048	2024-12-06	2024-12-10	Delivered	13380.15
ORD00271	CUST0097	SELL068	2024-11-24	\N	Processing	23732.60
ORD00272	CUST0099	SELL049	2023-12-14	2023-12-17	Delivered	57378.28
ORD00273	CUST0099	SELL078	2024-06-03	2024-06-13	Delivered	688797.69
ORD00274	CUST0099	SELL049	2023-07-16	2023-07-25	Delivered	21686.24
ORD00275	CUST0099	SELL065	2024-08-11	2024-08-21	Delivered	795534.40
ORD00276	CUST0100	SELL004	2024-06-19	2024-06-24	Delivered	189891.12
ORD00277	CUST0100	SELL081	2024-11-03	2024-11-05	Delivered	565928.04
ORD00278	CUST0100	SELL064	2024-12-03	2024-12-10	Delivered	36834.84
ORD00279	CUST0100	SELL053	2024-11-15	\N	Cancelled	459256.77
ORD00280	CUST0100	SELL011	2024-10-12	\N	Processing	186735.09
ORD00281	CUST0100	SELL064	2024-06-21	2024-06-25	Delivered	11957.92
ORD00282	CUST0100	SELL016	2024-09-07	2024-09-10	Delivered	163963.66
ORD00283	CUST0101	SELL027	2024-02-21	\N	Cancelled	188490.04
ORD00284	CUST0101	SELL061	2023-09-15	2023-09-21	Delivered	24967.78
ORD00285	CUST0101	SELL026	2023-05-05	2023-05-07	Delivered	21301.38
ORD00286	CUST0101	SELL072	2023-10-07	2023-10-13	Delivered	1482049.93
ORD00287	CUST0102	SELL085	2024-09-22	\N	Cancelled	13912.80
ORD00288	CUST0102	SELL017	2023-11-22	\N	Cancelled	766746.28
ORD00289	CUST0102	SELL019	2023-10-05	2023-10-09	Delivered	838831.71
ORD00290	CUST0102	SELL057	2023-07-16	\N	Cancelled	517397.50
ORD00291	CUST0102	SELL061	2024-04-03	2024-04-11	Delivered	8834.25
ORD00292	CUST0102	SELL082	2023-10-03	\N	Shipped	65538.61
ORD00293	CUST0102	SELL060	2024-02-17	2024-02-24	Delivered	511280.86
ORD00294	CUST0102	SELL068	2023-03-08	2023-03-15	Delivered	52451.70
ORD00295	CUST0102	SELL002	2023-11-12	\N	Cancelled	528192.72
ORD00296	CUST0102	SELL074	2023-11-12	2023-11-14	Delivered	95114.76
ORD00297	CUST0105	SELL008	2023-07-21	2023-07-25	Delivered	375751.75
ORD00298	CUST0105	SELL041	2023-05-15	2023-05-28	Delivered	392099.74
ORD00299	CUST0105	SELL011	2023-09-26	\N	Returned	829768.29
ORD00300	CUST0105	SELL001	2024-06-20	2024-07-04	Delivered	60582.65
ORD00301	CUST0106	SELL024	2024-06-01	2024-06-05	Delivered	1006562.43
ORD00302	CUST0107	SELL017	2024-10-07	2024-10-12	Delivered	72273.39
ORD00303	CUST0107	SELL035	2024-10-16	2024-10-21	Delivered	541298.27
ORD00304	CUST0107	SELL081	2024-11-27	\N	Cancelled	\N
ORD00305	CUST0107	SELL027	2024-12-04	2024-12-10	Delivered	23962.00
ORD00306	CUST0107	SELL027	2024-09-17	\N	Cancelled	23581.39
ORD00307	CUST0107	SELL076	2024-09-29	2024-10-08	Delivered	124012.95
ORD00308	CUST0107	SELL002	2024-09-19	\N	Returned	4994.97
ORD00309	CUST0107	SELL040	2024-09-29	\N	Shipped	15371.06
ORD00310	CUST0108	SELL056	2024-09-02	\N	Cancelled	144597.19
ORD00311	CUST0108	SELL030	2023-02-14	\N	Shipped	56529.82
ORD00312	CUST0108	SELL077	2024-06-11	2024-06-17	Delivered	517459.78
ORD00313	CUST0110	SELL024	2024-09-22	2024-09-23	Delivered	649434.60
ORD00314	CUST0111	SELL013	2024-11-11	2024-11-14	Delivered	331970.24
ORD00315	CUST0111	SELL050	2024-12-29	\N	Shipped	156675.92
ORD00316	CUST0111	SELL055	2024-12-24	\N	Returned	1088264.77
ORD00317	CUST0111	SELL023	2024-11-12	2024-11-17	Delivered	1015340.04
ORD00318	CUST0111	SELL018	2024-11-15	\N	Returned	1110682.05
ORD00319	CUST0113	SELL062	2024-11-26	\N	Returned	6970.88
ORD00320	CUST0114	SELL045	2024-07-29	\N	Processing	41523.39
ORD00321	CUST0114	SELL002	2024-06-17	\N	Returned	26705.28
ORD00322	CUST0114	SELL058	2024-02-01	\N	Cancelled	337557.54
ORD00323	CUST0114	SELL050	2024-07-08	\N	Cancelled	409347.26
ORD00324	CUST0114	SELL037	2024-07-23	2024-07-27	Delivered	20703.44
ORD00325	CUST0114	SELL044	2024-11-19	2024-11-23	Delivered	1024046.49
ORD00326	CUST0115	SELL077	2024-01-29	\N	Returned	1697623.25
ORD00327	CUST0115	SELL017	2023-10-12	\N	Cancelled	136758.96
ORD00328	CUST0116	SELL006	2024-10-01	\N	Cancelled	44052.51
ORD00329	CUST0116	SELL044	2023-07-26	2023-07-29	Delivered	1056588.38
ORD00330	CUST0116	SELL079	2024-11-18	2024-11-24	Delivered	237701.88
ORD00331	CUST0116	SELL036	2024-07-04	2024-07-08	Delivered	\N
ORD00332	CUST0116	SELL085	2023-05-03	\N	Processing	8076.20
ORD00333	CUST0116	SELL003	2024-03-04	2024-03-09	Delivered	1038583.27
ORD00334	CUST0117	SELL002	2024-11-16	\N	Shipped	20108.16
ORD00335	CUST0117	SELL087	2024-11-28	2024-12-02	Delivered	11561.20
ORD00336	CUST0117	SELL072	2024-04-27	\N	Returned	499346.99
ORD00337	CUST0118	SELL037	2024-09-04	2024-09-07	Delivered	118777.43
ORD00338	CUST0119	SELL015	2023-11-08	2023-11-10	Delivered	835660.76
ORD00339	CUST0119	SELL036	2024-04-21	\N	Shipped	17418.14
ORD00340	CUST0119	SELL041	2024-08-09	\N	Processing	47474.30
ORD00341	CUST0119	SELL021	2024-11-15	\N	Shipped	\N
ORD00342	CUST0119	SELL054	2024-07-13	\N	Returned	456035.22
ORD00343	CUST0119	SELL053	2024-07-22	\N	Cancelled	173734.16
ORD00344	CUST0120	SELL021	2024-10-13	\N	Processing	249821.66
ORD00345	CUST0120	SELL059	2024-09-01	2024-09-10	Delivered	12341.62
ORD00346	CUST0120	SELL078	2024-12-31	\N	Returned	75091.84
ORD00347	CUST0121	SELL034	2024-05-19	2024-05-28	Delivered	1135166.90
ORD00348	CUST0122	SELL081	2024-04-13	2024-04-24	Delivered	80565.33
ORD00349	CUST0122	SELL015	2024-08-01	\N	Processing	564062.64
ORD00350	CUST0122	SELL059	2024-09-02	\N	Returned	259667.35
ORD00351	CUST0122	SELL019	2024-08-09	2024-08-14	Delivered	905369.04
ORD00352	CUST0123	SELL040	2023-11-14	\N	Cancelled	62889.22
ORD00353	CUST0123	SELL004	2024-03-08	2024-03-13	Delivered	1747386.06
ORD00354	CUST0123	SELL076	2024-02-17	\N	Returned	681549.77
ORD00355	CUST0123	SELL009	2023-09-01	\N	Returned	34967.80
ORD00356	CUST0123	SELL016	2024-09-26	\N	Returned	112340.05
ORD00357	CUST0123	SELL068	2024-10-28	\N	Returned	\N
ORD00358	CUST0123	SELL011	2024-10-31	\N	Returned	534672.17
ORD00359	CUST0123	SELL012	2024-01-08	\N	Cancelled	785948.40
ORD00360	CUST0123	SELL069	2024-06-17	2024-06-20	Delivered	579273.29
ORD00361	CUST0123	SELL039	2024-06-21	2024-06-30	Delivered	81869.66
ORD00362	CUST0124	SELL077	2024-11-23	\N	Processing	423407.40
ORD00363	CUST0124	SELL069	2024-12-18	2024-12-25	Delivered	58042.90
ORD00364	CUST0124	SELL024	2024-11-14	\N	Shipped	61242.36
ORD00365	CUST0124	SELL013	2024-12-04	\N	Returned	299455.34
ORD00366	CUST0124	SELL014	2024-12-26	\N	Cancelled	393687.16
ORD00367	CUST0126	SELL061	2024-03-31	2024-04-10	Delivered	71357.08
ORD00368	CUST0126	SELL043	2024-06-14	2024-06-20	Delivered	\N
ORD00369	CUST0126	SELL046	2024-08-04	2024-08-12	Delivered	135890.25
ORD00370	CUST0127	SELL004	2024-05-12	\N	Processing	7533.78
ORD00371	CUST0127	SELL057	2024-04-02	\N	Cancelled	1912003.69
ORD00372	CUST0127	SELL063	2024-11-15	2024-11-21	Delivered	9954.82
ORD00373	CUST0127	SELL057	2024-05-03	\N	Cancelled	350606.06
ORD00374	CUST0127	SELL042	2024-09-26	2024-09-28	Delivered	68757.46
ORD00375	CUST0128	SELL047	2024-07-21	\N	Shipped	329209.29
ORD00376	CUST0128	SELL018	2024-06-23	2024-06-25	Delivered	33000.44
ORD00377	CUST0128	SELL008	2024-03-07	\N	Processing	1081019.63
ORD00378	CUST0128	SELL073	2024-03-17	\N	Returned	73459.05
ORD00379	CUST0128	SELL060	2024-03-27	\N	Cancelled	484043.70
ORD00380	CUST0128	SELL010	2024-04-29	\N	Returned	442560.44
ORD00381	CUST0128	SELL052	2024-09-20	\N	Shipped	69007.99
ORD00382	CUST0128	SELL075	2024-06-23	\N	Processing	403673.98
ORD00383	CUST0129	SELL019	2024-12-26	2025-01-02	Delivered	8999.40
ORD00384	CUST0129	SELL009	2024-11-28	\N	Cancelled	5344.42
ORD00385	CUST0129	SELL030	2024-11-30	2024-12-03	Delivered	1340872.79
ORD00386	CUST0129	SELL057	2024-12-03	2024-12-07	Delivered	549925.12
ORD00387	CUST0130	SELL016	2024-12-10	\N	Returned	121332.02
ORD00388	CUST0130	SELL041	2024-11-11	\N	Returned	623198.53
ORD00389	CUST0130	SELL054	2024-11-24	2024-12-03	Delivered	170398.32
ORD00390	CUST0130	SELL011	2024-12-19	2025-01-02	Delivered	46462.10
ORD00391	CUST0130	SELL023	2024-10-02	2024-10-08	Delivered	73400.14
ORD00392	CUST0130	SELL027	2024-10-04	\N	Cancelled	746118.36
ORD00393	CUST0130	SELL021	2024-12-21	2024-12-25	Delivered	487075.95
ORD00394	CUST0131	SELL043	2024-09-20	2024-09-22	Delivered	1174.07
ORD00395	CUST0131	SELL077	2024-06-02	2024-06-10	Delivered	392693.70
ORD00396	CUST0131	SELL060	2024-01-03	\N	Shipped	783030.12
ORD00397	CUST0131	SELL013	2024-09-16	\N	Returned	382011.32
ORD00398	CUST0131	SELL013	2024-03-01	\N	Returned	189369.24
ORD00399	CUST0131	SELL086	2024-11-04	\N	Shipped	29538.45
ORD00400	CUST0132	SELL026	2024-10-11	\N	Returned	1371310.40
ORD00401	CUST0132	SELL074	2024-12-12	\N	Processing	148528.57
ORD00402	CUST0132	SELL066	2024-09-14	\N	Returned	1243150.89
ORD00403	CUST0133	SELL055	2024-04-02	\N	Processing	62010.68
ORD00404	CUST0133	SELL038	2024-05-01	\N	Cancelled	263054.64
ORD00405	CUST0133	SELL065	2024-04-12	\N	Shipped	6345.78
ORD00406	CUST0134	SELL068	2024-09-09	\N	Returned	101683.63
ORD00407	CUST0134	SELL068	2023-12-26	\N	Returned	54346.36
ORD00408	CUST0134	SELL020	2024-11-12	\N	Cancelled	\N
ORD00409	CUST0134	SELL054	2024-01-29	2024-02-09	Delivered	208766.75
ORD00410	CUST0135	SELL008	2024-12-13	\N	Shipped	134871.38
ORD00411	CUST0135	SELL032	2024-08-31	\N	Cancelled	624620.28
ORD00412	CUST0135	SELL087	2024-04-30	2024-05-04	Delivered	100026.32
ORD00413	CUST0135	SELL030	2024-11-07	2024-11-16	Delivered	227426.90
ORD00414	CUST0135	SELL006	2024-08-05	\N	Shipped	21092.44
ORD00415	CUST0137	SELL029	2024-11-23	\N	Processing	81197.50
ORD00416	CUST0137	SELL036	2024-11-06	2024-11-09	Delivered	73579.33
ORD00417	CUST0137	SELL063	2024-08-16	\N	Returned	19648.74
ORD00418	CUST0137	SELL063	2024-08-17	\N	Shipped	40227.54
ORD00419	CUST0138	SELL016	2023-04-14	\N	Cancelled	687984.41
ORD00420	CUST0138	SELL004	2024-03-21	\N	Returned	8480.78
ORD00421	CUST0138	SELL004	2023-10-30	\N	Shipped	407586.12
ORD00422	CUST0138	SELL082	2024-04-17	\N	Returned	321697.94
ORD00423	CUST0138	SELL045	2024-10-28	2024-11-05	Delivered	168960.56
ORD00424	CUST0139	SELL013	2023-12-18	\N	Processing	121442.45
ORD00425	CUST0139	SELL047	2024-01-08	\N	Processing	1211000.62
ORD00426	CUST0139	SELL072	2024-11-15	\N	Cancelled	269401.53
ORD00427	CUST0139	SELL019	2024-12-07	2024-12-13	Delivered	142692.85
ORD00428	CUST0139	SELL011	2023-11-24	\N	Cancelled	83437.72
ORD00429	CUST0139	SELL036	2023-07-05	\N	Returned	4554.48
ORD00430	CUST0139	SELL019	2024-11-21	\N	Processing	22153.16
ORD00431	CUST0139	SELL073	2024-04-21	2024-05-01	Delivered	899321.45
ORD00432	CUST0139	SELL047	2024-02-28	\N	Returned	102365.44
ORD00433	CUST0139	SELL069	2023-06-14	2023-06-19	Delivered	132923.54
ORD00434	CUST0140	SELL083	2024-05-01	\N	Returned	1687415.50
ORD00435	CUST0140	SELL072	2023-06-02	\N	Cancelled	\N
ORD00436	CUST0140	SELL004	2024-02-17	\N	Cancelled	215813.02
ORD00437	CUST0140	SELL066	2024-03-17	2024-03-22	Delivered	284037.06
ORD00438	CUST0140	SELL021	2023-07-15	\N	Cancelled	596873.08
ORD00439	CUST0141	SELL049	2024-05-23	\N	Processing	50530.96
ORD00440	CUST0141	SELL064	2024-07-06	\N	Shipped	76881.64
ORD00441	CUST0141	SELL013	2023-07-15	2023-07-22	Delivered	1817749.85
ORD00442	CUST0141	SELL068	2023-04-24	\N	Shipped	400105.28
ORD00443	CUST0142	SELL023	2024-03-22	\N	Processing	3250.98
ORD00444	CUST0142	SELL020	2023-06-12	\N	Processing	318136.45
ORD00445	CUST0142	SELL069	2023-04-05	\N	Cancelled	183364.82
ORD00446	CUST0144	SELL085	2024-07-17	\N	Shipped	59584.40
ORD00447	CUST0144	SELL063	2024-04-08	2024-04-15	Delivered	11561.20
ORD00448	CUST0145	SELL076	2024-12-17	\N	Processing	6230.11
ORD00449	CUST0145	SELL090	2024-12-05	\N	Cancelled	48584.83
ORD00450	CUST0145	SELL055	2024-11-14	2024-11-20	Delivered	115950.03
ORD00451	CUST0145	SELL040	2024-12-02	\N	Cancelled	167801.23
ORD00452	CUST0145	SELL074	2024-12-29	\N	Cancelled	459740.34
ORD00453	CUST0145	SELL007	2024-11-14	2024-11-19	Delivered	67579.57
ORD00454	CUST0145	SELL029	2024-11-15	2024-11-17	Delivered	1300172.97
ORD00455	CUST0145	SELL001	2024-12-16	2024-12-19	Delivered	792677.46
ORD00456	CUST0145	SELL088	2024-12-14	2024-12-18	Delivered	701886.30
ORD00457	CUST0145	SELL025	2024-11-28	2024-12-05	Delivered	1255316.56
ORD00458	CUST0148	SELL022	2024-08-16	2024-08-19	Delivered	166388.35
ORD00459	CUST0148	SELL072	2024-09-19	\N	Shipped	230104.36
ORD00460	CUST0148	SELL089	2024-11-06	2024-11-13	Delivered	160987.02
ORD00461	CUST0148	SELL025	2024-12-05	\N	Processing	1231073.02
ORD00462	CUST0148	SELL008	2024-09-19	\N	Shipped	41738.40
ORD00463	CUST0148	SELL057	2024-09-17	2024-09-23	Delivered	7172.97
ORD00464	CUST0148	SELL019	2024-10-11	\N	Cancelled	272309.74
ORD00465	CUST0148	SELL042	2024-09-11	\N	Returned	\N
ORD00466	CUST0148	SELL050	2024-07-30	\N	Cancelled	553086.42
ORD00467	CUST0149	SELL050	2024-03-15	\N	Returned	105688.91
ORD00468	CUST0149	SELL059	2024-06-11	2024-06-13	Delivered	231544.96
ORD00469	CUST0149	SELL021	2024-05-08	\N	Shipped	1256918.44
ORD00470	CUST0149	SELL030	2024-06-14	2024-06-19	Delivered	816829.96
ORD00471	CUST0150	SELL025	2024-10-15	2024-10-17	Delivered	167987.24
ORD00472	CUST0150	SELL070	2024-05-28	2024-05-29	Delivered	37254.90
ORD00473	CUST0150	SELL067	2023-09-29	\N	Returned	1368195.68
ORD00474	CUST0150	SELL083	2024-11-18	\N	Processing	234437.08
ORD00475	CUST0152	SELL079	2024-09-21	\N	Shipped	458822.98
ORD00476	CUST0152	SELL041	2024-05-01	\N	Processing	\N
ORD00477	CUST0152	SELL023	2024-06-29	2024-07-13	Delivered	117508.45
ORD00478	CUST0152	SELL080	2024-02-05	2024-02-16	Delivered	3149.21
ORD00479	CUST0152	SELL018	2024-06-28	2024-07-01	Delivered	\N
ORD00480	CUST0152	SELL086	2023-11-24	\N	Shipped	364494.60
ORD00481	CUST0152	SELL015	2024-10-25	2024-10-30	Delivered	924212.96
ORD00482	CUST0152	SELL067	2024-03-22	2024-03-29	Delivered	515180.54
ORD00483	CUST0153	SELL043	2024-12-08	\N	Returned	367051.46
ORD00484	CUST0153	SELL089	2024-12-10	2024-12-11	Delivered	508341.61
ORD00485	CUST0154	SELL034	2024-01-23	\N	Shipped	38184.64
ORD00486	CUST0154	SELL041	2023-12-30	\N	Processing	520184.35
ORD00487	CUST0154	SELL010	2024-03-17	\N	Processing	871926.90
ORD00488	CUST0156	SELL086	2024-11-17	\N	Processing	35488.70
ORD00489	CUST0156	SELL024	2024-12-16	\N	Shipped	5512.81
ORD00490	CUST0156	SELL050	2024-08-01	2024-08-05	Delivered	22192.46
ORD00491	CUST0156	SELL024	2024-10-13	\N	Cancelled	437038.04
ORD00492	CUST0156	SELL074	2024-07-15	\N	Shipped	1586657.86
ORD00493	CUST0156	SELL045	2024-08-21	2024-08-28	Delivered	118235.75
ORD00494	CUST0156	SELL011	2024-12-13	2024-12-22	Delivered	876039.35
ORD00495	CUST0156	SELL078	2024-09-09	\N	Returned	827921.76
ORD00496	CUST0157	SELL025	2024-09-08	2024-09-13	Delivered	\N
ORD00497	CUST0157	SELL052	2024-11-07	2024-11-14	Delivered	20993.04
ORD00498	CUST0157	SELL041	2024-12-13	2024-12-15	Delivered	82041.04
ORD00499	CUST0158	SELL024	2023-12-06	\N	Cancelled	795534.40
ORD00500	CUST0158	SELL021	2023-12-30	2024-01-03	Delivered	26343.44
ORD00501	CUST0158	SELL021	2024-06-01	2024-06-08	Delivered	354085.10
ORD00502	CUST0158	SELL067	2024-07-27	2024-07-29	Delivered	929593.33
ORD00503	CUST0158	SELL068	2023-11-21	\N	Cancelled	189251.98
ORD00504	CUST0158	SELL054	2023-10-22	2023-10-25	Delivered	200052.64
ORD00505	CUST0159	SELL074	2024-09-30	2024-10-03	Delivered	734614.02
ORD00506	CUST0159	SELL003	2023-12-30	2024-01-03	Delivered	108353.68
ORD00507	CUST0159	SELL060	2023-10-05	\N	Cancelled	769734.40
ORD00508	CUST0159	SELL047	2024-01-13	\N	Returned	616827.58
ORD00509	CUST0159	SELL041	2024-06-07	2024-06-10	Delivered	72047.64
ORD00510	CUST0161	SELL065	2024-05-29	\N	Cancelled	39819.28
ORD00511	CUST0161	SELL038	2024-07-21	2024-07-26	Delivered	3485.44
ORD00512	CUST0162	SELL077	2024-10-05	\N	Cancelled	102688.45
ORD00513	CUST0162	SELL017	2024-11-11	2024-11-16	Delivered	198883.60
ORD00514	CUST0162	SELL049	2024-11-23	2024-11-26	Delivered	235009.16
ORD00515	CUST0162	SELL042	2024-04-10	\N	Returned	40751.46
ORD00516	CUST0162	SELL021	2024-06-03	2024-06-08	Delivered	589959.06
ORD00517	CUST0162	SELL083	2024-12-28	2025-01-01	Delivered	168325.37
ORD00518	CUST0162	SELL088	2024-07-18	2024-07-24	Delivered	125685.71
ORD00519	CUST0162	SELL018	2024-06-10	\N	Shipped	436199.25
ORD00520	CUST0162	SELL090	2024-04-05	\N	Returned	463130.71
ORD00521	CUST0162	SELL075	2024-09-18	\N	Returned	820507.69
ORD00522	CUST0162	SELL026	2024-12-10	2024-12-17	Delivered	817839.94
ORD00523	CUST0162	SELL086	2024-04-07	2024-04-13	Delivered	180380.35
ORD00524	CUST0162	SELL039	2024-07-07	2024-07-12	Delivered	339418.37
ORD00525	CUST0163	SELL028	2024-09-01	2024-09-02	Delivered	841301.64
ORD00526	CUST0164	SELL037	2024-08-26	\N	Cancelled	\N
ORD00527	CUST0165	SELL073	2023-06-07	2023-06-15	Delivered	1380886.77
ORD00528	CUST0168	SELL088	2024-01-15	\N	Shipped	347417.94
ORD00529	CUST0169	SELL062	2024-01-05	2024-01-10	Delivered	27825.60
ORD00530	CUST0169	SELL060	2023-05-04	2023-05-08	Delivered	1120410.59
ORD00531	CUST0169	SELL004	2023-10-28	\N	Processing	53743.75
ORD00532	CUST0169	SELL056	2024-10-31	\N	Processing	147594.20
ORD00533	CUST0169	SELL070	2024-07-14	\N	Processing	220262.55
ORD00534	CUST0170	SELL048	2024-10-31	2024-11-04	Delivered	223383.08
ORD00535	CUST0170	SELL018	2024-11-13	2024-11-16	Delivered	193656.60
ORD00536	CUST0170	SELL044	2024-06-29	\N	Shipped	231412.15
ORD00537	CUST0170	SELL051	2024-07-20	\N	Processing	3385.48
ORD00538	CUST0171	SELL086	2023-12-21	2023-12-26	Delivered	451022.95
ORD00539	CUST0171	SELL053	2024-04-09	\N	Cancelled	211986.98
ORD00540	CUST0171	SELL065	2024-03-24	\N	Returned	1121118.77
ORD00541	CUST0171	SELL025	2024-11-09	2024-11-16	Delivered	768841.50
ORD00542	CUST0171	SELL058	2024-12-01	2024-12-04	Delivered	926660.16
ORD00543	CUST0172	SELL087	2024-11-25	\N	Cancelled	871730.60
ORD00544	CUST0172	SELL013	2024-09-27	\N	Processing	92772.76
ORD00545	CUST0173	SELL081	2024-11-13	2024-11-15	Delivered	240142.74
ORD00546	CUST0173	SELL053	2024-12-23	2024-12-28	Delivered	181459.05
ORD00547	CUST0174	SELL060	2024-11-08	\N	Cancelled	142340.25
ORD00548	CUST0174	SELL063	2024-12-11	2024-12-16	Delivered	13409.28
ORD00549	CUST0174	SELL088	2024-12-12	2024-12-13	Delivered	95430.98
ORD00550	CUST0174	SELL084	2024-11-28	\N	Processing	1408878.80
ORD00551	CUST0174	SELL015	2024-12-18	\N	Shipped	86284.48
ORD00552	CUST0174	SELL047	2024-12-10	2024-12-14	Delivered	1613502.06
ORD00553	CUST0174	SELL055	2024-12-01	\N	Cancelled	47284.02
ORD00554	CUST0174	SELL018	2024-12-04	2024-12-06	Delivered	160848.97
ORD00555	CUST0174	SELL070	2024-12-02	\N	Returned	10382.40
ORD00556	CUST0174	SELL015	2024-11-15	\N	Cancelled	\N
ORD00557	CUST0174	SELL002	2024-11-04	2024-11-09	Delivered	10095.25
ORD00558	CUST0175	SELL062	2024-04-26	\N	Shipped	\N
ORD00559	CUST0175	SELL010	2024-10-01	\N	Cancelled	181459.05
ORD00560	CUST0175	SELL010	2024-07-16	\N	Cancelled	43616.81
ORD00561	CUST0175	SELL051	2024-12-04	2024-12-11	Delivered	378503.96
ORD00562	CUST0175	SELL017	2024-03-09	\N	Returned	22672.78
ORD00563	CUST0175	SELL054	2024-12-14	2024-12-16	Delivered	65148.54
ORD00564	CUST0176	SELL044	2024-07-28	\N	Returned	50969.15
ORD00565	CUST0176	SELL050	2024-07-31	\N	Cancelled	132098.65
ORD00566	CUST0178	SELL030	2024-03-12	\N	Cancelled	203865.60
ORD00567	CUST0178	SELL067	2024-03-30	2024-04-02	Delivered	98560.00
ORD00568	CUST0178	SELL089	2023-10-11	\N	Processing	87090.70
ORD00569	CUST0178	SELL023	2024-09-06	\N	Cancelled	24006.66
ORD00570	CUST0178	SELL064	2024-05-01	2024-05-07	Delivered	43905.60
ORD00571	CUST0179	SELL033	2024-09-19	2024-09-22	Delivered	\N
ORD00572	CUST0179	SELL033	2024-08-11	\N	Processing	64819.73
ORD00573	CUST0181	SELL047	2024-05-31	2024-06-01	Delivered	1564948.01
ORD00574	CUST0181	SELL088	2024-05-19	\N	Shipped	324721.91
ORD00575	CUST0181	SELL030	2024-08-19	2024-08-21	Delivered	10095.25
ORD00576	CUST0182	SELL022	2024-06-07	\N	Processing	742960.79
ORD00577	CUST0182	SELL016	2024-04-20	\N	Processing	5457.04
ORD00578	CUST0183	SELL031	2024-01-27	2024-01-29	Delivered	146008.50
ORD00579	CUST0183	SELL057	2024-08-07	\N	Returned	567895.40
ORD00580	CUST0183	SELL056	2024-03-20	2024-03-29	Delivered	236830.69
ORD00581	CUST0183	SELL077	2024-01-12	2024-01-15	Delivered	109722.82
ORD00582	CUST0183	SELL049	2024-04-08	\N	Shipped	680096.85
ORD00583	CUST0183	SELL047	2023-07-08	2023-07-15	Delivered	32894.08
ORD00584	CUST0183	SELL030	2023-09-15	2023-09-22	Delivered	76881.64
ORD00585	CUST0183	SELL026	2024-11-26	\N	Cancelled	694979.34
ORD00586	CUST0185	SELL056	2024-11-10	2024-11-12	Delivered	359728.58
ORD00587	CUST0187	SELL055	2024-11-19	2024-11-28	Delivered	655577.48
ORD00588	CUST0187	SELL020	2024-12-14	\N	Returned	220496.44
ORD00589	CUST0187	SELL008	2024-10-30	\N	Cancelled	49202.47
ORD00590	CUST0187	SELL048	2024-11-27	\N	Processing	55149.16
ORD00591	CUST0188	SELL009	2024-09-28	\N	Processing	1283356.59
ORD00592	CUST0188	SELL046	2024-10-08	\N	Shipped	61637.76
ORD00593	CUST0188	SELL048	2024-05-05	2024-05-10	Delivered	76726.04
ORD00594	CUST0189	SELL019	2024-12-24	\N	Returned	207613.26
ORD00595	CUST0190	SELL060	2024-11-01	2024-11-10	Delivered	649434.60
ORD00596	CUST0190	SELL082	2024-10-31	\N	Shipped	1712169.09
ORD00597	CUST0190	SELL006	2024-12-04	\N	Cancelled	754309.18
ORD00598	CUST0190	SELL066	2024-12-10	2024-12-12	Delivered	17607.17
ORD00599	CUST0190	SELL037	2024-11-27	2024-12-04	Delivered	58703.25
ORD00600	CUST0190	SELL005	2024-12-01	2024-12-11	Delivered	771760.08
ORD00601	CUST0190	SELL019	2024-12-31	\N	Returned	114695.41
ORD00602	CUST0190	SELL002	2024-10-28	2024-11-03	Delivered	656811.71
ORD00603	CUST0192	SELL087	2024-11-20	2024-11-22	Delivered	78576.78
ORD00604	CUST0192	SELL034	2024-12-16	\N	Shipped	426564.74
ORD00605	CUST0192	SELL036	2024-12-23	\N	Cancelled	883743.02
ORD00606	CUST0192	SELL052	2024-12-17	\N	Shipped	59216.88
ORD00607	CUST0192	SELL029	2024-11-30	\N	Processing	327507.66
ORD00608	CUST0193	SELL085	2023-09-27	2023-10-01	Delivered	25829.99
ORD00609	CUST0194	SELL016	2023-04-12	2023-04-15	Delivered	18483.24
ORD00610	CUST0196	SELL022	2024-01-24	\N	Cancelled	500131.60
ORD00611	CUST0196	SELL002	2023-08-12	2023-08-18	Delivered	45102.28
ORD00612	CUST0196	SELL001	2023-10-22	\N	Shipped	890698.14
ORD00613	CUST0196	SELL012	2024-05-19	\N	Returned	52451.70
ORD00614	CUST0196	SELL079	2023-08-12	\N	Shipped	261576.42
ORD00615	CUST0196	SELL038	2024-10-03	2024-10-08	Delivered	803078.39
ORD00616	CUST0196	SELL090	2024-02-10	2024-02-17	Delivered	24990.69
ORD00617	CUST0197	SELL040	2024-07-03	2024-07-08	Delivered	21709.68
ORD00618	CUST0198	SELL027	2024-11-22	\N	Returned	30160.29
ORD00619	CUST0198	SELL017	2024-11-12	2024-11-16	Delivered	264786.66
ORD00620	CUST0198	SELL056	2024-12-10	2024-12-14	Delivered	191420.62
ORD00621	CUST0198	SELL033	2024-11-25	2024-11-26	Delivered	30284.60
ORD00622	CUST0198	SELL058	2024-12-18	\N	Processing	400105.28
ORD00623	CUST0198	SELL090	2024-12-21	\N	Cancelled	267729.96
ORD00624	CUST0198	SELL031	2024-11-24	2024-11-26	Delivered	45992.18
ORD00625	CUST0198	SELL079	2024-12-13	2024-12-16	Delivered	102447.74
ORD00626	CUST0198	SELL043	2024-12-05	2024-12-07	Delivered	85781.07
ORD00627	CUST0198	SELL026	2024-12-12	\N	Shipped	225136.60
ORD00628	CUST0198	SELL003	2024-12-02	2024-12-05	Delivered	1022886.92
ORD00629	CUST0198	SELL076	2024-11-17	\N	Shipped	24526.05
ORD00630	CUST0199	SELL001	2024-10-06	2024-10-09	Delivered	152795.70
ORD00631	CUST0199	SELL036	2024-01-22	\N	Processing	70104.98
ORD00632	CUST0199	SELL077	2024-11-06	\N	Processing	154519.40
ORD00633	CUST0199	SELL050	2024-04-13	\N	Shipped	469525.69
ORD00634	CUST0199	SELL003	2024-04-18	\N	Shipped	47233.84
ORD00635	CUST0199	SELL027	2024-07-14	2024-07-18	Delivered	204981.37
ORD00636	CUST0199	SELL001	2024-03-03	\N	Processing	1732506.27
ORD00637	CUST0199	SELL046	2024-10-24	2024-10-25	Delivered	918620.89
ORD00638	CUST0200	SELL021	2023-05-26	2023-06-03	Delivered	439020.25
ORD00639	CUST0200	SELL052	2024-06-07	2024-06-18	Delivered	274071.30
ORD00640	CUST0200	SELL030	2023-05-30	\N	Shipped	91238.43
ORD00641	CUST0202	SELL084	2024-12-03	\N	Shipped	119435.37
ORD00642	CUST0202	SELL072	2024-02-16	\N	Cancelled	209471.51
ORD00643	CUST0202	SELL069	2024-11-19	2024-11-22	Delivered	988437.53
ORD00644	CUST0203	SELL010	2024-09-05	\N	Processing	471432.66
ORD00645	CUST0203	SELL078	2024-07-15	\N	Shipped	40919.83
ORD00646	CUST0203	SELL024	2024-08-30	\N	Shipped	156879.65
ORD00647	CUST0203	SELL011	2024-12-20	\N	Cancelled	112087.69
ORD00648	CUST0203	SELL007	2024-11-25	2024-12-01	Delivered	167249.52
ORD00649	CUST0203	SELL034	2024-09-10	2024-09-11	Delivered	8700.29
ORD00650	CUST0203	SELL014	2024-11-02	\N	Returned	400115.34
ORD00651	CUST0203	SELL053	2024-12-01	\N	Cancelled	8834.25
ORD00652	CUST0203	SELL008	2024-07-28	2024-07-30	Delivered	534704.88
ORD00653	CUST0203	SELL037	2024-11-08	2024-11-13	Delivered	138579.52
ORD00654	CUST0203	SELL052	2024-06-10	\N	Shipped	78498.02
ORD00655	CUST0203	SELL006	2024-11-28	2024-12-04	Delivered	24463.34
ORD00656	CUST0203	SELL036	2024-07-14	\N	Shipped	1018515.34
ORD00657	CUST0204	SELL049	2024-01-04	\N	Shipped	35558.78
ORD00658	CUST0205	SELL056	2024-02-11	2024-02-17	Delivered	409790.96
ORD00659	CUST0205	SELL068	2023-08-08	\N	Returned	8757.97
ORD00660	CUST0205	SELL061	2024-03-20	2024-03-22	Delivered	872071.33
ORD00661	CUST0205	SELL050	2024-03-16	\N	Processing	10799.52
ORD00662	CUST0205	SELL050	2024-02-03	\N	Returned	17215.74
ORD00663	CUST0205	SELL035	2024-11-23	2024-11-26	Delivered	739180.57
ORD00664	CUST0206	SELL079	2024-10-26	\N	Shipped	808297.13
ORD00665	CUST0207	SELL001	2024-11-19	2024-11-26	Delivered	564791.35
ORD00666	CUST0207	SELL086	2024-12-22	2024-12-30	Delivered	286980.91
ORD00667	CUST0207	SELL069	2024-04-10	2024-04-15	Delivered	\N
ORD00668	CUST0207	SELL030	2023-07-19	2023-07-23	Delivered	1755792.32
ORD00669	CUST0209	SELL029	2024-08-31	2024-09-02	Delivered	130533.42
ORD00670	CUST0209	SELL058	2024-04-16	\N	Returned	434219.57
ORD00671	CUST0209	SELL036	2024-03-27	2024-04-02	Delivered	100327.02
ORD00672	CUST0209	SELL074	2024-08-08	\N	Cancelled	44547.39
ORD00673	CUST0209	SELL004	2024-09-04	\N	Returned	913252.80
ORD00674	CUST0209	SELL026	2024-03-04	\N	Processing	7038.57
ORD00675	CUST0209	SELL027	2024-02-01	2024-02-07	Delivered	78955.84
ORD00676	CUST0209	SELL022	2024-02-14	2024-02-15	Delivered	3568.70
ORD00677	CUST0209	SELL028	2024-01-19	2024-01-21	Delivered	2985.64
ORD00678	CUST0209	SELL072	2024-02-18	2024-02-23	Delivered	507804.25
ORD00679	CUST0209	SELL057	2024-10-02	\N	Processing	96102.05
ORD00680	CUST0209	SELL026	2024-12-24	\N	Processing	50013.11
ORD00681	CUST0210	SELL069	2024-10-22	2024-10-28	Delivered	178295.72
ORD00682	CUST0210	SELL066	2024-11-15	\N	Shipped	177386.77
ORD00683	CUST0210	SELL023	2024-11-27	\N	Cancelled	16447.04
ORD00684	CUST0210	SELL080	2024-10-27	\N	Cancelled	30149.21
ORD00685	CUST0211	SELL002	2024-01-08	2024-01-15	Delivered	1607599.10
ORD00686	CUST0211	SELL013	2024-06-03	\N	Shipped	179162.29
ORD00687	CUST0211	SELL065	2024-02-20	\N	Returned	43227.07
ORD00688	CUST0211	SELL062	2024-12-12	\N	Cancelled	2944.75
ORD00689	CUST0211	SELL006	2023-11-19	\N	Cancelled	1174.07
ORD00690	CUST0211	SELL001	2023-03-14	\N	Cancelled	115039.92
ORD00691	CUST0211	SELL052	2023-11-05	\N	Cancelled	70977.40
ORD00692	CUST0211	SELL048	2024-07-04	2024-07-07	Delivered	191405.76
ORD00693	CUST0211	SELL007	2023-03-09	\N	Returned	127071.80
ORD00694	CUST0211	SELL082	2023-02-14	\N	Processing	1913024.48
ORD00695	CUST0211	SELL001	2024-08-19	\N	Shipped	47233.84
ORD00696	CUST0211	SELL049	2023-10-09	\N	Cancelled	533791.17
ORD00697	CUST0212	SELL022	2024-12-25	\N	Returned	53290.52
ORD00698	CUST0212	SELL068	2024-04-19	2024-04-25	Delivered	112612.34
ORD00699	CUST0212	SELL050	2024-08-30	2024-09-05	Delivered	283877.97
ORD00700	CUST0212	SELL087	2024-09-06	\N	Processing	1924.96
ORD00701	CUST0213	SELL061	2023-12-03	\N	Returned	24750.33
ORD00702	CUST0213	SELL003	2024-08-19	\N	Cancelled	601488.25
ORD00703	CUST0213	SELL018	2024-05-09	\N	Returned	554853.60
ORD00704	CUST0213	SELL027	2024-04-19	2024-04-21	Delivered	526844.32
ORD00705	CUST0213	SELL016	2024-07-11	\N	Cancelled	242270.05
ORD00706	CUST0213	SELL042	2024-03-11	2024-03-17	Delivered	877534.55
ORD00707	CUST0213	SELL068	2024-06-17	\N	Processing	1523373.58
ORD00708	CUST0213	SELL068	2024-01-26	\N	Processing	474127.35
ORD00709	CUST0214	SELL088	2024-10-18	\N	Shipped	484168.90
ORD00710	CUST0214	SELL010	2024-10-25	2024-10-30	Delivered	32300.05
ORD00711	CUST0215	SELL053	2023-07-16	\N	Cancelled	221982.20
ORD00712	CUST0216	SELL010	2024-09-27	2024-10-01	Delivered	1018573.95
ORD00713	CUST0217	SELL044	2024-11-19	\N	Returned	14155.92
ORD00714	CUST0217	SELL013	2024-08-29	\N	Cancelled	\N
ORD00715	CUST0217	SELL008	2024-08-28	\N	Shipped	1098861.08
ORD00716	CUST0217	SELL059	2024-08-24	2024-08-30	Delivered	70228.44
ORD00717	CUST0217	SELL046	2024-10-22	\N	Shipped	65607.55
ORD00718	CUST0217	SELL063	2024-09-14	2024-09-21	Delivered	431300.41
ORD00719	CUST0217	SELL001	2024-09-16	2024-09-21	Delivered	361931.70
ORD00720	CUST0217	SELL028	2024-12-31	2025-01-01	Delivered	473129.95
ORD00721	CUST0217	SELL003	2024-11-20	2024-11-26	Delivered	1017025.87
ORD00722	CUST0217	SELL003	2024-10-31	2024-11-02	Delivered	569557.84
ORD00723	CUST0218	SELL085	2024-02-19	\N	Processing	6463.53
ORD00724	CUST0218	SELL075	2024-08-01	\N	Processing	48926.68
ORD00725	CUST0220	SELL025	2023-12-28	\N	Shipped	6831.72
ORD00726	CUST0220	SELL008	2024-08-25	2024-08-30	Delivered	537796.40
ORD00727	CUST0220	SELL004	2024-08-12	\N	Shipped	321528.06
ORD00728	CUST0220	SELL042	2024-11-25	\N	Cancelled	131397.02
ORD00729	CUST0220	SELL037	2023-06-29	\N	Processing	252555.02
ORD00730	CUST0220	SELL046	2023-11-09	2023-11-16	Delivered	89136.44
ORD00731	CUST0220	SELL010	2024-07-03	2024-07-09	Delivered	330791.24
ORD00732	CUST0220	SELL035	2023-10-13	2023-10-15	Delivered	41020.52
ORD00733	CUST0221	SELL006	2024-05-08	\N	Returned	\N
ORD00734	CUST0221	SELL015	2024-01-22	\N	Shipped	\N
ORD00735	CUST0221	SELL049	2024-01-03	2024-01-04	Delivered	260806.91
ORD00736	CUST0221	SELL023	2024-01-17	2024-01-24	Delivered	166699.15
ORD00737	CUST0221	SELL037	2024-08-30	2024-09-04	Delivered	1015740.44
ORD00738	CUST0221	SELL077	2024-07-18	\N	Returned	1352170.00
ORD00739	CUST0222	SELL050	2024-08-17	\N	Processing	2354575.73
ORD00740	CUST0222	SELL017	2024-01-13	2024-01-16	Delivered	\N
ORD00741	CUST0223	SELL001	2023-09-26	2023-09-28	Delivered	582824.76
ORD00742	CUST0223	SELL070	2024-05-04	2024-05-08	Delivered	122312.70
ORD00743	CUST0223	SELL076	2024-12-23	2024-12-26	Delivered	63585.10
ORD00744	CUST0223	SELL013	2024-07-23	2024-07-24	Delivered	1283879.52
ORD00745	CUST0223	SELL014	2023-09-26	2023-10-01	Delivered	\N
ORD00746	CUST0223	SELL014	2024-12-14	\N	Processing	77698.16
ORD00747	CUST0223	SELL088	2024-10-29	\N	Processing	144928.51
ORD00748	CUST0223	SELL041	2024-11-22	2024-11-28	Delivered	603998.75
ORD00749	CUST0223	SELL055	2024-12-22	\N	Returned	37906.68
ORD00750	CUST0223	SELL067	2024-02-10	\N	Shipped	657071.01
ORD00751	CUST0223	SELL045	2023-12-06	2023-12-12	Delivered	54346.36
ORD00752	CUST0223	SELL070	2024-06-22	2024-06-25	Delivered	462984.69
ORD00753	CUST0224	SELL072	2024-09-12	\N	Shipped	147735.75
ORD00754	CUST0224	SELL021	2024-08-18	\N	Processing	879031.83
ORD00755	CUST0225	SELL070	2023-10-13	\N	Returned	26072.32
ORD00756	CUST0225	SELL081	2024-11-05	\N	Cancelled	97722.81
ORD00757	CUST0225	SELL089	2024-07-23	2024-07-25	Delivered	63131.92
ORD00758	CUST0225	SELL085	2024-03-25	2024-04-04	Delivered	13409.28
ORD00759	CUST0227	SELL064	2024-12-03	\N	Cancelled	102551.30
ORD00760	CUST0227	SELL020	2024-12-04	\N	Returned	118506.89
ORD00761	CUST0227	SELL001	2024-12-13	2024-12-18	Delivered	359728.58
ORD00762	CUST0227	SELL047	2024-08-06	\N	Returned	135330.44
ORD00763	CUST0227	SELL044	2024-12-15	2024-12-21	Delivered	684591.89
ORD00764	CUST0228	SELL082	2024-10-24	\N	Returned	561051.96
ORD00765	CUST0228	SELL024	2024-12-27	\N	Shipped	92782.44
ORD00766	CUST0228	SELL029	2024-10-22	2024-10-27	Delivered	147425.86
ORD00767	CUST0228	SELL063	2024-11-16	2024-11-22	Delivered	169258.32
ORD00768	CUST0228	SELL029	2024-12-27	2024-12-30	Delivered	53790.15
ORD00769	CUST0228	SELL010	2024-12-05	\N	Processing	317300.85
ORD00770	CUST0228	SELL027	2024-10-05	2024-10-08	Delivered	17287.41
ORD00771	CUST0229	SELL047	2024-03-05	2024-03-07	Delivered	110258.32
ORD00772	CUST0229	SELL006	2024-08-27	\N	Processing	4038.10
ORD00773	CUST0229	SELL012	2024-03-06	2024-03-13	Delivered	66595.50
ORD00774	CUST0229	SELL068	2024-03-13	\N	Returned	1204441.38
ORD00775	CUST0229	SELL045	2024-09-30	\N	Cancelled	230562.48
ORD00776	CUST0229	SELL058	2024-11-04	\N	Cancelled	23283.14
ORD00777	CUST0231	SELL076	2024-12-22	\N	Returned	199004.09
ORD00778	CUST0231	SELL089	2023-10-16	\N	Shipped	500323.45
ORD00779	CUST0231	SELL076	2024-04-26	2024-04-28	Delivered	271470.00
ORD00780	CUST0231	SELL041	2023-10-13	\N	Processing	148614.93
ORD00781	CUST0231	SELL055	2024-01-11	\N	Returned	424197.66
ORD00782	CUST0231	SELL063	2024-07-13	2024-07-18	Delivered	30345.96
ORD00783	CUST0231	SELL038	2024-09-10	\N	Returned	160455.89
ORD00784	CUST0231	SELL037	2023-12-05	\N	Shipped	393692.05
ORD00785	CUST0231	SELL014	2024-12-24	\N	Processing	1398814.12
ORD00786	CUST0232	SELL002	2024-10-23	2024-10-31	Delivered	70957.82
ORD00787	CUST0232	SELL052	2024-06-28	\N	Processing	44449.74
ORD00788	CUST0232	SELL072	2024-08-07	2024-08-14	Delivered	71048.06
ORD00789	CUST0232	SELL066	2024-08-08	2024-08-11	Delivered	37830.93
ORD00790	CUST0233	SELL023	2024-09-20	\N	Returned	5352.06
ORD00791	CUST0233	SELL084	2024-10-15	\N	Shipped	984241.89
ORD00792	CUST0235	SELL055	2024-01-07	\N	Shipped	1428900.54
ORD00793	CUST0235	SELL032	2024-07-22	\N	Returned	555469.76
ORD00794	CUST0236	SELL064	2024-11-02	\N	Returned	\N
ORD00795	CUST0236	SELL074	2024-07-22	2024-07-25	Delivered	103294.81
ORD00796	CUST0236	SELL008	2024-06-11	2024-06-13	Delivered	51096.45
ORD00797	CUST0236	SELL042	2024-06-21	2024-06-28	Delivered	816.52
ORD00798	CUST0237	SELL051	2024-07-18	2024-07-25	Delivered	460779.85
ORD00799	CUST0237	SELL067	2024-12-15	\N	Shipped	82563.21
ORD00800	CUST0237	SELL051	2024-08-22	\N	Returned	\N
ORD00801	CUST0237	SELL009	2024-11-16	2024-11-25	Delivered	74516.28
ORD00802	CUST0238	SELL083	2024-12-04	2024-12-06	Delivered	1032680.62
ORD00803	CUST0238	SELL026	2024-12-31	2025-01-05	Delivered	643024.25
ORD00804	CUST0238	SELL020	2024-12-02	\N	Returned	110991.10
ORD00805	CUST0238	SELL085	2024-12-28	2025-01-04	Delivered	177974.85
ORD00806	CUST0238	SELL014	2024-12-06	2024-12-10	Delivered	8480.78
ORD00807	CUST0238	SELL085	2024-12-27	2024-12-30	Delivered	103538.61
ORD00808	CUST0238	SELL085	2024-12-20	2024-12-21	Delivered	87610.75
ORD00809	CUST0238	SELL037	2024-12-17	2024-12-18	Delivered	17694.90
ORD00810	CUST0242	SELL076	2024-07-10	\N	Processing	155979.39
ORD00811	CUST0244	SELL073	2024-12-12	\N	Returned	43862.96
ORD00812	CUST0244	SELL046	2024-12-08	2024-12-17	Delivered	194607.91
ORD00813	CUST0244	SELL020	2024-11-30	2024-12-04	Delivered	5416.29
ORD00814	CUST0244	SELL064	2024-12-09	2024-12-20	Delivered	246012.35
ORD00815	CUST0245	SELL053	2024-05-24	2024-05-26	Delivered	91572.30
ORD00816	CUST0245	SELL021	2024-05-30	2024-06-05	Delivered	60039.89
ORD00817	CUST0245	SELL064	2024-12-21	\N	Shipped	308380.38
ORD00818	CUST0245	SELL045	2024-10-01	\N	Returned	10476.40
ORD00819	CUST0245	SELL060	2024-12-04	2024-12-10	Delivered	397793.53
ORD00820	CUST0246	SELL071	2023-05-12	2023-05-20	Delivered	24825.96
ORD00821	CUST0246	SELL006	2024-08-15	2024-08-25	Delivered	142890.79
ORD00822	CUST0246	SELL008	2023-07-22	\N	Shipped	149126.89
ORD00823	CUST0247	SELL037	2024-02-20	2024-02-21	Delivered	33288.69
ORD00824	CUST0247	SELL026	2024-08-14	2024-08-20	Delivered	15571.78
ORD00825	CUST0248	SELL077	2024-06-09	2024-06-17	Delivered	\N
ORD00826	CUST0248	SELL026	2024-02-03	\N	Shipped	361665.18
ORD00827	CUST0248	SELL068	2024-01-09	2024-01-12	Delivered	29001.62
ORD00828	CUST0248	SELL043	2024-05-24	2024-05-30	Delivered	527527.80
ORD00829	CUST0249	SELL034	2024-10-23	2024-10-29	Delivered	576056.05
ORD00830	CUST0249	SELL006	2024-10-27	2024-10-29	Delivered	2248.73
ORD00831	CUST0249	SELL051	2024-12-21	\N	Shipped	28585.35
ORD00832	CUST0250	SELL038	2024-06-18	\N	Cancelled	2511.26
ORD00833	CUST0250	SELL032	2023-12-31	2024-01-06	Delivered	308147.91
ORD00834	CUST0250	SELL086	2024-11-22	\N	Shipped	183000.43
ORD00835	CUST0250	SELL085	2024-04-19	2024-04-27	Delivered	93330.92
ORD00836	CUST0250	SELL014	2024-09-07	\N	Processing	299320.66
ORD00837	CUST0250	SELL081	2024-10-23	\N	Processing	7685.53
ORD00838	CUST0251	SELL075	2024-12-14	\N	Cancelled	85884.09
ORD00839	CUST0251	SELL076	2024-12-20	\N	Cancelled	\N
ORD00840	CUST0252	SELL030	2024-11-09	\N	Cancelled	41722.67
ORD00841	CUST0252	SELL034	2024-03-18	\N	Processing	50533.44
ORD00842	CUST0252	SELL049	2024-05-18	\N	Processing	31300.16
ORD00843	CUST0252	SELL076	2024-10-28	\N	Returned	446216.60
ORD00844	CUST0252	SELL051	2024-10-31	2024-11-06	Delivered	\N
ORD00845	CUST0252	SELL012	2024-04-16	2024-04-23	Delivered	176253.29
ORD00846	CUST0252	SELL089	2024-05-16	2024-05-22	Delivered	325875.84
ORD00847	CUST0252	SELL085	2024-12-09	\N	Processing	135696.98
ORD00848	CUST0252	SELL049	2024-07-09	\N	Processing	73390.02
ORD00849	CUST0253	SELL057	2024-05-18	2024-05-21	Delivered	110640.11
ORD00850	CUST0254	SELL081	2024-10-27	\N	Processing	20392.27
ORD00851	CUST0254	SELL069	2024-04-27	2024-05-05	Delivered	570375.48
ORD00852	CUST0254	SELL068	2024-03-22	\N	Shipped	216605.55
ORD00853	CUST0254	SELL076	2024-02-11	2024-02-14	Delivered	545501.09
ORD00854	CUST0254	SELL006	2024-01-05	2024-01-10	Delivered	140041.10
ORD00855	CUST0254	SELL016	2024-06-07	2024-06-13	Delivered	48024.83
ORD00856	CUST0254	SELL061	2024-10-21	2024-10-24	Delivered	885861.21
ORD00857	CUST0254	SELL001	2024-11-22	2024-12-02	Delivered	120073.18
ORD00858	CUST0254	SELL080	2024-04-29	\N	Processing	51056.48
ORD00859	CUST0254	SELL080	2024-11-15	\N	Returned	119776.80
ORD00860	CUST0255	SELL041	2024-05-08	\N	Cancelled	392948.44
ORD00861	CUST0255	SELL047	2024-11-01	\N	Processing	2511.26
ORD00862	CUST0255	SELL008	2023-12-26	2024-01-09	Delivered	32819.40
ORD00863	CUST0255	SELL083	2024-04-24	2024-05-08	Delivered	20590.75
ORD00864	CUST0257	SELL084	2023-04-20	\N	Cancelled	183729.65
ORD00865	CUST0257	SELL088	2024-04-14	\N	Shipped	102185.35
ORD00866	CUST0258	SELL063	2024-09-18	\N	Processing	1206982.05
ORD00867	CUST0258	SELL078	2024-07-21	\N	Processing	23255.54
ORD00868	CUST0258	SELL017	2024-12-23	2024-12-27	Delivered	234388.12
ORD00869	CUST0258	SELL055	2024-06-15	2024-06-21	Delivered	179864.29
ORD00870	CUST0258	SELL055	2024-12-14	\N	Processing	\N
ORD00871	CUST0258	SELL012	2024-11-30	\N	Shipped	14377.20
ORD00872	CUST0258	SELL001	2024-09-09	\N	Shipped	679865.87
ORD00873	CUST0258	SELL017	2024-10-06	\N	Shipped	28922.62
ORD00874	CUST0258	SELL002	2024-09-01	2024-09-08	Delivered	135102.64
ORD00875	CUST0258	SELL033	2024-07-14	2024-07-19	Delivered	16199.28
ORD00876	CUST0258	SELL069	2024-10-30	\N	Returned	121165.30
ORD00877	CUST0259	SELL089	2024-09-22	2024-09-27	Delivered	104703.44
ORD00878	CUST0259	SELL044	2024-11-23	2024-11-27	Delivered	354205.42
ORD00879	CUST0259	SELL079	2024-11-02	\N	Processing	175604.14
ORD00880	CUST0259	SELL025	2024-10-02	2024-10-03	Delivered	552557.03
ORD00881	CUST0260	SELL006	2024-04-01	\N	Shipped	110269.71
ORD00882	CUST0260	SELL065	2023-10-23	2023-10-28	Delivered	109517.52
ORD00883	CUST0260	SELL066	2024-12-10	\N	Returned	14155.92
ORD00884	CUST0261	SELL036	2024-05-25	2024-05-29	Delivered	337069.86
ORD00885	CUST0261	SELL047	2024-09-11	2024-09-21	Delivered	183062.91
ORD00886	CUST0261	SELL019	2024-02-08	2024-02-11	Delivered	55373.35
ORD00887	CUST0261	SELL076	2024-10-18	\N	Cancelled	784342.05
ORD00888	CUST0261	SELL088	2024-07-19	2024-07-28	Delivered	15006.39
ORD00889	CUST0261	SELL049	2024-11-18	\N	Cancelled	369100.36
ORD00890	CUST0261	SELL020	2023-11-13	2023-11-16	Delivered	2057186.68
ORD00891	CUST0261	SELL002	2023-08-13	2023-08-16	Delivered	114528.20
ORD00892	CUST0262	SELL066	2024-05-10	\N	Shipped	328067.34
ORD00893	CUST0262	SELL037	2024-08-05	\N	Processing	85883.35
ORD00894	CUST0263	SELL007	2024-11-19	\N	Cancelled	57709.20
ORD00895	CUST0264	SELL003	2023-10-11	2023-10-16	Delivered	365253.79
ORD00896	CUST0265	SELL057	2024-11-17	\N	Cancelled	2724995.80
ORD00897	CUST0267	SELL012	2023-11-20	\N	Processing	1035554.73
ORD00898	CUST0267	SELL061	2024-09-14	2024-09-19	Delivered	364555.47
ORD00899	CUST0267	SELL038	2024-04-02	2024-04-04	Delivered	163247.70
ORD00900	CUST0267	SELL068	2024-09-30	2024-10-01	Delivered	14011.65
ORD00901	CUST0267	SELL088	2024-08-19	2024-08-24	Delivered	90584.94
ORD00902	CUST0268	SELL049	2024-11-14	2024-11-18	Delivered	24376.32
ORD00903	CUST0269	SELL067	2024-08-30	2024-09-05	Delivered	252137.68
ORD00904	CUST0269	SELL074	2024-06-01	\N	Processing	43142.24
ORD00905	CUST0269	SELL059	2024-10-08	2024-10-09	Delivered	38299.46
ORD00906	CUST0269	SELL087	2024-12-17	2024-12-22	Delivered	73288.78
ORD00907	CUST0272	SELL058	2024-12-25	\N	Cancelled	24526.05
ORD00908	CUST0272	SELL048	2024-12-30	2025-01-06	Delivered	1320381.28
ORD00909	CUST0272	SELL064	2024-11-08	2024-11-16	Delivered	1887115.40
ORD00910	CUST0272	SELL036	2024-12-18	2024-12-23	Delivered	731989.14
ORD00911	CUST0272	SELL063	2024-11-25	2024-11-29	Delivered	377173.89
ORD00912	CUST0272	SELL010	2024-11-07	\N	Shipped	14095.84
ORD00913	CUST0272	SELL008	2024-12-31	\N	Returned	44052.51
ORD00914	CUST0272	SELL085	2024-11-03	\N	Shipped	719457.16
ORD00915	CUST0273	SELL057	2024-12-28	\N	Processing	51810.86
ORD00916	CUST0273	SELL088	2024-11-23	2024-12-01	Delivered	14427.90
ORD00917	CUST0273	SELL074	2024-10-14	2024-10-25	Delivered	478987.84
ORD00918	CUST0273	SELL045	2024-09-23	2024-10-02	Delivered	71972.01
ORD00919	CUST0274	SELL066	2024-04-13	\N	Shipped	\N
ORD00920	CUST0274	SELL085	2024-08-26	\N	Processing	479176.61
ORD00921	CUST0274	SELL031	2024-08-30	2024-09-04	Delivered	72469.92
ORD00922	CUST0274	SELL056	2024-07-16	\N	Shipped	45102.28
ORD00923	CUST0275	SELL070	2024-08-12	\N	Shipped	346394.23
ORD00924	CUST0275	SELL070	2024-09-05	2024-09-07	Delivered	95695.43
ORD00925	CUST0275	SELL051	2024-08-25	\N	Returned	287086.29
ORD00926	CUST0275	SELL002	2024-06-26	2024-06-28	Delivered	134560.35
ORD00927	CUST0275	SELL086	2024-09-11	\N	Returned	473814.09
ORD00928	CUST0275	SELL007	2024-11-19	\N	Returned	192003.88
ORD00929	CUST0275	SELL090	2024-08-03	2024-08-06	Delivered	1580460.04
ORD00930	CUST0275	SELL090	2024-04-11	2024-04-15	Delivered	310936.87
ORD00931	CUST0275	SELL006	2024-09-26	2024-09-29	Delivered	291536.08
ORD00932	CUST0275	SELL030	2024-10-10	\N	Returned	1594874.68
ORD00933	CUST0275	SELL002	2024-07-25	\N	Shipped	6821.26
ORD00934	CUST0275	SELL055	2024-04-22	\N	Shipped	9207.08
ORD00935	CUST0276	SELL084	2024-09-22	\N	Shipped	513579.85
ORD00936	CUST0276	SELL088	2024-10-11	\N	Shipped	1368218.23
ORD00937	CUST0276	SELL074	2024-11-11	\N	Cancelled	1081736.00
ORD00938	CUST0277	SELL057	2023-10-02	2023-10-06	Delivered	1192178.97
ORD00939	CUST0277	SELL073	2024-03-13	\N	Returned	190714.01
ORD00940	CUST0277	SELL028	2024-01-10	2024-01-11	Delivered	21340.87
ORD00941	CUST0277	SELL051	2024-08-25	2024-08-27	Delivered	170268.12
ORD00942	CUST0277	SELL085	2023-10-04	\N	Returned	227473.76
ORD00943	CUST0277	SELL054	2023-09-12	\N	Returned	519702.92
ORD00944	CUST0277	SELL012	2024-04-07	2024-04-08	Delivered	12341.62
ORD00945	CUST0277	SELL043	2023-08-09	2023-08-15	Delivered	746747.97
ORD00946	CUST0277	SELL030	2024-06-17	2024-06-18	Delivered	945114.90
ORD00947	CUST0277	SELL089	2024-11-19	\N	Shipped	285781.38
ORD00948	CUST0278	SELL090	2023-05-08	2023-05-12	Delivered	\N
ORD00949	CUST0278	SELL065	2024-07-19	2024-07-20	Delivered	250844.04
ORD00950	CUST0278	SELL060	2024-03-17	\N	Cancelled	197983.95
ORD00951	CUST0280	SELL062	2024-08-19	\N	Shipped	775038.35
ORD00952	CUST0280	SELL066	2024-10-20	2024-10-22	Delivered	12278.28
ORD00953	CUST0280	SELL062	2024-06-29	2024-07-06	Delivered	632732.68
ORD00954	CUST0280	SELL030	2024-10-09	2024-10-16	Delivered	14845.55
ORD00955	CUST0280	SELL084	2024-09-26	\N	Shipped	215882.30
ORD00956	CUST0280	SELL026	2024-08-25	\N	Cancelled	648100.51
ORD00957	CUST0280	SELL017	2024-07-02	2024-07-04	Delivered	213274.88
ORD00958	CUST0280	SELL065	2024-12-09	\N	Processing	95695.43
ORD00959	CUST0280	SELL008	2024-05-25	\N	Returned	189891.12
ORD00960	CUST0280	SELL029	2024-10-21	2024-10-26	Delivered	266180.98
ORD00961	CUST0280	SELL088	2024-06-16	2024-06-23	Delivered	320608.15
ORD00962	CUST0280	SELL070	2024-07-27	\N	Processing	492647.20
ORD00963	CUST0281	SELL008	2024-03-17	2024-03-27	Delivered	387335.12
ORD00964	CUST0281	SELL006	2024-04-07	\N	Shipped	25528.24
ORD00965	CUST0281	SELL039	2024-03-04	2024-03-06	Delivered	100048.28
ORD00966	CUST0281	SELL078	2023-11-24	\N	Returned	570326.40
ORD00967	CUST0281	SELL050	2023-10-21	\N	Processing	6821.26
ORD00968	CUST0281	SELL086	2023-12-04	\N	Processing	153949.20
ORD00969	CUST0281	SELL066	2023-11-01	2023-11-11	Delivered	176857.47
ORD00970	CUST0281	SELL053	2024-08-28	\N	Cancelled	33292.29
ORD00971	CUST0281	SELL088	2024-07-17	\N	Cancelled	291412.38
ORD00972	CUST0281	SELL059	2024-11-12	2024-11-18	Delivered	1061481.88
ORD00973	CUST0282	SELL047	2023-10-09	\N	Returned	33898.73
ORD00974	CUST0282	SELL073	2024-08-23	\N	Shipped	187711.64
ORD00975	CUST0282	SELL082	2024-04-20	\N	Returned	249912.24
ORD00976	CUST0282	SELL035	2024-11-15	\N	Shipped	19169.60
ORD00977	CUST0285	SELL002	2024-03-31	2024-04-06	Delivered	36581.64
ORD00978	CUST0286	SELL058	2024-06-29	2024-07-06	Delivered	11097.43
ORD00979	CUST0288	SELL035	2024-11-30	\N	Shipped	106466.10
ORD00980	CUST0288	SELL075	2024-09-08	\N	Returned	443964.40
ORD00981	CUST0288	SELL028	2024-09-22	\N	Shipped	334715.64
ORD00982	CUST0288	SELL088	2024-07-07	2024-07-13	Delivered	67894.35
ORD00983	CUST0289	SELL027	2024-10-31	2024-11-02	Delivered	1602.14
ORD00984	CUST0289	SELL088	2024-07-24	2024-07-31	Delivered	1323987.05
ORD00985	CUST0290	SELL053	2023-04-17	\N	Returned	151154.98
ORD00986	CUST0290	SELL060	2024-02-17	2024-02-19	Delivered	13171.72
ORD00987	CUST0290	SELL020	2024-12-26	\N	Returned	2453030.18
ORD00988	CUST0290	SELL062	2023-04-17	\N	Shipped	1515860.19
ORD00989	CUST0290	SELL089	2024-01-25	2024-01-30	Delivered	62992.61
ORD00990	CUST0290	SELL045	2023-10-11	2023-10-14	Delivered	337561.86
ORD00991	CUST0290	SELL045	2024-07-31	\N	Processing	473129.95
ORD00992	CUST0290	SELL019	2023-10-27	\N	Shipped	19742.68
ORD00993	CUST0291	SELL047	2024-12-09	2024-12-12	Delivered	243429.47
ORD00994	CUST0291	SELL071	2024-12-01	2024-12-02	Delivered	556868.36
ORD00995	CUST0291	SELL071	2024-11-26	2024-12-02	Delivered	117897.53
ORD00996	CUST0292	SELL034	2024-09-13	\N	Shipped	117590.08
ORD00997	CUST0292	SELL089	2023-11-07	2023-11-09	Delivered	1067500.41
ORD00998	CUST0292	SELL086	2023-11-30	\N	Returned	1183040.92
ORD00999	CUST0292	SELL062	2024-07-28	2024-08-03	Delivered	734304.98
ORD01000	CUST0292	SELL030	2023-07-02	2023-07-05	Delivered	332153.37
ORD01001	CUST0292	SELL085	2024-11-27	\N	Processing	30282.75
ORD01002	CUST0292	SELL006	2024-04-04	\N	Processing	26617.40
ORD01003	CUST0293	SELL035	2024-02-26	2024-03-11	Delivered	\N
ORD01004	CUST0293	SELL049	2024-12-31	2025-01-14	Delivered	391595.61
ORD01005	CUST0293	SELL018	2023-04-16	2023-04-19	Delivered	50868.08
ORD01006	CUST0294	SELL085	2024-12-06	2024-12-12	Delivered	12650.30
ORD01007	CUST0294	SELL080	2024-11-19	\N	Shipped	17759.04
ORD01008	CUST0295	SELL030	2024-05-07	2024-05-16	Delivered	99842.46
ORD01009	CUST0296	SELL068	2024-10-02	\N	Returned	9547.40
ORD01010	CUST0296	SELL088	2024-08-30	\N	Shipped	\N
ORD01011	CUST0296	SELL066	2024-09-30	2024-10-01	Delivered	309288.39
ORD01012	CUST0296	SELL004	2024-12-05	2024-12-12	Delivered	137727.03
ORD01013	CUST0296	SELL001	2024-07-09	\N	Returned	24107.04
ORD01014	CUST0296	SELL074	2024-10-27	2024-10-30	Delivered	76142.09
ORD01015	CUST0297	SELL005	2023-05-16	2023-05-19	Delivered	40632.15
ORD01016	CUST0297	SELL050	2023-11-01	2023-11-07	Delivered	1018903.35
ORD01017	CUST0297	SELL076	2023-11-08	2023-11-11	Delivered	680880.78
ORD01018	CUST0298	SELL011	2024-03-16	2024-03-18	Delivered	467178.97
ORD01019	CUST0298	SELL029	2024-12-21	2024-12-24	Delivered	23990.67
ORD01020	CUST0298	SELL076	2024-02-02	2024-02-07	Delivered	66459.48
ORD01021	CUST0298	SELL035	2024-03-26	\N	Cancelled	\N
ORD01022	CUST0299	SELL086	2024-07-08	\N	Shipped	57794.83
ORD01023	CUST0299	SELL023	2024-11-02	2024-11-08	Delivered	5399.76
ORD01024	CUST0299	SELL081	2024-12-09	2024-12-12	Delivered	227279.12
ORD01025	CUST0299	SELL036	2024-07-22	2024-07-25	Delivered	26396.73
ORD01026	CUST0302	SELL015	2024-10-04	2024-10-11	Delivered	21604.29
ORD01027	CUST0302	SELL051	2024-12-31	\N	Returned	156709.08
ORD01028	CUST0302	SELL011	2024-11-11	\N	Shipped	788128.86
ORD01029	CUST0302	SELL070	2024-07-27	2024-07-29	Delivered	1316488.47
ORD01030	CUST0302	SELL025	2024-06-13	2024-06-15	Delivered	24006.66
ORD01031	CUST0303	SELL075	2024-03-27	\N	Returned	13196.11
ORD01032	CUST0304	SELL019	2024-09-04	\N	Returned	6516.61
ORD01033	CUST0304	SELL063	2023-10-22	\N	Returned	757102.92
ORD01034	CUST0304	SELL008	2023-12-22	\N	Processing	30581.49
ORD01035	CUST0304	SELL036	2024-10-28	\N	Cancelled	468002.78
ORD01036	CUST0304	SELL018	2024-09-29	2024-10-01	Delivered	75976.50
ORD01037	CUST0304	SELL030	2023-11-01	2023-11-02	Delivered	135063.48
ORD01038	CUST0304	SELL086	2024-09-16	\N	Returned	1365408.14
ORD01039	CUST0304	SELL008	2024-02-15	2024-02-21	Delivered	45557.08
ORD01040	CUST0304	SELL075	2023-12-04	\N	Shipped	48710.76
ORD01041	CUST0304	SELL070	2024-10-16	2024-10-18	Delivered	952072.75
ORD01042	CUST0304	SELL012	2024-12-19	\N	Processing	154950.88
ORD01043	CUST0305	SELL034	2024-05-03	\N	Shipped	36491.25
ORD01044	CUST0305	SELL053	2024-01-29	\N	Processing	353692.59
ORD01045	CUST0305	SELL020	2024-09-11	2024-09-21	Delivered	254267.42
ORD01046	CUST0306	SELL044	2024-12-16	\N	Processing	23540.85
ORD01047	CUST0306	SELL063	2024-10-21	\N	Shipped	36567.08
ORD01048	CUST0306	SELL012	2024-10-26	2024-10-27	Delivered	1229781.35
ORD01049	CUST0306	SELL063	2024-10-12	2024-10-13	Delivered	679049.30
ORD01050	CUST0306	SELL080	2024-12-17	\N	Shipped	66595.50
ORD01051	CUST0306	SELL023	2024-10-17	2024-10-19	Delivered	34973.36
ORD01052	CUST0307	SELL038	2024-10-21	2024-10-24	Delivered	58767.24
ORD01053	CUST0307	SELL076	2024-12-24	\N	Processing	1333503.85
ORD01054	CUST0307	SELL067	2024-09-30	2024-10-07	Delivered	1038425.47
ORD01055	CUST0308	SELL088	2024-08-15	\N	Processing	51659.98
ORD01056	CUST0308	SELL024	2024-04-14	\N	Cancelled	242664.04
ORD01057	CUST0308	SELL024	2024-06-14	2024-06-17	Delivered	42901.95
ORD01058	CUST0310	SELL011	2024-12-21	2024-12-26	Delivered	39168.98
ORD01059	CUST0310	SELL037	2024-12-26	2024-12-31	Delivered	407731.20
ORD01060	CUST0312	SELL060	2024-03-29	2024-04-03	Delivered	101388.10
ORD01061	CUST0312	SELL010	2023-12-07	2023-12-15	Delivered	118084.60
ORD01062	CUST0312	SELL027	2024-06-14	2024-06-19	Delivered	193997.28
ORD01063	CUST0312	SELL009	2024-08-31	\N	Processing	317128.75
ORD01064	CUST0313	SELL056	2024-11-23	\N	Cancelled	45651.79
ORD01065	CUST0313	SELL034	2024-09-17	\N	Cancelled	849393.93
ORD01066	CUST0313	SELL023	2024-08-20	2024-08-24	Delivered	57025.35
ORD01067	CUST0313	SELL050	2024-12-31	2025-01-06	Delivered	\N
ORD01068	CUST0314	SELL056	2024-12-19	2024-12-23	Delivered	931864.34
ORD01069	CUST0315	SELL037	2024-12-30	2024-12-31	Delivered	108201.85
ORD01070	CUST0316	SELL036	2024-11-06	\N	Shipped	136400.23
ORD01071	CUST0316	SELL056	2024-10-25	2024-10-30	Delivered	412524.16
ORD01072	CUST0316	SELL051	2024-10-23	2024-11-02	Delivered	26917.21
ORD01073	CUST0317	SELL031	2024-03-07	2024-03-12	Delivered	1464648.35
ORD01074	CUST0317	SELL073	2023-11-27	\N	Returned	2462814.31
ORD01075	CUST0317	SELL030	2024-08-24	\N	Shipped	687406.40
ORD01076	CUST0317	SELL053	2023-12-30	2024-01-03	Delivered	335910.17
ORD01077	CUST0317	SELL014	2024-12-21	2024-12-28	Delivered	515070.46
ORD01078	CUST0317	SELL078	2023-11-12	2023-11-14	Delivered	48285.65
ORD01079	CUST0318	SELL009	2024-09-10	\N	Returned	1346379.12
ORD01080	CUST0318	SELL048	2023-07-10	2023-07-16	Delivered	305515.78
ORD01081	CUST0318	SELL053	2023-10-04	2023-10-08	Delivered	4792.40
ORD01082	CUST0318	SELL070	2024-11-23	\N	Returned	128736.45
ORD01083	CUST0318	SELL049	2023-10-28	\N	Returned	\N
ORD01084	CUST0318	SELL013	2024-05-23	\N	Cancelled	12155.28
ORD01085	CUST0318	SELL021	2024-12-26	\N	Shipped	11386.20
ORD01086	CUST0318	SELL039	2023-06-05	\N	Processing	596785.81
ORD01087	CUST0320	SELL001	2024-12-20	2024-12-25	Delivered	44389.86
ORD01088	CUST0320	SELL010	2024-12-31	2025-01-03	Delivered	609401.78
ORD01089	CUST0320	SELL069	2024-12-20	\N	Returned	345294.13
ORD01090	CUST0320	SELL066	2024-12-05	\N	Returned	\N
ORD01091	CUST0321	SELL008	2024-09-14	\N	Cancelled	1924.96
ORD01092	CUST0322	SELL074	2024-03-05	2024-03-16	Delivered	1013423.02
ORD01093	CUST0323	SELL034	2024-11-05	\N	Returned	178790.22
ORD01094	CUST0324	SELL006	2024-06-28	2024-06-30	Delivered	87002.20
ORD01095	CUST0324	SELL003	2024-09-24	\N	Returned	441325.97
ORD01096	CUST0325	SELL065	2024-11-21	2024-11-24	Delivered	1139763.44
ORD01097	CUST0325	SELL055	2024-04-29	2024-05-05	Delivered	35488.70
ORD01098	CUST0326	SELL051	2024-03-18	2024-03-20	Delivered	182319.68
ORD01099	CUST0328	SELL079	2024-10-11	2024-10-19	Delivered	\N
ORD01100	CUST0329	SELL043	2024-07-03	\N	Cancelled	97086.56
ORD01101	CUST0329	SELL039	2024-08-19	2024-08-27	Delivered	199930.87
ORD01102	CUST0329	SELL030	2024-06-26	\N	Processing	143131.75
ORD01103	CUST0329	SELL022	2024-12-05	2024-12-08	Delivered	852463.48
ORD01104	CUST0329	SELL061	2024-06-19	\N	Shipped	53843.48
ORD01105	CUST0329	SELL070	2024-08-10	\N	Cancelled	331468.35
ORD01106	CUST0330	SELL013	2024-08-13	\N	Processing	319248.56
ORD01107	CUST0330	SELL068	2023-09-12	2023-09-15	Delivered	1144574.29
ORD01108	CUST0330	SELL046	2024-02-18	\N	Returned	49750.64
ORD01109	CUST0330	SELL074	2024-08-08	\N	Processing	94241.74
ORD01110	CUST0330	SELL068	2023-08-30	2023-09-03	Delivered	16739.67
ORD01111	CUST0331	SELL066	2024-07-08	2024-07-09	Delivered	141950.72
ORD01112	CUST0331	SELL037	2024-10-09	2024-10-10	Delivered	162894.00
ORD01113	CUST0331	SELL028	2024-09-04	2024-09-10	Delivered	120150.56
ORD01114	CUST0331	SELL049	2024-07-10	2024-07-17	Delivered	41341.72
ORD01115	CUST0331	SELL029	2024-06-08	\N	Shipped	7077.96
ORD01116	CUST0331	SELL056	2024-08-27	\N	Returned	102750.60
ORD01117	CUST0332	SELL077	2023-03-22	2023-04-02	Delivered	58514.20
ORD01118	CUST0332	SELL011	2024-01-27	2024-02-10	Delivered	52971.75
ORD01119	CUST0333	SELL039	2024-07-22	\N	Processing	51996.04
ORD01120	CUST0334	SELL074	2024-11-29	2024-12-05	Delivered	12460.22
ORD01121	CUST0334	SELL023	2024-11-05	\N	Cancelled	35864.85
ORD01122	CUST0334	SELL081	2024-08-04	\N	Shipped	98779.27
ORD01123	CUST0334	SELL075	2023-10-12	2023-10-15	Delivered	127390.86
ORD01124	CUST0334	SELL021	2024-05-12	\N	Processing	13921.15
ORD01125	CUST0334	SELL044	2023-09-16	2023-09-21	Delivered	343450.84
ORD01126	CUST0335	SELL044	2024-05-08	\N	Shipped	445519.58
ORD01127	CUST0335	SELL055	2024-06-19	2024-06-27	Delivered	291464.46
ORD01128	CUST0335	SELL060	2023-08-22	\N	Processing	567313.19
ORD01129	CUST0336	SELL061	2024-07-23	2024-07-28	Delivered	8016.63
ORD01130	CUST0338	SELL065	2024-11-07	\N	Processing	540650.06
ORD01131	CUST0338	SELL090	2024-08-31	2024-09-03	Delivered	349632.08
ORD01132	CUST0338	SELL077	2024-08-04	\N	Cancelled	283296.19
ORD01133	CUST0338	SELL070	2024-02-11	\N	Returned	13121.51
ORD01134	CUST0338	SELL012	2024-09-25	\N	Returned	164639.04
ORD01135	CUST0341	SELL006	2024-12-14	\N	Returned	78821.20
ORD01136	CUST0343	SELL032	2024-10-07	2024-10-10	Delivered	6230.11
ORD01137	CUST0343	SELL088	2024-05-02	\N	Processing	729035.92
ORD01138	CUST0343	SELL082	2024-07-10	2024-07-17	Delivered	940331.68
ORD01139	CUST0343	SELL063	2024-07-15	2024-07-17	Delivered	74632.08
ORD01140	CUST0343	SELL075	2024-08-13	2024-08-18	Delivered	36749.26
ORD01141	CUST0344	SELL089	2024-05-10	2024-05-13	Delivered	686857.19
ORD01142	CUST0344	SELL015	2024-12-28	2024-12-31	Delivered	247851.46
ORD01143	CUST0344	SELL071	2024-09-01	\N	Shipped	1072928.69
ORD01144	CUST0345	SELL046	2024-06-04	2024-06-10	Delivered	\N
ORD01145	CUST0345	SELL015	2023-09-04	\N	Cancelled	330684.40
ORD01146	CUST0345	SELL034	2024-10-05	2024-10-06	Delivered	\N
ORD01147	CUST0346	SELL001	2024-09-15	2024-09-19	Delivered	900.70
ORD01148	CUST0346	SELL035	2024-11-14	\N	Processing	5352.06
ORD01149	CUST0346	SELL083	2024-08-16	\N	Processing	24046.50
ORD01150	CUST0346	SELL070	2024-07-22	2024-07-28	Delivered	1255094.75
ORD01151	CUST0346	SELL024	2024-08-31	\N	Processing	16350.70
ORD01152	CUST0347	SELL049	2023-05-06	2023-05-09	Delivered	69170.64
ORD01153	CUST0347	SELL022	2024-04-26	2024-05-02	Delivered	16326.25
ORD01154	CUST0347	SELL054	2024-04-18	\N	Shipped	1310091.95
ORD01155	CUST0347	SELL064	2024-01-29	2024-01-30	Delivered	527944.80
ORD01156	CUST0347	SELL012	2024-06-29	2024-07-03	Delivered	481758.40
ORD01157	CUST0348	SELL066	2024-08-09	\N	Cancelled	1088533.32
ORD01158	CUST0349	SELL015	2024-12-02	\N	Returned	660221.58
ORD01159	CUST0349	SELL038	2024-11-25	\N	Processing	382139.74
ORD01160	CUST0349	SELL019	2024-12-01	\N	Processing	487249.66
ORD01161	CUST0349	SELL017	2024-12-12	2024-12-18	Delivered	75449.74
ORD01162	CUST0350	SELL089	2023-10-19	2023-10-26	Delivered	28971.39
ORD01163	CUST0350	SELL041	2023-10-05	2023-10-08	Delivered	\N
ORD01164	CUST0350	SELL066	2024-09-20	\N	Shipped	215427.32
ORD01165	CUST0350	SELL040	2024-04-24	\N	Cancelled	686918.06
ORD01166	CUST0350	SELL015	2023-09-26	\N	Shipped	101134.25
ORD01167	CUST0350	SELL026	2023-09-03	2023-09-13	Delivered	72583.62
ORD01168	CUST0350	SELL066	2024-01-01	\N	Cancelled	99199.56
ORD01169	CUST0350	SELL056	2024-05-08	2024-05-14	Delivered	171956.04
ORD01170	CUST0350	SELL088	2024-08-26	\N	Returned	\N
ORD01171	CUST0350	SELL052	2024-05-03	2024-05-09	Delivered	271932.37
ORD01172	CUST0350	SELL016	2024-05-28	\N	Shipped	11470.51
ORD01173	CUST0350	SELL081	2024-02-24	\N	Cancelled	34353.34
ORD01174	CUST0351	SELL074	2024-10-29	\N	Cancelled	1726285.36
ORD01175	CUST0351	SELL071	2024-01-01	\N	Shipped	75701.89
ORD01176	CUST0351	SELL088	2024-09-16	\N	Cancelled	7785.89
ORD01177	CUST0351	SELL011	2024-03-24	\N	Shipped	265248.35
ORD01178	CUST0352	SELL025	2024-01-04	\N	Shipped	1029403.72
ORD01179	CUST0352	SELL042	2024-05-18	2024-05-22	Delivered	15970.44
ORD01180	CUST0352	SELL007	2024-05-14	2024-05-16	Delivered	29611.68
ORD01181	CUST0352	SELL070	2024-12-07	2024-12-14	Delivered	169836.89
ORD01182	CUST0353	SELL065	2024-02-24	\N	Cancelled	154382.17
ORD01183	CUST0353	SELL003	2024-05-30	2024-06-03	Delivered	31522.68
ORD01184	CUST0353	SELL071	2024-11-19	\N	Shipped	\N
ORD01185	CUST0353	SELL008	2024-08-28	2024-08-29	Delivered	482209.15
ORD01186	CUST0353	SELL067	2024-03-21	2024-03-23	Delivered	15761.34
ORD01187	CUST0353	SELL073	2024-05-06	2024-05-08	Delivered	232908.60
ORD01188	CUST0353	SELL002	2024-11-05	\N	Returned	49398.49
ORD01189	CUST0353	SELL006	2024-06-18	2024-06-24	Delivered	509325.39
ORD01190	CUST0354	SELL040	2024-11-11	\N	Shipped	111871.28
ORD01191	CUST0355	SELL021	2024-11-18	\N	Cancelled	807200.55
ORD01192	CUST0355	SELL090	2024-11-13	\N	Shipped	107334.05
ORD01193	CUST0356	SELL035	2024-04-27	\N	Processing	95556.59
ORD01194	CUST0356	SELL066	2023-08-17	2023-08-20	Delivered	14427.90
ORD01195	CUST0356	SELL027	2024-01-17	\N	Processing	50601.20
ORD01196	CUST0357	SELL082	2024-04-27	2024-05-04	Delivered	80525.21
ORD01197	CUST0357	SELL085	2024-03-10	\N	Shipped	28419.53
ORD01198	CUST0357	SELL011	2024-06-10	\N	Cancelled	103880.12
ORD01199	CUST0358	SELL065	2024-08-16	\N	Processing	874450.51
ORD01200	CUST0358	SELL003	2024-05-10	2024-05-17	Delivered	33329.69
ORD01201	CUST0358	SELL048	2023-09-03	\N	Processing	13171.72
ORD01202	CUST0358	SELL007	2023-04-22	2023-04-26	Delivered	10088.47
ORD01203	CUST0358	SELL083	2023-07-03	\N	Returned	\N
ORD01204	CUST0359	SELL005	2024-11-03	2024-11-09	Delivered	271042.29
ORD01205	CUST0359	SELL081	2024-12-20	2024-12-23	Delivered	200327.57
ORD01206	CUST0359	SELL043	2024-12-26	\N	Processing	919080.41
ORD01207	CUST0361	SELL001	2024-04-11	\N	Cancelled	619079.90
ORD01208	CUST0361	SELL066	2024-03-24	2024-03-30	Delivered	2348.14
ORD01209	CUST0361	SELL076	2024-09-14	\N	Shipped	475610.24
ORD01210	CUST0361	SELL006	2024-05-23	2024-05-25	Delivered	88519.54
ORD01211	CUST0361	SELL071	2024-12-02	\N	Returned	255075.48
ORD01212	CUST0363	SELL018	2024-12-15	2024-12-22	Delivered	7077.96
ORD01213	CUST0363	SELL050	2024-04-15	\N	Cancelled	201351.65
ORD01214	CUST0363	SELL088	2024-04-14	\N	Processing	1363173.53
ORD01215	CUST0363	SELL019	2024-04-01	\N	Returned	149660.33
ORD01216	CUST0363	SELL001	2024-11-22	2024-11-23	Delivered	277797.81
ORD01217	CUST0363	SELL034	2024-11-17	\N	Returned	882156.73
ORD01218	CUST0365	SELL055	2024-08-22	\N	Shipped	1015642.67
ORD01219	CUST0366	SELL071	2024-06-08	\N	Returned	147534.54
ORD01220	CUST0366	SELL054	2023-11-16	\N	Shipped	59382.20
ORD01221	CUST0366	SELL016	2024-04-16	\N	Processing	43501.45
ORD01222	CUST0366	SELL010	2023-05-31	2023-06-07	Delivered	521312.75
ORD01223	CUST0366	SELL082	2024-02-12	2024-02-16	Delivered	14402.86
ORD01224	CUST0366	SELL056	2023-07-14	2023-07-17	Delivered	80161.95
ORD01225	CUST0366	SELL065	2024-05-23	2024-05-30	Delivered	506570.74
ORD01226	CUST0366	SELL008	2023-09-30	2023-10-06	Delivered	13862.43
ORD01227	CUST0366	SELL057	2023-02-23	\N	Processing	264786.66
ORD01228	CUST0367	SELL073	2024-02-25	2024-02-29	Delivered	94467.68
ORD01229	CUST0367	SELL024	2024-02-08	\N	Shipped	1365823.52
ORD01230	CUST0369	SELL027	2024-11-20	\N	Shipped	244411.45
ORD01231	CUST0369	SELL078	2024-11-27	\N	Processing	768841.50
ORD01232	CUST0369	SELL030	2024-10-29	\N	Cancelled	287086.29
ORD01233	CUST0369	SELL088	2024-10-17	\N	Processing	60835.63
ORD01234	CUST0370	SELL002	2024-12-16	2024-12-19	Delivered	88545.48
ORD01235	CUST0370	SELL060	2024-11-01	\N	Cancelled	536726.45
ORD01236	CUST0370	SELL031	2024-11-27	\N	Processing	150515.56
ORD01237	CUST0370	SELL024	2024-09-14	2024-09-16	Delivered	282271.60
ORD01238	CUST0370	SELL060	2024-09-11	2024-09-12	Delivered	125277.25
ORD01239	CUST0370	SELL070	2024-09-18	\N	Cancelled	10884.54
ORD01240	CUST0370	SELL023	2024-11-07	2024-11-10	Delivered	855219.84
ORD01241	CUST0370	SELL013	2024-12-08	\N	Cancelled	162812.75
ORD01242	CUST0370	SELL003	2024-12-20	\N	Shipped	\N
ORD01243	CUST0370	SELL024	2024-09-21	2024-09-25	Delivered	3204.28
ORD01244	CUST0371	SELL057	2024-04-09	2024-04-15	Delivered	184897.87
ORD01245	CUST0371	SELL042	2024-03-18	\N	Processing	332973.30
ORD01246	CUST0371	SELL078	2024-06-04	2024-06-09	Delivered	14402.86
ORD01247	CUST0371	SELL021	2024-05-30	\N	Processing	215521.34
ORD01248	CUST0371	SELL083	2024-08-29	2024-09-06	Delivered	\N
ORD01249	CUST0371	SELL076	2024-01-30	2024-02-04	Delivered	627213.66
ORD01250	CUST0372	SELL047	2023-08-02	2023-08-11	Delivered	1532854.95
ORD01251	CUST0375	SELL039	2024-11-27	\N	Processing	1488556.02
ORD01252	CUST0375	SELL032	2024-04-22	\N	Shipped	79623.58
ORD01253	CUST0375	SELL084	2024-01-13	\N	Processing	1199432.67
ORD01254	CUST0375	SELL029	2024-10-10	\N	Shipped	559798.45
ORD01255	CUST0375	SELL017	2024-01-18	\N	Cancelled	6563.88
ORD01256	CUST0375	SELL030	2024-07-28	\N	Shipped	46389.30
ORD01257	CUST0377	SELL079	2024-07-22	2024-07-29	Delivered	338489.64
ORD01258	CUST0377	SELL040	2024-04-13	2024-04-17	Delivered	67518.08
ORD01259	CUST0377	SELL073	2024-05-19	\N	Returned	18232.92
ORD01260	CUST0377	SELL058	2024-10-29	2024-11-02	Delivered	12699.55
ORD01261	CUST0377	SELL036	2024-07-26	2024-07-30	Delivered	98293.53
ORD01262	CUST0377	SELL080	2024-03-15	\N	Returned	18777.19
ORD01263	CUST0377	SELL041	2024-10-01	\N	Shipped	523651.34
ORD01264	CUST0378	SELL018	2024-03-26	2024-04-02	Delivered	95128.44
ORD01265	CUST0379	SELL060	2024-09-05	\N	Shipped	98197.51
ORD01266	CUST0379	SELL065	2024-03-08	2024-03-09	Delivered	127598.57
ORD01267	CUST0379	SELL062	2024-01-04	2024-01-09	Delivered	96202.74
ORD01268	CUST0379	SELL076	2024-04-30	\N	Processing	113014.76
ORD01269	CUST0381	SELL036	2024-01-12	\N	Shipped	18690.33
ORD01270	CUST0381	SELL068	2024-02-16	\N	Returned	12706.74
ORD01271	CUST0381	SELL062	2024-03-27	\N	Returned	45090.58
ORD01272	CUST0381	SELL022	2024-04-19	2024-04-24	Delivered	8028.09
ORD01273	CUST0381	SELL021	2024-06-11	2024-06-16	Delivered	60582.65
ORD01274	CUST0381	SELL085	2024-02-13	\N	Returned	168787.54
ORD01275	CUST0384	SELL074	2023-11-08	2023-11-13	Delivered	308912.61
ORD01276	CUST0384	SELL057	2024-03-10	2024-03-16	Delivered	73629.38
ORD01277	CUST0384	SELL047	2023-03-26	\N	Shipped	\N
ORD01278	CUST0384	SELL007	2023-09-26	\N	Cancelled	456855.44
ORD01279	CUST0384	SELL012	2023-12-03	\N	Processing	30345.96
ORD01280	CUST0385	SELL085	2024-07-31	2024-08-04	Delivered	\N
ORD01281	CUST0385	SELL008	2024-04-09	\N	Processing	37315.03
ORD01282	CUST0386	SELL030	2023-04-16	\N	Cancelled	347418.14
ORD01283	CUST0386	SELL087	2023-08-29	\N	Processing	180084.64
ORD01284	CUST0386	SELL012	2024-12-23	2024-12-29	Delivered	430462.89
ORD01285	CUST0386	SELL062	2024-05-02	\N	Cancelled	712325.89
ORD01286	CUST0386	SELL057	2024-03-14	2024-03-19	Delivered	63045.36
ORD01287	CUST0386	SELL006	2023-09-24	2023-09-26	Delivered	509055.94
ORD01288	CUST0386	SELL026	2024-06-12	\N	Processing	\N
ORD01289	CUST0386	SELL069	2024-04-02	\N	Processing	83437.72
ORD01290	CUST0386	SELL036	2024-10-24	\N	Cancelled	405537.54
ORD01291	CUST0386	SELL001	2023-04-13	\N	Shipped	101292.39
ORD01292	CUST0388	SELL076	2024-06-24	2024-07-01	Delivered	1759452.55
ORD01293	CUST0388	SELL083	2024-02-28	2024-03-06	Delivered	151263.40
ORD01294	CUST0389	SELL049	2024-08-24	2024-08-30	Delivered	13409.28
ORD01295	CUST0390	SELL030	2024-06-20	2024-06-28	Delivered	668077.43
ORD01296	CUST0390	SELL008	2024-11-12	\N	Cancelled	3329.98
ORD01297	CUST0391	SELL084	2024-06-04	2024-06-14	Delivered	1090050.21
ORD01298	CUST0391	SELL030	2024-06-07	\N	Shipped	51425.70
ORD01299	CUST0391	SELL003	2024-09-20	\N	Returned	159994.66
ORD01300	CUST0392	SELL079	2024-05-19	\N	Processing	32796.92
ORD01301	CUST0392	SELL043	2024-06-13	2024-06-20	Delivered	1343803.78
ORD01302	CUST0392	SELL090	2024-12-10	\N	Processing	24585.89
ORD01303	CUST0392	SELL086	2024-11-18	2024-11-19	Delivered	182439.52
ORD01304	CUST0392	SELL010	2024-10-10	2024-10-16	Delivered	44912.78
ORD01305	CUST0392	SELL052	2024-01-28	\N	Processing	919640.12
ORD01306	CUST0392	SELL069	2024-11-07	2024-11-12	Delivered	110900.42
ORD01307	CUST0392	SELL040	2023-12-31	\N	Cancelled	\N
ORD01308	CUST0392	SELL088	2024-12-18	\N	Cancelled	470493.77
ORD01309	CUST0392	SELL077	2024-07-29	2024-08-02	Delivered	\N
ORD01310	CUST0393	SELL030	2024-09-28	2024-10-01	Delivered	29570.18
ORD01311	CUST0393	SELL015	2023-06-20	2023-06-25	Delivered	217322.84
ORD01312	CUST0393	SELL044	2023-11-17	\N	Returned	\N
ORD01313	CUST0394	SELL020	2023-09-09	2023-09-14	Delivered	265518.94
ORD01314	CUST0394	SELL009	2024-11-17	2024-11-23	Delivered	68157.62
ORD01315	CUST0394	SELL038	2023-11-09	\N	Returned	913573.37
ORD01316	CUST0394	SELL024	2024-04-26	\N	Shipped	\N
ORD01317	CUST0394	SELL050	2023-09-07	\N	Returned	\N
ORD01318	CUST0394	SELL059	2024-01-15	\N	Cancelled	410863.88
ORD01319	CUST0394	SELL042	2024-02-09	2024-02-11	Delivered	261871.45
ORD01320	CUST0394	SELL038	2023-05-26	\N	Returned	211096.17
ORD01321	CUST0394	SELL059	2023-10-21	\N	Shipped	171956.04
ORD01322	CUST0394	SELL008	2024-08-19	2024-08-26	Delivered	49812.90
ORD01323	CUST0395	SELL089	2023-10-10	\N	Processing	191306.61
ORD01324	CUST0395	SELL011	2024-02-12	\N	Cancelled	118352.69
ORD01325	CUST0396	SELL066	2024-02-23	\N	Processing	289181.78
ORD01326	CUST0396	SELL053	2024-06-02	2024-06-10	Delivered	90042.32
ORD01327	CUST0396	SELL078	2024-07-06	\N	Processing	31091.23
ORD01328	CUST0396	SELL086	2024-09-28	\N	Shipped	756460.81
ORD01329	CUST0396	SELL051	2023-09-29	2023-10-07	Delivered	53108.20
ORD01330	CUST0396	SELL076	2024-05-08	2024-05-12	Delivered	\N
ORD01331	CUST0398	SELL033	2023-05-24	2023-05-30	Delivered	117469.19
ORD01332	CUST0398	SELL025	2023-12-02	\N	Cancelled	1039365.35
ORD01333	CUST0398	SELL019	2024-08-31	\N	Shipped	380265.64
ORD01334	CUST0398	SELL064	2023-05-29	2023-06-10	Delivered	3849.92
ORD01335	CUST0398	SELL086	2024-11-15	2024-11-23	Delivered	\N
ORD01336	CUST0398	SELL030	2023-10-13	2023-10-18	Delivered	47472.78
ORD01337	CUST0399	SELL014	2024-10-19	\N	Shipped	65577.92
ORD01338	CUST0399	SELL005	2024-08-15	\N	Shipped	124747.54
ORD01339	CUST0400	SELL001	2024-02-01	\N	Returned	167569.26
ORD01340	CUST0400	SELL084	2023-10-29	\N	Processing	244771.48
ORD01341	CUST0400	SELL062	2023-08-08	\N	Returned	11683.06
ORD01342	CUST0400	SELL010	2023-12-13	\N	Returned	1107572.50
ORD01343	CUST0401	SELL080	2024-11-27	\N	Returned	1178247.54
ORD01344	CUST0401	SELL040	2024-11-29	\N	Processing	\N
ORD01345	CUST0401	SELL057	2024-12-05	2024-12-06	Delivered	60942.63
ORD01346	CUST0401	SELL078	2024-12-18	2024-12-19	Delivered	5755.30
ORD01347	CUST0402	SELL031	2024-04-21	2024-04-27	Delivered	408079.72
ORD01348	CUST0402	SELL045	2024-04-18	\N	Cancelled	14461.31
ORD01349	CUST0402	SELL080	2024-01-13	2024-01-20	Delivered	103986.26
ORD01350	CUST0402	SELL061	2024-06-02	2024-06-06	Delivered	9207.08
ORD01351	CUST0402	SELL041	2023-05-04	\N	Returned	646899.17
ORD01352	CUST0402	SELL076	2023-05-16	\N	Returned	160848.97
ORD01353	CUST0403	SELL081	2024-11-02	2024-11-05	Delivered	2149209.07
ORD01354	CUST0403	SELL077	2024-08-06	2024-08-10	Delivered	324717.30
ORD01355	CUST0403	SELL078	2024-05-05	2024-05-07	Delivered	1317086.90
ORD01356	CUST0403	SELL006	2024-09-27	\N	Shipped	1144891.00
ORD01357	CUST0403	SELL037	2024-12-11	\N	Shipped	189703.99
ORD01358	CUST0403	SELL044	2024-07-15	\N	Cancelled	\N
ORD01359	CUST0404	SELL088	2024-04-24	2024-04-28	Delivered	135696.91
ORD01360	CUST0404	SELL047	2024-04-11	2024-04-14	Delivered	528191.14
ORD01361	CUST0404	SELL080	2024-09-03	2024-09-04	Delivered	100004.00
ORD01362	CUST0404	SELL024	2024-06-14	\N	Processing	9954.82
ORD01363	CUST0405	SELL039	2024-02-27	\N	Returned	378503.96
ORD01364	CUST0407	SELL007	2024-08-27	2024-09-03	Delivered	888627.76
ORD01365	CUST0407	SELL068	2023-12-11	2023-12-15	Delivered	191900.83
ORD01366	CUST0407	SELL008	2024-02-05	\N	Shipped	506720.90
ORD01367	CUST0407	SELL048	2024-11-23	2024-12-02	Delivered	289357.03
ORD01368	CUST0407	SELL056	2024-06-24	2024-07-04	Delivered	18080.28
ORD01369	CUST0407	SELL033	2024-05-06	\N	Returned	1446072.43
ORD01370	CUST0407	SELL016	2024-05-23	2024-05-26	Delivered	154882.11
ORD01371	CUST0407	SELL051	2024-04-29	\N	Processing	905535.81
ORD01372	CUST0408	SELL018	2024-06-01	2024-06-05	Delivered	7092.62
ORD01373	CUST0409	SELL052	2024-11-25	\N	Shipped	344086.23
ORD01374	CUST0409	SELL048	2024-12-06	2024-12-07	Delivered	1027134.30
ORD01375	CUST0409	SELL023	2024-12-15	2024-12-17	Delivered	515070.46
ORD01376	CUST0409	SELL008	2024-11-28	\N	Cancelled	257485.66
ORD01377	CUST0409	SELL011	2024-11-30	2024-12-06	Delivered	41043.57
ORD01378	CUST0409	SELL071	2024-11-21	\N	Shipped	509664.00
ORD01379	CUST0410	SELL048	2024-11-10	\N	Shipped	787954.12
ORD01380	CUST0410	SELL032	2023-07-29	\N	Cancelled	1962716.00
ORD01381	CUST0410	SELL078	2023-09-24	\N	Returned	336301.78
ORD01382	CUST0410	SELL072	2024-01-20	2024-01-27	Delivered	336920.80
ORD01383	CUST0411	SELL021	2024-05-16	\N	Cancelled	23540.85
ORD01384	CUST0411	SELL003	2024-05-17	\N	Returned	1123765.76
ORD01385	CUST0412	SELL039	2024-02-23	2024-02-25	Delivered	604011.00
ORD01386	CUST0412	SELL043	2024-03-16	\N	Processing	240474.84
ORD01387	CUST0412	SELL029	2024-08-17	2024-08-22	Delivered	409790.96
ORD01388	CUST0412	SELL024	2024-01-21	\N	Returned	228846.48
ORD01389	CUST0412	SELL065	2023-11-11	2023-11-17	Delivered	499557.85
ORD01390	CUST0412	SELL072	2024-11-17	2024-11-19	Delivered	64814.68
ORD01391	CUST0412	SELL039	2024-03-12	2024-03-17	Delivered	3628.18
ORD01392	CUST0413	SELL017	2024-07-30	\N	Returned	1450724.24
ORD01393	CUST0413	SELL056	2024-12-16	\N	Shipped	622605.57
ORD01394	CUST0413	SELL034	2024-09-22	\N	Shipped	946234.05
ORD01395	CUST0413	SELL090	2024-06-19	\N	Shipped	49739.73
ORD01396	CUST0414	SELL041	2024-11-07	\N	Cancelled	723338.14
ORD01397	CUST0414	SELL033	2024-11-08	2024-11-13	Delivered	407337.51
ORD01398	CUST0414	SELL090	2024-06-29	2024-06-30	Delivered	24825.96
ORD01399	CUST0414	SELL076	2024-12-12	2024-12-14	Delivered	1042211.85
ORD01400	CUST0415	SELL017	2024-09-13	\N	Shipped	4535.45
ORD01401	CUST0415	SELL038	2024-12-25	\N	Shipped	2944.75
ORD01402	CUST0415	SELL033	2024-09-28	\N	Returned	90045.30
ORD01403	CUST0416	SELL042	2024-09-09	2024-09-15	Delivered	92706.45
ORD01404	CUST0416	SELL080	2024-04-09	\N	Shipped	\N
ORD01405	CUST0416	SELL001	2023-10-30	2023-11-01	Delivered	305798.40
ORD01406	CUST0416	SELL043	2024-09-25	\N	Shipped	\N
ORD01407	CUST0417	SELL036	2024-09-24	2024-09-28	Delivered	104826.28
ORD01408	CUST0417	SELL068	2024-12-11	\N	Processing	1940456.15
ORD01409	CUST0418	SELL066	2024-12-25	2024-12-28	Delivered	9563.86
ORD01410	CUST0418	SELL069	2024-01-22	\N	Cancelled	369171.32
ORD01411	CUST0418	SELL020	2024-08-24	2024-08-30	Delivered	505004.26
ORD01412	CUST0418	SELL036	2023-10-26	\N	Shipped	703636.90
ORD01413	CUST0418	SELL074	2024-06-15	\N	Processing	205073.54
ORD01414	CUST0418	SELL006	2024-07-06	2024-07-13	Delivered	207598.77
ORD01415	CUST0418	SELL064	2023-10-18	\N	Cancelled	18247.68
ORD01416	CUST0418	SELL001	2024-07-17	2024-07-25	Delivered	15970.44
ORD01417	CUST0419	SELL077	2023-09-04	2023-09-09	Delivered	602922.95
ORD01418	CUST0419	SELL061	2024-08-27	\N	Returned	2431.72
ORD01419	CUST0419	SELL009	2023-09-28	\N	Returned	30229.10
ORD01420	CUST0419	SELL041	2023-10-14	\N	Processing	42820.06
ORD01421	CUST0419	SELL004	2024-01-15	2024-01-19	Delivered	267736.80
ORD01422	CUST0419	SELL057	2024-11-13	2024-11-20	Delivered	409790.96
ORD01423	CUST0421	SELL068	2024-04-18	2024-04-25	Delivered	69992.67
ORD01424	CUST0421	SELL071	2024-07-25	2024-07-30	Delivered	504390.28
ORD01425	CUST0421	SELL016	2024-01-31	\N	Returned	587875.86
ORD01426	CUST0421	SELL055	2024-07-30	2024-08-05	Delivered	14239.20
ORD01427	CUST0421	SELL036	2024-09-18	\N	Shipped	506311.33
ORD01428	CUST0421	SELL070	2024-08-09	\N	Cancelled	86690.40
ORD01429	CUST0421	SELL008	2023-11-13	2023-11-18	Delivered	201503.45
ORD01430	CUST0421	SELL027	2024-01-04	2024-01-09	Delivered	52539.60
ORD01431	CUST0422	SELL031	2024-05-04	2024-05-09	Delivered	58923.21
ORD01432	CUST0422	SELL070	2024-06-08	\N	Shipped	48285.65
ORD01433	CUST0422	SELL066	2024-10-07	\N	Processing	1061234.59
ORD01434	CUST0422	SELL076	2023-11-08	2023-11-13	Delivered	199354.44
ORD01435	CUST0422	SELL085	2024-12-21	\N	Processing	10621.64
ORD01436	CUST0422	SELL066	2024-04-04	2024-04-14	Delivered	63394.81
ORD01437	CUST0422	SELL013	2024-10-15	2024-10-21	Delivered	278279.64
ORD01438	CUST0423	SELL068	2023-12-02	2023-12-05	Delivered	57981.42
ORD01439	CUST0423	SELL014	2024-08-02	\N	Cancelled	569468.31
ORD01440	CUST0424	SELL051	2024-09-12	\N	Returned	2241418.11
ORD01441	CUST0424	SELL081	2024-06-10	2024-06-16	Delivered	74245.65
ORD01442	CUST0425	SELL030	2024-03-05	\N	Shipped	65303.75
ORD01443	CUST0425	SELL064	2024-08-03	2024-08-10	Delivered	326360.99
ORD01444	CUST0425	SELL086	2024-05-14	\N	Cancelled	18540.60
ORD01445	CUST0426	SELL018	2024-12-10	2024-12-12	Delivered	164719.61
ORD01446	CUST0426	SELL030	2024-11-14	2024-11-19	Delivered	22051.24
ORD01447	CUST0426	SELL081	2024-06-20	\N	Cancelled	46165.13
ORD01448	CUST0427	SELL016	2023-11-09	2023-11-15	Delivered	130265.75
ORD01449	CUST0427	SELL079	2024-11-25	2024-12-01	Delivered	695495.94
ORD01450	CUST0427	SELL013	2023-08-10	2023-08-16	Delivered	276291.22
ORD01451	CUST0427	SELL050	2023-11-29	\N	Returned	1311860.43
ORD01452	CUST0427	SELL076	2023-12-13	2023-12-15	Delivered	129981.66
ORD01453	CUST0427	SELL082	2023-07-27	2023-08-03	Delivered	1281402.50
ORD01454	CUST0428	SELL025	2024-12-06	\N	Cancelled	39662.61
ORD01455	CUST0428	SELL001	2024-12-25	2024-12-26	Delivered	103319.96
ORD01456	CUST0428	SELL017	2024-12-01	2024-12-08	Delivered	437118.57
ORD01457	CUST0428	SELL027	2024-12-03	\N	Shipped	68557.15
ORD01458	CUST0429	SELL082	2024-11-04	2024-11-06	Delivered	11561.20
ORD01459	CUST0429	SELL045	2024-03-19	2024-03-26	Delivered	85496.84
ORD01460	CUST0429	SELL049	2024-05-31	2024-06-07	Delivered	358922.60
ORD01461	CUST0429	SELL083	2024-06-25	\N	Returned	287086.29
ORD01462	CUST0429	SELL049	2024-03-28	2024-04-01	Delivered	842568.75
ORD01463	CUST0429	SELL027	2024-06-18	2024-06-24	Delivered	169891.58
ORD01464	CUST0430	SELL030	2024-08-09	2024-08-14	Delivered	337069.86
ORD01465	CUST0430	SELL038	2024-08-30	2024-09-08	Delivered	155573.74
ORD01466	CUST0430	SELL060	2024-12-04	\N	Cancelled	\N
ORD01467	CUST0432	SELL056	2024-10-16	2024-10-22	Delivered	555466.70
ORD01468	CUST0433	SELL011	2024-12-17	\N	Shipped	97722.81
ORD01469	CUST0433	SELL053	2024-08-11	2024-08-16	Delivered	31709.48
ORD01470	CUST0434	SELL052	2024-11-12	\N	Cancelled	34293.40
ORD01471	CUST0434	SELL084	2024-11-13	2024-11-18	Delivered	173260.79
ORD01472	CUST0434	SELL005	2024-12-27	2024-12-31	Delivered	110269.71
ORD01473	CUST0435	SELL003	2024-02-14	\N	Shipped	42328.70
ORD01474	CUST0435	SELL005	2023-04-04	2023-04-14	Delivered	772605.69
ORD01475	CUST0435	SELL055	2023-07-31	2023-08-09	Delivered	296286.45
ORD01476	CUST0435	SELL023	2024-10-29	2024-11-11	Delivered	49605.18
ORD01477	CUST0435	SELL010	2024-11-25	\N	Processing	292254.69
ORD01478	CUST0436	SELL047	2024-11-13	\N	Returned	24802.59
ORD01479	CUST0436	SELL043	2024-12-15	\N	Cancelled	351681.26
ORD01480	CUST0437	SELL055	2024-07-20	\N	Cancelled	229462.18
ORD01481	CUST0437	SELL032	2024-12-13	\N	Shipped	51526.03
ORD01482	CUST0437	SELL030	2024-08-21	2024-08-25	Delivered	32529.36
ORD01483	CUST0437	SELL073	2024-09-12	2024-09-15	Delivered	76292.93
ORD01484	CUST0437	SELL035	2024-09-19	2024-09-20	Delivered	628381.84
ORD01485	CUST0438	SELL051	2024-06-20	\N	Shipped	125806.75
ORD01486	CUST0439	SELL074	2024-08-03	\N	Processing	294670.24
ORD01487	CUST0439	SELL020	2024-10-09	2024-10-14	Delivered	442560.44
ORD01488	CUST0439	SELL054	2024-12-14	\N	Returned	932741.10
ORD01489	CUST0439	SELL051	2024-10-15	\N	Processing	145263.16
ORD01490	CUST0439	SELL010	2024-11-18	\N	Processing	168765.99
ORD01491	CUST0440	SELL012	2024-11-17	\N	Returned	994838.80
ORD01492	CUST0440	SELL001	2024-11-29	2024-12-03	Delivered	114532.41
ORD01493	CUST0440	SELL037	2024-11-18	2024-11-21	Delivered	573477.05
ORD01494	CUST0441	SELL019	2024-06-03	\N	Returned	385410.72
ORD01495	CUST0441	SELL075	2023-10-27	2023-11-02	Delivered	1042351.76
ORD01496	CUST0442	SELL073	2024-06-20	\N	Returned	32591.54
ORD01497	CUST0443	SELL005	2024-10-26	\N	Cancelled	29196.20
ORD01498	CUST0444	SELL032	2023-09-29	2023-10-05	Delivered	243727.04
ORD01499	CUST0444	SELL054	2024-03-09	2024-03-15	Delivered	180153.97
ORD01500	CUST0444	SELL010	2024-03-02	2024-03-03	Delivered	420883.00
ORD01501	CUST0445	SELL011	2024-11-18	\N	Returned	1159391.80
ORD01502	CUST0445	SELL052	2024-05-25	\N	Shipped	1001521.90
ORD01503	CUST0445	SELL020	2024-02-25	2024-02-28	Delivered	651736.73
ORD01504	CUST0445	SELL049	2023-07-05	2023-07-10	Delivered	407731.20
ORD01505	CUST0445	SELL015	2023-06-21	\N	Processing	25905.43
ORD01506	CUST0446	SELL039	2023-07-09	\N	Shipped	327218.95
ORD01507	CUST0446	SELL090	2024-04-24	2024-05-03	Delivered	93330.92
ORD01508	CUST0446	SELL025	2024-11-06	2024-11-14	Delivered	68942.67
ORD01509	CUST0446	SELL022	2024-07-15	2024-07-21	Delivered	18117.48
ORD01510	CUST0446	SELL011	2023-09-08	\N	Returned	443026.21
ORD01511	CUST0446	SELL023	2024-06-09	2024-06-16	Delivered	804733.40
ORD01512	CUST0448	SELL079	2024-09-20	\N	Cancelled	2721.27
ORD01513	CUST0448	SELL077	2024-08-12	\N	Cancelled	253935.11
ORD01514	CUST0448	SELL044	2024-10-13	\N	Returned	58964.00
ORD01515	CUST0448	SELL024	2024-02-09	\N	Processing	57376.80
ORD01516	CUST0449	SELL002	2023-06-09	2023-06-16	Delivered	716689.83
ORD01517	CUST0449	SELL054	2024-06-04	\N	Cancelled	86508.56
ORD01518	CUST0449	SELL013	2024-02-16	\N	Shipped	37123.11
ORD01519	CUST0450	SELL085	2024-10-08	\N	Processing	25399.10
ORD01520	CUST0450	SELL036	2024-06-30	2024-07-11	Delivered	32412.37
ORD01521	CUST0450	SELL012	2024-09-11	2024-09-18	Delivered	61852.40
ORD01522	CUST0450	SELL014	2024-10-19	\N	Shipped	970312.13
ORD01523	CUST0451	SELL068	2023-12-28	\N	Processing	120043.30
ORD01524	CUST0451	SELL072	2024-07-15	\N	Shipped	381487.47
ORD01525	CUST0451	SELL079	2024-06-14	2024-06-15	Delivered	152620.50
ORD01526	CUST0451	SELL053	2024-04-06	2024-04-11	Delivered	1741171.42
ORD01527	CUST0451	SELL045	2024-02-26	2024-02-28	Delivered	1506030.00
ORD01528	CUST0451	SELL085	2023-12-09	2023-12-16	Delivered	\N
ORD01529	CUST0451	SELL045	2024-06-16	\N	Cancelled	1725784.12
ORD01530	CUST0451	SELL007	2024-09-25	\N	Cancelled	311634.75
ORD01531	CUST0452	SELL059	2023-08-12	2023-08-16	Delivered	13409.28
ORD01532	CUST0452	SELL057	2023-09-16	2023-09-18	Delivered	14771.68
ORD01533	CUST0452	SELL082	2023-08-22	2023-08-24	Delivered	1602.14
ORD01534	CUST0452	SELL051	2023-12-05	\N	Returned	70088.60
ORD01535	CUST0453	SELL087	2024-10-02	\N	Cancelled	20196.96
ORD01536	CUST0453	SELL036	2024-10-01	\N	Processing	91572.30
ORD01537	CUST0453	SELL051	2024-11-01	\N	Shipped	323619.81
ORD01538	CUST0453	SELL050	2024-12-14	\N	Shipped	\N
ORD01539	CUST0453	SELL008	2024-11-05	2024-11-15	Delivered	46665.46
ORD01540	CUST0453	SELL038	2024-11-13	\N	Returned	7586.49
ORD01541	CUST0454	SELL003	2024-08-11	2024-08-18	Delivered	465301.97
ORD01542	CUST0454	SELL017	2024-04-15	\N	Cancelled	63045.36
ORD01543	CUST0454	SELL046	2024-04-25	\N	Shipped	609597.45
ORD01544	CUST0455	SELL046	2024-09-25	2024-09-27	Delivered	321721.45
ORD01545	CUST0455	SELL006	2024-09-06	2024-09-08	Delivered	1738086.01
ORD01546	CUST0455	SELL011	2024-06-30	2024-07-04	Delivered	610317.96
ORD01547	CUST0455	SELL024	2024-10-13	2024-10-15	Delivered	40190.19
ORD01548	CUST0455	SELL075	2024-03-08	\N	Returned	1063841.04
ORD01549	CUST0455	SELL037	2024-12-05	\N	Processing	32496.44
ORD01550	CUST0458	SELL011	2024-11-17	2024-11-20	Delivered	51604.24
ORD01551	CUST0459	SELL074	2024-06-05	2024-06-06	Delivered	47284.02
ORD01552	CUST0459	SELL080	2023-06-18	\N	Processing	86352.92
ORD01553	CUST0459	SELL088	2024-08-05	\N	Returned	\N
ORD01554	CUST0459	SELL075	2023-08-08	\N	Cancelled	39482.24
ORD01555	CUST0459	SELL048	2024-01-20	\N	Returned	57790.16
ORD01556	CUST0459	SELL032	2023-10-18	2023-10-19	Delivered	263606.60
ORD01557	CUST0460	SELL027	2024-10-25	\N	Returned	1823.79
ORD01558	CUST0460	SELL017	2024-05-13	2024-05-18	Delivered	\N
ORD01559	CUST0460	SELL018	2024-02-16	\N	Shipped	99989.07
ORD01560	CUST0460	SELL021	2024-05-17	\N	Processing	198912.26
ORD01561	CUST0460	SELL036	2024-12-17	2024-12-21	Delivered	204806.12
ORD01562	CUST0460	SELL047	2024-07-08	\N	Shipped	358879.83
ORD01563	CUST0460	SELL076	2024-06-13	\N	Cancelled	485731.76
ORD01564	CUST0460	SELL041	2023-11-12	2023-11-16	Delivered	43789.85
ORD01565	CUST0461	SELL019	2024-05-06	\N	Processing	1401503.52
ORD01566	CUST0461	SELL079	2024-11-30	2024-12-01	Delivered	56009.43
ORD01567	CUST0461	SELL085	2024-04-20	2024-04-27	Delivered	99076.62
ORD01568	CUST0462	SELL064	2023-07-01	2023-07-04	Delivered	339257.53
ORD01569	CUST0462	SELL079	2023-07-19	2023-07-25	Delivered	103389.13
ORD01570	CUST0462	SELL025	2023-11-19	\N	Processing	523208.74
ORD01571	CUST0462	SELL057	2024-08-02	2024-08-09	Delivered	458781.64
ORD01572	CUST0462	SELL015	2024-12-08	2024-12-09	Delivered	25061.13
ORD01573	CUST0462	SELL017	2024-12-06	2024-12-09	Delivered	5914.40
ORD01574	CUST0462	SELL087	2024-01-28	2024-02-01	Delivered	540458.75
ORD01575	CUST0462	SELL049	2023-09-20	\N	Returned	287086.29
ORD01576	CUST0462	SELL077	2024-09-12	\N	Shipped	91114.16
ORD01577	CUST0464	SELL012	2024-03-14	\N	Cancelled	1038879.17
ORD01578	CUST0464	SELL083	2024-12-15	\N	Returned	661180.78
ORD01579	CUST0464	SELL009	2023-07-27	2023-08-02	Delivered	739805.40
ORD01580	CUST0464	SELL044	2024-07-19	\N	Shipped	69998.19
ORD01581	CUST0464	SELL028	2023-10-04	2023-10-10	Delivered	38342.82
ORD01582	CUST0464	SELL067	2023-07-03	2023-07-07	Delivered	260280.99
ORD01583	CUST0467	SELL083	2024-07-06	\N	Returned	50242.47
ORD01584	CUST0467	SELL015	2024-06-26	\N	Shipped	4696.28
ORD01585	CUST0468	SELL021	2024-11-29	\N	Returned	227151.91
ORD01586	CUST0468	SELL046	2024-11-30	2024-12-03	Delivered	825680.81
ORD01587	CUST0468	SELL032	2024-12-10	2024-12-12	Delivered	100339.89
ORD01588	CUST0468	SELL090	2024-11-23	2024-11-30	Delivered	1781841.04
ORD01589	CUST0469	SELL027	2024-10-05	\N	Cancelled	\N
ORD01590	CUST0469	SELL060	2024-05-14	2024-05-21	Delivered	454316.32
ORD01591	CUST0470	SELL008	2023-08-30	\N	Returned	152620.50
ORD01592	CUST0470	SELL001	2023-10-07	\N	Shipped	484414.91
ORD01593	CUST0471	SELL022	2024-05-17	\N	Cancelled	102269.93
ORD01594	CUST0472	SELL008	2024-03-01	2024-03-06	Delivered	33479.34
ORD01595	CUST0472	SELL019	2024-11-21	\N	Processing	32496.44
ORD01596	CUST0472	SELL062	2023-12-17	2023-12-23	Delivered	52346.95
ORD01597	CUST0472	SELL079	2024-07-21	2024-07-24	Delivered	\N
ORD01598	CUST0473	SELL025	2024-06-21	\N	Processing	2277.57
ORD01599	CUST0473	SELL087	2023-10-17	\N	Shipped	57552.08
ORD01600	CUST0473	SELL012	2024-12-13	2024-12-20	Delivered	140237.76
ORD01601	CUST0473	SELL054	2023-10-20	2023-10-22	Delivered	106784.91
ORD01602	CUST0473	SELL005	2023-04-29	2023-05-02	Delivered	978096.05
ORD01603	CUST0473	SELL027	2023-12-25	\N	Cancelled	207805.53
ORD01604	CUST0474	SELL027	2024-12-09	2024-12-19	Delivered	28812.35
ORD01605	CUST0475	SELL050	2024-12-08	2024-12-11	Delivered	31477.40
ORD01606	CUST0475	SELL031	2024-11-02	\N	Returned	1211726.50
ORD01607	CUST0476	SELL034	2024-06-06	2024-06-13	Delivered	96615.35
ORD01608	CUST0476	SELL049	2024-06-03	\N	Returned	1092137.37
ORD01609	CUST0476	SELL008	2024-02-27	2024-03-03	Delivered	199233.48
ORD01610	CUST0478	SELL077	2024-01-09	\N	Cancelled	1368736.41
ORD01611	CUST0478	SELL069	2024-05-20	\N	Processing	789996.34
ORD01612	CUST0478	SELL029	2024-12-26	2024-12-29	Delivered	22960.29
ORD01613	CUST0478	SELL004	2024-09-12	\N	Shipped	206048.30
ORD01614	CUST0478	SELL090	2024-10-01	2024-10-05	Delivered	1272167.51
ORD01615	CUST0478	SELL056	2023-12-18	\N	Processing	\N
ORD01616	CUST0478	SELL016	2024-09-24	\N	Cancelled	306963.73
ORD01617	CUST0479	SELL013	2024-12-03	2024-12-10	Delivered	40465.27
ORD01618	CUST0480	SELL086	2024-10-27	\N	Cancelled	1379975.68
ORD01619	CUST0480	SELL056	2024-06-09	2024-06-13	Delivered	638415.97
ORD01620	CUST0481	SELL083	2024-04-09	2024-04-19	Delivered	865087.23
ORD01621	CUST0481	SELL014	2024-04-02	\N	Cancelled	513753.00
ORD01622	CUST0481	SELL049	2024-07-30	2024-08-08	Delivered	45708.85
ORD01623	CUST0481	SELL038	2023-06-07	2023-06-10	Delivered	7172.97
ORD01624	CUST0481	SELL074	2024-04-14	2024-04-19	Delivered	215711.20
ORD01625	CUST0481	SELL069	2024-06-21	2024-06-24	Delivered	310749.90
ORD01626	CUST0481	SELL001	2024-05-16	\N	Processing	325806.45
ORD01627	CUST0481	SELL007	2024-09-27	2024-10-06	Delivered	767003.95
ORD01628	CUST0481	SELL009	2024-04-25	\N	Returned	1062479.55
ORD01629	CUST0481	SELL020	2023-06-05	2023-06-12	Delivered	\N
ORD01630	CUST0482	SELL034	2024-08-31	2024-09-02	Delivered	380329.47
ORD01631	CUST0482	SELL037	2024-11-17	\N	Returned	560071.01
ORD01632	CUST0482	SELL027	2024-07-12	\N	Shipped	64122.63
ORD01633	CUST0482	SELL036	2024-03-26	\N	Returned	56377.85
ORD01634	CUST0482	SELL066	2024-05-10	2024-05-17	Delivered	77315.50
ORD01635	CUST0482	SELL085	2024-10-22	\N	Processing	544947.62
ORD01636	CUST0482	SELL085	2024-02-09	2024-02-16	Delivered	84100.44
ORD01637	CUST0482	SELL084	2023-12-29	\N	Processing	116488.73
ORD01638	CUST0482	SELL069	2024-08-09	\N	Returned	1011339.75
ORD01639	CUST0482	SELL069	2024-10-12	2024-10-14	Delivered	\N
ORD01640	CUST0483	SELL073	2024-08-19	2024-08-24	Delivered	40877.16
ORD01641	CUST0483	SELL076	2024-07-15	\N	Processing	102403.06
ORD01642	CUST0486	SELL017	2023-12-16	2023-12-29	Delivered	168353.89
ORD01643	CUST0488	SELL018	2024-02-24	\N	Shipped	159679.04
ORD01644	CUST0490	SELL036	2024-07-31	\N	Cancelled	628372.20
ORD01645	CUST0490	SELL068	2024-07-27	2024-07-28	Delivered	11386.20
ORD01646	CUST0491	SELL034	2024-09-21	\N	Shipped	100013.23
ORD01647	CUST0491	SELL045	2024-05-09	2024-05-12	Delivered	629898.03
ORD01648	CUST0491	SELL032	2024-05-24	2024-05-26	Delivered	141953.36
ORD01649	CUST0492	SELL022	2024-09-27	\N	Returned	344917.27
ORD01650	CUST0492	SELL076	2024-10-16	2024-10-18	Delivered	1462057.55
ORD01651	CUST0493	SELL056	2024-04-12	\N	Shipped	805628.22
ORD01652	CUST0494	SELL054	2024-11-16	\N	Returned	182275.12
ORD01653	CUST0494	SELL068	2024-09-02	\N	Shipped	311454.20
ORD01654	CUST0494	SELL019	2024-06-10	2024-06-16	Delivered	160108.43
ORD01655	CUST0494	SELL024	2024-06-12	2024-06-16	Delivered	809604.90
ORD01656	CUST0494	SELL067	2024-10-22	2024-10-23	Delivered	\N
ORD01657	CUST0494	SELL075	2024-02-24	\N	Returned	63030.81
ORD01658	CUST0494	SELL060	2024-02-02	\N	Shipped	471756.64
ORD01659	CUST0494	SELL019	2024-02-01	\N	Processing	1349163.71
ORD01660	CUST0495	SELL010	2024-12-02	2024-12-07	Delivered	187646.29
ORD01661	CUST0495	SELL058	2024-12-04	\N	Cancelled	89630.67
ORD01662	CUST0497	SELL007	2023-06-02	2023-06-05	Delivered	141135.80
ORD01663	CUST0497	SELL072	2024-09-20	2024-09-24	Delivered	87482.09
ORD01664	CUST0497	SELL007	2024-05-19	2024-05-23	Delivered	1158907.10
ORD01665	CUST0497	SELL059	2024-01-10	2024-01-16	Delivered	211679.32
ORD01666	CUST0497	SELL032	2024-09-04	2024-09-05	Delivered	182560.65
ORD01667	CUST0497	SELL040	2024-04-24	2024-04-29	Delivered	102447.74
ORD01668	CUST0499	SELL010	2024-10-24	\N	Returned	120704.02
ORD01669	CUST0499	SELL062	2024-12-25	2024-12-31	Delivered	1280228.45
ORD01670	CUST0501	SELL059	2024-06-14	\N	Shipped	51492.75
ORD01671	CUST0501	SELL086	2023-03-15	\N	Processing	107691.70
ORD01672	CUST0501	SELL075	2023-05-08	\N	Processing	158321.24
ORD01673	CUST0501	SELL015	2024-03-25	2024-03-29	Delivered	53762.13
ORD01674	CUST0502	SELL065	2024-12-28	\N	Processing	39655.64
ORD01675	CUST0502	SELL049	2024-10-15	\N	Processing	1281457.61
ORD01676	CUST0502	SELL006	2024-11-16	2024-11-19	Delivered	86284.48
ORD01677	CUST0502	SELL009	2024-09-16	\N	Returned	43905.60
ORD01678	CUST0503	SELL015	2024-05-29	\N	Shipped	6438.96
ORD01679	CUST0503	SELL014	2024-01-25	\N	Returned	9521.40
ORD01680	CUST0503	SELL034	2024-10-04	2024-10-08	Delivered	129842.64
ORD01681	CUST0503	SELL028	2024-12-06	\N	Shipped	48648.69
ORD01682	CUST0503	SELL089	2024-03-20	2024-03-22	Delivered	530860.46
ORD01683	CUST0504	SELL034	2024-01-22	2024-01-24	Delivered	25910.95
ORD01684	CUST0505	SELL067	2024-09-21	2024-09-22	Delivered	78806.70
ORD01685	CUST0505	SELL062	2024-11-22	\N	Returned	30388.20
ORD01686	CUST0506	SELL062	2024-01-16	\N	Processing	437628.20
ORD01687	CUST0506	SELL054	2024-06-25	\N	Processing	135442.10
ORD01688	CUST0506	SELL028	2023-05-12	2023-05-16	Delivered	54388.50
ORD01689	CUST0506	SELL047	2023-08-07	2023-08-11	Delivered	584934.80
ORD01690	CUST0506	SELL065	2024-09-13	\N	Shipped	351142.20
ORD01691	CUST0507	SELL022	2024-10-26	2024-11-05	Delivered	425267.89
ORD01692	CUST0507	SELL015	2024-08-27	2024-08-31	Delivered	441078.84
ORD01693	CUST0507	SELL043	2024-07-30	2024-08-09	Delivered	339524.65
ORD01694	CUST0507	SELL077	2024-06-13	2024-06-17	Delivered	5712.84
ORD01695	CUST0509	SELL016	2024-12-30	\N	Processing	26343.44
ORD01696	CUST0509	SELL044	2024-12-15	\N	Processing	2847.84
ORD01697	CUST0511	SELL033	2024-01-23	\N	Returned	459203.48
ORD01698	CUST0511	SELL077	2024-09-22	2024-09-27	Delivered	23616.92
ORD01699	CUST0511	SELL013	2024-09-29	2024-10-01	Delivered	\N
ORD01700	CUST0511	SELL067	2024-08-16	\N	Cancelled	1482754.03
ORD01701	CUST0511	SELL018	2024-10-11	\N	Cancelled	822273.60
ORD01702	CUST0511	SELL012	2024-03-25	2024-04-01	Delivered	499862.83
ORD01703	CUST0511	SELL058	2024-03-27	\N	Shipped	25905.43
ORD01704	CUST0511	SELL024	2024-05-18	\N	Shipped	\N
ORD01705	CUST0512	SELL030	2024-12-22	\N	Shipped	563880.02
ORD01706	CUST0512	SELL013	2024-11-25	\N	Shipped	68699.92
ORD01707	CUST0513	SELL021	2024-12-06	2024-12-08	Delivered	497712.95
ORD01708	CUST0513	SELL055	2024-11-24	2024-12-04	Delivered	130015.70
ORD01709	CUST0513	SELL025	2024-11-25	2024-12-02	Delivered	1220840.69
ORD01710	CUST0513	SELL012	2024-11-27	2024-12-04	Delivered	333752.14
ORD01711	CUST0513	SELL041	2024-11-23	2024-11-28	Delivered	4038.10
ORD01712	CUST0513	SELL031	2024-11-30	2024-12-04	Delivered	23765.62
ORD01713	CUST0513	SELL069	2024-12-25	2024-12-30	Delivered	5323.48
ORD01714	CUST0513	SELL025	2024-12-23	\N	Processing	691596.36
ORD01715	CUST0517	SELL087	2024-07-25	2024-07-28	Delivered	70505.99
ORD01716	CUST0518	SELL033	2024-11-14	2024-11-19	Delivered	82979.02
ORD01717	CUST0518	SELL018	2024-06-20	\N	Shipped	1065848.19
ORD01718	CUST0518	SELL045	2023-06-16	\N	Cancelled	14723.75
ORD01719	CUST0518	SELL002	2024-09-27	\N	Processing	74245.65
ORD01720	CUST0518	SELL013	2024-04-23	2024-04-28	Delivered	194600.30
ORD01721	CUST0518	SELL076	2023-12-17	2023-12-24	Delivered	675417.62
ORD01722	CUST0518	SELL079	2024-03-11	\N	Returned	146172.96
ORD01723	CUST0518	SELL090	2024-02-13	2024-02-17	Delivered	994838.80
ORD01724	CUST0518	SELL011	2024-02-16	\N	Cancelled	13380.15
ORD01725	CUST0518	SELL062	2024-08-25	2024-08-29	Delivered	34157.64
ORD01726	CUST0519	SELL038	2024-06-28	2024-07-04	Delivered	16961.56
ORD01727	CUST0519	SELL082	2024-09-06	\N	Cancelled	1955906.49
ORD01728	CUST0519	SELL034	2024-08-30	2024-09-01	Delivered	629332.63
ORD01729	CUST0519	SELL088	2024-07-07	2024-07-14	Delivered	501907.37
ORD01730	CUST0519	SELL032	2024-09-17	\N	Processing	82232.97
ORD01731	CUST0519	SELL029	2024-07-24	2024-07-27	Delivered	32574.27
ORD01732	CUST0519	SELL049	2024-07-10	2024-07-15	Delivered	324828.96
ORD01733	CUST0519	SELL063	2024-09-06	2024-09-13	Delivered	21912.74
ORD01734	CUST0519	SELL055	2024-09-18	2024-09-20	Delivered	64122.63
ORD01735	CUST0519	SELL077	2024-09-15	\N	Cancelled	27088.10
ORD01736	CUST0519	SELL057	2024-07-12	2024-07-15	Delivered	\N
ORD01737	CUST0519	SELL046	2024-09-26	2024-10-03	Delivered	135283.44
ORD01738	CUST0521	SELL071	2024-09-04	\N	Shipped	269130.44
ORD01739	CUST0522	SELL025	2024-10-08	\N	Cancelled	9404.33
ORD01740	CUST0522	SELL034	2024-12-01	2024-12-02	Delivered	813081.63
ORD01741	CUST0522	SELL061	2024-10-02	2024-10-09	Delivered	1657410.01
ORD01742	CUST0522	SELL046	2024-12-31	2025-01-04	Delivered	129271.75
ORD01743	CUST0523	SELL024	2024-08-05	2024-08-08	Delivered	1416912.17
ORD01744	CUST0525	SELL086	2023-12-30	\N	Cancelled	3485.44
ORD01745	CUST0525	SELL076	2024-10-22	\N	Cancelled	220692.32
ORD01746	CUST0525	SELL036	2024-05-21	\N	Processing	192259.59
ORD01747	CUST0525	SELL083	2024-07-24	\N	Returned	1132304.71
ORD01748	CUST0525	SELL050	2024-12-15	\N	Processing	479117.75
ORD01749	CUST0526	SELL080	2024-08-11	\N	Cancelled	\N
ORD01750	CUST0526	SELL024	2024-09-22	\N	Cancelled	611816.16
ORD01751	CUST0526	SELL009	2024-12-21	2024-12-23	Delivered	33297.75
ORD01752	CUST0526	SELL063	2024-11-14	2024-11-17	Delivered	44306.32
ORD01753	CUST0527	SELL044	2024-08-27	\N	Returned	19390.59
ORD01754	CUST0528	SELL003	2024-10-31	2024-11-01	Delivered	195934.03
ORD01755	CUST0529	SELL064	2024-08-08	2024-08-15	Delivered	351805.72
ORD01756	CUST0529	SELL066	2023-12-21	2023-12-24	Delivered	8076.20
ORD01757	CUST0529	SELL068	2023-08-31	2023-09-05	Delivered	395222.81
ORD01758	CUST0529	SELL067	2023-08-10	\N	Processing	515070.46
ORD01759	CUST0529	SELL067	2024-06-30	2024-07-07	Delivered	136573.70
ORD01760	CUST0529	SELL040	2023-09-19	\N	Cancelled	449826.69
ORD01761	CUST0530	SELL078	2024-06-26	2024-07-02	Delivered	654050.30
ORD01762	CUST0530	SELL020	2024-05-25	\N	Cancelled	132692.49
ORD01763	CUST0532	SELL007	2024-07-03	2024-07-10	Delivered	1746773.40
ORD01764	CUST0534	SELL039	2024-07-18	2024-07-23	Delivered	130130.84
ORD01765	CUST0534	SELL040	2024-01-26	\N	Returned	21374.21
ORD01766	CUST0534	SELL013	2023-12-02	\N	Cancelled	6057.15
ORD01767	CUST0535	SELL089	2024-06-01	2024-06-05	Delivered	476073.93
ORD01768	CUST0536	SELL054	2024-09-12	\N	Cancelled	243407.52
ORD01769	CUST0536	SELL049	2024-12-31	\N	Cancelled	1430577.19
ORD01770	CUST0536	SELL082	2024-12-22	\N	Returned	23255.54
ORD01771	CUST0536	SELL004	2024-11-28	2024-11-30	Delivered	18080.28
ORD01772	CUST0536	SELL025	2024-12-06	2024-12-13	Delivered	192990.07
ORD01773	CUST0536	SELL043	2024-12-01	\N	Processing	1259946.96
ORD01774	CUST0539	SELL039	2024-08-24	\N	Processing	\N
ORD01775	CUST0540	SELL056	2024-06-22	\N	Cancelled	58586.40
ORD01776	CUST0540	SELL018	2024-10-31	2024-11-07	Delivered	41117.60
ORD01777	CUST0540	SELL045	2024-09-03	\N	Shipped	385456.22
ORD01778	CUST0540	SELL076	2024-07-24	2024-07-26	Delivered	5762.47
ORD01779	CUST0540	SELL062	2024-06-07	2024-06-10	Delivered	\N
ORD01780	CUST0540	SELL033	2024-02-12	2024-02-18	Delivered	390298.12
ORD01781	CUST0540	SELL007	2024-01-07	2024-01-12	Delivered	411387.98
ORD01782	CUST0540	SELL017	2024-06-11	2024-06-13	Delivered	56480.82
ORD01783	CUST0540	SELL068	2024-05-18	2024-05-24	Delivered	292210.30
ORD01784	CUST0540	SELL024	2024-08-01	\N	Cancelled	521857.71
ORD01785	CUST0540	SELL066	2023-09-18	2023-09-23	Delivered	30581.49
ORD01786	CUST0540	SELL082	2024-05-02	\N	Shipped	\N
ORD01787	CUST0541	SELL074	2023-10-23	\N	Cancelled	97617.63
ORD01788	CUST0541	SELL088	2024-05-12	2024-05-15	Delivered	439754.74
ORD01789	CUST0541	SELL009	2023-10-19	2023-10-25	Delivered	257364.90
ORD01790	CUST0541	SELL080	2024-11-06	2024-11-11	Delivered	335067.63
ORD01791	CUST0541	SELL083	2023-11-30	2023-12-03	Delivered	116573.24
ORD01792	CUST0541	SELL007	2023-01-17	\N	Shipped	808571.70
ORD01793	CUST0541	SELL011	2023-07-24	\N	Processing	234738.71
ORD01794	CUST0541	SELL028	2024-07-16	\N	Processing	196809.88
ORD01795	CUST0541	SELL033	2024-08-12	\N	Returned	187982.07
ORD01796	CUST0541	SELL071	2023-07-29	\N	Shipped	211177.92
ORD01797	CUST0541	SELL063	2024-07-01	2024-07-07	Delivered	263054.64
ORD01798	CUST0541	SELL020	2023-01-25	2023-01-30	Delivered	145973.64
ORD01799	CUST0541	SELL039	2023-08-08	2023-08-14	Delivered	1313271.46
ORD01800	CUST0541	SELL081	2024-01-01	2024-01-07	Delivered	782873.27
ORD01801	CUST0542	SELL003	2023-11-29	\N	Cancelled	545617.92
ORD01802	CUST0542	SELL028	2024-05-20	2024-05-23	Delivered	\N
ORD01803	CUST0542	SELL044	2023-05-13	\N	Processing	117508.45
ORD01804	CUST0542	SELL074	2024-05-08	2024-05-10	Delivered	68037.48
ORD01805	CUST0543	SELL080	2024-12-25	\N	Shipped	71782.70
ORD01806	CUST0544	SELL041	2024-08-30	2024-09-06	Delivered	355773.52
ORD01807	CUST0544	SELL027	2024-07-17	\N	Returned	80964.57
ORD01808	CUST0546	SELL001	2024-08-31	\N	Shipped	654671.31
ORD01809	CUST0546	SELL060	2024-10-18	\N	Cancelled	26206.57
ORD01810	CUST0546	SELL030	2024-12-29	2025-01-07	Delivered	1158331.97
ORD01811	CUST0546	SELL044	2024-10-19	2024-10-29	Delivered	101960.16
ORD01812	CUST0546	SELL069	2024-11-19	2024-11-27	Delivered	378503.96
ORD01813	CUST0546	SELL069	2024-08-25	2024-08-29	Delivered	132157.53
ORD01814	CUST0547	SELL045	2024-12-16	\N	Shipped	75670.50
ORD01815	CUST0547	SELL034	2024-09-12	2024-09-17	Delivered	247824.46
ORD01816	CUST0547	SELL082	2024-11-29	\N	Processing	638398.91
ORD01817	CUST0547	SELL057	2024-11-21	\N	Shipped	213131.04
ORD01818	CUST0547	SELL038	2024-12-21	\N	Returned	64022.61
ORD01819	CUST0547	SELL064	2024-11-12	\N	Returned	1044264.04
ORD01820	CUST0548	SELL085	2024-12-27	\N	Returned	1861542.37
ORD01821	CUST0549	SELL023	2024-09-09	\N	Returned	185175.91
ORD01822	CUST0549	SELL087	2024-10-18	2024-10-22	Delivered	180084.64
ORD01823	CUST0550	SELL077	2024-12-27	2025-01-06	Delivered	528573.66
ORD01824	CUST0550	SELL028	2024-08-15	\N	Processing	102403.06
ORD01825	CUST0550	SELL078	2024-06-26	2024-06-28	Delivered	337665.56
ORD01826	CUST0550	SELL029	2024-09-18	\N	Processing	35031.88
ORD01827	CUST0550	SELL026	2024-12-01	2024-12-03	Delivered	722299.05
ORD01828	CUST0550	SELL066	2024-07-16	2024-07-18	Delivered	61579.68
ORD01829	CUST0550	SELL061	2024-08-06	\N	Shipped	1019878.78
ORD01830	CUST0550	SELL087	2024-06-29	\N	Processing	229390.82
ORD01831	CUST0552	SELL083	2023-07-01	\N	Cancelled	452351.13
ORD01832	CUST0552	SELL081	2024-02-02	2024-02-05	Delivered	137710.20
ORD01833	CUST0552	SELL015	2023-12-24	2023-12-25	Delivered	63364.03
ORD01834	CUST0552	SELL088	2024-08-17	\N	Shipped	507870.22
ORD01835	CUST0552	SELL028	2024-09-15	2024-09-20	Delivered	42025.94
ORD01836	CUST0552	SELL034	2024-08-02	\N	Shipped	58338.32
ORD01837	CUST0553	SELL013	2024-03-25	2024-03-26	Delivered	19742.68
ORD01838	CUST0555	SELL060	2024-11-21	\N	Shipped	1622826.09
ORD01839	CUST0556	SELL084	2024-10-23	2024-10-31	Delivered	557510.13
ORD01840	CUST0556	SELL085	2024-11-03	\N	Cancelled	8994.92
ORD01841	CUST0556	SELL086	2024-08-08	\N	Shipped	32521.50
ORD01842	CUST0556	SELL076	2024-11-20	2024-11-23	Delivered	695331.56
ORD01843	CUST0556	SELL073	2024-08-21	\N	Processing	4620.81
ORD01844	CUST0557	SELL077	2024-12-02	\N	Returned	1616476.58
ORD01845	CUST0557	SELL070	2024-12-31	2025-01-04	Delivered	43905.60
ORD01846	CUST0557	SELL032	2024-12-06	2024-12-09	Delivered	97853.36
ORD01847	CUST0557	SELL052	2024-12-16	\N	Shipped	700840.62
ORD01848	CUST0557	SELL066	2024-12-18	\N	Processing	94945.56
ORD01849	CUST0557	SELL039	2024-12-09	\N	Processing	16739.67
ORD01850	CUST0558	SELL062	2024-02-27	\N	Processing	4731.52
ORD01851	CUST0558	SELL021	2024-09-08	2024-09-09	Delivered	1707225.31
ORD01852	CUST0558	SELL082	2024-03-19	\N	Cancelled	882759.48
ORD01853	CUST0558	SELL011	2024-05-02	2024-05-06	Delivered	2943847.83
ORD01854	CUST0558	SELL049	2023-11-18	2023-11-24	Delivered	43372.48
ORD01855	CUST0558	SELL072	2024-10-06	\N	Returned	434062.64
ORD01856	CUST0558	SELL052	2024-06-24	2024-07-01	Delivered	987015.13
ORD01857	CUST0558	SELL076	2024-08-13	\N	Processing	127630.73
ORD01858	CUST0559	SELL058	2024-12-06	\N	Processing	4876.47
ORD01859	CUST0560	SELL006	2024-06-09	2024-06-14	Delivered	185673.25
ORD01860	CUST0560	SELL038	2023-09-16	\N	Processing	104826.28
ORD01861	CUST0560	SELL075	2024-12-05	\N	Shipped	\N
ORD01862	CUST0560	SELL058	2024-06-26	2024-06-29	Delivered	242330.60
ORD01863	CUST0560	SELL020	2024-06-21	\N	Processing	363996.06
ORD01864	CUST0560	SELL075	2024-08-19	2024-08-21	Delivered	15152.82
ORD01865	CUST0561	SELL049	2024-06-20	2024-06-24	Delivered	630266.76
ORD01866	CUST0561	SELL057	2024-08-20	2024-08-27	Delivered	549230.53
ORD01867	CUST0561	SELL076	2024-05-10	2024-05-14	Delivered	6170.81
ORD01868	CUST0561	SELL046	2024-07-12	\N	Processing	6770.96
ORD01869	CUST0561	SELL084	2024-06-10	\N	Cancelled	\N
ORD01870	CUST0561	SELL003	2023-12-12	2023-12-16	Delivered	563919.29
ORD01871	CUST0561	SELL051	2023-11-02	2023-11-07	Delivered	215711.20
ORD01872	CUST0561	SELL007	2024-04-06	2024-04-12	Delivered	7533.78
ORD01873	CUST0562	SELL032	2024-08-11	2024-08-19	Delivered	6230.11
ORD01874	CUST0563	SELL042	2024-10-21	\N	Processing	24683.24
ORD01875	CUST0563	SELL062	2024-07-11	2024-07-14	Delivered	76433.95
ORD01876	CUST0563	SELL017	2024-06-18	2024-06-30	Delivered	24463.34
ORD01877	CUST0563	SELL042	2024-07-01	\N	Cancelled	502019.35
ORD01878	CUST0563	SELL062	2024-10-06	\N	Cancelled	1633.04
ORD01879	CUST0563	SELL040	2024-06-27	2024-07-02	Delivered	118653.08
ORD01880	CUST0563	SELL055	2024-09-16	2024-09-20	Delivered	220539.42
ORD01881	CUST0563	SELL011	2024-10-06	2024-10-14	Delivered	430288.80
ORD01882	CUST0563	SELL084	2024-11-29	2024-12-13	Delivered	402816.45
ORD01883	CUST0564	SELL090	2024-08-12	\N	Returned	61852.40
ORD01884	CUST0564	SELL003	2024-09-27	\N	Returned	\N
ORD01885	CUST0565	SELL044	2024-11-06	2024-11-11	Delivered	12706.74
ORD01886	CUST0566	SELL089	2023-12-05	\N	Shipped	37320.95
ORD01887	CUST0566	SELL020	2024-02-03	2024-02-08	Delivered	21709.68
ORD01888	CUST0566	SELL013	2024-06-22	2024-06-28	Delivered	126473.94
ORD01889	CUST0567	SELL004	2024-12-11	\N	Returned	479437.69
ORD01890	CUST0567	SELL046	2024-01-10	\N	Cancelled	63030.80
ORD01891	CUST0567	SELL074	2023-08-08	\N	Processing	\N
ORD01892	CUST0567	SELL048	2023-11-18	2023-11-24	Delivered	586047.25
ORD01893	CUST0568	SELL039	2024-12-10	2024-12-14	Delivered	100933.34
ORD01894	CUST0568	SELL021	2024-10-12	\N	Cancelled	438424.40
ORD01895	CUST0568	SELL023	2024-10-12	\N	Returned	4696.28
ORD01896	CUST0568	SELL060	2024-12-02	\N	Returned	79755.34
ORD01897	CUST0568	SELL060	2024-10-29	\N	Cancelled	307549.24
ORD01898	CUST0568	SELL087	2024-10-30	2024-11-04	Delivered	1213753.37
ORD01899	CUST0568	SELL075	2024-10-27	2024-10-31	Delivered	705677.44
ORD01900	CUST0568	SELL052	2024-09-14	2024-09-16	Delivered	19741.12
ORD01901	CUST0569	SELL007	2024-01-12	2024-01-17	Delivered	48037.37
ORD01902	CUST0569	SELL059	2024-02-02	2024-02-05	Delivered	471590.12
ORD01903	CUST0569	SELL043	2024-10-15	\N	Shipped	1835205.35
ORD01904	CUST0569	SELL079	2024-01-14	2024-01-21	Delivered	20698.80
ORD01905	CUST0569	SELL083	2024-02-03	\N	Processing	69170.07
ORD01906	CUST0569	SELL039	2023-11-19	2023-11-23	Delivered	63091.21
ORD01907	CUST0569	SELL082	2024-12-27	2024-12-29	Delivered	78955.84
ORD01908	CUST0569	SELL065	2024-04-14	2024-04-23	Delivered	85470.14
ORD01909	CUST0570	SELL077	2024-10-23	2024-10-27	Delivered	986407.20
ORD01910	CUST0570	SELL029	2024-11-11	\N	Shipped	243681.27
ORD01911	CUST0570	SELL086	2024-11-04	\N	Returned	674219.46
ORD01912	CUST0570	SELL066	2024-11-19	2024-11-21	Delivered	15003.67
ORD01913	CUST0571	SELL055	2023-11-12	2023-11-17	Delivered	281964.48
ORD01914	CUST0572	SELL025	2024-09-26	\N	Cancelled	674182.67
ORD01915	CUST0572	SELL017	2024-07-01	2024-07-03	Delivered	889298.04
ORD01916	CUST0572	SELL064	2024-06-09	2024-06-16	Delivered	2019.05
ORD01917	CUST0573	SELL051	2024-12-16	\N	Shipped	72306.55
ORD01918	CUST0574	SELL005	2024-02-05	2024-02-16	Delivered	358222.29
ORD01919	CUST0575	SELL061	2023-08-08	\N	Cancelled	22713.45
ORD01920	CUST0575	SELL023	2024-07-04	2024-07-09	Delivered	470699.26
ORD01921	CUST0575	SELL056	2024-06-06	\N	Shipped	\N
ORD01922	CUST0575	SELL041	2024-08-18	\N	Shipped	13912.80
ORD01923	CUST0575	SELL046	2024-06-27	\N	Cancelled	18054.21
ORD01924	CUST0575	SELL006	2024-08-04	2024-08-14	Delivered	1418267.19
ORD01925	CUST0575	SELL063	2024-01-06	\N	Cancelled	109521.65
ORD01926	CUST0575	SELL072	2023-09-24	2023-09-29	Delivered	53953.43
ORD01927	CUST0575	SELL077	2024-05-25	\N	Shipped	60582.65
ORD01928	CUST0575	SELL069	2024-07-12	\N	Processing	266991.21
ORD01929	CUST0576	SELL071	2023-06-17	\N	Returned	32496.44
ORD01930	CUST0576	SELL003	2024-01-17	2024-01-20	Delivered	456035.22
ORD01931	CUST0577	SELL045	2024-10-08	2024-10-11	Delivered	795566.29
ORD01932	CUST0577	SELL058	2024-12-20	\N	Returned	156709.08
ORD01933	CUST0577	SELL045	2024-09-03	2024-09-04	Delivered	120268.52
ORD01934	CUST0577	SELL084	2024-12-14	2024-12-20	Delivered	424884.05
ORD01935	CUST0578	SELL028	2024-04-13	\N	Processing	4696.28
ORD01936	CUST0579	SELL062	2023-06-17	2023-06-27	Delivered	643395.88
ORD01937	CUST0579	SELL002	2024-07-12	\N	Returned	616829.11
ORD01938	CUST0579	SELL065	2024-11-01	\N	Shipped	1240191.46
ORD01939	CUST0579	SELL032	2023-10-13	2023-10-19	Delivered	1401938.78
ORD01940	CUST0582	SELL036	2024-08-08	\N	Returned	26273.91
ORD01941	CUST0582	SELL064	2024-06-16	2024-06-21	Delivered	359579.20
ORD01942	CUST0582	SELL042	2024-05-21	2024-05-28	Delivered	398397.28
ORD01943	CUST0582	SELL060	2024-04-25	2024-04-29	Delivered	180749.37
ORD01944	CUST0582	SELL014	2024-12-12	2024-12-15	Delivered	1428725.36
ORD01945	CUST0582	SELL028	2024-01-28	\N	Processing	25825.32
ORD01946	CUST0582	SELL049	2024-10-10	2024-10-15	Delivered	492031.74
ORD01947	CUST0582	SELL002	2024-04-23	2024-04-25	Delivered	118084.60
ORD01948	CUST0582	SELL032	2024-06-19	2024-06-20	Delivered	173901.38
ORD01949	CUST0582	SELL049	2024-08-29	2024-08-31	Delivered	48466.70
ORD01950	CUST0582	SELL004	2024-06-27	2024-06-28	Delivered	54215.60
ORD01951	CUST0582	SELL079	2024-01-22	\N	Processing	10688.84
ORD01952	CUST0585	SELL028	2024-12-26	\N	Returned	643433.84
ORD01953	CUST0585	SELL067	2023-12-29	\N	Processing	122712.27
ORD01954	CUST0586	SELL015	2024-07-17	2024-07-23	Delivered	\N
ORD01955	CUST0586	SELL050	2024-11-25	2024-11-26	Delivered	31579.12
ORD01956	CUST0586	SELL046	2024-06-14	2024-06-21	Delivered	127824.90
ORD01957	CUST0586	SELL007	2024-09-16	\N	Cancelled	609217.26
ORD01958	CUST0587	SELL068	2024-10-12	\N	Cancelled	72198.04
ORD01959	CUST0587	SELL081	2024-09-29	2024-10-01	Delivered	868327.05
ORD01960	CUST0587	SELL090	2024-04-14	2024-04-15	Delivered	1372231.16
ORD01961	CUST0589	SELL038	2024-12-06	2024-12-09	Delivered	259751.90
ORD01962	CUST0589	SELL057	2024-10-26	2024-10-29	Delivered	24920.44
ORD01963	CUST0590	SELL067	2024-12-23	\N	Cancelled	44222.23
ORD01964	CUST0590	SELL004	2023-11-20	2023-11-21	Delivered	1073842.93
ORD01965	CUST0590	SELL005	2023-10-05	\N	Processing	140572.66
ORD01966	CUST0590	SELL005	2024-05-19	\N	Processing	674226.50
ORD01967	CUST0590	SELL046	2024-01-07	2024-01-14	Delivered	28370.48
ORD01968	CUST0591	SELL053	2024-05-18	\N	Returned	\N
ORD01969	CUST0591	SELL075	2023-09-07	2023-09-13	Delivered	363859.64
ORD01970	CUST0591	SELL059	2024-11-13	\N	Returned	21243.28
ORD01971	CUST0591	SELL020	2024-09-22	\N	Returned	19648.74
ORD01972	CUST0591	SELL049	2024-07-04	\N	Processing	257220.91
ORD01973	CUST0591	SELL016	2024-03-16	2024-03-18	Delivered	433699.07
ORD01974	CUST0592	SELL016	2024-08-25	\N	Cancelled	832088.60
ORD01975	CUST0592	SELL051	2024-05-23	\N	Processing	487091.15
ORD01976	CUST0592	SELL085	2023-05-25	2023-05-28	Delivered	1016135.30
ORD01977	CUST0592	SELL051	2024-11-13	\N	Shipped	\N
ORD01978	CUST0592	SELL015	2023-07-31	\N	Processing	515939.67
ORD01979	CUST0592	SELL034	2024-12-29	2025-01-03	Delivered	135777.09
ORD01980	CUST0592	SELL025	2024-10-15	2024-10-22	Delivered	156645.15
ORD01981	CUST0592	SELL062	2024-12-04	\N	Processing	35280.59
ORD01982	CUST0592	SELL060	2024-11-01	2024-11-07	Delivered	186774.13
ORD01983	CUST0593	SELL003	2024-01-25	\N	Shipped	179754.67
ORD01984	CUST0593	SELL029	2024-10-08	\N	Returned	134382.79
ORD01985	CUST0593	SELL079	2024-02-21	2024-02-27	Delivered	47930.68
ORD01986	CUST0593	SELL074	2024-09-07	\N	Returned	939059.84
ORD01987	CUST0593	SELL031	2024-02-14	2024-02-19	Delivered	82713.56
ORD01988	CUST0593	SELL034	2024-06-16	\N	Processing	18690.33
ORD01989	CUST0593	SELL070	2024-12-03	\N	Returned	47325.18
ORD01990	CUST0593	SELL078	2023-12-10	2023-12-11	Delivered	1375465.84
ORD01991	CUST0593	SELL089	2024-10-27	\N	Returned	56936.10
ORD01992	CUST0593	SELL074	2024-09-24	2024-09-27	Delivered	18117.48
ORD01993	CUST0593	SELL060	2024-06-03	\N	Shipped	17515.94
ORD01994	CUST0593	SELL028	2024-06-06	\N	Returned	509664.00
ORD01995	CUST0593	SELL045	2023-11-20	2023-11-23	Delivered	51228.88
ORD01996	CUST0593	SELL046	2024-02-25	\N	Cancelled	490432.66
ORD01997	CUST0594	SELL055	2024-09-08	2024-09-18	Delivered	133191.00
ORD01998	CUST0594	SELL047	2024-08-14	2024-08-18	Delivered	957676.93
ORD01999	CUST0595	SELL022	2024-04-10	\N	Cancelled	178914.74
ORD02000	CUST0595	SELL006	2024-04-23	\N	Processing	\N
ORD02001	CUST0596	SELL061	2024-01-28	2024-01-30	Delivered	1228137.40
ORD02002	CUST0597	SELL087	2024-09-01	2024-09-08	Delivered	643395.88
ORD02003	CUST0598	SELL080	2024-09-01	2024-09-05	Delivered	209097.61
ORD02004	CUST0598	SELL080	2023-08-26	\N	Cancelled	19691.64
ORD02005	CUST0598	SELL002	2024-01-17	2024-01-19	Delivered	1235650.44
ORD02006	CUST0598	SELL030	2023-09-01	2023-09-11	Delivered	164442.78
ORD02007	CUST0598	SELL043	2024-04-30	2024-05-09	Delivered	219422.34
ORD02008	CUST0598	SELL055	2024-09-01	2024-09-09	Delivered	\N
ORD02009	CUST0598	SELL009	2024-08-09	2024-08-15	Delivered	275127.81
ORD02010	CUST0598	SELL013	2024-06-27	\N	Cancelled	108353.68
ORD02011	CUST0599	SELL076	2023-12-13	\N	Cancelled	26917.21
ORD02012	CUST0599	SELL053	2023-07-10	\N	Returned	39300.97
ORD02013	CUST0599	SELL090	2024-05-26	2024-05-31	Delivered	991771.17
ORD02014	CUST0599	SELL082	2024-09-30	\N	Returned	181747.95
ORD02015	CUST0599	SELL023	2024-04-30	2024-05-08	Delivered	1124082.02
ORD02016	CUST0599	SELL060	2024-09-09	\N	Processing	28180.48
ORD02017	CUST0599	SELL031	2024-09-19	2024-09-21	Delivered	242070.75
ORD02018	CUST0599	SELL056	2024-10-16	2024-10-26	Delivered	34967.80
ORD02019	CUST0599	SELL089	2024-02-02	2024-02-09	Delivered	1720355.06
ORD02020	CUST0599	SELL012	2024-11-10	\N	Cancelled	36567.08
ORD02021	CUST0600	SELL060	2024-10-30	2024-11-02	Delivered	69996.63
ORD02022	CUST0602	SELL046	2024-10-07	\N	Shipped	557154.99
ORD02023	CUST0602	SELL026	2024-08-19	2024-08-24	Delivered	2802.33
ORD02024	CUST0602	SELL076	2024-10-09	\N	Shipped	245496.97
ORD02025	CUST0602	SELL074	2024-06-13	\N	Returned	52123.14
ORD02026	CUST0603	SELL029	2023-03-13	\N	Shipped	3871.20
ORD02027	CUST0603	SELL083	2023-06-21	\N	Cancelled	250878.09
ORD02028	CUST0603	SELL061	2024-08-27	2024-08-29	Delivered	46035.40
ORD02029	CUST0603	SELL036	2024-11-22	\N	Processing	3548.64
ORD02030	CUST0605	SELL082	2024-12-10	2024-12-19	Delivered	271616.18
ORD02031	CUST0606	SELL084	2024-08-20	2024-08-25	Delivered	2017488.79
ORD02032	CUST0606	SELL029	2024-11-26	\N	Cancelled	1057640.67
ORD02033	CUST0606	SELL063	2024-09-13	\N	Returned	1176557.82
ORD02034	CUST0606	SELL083	2024-07-17	2024-07-18	Delivered	58333.34
ORD02035	CUST0608	SELL025	2024-10-09	2024-10-15	Delivered	548636.31
ORD02036	CUST0610	SELL059	2024-11-16	2024-11-18	Delivered	45302.42
ORD02037	CUST0610	SELL007	2024-10-14	\N	Cancelled	72583.62
ORD02038	CUST0610	SELL043	2024-10-21	2024-10-26	Delivered	369351.72
ORD02039	CUST0610	SELL034	2024-08-26	2024-08-29	Delivered	191629.85
ORD02040	CUST0610	SELL019	2024-08-31	\N	Shipped	367940.95
ORD02041	CUST0611	SELL084	2024-11-03	2024-11-14	Delivered	867436.59
ORD02042	CUST0611	SELL032	2024-05-27	\N	Returned	140307.63
ORD02043	CUST0611	SELL028	2024-02-02	2024-02-11	Delivered	212476.89
ORD02044	CUST0611	SELL030	2024-11-30	\N	Processing	82804.12
ORD02045	CUST0611	SELL005	2024-07-28	\N	Processing	281964.48
ORD02046	CUST0611	SELL019	2024-07-19	\N	Shipped	1260871.90
ORD02047	CUST0611	SELL005	2024-03-08	2024-03-20	Delivered	1018541.18
ORD02048	CUST0612	SELL005	2023-10-23	2023-10-28	Delivered	150697.55
ORD02049	CUST0612	SELL088	2023-10-08	\N	Returned	620872.37
ORD02050	CUST0614	SELL072	2023-05-24	\N	Processing	25910.95
ORD02051	CUST0614	SELL041	2024-01-22	2024-01-24	Delivered	407731.20
ORD02052	CUST0614	SELL071	2024-07-09	\N	Processing	\N
ORD02053	CUST0614	SELL038	2024-11-21	\N	Cancelled	10156.44
ORD02054	CUST0614	SELL073	2024-01-13	2024-01-15	Delivered	870698.52
ORD02055	CUST0614	SELL028	2024-03-26	2024-04-04	Delivered	25484.84
ORD02056	CUST0614	SELL054	2023-04-25	2023-05-01	Delivered	40877.16
ORD02057	CUST0614	SELL065	2024-06-28	2024-07-08	Delivered	57109.46
ORD02058	CUST0615	SELL019	2024-12-09	\N	Processing	1180810.69
ORD02059	CUST0615	SELL005	2024-12-13	\N	Shipped	29665.75
ORD02060	CUST0615	SELL083	2023-09-18	\N	Returned	71056.05
ORD02061	CUST0616	SELL023	2024-06-19	\N	Shipped	459768.00
ORD02062	CUST0616	SELL079	2024-03-23	2024-03-26	Delivered	1517372.93
ORD02063	CUST0616	SELL088	2024-12-02	\N	Processing	139211.89
ORD02064	CUST0617	SELL008	2024-09-14	2024-09-20	Delivered	83437.72
ORD02065	CUST0617	SELL058	2024-12-09	2024-12-17	Delivered	33029.61
ORD02066	CUST0617	SELL074	2024-09-11	\N	Shipped	140129.81
ORD02067	CUST0617	SELL021	2024-10-13	\N	Cancelled	127505.15
ORD02068	CUST0617	SELL035	2024-12-29	2025-01-07	Delivered	578743.00
ORD02069	CUST0618	SELL045	2024-08-22	2024-08-26	Delivered	47233.84
ORD02070	CUST0618	SELL057	2024-08-09	2024-08-14	Delivered	51993.13
ORD02071	CUST0618	SELL057	2024-07-17	2024-07-22	Delivered	\N
ORD02072	CUST0618	SELL012	2024-12-13	2024-12-22	Delivered	1057590.73
ORD02073	CUST0618	SELL076	2024-12-02	2024-12-08	Delivered	770041.63
ORD02074	CUST0618	SELL057	2024-04-09	\N	Returned	45302.42
ORD02075	CUST0618	SELL048	2024-10-26	2024-11-01	Delivered	104228.31
ORD02076	CUST0618	SELL067	2024-04-15	\N	Shipped	1330904.90
ORD02077	CUST0618	SELL086	2024-12-03	\N	Cancelled	619796.13
ORD02078	CUST0618	SELL026	2024-11-04	\N	Returned	173740.39
ORD02079	CUST0618	SELL085	2024-07-30	2024-08-08	Delivered	857314.46
ORD02080	CUST0618	SELL079	2024-12-22	\N	Processing	736882.44
ORD02081	CUST0620	SELL023	2023-11-26	2023-11-29	Delivered	184401.52
ORD02082	CUST0621	SELL059	2023-11-21	2023-11-22	Delivered	195886.35
ORD02083	CUST0621	SELL024	2024-11-23	2024-11-30	Delivered	80339.85
ORD02084	CUST0621	SELL043	2024-07-05	2024-07-09	Delivered	207992.10
ORD02085	CUST0621	SELL031	2024-03-09	\N	Shipped	54388.95
ORD02086	CUST0621	SELL028	2024-08-03	\N	Shipped	678632.38
ORD02087	CUST0621	SELL090	2024-09-14	\N	Shipped	60421.06
ORD02088	CUST0621	SELL037	2024-12-14	2024-12-19	Delivered	111904.54
ORD02089	CUST0621	SELL052	2024-04-12	2024-04-19	Delivered	86352.92
ORD02090	CUST0621	SELL054	2024-11-29	2024-12-05	Delivered	5261.71
ORD02091	CUST0621	SELL017	2024-04-21	2024-04-27	Delivered	56642.17
ORD02092	CUST0621	SELL063	2024-09-20	2024-09-26	Delivered	17515.94
ORD02093	CUST0621	SELL009	2024-12-31	2025-01-02	Delivered	169273.30
ORD02094	CUST0622	SELL007	2024-12-13	\N	Processing	342064.22
ORD02095	CUST0623	SELL038	2024-07-30	\N	Returned	444649.02
ORD02096	CUST0623	SELL010	2024-11-08	2024-11-12	Delivered	45926.31
ORD02097	CUST0624	SELL023	2024-12-26	\N	Processing	340110.70
ORD02098	CUST0624	SELL087	2024-08-25	2024-08-30	Delivered	48285.65
ORD02099	CUST0624	SELL003	2024-09-25	2024-09-29	Delivered	11209.32
ORD02100	CUST0624	SELL062	2024-09-15	\N	Processing	174074.54
ORD02101	CUST0626	SELL062	2023-12-24	2023-12-29	Delivered	\N
ORD02102	CUST0626	SELL030	2023-11-23	\N	Returned	473947.30
ORD02103	CUST0626	SELL058	2024-12-22	\N	Returned	1467554.94
ORD02104	CUST0626	SELL028	2024-08-17	\N	Cancelled	122096.40
ORD02105	CUST0626	SELL045	2024-10-17	2024-10-22	Delivered	770562.66
ORD02106	CUST0626	SELL053	2024-02-07	2024-02-10	Delivered	15315.45
ORD02107	CUST0626	SELL069	2024-04-22	\N	Shipped	796626.60
ORD02108	CUST0626	SELL002	2024-11-11	2024-11-16	Delivered	65858.60
ORD02109	CUST0626	SELL064	2024-09-07	\N	Returned	948919.92
ORD02110	CUST0626	SELL089	2024-02-18	\N	Cancelled	632010.46
ORD02111	CUST0626	SELL076	2024-01-29	\N	Cancelled	204410.76
ORD02112	CUST0626	SELL011	2024-06-21	2024-06-22	Delivered	661180.78
ORD02113	CUST0626	SELL031	2024-05-09	2024-05-10	Delivered	62292.43
ORD02114	CUST0626	SELL042	2024-05-29	\N	Cancelled	1553648.52
ORD02115	CUST0628	SELL058	2024-04-12	2024-04-18	Delivered	24288.60
ORD02116	CUST0628	SELL048	2024-11-08	\N	Returned	198923.73
ORD02117	CUST0629	SELL042	2024-08-15	\N	Shipped	274063.06
ORD02118	CUST0629	SELL072	2024-10-21	\N	Shipped	204806.12
ORD02119	CUST0629	SELL059	2024-11-10	2024-11-11	Delivered	345924.48
ORD02120	CUST0631	SELL038	2024-09-24	2024-09-30	Delivered	580632.46
ORD02121	CUST0631	SELL080	2024-07-25	2024-07-29	Delivered	\N
ORD02122	CUST0631	SELL023	2024-12-12	\N	Processing	47669.61
ORD02123	CUST0631	SELL003	2024-10-10	2024-10-16	Delivered	711191.81
ORD02124	CUST0631	SELL074	2024-12-06	2024-12-10	Delivered	246601.80
ORD02125	CUST0631	SELL012	2024-11-23	\N	Shipped	32407.34
ORD02126	CUST0632	SELL015	2024-11-24	\N	Shipped	35044.30
ORD02127	CUST0632	SELL028	2024-12-12	2024-12-14	Delivered	575752.52
ORD02128	CUST0633	SELL020	2023-11-02	2023-11-03	Delivered	446216.60
ORD02129	CUST0633	SELL029	2024-01-18	\N	Cancelled	40620.55
ORD02130	CUST0633	SELL078	2023-12-07	\N	Cancelled	38427.65
ORD02131	CUST0634	SELL021	2024-01-30	\N	Processing	31498.10
ORD02132	CUST0634	SELL025	2023-11-15	2023-11-20	Delivered	137481.28
ORD02133	CUST0634	SELL063	2024-09-21	2024-09-29	Delivered	19738.96
ORD02134	CUST0634	SELL089	2024-11-10	\N	Returned	196595.48
ORD02135	CUST0635	SELL021	2024-10-28	\N	Returned	73390.02
ORD02136	CUST0635	SELL010	2024-11-14	2024-11-18	Delivered	1633.04
ORD02137	CUST0635	SELL020	2024-12-28	2024-12-31	Delivered	14077.14
ORD02138	CUST0635	SELL026	2024-10-24	2024-10-25	Delivered	52507.89
ORD02139	CUST0635	SELL004	2024-11-23	\N	Shipped	\N
ORD02140	CUST0635	SELL051	2024-12-13	\N	Processing	27088.10
ORD02141	CUST0636	SELL088	2023-09-02	2023-09-08	Delivered	85978.02
ORD02142	CUST0636	SELL072	2023-10-10	2023-10-11	Delivered	402619.27
ORD02143	CUST0636	SELL063	2024-09-22	2024-09-27	Delivered	31766.85
ORD02144	CUST0636	SELL077	2024-01-26	2024-01-29	Delivered	616971.17
ORD02145	CUST0637	SELL015	2024-03-01	2024-03-08	Delivered	177974.85
ORD02146	CUST0637	SELL067	2023-12-31	\N	Shipped	182969.82
ORD02147	CUST0637	SELL069	2023-12-09	2023-12-11	Delivered	47233.84
ORD02148	CUST0638	SELL036	2024-09-29	\N	Shipped	13475.96
ORD02149	CUST0638	SELL014	2023-12-06	2023-12-08	Delivered	562883.38
ORD02150	CUST0638	SELL001	2024-04-17	2024-04-20	Delivered	88185.56
ORD02151	CUST0638	SELL028	2023-11-18	\N	Returned	749726.57
ORD02152	CUST0640	SELL022	2023-07-13	\N	Cancelled	746129.10
ORD02153	CUST0640	SELL034	2024-01-14	2024-01-17	Delivered	29665.75
ORD02154	CUST0640	SELL030	2023-12-30	\N	Shipped	9800.57
ORD02155	CUST0640	SELL041	2024-01-17	\N	Returned	553200.55
ORD02156	CUST0640	SELL001	2024-06-20	2024-06-22	Delivered	171216.94
ORD02157	CUST0640	SELL089	2024-01-11	\N	Returned	12341.62
ORD02158	CUST0640	SELL008	2024-10-11	2024-10-18	Delivered	2195798.60
ORD02159	CUST0640	SELL009	2024-04-16	2024-04-17	Delivered	23616.92
ORD02160	CUST0641	SELL060	2024-12-19	2024-12-28	Delivered	6970.88
ORD02161	CUST0641	SELL074	2024-10-21	\N	Returned	103934.64
ORD02162	CUST0641	SELL055	2024-10-27	2024-11-04	Delivered	63753.88
ORD02163	CUST0641	SELL017	2024-10-27	\N	Processing	14965.75
ORD02164	CUST0642	SELL058	2023-08-18	\N	Returned	43032.12
ORD02165	CUST0642	SELL030	2024-05-02	\N	Cancelled	27285.04
ORD02166	CUST0642	SELL066	2023-11-24	2023-11-30	Delivered	327229.73
ORD02167	CUST0642	SELL080	2023-09-24	2023-09-30	Delivered	156709.08
ORD02168	CUST0642	SELL073	2024-02-11	2024-02-14	Delivered	22657.06
ORD02169	CUST0642	SELL082	2023-12-05	\N	Returned	277403.35
ORD02170	CUST0642	SELL046	2024-12-09	\N	Processing	1769642.81
ORD02171	CUST0643	SELL044	2023-11-29	\N	Processing	1148191.33
ORD02172	CUST0643	SELL036	2024-07-04	\N	Processing	409790.96
ORD02173	CUST0643	SELL052	2024-05-11	2024-05-14	Delivered	2511.26
ORD02174	CUST0643	SELL008	2024-12-22	\N	Cancelled	140970.74
ORD02175	CUST0644	SELL084	2024-11-15	\N	Shipped	289033.42
ORD02176	CUST0644	SELL061	2024-10-25	2024-10-27	Delivered	121527.21
ORD02177	CUST0644	SELL004	2023-11-13	2023-11-23	Delivered	506005.84
ORD02178	CUST0644	SELL053	2024-07-28	\N	Returned	159664.84
ORD02179	CUST0644	SELL040	2024-06-09	2024-06-17	Delivered	50265.21
ORD02180	CUST0645	SELL076	2024-10-04	\N	Processing	2253493.62
ORD02181	CUST0645	SELL054	2024-12-07	\N	Processing	2195842.84
ORD02182	CUST0645	SELL089	2024-12-18	2025-01-01	Delivered	124125.36
ORD02183	CUST0645	SELL037	2024-11-24	2024-12-04	Delivered	370104.20
ORD02184	CUST0645	SELL012	2024-11-22	2024-11-29	Delivered	670530.77
ORD02185	CUST0645	SELL025	2024-11-16	2024-11-19	Delivered	86352.92
ORD02186	CUST0645	SELL008	2024-10-25	2024-10-31	Delivered	87588.60
ORD02187	CUST0645	SELL029	2024-11-19	\N	Shipped	1030921.60
ORD02188	CUST0645	SELL030	2024-10-08	\N	Returned	14011.65
ORD02189	CUST0645	SELL062	2024-11-06	2024-11-20	Delivered	91572.30
ORD02190	CUST0646	SELL046	2024-04-17	2024-04-24	Delivered	\N
ORD02191	CUST0646	SELL017	2024-07-25	\N	Shipped	133191.00
ORD02192	CUST0646	SELL029	2024-12-27	2024-12-29	Delivered	1322728.85
ORD02193	CUST0646	SELL090	2024-07-31	\N	Returned	1703192.03
ORD02194	CUST0646	SELL002	2024-04-22	2024-04-26	Delivered	109628.52
ORD02195	CUST0646	SELL069	2024-06-07	\N	Returned	507131.62
ORD02196	CUST0646	SELL057	2024-04-11	2024-04-13	Delivered	8968.44
ORD02197	CUST0648	SELL084	2024-06-07	\N	Cancelled	74048.46
ORD02198	CUST0648	SELL086	2024-02-04	2024-02-08	Delivered	49985.97
ORD02199	CUST0648	SELL081	2024-03-07	\N	Returned	273656.26
ORD02200	CUST0649	SELL074	2024-06-17	\N	Returned	32317.65
ORD02201	CUST0649	SELL087	2024-11-20	\N	Processing	44052.51
ORD02202	CUST0650	SELL047	2024-09-12	\N	Shipped	582657.42
ORD02203	CUST0650	SELL005	2024-12-27	2025-01-02	Delivered	13938.18
ORD02204	CUST0650	SELL074	2024-05-09	\N	Processing	66052.59
ORD02205	CUST0652	SELL061	2024-07-22	2024-07-24	Delivered	13912.80
ORD02206	CUST0652	SELL057	2024-08-25	2024-08-31	Delivered	5971.28
ORD02207	CUST0653	SELL073	2024-02-29	2024-03-05	Delivered	20220.48
ORD02208	CUST0653	SELL061	2024-09-03	2024-09-04	Delivered	12989.38
ORD02209	CUST0653	SELL060	2023-10-13	\N	Returned	240843.57
ORD02210	CUST0654	SELL058	2024-07-08	2024-07-13	Delivered	116663.65
ORD02211	CUST0654	SELL075	2024-10-12	2024-10-13	Delivered	926737.83
ORD02212	CUST0655	SELL027	2023-03-08	\N	Returned	264206.69
ORD02213	CUST0656	SELL008	2024-07-15	2024-07-23	Delivered	458267.45
ORD02214	CUST0656	SELL082	2024-12-07	\N	Returned	525731.42
ORD02215	CUST0656	SELL028	2024-09-06	2024-09-15	Delivered	189651.37
ORD02216	CUST0656	SELL074	2024-12-21	2024-12-31	Delivered	181209.68
ORD02217	CUST0656	SELL057	2024-07-14	\N	Cancelled	91703.33
ORD02218	CUST0656	SELL057	2024-11-07	\N	Cancelled	24526.05
ORD02219	CUST0656	SELL065	2024-10-30	2024-11-04	Delivered	332973.30
ORD02220	CUST0656	SELL083	2024-10-30	\N	Processing	120790.15
ORD02221	CUST0656	SELL046	2024-08-17	2024-08-22	Delivered	45054.25
ORD02222	CUST0656	SELL088	2024-08-08	\N	Processing	515460.80
ORD02223	CUST0657	SELL040	2023-10-03	2023-10-10	Delivered	35007.70
ORD02224	CUST0657	SELL034	2023-10-10	2023-10-14	Delivered	48314.36
ORD02225	CUST0657	SELL015	2024-04-15	2024-04-17	Delivered	923433.55
ORD02226	CUST0658	SELL082	2023-05-03	\N	Returned	17522.15
ORD02227	CUST0658	SELL070	2023-09-29	2023-10-03	Delivered	564648.56
ORD02228	CUST0658	SELL004	2023-02-21	\N	Processing	442560.44
ORD02229	CUST0658	SELL004	2023-06-09	\N	Shipped	72814.92
ORD02230	CUST0659	SELL050	2024-03-15	\N	Cancelled	46853.29
ORD02231	CUST0659	SELL076	2023-06-03	\N	Returned	41250.55
ORD02232	CUST0659	SELL069	2024-07-14	2024-07-15	Delivered	61391.40
ORD02233	CUST0660	SELL072	2024-10-03	\N	Processing	1110726.95
ORD02234	CUST0661	SELL036	2023-10-11	\N	Processing	166785.29
ORD02235	CUST0661	SELL028	2024-04-23	2024-04-24	Delivered	370314.78
ORD02236	CUST0661	SELL033	2024-01-01	\N	Returned	\N
ORD02237	CUST0661	SELL017	2024-01-28	\N	Shipped	962914.49
ORD02238	CUST0661	SELL071	2023-10-30	2023-10-31	Delivered	251980.85
ORD02239	CUST0661	SELL079	2024-03-18	\N	Processing	1230207.90
ORD02240	CUST0662	SELL020	2024-06-14	2024-06-21	Delivered	27621.24
ORD02241	CUST0662	SELL014	2024-12-20	\N	Returned	175672.42
ORD02242	CUST0662	SELL007	2024-05-21	2024-05-28	Delivered	167564.56
ORD02243	CUST0662	SELL053	2024-04-12	2024-04-18	Delivered	780584.55
ORD02244	CUST0662	SELL042	2024-08-04	2024-08-09	Delivered	\N
ORD02245	CUST0662	SELL065	2024-09-23	\N	Processing	172705.84
ORD02246	CUST0662	SELL082	2024-07-27	\N	Returned	188580.52
ORD02247	CUST0665	SELL059	2023-08-13	2023-08-20	Delivered	518985.79
ORD02248	CUST0665	SELL045	2023-10-23	\N	Shipped	107668.84
ORD02249	CUST0665	SELL016	2024-12-16	2024-12-24	Delivered	\N
ORD02250	CUST0666	SELL058	2024-08-28	2024-09-04	Delivered	417590.00
ORD02251	CUST0666	SELL052	2024-07-29	\N	Processing	1405617.22
ORD02252	CUST0666	SELL006	2024-12-17	\N	Returned	115104.16
ORD02253	CUST0666	SELL042	2024-11-20	\N	Shipped	281964.48
ORD02254	CUST0666	SELL001	2024-11-27	2024-11-28	Delivered	84659.35
ORD02255	CUST0666	SELL008	2024-06-17	2024-06-24	Delivered	20510.26
ORD02256	CUST0666	SELL012	2024-07-18	2024-07-25	Delivered	34106.30
ORD02257	CUST0666	SELL080	2024-05-25	2024-06-01	Delivered	41020.52
ORD02258	CUST0666	SELL011	2024-11-19	2024-11-24	Delivered	135100.29
ORD02259	CUST0666	SELL034	2024-12-09	2024-12-11	Delivered	464020.29
ORD02260	CUST0666	SELL020	2024-12-30	2025-01-06	Delivered	142379.88
ORD02261	CUST0666	SELL073	2024-06-13	2024-06-18	Delivered	105159.48
ORD02262	CUST0667	SELL079	2024-05-03	\N	Cancelled	622116.46
ORD02263	CUST0667	SELL054	2024-11-27	2024-12-02	Delivered	98694.80
ORD02264	CUST0667	SELL064	2023-12-18	\N	Returned	91431.76
ORD02265	CUST0667	SELL068	2023-11-07	2023-11-17	Delivered	876706.12
ORD02266	CUST0667	SELL068	2024-03-14	2024-03-28	Delivered	9866.86
ORD02267	CUST0667	SELL006	2024-04-18	2024-04-27	Delivered	61685.11
ORD02268	CUST0667	SELL086	2024-05-22	2024-06-05	Delivered	17265.90
ORD02269	CUST0667	SELL072	2024-11-02	2024-11-11	Delivered	54814.26
ORD02270	CUST0667	SELL085	2023-11-17	2023-11-21	Delivered	11129.13
ORD02271	CUST0667	SELL016	2023-09-10	\N	Returned	28468.05
ORD02272	CUST0670	SELL028	2024-10-17	2024-10-19	Delivered	5399.76
ORD02273	CUST0670	SELL032	2024-10-30	2024-11-06	Delivered	108471.43
ORD02274	CUST0670	SELL077	2024-10-15	2024-10-18	Delivered	118094.97
ORD02275	CUST0671	SELL066	2024-10-10	2024-10-14	Delivered	89272.26
ORD02276	CUST0671	SELL029	2024-06-03	2024-06-07	Delivered	44745.78
ORD02277	CUST0671	SELL030	2024-03-25	2024-03-27	Delivered	202825.74
ORD02278	CUST0671	SELL072	2024-10-19	2024-10-23	Delivered	32284.63
ORD02279	CUST0671	SELL046	2024-08-22	\N	Processing	422203.94
ORD02280	CUST0671	SELL088	2024-04-13	2024-04-15	Delivered	226321.39
ORD02281	CUST0671	SELL034	2024-10-26	2024-10-31	Delivered	\N
ORD02282	CUST0672	SELL056	2024-09-03	\N	Cancelled	1192014.28
ORD02283	CUST0672	SELL033	2024-02-05	2024-02-07	Delivered	711932.45
ORD02284	CUST0673	SELL085	2024-12-17	2024-12-22	Delivered	8406.99
ORD02285	CUST0673	SELL050	2024-10-30	2024-11-06	Delivered	77977.95
ORD02286	CUST0673	SELL013	2024-11-24	2024-11-29	Delivered	24750.33
ORD02287	CUST0673	SELL048	2024-12-16	\N	Processing	269629.27
ORD02288	CUST0673	SELL027	2024-11-01	\N	Shipped	646542.53
ORD02289	CUST0673	SELL061	2024-11-30	\N	Cancelled	1056086.58
ORD02290	CUST0673	SELL077	2024-11-15	2024-11-18	Delivered	175369.76
ORD02291	CUST0673	SELL084	2024-10-10	\N	Shipped	607290.96
ORD02292	CUST0674	SELL063	2024-03-20	\N	Returned	286695.52
ORD02293	CUST0674	SELL040	2024-09-01	2024-09-02	Delivered	180084.64
ORD02294	CUST0674	SELL034	2024-06-02	\N	Processing	886785.03
ORD02295	CUST0675	SELL029	2024-06-15	2024-06-19	Delivered	1169138.42
ORD02296	CUST0675	SELL024	2024-11-10	2024-11-14	Delivered	1597548.44
ORD02297	CUST0675	SELL073	2024-10-01	\N	Processing	173134.33
ORD02298	CUST0675	SELL047	2024-12-26	\N	Processing	30854.05
ORD02299	CUST0675	SELL015	2024-09-26	2024-09-27	Delivered	158270.04
ORD02300	CUST0675	SELL053	2024-11-26	\N	Processing	26191.00
ORD02301	CUST0676	SELL005	2024-09-21	\N	Processing	536510.96
ORD02302	CUST0676	SELL090	2024-05-14	\N	Processing	58000.93
ORD02303	CUST0676	SELL045	2024-12-04	\N	Returned	423658.47
ORD02304	CUST0676	SELL082	2024-04-09	\N	Processing	9871.34
ORD02305	CUST0677	SELL033	2024-07-01	2024-07-05	Delivered	2395014.01
ORD02306	CUST0677	SELL087	2024-12-12	\N	Returned	43661.34
ORD02307	CUST0677	SELL045	2024-10-12	\N	Processing	1030921.60
ORD02308	CUST0677	SELL069	2024-11-28	2024-12-04	Delivered	57806.00
ORD02309	CUST0677	SELL049	2024-05-01	2024-05-06	Delivered	2989.48
ORD02310	CUST0677	SELL027	2024-03-15	2024-03-19	Delivered	11608.58
ORD02311	CUST0678	SELL033	2024-11-07	\N	Shipped	1191248.26
ORD02312	CUST0678	SELL056	2024-05-07	\N	Returned	48013.32
ORD02313	CUST0679	SELL032	2024-07-25	\N	Returned	103621.72
ORD02314	CUST0679	SELL043	2024-10-29	2024-10-30	Delivered	325573.42
ORD02315	CUST0680	SELL015	2024-11-22	2024-12-03	Delivered	506890.19
ORD02316	CUST0680	SELL061	2024-12-19	2025-01-01	Delivered	229390.82
ORD02317	CUST0681	SELL058	2024-08-28	\N	Shipped	280938.65
ORD02318	CUST0682	SELL060	2024-12-07	2024-12-09	Delivered	57806.00
ORD02319	CUST0682	SELL082	2024-12-26	2024-12-27	Delivered	185321.91
ORD02320	CUST0682	SELL073	2024-12-02	\N	Processing	36567.08
ORD02321	CUST0682	SELL087	2024-12-29	\N	Shipped	194836.46
ORD02322	CUST0682	SELL065	2024-12-24	2024-12-30	Delivered	1147155.41
ORD02323	CUST0682	SELL005	2024-12-23	2024-12-27	Delivered	572061.17
ORD02324	CUST0683	SELL043	2023-10-14	2023-10-21	Delivered	179452.02
ORD02325	CUST0683	SELL025	2023-05-08	\N	Cancelled	22348.80
ORD02326	CUST0683	SELL033	2024-04-12	\N	Processing	66958.68
ORD02327	CUST0683	SELL035	2024-12-08	\N	Cancelled	454353.38
ORD02328	CUST0683	SELL044	2024-05-29	2024-06-04	Delivered	316366.34
ORD02329	CUST0683	SELL078	2023-04-17	\N	Shipped	538786.92
ORD02330	CUST0684	SELL083	2024-10-14	2024-10-19	Delivered	86986.03
ORD02331	CUST0684	SELL081	2024-10-03	2024-10-05	Delivered	40185.68
ORD02332	CUST0685	SELL089	2023-12-17	\N	Returned	326498.43
ORD02333	CUST0685	SELL058	2024-04-01	2024-04-04	Delivered	35221.95
ORD02334	CUST0685	SELL076	2024-08-09	2024-08-11	Delivered	297926.52
ORD02335	CUST0685	SELL063	2023-11-19	\N	Cancelled	45708.85
ORD02336	CUST0685	SELL076	2024-02-24	\N	Processing	166648.45
ORD02337	CUST0685	SELL088	2024-04-10	\N	Returned	4710.98
ORD02338	CUST0686	SELL080	2024-07-26	2024-08-03	Delivered	64122.63
ORD02339	CUST0688	SELL066	2024-11-29	\N	Processing	147420.82
ORD02340	CUST0688	SELL006	2024-04-28	2024-05-01	Delivered	105588.96
ORD02341	CUST0688	SELL045	2024-10-02	\N	Shipped	1196417.96
ORD02342	CUST0688	SELL058	2024-12-01	2024-12-03	Delivered	245349.52
ORD02343	CUST0688	SELL024	2024-04-20	2024-04-27	Delivered	13642.52
ORD02344	CUST0689	SELL032	2024-12-24	\N	Cancelled	1173216.51
ORD02345	CUST0689	SELL077	2024-09-11	\N	Shipped	363459.87
ORD02346	CUST0689	SELL047	2024-10-22	2024-10-29	Delivered	1086701.68
ORD02347	CUST0689	SELL049	2024-12-23	\N	Processing	29691.10
ORD02348	CUST0689	SELL037	2024-09-28	2024-10-01	Delivered	\N
ORD02349	CUST0689	SELL038	2024-09-20	2024-09-25	Delivered	117531.81
ORD02350	CUST0690	SELL085	2024-04-27	\N	Shipped	176210.04
ORD02351	CUST0690	SELL072	2024-04-17	2024-04-19	Delivered	187599.69
ORD02352	CUST0690	SELL061	2023-04-11	2023-04-14	Delivered	166393.68
ORD02353	CUST0690	SELL075	2023-05-24	\N	Returned	201277.32
ORD02354	CUST0690	SELL032	2024-11-09	\N	Returned	1724427.15
ORD02355	CUST0690	SELL071	2024-03-04	\N	Processing	14461.31
ORD02356	CUST0690	SELL037	2023-08-14	2023-08-22	Delivered	109628.52
ORD02357	CUST0690	SELL024	2024-05-06	2024-05-08	Delivered	67745.32
ORD02358	CUST0690	SELL058	2023-12-05	\N	Shipped	52910.92
ORD02359	CUST0690	SELL070	2023-07-06	\N	Returned	8199.23
ORD02360	CUST0691	SELL053	2024-05-12	2024-05-14	Delivered	768841.50
ORD02361	CUST0691	SELL077	2024-01-04	\N	Processing	96291.59
ORD02362	CUST0691	SELL039	2024-11-14	2024-11-21	Delivered	38151.06
ORD02363	CUST0691	SELL050	2023-10-16	2023-10-19	Delivered	395756.90
ORD02364	CUST0691	SELL002	2023-12-12	2023-12-15	Delivered	1461335.07
ORD02365	CUST0691	SELL016	2023-09-21	\N	Shipped	602615.41
ORD02366	CUST0692	SELL083	2024-10-23	\N	Shipped	567895.40
ORD02367	CUST0692	SELL030	2023-03-11	2023-03-13	Delivered	373173.62
ORD02368	CUST0692	SELL067	2023-11-21	\N	Returned	233291.88
ORD02369	CUST0692	SELL086	2024-02-29	\N	Returned	404390.93
ORD02370	CUST0692	SELL082	2023-05-31	\N	Shipped	126037.11
ORD02371	CUST0692	SELL053	2023-07-05	2023-07-08	Delivered	23357.67
ORD02372	CUST0693	SELL012	2023-11-09	2023-11-11	Delivered	80530.64
ORD02373	CUST0694	SELL085	2024-07-25	\N	Returned	411002.40
ORD02374	CUST0694	SELL071	2024-06-24	2024-07-01	Delivered	962.48
ORD02375	CUST0695	SELL061	2024-11-28	\N	Cancelled	753553.79
ORD02376	CUST0695	SELL065	2024-08-30	2024-09-05	Delivered	55939.01
ORD02377	CUST0695	SELL045	2024-09-09	\N	Cancelled	19355.44
ORD02378	CUST0695	SELL024	2024-09-15	2024-09-21	Delivered	11275.57
ORD02379	CUST0695	SELL025	2024-09-26	2024-10-01	Delivered	159247.16
ORD02380	CUST0695	SELL006	2024-11-30	2024-12-02	Delivered	631738.02
ORD02381	CUST0695	SELL059	2024-10-05	2024-10-07	Delivered	8224.90
ORD02382	CUST0695	SELL017	2024-10-05	2024-10-10	Delivered	111972.04
ORD02383	CUST0696	SELL053	2024-12-02	2024-12-06	Delivered	1116444.00
ORD02384	CUST0696	SELL087	2024-11-26	\N	Shipped	10094.25
ORD02385	CUST0696	SELL088	2024-11-25	2024-12-03	Delivered	1019787.06
ORD02386	CUST0696	SELL059	2024-12-21	2024-12-30	Delivered	\N
ORD02387	CUST0696	SELL090	2024-12-06	\N	Returned	177033.40
ORD02388	CUST0697	SELL014	2024-09-20	2024-09-24	Delivered	718474.40
ORD02389	CUST0697	SELL081	2024-09-07	\N	Processing	468599.00
ORD02390	CUST0697	SELL013	2024-09-01	2024-09-08	Delivered	15172.98
ORD02391	CUST0697	SELL026	2024-10-27	2024-11-04	Delivered	138284.58
ORD02392	CUST0697	SELL070	2024-04-25	\N	Cancelled	199046.54
ORD02393	CUST0697	SELL035	2024-11-23	\N	Shipped	322328.61
ORD02394	CUST0697	SELL028	2024-11-24	\N	Processing	86940.02
ORD02395	CUST0697	SELL064	2024-07-29	2024-08-01	Delivered	2457784.65
ORD02396	CUST0700	SELL004	2024-10-17	\N	Returned	102946.51
ORD02397	CUST0700	SELL046	2024-11-30	2024-12-07	Delivered	\N
ORD02398	CUST0700	SELL034	2024-12-30	2025-01-04	Delivered	1162569.20
ORD02399	CUST0700	SELL024	2024-11-04	2024-11-10	Delivered	70846.58
ORD02400	CUST0701	SELL016	2024-12-30	\N	Shipped	322428.84
ORD02401	CUST0701	SELL001	2024-12-14	2024-12-21	Delivered	965244.47
ORD02402	CUST0701	SELL026	2024-07-03	2024-07-10	Delivered	1457210.64
ORD02403	CUST0701	SELL060	2023-12-20	2023-12-25	Delivered	287162.35
ORD02404	CUST0701	SELL055	2023-12-30	\N	Cancelled	32467.71
ORD02405	CUST0701	SELL047	2024-09-27	2024-10-02	Delivered	73459.05
ORD02406	CUST0702	SELL073	2024-05-13	2024-05-19	Delivered	465732.88
ORD02407	CUST0703	SELL082	2024-12-21	\N	Cancelled	49184.99
ORD02408	CUST0703	SELL058	2024-12-24	2025-01-03	Delivered	140423.37
ORD02409	CUST0703	SELL078	2024-09-17	2024-09-25	Delivered	106282.78
ORD02410	CUST0703	SELL008	2024-01-28	\N	Cancelled	120311.33
ORD02411	CUST0703	SELL073	2024-02-13	\N	Cancelled	270089.35
ORD02412	CUST0704	SELL006	2024-09-13	\N	Cancelled	63820.60
ORD02413	CUST0704	SELL048	2024-11-15	\N	Processing	124795.26
ORD02414	CUST0706	SELL033	2024-10-17	\N	Shipped	247264.61
ORD02415	CUST0707	SELL016	2024-08-18	2024-08-25	Delivered	359945.69
ORD02416	CUST0707	SELL043	2024-10-24	\N	Cancelled	325750.81
ORD02417	CUST0707	SELL073	2024-11-02	\N	Returned	39477.92
ORD02418	CUST0707	SELL027	2024-09-14	2024-09-21	Delivered	4792.40
ORD02419	CUST0708	SELL059	2024-01-20	\N	Shipped	16693.05
ORD02420	CUST0708	SELL058	2024-11-02	\N	Processing	602012.32
ORD02421	CUST0708	SELL059	2024-06-04	\N	Cancelled	1123054.56
ORD02422	CUST0708	SELL009	2024-12-23	2024-12-30	Delivered	20728.76
ORD02423	CUST0709	SELL015	2024-07-26	2024-07-30	Delivered	2690559.32
ORD02424	CUST0710	SELL081	2024-09-20	\N	Shipped	80490.90
ORD02425	CUST0710	SELL064	2024-08-16	2024-08-23	Delivered	27425.31
ORD02426	CUST0710	SELL053	2024-08-20	\N	Processing	643395.88
ORD02427	CUST0710	SELL037	2024-10-21	\N	Shipped	176964.02
ORD02428	CUST0711	SELL022	2024-12-21	\N	Returned	122316.70
ORD02429	CUST0711	SELL032	2024-10-13	\N	Processing	86080.60
ORD02430	CUST0712	SELL034	2024-06-25	\N	Processing	59216.26
ORD02431	CUST0712	SELL046	2023-09-29	2023-10-04	Delivered	164442.78
ORD02432	CUST0712	SELL001	2023-10-08	\N	Returned	376793.55
ORD02433	CUST0712	SELL011	2024-06-22	2024-06-28	Delivered	124099.07
ORD02434	CUST0712	SELL002	2024-08-17	2024-08-24	Delivered	513753.00
ORD02435	CUST0712	SELL041	2024-09-26	\N	Returned	161129.66
ORD02436	CUST0713	SELL039	2023-09-13	\N	Returned	\N
ORD02437	CUST0713	SELL065	2023-12-30	2024-01-05	Delivered	54574.89
ORD02438	CUST0713	SELL051	2024-03-20	\N	Returned	317681.73
ORD02439	CUST0713	SELL006	2023-04-16	2023-04-22	Delivered	15152.82
ORD02440	CUST0714	SELL080	2024-12-25	2024-12-28	Delivered	441311.10
ORD02441	CUST0714	SELL059	2024-11-04	2024-11-08	Delivered	567444.59
ORD02442	CUST0714	SELL004	2024-11-03	\N	Cancelled	714561.84
ORD02443	CUST0714	SELL031	2024-12-27	\N	Processing	2887.44
ORD02444	CUST0714	SELL033	2024-11-05	2024-11-11	Delivered	51056.48
ORD02445	CUST0714	SELL041	2024-11-09	2024-11-11	Delivered	2365.76
ORD02446	CUST0714	SELL061	2024-10-25	\N	Processing	24556.56
ORD02447	CUST0714	SELL055	2024-12-27	2025-01-02	Delivered	180785.23
ORD02448	CUST0714	SELL023	2024-12-16	\N	Returned	\N
ORD02449	CUST0714	SELL019	2024-12-22	\N	Shipped	14402.86
ORD02450	CUST0714	SELL056	2024-12-03	2024-12-04	Delivered	678774.80
ORD02451	CUST0714	SELL014	2024-11-12	2024-11-18	Delivered	166842.38
ORD02452	CUST0714	SELL062	2024-12-13	\N	Cancelled	214085.70
ORD02453	CUST0714	SELL055	2024-11-19	2024-11-20	Delivered	492503.63
ORD02454	CUST0715	SELL084	2024-09-02	2024-09-11	Delivered	16768.75
ORD02455	CUST0715	SELL085	2024-08-21	\N	Cancelled	\N
ORD02456	CUST0715	SELL031	2024-09-20	2024-09-23	Delivered	1611658.56
ORD02457	CUST0715	SELL046	2024-08-10	\N	Cancelled	\N
ORD02458	CUST0716	SELL025	2023-12-10	\N	Processing	793406.76
ORD02459	CUST0717	SELL013	2024-12-31	\N	Returned	33000.44
ORD02460	CUST0717	SELL055	2024-07-07	\N	Shipped	157895.28
ORD02461	CUST0719	SELL018	2024-11-25	2024-11-28	Delivered	23275.64
ORD02462	CUST0720	SELL015	2024-07-23	2024-08-03	Delivered	177033.40
ORD02463	CUST0720	SELL084	2024-10-21	\N	Processing	267405.41
ORD02464	CUST0720	SELL075	2024-07-20	2024-07-28	Delivered	42851.74
ORD02465	CUST0720	SELL003	2024-07-31	2024-08-04	Delivered	1456956.16
ORD02466	CUST0720	SELL032	2024-10-17	\N	Processing	76579.25
ORD02467	CUST0720	SELL004	2024-06-28	\N	Returned	1620739.88
ORD02468	CUST0720	SELL061	2024-09-25	\N	Returned	280551.90
ORD02469	CUST0721	SELL017	2024-12-22	2024-12-28	Delivered	128378.51
ORD02470	CUST0721	SELL003	2024-09-12	\N	Processing	3538.98
ORD02471	CUST0721	SELL044	2024-09-18	2024-09-20	Delivered	32317.65
ORD02472	CUST0721	SELL019	2024-11-03	\N	Processing	323877.39
ORD02473	CUST0721	SELL011	2024-12-01	2024-12-07	Delivered	253301.20
ORD02474	CUST0721	SELL059	2024-12-04	\N	Cancelled	14265.27
ORD02475	CUST0722	SELL011	2024-12-04	2024-12-09	Delivered	11018.01
ORD02476	CUST0722	SELL076	2023-11-15	2023-11-16	Delivered	513753.00
ORD02477	CUST0722	SELL059	2024-12-24	2024-12-30	Delivered	50986.52
ORD02478	CUST0722	SELL087	2024-09-27	2024-09-30	Delivered	127701.09
ORD02479	CUST0723	SELL014	2024-01-19	\N	Shipped	94456.29
ORD02480	CUST0723	SELL031	2024-03-17	\N	Cancelled	163163.25
ORD02481	CUST0723	SELL054	2024-02-06	\N	Cancelled	889014.58
ORD02482	CUST0723	SELL045	2023-11-10	\N	Returned	64022.61
ORD02483	CUST0723	SELL005	2024-02-26	2024-03-04	Delivered	81994.48
ORD02484	CUST0724	SELL083	2024-12-25	\N	Shipped	\N
ORD02485	CUST0724	SELL080	2024-10-03	2024-10-10	Delivered	190414.55
ORD02486	CUST0724	SELL047	2024-09-11	\N	Returned	141210.13
ORD02487	CUST0724	SELL071	2024-11-25	\N	Shipped	201079.90
ORD02488	CUST0724	SELL038	2024-12-29	2025-01-05	Delivered	7571.15
ORD02489	CUST0725	SELL016	2023-09-28	2023-09-29	Delivered	245132.44
ORD02490	CUST0725	SELL085	2023-08-23	\N	Returned	889298.04
ORD02491	CUST0726	SELL079	2024-12-06	\N	Cancelled	1023203.23
ORD02492	CUST0726	SELL065	2024-10-22	\N	Shipped	611372.36
ORD02493	CUST0726	SELL066	2024-11-13	2024-11-14	Delivered	34344.46
ORD02494	CUST0727	SELL013	2024-07-02	\N	Processing	286186.93
ORD02495	CUST0727	SELL035	2024-08-20	2024-08-25	Delivered	21115.71
ORD02496	CUST0728	SELL038	2024-11-25	\N	Returned	90604.84
ORD02497	CUST0728	SELL020	2024-12-13	\N	Returned	264786.66
ORD02498	CUST0728	SELL004	2024-06-01	\N	Cancelled	318689.03
ORD02499	CUST0729	SELL047	2024-04-18	\N	Processing	1398698.82
ORD02500	CUST0729	SELL086	2024-07-02	\N	Cancelled	5238.20
ORD02501	CUST0729	SELL080	2024-08-29	\N	Returned	81363.84
ORD02502	CUST0729	SELL043	2024-08-09	\N	Processing	27810.90
ORD02503	CUST0730	SELL048	2024-12-30	\N	Returned	127701.09
ORD02504	CUST0730	SELL024	2024-12-14	2024-12-15	Delivered	965078.43
ORD02505	CUST0730	SELL086	2024-07-13	\N	Returned	\N
ORD02506	CUST0731	SELL075	2024-08-25	\N	Cancelled	229304.79
ORD02507	CUST0731	SELL036	2024-12-29	2025-01-03	Delivered	82134.60
ORD02508	CUST0731	SELL032	2024-04-06	2024-04-18	Delivered	44547.39
ORD02509	CUST0731	SELL066	2023-09-24	2023-10-05	Delivered	148168.66
ORD02510	CUST0731	SELL046	2024-07-19	2024-07-30	Delivered	337634.60
ORD02511	CUST0732	SELL078	2024-09-15	\N	Returned	49772.57
ORD02512	CUST0732	SELL033	2024-08-12	2024-08-18	Delivered	55613.62
ORD02513	CUST0732	SELL038	2024-07-13	\N	Returned	12764.12
ORD02514	CUST0732	SELL088	2024-11-30	\N	Processing	257919.31
ORD02515	CUST0732	SELL064	2024-08-18	2024-08-25	Delivered	33482.97
ORD02516	CUST0732	SELL046	2024-12-12	\N	Returned	66428.57
ORD02517	CUST0733	SELL085	2024-12-13	\N	Returned	107654.08
ORD02518	CUST0733	SELL027	2024-06-28	2024-07-03	Delivered	46511.08
ORD02519	CUST0733	SELL086	2024-08-30	\N	Returned	103217.04
ORD02520	CUST0734	SELL049	2023-07-16	2023-07-21	Delivered	14461.31
ORD02521	CUST0734	SELL017	2023-08-23	\N	Returned	1522427.71
ORD02522	CUST0734	SELL018	2024-04-05	2024-04-10	Delivered	38612.32
ORD02523	CUST0734	SELL028	2024-02-25	\N	Returned	499500.17
ORD02524	CUST0736	SELL018	2024-03-06	2024-03-08	Delivered	20703.44
ORD02525	CUST0736	SELL081	2023-10-04	\N	Shipped	11779.00
ORD02526	CUST0736	SELL044	2024-04-14	\N	Shipped	7571.15
ORD02527	CUST0736	SELL046	2023-11-29	2023-12-01	Delivered	110269.71
ORD02528	CUST0736	SELL007	2024-10-21	\N	Shipped	626693.80
ORD02529	CUST0736	SELL079	2023-07-05	\N	Shipped	165613.95
ORD02530	CUST0737	SELL059	2023-08-16	\N	Returned	1051421.01
ORD02531	CUST0737	SELL061	2023-03-06	\N	Cancelled	1111622.55
ORD02532	CUST0737	SELL016	2023-08-13	\N	Shipped	201713.20
ORD02533	CUST0737	SELL005	2024-01-31	\N	Cancelled	121332.02
ORD02534	CUST0737	SELL060	2024-12-03	\N	Cancelled	417951.56
ORD02535	CUST0737	SELL008	2024-09-20	\N	Cancelled	668176.69
ORD02536	CUST0737	SELL004	2023-12-17	2023-12-22	Delivered	40996.15
ORD02537	CUST0737	SELL063	2024-08-15	\N	Returned	\N
ORD02538	CUST0737	SELL013	2024-02-15	\N	Cancelled	829768.29
ORD02539	CUST0737	SELL051	2023-09-02	\N	Shipped	75063.14
ORD02540	CUST0737	SELL037	2024-02-16	2024-02-19	Delivered	288317.26
ORD02541	CUST0737	SELL089	2023-04-22	\N	Returned	10854.84
ORD02542	CUST0738	SELL078	2024-02-09	\N	Shipped	252370.13
ORD02543	CUST0739	SELL090	2024-12-13	\N	Cancelled	352776.27
ORD02544	CUST0740	SELL038	2024-06-18	\N	Shipped	133677.94
ORD02545	CUST0740	SELL015	2024-06-22	2024-06-24	Delivered	140361.00
ORD02546	CUST0740	SELL057	2024-08-12	\N	Shipped	38469.79
ORD02547	CUST0740	SELL058	2024-09-25	2024-09-30	Delivered	563928.96
ORD02548	CUST0740	SELL029	2024-06-12	\N	Processing	112214.93
ORD02549	CUST0740	SELL024	2024-10-05	2024-10-09	Delivered	1810580.04
ORD02550	CUST0740	SELL050	2024-09-05	2024-09-12	Delivered	199058.95
ORD02551	CUST0740	SELL043	2024-04-02	\N	Shipped	1053964.00
ORD02552	CUST0740	SELL052	2024-08-05	\N	Processing	18283.54
ORD02553	CUST0740	SELL087	2024-08-16	\N	Cancelled	34862.69
ORD02554	CUST0740	SELL013	2024-04-14	2024-04-18	Delivered	38310.15
ORD02555	CUST0741	SELL037	2024-04-17	\N	Shipped	9270.30
ORD02556	CUST0741	SELL059	2024-06-30	2024-07-06	Delivered	251501.84
ORD02557	CUST0741	SELL065	2024-05-03	2024-05-06	Delivered	79945.84
ORD02558	CUST0741	SELL063	2024-04-15	2024-04-17	Delivered	351651.77
ORD02559	CUST0741	SELL027	2024-10-30	2024-11-03	Delivered	445358.44
ORD02560	CUST0741	SELL021	2024-11-23	\N	Shipped	337113.25
ORD02561	CUST0741	SELL018	2024-01-08	\N	Processing	160055.92
ORD02562	CUST0744	SELL084	2023-12-22	2023-12-26	Delivered	207023.97
ORD02563	CUST0744	SELL013	2023-11-16	\N	Cancelled	161049.76
ORD02564	CUST0744	SELL052	2024-06-27	\N	Processing	276649.37
ORD02565	CUST0744	SELL044	2024-08-18	\N	Returned	155807.07
ORD02566	CUST0744	SELL069	2024-01-13	\N	Cancelled	205793.45
ORD02567	CUST0744	SELL036	2024-07-16	2024-07-22	Delivered	198153.24
ORD02568	CUST0745	SELL022	2024-06-03	\N	Shipped	71484.11
ORD02569	CUST0747	SELL026	2024-11-29	2024-12-03	Delivered	125318.47
ORD02570	CUST0747	SELL073	2024-12-29	\N	Returned	342491.29
ORD02571	CUST0747	SELL065	2024-10-23	2024-10-26	Delivered	131993.61
ORD02572	CUST0747	SELL014	2024-12-05	2024-12-09	Delivered	17641.20
ORD02573	CUST0747	SELL067	2024-11-22	2024-11-28	Delivered	353048.88
ORD02574	CUST0747	SELL059	2024-11-15	\N	Returned	252338.09
ORD02575	CUST0748	SELL070	2024-12-31	\N	Shipped	108888.85
ORD02576	CUST0748	SELL050	2024-01-28	\N	Shipped	252324.34
ORD02577	CUST0748	SELL051	2023-08-19	\N	Cancelled	116422.40
ORD02578	CUST0748	SELL062	2024-10-24	2024-11-01	Delivered	341616.01
ORD02579	CUST0748	SELL078	2024-07-18	\N	Processing	577031.11
ORD02580	CUST0748	SELL047	2023-07-05	\N	Processing	712905.14
ORD02581	CUST0748	SELL020	2023-12-02	2023-12-06	Delivered	32929.20
ORD02582	CUST0748	SELL087	2023-10-27	\N	Cancelled	5889.50
ORD02583	CUST0749	SELL012	2024-09-24	2024-09-29	Delivered	2087573.62
ORD02584	CUST0749	SELL068	2024-07-19	2024-07-22	Delivered	87684.88
ORD02585	CUST0750	SELL032	2024-12-30	\N	Cancelled	1297591.76
ORD02586	CUST0750	SELL060	2024-10-07	2024-10-09	Delivered	342501.25
ORD02587	CUST0750	SELL063	2024-11-27	2024-12-02	Delivered	219122.04
ORD02588	CUST0750	SELL044	2024-11-10	2024-11-15	Delivered	127701.09
ORD02589	CUST0750	SELL044	2024-11-14	2024-11-17	Delivered	198852.85
ORD02590	CUST0751	SELL029	2024-07-28	\N	Shipped	70928.68
ORD02591	CUST0751	SELL037	2024-09-29	\N	Cancelled	64965.08
ORD02592	CUST0751	SELL089	2024-05-05	2024-05-06	Delivered	130707.25
ORD02593	CUST0751	SELL012	2024-10-15	2024-10-21	Delivered	101814.33
ORD02594	CUST0751	SELL006	2024-09-26	\N	Cancelled	26461.80
ORD02595	CUST0751	SELL033	2024-08-01	2024-08-04	Delivered	804244.85
ORD02596	CUST0751	SELL089	2024-05-30	2024-06-01	Delivered	403051.28
ORD02597	CUST0751	SELL007	2024-09-23	2024-09-28	Delivered	39288.15
ORD02598	CUST0751	SELL048	2024-07-18	\N	Cancelled	121518.49
ORD02599	CUST0751	SELL044	2024-11-15	2024-11-17	Delivered	25947.77
ORD02600	CUST0752	SELL040	2023-11-07	\N	Cancelled	543993.24
ORD02601	CUST0752	SELL068	2024-09-07	\N	Returned	817539.36
ORD02602	CUST0752	SELL041	2023-11-25	2023-11-29	Delivered	700393.60
ORD02603	CUST0753	SELL050	2024-10-22	\N	Cancelled	561783.10
ORD02604	CUST0753	SELL030	2024-07-16	2024-07-22	Delivered	81167.53
ORD02605	CUST0753	SELL073	2024-12-23	2024-12-24	Delivered	108875.43
ORD02606	CUST0753	SELL082	2024-10-11	2024-10-16	Delivered	180084.64
ORD02607	CUST0753	SELL009	2024-10-22	2024-10-25	Delivered	33826.71
ORD02608	CUST0753	SELL029	2024-11-10	2024-11-11	Delivered	223132.14
ORD02609	CUST0753	SELL025	2024-08-20	2024-08-26	Delivered	71981.01
ORD02610	CUST0753	SELL018	2024-09-29	\N	Cancelled	1191774.97
ORD02611	CUST0753	SELL060	2024-07-26	\N	Shipped	378000.32
ORD02612	CUST0753	SELL057	2024-07-25	\N	Shipped	134609.96
ORD02613	CUST0753	SELL029	2024-09-30	\N	Returned	186496.12
ORD02614	CUST0753	SELL003	2024-10-12	\N	Shipped	321009.41
ORD02615	CUST0755	SELL019	2024-11-05	\N	Processing	217385.44
ORD02616	CUST0756	SELL078	2024-12-27	\N	Cancelled	368101.30
ORD02617	CUST0756	SELL056	2024-11-15	\N	Returned	416845.36
ORD02618	CUST0756	SELL012	2024-12-15	\N	Returned	115608.82
ORD02619	CUST0756	SELL067	2024-12-17	\N	Returned	55416.96
ORD02620	CUST0756	SELL088	2024-12-25	2024-12-27	Delivered	651771.68
ORD02621	CUST0758	SELL031	2024-07-24	\N	Returned	598466.49
ORD02622	CUST0758	SELL027	2024-12-18	2024-12-25	Delivered	87218.15
ORD02623	CUST0758	SELL021	2024-11-15	\N	Shipped	687279.15
ORD02624	CUST0758	SELL010	2024-06-21	2024-06-23	Delivered	1198474.16
ORD02625	CUST0758	SELL071	2024-06-07	2024-06-08	Delivered	34507.56
ORD02626	CUST0760	SELL059	2024-11-13	\N	Returned	\N
ORD02627	CUST0760	SELL011	2024-12-14	\N	Returned	680961.73
ORD02628	CUST0760	SELL010	2024-12-26	2025-01-03	Delivered	26230.02
ORD02629	CUST0760	SELL008	2024-12-06	\N	Shipped	1636649.83
ORD02630	CUST0760	SELL067	2024-12-16	2024-12-30	Delivered	15371.06
ORD02631	CUST0760	SELL022	2024-12-18	2024-12-24	Delivered	290642.30
ORD02632	CUST0760	SELL090	2024-12-22	2024-12-29	Delivered	70682.86
ORD02633	CUST0761	SELL084	2024-08-31	2024-09-02	Delivered	716591.83
ORD02634	CUST0762	SELL064	2024-12-28	2025-01-05	Delivered	160965.44
ORD02635	CUST0762	SELL060	2024-11-18	\N	Shipped	111030.12
ORD02636	CUST0762	SELL022	2024-11-27	2024-12-03	Delivered	468450.06
ORD02637	CUST0763	SELL003	2024-01-12	2024-01-19	Delivered	871926.90
ORD02638	CUST0763	SELL008	2024-07-18	2024-07-19	Delivered	586313.81
ORD02639	CUST0764	SELL064	2024-12-26	2024-12-28	Delivered	\N
ORD02640	CUST0764	SELL084	2024-12-09	\N	Shipped	75662.76
ORD02641	CUST0764	SELL001	2024-12-15	\N	Returned	149032.56
ORD02642	CUST0764	SELL018	2024-12-23	2024-12-29	Delivered	1459370.17
ORD02643	CUST0767	SELL050	2024-07-16	\N	Shipped	299192.34
ORD02644	CUST0768	SELL035	2024-07-25	2024-07-31	Delivered	245007.21
ORD02645	CUST0769	SELL052	2024-12-04	\N	Cancelled	608717.00
ORD02646	CUST0769	SELL067	2024-05-28	\N	Shipped	246601.80
ORD02647	CUST0769	SELL090	2024-10-30	2024-11-02	Delivered	45816.72
ORD02648	CUST0770	SELL004	2024-07-30	\N	Cancelled	1465053.05
ORD02649	CUST0771	SELL062	2023-08-18	\N	Shipped	227490.03
ORD02650	CUST0771	SELL021	2024-01-24	2024-01-29	Delivered	255676.46
ORD02651	CUST0771	SELL068	2023-12-06	\N	Cancelled	116166.10
ORD02652	CUST0772	SELL044	2024-06-17	2024-06-23	Delivered	427359.18
ORD02653	CUST0772	SELL068	2024-10-14	2024-10-19	Delivered	340737.24
ORD02654	CUST0772	SELL030	2024-10-30	2024-11-04	Delivered	38292.36
ORD02655	CUST0772	SELL071	2024-04-20	\N	Cancelled	39264.98
ORD02656	CUST0772	SELL040	2024-07-05	\N	Processing	923488.82
ORD02657	CUST0772	SELL018	2024-07-24	\N	Returned	11866.30
ORD02658	CUST0772	SELL054	2024-09-03	2024-09-10	Delivered	\N
ORD02659	CUST0772	SELL005	2024-07-01	2024-07-05	Delivered	6057.15
ORD02660	CUST0772	SELL038	2024-08-15	2024-08-22	Delivered	430074.55
ORD02661	CUST0772	SELL022	2024-11-11	\N	Returned	172825.59
ORD02662	CUST0773	SELL035	2024-10-14	2024-10-18	Delivered	288258.95
ORD02663	CUST0773	SELL027	2024-04-10	2024-04-14	Delivered	7958.84
ORD02664	CUST0774	SELL008	2024-01-21	2024-01-23	Delivered	86513.92
ORD02665	CUST0774	SELL088	2023-10-29	2023-11-02	Delivered	\N
ORD02666	CUST0774	SELL031	2024-03-07	\N	Shipped	263416.03
ORD02667	CUST0774	SELL002	2023-10-20	\N	Returned	171576.08
ORD02668	CUST0774	SELL040	2024-03-16	2024-03-25	Delivered	1118094.17
ORD02669	CUST0774	SELL055	2023-02-24	2023-02-26	Delivered	8076.20
ORD02670	CUST0776	SELL025	2024-10-22	\N	Returned	276589.43
ORD02671	CUST0778	SELL080	2024-07-24	\N	Cancelled	37861.18
ORD02672	CUST0778	SELL034	2024-09-20	\N	Shipped	249096.11
ORD02673	CUST0778	SELL058	2024-11-13	\N	Processing	56478.55
ORD02674	CUST0778	SELL018	2024-08-22	\N	Processing	486073.96
ORD02675	CUST0778	SELL069	2024-08-14	\N	Returned	1599720.00
ORD02676	CUST0778	SELL028	2024-11-27	2024-12-05	Delivered	\N
ORD02677	CUST0778	SELL027	2024-11-12	\N	Returned	7785.89
ORD02678	CUST0778	SELL078	2024-07-07	2024-07-12	Delivered	10193.83
ORD02679	CUST0778	SELL031	2024-08-09	\N	Cancelled	7785.89
ORD02680	CUST0778	SELL053	2024-12-25	\N	Cancelled	139770.08
ORD02681	CUST0778	SELL003	2024-12-02	2024-12-10	Delivered	\N
ORD02682	CUST0778	SELL014	2024-07-17	2024-07-23	Delivered	100741.91
ORD02683	CUST0779	SELL042	2024-11-17	\N	Returned	151860.31
ORD02684	CUST0779	SELL076	2024-08-31	\N	Processing	16449.80
ORD02685	CUST0779	SELL063	2024-06-25	2024-06-30	Delivered	294318.98
ORD02686	CUST0779	SELL011	2024-06-08	2024-06-10	Delivered	95598.42
ORD02687	CUST0779	SELL073	2024-04-10	\N	Cancelled	222603.78
ORD02688	CUST0779	SELL075	2024-05-21	\N	Returned	1280461.82
ORD02689	CUST0779	SELL017	2024-02-26	2024-02-29	Delivered	14928.20
ORD02690	CUST0779	SELL044	2024-06-23	2024-07-03	Delivered	\N
ORD02691	CUST0779	SELL054	2024-05-17	2024-05-23	Delivered	46511.08
ORD02692	CUST0779	SELL019	2024-02-11	\N	Cancelled	27088.10
ORD02693	CUST0779	SELL064	2024-02-16	\N	Cancelled	48671.74
ORD02694	CUST0779	SELL025	2024-07-08	\N	Shipped	237309.76
ORD02695	CUST0782	SELL008	2024-11-18	\N	Returned	295881.30
ORD02696	CUST0782	SELL056	2024-08-12	\N	Returned	8480.78
ORD02697	CUST0782	SELL070	2024-05-19	2024-05-24	Delivered	45877.96
ORD02698	CUST0783	SELL060	2024-05-06	2024-05-10	Delivered	173094.92
ORD02699	CUST0783	SELL008	2024-02-11	\N	Cancelled	7869.35
ORD02700	CUST0783	SELL015	2023-11-21	2023-11-28	Delivered	68496.96
ORD02701	CUST0783	SELL007	2024-01-26	2024-01-28	Delivered	313387.28
ORD02702	CUST0783	SELL009	2023-10-06	2023-10-12	Delivered	18690.33
ORD02703	CUST0783	SELL033	2024-06-27	2024-07-01	Delivered	38061.27
ORD02704	CUST0783	SELL016	2024-01-31	\N	Returned	96496.00
ORD02705	CUST0784	SELL033	2024-02-24	\N	Returned	59548.32
ORD02706	CUST0784	SELL022	2024-05-19	\N	Processing	240879.20
ORD02707	CUST0784	SELL027	2024-06-22	\N	Cancelled	848320.28
ORD02708	CUST0784	SELL076	2023-09-13	\N	Cancelled	1242167.50
ORD02709	CUST0784	SELL056	2024-04-14	\N	Shipped	44272.74
ORD02710	CUST0784	SELL022	2023-07-19	2023-07-22	Delivered	74227.75
ORD02711	CUST0784	SELL009	2024-05-22	2024-05-23	Delivered	19732.78
ORD02712	CUST0784	SELL079	2024-04-22	2024-04-23	Delivered	140246.84
ORD02713	CUST0784	SELL065	2023-08-03	\N	Returned	323870.71
ORD02714	CUST0784	SELL055	2024-11-07	2024-11-13	Delivered	24463.34
ORD02715	CUST0784	SELL076	2024-04-19	2024-04-23	Delivered	219581.43
ORD02716	CUST0784	SELL023	2024-10-30	2024-11-05	Delivered	\N
ORD02717	CUST0784	SELL067	2023-08-11	2023-08-15	Delivered	527912.66
ORD02718	CUST0785	SELL006	2024-12-26	\N	Shipped	\N
ORD02719	CUST0785	SELL041	2024-12-19	\N	Shipped	8757.97
ORD02720	CUST0785	SELL054	2024-06-17	\N	Cancelled	2507221.79
ORD02721	CUST0785	SELL083	2024-04-13	\N	Shipped	222485.82
ORD02722	CUST0786	SELL053	2024-07-12	\N	Returned	52843.35
ORD02723	CUST0786	SELL024	2024-10-23	2024-10-27	Delivered	48431.34
ORD02724	CUST0786	SELL015	2024-03-19	2024-03-21	Delivered	818092.87
ORD02725	CUST0786	SELL068	2024-05-31	2024-06-02	Delivered	\N
ORD02726	CUST0786	SELL002	2024-12-03	2024-12-08	Delivered	110331.26
ORD02727	CUST0787	SELL038	2024-11-28	\N	Cancelled	\N
ORD02728	CUST0787	SELL005	2024-11-22	\N	Shipped	217385.44
ORD02729	CUST0789	SELL049	2024-05-19	2024-05-25	Delivered	44730.34
ORD02730	CUST0789	SELL011	2024-02-03	\N	Processing	6965.45
ORD02731	CUST0789	SELL055	2023-02-22	\N	Returned	193503.56
ORD02732	CUST0789	SELL013	2023-04-25	\N	Returned	56427.74
ORD02733	CUST0789	SELL055	2023-09-21	\N	Returned	50798.20
ORD02734	CUST0790	SELL084	2024-01-02	\N	Cancelled	8956.92
ORD02735	CUST0792	SELL023	2024-11-01	\N	Cancelled	1051465.44
ORD02736	CUST0792	SELL014	2024-01-05	\N	Returned	55183.61
ORD02737	CUST0792	SELL075	2024-05-19	2024-05-22	Delivered	403980.41
ORD02738	CUST0792	SELL017	2023-08-19	2023-08-22	Delivered	280143.99
ORD02739	CUST0792	SELL031	2024-11-10	2024-11-20	Delivered	161331.95
ORD02740	CUST0792	SELL074	2024-09-11	2024-09-17	Delivered	\N
ORD02741	CUST0792	SELL018	2024-08-13	\N	Processing	235978.86
ORD02742	CUST0792	SELL073	2024-03-18	\N	Returned	1815095.63
ORD02743	CUST0792	SELL041	2024-04-15	2024-04-21	Delivered	21790.46
ORD02744	CUST0792	SELL003	2024-09-06	2024-09-13	Delivered	1006071.55
ORD02745	CUST0792	SELL073	2023-11-09	\N	Shipped	124245.93
ORD02746	CUST0792	SELL004	2024-04-03	2024-04-12	Delivered	494280.20
ORD02747	CUST0793	SELL004	2024-07-06	2024-07-10	Delivered	1097468.41
ORD02748	CUST0793	SELL057	2024-07-01	\N	Shipped	397767.20
ORD02749	CUST0793	SELL049	2024-12-25	2024-12-30	Delivered	4809.30
ORD02750	CUST0793	SELL045	2024-10-12	\N	Returned	83542.55
ORD02751	CUST0793	SELL058	2023-12-12	2023-12-20	Delivered	22153.16
ORD02752	CUST0793	SELL044	2023-11-27	\N	Cancelled	26191.00
ORD02753	CUST0793	SELL007	2024-03-27	\N	Returned	74771.22
ORD02754	CUST0793	SELL055	2024-01-12	2024-01-16	Delivered	168684.73
ORD02755	CUST0793	SELL040	2024-09-08	2024-09-10	Delivered	16538.43
ORD02756	CUST0793	SELL002	2024-10-01	\N	Processing	1330904.90
ORD02757	CUST0793	SELL065	2023-12-12	2023-12-22	Delivered	232342.08
ORD02758	CUST0793	SELL082	2024-03-22	\N	Processing	851701.63
ORD02759	CUST0795	SELL084	2024-11-05	\N	Returned	1103202.87
ORD02760	CUST0795	SELL002	2024-04-26	\N	Cancelled	94516.59
ORD02761	CUST0796	SELL030	2024-10-23	\N	Returned	232783.60
ORD02762	CUST0797	SELL068	2024-10-17	\N	Processing	671864.12
ORD02763	CUST0797	SELL069	2024-11-28	\N	Cancelled	559472.66
ORD02764	CUST0797	SELL082	2024-08-02	2024-08-07	Delivered	356067.36
ORD02765	CUST0797	SELL061	2024-06-26	\N	Shipped	87419.50
ORD02766	CUST0797	SELL010	2024-07-24	2024-07-27	Delivered	636407.49
ORD02767	CUST0797	SELL086	2024-05-08	\N	Cancelled	172250.46
ORD02768	CUST0797	SELL035	2024-11-15	2024-11-24	Delivered	23962.00
ORD02769	CUST0797	SELL049	2024-04-08	2024-04-10	Delivered	38177.68
ORD02770	CUST0797	SELL023	2024-11-29	\N	Returned	411002.40
ORD02771	CUST0797	SELL054	2024-08-24	\N	Cancelled	109945.04
ORD02772	CUST0797	SELL039	2024-07-01	2024-07-07	Delivered	6169.57
ORD02773	CUST0797	SELL067	2024-04-26	\N	Returned	31709.48
ORD02774	CUST0798	SELL070	2023-11-10	\N	Processing	838846.42
ORD02775	CUST0798	SELL069	2024-04-26	\N	Processing	1924.96
ORD02776	CUST0800	SELL023	2024-07-12	2024-07-14	Delivered	57745.17
ORD02777	CUST0800	SELL027	2024-09-10	2024-09-15	Delivered	170697.47
ORD02778	CUST0800	SELL044	2024-03-29	2024-04-05	Delivered	298987.09
ORD02779	CUST0801	SELL015	2024-10-01	2024-10-05	Delivered	789376.88
ORD02780	CUST0801	SELL024	2024-10-28	2024-11-03	Delivered	2388424.82
ORD02781	CUST0801	SELL079	2024-10-12	\N	Shipped	801.07
ORD02782	CUST0801	SELL090	2024-10-08	\N	Shipped	3172.89
ORD02783	CUST0801	SELL088	2024-12-03	2024-12-05	Delivered	88011.45
ORD02784	CUST0801	SELL031	2024-10-06	2024-10-11	Delivered	102447.74
ORD02785	CUST0801	SELL065	2024-10-21	2024-10-23	Delivered	3329.98
ORD02786	CUST0801	SELL075	2024-08-27	2024-08-31	Delivered	504259.73
ORD02787	CUST0801	SELL012	2024-12-14	\N	Returned	51993.13
ORD02788	CUST0801	SELL041	2024-12-07	\N	Shipped	363996.06
ORD02789	CUST0801	SELL022	2024-10-08	2024-10-13	Delivered	622086.94
ORD02790	CUST0801	SELL026	2024-12-03	2024-12-07	Delivered	97086.56
ORD02791	CUST0802	SELL031	2024-10-10	\N	Processing	199481.86
ORD02792	CUST0802	SELL029	2024-05-22	2024-05-28	Delivered	772795.08
ORD02793	CUST0802	SELL047	2024-04-03	\N	Cancelled	476441.46
ORD02794	CUST0802	SELL046	2024-08-01	2024-08-06	Delivered	31709.48
ORD02795	CUST0802	SELL054	2024-03-01	2024-03-07	Delivered	760793.62
ORD02796	CUST0804	SELL080	2024-07-27	\N	Processing	48182.26
ORD02797	CUST0804	SELL063	2023-11-21	2023-11-27	Delivered	27918.16
ORD02798	CUST0804	SELL023	2023-12-17	2023-12-18	Delivered	305522.26
ORD02799	CUST0804	SELL009	2023-11-16	2023-11-23	Delivered	273170.78
ORD02800	CUST0805	SELL082	2024-10-17	\N	Shipped	329436.98
ORD02801	CUST0808	SELL046	2024-12-28	\N	Processing	545026.24
ORD02802	CUST0809	SELL075	2024-01-14	\N	Processing	99076.62
ORD02803	CUST0809	SELL084	2024-10-03	2024-10-10	Delivered	43039.35
ORD02804	CUST0809	SELL051	2023-08-10	2023-08-14	Delivered	644680.18
ORD02805	CUST0810	SELL030	2024-12-13	2024-12-19	Delivered	656895.94
ORD02806	CUST0811	SELL031	2024-07-08	\N	Processing	46265.11
ORD02807	CUST0811	SELL046	2024-01-21	2024-01-25	Delivered	4038.10
ORD02808	CUST0811	SELL003	2024-05-27	\N	Returned	1445727.65
ORD02809	CUST0811	SELL084	2023-09-04	2023-09-08	Delivered	181459.05
ORD02810	CUST0812	SELL035	2023-06-13	\N	Processing	249085.34
ORD02811	CUST0812	SELL008	2024-08-05	2024-08-06	Delivered	17976.54
ORD02812	CUST0812	SELL061	2024-11-17	2024-11-18	Delivered	5994.32
ORD02813	CUST0812	SELL065	2024-10-07	\N	Returned	47444.61
ORD02814	CUST0812	SELL052	2024-01-25	\N	Cancelled	198153.24
ORD02815	CUST0812	SELL061	2023-06-14	\N	Processing	27116.85
ORD02816	CUST0812	SELL027	2023-10-30	2023-11-04	Delivered	158091.35
ORD02817	CUST0813	SELL047	2024-08-23	\N	Cancelled	540868.00
ORD02818	CUST0813	SELL048	2024-09-21	2024-09-25	Delivered	52486.04
ORD02819	CUST0814	SELL061	2023-08-25	2023-08-29	Delivered	22093.77
ORD02820	CUST0814	SELL050	2024-01-25	2024-01-29	Delivered	619843.72
ORD02821	CUST0814	SELL069	2024-06-25	2024-07-01	Delivered	117073.40
ORD02822	CUST0814	SELL035	2024-03-22	2024-03-25	Delivered	\N
ORD02823	CUST0814	SELL078	2024-07-16	2024-07-17	Delivered	87588.60
ORD02824	CUST0814	SELL013	2024-01-09	\N	Cancelled	528936.56
ORD02825	CUST0814	SELL075	2024-11-20	\N	Shipped	131032.85
ORD02826	CUST0814	SELL064	2023-09-05	\N	Returned	1544358.47
ORD02827	CUST0814	SELL055	2023-07-24	\N	Returned	162456.53
ORD02828	CUST0814	SELL043	2024-02-10	\N	Cancelled	15798.46
ORD02829	CUST0815	SELL076	2024-12-19	2024-12-21	Delivered	286376.81
ORD02830	CUST0815	SELL004	2024-11-17	2024-11-21	Delivered	153518.44
ORD02831	CUST0815	SELL008	2024-09-28	2024-09-30	Delivered	105815.87
ORD02832	CUST0815	SELL003	2024-10-25	\N	Shipped	196582.07
ORD02833	CUST0815	SELL040	2024-12-21	2024-12-27	Delivered	841978.87
ORD02834	CUST0815	SELL016	2024-09-23	2024-09-30	Delivered	21277.86
ORD02835	CUST0816	SELL068	2024-10-05	2024-10-09	Delivered	614201.88
ORD02836	CUST0816	SELL063	2024-02-15	\N	Shipped	493640.21
ORD02837	CUST0816	SELL042	2024-07-20	2024-07-27	Delivered	142961.41
ORD02838	CUST0816	SELL076	2023-10-20	2023-10-26	Delivered	52486.04
ORD02839	CUST0816	SELL001	2023-12-12	\N	Returned	111171.38
ORD02840	CUST0816	SELL008	2024-05-19	2024-05-26	Delivered	44862.34
ORD02841	CUST0816	SELL060	2024-07-06	\N	Processing	5399.76
ORD02842	CUST0817	SELL028	2024-07-13	2024-07-17	Delivered	272051.99
ORD02843	CUST0817	SELL027	2023-04-15	\N	Returned	112490.00
ORD02844	CUST0817	SELL057	2023-09-09	\N	Processing	64022.61
ORD02845	CUST0817	SELL041	2023-11-14	\N	Cancelled	19637.44
ORD02846	CUST0817	SELL066	2024-01-05	2024-01-09	Delivered	553178.86
ORD02847	CUST0817	SELL090	2023-07-10	2023-07-17	Delivered	199684.92
ORD02848	CUST0817	SELL061	2023-04-21	\N	Returned	51810.86
ORD02849	CUST0817	SELL052	2024-06-06	2024-06-10	Delivered	982884.07
ORD02850	CUST0817	SELL065	2023-09-08	\N	Shipped	560667.61
ORD02851	CUST0817	SELL058	2023-04-23	\N	Shipped	21755.58
ORD02852	CUST0818	SELL084	2024-12-05	\N	Shipped	83872.29
ORD02853	CUST0818	SELL045	2024-09-15	2024-09-17	Delivered	194669.49
ORD02854	CUST0818	SELL035	2024-11-10	2024-11-19	Delivered	61048.20
ORD02855	CUST0818	SELL090	2024-11-13	\N	Processing	248810.57
ORD02856	CUST0818	SELL004	2024-10-21	2024-10-29	Delivered	539592.87
ORD02857	CUST0818	SELL089	2024-09-11	2024-09-20	Delivered	1557795.44
ORD02858	CUST0819	SELL043	2024-01-20	\N	Processing	2661200.53
ORD02859	CUST0819	SELL054	2023-11-26	\N	Shipped	52304.59
ORD02860	CUST0819	SELL032	2024-07-22	\N	Processing	13464.64
ORD02861	CUST0819	SELL013	2024-08-10	2024-08-20	Delivered	508025.72
ORD02862	CUST0819	SELL085	2024-11-26	\N	Cancelled	18232.92
ORD02863	CUST0820	SELL016	2024-12-05	\N	Returned	64321.19
ORD02864	CUST0820	SELL076	2024-03-26	\N	Cancelled	1494809.92
ORD02865	CUST0820	SELL004	2024-01-19	2024-02-02	Delivered	602198.00
ORD02866	CUST0821	SELL029	2024-08-19	2024-08-25	Delivered	1633.04
ORD02867	CUST0821	SELL014	2024-08-16	\N	Returned	474290.02
ORD02868	CUST0821	SELL056	2024-08-26	2024-08-29	Delivered	262877.04
ORD02869	CUST0821	SELL035	2024-12-02	\N	Processing	35114.37
ORD02870	CUST0821	SELL011	2024-09-14	2024-09-16	Delivered	193988.83
ORD02871	CUST0822	SELL066	2024-10-13	2024-10-20	Delivered	1454233.82
ORD02872	CUST0822	SELL073	2024-09-20	2024-09-25	Delivered	36035.42
ORD02873	CUST0822	SELL073	2024-10-11	2024-10-17	Delivered	236487.25
ORD02874	CUST0822	SELL050	2024-11-23	\N	Shipped	719457.16
ORD02875	CUST0822	SELL047	2024-11-27	2024-12-04	Delivered	\N
ORD02876	CUST0823	SELL040	2024-10-30	2024-11-04	Delivered	1698546.23
ORD02877	CUST0824	SELL002	2023-09-01	\N	Cancelled	674578.87
ORD02878	CUST0824	SELL059	2024-12-29	2024-12-31	Delivered	247085.24
ORD02879	CUST0824	SELL033	2023-10-22	2023-10-24	Delivered	687406.40
ORD02880	CUST0824	SELL082	2024-04-13	\N	Shipped	1332354.35
ORD02881	CUST0824	SELL003	2024-05-02	\N	Processing	287162.35
ORD02882	CUST0825	SELL083	2024-02-10	2024-02-17	Delivered	43501.45
ORD02883	CUST0825	SELL090	2024-01-27	\N	Shipped	7958.84
ORD02884	CUST0825	SELL082	2024-06-19	\N	Processing	20952.80
ORD02885	CUST0825	SELL082	2024-03-03	2024-03-09	Delivered	26206.57
ORD02886	CUST0825	SELL066	2024-03-23	2024-03-25	Delivered	\N
ORD02887	CUST0825	SELL058	2023-12-06	\N	Returned	178699.74
ORD02888	CUST0825	SELL028	2024-03-16	2024-03-19	Delivered	113221.27
ORD02889	CUST0826	SELL058	2024-07-07	2024-07-10	Delivered	776806.99
ORD02890	CUST0826	SELL068	2024-01-03	2024-01-06	Delivered	240879.20
ORD02891	CUST0827	SELL063	2024-11-01	\N	Processing	26579.20
ORD02892	CUST0827	SELL081	2024-07-15	2024-07-21	Delivered	527670.35
ORD02893	CUST0828	SELL032	2024-12-12	\N	Returned	425221.58
ORD02894	CUST0829	SELL054	2024-05-05	2024-05-12	Delivered	114123.99
ORD02895	CUST0830	SELL028	2024-10-06	\N	Processing	201980.35
ORD02896	CUST0830	SELL015	2024-11-23	\N	Shipped	264292.34
ORD02897	CUST0830	SELL055	2024-07-20	2024-07-25	Delivered	573477.05
ORD02898	CUST0830	SELL073	2024-12-25	2025-01-01	Delivered	126318.52
ORD02899	CUST0830	SELL013	2024-06-27	2024-06-28	Delivered	606004.23
ORD02900	CUST0830	SELL044	2024-08-17	2024-08-22	Delivered	1110784.70
ORD02901	CUST0830	SELL086	2024-11-04	\N	Returned	1308079.19
ORD02902	CUST0830	SELL038	2024-11-15	\N	Shipped	264386.43
ORD02903	CUST0830	SELL076	2024-08-23	2024-08-24	Delivered	581859.80
ORD02904	CUST0830	SELL042	2024-12-07	\N	Shipped	11209.32
ORD02905	CUST0830	SELL033	2024-09-27	2024-09-29	Delivered	\N
ORD02906	CUST0830	SELL057	2024-11-24	\N	Returned	1214404.96
ORD02907	CUST0830	SELL004	2024-11-03	2024-11-08	Delivered	1583210.41
ORD02908	CUST0830	SELL012	2024-07-04	\N	Processing	\N
ORD02909	CUST0831	SELL026	2024-03-11	2024-03-14	Delivered	88105.02
ORD02910	CUST0831	SELL049	2024-09-30	\N	Returned	1571373.93
ORD02911	CUST0831	SELL029	2024-10-27	2024-11-02	Delivered	64966.29
ORD02912	CUST0831	SELL012	2024-03-22	2024-03-26	Delivered	649434.60
ORD02913	CUST0831	SELL057	2024-12-04	2024-12-11	Delivered	32521.50
ORD02914	CUST0831	SELL009	2024-03-05	\N	Cancelled	182237.32
ORD02915	CUST0831	SELL016	2024-09-03	2024-09-05	Delivered	1458423.30
ORD02916	CUST0831	SELL065	2024-03-14	\N	Processing	487075.95
ORD02917	CUST0833	SELL086	2024-09-24	\N	Returned	121075.44
ORD02918	CUST0833	SELL041	2024-12-07	\N	Processing	47755.52
ORD02919	CUST0833	SELL075	2024-08-26	2024-08-31	Delivered	758332.90
ORD02920	CUST0833	SELL071	2024-06-19	2024-06-25	Delivered	\N
ORD02921	CUST0833	SELL014	2024-07-28	2024-08-03	Delivered	145167.24
ORD02922	CUST0833	SELL021	2024-12-20	2024-12-21	Delivered	38929.45
ORD02923	CUST0833	SELL089	2024-08-26	2024-08-27	Delivered	952072.75
ORD02924	CUST0833	SELL076	2024-11-07	2024-11-13	Delivered	8757.97
ORD02925	CUST0833	SELL021	2024-08-27	2024-09-01	Delivered	290501.34
ORD02926	CUST0833	SELL086	2024-08-16	\N	Cancelled	1337.62
ORD02927	CUST0833	SELL023	2024-10-13	\N	Processing	41185.06
ORD02928	CUST0833	SELL025	2024-10-29	2024-11-01	Delivered	44137.50
ORD02929	CUST0834	SELL064	2024-02-01	\N	Processing	26461.80
ORD02930	CUST0834	SELL032	2023-08-22	\N	Shipped	308912.61
ORD02931	CUST0834	SELL007	2023-05-10	\N	Cancelled	\N
ORD02932	CUST0835	SELL083	2024-07-10	\N	Cancelled	35910.44
ORD02933	CUST0835	SELL028	2024-11-14	2024-11-19	Delivered	69517.54
ORD02934	CUST0835	SELL030	2024-10-02	2024-10-04	Delivered	24683.24
ORD02935	CUST0836	SELL074	2024-07-16	\N	Shipped	\N
ORD02936	CUST0836	SELL082	2024-12-10	2024-12-15	Delivered	81118.15
ORD02937	CUST0836	SELL001	2024-09-01	2024-09-07	Delivered	45902.74
ORD02938	CUST0836	SELL035	2024-11-10	2024-11-11	Delivered	18483.24
ORD02939	CUST0836	SELL041	2024-10-16	2024-10-21	Delivered	69610.56
ORD02940	CUST0836	SELL057	2024-11-15	2024-11-20	Delivered	246866.05
ORD02941	CUST0836	SELL047	2024-09-30	\N	Shipped	141179.30
ORD02942	CUST0836	SELL032	2024-10-22	2024-10-26	Delivered	494813.66
ORD02943	CUST0836	SELL011	2024-11-16	\N	Returned	15152.82
ORD02944	CUST0836	SELL010	2024-10-19	\N	Shipped	138696.11
ORD02945	CUST0836	SELL077	2024-07-28	2024-07-30	Delivered	\N
ORD02946	CUST0836	SELL057	2024-08-30	2024-08-31	Delivered	110681.85
ORD02947	CUST0837	SELL036	2023-12-12	\N	Cancelled	149763.69
ORD02948	CUST0837	SELL014	2024-11-20	\N	Processing	569946.78
ORD02949	CUST0837	SELL075	2024-07-06	2024-07-13	Delivered	646154.12
ORD02950	CUST0837	SELL068	2024-09-07	2024-09-08	Delivered	132529.29
ORD02951	CUST0837	SELL061	2024-12-10	\N	Returned	1713468.86
ORD02952	CUST0838	SELL064	2024-12-29	2025-01-03	Delivered	118060.60
ORD02953	CUST0838	SELL057	2024-11-07	\N	Returned	\N
ORD02954	CUST0839	SELL058	2024-09-16	2024-09-18	Delivered	456816.78
ORD02955	CUST0839	SELL016	2024-12-01	2024-12-05	Delivered	29614.02
ORD02956	CUST0839	SELL057	2024-12-05	\N	Shipped	13361.05
ORD02957	CUST0839	SELL071	2024-12-07	\N	Processing	554133.17
ORD02958	CUST0840	SELL051	2024-01-13	2024-01-19	Delivered	\N
ORD02959	CUST0840	SELL005	2024-11-24	\N	Shipped	762526.05
ORD02960	CUST0840	SELL069	2024-02-14	\N	Processing	142340.25
ORD02961	CUST0843	SELL072	2024-10-25	\N	Cancelled	\N
ORD02962	CUST0843	SELL055	2024-03-10	\N	Processing	1028522.50
ORD02963	CUST0843	SELL065	2024-07-20	\N	Returned	26191.00
ORD02964	CUST0843	SELL055	2024-05-30	2024-06-03	Delivered	8757.97
ORD02965	CUST0843	SELL045	2024-09-15	\N	Shipped	\N
ORD02966	CUST0843	SELL017	2024-10-21	2024-10-27	Delivered	782053.66
ORD02967	CUST0843	SELL065	2024-12-06	\N	Returned	896407.98
ORD02968	CUST0843	SELL047	2024-08-31	2024-09-03	Delivered	\N
ORD02969	CUST0843	SELL060	2024-08-02	2024-08-03	Delivered	150550.83
ORD02970	CUST0843	SELL047	2024-05-06	2024-05-12	Delivered	16010.80
ORD02971	CUST0844	SELL040	2024-08-18	\N	Processing	17522.15
ORD02972	CUST0844	SELL003	2024-09-12	2024-09-16	Delivered	1446927.23
ORD02973	CUST0845	SELL084	2024-08-27	\N	Returned	198636.75
ORD02974	CUST0845	SELL066	2024-07-11	2024-07-14	Delivered	937404.21
ORD02975	CUST0845	SELL034	2024-11-10	\N	Returned	10914.08
ORD02976	CUST0847	SELL003	2024-10-16	2024-10-26	Delivered	3849.92
ORD02977	CUST0847	SELL088	2024-10-30	2024-11-01	Delivered	70592.32
ORD02978	CUST0847	SELL076	2024-10-03	2024-10-05	Delivered	73176.91
ORD02979	CUST0847	SELL038	2024-08-15	2024-08-25	Delivered	12599.24
ORD02980	CUST0847	SELL034	2024-09-05	2024-09-12	Delivered	202145.72
ORD02981	CUST0849	SELL021	2024-05-25	2024-06-01	Delivered	140213.78
ORD02982	CUST0849	SELL058	2024-07-20	\N	Cancelled	94945.56
ORD02983	CUST0849	SELL005	2024-07-15	2024-07-19	Delivered	194757.85
ORD02984	CUST0850	SELL037	2024-10-17	2024-10-20	Delivered	233857.94
ORD02985	CUST0851	SELL063	2024-08-23	\N	Cancelled	794553.45
ORD02986	CUST0851	SELL040	2024-09-10	\N	Returned	327919.04
ORD02987	CUST0851	SELL056	2024-08-27	2024-08-31	Delivered	300935.13
ORD02988	CUST0852	SELL020	2023-12-24	2023-12-28	Delivered	\N
ORD02989	CUST0852	SELL081	2024-05-30	2024-06-01	Delivered	26929.28
ORD02990	CUST0852	SELL008	2024-12-10	\N	Cancelled	24124.25
ORD02991	CUST0852	SELL040	2023-11-06	2023-11-08	Delivered	249606.15
ORD02992	CUST0854	SELL020	2024-01-07	2024-01-09	Delivered	213156.97
ORD02993	CUST0855	SELL038	2023-11-23	\N	Cancelled	43473.37
ORD02994	CUST0855	SELL010	2024-07-27	\N	Cancelled	15527.58
ORD02995	CUST0855	SELL052	2024-12-07	\N	Processing	156737.85
ORD02996	CUST0857	SELL016	2024-04-29	2024-05-03	Delivered	756814.31
ORD02997	CUST0858	SELL084	2024-03-09	2024-03-10	Delivered	126350.44
ORD02998	CUST0858	SELL018	2023-08-07	2023-08-11	Delivered	150088.30
ORD02999	CUST0858	SELL010	2024-08-04	\N	Shipped	17641.20
ORD03000	CUST0859	SELL041	2024-02-15	2024-02-16	Delivered	1071290.74
ORD03001	CUST0860	SELL019	2023-03-24	2023-03-27	Delivered	361991.39
ORD03002	CUST0860	SELL044	2023-06-19	\N	Shipped	20728.76
ORD03003	CUST0861	SELL017	2024-10-22	2024-10-26	Delivered	29754.99
ORD03004	CUST0861	SELL064	2024-11-26	\N	Shipped	418447.53
ORD03005	CUST0861	SELL068	2024-12-29	\N	Shipped	94625.99
ORD03006	CUST0861	SELL072	2024-11-18	2024-11-22	Delivered	697032.82
ORD03007	CUST0861	SELL026	2024-11-06	2024-11-09	Delivered	854934.30
ORD03008	CUST0862	SELL062	2024-11-30	2024-12-01	Delivered	423407.40
ORD03009	CUST0862	SELL058	2024-12-09	\N	Shipped	61427.21
ORD03010	CUST0862	SELL043	2024-12-03	\N	Cancelled	627134.37
ORD03011	CUST0862	SELL087	2024-12-26	\N	Returned	7617.12
ORD03012	CUST0862	SELL065	2024-12-04	\N	Returned	398461.26
ORD03013	CUST0862	SELL074	2024-12-19	\N	Processing	56807.28
ORD03014	CUST0864	SELL084	2024-09-19	\N	Shipped	596650.80
ORD03015	CUST0864	SELL047	2024-08-20	\N	Cancelled	6501.96
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payments (payment_id, order_id, payment_method, amount, payment_date) FROM stdin;
PAY00001	ORD00002	Mobile Money	\N	2024-09-10 16:00:00
PAY00002	ORD00003	Cash on Delivery	343428.55	2024-09-07 19:00:00
PAY00003	ORD00004	Cash on Delivery	26203.69	2023-12-11 15:00:00
PAY00004	ORD00005	Bank Transfer	6746.19	2023-11-19 13:00:00
PAY00005	ORD00006	Cash on Delivery	2257228.05	2024-06-29 03:00:00
PAY00006	ORD00008	Card	802557.78	2024-01-07 00:00:00
PAY00007	ORD00009	Mobile Money	1260295.96	2024-04-28 04:00:00
PAY00008	ORD00010	Mobile Money	87246.65	2024-03-25 08:00:00
PAY00009	ORD00011	Card	334130.92	2024-12-26 14:00:00
PAY00010	ORD00012	Card	314953.64	2024-05-25 18:00:00
PAY00011	ORD00013	Card	78337.96	2024-12-29 09:00:00
PAY00012	ORD00014	Cash on Delivery	580632.46	2024-02-15 06:00:00
PAY00013	ORD00015	Card	316660.38	2024-07-17 14:00:00
PAY00014	ORD00016	Card	2019.05	2024-08-21 05:00:00
PAY00015	ORD00017	Card	18690.33	2024-01-10 21:00:00
PAY00016	ORD00018	Mobile Money	\N	2024-04-19 16:00:00
PAY00017	ORD00019	Cash on Delivery	1154125.19	2023-10-30 04:00:00
PAY00018	ORD00021	Mobile Money	145236.92	2024-12-31 00:00:00
PAY00019	ORD00022	Mobile Money	663220.45	2024-12-15 21:00:00
PAY00020	ORD00024	Card	202012.48	2023-09-23 14:00:00
PAY00021	ORD00026	Card	641461.84	2023-11-06 02:00:00
PAY00022	ORD00027	Card	63031.03	2024-11-15 23:00:00
PAY00023	ORD00028	Mobile Money	387229.75	2023-10-10 15:00:00
PAY00024	ORD00029	Card	610496.92	2024-09-08 15:00:00
PAY00025	ORD00030	Cash on Delivery	537014.62	2024-11-30 21:00:00
PAY00026	ORD00031	Bank Transfer	5969.13	2024-11-28 09:00:00
PAY00027	ORD00032	Card	742823.21	2024-10-08 06:00:00
PAY00028	ORD00033	Card	87218.76	2024-06-28 23:00:00
PAY00029	ORD00034	Cash on Delivery	20188.50	2024-11-11 13:00:00
PAY00030	ORD00036	Cash on Delivery	37673.59	2024-12-02 04:00:00
PAY00031	ORD00037	Card	418860.68	2024-11-12 18:00:00
PAY00032	ORD00038	Cash on Delivery	50969.15	2024-11-19 06:00:00
PAY00033	ORD00040	Card	181459.05	2024-08-19 09:00:00
PAY00034	ORD00041	Card	1924.96	2023-11-11 19:00:00
PAY00035	ORD00042	Mobile Money	386969.63	2023-09-29 07:00:00
PAY00036	ORD00045	Mobile Money	37115.57	2023-07-07 22:00:00
PAY00037	ORD00047	Bank Transfer	397308.38	2023-12-24 20:00:00
PAY00038	ORD00048	Bank Transfer	620263.73	2023-11-04 09:00:00
PAY00039	ORD00049	Bank Transfer	8921.75	2023-12-09 09:00:00
PAY00040	ORD00054	Mobile Money	130620.52	2023-09-18 01:00:00
PAY00041	ORD00056	Mobile Money	55822.24	2024-09-29 15:00:00
PAY00042	ORD00057	Bank Transfer	44075.43	2024-10-15 20:00:00
PAY00043	ORD00058	Cash on Delivery	72814.92	2024-11-25 04:00:00
PAY00044	ORD00059	Mobile Money	\N	2024-10-05 07:00:00
PAY00045	ORD00060	Mobile Money	719457.16	2024-09-08 08:00:00
PAY00046	ORD00062	Card	841181.08	2024-07-24 19:00:00
PAY00047	ORD00064	Card	\N	2024-10-26 04:00:00
PAY00048	ORD00065	Bank Transfer	568676.24	2024-09-03 04:00:00
PAY00049	ORD00066	Mobile Money	55153.50	2024-10-16 21:00:00
PAY00050	ORD00068	Mobile Money	59207.10	2024-10-15 00:00:00
PAY00051	ORD00069	Card	105355.32	2024-07-28 20:00:00
PAY00052	ORD00070	Bank Transfer	14849.13	2024-07-07 17:00:00
PAY00053	ORD00071	Card	661180.78	2024-08-01 23:00:00
PAY00054	ORD00072	Card	28219.20	2023-12-22 00:00:00
PAY00055	ORD00074	Mobile Money	85134.06	2024-12-29 05:00:00
PAY00056	ORD00077	Card	9252.98	2024-09-01 05:00:00
PAY00057	ORD00078	Card	52248.32	2024-10-11 13:00:00
PAY00058	ORD00080	Cash on Delivery	237323.74	2024-10-26 06:00:00
PAY00059	ORD00081	Card	56202.28	2024-06-08 10:00:00
PAY00060	ORD00082	Cash on Delivery	68811.36	2024-07-06 09:00:00
PAY00061	ORD00083	Mobile Money	221349.29	2024-07-10 05:00:00
PAY00062	ORD00084	Bank Transfer	156675.92	2024-09-07 20:00:00
PAY00063	ORD00088	Card	317920.43	2023-10-29 03:00:00
PAY00064	ORD00089	Cash on Delivery	11561.20	2024-02-08 12:00:00
PAY00065	ORD00091	Mobile Money	290642.30	2023-09-13 17:00:00
PAY00066	ORD00092	Bank Transfer	172118.10	2023-06-12 18:00:00
PAY00067	ORD00093	Mobile Money	150879.51	2023-07-22 22:00:00
PAY00068	ORD00094	Bank Transfer	113579.08	2024-04-15 04:00:00
PAY00069	ORD00095	Bank Transfer	105588.96	2023-11-01 18:00:00
PAY00070	ORD00096	Card	56377.85	2023-06-11 17:00:00
PAY00071	ORD00097	Mobile Money	15165.36	2024-05-25 11:00:00
PAY00072	ORD00098	Mobile Money	176298.80	2024-06-30 04:00:00
PAY00073	ORD00099	Cash on Delivery	28718.29	2024-08-26 06:00:00
PAY00074	ORD00100	Card	1216584.61	2024-11-22 01:00:00
PAY00075	ORD00101	Card	\N	2024-11-27 00:00:00
PAY00076	ORD00102	Cash on Delivery	551588.14	2024-08-24 03:00:00
PAY00077	ORD00103	Bank Transfer	541867.09	2024-08-25 18:00:00
PAY00078	ORD00104	Cash on Delivery	47715.49	2024-08-30 05:00:00
PAY00079	ORD00107	Card	163173.87	2024-10-29 01:00:00
PAY00080	ORD00109	Card	95695.43	2024-08-11 14:00:00
PAY00081	ORD00110	Cash on Delivery	\N	2023-09-21 20:00:00
PAY00082	ORD00112	Cash on Delivery	29969.43	2024-06-02 17:00:00
PAY00083	ORD00113	Card	20510.26	2024-07-24 20:00:00
PAY00084	ORD00114	Bank Transfer	116631.80	2023-07-12 07:00:00
PAY00085	ORD00116	Cash on Delivery	487091.15	2023-03-23 12:00:00
PAY00086	ORD00118	Cash on Delivery	3808.56	2023-05-12 03:00:00
PAY00087	ORD00119	Cash on Delivery	\N	2024-02-07 20:00:00
PAY00088	ORD00120	Cash on Delivery	135324.64	2023-07-04 20:00:00
PAY00089	ORD00121	Cash on Delivery	361871.41	2023-06-23 06:00:00
PAY00090	ORD00123	Card	286796.28	2024-03-24 17:00:00
PAY00091	ORD00124	Card	17894.71	2024-09-28 19:00:00
PAY00092	ORD00125	Card	1308986.59	2024-08-09 15:00:00
PAY00093	ORD00126	Mobile Money	17879.04	2024-03-10 00:00:00
PAY00094	ORD00127	Card	21681.00	2023-10-10 19:00:00
PAY00095	ORD00128	Card	1690544.05	2024-12-14 03:00:00
PAY00096	ORD00130	Mobile Money	409790.96	2024-06-06 20:00:00
PAY00097	ORD00131	Card	36567.08	2024-11-15 07:00:00
PAY00098	ORD00132	Mobile Money	387334.01	2024-03-22 14:00:00
PAY00099	ORD00133	Cash on Delivery	52128.03	2024-11-19 20:00:00
PAY00100	ORD00134	Mobile Money	854711.56	2024-09-27 17:00:00
PAY00101	ORD00136	Card	121358.37	2024-12-06 07:00:00
PAY00102	ORD00137	Card	53108.20	2024-10-20 14:00:00
PAY00103	ORD00138	Mobile Money	90240.52	2024-07-19 17:00:00
PAY00104	ORD00139	Card	61679.19	2024-12-03 03:00:00
PAY00105	ORD00144	Card	20387.66	2024-08-05 06:00:00
PAY00106	ORD00145	Card	33479.34	2024-08-26 23:00:00
PAY00107	ORD00146	Bank Transfer	67971.18	2023-11-18 15:00:00
PAY00108	ORD00147	Bank Transfer	8223.52	2024-06-29 20:00:00
PAY00109	ORD00148	Bank Transfer	424510.83	2023-09-10 03:00:00
PAY00110	ORD00149	Cash on Delivery	165983.83	2024-02-24 12:00:00
PAY00111	ORD00150	Cash on Delivery	923063.39	2023-08-21 23:00:00
PAY00112	ORD00152	Card	381529.84	2024-11-24 01:00:00
PAY00113	ORD00154	Mobile Money	44137.50	2023-12-24 17:00:00
PAY00114	ORD00155	Mobile Money	407731.20	2024-08-19 22:00:00
PAY00115	ORD00156	Cash on Delivery	28748.14	2023-12-30 22:00:00
PAY00116	ORD00157	Bank Transfer	1837779.82	2024-03-10 02:00:00
PAY00117	ORD00159	Card	8939.52	2024-11-05 12:00:00
PAY00118	ORD00161	Cash on Delivery	198883.60	2024-07-29 17:00:00
PAY00119	ORD00163	Card	\N	2024-07-01 01:00:00
PAY00120	ORD00164	Card	\N	2024-07-14 13:00:00
PAY00121	ORD00165	Mobile Money	72273.39	2024-07-20 16:00:00
PAY00122	ORD00166	Card	241237.25	2024-12-05 03:00:00
PAY00123	ORD00167	Cash on Delivery	24526.05	2024-09-29 14:00:00
PAY00124	ORD00169	Card	74101.71	2024-08-26 20:00:00
PAY00125	ORD00170	Bank Transfer	\N	2024-08-11 16:00:00
PAY00126	ORD00172	Mobile Money	140456.88	2024-04-19 11:00:00
PAY00127	ORD00173	Card	10045.04	2024-05-25 15:00:00
PAY00128	ORD00175	Bank Transfer	1362565.60	2024-03-28 23:00:00
PAY00129	ORD00176	Cash on Delivery	463018.78	2024-03-12 08:00:00
PAY00130	ORD00178	Cash on Delivery	12927.06	2023-07-15 07:00:00
PAY00131	ORD00179	Mobile Money	\N	2024-04-04 07:00:00
PAY00132	ORD00181	Mobile Money	\N	2024-04-30 14:00:00
PAY00133	ORD00182	Mobile Money	91816.72	2024-08-23 10:00:00
PAY00134	ORD00183	Bank Transfer	1118704.60	2024-11-15 11:00:00
PAY00135	ORD00184	Card	1110784.70	2024-12-18 08:00:00
PAY00136	ORD00185	Bank Transfer	673130.69	2024-10-25 21:00:00
PAY00137	ORD00186	Card	68811.36	2024-10-07 22:00:00
PAY00138	ORD00187	Bank Transfer	279610.57	2024-09-05 07:00:00
PAY00139	ORD00188	Mobile Money	47284.02	2024-12-31 20:00:00
PAY00140	ORD00190	Bank Transfer	205354.87	2024-12-16 05:00:00
PAY00141	ORD00191	Mobile Money	11170.68	2023-10-31 07:00:00
PAY00142	ORD00192	Card	51341.16	2024-12-14 09:00:00
PAY00143	ORD00194	Mobile Money	1633.04	2024-12-23 14:00:00
PAY00144	ORD00195	Bank Transfer	80751.63	2024-11-16 11:00:00
PAY00145	ORD00196	Cash on Delivery	1906549.00	2024-12-24 19:00:00
PAY00146	ORD00197	Cash on Delivery	1106566.77	2023-10-04 16:00:00
PAY00147	ORD00198	Card	637741.33	2024-01-07 15:00:00
PAY00148	ORD00199	Card	46351.50	2023-12-25 23:00:00
PAY00149	ORD00200	Card	15864.45	2023-05-22 15:00:00
PAY00150	ORD00202	Card	415783.66	2023-09-27 21:00:00
PAY00151	ORD00203	Bank Transfer	587515.04	2024-04-26 21:00:00
PAY00152	ORD00205	Cash on Delivery	184222.10	2024-08-09 21:00:00
PAY00153	ORD00206	Bank Transfer	207195.58	2024-12-08 17:00:00
PAY00154	ORD00207	Cash on Delivery	1839733.68	2024-12-26 12:00:00
PAY00155	ORD00208	Mobile Money	463513.16	2024-10-27 23:00:00
PAY00156	ORD00210	Card	1046114.96	2024-12-26 14:00:00
PAY00157	ORD00211	Mobile Money	9870.56	2024-10-04 14:00:00
PAY00158	ORD00212	Mobile Money	97186.64	2024-12-20 11:00:00
PAY00159	ORD00213	Card	1098722.46	2024-07-07 22:00:00
PAY00160	ORD00215	Cash on Delivery	1067633.73	2024-09-28 22:00:00
PAY00161	ORD00216	Cash on Delivery	104715.98	2024-04-26 19:00:00
PAY00162	ORD00220	Cash on Delivery	1821077.11	2024-08-06 13:00:00
PAY00163	ORD00223	Card	81177.59	2024-03-02 06:00:00
PAY00164	ORD00225	Bank Transfer	68706.68	2024-02-26 04:00:00
PAY00165	ORD00226	Card	340737.24	2024-01-08 06:00:00
PAY00166	ORD00227	Card	123624.12	2024-04-01 23:00:00
PAY00167	ORD00228	Mobile Money	19060.11	2024-10-13 11:00:00
PAY00168	ORD00229	Card	1313680.59	2024-12-02 12:00:00
PAY00169	ORD00230	Card	18140.90	2024-11-30 18:00:00
PAY00170	ORD00231	Bank Transfer	299658.88	2024-09-18 10:00:00
PAY00171	ORD00232	Bank Transfer	114557.57	2024-05-27 08:00:00
PAY00172	ORD00233	Bank Transfer	114669.90	2024-05-11 02:00:00
PAY00173	ORD00234	Mobile Money	869814.44	2024-10-16 09:00:00
PAY00174	ORD00235	Bank Transfer	35594.97	2024-08-10 06:00:00
PAY00175	ORD00238	Mobile Money	2985.64	2024-07-24 00:00:00
PAY00176	ORD00239	Card	8185.56	2024-08-09 13:00:00
PAY00177	ORD00240	Cash on Delivery	\N	2024-09-25 06:00:00
PAY00178	ORD00241	Card	336109.81	2024-10-30 22:00:00
PAY00179	ORD00243	Card	34836.28	2024-11-17 09:00:00
PAY00180	ORD00244	Mobile Money	318844.35	2024-11-21 07:00:00
PAY00181	ORD00245	Bank Transfer	87303.72	2024-01-13 03:00:00
PAY00182	ORD00246	Mobile Money	\N	2024-02-09 11:00:00
PAY00183	ORD00247	Mobile Money	\N	2023-06-29 09:00:00
PAY00184	ORD00251	Bank Transfer	199058.95	2024-11-18 14:00:00
PAY00185	ORD00252	Cash on Delivery	53834.42	2024-10-26 06:00:00
PAY00186	ORD00254	Cash on Delivery	90661.69	2024-05-29 04:00:00
PAY00187	ORD00255	Card	250605.03	2024-01-22 21:00:00
PAY00188	ORD00257	Mobile Money	17150.33	2024-10-08 15:00:00
PAY00189	ORD00258	Card	653256.02	2024-02-27 16:00:00
PAY00190	ORD00259	Mobile Money	1008375.05	2024-09-30 23:00:00
PAY00191	ORD00260	Card	21046.98	2024-01-01 06:00:00
PAY00192	ORD00261	Card	1033526.75	2024-01-20 03:00:00
PAY00193	ORD00265	Mobile Money	718503.54	2024-12-28 01:00:00
PAY00194	ORD00266	Mobile Money	39485.36	2024-09-06 20:00:00
PAY00195	ORD00267	Cash on Delivery	1337468.88	2024-08-10 07:00:00
PAY00196	ORD00268	Cash on Delivery	1040455.46	2024-12-24 20:00:00
PAY00197	ORD00270	Bank Transfer	13380.15	2024-12-06 20:00:00
PAY00198	ORD00271	Card	23732.60	2024-11-24 08:00:00
PAY00199	ORD00272	Bank Transfer	57378.28	2023-12-15 11:00:00
PAY00200	ORD00273	Mobile Money	688797.69	2024-06-04 08:00:00
PAY00201	ORD00274	Mobile Money	21686.24	2023-07-16 11:00:00
PAY00202	ORD00275	Mobile Money	795534.40	2024-08-12 09:00:00
PAY00203	ORD00276	Cash on Delivery	189891.12	2024-06-19 08:00:00
PAY00204	ORD00277	Card	565928.04	2024-11-04 07:00:00
PAY00205	ORD00278	Bank Transfer	36834.84	2024-12-05 00:00:00
PAY00206	ORD00280	Card	186735.09	2024-10-13 07:00:00
PAY00207	ORD00281	Card	11957.92	2024-06-21 04:00:00
PAY00208	ORD00282	Card	163963.66	2024-09-07 18:00:00
PAY00209	ORD00284	Bank Transfer	24967.78	2023-09-15 15:00:00
PAY00210	ORD00285	Cash on Delivery	21301.38	2023-05-05 01:00:00
PAY00211	ORD00286	Card	1482049.93	2023-10-08 07:00:00
PAY00212	ORD00289	Bank Transfer	838831.71	2023-10-06 20:00:00
PAY00213	ORD00291	Mobile Money	8834.25	2024-04-03 14:00:00
PAY00214	ORD00292	Mobile Money	65538.61	2023-10-03 04:00:00
PAY00215	ORD00293	Mobile Money	511280.86	2024-02-17 06:00:00
PAY00216	ORD00294	Mobile Money	52451.70	2023-03-08 21:00:00
PAY00217	ORD00296	Cash on Delivery	95114.76	2023-11-12 15:00:00
PAY00218	ORD00297	Mobile Money	375751.75	2023-07-21 12:00:00
PAY00219	ORD00298	Cash on Delivery	392099.74	2023-05-16 07:00:00
PAY00220	ORD00300	Cash on Delivery	\N	2024-06-21 05:00:00
PAY00221	ORD00301	Bank Transfer	1006562.43	2024-06-02 07:00:00
PAY00222	ORD00302	Mobile Money	72273.39	2024-10-07 01:00:00
PAY00223	ORD00303	Mobile Money	541298.27	2024-10-17 13:00:00
PAY00224	ORD00305	Cash on Delivery	23962.00	2024-12-04 00:00:00
PAY00225	ORD00307	Bank Transfer	124012.95	2024-09-30 09:00:00
PAY00226	ORD00309	Card	15371.06	2024-09-29 06:00:00
PAY00227	ORD00311	Mobile Money	56529.82	2023-02-15 04:00:00
PAY00228	ORD00312	Cash on Delivery	517459.78	2024-06-11 19:00:00
PAY00229	ORD00313	Card	649434.60	2024-09-23 06:00:00
PAY00230	ORD00314	Card	331970.24	2024-11-11 20:00:00
PAY00231	ORD00315	Card	156675.92	2024-12-29 21:00:00
PAY00232	ORD00317	Mobile Money	1015340.04	2024-11-13 14:00:00
PAY00233	ORD00320	Mobile Money	41523.39	2024-07-29 14:00:00
PAY00234	ORD00324	Bank Transfer	20703.44	2024-07-24 04:00:00
PAY00235	ORD00325	Card	1024046.49	2024-11-19 01:00:00
PAY00236	ORD00329	Bank Transfer	1056588.38	2023-07-27 23:00:00
PAY00237	ORD00330	Mobile Money	237701.88	2024-11-19 06:00:00
PAY00238	ORD00331	Mobile Money	\N	2024-07-05 14:00:00
PAY00239	ORD00332	Cash on Delivery	8076.20	2023-05-04 20:00:00
PAY00240	ORD00333	Cash on Delivery	1038583.27	2024-03-05 10:00:00
PAY00241	ORD00334	Mobile Money	20108.16	2024-11-17 02:00:00
PAY00242	ORD00335	Mobile Money	11561.20	2024-11-29 23:00:00
PAY00243	ORD00337	Cash on Delivery	118777.43	2024-09-04 20:00:00
PAY00244	ORD00338	Card	835660.76	2023-11-09 23:00:00
PAY00245	ORD00339	Card	17418.14	2024-04-21 05:00:00
PAY00246	ORD00340	Card	47474.30	2024-08-09 18:00:00
PAY00247	ORD00341	Cash on Delivery	\N	2024-11-15 20:00:00
PAY00248	ORD00344	Bank Transfer	249821.66	2024-10-14 16:00:00
PAY00249	ORD00345	Cash on Delivery	12341.62	2024-09-01 23:00:00
PAY00250	ORD00347	Mobile Money	1135166.90	2024-05-20 02:00:00
PAY00251	ORD00348	Bank Transfer	80565.33	2024-04-13 00:00:00
PAY00252	ORD00349	Cash on Delivery	564062.64	2024-08-01 07:00:00
PAY00253	ORD00351	Mobile Money	905369.04	2024-08-09 20:00:00
PAY00254	ORD00353	Mobile Money	1747386.06	2024-03-08 15:00:00
PAY00255	ORD00360	Bank Transfer	579273.29	2024-06-17 04:00:00
PAY00256	ORD00361	Cash on Delivery	81869.66	2024-06-22 16:00:00
PAY00257	ORD00362	Bank Transfer	423407.40	2024-11-23 22:00:00
PAY00258	ORD00363	Card	58042.90	2024-12-19 00:00:00
PAY00259	ORD00364	Cash on Delivery	61242.36	2024-11-14 04:00:00
PAY00260	ORD00367	Mobile Money	71357.08	2024-03-31 17:00:00
PAY00261	ORD00368	Card	\N	2024-06-15 09:00:00
PAY00262	ORD00369	Bank Transfer	135890.25	2024-08-04 00:00:00
PAY00263	ORD00370	Card	7533.78	2024-05-12 01:00:00
PAY00264	ORD00372	Card	9954.82	2024-11-15 22:00:00
PAY00265	ORD00374	Card	68757.46	2024-09-27 09:00:00
PAY00266	ORD00375	Cash on Delivery	329209.29	2024-07-22 10:00:00
PAY00267	ORD00376	Card	33000.44	2024-06-23 23:00:00
PAY00268	ORD00377	Cash on Delivery	1081019.63	2024-03-08 11:00:00
PAY00269	ORD00381	Cash on Delivery	69007.99	2024-09-20 18:00:00
PAY00270	ORD00382	Cash on Delivery	403673.98	2024-06-24 04:00:00
PAY00271	ORD00383	Cash on Delivery	8999.40	2024-12-26 12:00:00
PAY00272	ORD00385	Mobile Money	1340872.79	2024-12-01 14:00:00
PAY00273	ORD00386	Cash on Delivery	549925.12	2024-12-04 08:00:00
PAY00274	ORD00389	Mobile Money	170398.32	2024-11-24 06:00:00
PAY00275	ORD00390	Cash on Delivery	46462.10	2024-12-19 11:00:00
PAY00276	ORD00391	Cash on Delivery	73400.14	2024-10-03 11:00:00
PAY00277	ORD00393	Cash on Delivery	487075.95	2024-12-21 21:00:00
PAY00278	ORD00394	Cash on Delivery	1174.07	2024-09-20 06:00:00
PAY00279	ORD00395	Cash on Delivery	392693.70	2024-06-02 04:00:00
PAY00280	ORD00396	Cash on Delivery	783030.12	2024-01-04 16:00:00
PAY00281	ORD00399	Cash on Delivery	29538.45	2024-11-05 06:00:00
PAY00282	ORD00401	Bank Transfer	148528.57	2024-12-13 18:00:00
PAY00283	ORD00403	Card	62010.68	2024-04-02 06:00:00
PAY00284	ORD00405	Mobile Money	6345.78	2024-04-12 14:00:00
PAY00285	ORD00409	Cash on Delivery	208766.75	2024-01-29 15:00:00
PAY00286	ORD00410	Card	134871.38	2024-12-14 06:00:00
PAY00287	ORD00412	Card	100026.32	2024-05-01 00:00:00
PAY00288	ORD00413	Card	227426.90	2024-11-07 18:00:00
PAY00289	ORD00414	Mobile Money	21092.44	2024-08-05 18:00:00
PAY00290	ORD00415	Bank Transfer	81197.50	2024-11-24 08:00:00
PAY00291	ORD00416	Mobile Money	73579.33	2024-11-06 16:00:00
PAY00292	ORD00418	Cash on Delivery	40227.54	2024-08-18 18:00:00
PAY00293	ORD00421	Cash on Delivery	407586.12	2023-10-30 04:00:00
PAY00294	ORD00423	Bank Transfer	168960.56	2024-10-28 15:00:00
PAY00295	ORD00424	Mobile Money	121442.45	2023-12-18 17:00:00
PAY00296	ORD00425	Mobile Money	1211000.62	2024-01-08 17:00:00
PAY00297	ORD00427	Bank Transfer	142692.85	2024-12-08 14:00:00
PAY00298	ORD00430	Cash on Delivery	22153.16	2024-11-22 13:00:00
PAY00299	ORD00431	Mobile Money	899321.45	2024-04-22 12:00:00
PAY00300	ORD00433	Bank Transfer	132923.54	2023-06-14 19:00:00
PAY00301	ORD00437	Bank Transfer	284037.06	2024-03-18 12:00:00
PAY00302	ORD00439	Cash on Delivery	50530.96	2024-05-23 00:00:00
PAY00303	ORD00440	Card	76881.64	2024-07-06 21:00:00
PAY00304	ORD00441	Bank Transfer	1817749.85	2023-07-15 16:00:00
PAY00305	ORD00442	Card	400105.28	2023-04-25 13:00:00
PAY00306	ORD00443	Mobile Money	3250.98	2024-03-23 11:00:00
PAY00307	ORD00444	Mobile Money	318136.45	2023-06-13 07:00:00
PAY00308	ORD00446	Mobile Money	59584.40	2024-07-18 06:00:00
PAY00309	ORD00447	Card	11561.20	2024-04-09 18:00:00
PAY00310	ORD00448	Bank Transfer	6230.11	2024-12-18 02:00:00
PAY00311	ORD00450	Bank Transfer	115950.03	2024-11-15 06:00:00
PAY00312	ORD00453	Card	67579.57	2024-11-14 02:00:00
PAY00313	ORD00454	Card	1300172.97	2024-11-15 09:00:00
PAY00314	ORD00455	Mobile Money	792677.46	2024-12-17 10:00:00
PAY00315	ORD00456	Card	701886.30	2024-12-15 10:00:00
PAY00316	ORD00457	Card	1255316.56	2024-11-29 03:00:00
PAY00317	ORD00458	Card	166388.35	2024-08-17 20:00:00
PAY00318	ORD00459	Mobile Money	230104.36	2024-09-20 20:00:00
PAY00319	ORD00460	Mobile Money	160987.02	2024-11-07 14:00:00
PAY00320	ORD00461	Card	1231073.02	2024-12-06 00:00:00
PAY00321	ORD00462	Cash on Delivery	41738.40	2024-09-20 12:00:00
PAY00322	ORD00463	Mobile Money	7172.97	2024-09-17 07:00:00
PAY00323	ORD00468	Bank Transfer	231544.96	2024-06-12 07:00:00
PAY00324	ORD00469	Bank Transfer	1256918.44	2024-05-09 09:00:00
PAY00325	ORD00470	Card	816829.96	2024-06-15 04:00:00
PAY00326	ORD00471	Cash on Delivery	167987.24	2024-10-16 16:00:00
PAY00327	ORD00472	Mobile Money	37254.90	2024-05-29 22:00:00
PAY00328	ORD00474	Mobile Money	234437.08	2024-11-19 22:00:00
PAY00329	ORD00475	Mobile Money	458822.98	2024-09-22 02:00:00
PAY00330	ORD00476	Mobile Money	\N	2024-05-01 17:00:00
PAY00331	ORD00477	Card	117508.45	2024-06-30 06:00:00
PAY00332	ORD00478	Bank Transfer	3149.21	2024-02-05 17:00:00
PAY00333	ORD00479	Mobile Money	\N	2024-06-29 05:00:00
PAY00334	ORD00480	Cash on Delivery	364494.60	2023-11-24 23:00:00
PAY00335	ORD00481	Mobile Money	924212.96	2024-10-26 20:00:00
PAY00336	ORD00482	Cash on Delivery	515180.54	2024-03-22 18:00:00
PAY00337	ORD00484	Card	508341.61	2024-12-11 16:00:00
PAY00338	ORD00485	Mobile Money	38184.64	2024-01-24 15:00:00
PAY00339	ORD00486	Card	520184.35	2023-12-30 20:00:00
PAY00340	ORD00487	Card	871926.90	2024-03-18 16:00:00
PAY00341	ORD00488	Cash on Delivery	35488.70	2024-11-17 17:00:00
PAY00342	ORD00489	Card	5512.81	2024-12-16 22:00:00
PAY00343	ORD00490	Cash on Delivery	22192.46	2024-08-02 18:00:00
PAY00344	ORD00492	Cash on Delivery	1586657.86	2024-07-17 00:00:00
PAY00345	ORD00493	Cash on Delivery	118235.75	2024-08-21 21:00:00
PAY00346	ORD00494	Bank Transfer	876039.35	2024-12-13 00:00:00
PAY00347	ORD00496	Bank Transfer	\N	2024-09-08 01:00:00
PAY00348	ORD00497	Bank Transfer	20993.04	2024-11-07 13:00:00
PAY00349	ORD00498	Mobile Money	82041.04	2024-12-13 10:00:00
PAY00350	ORD00500	Mobile Money	26343.44	2023-12-30 08:00:00
PAY00351	ORD00501	Mobile Money	354085.10	2024-06-01 09:00:00
PAY00352	ORD00502	Mobile Money	929593.33	2024-07-28 19:00:00
PAY00353	ORD00504	Mobile Money	200052.64	2023-10-22 03:00:00
PAY00354	ORD00505	Mobile Money	734614.02	2024-09-30 17:00:00
PAY00355	ORD00506	Bank Transfer	108353.68	2023-12-31 23:00:00
PAY00356	ORD00509	Bank Transfer	72047.64	2024-06-08 01:00:00
PAY00357	ORD00511	Cash on Delivery	3485.44	2024-07-22 03:00:00
PAY00358	ORD00513	Card	198883.60	2024-11-12 16:00:00
PAY00359	ORD00514	Card	235009.16	2024-11-24 19:00:00
PAY00360	ORD00516	Card	589959.06	2024-06-03 11:00:00
PAY00361	ORD00517	Mobile Money	168325.37	2024-12-28 18:00:00
PAY00362	ORD00518	Card	125685.71	2024-07-18 03:00:00
PAY00363	ORD00519	Mobile Money	436199.25	2024-06-11 01:00:00
PAY00364	ORD00522	Card	817839.94	2024-12-10 14:00:00
PAY00365	ORD00523	Bank Transfer	180380.35	2024-04-08 05:00:00
PAY00366	ORD00524	Card	339418.37	2024-07-07 17:00:00
PAY00367	ORD00525	Card	841301.64	2024-09-01 18:00:00
PAY00368	ORD00527	Cash on Delivery	1380886.77	2023-06-07 07:00:00
PAY00369	ORD00528	Bank Transfer	347417.94	2024-01-16 03:00:00
PAY00370	ORD00529	Cash on Delivery	27825.60	2024-01-06 19:00:00
PAY00371	ORD00530	Card	1120410.59	2023-05-05 14:00:00
PAY00372	ORD00531	Cash on Delivery	53743.75	2023-10-29 00:00:00
PAY00373	ORD00532	Card	147594.20	2024-11-01 15:00:00
PAY00374	ORD00533	Cash on Delivery	220262.55	2024-07-15 15:00:00
PAY00375	ORD00534	Card	223383.08	2024-11-01 06:00:00
PAY00376	ORD00535	Cash on Delivery	193656.60	2024-11-13 04:00:00
PAY00377	ORD00536	Bank Transfer	231412.15	2024-06-30 23:00:00
PAY00378	ORD00537	Mobile Money	3385.48	2024-07-20 01:00:00
PAY00379	ORD00538	Bank Transfer	451022.95	2023-12-22 06:00:00
PAY00380	ORD00541	Card	768841.50	2024-11-10 03:00:00
PAY00381	ORD00542	Mobile Money	926660.16	2024-12-03 00:00:00
PAY00382	ORD00544	Mobile Money	92772.76	2024-09-27 06:00:00
PAY00383	ORD00545	Cash on Delivery	240142.74	2024-11-14 00:00:00
PAY00384	ORD00546	Mobile Money	181459.05	2024-12-24 15:00:00
PAY00385	ORD00548	Cash on Delivery	13409.28	2024-12-12 20:00:00
PAY00386	ORD00549	Bank Transfer	95430.98	2024-12-13 02:00:00
PAY00387	ORD00550	Cash on Delivery	1408878.80	2024-11-28 04:00:00
PAY00388	ORD00551	Card	86284.48	2024-12-19 11:00:00
PAY00389	ORD00552	Mobile Money	1613502.06	2024-12-10 06:00:00
PAY00390	ORD00554	Bank Transfer	160848.97	2024-12-05 13:00:00
PAY00391	ORD00557	Bank Transfer	10095.25	2024-11-05 17:00:00
PAY00392	ORD00558	Mobile Money	\N	2024-04-26 14:00:00
PAY00393	ORD00561	Bank Transfer	378503.96	2024-12-04 03:00:00
PAY00394	ORD00563	Mobile Money	65148.54	2024-12-15 00:00:00
PAY00395	ORD00567	Mobile Money	98560.00	2024-03-31 17:00:00
PAY00396	ORD00568	Card	87090.70	2023-10-12 12:00:00
PAY00397	ORD00570	Card	43905.60	2024-05-01 12:00:00
PAY00398	ORD00571	Card	\N	2024-09-20 06:00:00
PAY00399	ORD00572	Bank Transfer	64819.73	2024-08-12 23:00:00
PAY00400	ORD00573	Card	1564948.01	2024-05-31 10:00:00
PAY00401	ORD00574	Card	324721.91	2024-05-19 15:00:00
PAY00402	ORD00575	Card	10095.25	2024-08-19 19:00:00
PAY00403	ORD00576	Mobile Money	742960.79	2024-06-07 20:00:00
PAY00404	ORD00577	Card	5457.04	2024-04-21 22:00:00
PAY00405	ORD00578	Card	146008.50	2024-01-27 08:00:00
PAY00406	ORD00580	Cash on Delivery	236830.69	2024-03-21 05:00:00
PAY00407	ORD00581	Mobile Money	109722.82	2024-01-13 01:00:00
PAY00408	ORD00582	Cash on Delivery	680096.85	2024-04-08 21:00:00
PAY00409	ORD00583	Cash on Delivery	32894.08	2023-07-09 04:00:00
PAY00410	ORD00584	Cash on Delivery	76881.64	2023-09-16 17:00:00
PAY00411	ORD00586	Mobile Money	359728.58	2024-11-11 20:00:00
PAY00412	ORD00587	Mobile Money	655577.48	2024-11-19 09:00:00
PAY00413	ORD00590	Mobile Money	55149.16	2024-11-28 05:00:00
PAY00414	ORD00591	Card	1283356.59	2024-09-28 15:00:00
PAY00415	ORD00592	Bank Transfer	61637.76	2024-10-09 09:00:00
PAY00416	ORD00593	Card	76726.04	2024-05-06 14:00:00
PAY00417	ORD00595	Cash on Delivery	649434.60	2024-11-02 09:00:00
PAY00418	ORD00596	Card	1712169.09	2024-11-01 08:00:00
PAY00419	ORD00598	Card	17607.17	2024-12-11 10:00:00
PAY00420	ORD00599	Mobile Money	58703.25	2024-11-27 03:00:00
PAY00421	ORD00600	Card	771760.08	2024-12-02 21:00:00
PAY00422	ORD00602	Mobile Money	656811.71	2024-10-29 14:00:00
PAY00423	ORD00603	Mobile Money	78576.78	2024-11-21 00:00:00
PAY00424	ORD00604	Bank Transfer	426564.74	2024-12-16 18:00:00
PAY00425	ORD00606	Card	59216.88	2024-12-17 14:00:00
PAY00426	ORD00607	Card	\N	2024-11-30 09:00:00
PAY00427	ORD00608	Cash on Delivery	25829.99	2023-09-27 04:00:00
PAY00428	ORD00609	Cash on Delivery	18483.24	2023-04-12 06:00:00
PAY00429	ORD00611	Cash on Delivery	45102.28	2023-08-12 17:00:00
PAY00430	ORD00612	Mobile Money	890698.14	2023-10-23 05:00:00
PAY00431	ORD00614	Bank Transfer	261576.42	2023-08-13 03:00:00
PAY00432	ORD00615	Card	803078.39	2024-10-03 06:00:00
PAY00433	ORD00616	Card	24990.69	2024-02-10 22:00:00
PAY00434	ORD00617	Cash on Delivery	21709.68	2024-07-03 13:00:00
PAY00435	ORD00619	Bank Transfer	264786.66	2024-11-13 18:00:00
PAY00436	ORD00620	Bank Transfer	191420.62	2024-12-11 22:00:00
PAY00437	ORD00621	Card	30284.60	2024-11-26 01:00:00
PAY00438	ORD00622	Card	400105.28	2024-12-18 05:00:00
PAY00439	ORD00624	Card	45992.18	2024-11-25 20:00:00
PAY00440	ORD00625	Mobile Money	102447.74	2024-12-13 04:00:00
PAY00441	ORD00626	Mobile Money	85781.07	2024-12-05 17:00:00
PAY00442	ORD00627	Cash on Delivery	225136.60	2024-12-13 04:00:00
PAY00443	ORD00628	Bank Transfer	1022886.92	2024-12-03 07:00:00
PAY00444	ORD00629	Cash on Delivery	24526.05	2024-11-17 06:00:00
PAY00445	ORD00630	Mobile Money	152795.70	2024-10-07 04:00:00
PAY00446	ORD00631	Card	70104.98	2024-01-23 14:00:00
PAY00447	ORD00632	Mobile Money	154519.40	2024-11-06 02:00:00
PAY00448	ORD00633	Bank Transfer	469525.69	2024-04-13 00:00:00
PAY00449	ORD00634	Bank Transfer	47233.84	2024-04-18 18:00:00
PAY00450	ORD00635	Card	204981.37	2024-07-14 04:00:00
PAY00451	ORD00636	Bank Transfer	1732506.27	2024-03-04 15:00:00
PAY00452	ORD00637	Bank Transfer	918620.89	2024-10-24 10:00:00
PAY00453	ORD00638	Mobile Money	\N	2023-05-26 16:00:00
PAY00454	ORD00639	Cash on Delivery	274071.30	2024-06-07 04:00:00
PAY00455	ORD00640	Cash on Delivery	91238.43	2023-05-30 17:00:00
PAY00456	ORD00641	Mobile Money	119435.37	2024-12-04 01:00:00
PAY00457	ORD00643	Bank Transfer	988437.53	2024-11-19 20:00:00
PAY00458	ORD00644	Bank Transfer	471432.66	2024-09-05 17:00:00
PAY00459	ORD00645	Card	40919.83	2024-07-15 02:00:00
PAY00460	ORD00646	Bank Transfer	156879.65	2024-08-30 05:00:00
PAY00461	ORD00648	Mobile Money	167249.52	2024-11-25 01:00:00
PAY00462	ORD00649	Cash on Delivery	8700.29	2024-09-10 19:00:00
PAY00463	ORD00652	Cash on Delivery	534704.88	2024-07-28 20:00:00
PAY00464	ORD00653	Bank Transfer	138579.52	2024-11-09 21:00:00
PAY00465	ORD00654	Bank Transfer	78498.02	2024-06-11 15:00:00
PAY00466	ORD00655	Bank Transfer	24463.34	2024-11-29 16:00:00
PAY00467	ORD00656	Bank Transfer	1018515.34	2024-07-14 09:00:00
PAY00468	ORD00657	Mobile Money	35558.78	2024-01-04 12:00:00
PAY00469	ORD00658	Mobile Money	409790.96	2024-02-11 17:00:00
PAY00470	ORD00660	Bank Transfer	872071.33	2024-03-21 07:00:00
PAY00471	ORD00661	Mobile Money	10799.52	2024-03-17 02:00:00
PAY00472	ORD00663	Card	739180.57	2024-11-24 08:00:00
PAY00473	ORD00664	Card	808297.13	2024-10-26 09:00:00
PAY00474	ORD00665	Cash on Delivery	564791.35	2024-11-19 17:00:00
PAY00475	ORD00666	Cash on Delivery	286980.91	2024-12-22 16:00:00
PAY00476	ORD00667	Card	\N	2024-04-10 16:00:00
PAY00477	ORD00668	Mobile Money	1755792.32	2023-07-20 02:00:00
PAY00478	ORD00669	Bank Transfer	130533.42	2024-09-02 00:00:00
PAY00479	ORD00671	Bank Transfer	100327.02	2024-03-27 06:00:00
PAY00480	ORD00674	Card	7038.57	2024-03-05 07:00:00
PAY00481	ORD00675	Card	78955.84	2024-02-02 11:00:00
PAY00482	ORD00676	Bank Transfer	3568.70	2024-02-15 00:00:00
PAY00483	ORD00677	Bank Transfer	2985.64	2024-01-19 01:00:00
PAY00484	ORD00678	Mobile Money	507804.25	2024-02-19 18:00:00
PAY00485	ORD00679	Card	96102.05	2024-10-03 07:00:00
PAY00486	ORD00680	Card	50013.11	2024-12-25 07:00:00
PAY00487	ORD00681	Card	178295.72	2024-10-22 20:00:00
PAY00488	ORD00682	Card	177386.77	2024-11-16 22:00:00
PAY00489	ORD00685	Bank Transfer	1607599.10	2024-01-08 17:00:00
PAY00490	ORD00686	Mobile Money	179162.29	2024-06-03 16:00:00
PAY00491	ORD00692	Mobile Money	191405.76	2024-07-05 07:00:00
PAY00492	ORD00694	Cash on Delivery	1913024.48	2023-02-15 10:00:00
PAY00493	ORD00695	Card	47233.84	2024-08-19 02:00:00
PAY00494	ORD00698	Bank Transfer	112612.34	2024-04-19 14:00:00
PAY00495	ORD00699	Card	283877.97	2024-08-31 02:00:00
PAY00496	ORD00700	Bank Transfer	1924.96	2024-09-07 02:00:00
PAY00497	ORD00704	Bank Transfer	526844.32	2024-04-20 04:00:00
PAY00498	ORD00706	Card	877534.55	2024-03-11 04:00:00
PAY00499	ORD00707	Mobile Money	1523373.58	2024-06-18 08:00:00
PAY00500	ORD00708	Card	474127.35	2024-01-26 00:00:00
PAY00501	ORD00709	Card	484168.90	2024-10-19 10:00:00
PAY00502	ORD00710	Mobile Money	32300.05	2024-10-25 02:00:00
PAY00503	ORD00712	Cash on Delivery	1018573.95	2024-09-27 16:00:00
PAY00504	ORD00715	Card	1098861.08	2024-08-29 06:00:00
PAY00505	ORD00716	Bank Transfer	70228.44	2024-08-25 14:00:00
PAY00506	ORD00717	Mobile Money	65607.55	2024-10-23 01:00:00
PAY00507	ORD00718	Cash on Delivery	431300.41	2024-09-14 03:00:00
PAY00508	ORD00719	Cash on Delivery	361931.70	2024-09-17 05:00:00
PAY00509	ORD00720	Card	473129.95	2024-12-31 01:00:00
PAY00510	ORD00721	Card	1017025.87	2024-11-20 05:00:00
PAY00511	ORD00722	Bank Transfer	569557.84	2024-10-31 22:00:00
PAY00512	ORD00723	Cash on Delivery	6463.53	2024-02-20 23:00:00
PAY00513	ORD00724	Cash on Delivery	48926.68	2024-08-02 04:00:00
PAY00514	ORD00725	Mobile Money	6831.72	2023-12-28 11:00:00
PAY00515	ORD00726	Bank Transfer	537796.40	2024-08-25 23:00:00
PAY00516	ORD00727	Card	321528.06	2024-08-13 16:00:00
PAY00517	ORD00729	Card	252555.02	2023-06-29 02:00:00
PAY00518	ORD00730	Card	89136.44	2023-11-10 20:00:00
PAY00519	ORD00731	Mobile Money	330791.24	2024-07-03 11:00:00
PAY00520	ORD00732	Card	41020.52	2023-10-14 13:00:00
PAY00521	ORD00734	Card	\N	2024-01-22 00:00:00
PAY00522	ORD00735	Mobile Money	260806.91	2024-01-03 09:00:00
PAY00523	ORD00736	Card	166699.15	2024-01-17 11:00:00
PAY00524	ORD00737	Mobile Money	1015740.44	2024-08-31 10:00:00
PAY00525	ORD00739	Card	2354575.73	2024-08-18 05:00:00
PAY00526	ORD00740	Card	\N	2024-01-14 20:00:00
PAY00527	ORD00741	Card	582824.76	2023-09-27 12:00:00
PAY00528	ORD00742	Mobile Money	122312.70	2024-05-04 02:00:00
PAY00529	ORD00743	Mobile Money	63585.10	2024-12-23 17:00:00
PAY00530	ORD00744	Mobile Money	1283879.52	2024-07-24 16:00:00
PAY00531	ORD00745	Card	\N	2023-09-27 23:00:00
PAY00532	ORD00746	Bank Transfer	77698.16	2024-12-15 10:00:00
PAY00533	ORD00747	Card	144928.51	2024-10-29 10:00:00
PAY00534	ORD00748	Card	603998.75	2024-11-22 08:00:00
PAY00535	ORD00750	Card	657071.01	2024-02-10 06:00:00
PAY00536	ORD00751	Bank Transfer	54346.36	2023-12-07 10:00:00
PAY00537	ORD00752	Card	462984.69	2024-06-23 18:00:00
PAY00538	ORD00753	Cash on Delivery	147735.75	2024-09-13 01:00:00
PAY00539	ORD00754	Cash on Delivery	879031.83	2024-08-18 03:00:00
PAY00540	ORD00757	Card	63131.92	2024-07-23 15:00:00
PAY00541	ORD00758	Cash on Delivery	13409.28	2024-03-25 23:00:00
PAY00542	ORD00761	Mobile Money	359728.58	2024-12-14 15:00:00
PAY00543	ORD00763	Cash on Delivery	684591.89	2024-12-16 04:00:00
PAY00544	ORD00765	Mobile Money	92782.44	2024-12-28 03:00:00
PAY00545	ORD00766	Card	147425.86	2024-10-23 12:00:00
PAY00546	ORD00767	Bank Transfer	169258.32	2024-11-16 22:00:00
PAY00547	ORD00768	Card	53790.15	2024-12-28 23:00:00
PAY00548	ORD00769	Bank Transfer	317300.85	2024-12-05 03:00:00
PAY00549	ORD00770	Card	17287.41	2024-10-06 00:00:00
PAY00550	ORD00771	Card	110258.32	2024-03-05 09:00:00
PAY00551	ORD00772	Mobile Money	4038.10	2024-08-27 11:00:00
PAY00552	ORD00773	Card	66595.50	2024-03-06 02:00:00
PAY00553	ORD00778	Bank Transfer	500323.45	2023-10-16 01:00:00
PAY00554	ORD00779	Card	271470.00	2024-04-27 15:00:00
PAY00555	ORD00780	Bank Transfer	148614.93	2023-10-14 05:00:00
PAY00556	ORD00782	Bank Transfer	30345.96	2024-07-14 17:00:00
PAY00557	ORD00784	Card	393692.05	2023-12-05 06:00:00
PAY00558	ORD00785	Card	1398814.12	2024-12-24 12:00:00
PAY00559	ORD00786	Card	70957.82	2024-10-23 07:00:00
PAY00560	ORD00787	Bank Transfer	\N	2024-06-29 16:00:00
PAY00561	ORD00788	Card	71048.06	2024-08-08 10:00:00
PAY00562	ORD00789	Card	37830.93	2024-08-08 15:00:00
PAY00563	ORD00791	Bank Transfer	984241.89	2024-10-16 12:00:00
PAY00564	ORD00792	Cash on Delivery	1428900.54	2024-01-07 00:00:00
PAY00565	ORD00795	Cash on Delivery	103294.81	2024-07-23 20:00:00
PAY00566	ORD00796	Bank Transfer	51096.45	2024-06-12 21:00:00
PAY00567	ORD00797	Mobile Money	816.52	2024-06-22 14:00:00
PAY00568	ORD00798	Bank Transfer	460779.85	2024-07-19 07:00:00
PAY00569	ORD00799	Card	82563.21	2024-12-16 12:00:00
PAY00570	ORD00801	Mobile Money	74516.28	2024-11-17 06:00:00
PAY00571	ORD00802	Bank Transfer	1032680.62	2024-12-04 18:00:00
PAY00572	ORD00803	Bank Transfer	643024.25	2024-12-31 03:00:00
PAY00573	ORD00805	Bank Transfer	177974.85	2024-12-29 23:00:00
PAY00574	ORD00806	Card	8480.78	2024-12-06 16:00:00
PAY00575	ORD00807	Card	103538.61	2024-12-28 17:00:00
PAY00576	ORD00808	Cash on Delivery	87610.75	2024-12-21 05:00:00
PAY00577	ORD00809	Card	\N	2024-12-17 12:00:00
PAY00578	ORD00810	Bank Transfer	155979.39	2024-07-10 03:00:00
PAY00579	ORD00812	Mobile Money	194607.91	2024-12-08 03:00:00
PAY00580	ORD00813	Cash on Delivery	5416.29	2024-12-01 15:00:00
PAY00581	ORD00814	Bank Transfer	246012.35	2024-12-10 07:00:00
PAY00582	ORD00815	Card	91572.30	2024-05-25 10:00:00
PAY00583	ORD00816	Cash on Delivery	60039.89	2024-05-30 18:00:00
PAY00584	ORD00817	Cash on Delivery	308380.38	2024-12-22 00:00:00
PAY00585	ORD00819	Cash on Delivery	397793.53	2024-12-04 20:00:00
PAY00586	ORD00820	Card	24825.96	2023-05-12 22:00:00
PAY00587	ORD00821	Cash on Delivery	142890.79	2024-08-15 23:00:00
PAY00588	ORD00822	Bank Transfer	149126.89	2023-07-22 23:00:00
PAY00589	ORD00823	Bank Transfer	33288.69	2024-02-20 03:00:00
PAY00590	ORD00824	Card	15571.78	2024-08-14 16:00:00
PAY00591	ORD00825	Cash on Delivery	\N	2024-06-10 04:00:00
PAY00592	ORD00826	Card	361665.18	2024-02-05 00:00:00
PAY00593	ORD00827	Cash on Delivery	29001.62	2024-01-10 22:00:00
PAY00594	ORD00828	Cash on Delivery	527527.80	2024-05-25 15:00:00
PAY00595	ORD00829	Cash on Delivery	576056.05	2024-10-24 09:00:00
PAY00596	ORD00830	Cash on Delivery	2248.73	2024-10-27 01:00:00
PAY00597	ORD00831	Cash on Delivery	28585.35	2024-12-21 18:00:00
PAY00598	ORD00833	Cash on Delivery	308147.91	2024-01-01 21:00:00
PAY00599	ORD00834	Cash on Delivery	183000.43	2024-11-22 16:00:00
PAY00600	ORD00835	Cash on Delivery	93330.92	2024-04-19 17:00:00
PAY00601	ORD00836	Card	299320.66	2024-09-07 21:00:00
PAY00602	ORD00837	Mobile Money	7685.53	2024-10-23 13:00:00
PAY00603	ORD00841	Mobile Money	50533.44	2024-03-19 06:00:00
PAY00604	ORD00842	Mobile Money	31300.16	2024-05-19 00:00:00
PAY00605	ORD00844	Bank Transfer	\N	2024-11-01 13:00:00
PAY00606	ORD00845	Card	176253.29	2024-04-17 05:00:00
PAY00607	ORD00846	Card	325875.84	2024-05-17 12:00:00
PAY00608	ORD00847	Mobile Money	135696.98	2024-12-09 11:00:00
PAY00609	ORD00848	Mobile Money	73390.02	2024-07-10 00:00:00
PAY00610	ORD00849	Card	110640.11	2024-05-18 12:00:00
PAY00611	ORD00850	Cash on Delivery	20392.27	2024-10-27 05:00:00
PAY00612	ORD00851	Mobile Money	570375.48	2024-04-27 07:00:00
PAY00613	ORD00852	Cash on Delivery	216605.55	2024-03-22 19:00:00
PAY00614	ORD00853	Cash on Delivery	545501.09	2024-02-11 20:00:00
PAY00615	ORD00854	Mobile Money	140041.10	2024-01-06 12:00:00
PAY00616	ORD00855	Card	48024.83	2024-06-08 13:00:00
PAY00617	ORD00856	Cash on Delivery	885861.21	2024-10-21 19:00:00
PAY00618	ORD00857	Card	120073.18	2024-11-23 19:00:00
PAY00619	ORD00858	Cash on Delivery	51056.48	2024-04-29 19:00:00
PAY00620	ORD00861	Bank Transfer	2511.26	2024-11-02 20:00:00
PAY00621	ORD00862	Bank Transfer	32819.40	2023-12-26 17:00:00
PAY00622	ORD00863	Cash on Delivery	20590.75	2024-04-26 00:00:00
PAY00623	ORD00865	Cash on Delivery	102185.35	2024-04-15 10:00:00
PAY00624	ORD00866	Bank Transfer	1206982.05	2024-09-18 18:00:00
PAY00625	ORD00867	Card	23255.54	2024-07-22 17:00:00
PAY00626	ORD00868	Cash on Delivery	234388.12	2024-12-24 04:00:00
PAY00627	ORD00869	Mobile Money	179864.29	2024-06-16 02:00:00
PAY00628	ORD00870	Card	\N	2024-12-15 19:00:00
PAY00629	ORD00871	Cash on Delivery	14377.20	2024-11-30 00:00:00
PAY00630	ORD00872	Bank Transfer	679865.87	2024-09-09 13:00:00
PAY00631	ORD00873	Card	28922.62	2024-10-07 09:00:00
PAY00632	ORD00874	Mobile Money	135102.64	2024-09-01 06:00:00
PAY00633	ORD00875	Card	16199.28	2024-07-14 09:00:00
PAY00634	ORD00877	Mobile Money	104703.44	2024-09-23 21:00:00
PAY00635	ORD00878	Card	\N	2024-11-23 16:00:00
PAY00636	ORD00879	Mobile Money	175604.14	2024-11-02 15:00:00
PAY00637	ORD00880	Card	552557.03	2024-10-03 03:00:00
PAY00638	ORD00881	Card	110269.71	2024-04-01 19:00:00
PAY00639	ORD00882	Bank Transfer	109517.52	2023-10-24 17:00:00
PAY00640	ORD00884	Cash on Delivery	337069.86	2024-05-25 10:00:00
PAY00641	ORD00885	Card	183062.91	2024-09-12 08:00:00
PAY00642	ORD00886	Bank Transfer	55373.35	2024-02-08 12:00:00
PAY00643	ORD00888	Cash on Delivery	15006.39	2024-07-19 13:00:00
PAY00644	ORD00890	Card	2057186.68	2023-11-14 09:00:00
PAY00645	ORD00891	Mobile Money	114528.20	2023-08-14 09:00:00
PAY00646	ORD00892	Cash on Delivery	328067.34	2024-05-10 12:00:00
PAY00647	ORD00893	Cash on Delivery	85883.35	2024-08-06 05:00:00
PAY00648	ORD00895	Mobile Money	365253.79	2023-10-12 13:00:00
PAY00649	ORD00897	Card	1035554.73	2023-11-21 07:00:00
PAY00650	ORD00898	Mobile Money	364555.47	2024-09-14 23:00:00
PAY00651	ORD00899	Mobile Money	163247.70	2024-04-03 01:00:00
PAY00652	ORD00900	Cash on Delivery	14011.65	2024-10-01 08:00:00
PAY00653	ORD00901	Bank Transfer	90584.94	2024-08-20 17:00:00
PAY00654	ORD00902	Card	24376.32	2024-11-14 12:00:00
PAY00655	ORD00903	Card	252137.68	2024-08-31 19:00:00
PAY00656	ORD00904	Mobile Money	43142.24	2024-06-01 04:00:00
PAY00657	ORD00905	Card	38299.46	2024-10-09 12:00:00
PAY00658	ORD00906	Cash on Delivery	73288.78	2024-12-18 01:00:00
PAY00659	ORD00908	Card	1320381.28	2024-12-31 09:00:00
PAY00660	ORD00909	Bank Transfer	1887115.40	2024-11-09 07:00:00
PAY00661	ORD00910	Cash on Delivery	731989.14	2024-12-18 10:00:00
PAY00662	ORD00911	Card	377173.89	2024-11-25 17:00:00
PAY00663	ORD00912	Card	14095.84	2024-11-07 01:00:00
PAY00664	ORD00914	Mobile Money	719457.16	2024-11-04 19:00:00
PAY00665	ORD00915	Cash on Delivery	51810.86	2024-12-29 16:00:00
PAY00666	ORD00916	Mobile Money	14427.90	2024-11-24 15:00:00
PAY00667	ORD00917	Bank Transfer	\N	2024-10-15 04:00:00
PAY00668	ORD00918	Cash on Delivery	71972.01	2024-09-24 11:00:00
PAY00669	ORD00919	Card	\N	2024-04-14 11:00:00
PAY00670	ORD00920	Mobile Money	479176.61	2024-08-26 22:00:00
PAY00671	ORD00921	Card	72469.92	2024-08-31 09:00:00
PAY00672	ORD00922	Mobile Money	45102.28	2024-07-16 02:00:00
PAY00673	ORD00923	Bank Transfer	346394.23	2024-08-12 17:00:00
PAY00674	ORD00924	Card	95695.43	2024-09-05 12:00:00
PAY00675	ORD00926	Bank Transfer	134560.35	2024-06-26 20:00:00
PAY00676	ORD00929	Bank Transfer	1580460.04	2024-08-04 05:00:00
PAY00677	ORD00930	Mobile Money	310936.87	2024-04-12 00:00:00
PAY00678	ORD00931	Cash on Delivery	291536.08	2024-09-26 04:00:00
PAY00679	ORD00933	Card	6821.26	2024-07-25 01:00:00
PAY00680	ORD00934	Card	9207.08	2024-04-23 22:00:00
PAY00681	ORD00935	Cash on Delivery	513579.85	2024-09-23 16:00:00
PAY00682	ORD00936	Mobile Money	1368218.23	2024-10-12 16:00:00
PAY00683	ORD00938	Card	1192178.97	2023-10-02 01:00:00
PAY00684	ORD00940	Mobile Money	21340.87	2024-01-10 00:00:00
PAY00685	ORD00941	Card	170268.12	2024-08-26 09:00:00
PAY00686	ORD00944	Bank Transfer	12341.62	2024-04-07 21:00:00
PAY00687	ORD00945	Bank Transfer	746747.97	2023-08-10 04:00:00
PAY00688	ORD00946	Card	945114.90	2024-06-18 09:00:00
PAY00689	ORD00947	Cash on Delivery	285781.38	2024-11-19 05:00:00
PAY00690	ORD00948	Bank Transfer	\N	2023-05-09 07:00:00
PAY00691	ORD00949	Mobile Money	250844.04	2024-07-19 15:00:00
PAY00692	ORD00951	Card	775038.35	2024-08-20 21:00:00
PAY00693	ORD00952	Bank Transfer	12278.28	2024-10-20 07:00:00
PAY00694	ORD00953	Mobile Money	632732.68	2024-06-30 00:00:00
PAY00695	ORD00954	Card	14845.55	2024-10-10 14:00:00
PAY00696	ORD00955	Bank Transfer	215882.30	2024-09-26 16:00:00
PAY00697	ORD00957	Bank Transfer	213274.88	2024-07-03 07:00:00
PAY00698	ORD00958	Card	95695.43	2024-12-09 14:00:00
PAY00699	ORD00960	Cash on Delivery	266180.98	2024-10-22 17:00:00
PAY00700	ORD00961	Card	320608.15	2024-06-17 03:00:00
PAY00701	ORD00962	Card	492647.20	2024-07-27 00:00:00
PAY00702	ORD00963	Card	387335.12	2024-03-17 17:00:00
PAY00703	ORD00964	Card	25528.24	2024-04-07 00:00:00
PAY00704	ORD00965	Card	100048.28	2024-03-05 04:00:00
PAY00705	ORD00967	Bank Transfer	6821.26	2023-10-21 08:00:00
PAY00706	ORD00968	Mobile Money	153949.20	2023-12-05 07:00:00
PAY00707	ORD00969	Card	176857.47	2023-11-02 03:00:00
PAY00708	ORD00972	Cash on Delivery	1061481.88	2024-11-12 21:00:00
PAY00709	ORD00974	Card	187711.64	2024-08-23 16:00:00
PAY00710	ORD00976	Mobile Money	19169.60	2024-11-16 01:00:00
PAY00711	ORD00977	Mobile Money	36581.64	2024-04-01 12:00:00
PAY00712	ORD00978	Bank Transfer	11097.43	2024-06-29 10:00:00
PAY00713	ORD00979	Mobile Money	106466.10	2024-12-01 06:00:00
PAY00714	ORD00981	Cash on Delivery	334715.64	2024-09-23 18:00:00
PAY00715	ORD00982	Card	67894.35	2024-07-07 16:00:00
PAY00716	ORD00983	Card	1602.14	2024-11-01 04:00:00
PAY00717	ORD00984	Bank Transfer	1323987.05	2024-07-25 11:00:00
PAY00718	ORD00986	Card	13171.72	2024-02-17 13:00:00
PAY00719	ORD00988	Mobile Money	1515860.19	2023-04-17 12:00:00
PAY00720	ORD00989	Mobile Money	62992.61	2024-01-26 14:00:00
PAY00721	ORD00990	Cash on Delivery	337561.86	2023-10-11 22:00:00
PAY00722	ORD00991	Card	473129.95	2024-08-01 17:00:00
PAY00723	ORD00992	Card	19742.68	2023-10-28 12:00:00
PAY00724	ORD00993	Card	243429.47	2024-12-09 05:00:00
PAY00725	ORD00994	Card	556868.36	2024-12-01 23:00:00
PAY00726	ORD00995	Mobile Money	117897.53	2024-11-26 03:00:00
PAY00727	ORD00996	Card	117590.08	2024-09-14 07:00:00
PAY00728	ORD00997	Cash on Delivery	1067500.41	2023-11-07 19:00:00
PAY00729	ORD00999	Mobile Money	734304.98	2024-07-29 02:00:00
PAY00730	ORD01000	Card	\N	2023-07-02 23:00:00
PAY00731	ORD01001	Card	30282.75	2024-11-27 03:00:00
PAY00732	ORD01002	Cash on Delivery	26617.40	2024-04-05 03:00:00
PAY00733	ORD01003	Cash on Delivery	\N	2024-02-27 00:00:00
PAY00734	ORD01004	Cash on Delivery	391595.61	2025-01-01 03:00:00
PAY00735	ORD01005	Mobile Money	50868.08	2023-04-16 02:00:00
PAY00736	ORD01006	Bank Transfer	12650.30	2024-12-06 00:00:00
PAY00737	ORD01007	Cash on Delivery	17759.04	2024-11-20 01:00:00
PAY00738	ORD01008	Mobile Money	99842.46	2024-05-07 20:00:00
PAY00739	ORD01010	Bank Transfer	\N	2024-08-31 22:00:00
PAY00740	ORD01011	Cash on Delivery	309288.39	2024-10-01 06:00:00
PAY00741	ORD01012	Bank Transfer	137727.03	2024-12-06 01:00:00
PAY00742	ORD01014	Mobile Money	76142.09	2024-10-28 07:00:00
PAY00743	ORD01015	Bank Transfer	40632.15	2023-05-17 17:00:00
PAY00744	ORD01016	Bank Transfer	1018903.35	2023-11-01 00:00:00
PAY00745	ORD01017	Card	680880.78	2023-11-09 21:00:00
PAY00746	ORD01018	Mobile Money	467178.97	2024-03-17 11:00:00
PAY00747	ORD01019	Bank Transfer	23990.67	2024-12-22 05:00:00
PAY00853	ORD01155	Card	527944.80	2024-01-30 00:00:00
PAY00748	ORD01020	Bank Transfer	66459.48	2024-02-02 03:00:00
PAY00749	ORD01022	Bank Transfer	57794.83	2024-07-08 10:00:00
PAY00750	ORD01023	Bank Transfer	5399.76	2024-11-02 23:00:00
PAY00751	ORD01024	Bank Transfer	227279.12	2024-12-10 12:00:00
PAY00752	ORD01025	Cash on Delivery	26396.73	2024-07-23 04:00:00
PAY00753	ORD01026	Card	21604.29	2024-10-05 18:00:00
PAY00754	ORD01028	Bank Transfer	788128.86	2024-11-11 07:00:00
PAY00755	ORD01029	Cash on Delivery	1316488.47	2024-07-28 18:00:00
PAY00756	ORD01030	Cash on Delivery	24006.66	2024-06-13 09:00:00
PAY00757	ORD01034	Bank Transfer	30581.49	2023-12-23 02:00:00
PAY00758	ORD01036	Cash on Delivery	75976.50	2024-09-30 05:00:00
PAY00759	ORD01037	Bank Transfer	135063.48	2023-11-01 16:00:00
PAY00760	ORD01039	Bank Transfer	45557.08	2024-02-16 17:00:00
PAY00761	ORD01040	Mobile Money	48710.76	2023-12-04 21:00:00
PAY00762	ORD01041	Card	952072.75	2024-10-17 19:00:00
PAY00763	ORD01042	Cash on Delivery	154950.88	2024-12-19 20:00:00
PAY00764	ORD01043	Cash on Delivery	36491.25	2024-05-04 07:00:00
PAY00765	ORD01044	Cash on Delivery	353692.59	2024-01-29 05:00:00
PAY00766	ORD01045	Cash on Delivery	254267.42	2024-09-12 08:00:00
PAY00767	ORD01046	Mobile Money	23540.85	2024-12-16 22:00:00
PAY00768	ORD01047	Bank Transfer	36567.08	2024-10-22 11:00:00
PAY00769	ORD01048	Card	1229781.35	2024-10-26 22:00:00
PAY00770	ORD01049	Bank Transfer	679049.30	2024-10-13 07:00:00
PAY00771	ORD01050	Mobile Money	66595.50	2024-12-18 23:00:00
PAY00772	ORD01051	Card	34973.36	2024-10-17 04:00:00
PAY00773	ORD01052	Bank Transfer	58767.24	2024-10-21 10:00:00
PAY00774	ORD01053	Bank Transfer	1333503.85	2024-12-25 23:00:00
PAY00775	ORD01054	Bank Transfer	1038425.47	2024-10-02 00:00:00
PAY00776	ORD01055	Bank Transfer	51659.98	2024-08-15 06:00:00
PAY00777	ORD01057	Bank Transfer	42901.95	2024-06-15 22:00:00
PAY00778	ORD01058	Bank Transfer	39168.98	2024-12-21 15:00:00
PAY00779	ORD01059	Bank Transfer	407731.20	2024-12-27 14:00:00
PAY00780	ORD01060	Card	101388.10	2024-03-29 17:00:00
PAY00781	ORD01061	Mobile Money	118084.60	2023-12-07 14:00:00
PAY00782	ORD01062	Mobile Money	193997.28	2024-06-14 09:00:00
PAY00783	ORD01063	Card	317128.75	2024-09-01 19:00:00
PAY00784	ORD01066	Card	57025.35	2024-08-21 07:00:00
PAY00785	ORD01067	Mobile Money	\N	2025-01-01 21:00:00
PAY00786	ORD01068	Bank Transfer	931864.34	2024-12-20 06:00:00
PAY00787	ORD01069	Cash on Delivery	108201.85	2024-12-31 16:00:00
PAY00788	ORD01070	Card	136400.23	2024-11-06 17:00:00
PAY00789	ORD01071	Card	412524.16	2024-10-26 23:00:00
PAY00790	ORD01072	Cash on Delivery	26917.21	2024-10-23 18:00:00
PAY00791	ORD01073	Bank Transfer	1464648.35	2024-03-08 02:00:00
PAY00792	ORD01075	Bank Transfer	687406.40	2024-08-25 18:00:00
PAY00793	ORD01076	Cash on Delivery	335910.17	2023-12-31 14:00:00
PAY00794	ORD01077	Mobile Money	515070.46	2024-12-21 18:00:00
PAY00795	ORD01078	Mobile Money	48285.65	2023-11-12 10:00:00
PAY00796	ORD01080	Card	305515.78	2023-07-11 00:00:00
PAY00797	ORD01081	Card	4792.40	2023-10-04 08:00:00
PAY00798	ORD01085	Card	11386.20	2024-12-27 08:00:00
PAY00799	ORD01086	Mobile Money	596785.81	2023-06-05 03:00:00
PAY00800	ORD01087	Bank Transfer	44389.86	2024-12-20 11:00:00
PAY00801	ORD01088	Mobile Money	609401.78	2024-12-31 00:00:00
PAY00802	ORD01092	Cash on Delivery	1013423.02	2024-03-06 12:00:00
PAY00803	ORD01094	Cash on Delivery	87002.20	2024-06-29 09:00:00
PAY00804	ORD01096	Cash on Delivery	1139763.44	2024-11-22 19:00:00
PAY00805	ORD01097	Bank Transfer	35488.70	2024-04-29 22:00:00
PAY00806	ORD01098	Mobile Money	182319.68	2024-03-18 14:00:00
PAY00807	ORD01099	Bank Transfer	\N	2024-10-11 17:00:00
PAY00808	ORD01101	Bank Transfer	199930.87	2024-08-20 20:00:00
PAY00809	ORD01102	Mobile Money	143131.75	2024-06-27 02:00:00
PAY00810	ORD01103	Cash on Delivery	852463.48	2024-12-06 22:00:00
PAY00811	ORD01104	Cash on Delivery	53843.48	2024-06-20 17:00:00
PAY00812	ORD01106	Cash on Delivery	319248.56	2024-08-14 04:00:00
PAY00813	ORD01107	Mobile Money	1144574.29	2023-09-12 17:00:00
PAY00814	ORD01109	Mobile Money	94241.74	2024-08-09 23:00:00
PAY00815	ORD01110	Bank Transfer	16739.67	2023-08-31 22:00:00
PAY00816	ORD01111	Card	141950.72	2024-07-08 10:00:00
PAY00817	ORD01112	Cash on Delivery	162894.00	2024-10-09 04:00:00
PAY00818	ORD01113	Card	120150.56	2024-09-04 09:00:00
PAY00819	ORD01114	Mobile Money	41341.72	2024-07-10 05:00:00
PAY00820	ORD01115	Card	7077.96	2024-06-09 07:00:00
PAY00821	ORD01117	Card	58514.20	2023-03-22 13:00:00
PAY00822	ORD01118	Mobile Money	52971.75	2024-01-28 05:00:00
PAY00823	ORD01119	Cash on Delivery	51996.04	2024-07-22 01:00:00
PAY00824	ORD01120	Mobile Money	12460.22	2024-11-30 17:00:00
PAY00825	ORD01122	Mobile Money	98779.27	2024-08-04 08:00:00
PAY00826	ORD01123	Card	127390.86	2023-10-13 04:00:00
PAY00827	ORD01124	Bank Transfer	13921.15	2024-05-13 21:00:00
PAY00828	ORD01125	Bank Transfer	343450.84	2023-09-16 12:00:00
PAY00829	ORD01126	Cash on Delivery	\N	2024-05-08 09:00:00
PAY00830	ORD01127	Mobile Money	291464.46	2024-06-20 14:00:00
PAY00831	ORD01128	Cash on Delivery	567313.19	2023-08-23 07:00:00
PAY00832	ORD01129	Card	8016.63	2024-07-24 23:00:00
PAY00833	ORD01130	Card	540650.06	2024-11-08 14:00:00
PAY00834	ORD01131	Card	349632.08	2024-09-01 18:00:00
PAY00835	ORD01136	Mobile Money	6230.11	2024-10-08 17:00:00
PAY00836	ORD01137	Mobile Money	729035.92	2024-05-03 03:00:00
PAY00837	ORD01138	Card	940331.68	2024-07-11 12:00:00
PAY00838	ORD01139	Bank Transfer	74632.08	2024-07-15 19:00:00
PAY00839	ORD01140	Card	36749.26	2024-08-14 19:00:00
PAY00840	ORD01141	Card	686857.19	2024-05-10 14:00:00
PAY00841	ORD01142	Bank Transfer	247851.46	2024-12-29 04:00:00
PAY00842	ORD01143	Bank Transfer	1072928.69	2024-09-01 09:00:00
PAY00843	ORD01144	Card	\N	2024-06-04 09:00:00
PAY00844	ORD01146	Cash on Delivery	\N	2024-10-06 02:00:00
PAY00845	ORD01147	Card	900.70	2024-09-15 20:00:00
PAY00846	ORD01148	Mobile Money	5352.06	2024-11-14 10:00:00
PAY00847	ORD01149	Card	24046.50	2024-08-17 10:00:00
PAY00848	ORD01150	Bank Transfer	1255094.75	2024-07-22 06:00:00
PAY00849	ORD01151	Card	16350.70	2024-08-31 14:00:00
PAY00850	ORD01152	Card	69170.64	2023-05-07 17:00:00
PAY00851	ORD01153	Bank Transfer	16326.25	2024-04-26 14:00:00
PAY00852	ORD01154	Mobile Money	1310091.95	2024-04-19 17:00:00
PAY00854	ORD01156	Mobile Money	481758.40	2024-06-30 03:00:00
PAY00855	ORD01159	Bank Transfer	382139.74	2024-11-26 00:00:00
PAY00856	ORD01160	Cash on Delivery	487249.66	2024-12-01 07:00:00
PAY00857	ORD01161	Mobile Money	75449.74	2024-12-12 02:00:00
PAY00858	ORD01162	Card	28971.39	2023-10-19 19:00:00
PAY00859	ORD01163	Mobile Money	\N	2023-10-05 22:00:00
PAY00860	ORD01164	Bank Transfer	215427.32	2024-09-21 18:00:00
PAY00861	ORD01166	Bank Transfer	101134.25	2023-09-27 05:00:00
PAY00862	ORD01167	Cash on Delivery	72583.62	2023-09-03 07:00:00
PAY00863	ORD01169	Bank Transfer	171956.04	2024-05-08 14:00:00
PAY00864	ORD01171	Mobile Money	271932.37	2024-05-04 17:00:00
PAY00865	ORD01172	Cash on Delivery	11470.51	2024-05-29 15:00:00
PAY00866	ORD01175	Card	75701.89	2024-01-01 13:00:00
PAY00867	ORD01177	Bank Transfer	265248.35	2024-03-25 00:00:00
PAY00868	ORD01178	Card	1029403.72	2024-01-05 22:00:00
PAY00869	ORD01179	Mobile Money	15970.44	2024-05-19 19:00:00
PAY00870	ORD01180	Bank Transfer	29611.68	2024-05-15 07:00:00
PAY00871	ORD01181	Bank Transfer	169836.89	2024-12-08 00:00:00
PAY00872	ORD01183	Card	31522.68	2024-05-31 08:00:00
PAY00873	ORD01184	Card	\N	2024-11-19 12:00:00
PAY00874	ORD01185	Mobile Money	482209.15	2024-08-28 22:00:00
PAY00875	ORD01186	Card	15761.34	2024-03-21 13:00:00
PAY00876	ORD01187	Cash on Delivery	232908.60	2024-05-07 18:00:00
PAY00877	ORD01189	Card	509325.39	2024-06-19 14:00:00
PAY00878	ORD01190	Cash on Delivery	111871.28	2024-11-12 17:00:00
PAY00879	ORD01192	Mobile Money	107334.05	2024-11-13 17:00:00
PAY00880	ORD01193	Mobile Money	95556.59	2024-04-28 13:00:00
PAY00881	ORD01194	Card	14427.90	2023-08-17 17:00:00
PAY00882	ORD01195	Mobile Money	50601.20	2024-01-19 00:00:00
PAY00883	ORD01196	Card	80525.21	2024-04-28 16:00:00
PAY00884	ORD01197	Cash on Delivery	\N	2024-03-10 17:00:00
PAY00885	ORD01199	Mobile Money	874450.51	2024-08-17 21:00:00
PAY00886	ORD01200	Mobile Money	33329.69	2024-05-11 04:00:00
PAY00887	ORD01201	Cash on Delivery	13171.72	2023-09-03 22:00:00
PAY00888	ORD01202	Bank Transfer	10088.47	2023-04-23 18:00:00
PAY00889	ORD01204	Card	271042.29	2024-11-03 00:00:00
PAY00890	ORD01205	Cash on Delivery	200327.57	2024-12-21 19:00:00
PAY00891	ORD01206	Card	919080.41	2024-12-26 22:00:00
PAY00892	ORD01208	Bank Transfer	2348.14	2024-03-24 01:00:00
PAY00893	ORD01209	Cash on Delivery	475610.24	2024-09-15 10:00:00
PAY00894	ORD01210	Cash on Delivery	88519.54	2024-05-23 01:00:00
PAY00895	ORD01212	Mobile Money	7077.96	2024-12-15 17:00:00
PAY00896	ORD01214	Mobile Money	1363173.53	2024-04-15 02:00:00
PAY00897	ORD01216	Bank Transfer	277797.81	2024-11-23 15:00:00
PAY00898	ORD01218	Card	1015642.67	2024-08-23 05:00:00
PAY00899	ORD01220	Mobile Money	59382.20	2023-11-16 05:00:00
PAY00900	ORD01221	Cash on Delivery	43501.45	2024-04-16 17:00:00
PAY00901	ORD01222	Bank Transfer	\N	2023-05-31 05:00:00
PAY00902	ORD01223	Card	14402.86	2024-02-13 17:00:00
PAY00903	ORD01224	Card	80161.95	2023-07-15 20:00:00
PAY00904	ORD01225	Card	506570.74	2024-05-24 17:00:00
PAY00905	ORD01226	Bank Transfer	13862.43	2023-10-01 01:00:00
PAY00906	ORD01227	Card	264786.66	2023-02-23 12:00:00
PAY00907	ORD01228	Mobile Money	94467.68	2024-02-26 06:00:00
PAY00908	ORD01229	Card	1365823.52	2024-02-10 00:00:00
PAY00909	ORD01230	Cash on Delivery	244411.45	2024-11-21 09:00:00
PAY00910	ORD01231	Cash on Delivery	768841.50	2024-11-29 00:00:00
PAY00911	ORD01233	Card	60835.63	2024-10-17 15:00:00
PAY00912	ORD01234	Mobile Money	88545.48	2024-12-17 03:00:00
PAY00913	ORD01236	Card	150515.56	2024-11-27 19:00:00
PAY00914	ORD01237	Mobile Money	282271.60	2024-09-15 02:00:00
PAY00915	ORD01238	Bank Transfer	125277.25	2024-09-11 21:00:00
PAY00916	ORD01240	Bank Transfer	855219.84	2024-11-08 05:00:00
PAY00917	ORD01242	Bank Transfer	\N	2024-12-20 00:00:00
PAY00918	ORD01243	Mobile Money	3204.28	2024-09-21 18:00:00
PAY00919	ORD01244	Mobile Money	184897.87	2024-04-10 07:00:00
PAY00920	ORD01245	Cash on Delivery	332973.30	2024-03-19 02:00:00
PAY00921	ORD01246	Card	14402.86	2024-06-05 12:00:00
PAY00922	ORD01247	Card	215521.34	2024-05-30 22:00:00
PAY00923	ORD01248	Card	\N	2024-08-29 03:00:00
PAY00924	ORD01249	Cash on Delivery	627213.66	2024-01-31 14:00:00
PAY00925	ORD01250	Card	1532854.95	2023-08-03 05:00:00
PAY00926	ORD01251	Mobile Money	1488556.02	2024-11-27 17:00:00
PAY00927	ORD01252	Card	79623.58	2024-04-23 12:00:00
PAY00928	ORD01253	Mobile Money	1199432.67	2024-01-14 04:00:00
PAY00929	ORD01254	Mobile Money	559798.45	2024-10-10 06:00:00
PAY00930	ORD01256	Bank Transfer	46389.30	2024-07-29 02:00:00
PAY00931	ORD01257	Mobile Money	338489.64	2024-07-23 15:00:00
PAY00932	ORD01258	Cash on Delivery	67518.08	2024-04-14 05:00:00
PAY00933	ORD01260	Card	12699.55	2024-10-29 04:00:00
PAY00934	ORD01261	Cash on Delivery	98293.53	2024-07-27 08:00:00
PAY00935	ORD01263	Card	523651.34	2024-10-03 00:00:00
PAY00936	ORD01264	Card	95128.44	2024-03-27 21:00:00
PAY00937	ORD01265	Bank Transfer	98197.51	2024-09-06 10:00:00
PAY00938	ORD01266	Card	127598.57	2024-03-08 16:00:00
PAY00939	ORD01267	Card	96202.74	2024-01-05 15:00:00
PAY00940	ORD01268	Card	113014.76	2024-05-01 01:00:00
PAY00941	ORD01269	Card	18690.33	2024-01-12 11:00:00
PAY00942	ORD01272	Card	8028.09	2024-04-20 08:00:00
PAY00943	ORD01273	Mobile Money	60582.65	2024-06-11 00:00:00
PAY00944	ORD01275	Bank Transfer	308912.61	2023-11-09 12:00:00
PAY00945	ORD01276	Cash on Delivery	73629.38	2024-03-10 20:00:00
PAY00946	ORD01277	Bank Transfer	\N	2023-03-27 13:00:00
PAY00947	ORD01279	Cash on Delivery	30345.96	2023-12-03 12:00:00
PAY00948	ORD01280	Bank Transfer	\N	2024-07-31 13:00:00
PAY00949	ORD01281	Bank Transfer	37315.03	2024-04-10 22:00:00
PAY00950	ORD01283	Cash on Delivery	180084.64	2023-08-29 20:00:00
PAY00951	ORD01284	Mobile Money	430462.89	2024-12-24 09:00:00
PAY00952	ORD01286	Card	63045.36	2024-03-15 10:00:00
PAY00953	ORD01287	Card	509055.94	2023-09-24 18:00:00
PAY00954	ORD01288	Card	\N	2024-06-13 14:00:00
PAY00955	ORD01289	Bank Transfer	83437.72	2024-04-02 07:00:00
PAY00956	ORD01291	Card	101292.39	2023-04-14 02:00:00
PAY00957	ORD01292	Cash on Delivery	1759452.55	2024-06-24 17:00:00
PAY00958	ORD01293	Card	151263.40	2024-02-28 13:00:00
PAY00959	ORD01294	Card	13409.28	2024-08-25 12:00:00
PAY00960	ORD01295	Cash on Delivery	668077.43	2024-06-21 10:00:00
PAY00961	ORD01297	Cash on Delivery	1090050.21	2024-06-05 17:00:00
PAY00962	ORD01298	Cash on Delivery	51425.70	2024-06-07 06:00:00
PAY00963	ORD01300	Cash on Delivery	32796.92	2024-05-19 15:00:00
PAY00964	ORD01301	Mobile Money	1343803.78	2024-06-13 01:00:00
PAY00965	ORD01302	Bank Transfer	24585.89	2024-12-11 14:00:00
PAY00966	ORD01303	Card	182439.52	2024-11-18 19:00:00
PAY00967	ORD01304	Card	44912.78	2024-10-10 22:00:00
PAY00968	ORD01305	Card	919640.12	2024-01-28 21:00:00
PAY00969	ORD01306	Mobile Money	110900.42	2024-11-08 15:00:00
PAY00970	ORD01309	Card	\N	2024-07-30 11:00:00
PAY00971	ORD01310	Cash on Delivery	29570.18	2024-09-29 21:00:00
PAY00972	ORD01311	Cash on Delivery	217322.84	2023-06-21 19:00:00
PAY00973	ORD01313	Mobile Money	265518.94	2023-09-10 10:00:00
PAY00974	ORD01314	Cash on Delivery	68157.62	2024-11-18 08:00:00
PAY00975	ORD01316	Card	\N	2024-04-27 19:00:00
PAY00976	ORD01319	Card	261871.45	2024-02-10 09:00:00
PAY00977	ORD01321	Bank Transfer	171956.04	2023-10-21 18:00:00
PAY00978	ORD01322	Cash on Delivery	49812.90	2024-08-20 16:00:00
PAY00979	ORD01323	Mobile Money	191306.61	2023-10-10 06:00:00
PAY00980	ORD01325	Mobile Money	289181.78	2024-02-24 19:00:00
PAY00981	ORD01326	Mobile Money	90042.32	2024-06-02 10:00:00
PAY00982	ORD01327	Card	31091.23	2024-07-07 06:00:00
PAY00983	ORD01328	Bank Transfer	756460.81	2024-09-28 21:00:00
PAY00984	ORD01329	Mobile Money	53108.20	2023-09-29 22:00:00
PAY00985	ORD01330	Cash on Delivery	\N	2024-05-09 19:00:00
PAY00986	ORD01331	Mobile Money	117469.19	2023-05-25 06:00:00
PAY00987	ORD01333	Mobile Money	380265.64	2024-09-01 20:00:00
PAY00988	ORD01334	Card	3849.92	2023-05-29 18:00:00
PAY00989	ORD01335	Cash on Delivery	\N	2024-11-15 03:00:00
PAY00990	ORD01336	Cash on Delivery	47472.78	2023-10-14 23:00:00
PAY00991	ORD01337	Bank Transfer	65577.92	2024-10-19 05:00:00
PAY00992	ORD01338	Mobile Money	124747.54	2024-08-16 14:00:00
PAY00993	ORD01340	Mobile Money	244771.48	2023-10-30 19:00:00
PAY00994	ORD01344	Card	\N	2024-11-30 05:00:00
PAY00995	ORD01345	Mobile Money	60942.63	2024-12-05 06:00:00
PAY00996	ORD01346	Mobile Money	5755.30	2024-12-18 22:00:00
PAY00997	ORD01347	Bank Transfer	408079.72	2024-04-21 11:00:00
PAY00998	ORD01349	Cash on Delivery	103986.26	2024-01-14 12:00:00
PAY00999	ORD01350	Cash on Delivery	9207.08	2024-06-03 01:00:00
PAY01000	ORD01353	Card	2149209.07	2024-11-03 15:00:00
PAY01001	ORD01354	Bank Transfer	324717.30	2024-08-07 04:00:00
PAY01002	ORD01355	Card	1317086.90	2024-05-07 00:00:00
PAY01003	ORD01356	Card	1144891.00	2024-09-28 12:00:00
PAY01004	ORD01357	Mobile Money	189703.99	2024-12-12 03:00:00
PAY01005	ORD01359	Card	135696.91	2024-04-25 18:00:00
PAY01006	ORD01360	Mobile Money	528191.14	2024-04-11 16:00:00
PAY01007	ORD01361	Card	100004.00	2024-09-04 10:00:00
PAY01008	ORD01362	Cash on Delivery	9954.82	2024-06-15 09:00:00
PAY01009	ORD01364	Cash on Delivery	888627.76	2024-08-27 20:00:00
PAY01010	ORD01365	Cash on Delivery	191900.83	2023-12-12 01:00:00
PAY01011	ORD01366	Mobile Money	506720.90	2024-02-06 19:00:00
PAY01012	ORD01367	Bank Transfer	289357.03	2024-11-23 06:00:00
PAY01013	ORD01368	Card	18080.28	2024-06-24 23:00:00
PAY01014	ORD01370	Mobile Money	154882.11	2024-05-23 15:00:00
PAY01015	ORD01371	Bank Transfer	905535.81	2024-04-30 06:00:00
PAY01016	ORD01372	Card	7092.62	2024-06-01 13:00:00
PAY01017	ORD01373	Card	344086.23	2024-11-26 05:00:00
PAY01018	ORD01374	Card	1027134.30	2024-12-06 20:00:00
PAY01019	ORD01375	Bank Transfer	515070.46	2024-12-15 14:00:00
PAY01020	ORD01377	Card	41043.57	2024-12-01 20:00:00
PAY01021	ORD01378	Mobile Money	509664.00	2024-11-22 12:00:00
PAY01022	ORD01379	Mobile Money	787954.12	2024-11-11 12:00:00
PAY01023	ORD01382	Card	336920.80	2024-01-21 03:00:00
PAY01024	ORD01385	Cash on Delivery	604011.00	2024-02-23 12:00:00
PAY01025	ORD01386	Card	240474.84	2024-03-16 00:00:00
PAY01026	ORD01387	Card	409790.96	2024-08-18 20:00:00
PAY01027	ORD01389	Card	499557.85	2023-11-12 09:00:00
PAY01028	ORD01390	Bank Transfer	64814.68	2024-11-18 09:00:00
PAY01029	ORD01391	Bank Transfer	3628.18	2024-03-12 02:00:00
PAY01030	ORD01393	Mobile Money	622605.57	2024-12-16 10:00:00
PAY01031	ORD01394	Card	946234.05	2024-09-23 23:00:00
PAY01032	ORD01395	Card	49739.73	2024-06-19 11:00:00
PAY01033	ORD01397	Bank Transfer	407337.51	2024-11-09 23:00:00
PAY01034	ORD01398	Mobile Money	24825.96	2024-07-01 00:00:00
PAY01035	ORD01399	Mobile Money	1042211.85	2024-12-13 08:00:00
PAY01036	ORD01400	Mobile Money	\N	2024-09-14 00:00:00
PAY01037	ORD01401	Cash on Delivery	2944.75	2024-12-25 22:00:00
PAY01038	ORD01403	Bank Transfer	92706.45	2024-09-09 08:00:00
PAY01039	ORD01404	Mobile Money	\N	2024-04-10 21:00:00
PAY01040	ORD01405	Bank Transfer	305798.40	2023-10-31 05:00:00
PAY01041	ORD01406	Cash on Delivery	\N	2024-09-25 05:00:00
PAY01042	ORD01407	Bank Transfer	104826.28	2024-09-25 16:00:00
PAY01043	ORD01408	Mobile Money	1940456.15	2024-12-11 13:00:00
PAY01044	ORD01409	Mobile Money	9563.86	2024-12-25 18:00:00
PAY01045	ORD01411	Card	505004.26	2024-08-24 21:00:00
PAY01046	ORD01412	Bank Transfer	703636.90	2023-10-27 10:00:00
PAY01047	ORD01413	Mobile Money	205073.54	2024-06-15 13:00:00
PAY01048	ORD01414	Cash on Delivery	207598.77	2024-07-07 04:00:00
PAY01049	ORD01416	Mobile Money	\N	2024-07-18 06:00:00
PAY01050	ORD01417	Cash on Delivery	602922.95	2023-09-05 20:00:00
PAY01051	ORD01420	Card	42820.06	2023-10-15 08:00:00
PAY01052	ORD01421	Bank Transfer	267736.80	2024-01-16 11:00:00
PAY01053	ORD01422	Cash on Delivery	409790.96	2024-11-13 11:00:00
PAY01054	ORD01423	Mobile Money	69992.67	2024-04-18 14:00:00
PAY01055	ORD01424	Bank Transfer	504390.28	2024-07-26 00:00:00
PAY01056	ORD01426	Card	14239.20	2024-07-31 20:00:00
PAY01057	ORD01427	Bank Transfer	506311.33	2024-09-20 00:00:00
PAY01058	ORD01429	Mobile Money	201503.45	2023-11-14 00:00:00
PAY01059	ORD01430	Card	52539.60	2024-01-04 07:00:00
PAY01060	ORD01431	Cash on Delivery	58923.21	2024-05-05 00:00:00
PAY01061	ORD01432	Cash on Delivery	48285.65	2024-06-08 00:00:00
PAY01062	ORD01433	Bank Transfer	1061234.59	2024-10-07 13:00:00
PAY01063	ORD01434	Mobile Money	199354.44	2023-11-08 16:00:00
PAY01064	ORD01435	Mobile Money	10621.64	2024-12-21 08:00:00
PAY01065	ORD01436	Mobile Money	63394.81	2024-04-05 00:00:00
PAY01066	ORD01437	Card	278279.64	2024-10-16 04:00:00
PAY01067	ORD01438	Mobile Money	57981.42	2023-12-03 00:00:00
PAY01068	ORD01441	Mobile Money	74245.65	2024-06-11 12:00:00
PAY01069	ORD01442	Mobile Money	65303.75	2024-03-06 14:00:00
PAY01070	ORD01443	Card	326360.99	2024-08-03 02:00:00
PAY01071	ORD01445	Mobile Money	164719.61	2024-12-11 09:00:00
PAY01072	ORD01446	Mobile Money	22051.24	2024-11-15 15:00:00
PAY01073	ORD01448	Card	130265.75	2023-11-10 13:00:00
PAY01074	ORD01449	Mobile Money	695495.94	2024-11-25 00:00:00
PAY01075	ORD01450	Card	276291.22	2023-08-11 08:00:00
PAY01076	ORD01452	Card	129981.66	2023-12-13 06:00:00
PAY01077	ORD01453	Card	1281402.50	2023-07-28 17:00:00
PAY01078	ORD01455	Cash on Delivery	103319.96	2024-12-26 00:00:00
PAY01079	ORD01456	Mobile Money	437118.57	2024-12-02 17:00:00
PAY01080	ORD01457	Bank Transfer	68557.15	2024-12-03 20:00:00
PAY01081	ORD01458	Mobile Money	11561.20	2024-11-05 00:00:00
PAY01082	ORD01459	Cash on Delivery	85496.84	2024-03-19 13:00:00
PAY01083	ORD01460	Card	358922.60	2024-06-01 10:00:00
PAY01084	ORD01462	Mobile Money	842568.75	2024-03-28 00:00:00
PAY01085	ORD01463	Bank Transfer	169891.58	2024-06-19 08:00:00
PAY01086	ORD01464	Card	337069.86	2024-08-10 00:00:00
PAY01087	ORD01465	Card	155573.74	2024-08-30 05:00:00
PAY01088	ORD01467	Cash on Delivery	555466.70	2024-10-16 06:00:00
PAY01089	ORD01468	Mobile Money	97722.81	2024-12-17 13:00:00
PAY01090	ORD01469	Cash on Delivery	31709.48	2024-08-12 02:00:00
PAY01091	ORD01471	Card	173260.79	2024-11-13 21:00:00
PAY01092	ORD01472	Mobile Money	110269.71	2024-12-27 18:00:00
PAY01093	ORD01473	Mobile Money	42328.70	2024-02-14 13:00:00
PAY01094	ORD01474	Card	772605.69	2023-04-04 07:00:00
PAY01095	ORD01475	Cash on Delivery	296286.45	2023-08-01 21:00:00
PAY01096	ORD01476	Bank Transfer	49605.18	2024-10-30 02:00:00
PAY01097	ORD01477	Mobile Money	292254.69	2024-11-25 14:00:00
PAY01098	ORD01481	Cash on Delivery	51526.03	2024-12-14 13:00:00
PAY01099	ORD01482	Bank Transfer	32529.36	2024-08-21 03:00:00
PAY01100	ORD01483	Card	76292.93	2024-09-12 19:00:00
PAY01101	ORD01484	Cash on Delivery	628381.84	2024-09-20 13:00:00
PAY01102	ORD01485	Mobile Money	125806.75	2024-06-21 07:00:00
PAY01103	ORD01486	Mobile Money	294670.24	2024-08-04 08:00:00
PAY01104	ORD01487	Card	442560.44	2024-10-09 07:00:00
PAY01105	ORD01489	Mobile Money	145263.16	2024-10-15 02:00:00
PAY01106	ORD01490	Card	168765.99	2024-11-19 23:00:00
PAY01107	ORD01492	Card	114532.41	2024-11-30 14:00:00
PAY01108	ORD01493	Bank Transfer	573477.05	2024-11-18 14:00:00
PAY01109	ORD01495	Card	1042351.76	2023-10-28 00:00:00
PAY01110	ORD01498	Mobile Money	243727.04	2023-09-29 19:00:00
PAY01111	ORD01499	Card	180153.97	2024-03-09 08:00:00
PAY01112	ORD01500	Card	420883.00	2024-03-02 04:00:00
PAY01113	ORD01502	Cash on Delivery	\N	2024-05-27 00:00:00
PAY01114	ORD01503	Card	651736.73	2024-02-25 15:00:00
PAY01115	ORD01504	Card	407731.20	2023-07-05 20:00:00
PAY01116	ORD01505	Mobile Money	25905.43	2023-06-21 05:00:00
PAY01117	ORD01506	Mobile Money	327218.95	2023-07-09 10:00:00
PAY01118	ORD01507	Cash on Delivery	93330.92	2024-04-24 16:00:00
PAY01119	ORD01508	Cash on Delivery	68942.67	2024-11-07 05:00:00
PAY01120	ORD01509	Card	18117.48	2024-07-16 11:00:00
PAY01121	ORD01511	Cash on Delivery	804733.40	2024-06-10 12:00:00
PAY01122	ORD01515	Cash on Delivery	\N	2024-02-09 02:00:00
PAY01123	ORD01516	Bank Transfer	716689.83	2023-06-09 04:00:00
PAY01124	ORD01518	Mobile Money	37123.11	2024-02-16 11:00:00
PAY01125	ORD01519	Cash on Delivery	25399.10	2024-10-09 01:00:00
PAY01126	ORD01520	Cash on Delivery	32412.37	2024-06-30 12:00:00
PAY01127	ORD01521	Cash on Delivery	61852.40	2024-09-11 13:00:00
PAY01128	ORD01522	Bank Transfer	970312.13	2024-10-19 11:00:00
PAY01129	ORD01523	Mobile Money	120043.30	2023-12-29 11:00:00
PAY01130	ORD01524	Cash on Delivery	381487.47	2024-07-16 14:00:00
PAY01131	ORD01525	Cash on Delivery	152620.50	2024-06-16 00:00:00
PAY01132	ORD01526	Mobile Money	1741171.42	2024-04-06 05:00:00
PAY01133	ORD01527	Card	1506030.00	2024-02-27 01:00:00
PAY01134	ORD01528	Card	\N	2023-12-09 09:00:00
PAY01135	ORD01531	Card	13409.28	2023-08-13 16:00:00
PAY01136	ORD01532	Card	14771.68	2023-09-17 20:00:00
PAY01137	ORD01533	Bank Transfer	1602.14	2023-08-22 00:00:00
PAY01138	ORD01536	Mobile Money	91572.30	2024-10-01 13:00:00
PAY01139	ORD01537	Bank Transfer	323619.81	2024-11-01 22:00:00
PAY01140	ORD01538	Bank Transfer	\N	2024-12-14 23:00:00
PAY01141	ORD01539	Bank Transfer	46665.46	2024-11-06 21:00:00
PAY01142	ORD01541	Cash on Delivery	465301.97	2024-08-11 04:00:00
PAY01143	ORD01543	Mobile Money	609597.45	2024-04-26 12:00:00
PAY01144	ORD01544	Bank Transfer	321721.45	2024-09-26 07:00:00
PAY01145	ORD01545	Bank Transfer	1738086.01	2024-09-06 23:00:00
PAY01146	ORD01546	Bank Transfer	610317.96	2024-06-30 21:00:00
PAY01147	ORD01547	Card	40190.19	2024-10-13 08:00:00
PAY01148	ORD01549	Card	32496.44	2024-12-05 12:00:00
PAY01149	ORD01550	Bank Transfer	51604.24	2024-11-18 13:00:00
PAY01150	ORD01551	Bank Transfer	47284.02	2024-06-05 09:00:00
PAY01151	ORD01552	Cash on Delivery	86352.92	2023-06-18 19:00:00
PAY01152	ORD01556	Bank Transfer	263606.60	2023-10-18 21:00:00
PAY01153	ORD01558	Mobile Money	\N	2024-05-14 02:00:00
PAY01154	ORD01559	Card	99989.07	2024-02-16 03:00:00
PAY01155	ORD01560	Card	198912.26	2024-05-18 18:00:00
PAY01156	ORD01561	Bank Transfer	204806.12	2024-12-17 23:00:00
PAY01157	ORD01562	Card	358879.83	2024-07-09 14:00:00
PAY01158	ORD01564	Card	\N	2023-11-13 08:00:00
PAY01159	ORD01565	Cash on Delivery	1401503.52	2024-05-07 11:00:00
PAY01160	ORD01566	Card	56009.43	2024-12-01 19:00:00
PAY01161	ORD01567	Card	99076.62	2024-04-20 05:00:00
PAY01162	ORD01568	Card	339257.53	2023-07-01 15:00:00
PAY01163	ORD01569	Card	\N	2023-07-19 23:00:00
PAY01164	ORD01570	Bank Transfer	523208.74	2023-11-19 01:00:00
PAY01165	ORD01571	Card	458781.64	2024-08-03 16:00:00
PAY01166	ORD01572	Card	25061.13	2024-12-08 23:00:00
PAY01167	ORD01573	Mobile Money	5914.40	2024-12-07 21:00:00
PAY01168	ORD01574	Card	540458.75	2024-01-29 23:00:00
PAY01169	ORD01576	Card	91114.16	2024-09-12 06:00:00
PAY01170	ORD01579	Mobile Money	739805.40	2023-07-28 14:00:00
PAY01171	ORD01580	Card	69998.19	2024-07-19 00:00:00
PAY01172	ORD01581	Bank Transfer	38342.82	2023-10-04 06:00:00
PAY01173	ORD01582	Card	\N	2023-07-04 14:00:00
PAY01174	ORD01584	Mobile Money	4696.28	2024-06-27 14:00:00
PAY01175	ORD01586	Card	825680.81	2024-11-30 22:00:00
PAY01176	ORD01587	Bank Transfer	100339.89	2024-12-10 07:00:00
PAY01177	ORD01588	Mobile Money	1781841.04	2024-11-23 10:00:00
PAY01178	ORD01590	Bank Transfer	454316.32	2024-05-15 06:00:00
PAY01179	ORD01592	Bank Transfer	484414.91	2023-10-07 17:00:00
PAY01180	ORD01594	Bank Transfer	33479.34	2024-03-02 17:00:00
PAY01181	ORD01595	Cash on Delivery	32496.44	2024-11-22 16:00:00
PAY01182	ORD01596	Mobile Money	52346.95	2023-12-17 18:00:00
PAY01183	ORD01597	Mobile Money	\N	2024-07-22 19:00:00
PAY01184	ORD01598	Card	2277.57	2024-06-22 23:00:00
PAY01185	ORD01599	Mobile Money	57552.08	2023-10-19 00:00:00
PAY01186	ORD01600	Mobile Money	\N	2024-12-13 10:00:00
PAY01187	ORD01601	Bank Transfer	106784.91	2023-10-20 16:00:00
PAY01188	ORD01602	Bank Transfer	978096.05	2023-04-30 07:00:00
PAY01189	ORD01604	Cash on Delivery	28812.35	2024-12-09 14:00:00
PAY01190	ORD01605	Mobile Money	31477.40	2024-12-08 14:00:00
PAY01191	ORD01607	Card	96615.35	2024-06-06 18:00:00
PAY01192	ORD01609	Card	199233.48	2024-02-27 09:00:00
PAY01193	ORD01611	Mobile Money	789996.34	2024-05-21 23:00:00
PAY01194	ORD01612	Mobile Money	22960.29	2024-12-27 13:00:00
PAY01195	ORD01613	Bank Transfer	206048.30	2024-09-12 21:00:00
PAY01196	ORD01614	Bank Transfer	1272167.51	2024-10-01 23:00:00
PAY01197	ORD01615	Card	\N	2023-12-19 11:00:00
PAY01198	ORD01617	Cash on Delivery	40465.27	2024-12-04 16:00:00
PAY01199	ORD01619	Cash on Delivery	638415.97	2024-06-10 03:00:00
PAY01200	ORD01620	Card	865087.23	2024-04-10 06:00:00
PAY01201	ORD01622	Cash on Delivery	45708.85	2024-07-30 16:00:00
PAY01202	ORD01623	Card	7172.97	2023-06-07 08:00:00
PAY01203	ORD01624	Cash on Delivery	215711.20	2024-04-15 16:00:00
PAY01204	ORD01625	Bank Transfer	310749.90	2024-06-22 15:00:00
PAY01205	ORD01626	Card	325806.45	2024-05-16 10:00:00
PAY01206	ORD01627	Cash on Delivery	767003.95	2024-09-28 09:00:00
PAY01207	ORD01629	Mobile Money	\N	2023-06-06 18:00:00
PAY01208	ORD01630	Cash on Delivery	380329.47	2024-08-31 12:00:00
PAY01209	ORD01632	Card	64122.63	2024-07-12 07:00:00
PAY01210	ORD01634	Bank Transfer	77315.50	2024-05-10 00:00:00
PAY01211	ORD01635	Card	544947.62	2024-10-22 21:00:00
PAY01212	ORD01636	Bank Transfer	84100.44	2024-02-10 18:00:00
PAY01213	ORD01637	Card	116488.73	2023-12-30 23:00:00
PAY01214	ORD01639	Card	\N	2024-10-12 11:00:00
PAY01215	ORD01640	Bank Transfer	40877.16	2024-08-19 22:00:00
PAY01216	ORD01641	Cash on Delivery	102403.06	2024-07-15 23:00:00
PAY01217	ORD01642	Cash on Delivery	168353.89	2023-12-17 00:00:00
PAY01218	ORD01643	Bank Transfer	159679.04	2024-02-25 15:00:00
PAY01219	ORD01645	Mobile Money	11386.20	2024-07-27 17:00:00
PAY01220	ORD01646	Mobile Money	100013.23	2024-09-22 04:00:00
PAY01221	ORD01647	Card	629898.03	2024-05-11 00:00:00
PAY01222	ORD01648	Mobile Money	141953.36	2024-05-25 15:00:00
PAY01223	ORD01650	Cash on Delivery	1462057.55	2024-10-18 00:00:00
PAY01224	ORD01651	Mobile Money	805628.22	2024-04-13 10:00:00
PAY01225	ORD01653	Mobile Money	311454.20	2024-09-03 17:00:00
PAY01226	ORD01654	Card	160108.43	2024-06-10 06:00:00
PAY01227	ORD01655	Cash on Delivery	809604.90	2024-06-13 00:00:00
PAY01228	ORD01656	Card	\N	2024-10-23 02:00:00
PAY01229	ORD01658	Bank Transfer	471756.64	2024-02-03 00:00:00
PAY01230	ORD01659	Mobile Money	1349163.71	2024-02-01 22:00:00
PAY01231	ORD01660	Card	187646.29	2024-12-02 03:00:00
PAY01232	ORD01662	Bank Transfer	141135.80	2023-06-02 03:00:00
PAY01233	ORD01663	Cash on Delivery	87482.09	2024-09-20 19:00:00
PAY01234	ORD01664	Bank Transfer	1158907.10	2024-05-20 12:00:00
PAY01235	ORD01665	Card	211679.32	2024-01-11 05:00:00
PAY01236	ORD01666	Bank Transfer	182560.65	2024-09-05 13:00:00
PAY01237	ORD01667	Card	\N	2024-04-24 07:00:00
PAY01238	ORD01669	Card	1280228.45	2024-12-26 16:00:00
PAY01239	ORD01670	Bank Transfer	51492.75	2024-06-14 16:00:00
PAY01240	ORD01671	Mobile Money	107691.70	2023-03-15 09:00:00
PAY01241	ORD01672	Card	158321.24	2023-05-08 00:00:00
PAY01242	ORD01673	Bank Transfer	53762.13	2024-03-26 19:00:00
PAY01243	ORD01674	Card	39655.64	2024-12-29 02:00:00
PAY01244	ORD01675	Mobile Money	1281457.61	2024-10-16 10:00:00
PAY01245	ORD01676	Cash on Delivery	86284.48	2024-11-17 12:00:00
PAY01246	ORD01678	Card	6438.96	2024-05-29 22:00:00
PAY01247	ORD01680	Bank Transfer	129842.64	2024-10-05 14:00:00
PAY01248	ORD01681	Bank Transfer	48648.69	2024-12-06 21:00:00
PAY01249	ORD01682	Bank Transfer	530860.46	2024-03-21 07:00:00
PAY01250	ORD01683	Cash on Delivery	25910.95	2024-01-23 18:00:00
PAY01251	ORD01684	Bank Transfer	78806.70	2024-09-21 14:00:00
PAY01252	ORD01686	Card	437628.20	2024-01-16 01:00:00
PAY01253	ORD01687	Card	135442.10	2024-06-26 06:00:00
PAY01254	ORD01688	Card	54388.50	2023-05-12 09:00:00
PAY01255	ORD01689	Bank Transfer	584934.80	2023-08-08 13:00:00
PAY01256	ORD01690	Card	351142.20	2024-09-13 01:00:00
PAY01257	ORD01691	Bank Transfer	425267.89	2024-10-26 06:00:00
PAY01258	ORD01692	Cash on Delivery	441078.84	2024-08-27 22:00:00
PAY01259	ORD01693	Card	339524.65	2024-08-01 00:00:00
PAY01260	ORD01694	Bank Transfer	5712.84	2024-06-13 17:00:00
PAY01261	ORD01695	Card	26343.44	2024-12-30 07:00:00
PAY01262	ORD01696	Card	2847.84	2024-12-16 05:00:00
PAY01263	ORD01698	Card	23616.92	2024-09-23 11:00:00
PAY01264	ORD01699	Card	\N	2024-09-30 20:00:00
PAY01265	ORD01702	Card	499862.83	2024-03-25 23:00:00
PAY01266	ORD01703	Card	25905.43	2024-03-27 20:00:00
PAY01267	ORD01704	Card	\N	2024-05-18 10:00:00
PAY01268	ORD01705	Card	563880.02	2024-12-23 02:00:00
PAY01269	ORD01706	Mobile Money	68699.92	2024-11-25 13:00:00
PAY01270	ORD01707	Cash on Delivery	497712.95	2024-12-06 14:00:00
PAY01271	ORD01708	Cash on Delivery	130015.70	2024-11-25 19:00:00
PAY01272	ORD01709	Mobile Money	1220840.69	2024-11-26 12:00:00
PAY01273	ORD01710	Cash on Delivery	333752.14	2024-11-28 02:00:00
PAY01274	ORD01711	Cash on Delivery	4038.10	2024-11-23 06:00:00
PAY01275	ORD01712	Cash on Delivery	23765.62	2024-12-01 19:00:00
PAY01276	ORD01713	Cash on Delivery	5323.48	2024-12-26 04:00:00
PAY01277	ORD01714	Mobile Money	691596.36	2024-12-23 14:00:00
PAY01278	ORD01715	Mobile Money	70505.99	2024-07-26 08:00:00
PAY01279	ORD01716	Bank Transfer	82979.02	2024-11-15 11:00:00
PAY01280	ORD01717	Mobile Money	1065848.19	2024-06-21 03:00:00
PAY01281	ORD01719	Card	74245.65	2024-09-28 22:00:00
PAY01282	ORD01720	Mobile Money	194600.30	2024-04-24 06:00:00
PAY01283	ORD01721	Card	675417.62	2023-12-17 17:00:00
PAY01284	ORD01723	Card	994838.80	2024-02-14 23:00:00
PAY01285	ORD01725	Card	34157.64	2024-08-26 18:00:00
PAY01286	ORD01726	Card	16961.56	2024-06-28 02:00:00
PAY01287	ORD01728	Bank Transfer	629332.63	2024-08-31 09:00:00
PAY01288	ORD01729	Card	501907.37	2024-07-07 04:00:00
PAY01289	ORD01730	Bank Transfer	82232.97	2024-09-18 06:00:00
PAY01290	ORD01731	Bank Transfer	32574.27	2024-07-25 23:00:00
PAY01291	ORD01732	Card	324828.96	2024-07-10 04:00:00
PAY01292	ORD01733	Bank Transfer	21912.74	2024-09-07 05:00:00
PAY01293	ORD01734	Bank Transfer	64122.63	2024-09-18 01:00:00
PAY01294	ORD01736	Card	\N	2024-07-13 10:00:00
PAY01295	ORD01737	Mobile Money	135283.44	2024-09-26 14:00:00
PAY01296	ORD01738	Cash on Delivery	269130.44	2024-09-04 17:00:00
PAY01297	ORD01740	Card	813081.63	2024-12-01 22:00:00
PAY01298	ORD01741	Card	1657410.01	2024-10-02 19:00:00
PAY01299	ORD01742	Bank Transfer	129271.75	2024-12-31 12:00:00
PAY01300	ORD01743	Cash on Delivery	1416912.17	2024-08-06 01:00:00
PAY01301	ORD01746	Card	192259.59	2024-05-21 11:00:00
PAY01302	ORD01748	Card	479117.75	2024-12-16 16:00:00
PAY01303	ORD01751	Cash on Delivery	33297.75	2024-12-22 17:00:00
PAY01304	ORD01752	Mobile Money	44306.32	2024-11-14 14:00:00
PAY01305	ORD01754	Cash on Delivery	195934.03	2024-10-31 19:00:00
PAY01306	ORD01755	Card	351805.72	2024-08-09 08:00:00
PAY01307	ORD01756	Bank Transfer	8076.20	2023-12-22 01:00:00
PAY01308	ORD01757	Card	395222.81	2023-09-01 09:00:00
PAY01309	ORD01758	Cash on Delivery	515070.46	2023-08-11 19:00:00
PAY01310	ORD01759	Card	136573.70	2024-06-30 04:00:00
PAY01311	ORD01761	Mobile Money	654050.30	2024-06-28 00:00:00
PAY01312	ORD01763	Card	1746773.40	2024-07-03 18:00:00
PAY01313	ORD01764	Bank Transfer	130130.84	2024-07-18 11:00:00
PAY01314	ORD01767	Mobile Money	476073.93	2024-06-02 03:00:00
PAY01315	ORD01771	Card	18080.28	2024-11-29 20:00:00
PAY01316	ORD01772	Bank Transfer	192990.07	2024-12-07 10:00:00
PAY01317	ORD01773	Mobile Money	1259946.96	2024-12-02 03:00:00
PAY01318	ORD01774	Cash on Delivery	\N	2024-08-25 12:00:00
PAY01319	ORD01776	Cash on Delivery	41117.60	2024-10-31 05:00:00
PAY01320	ORD01777	Bank Transfer	385456.22	2024-09-05 00:00:00
PAY01321	ORD01778	Mobile Money	5762.47	2024-07-25 09:00:00
PAY01322	ORD01779	Cash on Delivery	\N	2024-06-07 21:00:00
PAY01323	ORD01780	Card	390298.12	2024-02-13 17:00:00
PAY01324	ORD01781	Mobile Money	411387.98	2024-01-07 17:00:00
PAY01325	ORD01782	Mobile Money	56480.82	2024-06-12 01:00:00
PAY01326	ORD01783	Card	292210.30	2024-05-19 13:00:00
PAY01327	ORD01785	Card	30581.49	2023-09-19 11:00:00
PAY01328	ORD01786	Card	\N	2024-05-02 06:00:00
PAY01329	ORD01788	Card	439754.74	2024-05-13 22:00:00
PAY01330	ORD01789	Cash on Delivery	257364.90	2023-10-20 20:00:00
PAY01331	ORD01790	Card	335067.63	2024-11-07 20:00:00
PAY01332	ORD01791	Cash on Delivery	116573.24	2023-11-30 04:00:00
PAY01333	ORD01792	Bank Transfer	808571.70	2023-01-18 18:00:00
PAY01334	ORD01793	Card	234738.71	2023-07-25 08:00:00
PAY01335	ORD01794	Cash on Delivery	196809.88	2024-07-16 11:00:00
PAY01336	ORD01796	Card	211177.92	2023-07-29 04:00:00
PAY01337	ORD01797	Mobile Money	263054.64	2024-07-01 15:00:00
PAY01338	ORD01798	Cash on Delivery	145973.64	2023-01-26 22:00:00
PAY01339	ORD01799	Card	\N	2023-08-09 01:00:00
PAY01340	ORD01800	Card	782873.27	2024-01-01 19:00:00
PAY01341	ORD01802	Cash on Delivery	\N	2024-05-20 10:00:00
PAY01342	ORD01803	Mobile Money	117508.45	2023-05-13 16:00:00
PAY01343	ORD01804	Cash on Delivery	68037.48	2024-05-08 21:00:00
PAY01344	ORD01805	Card	71782.70	2024-12-25 05:00:00
PAY01345	ORD01806	Card	355773.52	2024-08-30 11:00:00
PAY01346	ORD01808	Mobile Money	654671.31	2024-09-01 04:00:00
PAY01347	ORD01810	Card	1158331.97	2024-12-30 17:00:00
PAY01348	ORD01811	Bank Transfer	101960.16	2024-10-20 12:00:00
PAY01349	ORD01812	Mobile Money	378503.96	2024-11-19 03:00:00
PAY01350	ORD01813	Bank Transfer	132157.53	2024-08-25 11:00:00
PAY01351	ORD01814	Mobile Money	75670.50	2024-12-17 09:00:00
PAY01352	ORD01815	Card	247824.46	2024-09-12 22:00:00
PAY01353	ORD01816	Card	638398.91	2024-11-30 02:00:00
PAY01354	ORD01817	Mobile Money	213131.04	2024-11-21 15:00:00
PAY01355	ORD01822	Mobile Money	180084.64	2024-10-18 02:00:00
PAY01356	ORD01823	Mobile Money	528573.66	2024-12-28 08:00:00
PAY01357	ORD01824	Bank Transfer	102403.06	2024-08-15 05:00:00
PAY01358	ORD01825	Mobile Money	337665.56	2024-06-27 19:00:00
PAY01359	ORD01826	Mobile Money	35031.88	2024-09-18 10:00:00
PAY01360	ORD01827	Cash on Delivery	722299.05	2024-12-02 20:00:00
PAY01361	ORD01828	Mobile Money	61579.68	2024-07-16 04:00:00
PAY01362	ORD01829	Cash on Delivery	1019878.78	2024-08-07 07:00:00
PAY01363	ORD01830	Cash on Delivery	229390.82	2024-06-30 21:00:00
PAY01364	ORD01832	Bank Transfer	137710.20	2024-02-03 11:00:00
PAY01365	ORD01833	Cash on Delivery	63364.03	2023-12-24 18:00:00
PAY01366	ORD01834	Bank Transfer	507870.22	2024-08-17 10:00:00
PAY01367	ORD01835	Mobile Money	42025.94	2024-09-17 00:00:00
PAY01368	ORD01836	Card	58338.32	2024-08-03 04:00:00
PAY01369	ORD01837	Card	19742.68	2024-03-25 11:00:00
PAY01370	ORD01838	Card	1622826.09	2024-11-22 17:00:00
PAY01371	ORD01839	Card	557510.13	2024-10-23 04:00:00
PAY01372	ORD01841	Cash on Delivery	32521.50	2024-08-08 08:00:00
PAY01373	ORD01842	Card	695331.56	2024-11-21 02:00:00
PAY01374	ORD01843	Card	4620.81	2024-08-23 00:00:00
PAY01375	ORD01845	Bank Transfer	43905.60	2025-01-01 19:00:00
PAY01376	ORD01846	Cash on Delivery	97853.36	2024-12-06 15:00:00
PAY01377	ORD01847	Mobile Money	700840.62	2024-12-17 13:00:00
PAY01378	ORD01848	Card	94945.56	2024-12-19 06:00:00
PAY01379	ORD01849	Mobile Money	16739.67	2024-12-10 13:00:00
PAY01380	ORD01850	Mobile Money	4731.52	2024-02-28 02:00:00
PAY01381	ORD01851	Mobile Money	1707225.31	2024-09-09 19:00:00
PAY01382	ORD01853	Mobile Money	2943847.83	2024-05-02 23:00:00
PAY01383	ORD01854	Cash on Delivery	43372.48	2023-11-19 08:00:00
PAY01384	ORD01856	Card	987015.13	2024-06-25 06:00:00
PAY01385	ORD01857	Mobile Money	127630.73	2024-08-14 09:00:00
PAY01386	ORD01858	Cash on Delivery	4876.47	2024-12-07 15:00:00
PAY01387	ORD01859	Card	185673.25	2024-06-09 14:00:00
PAY01388	ORD01860	Card	104826.28	2023-09-17 19:00:00
PAY01389	ORD01861	Card	\N	2024-12-06 20:00:00
PAY01390	ORD01862	Card	242330.60	2024-06-27 10:00:00
PAY01391	ORD01863	Bank Transfer	363996.06	2024-06-21 12:00:00
PAY01392	ORD01864	Bank Transfer	15152.82	2024-08-20 00:00:00
PAY01393	ORD01865	Cash on Delivery	630266.76	2024-06-20 17:00:00
PAY01394	ORD01866	Card	549230.53	2024-08-21 00:00:00
PAY01395	ORD01867	Cash on Delivery	6170.81	2024-05-10 07:00:00
PAY01396	ORD01868	Bank Transfer	6770.96	2024-07-12 11:00:00
PAY01397	ORD01870	Mobile Money	563919.29	2023-12-13 13:00:00
PAY01398	ORD01871	Bank Transfer	215711.20	2023-11-03 01:00:00
PAY01399	ORD01872	Mobile Money	7533.78	2024-04-06 14:00:00
PAY01400	ORD01873	Cash on Delivery	6230.11	2024-08-13 00:00:00
PAY01401	ORD01874	Cash on Delivery	24683.24	2024-10-21 14:00:00
PAY01402	ORD01875	Card	76433.95	2024-07-12 22:00:00
PAY01403	ORD01876	Cash on Delivery	24463.34	2024-06-19 07:00:00
PAY01404	ORD01879	Mobile Money	118653.08	2024-06-28 03:00:00
PAY01405	ORD01880	Mobile Money	220539.42	2024-09-16 00:00:00
PAY01406	ORD01881	Cash on Delivery	430288.80	2024-10-06 20:00:00
PAY01407	ORD01882	Cash on Delivery	402816.45	2024-11-30 02:00:00
PAY01408	ORD01885	Card	12706.74	2024-11-07 13:00:00
PAY01409	ORD01886	Bank Transfer	37320.95	2023-12-06 07:00:00
PAY01410	ORD01887	Mobile Money	21709.68	2024-02-03 13:00:00
PAY01411	ORD01888	Card	126473.94	2024-06-22 05:00:00
PAY01412	ORD01891	Mobile Money	\N	2023-08-08 02:00:00
PAY01413	ORD01892	Card	586047.25	2023-11-18 23:00:00
PAY01414	ORD01893	Card	100933.34	2024-12-10 02:00:00
PAY01415	ORD01898	Bank Transfer	1213753.37	2024-10-30 23:00:00
PAY01416	ORD01899	Card	705677.44	2024-10-28 06:00:00
PAY01417	ORD01900	Card	19741.12	2024-09-15 16:00:00
PAY01418	ORD01901	Cash on Delivery	48037.37	2024-01-12 00:00:00
PAY01419	ORD01902	Mobile Money	471590.12	2024-02-03 18:00:00
PAY01420	ORD01903	Cash on Delivery	1835205.35	2024-10-15 21:00:00
PAY01421	ORD01904	Bank Transfer	20698.80	2024-01-14 21:00:00
PAY01422	ORD01905	Card	69170.07	2024-02-04 09:00:00
PAY01423	ORD01906	Mobile Money	63091.21	2023-11-19 18:00:00
PAY01424	ORD01907	Mobile Money	78955.84	2024-12-27 00:00:00
PAY01425	ORD01908	Mobile Money	85470.14	2024-04-15 00:00:00
PAY01426	ORD01909	Card	986407.20	2024-10-24 19:00:00
PAY01427	ORD01910	Mobile Money	243681.27	2024-11-11 12:00:00
PAY01428	ORD01912	Card	15003.67	2024-11-20 01:00:00
PAY01429	ORD01913	Mobile Money	281964.48	2023-11-12 18:00:00
PAY01430	ORD01915	Card	889298.04	2024-07-02 14:00:00
PAY01431	ORD01916	Mobile Money	2019.05	2024-06-10 08:00:00
PAY01432	ORD01917	Cash on Delivery	72306.55	2024-12-18 00:00:00
PAY01433	ORD01918	Bank Transfer	358222.29	2024-02-06 00:00:00
PAY01434	ORD01920	Bank Transfer	470699.26	2024-07-04 21:00:00
PAY01435	ORD01921	Bank Transfer	\N	2024-06-06 23:00:00
PAY01436	ORD01922	Mobile Money	13912.80	2024-08-19 00:00:00
PAY01437	ORD01924	Card	1418267.19	2024-08-04 11:00:00
PAY01438	ORD01926	Card	53953.43	2023-09-24 15:00:00
PAY01439	ORD01927	Card	60582.65	2024-05-26 16:00:00
PAY01440	ORD01928	Mobile Money	266991.21	2024-07-13 03:00:00
PAY01441	ORD01930	Card	456035.22	2024-01-17 03:00:00
PAY01442	ORD01931	Mobile Money	795566.29	2024-10-09 22:00:00
PAY01443	ORD01933	Cash on Delivery	120268.52	2024-09-04 05:00:00
PAY01444	ORD01934	Card	424884.05	2024-12-14 02:00:00
PAY01445	ORD01935	Card	4696.28	2024-04-13 01:00:00
PAY01446	ORD01936	Bank Transfer	643395.88	2023-06-17 19:00:00
PAY01447	ORD01938	Cash on Delivery	1240191.46	2024-11-01 06:00:00
PAY01448	ORD01939	Mobile Money	1401938.78	2023-10-13 07:00:00
PAY01449	ORD01941	Bank Transfer	359579.20	2024-06-17 04:00:00
PAY01450	ORD01942	Bank Transfer	398397.28	2024-05-21 10:00:00
PAY01451	ORD01943	Bank Transfer	180749.37	2024-04-25 13:00:00
PAY01452	ORD01944	Mobile Money	1428725.36	2024-12-13 20:00:00
PAY01453	ORD01945	Card	25825.32	2024-01-28 04:00:00
PAY01454	ORD01946	Cash on Delivery	492031.74	2024-10-10 12:00:00
PAY01455	ORD01947	Bank Transfer	118084.60	2024-04-23 20:00:00
PAY01456	ORD01948	Card	173901.38	2024-06-20 15:00:00
PAY01457	ORD01949	Bank Transfer	48466.70	2024-08-30 06:00:00
PAY01458	ORD01950	Card	54215.60	2024-06-29 00:00:00
PAY01459	ORD01951	Card	10688.84	2024-01-22 15:00:00
PAY01460	ORD01953	Mobile Money	122712.27	2023-12-30 02:00:00
PAY01461	ORD01954	Bank Transfer	\N	2024-07-17 12:00:00
PAY01462	ORD01955	Cash on Delivery	31579.12	2024-11-26 19:00:00
PAY01463	ORD01956	Bank Transfer	127824.90	2024-06-14 03:00:00
PAY01464	ORD01959	Card	868327.05	2024-09-30 07:00:00
PAY01465	ORD01960	Bank Transfer	1372231.16	2024-04-15 07:00:00
PAY01466	ORD01961	Bank Transfer	259751.90	2024-12-07 18:00:00
PAY01467	ORD01962	Card	24920.44	2024-10-26 08:00:00
PAY01468	ORD01964	Cash on Delivery	1073842.93	2023-11-21 14:00:00
PAY01469	ORD01965	Card	140572.66	2023-10-05 05:00:00
PAY01470	ORD01966	Card	674226.50	2024-05-19 21:00:00
PAY01471	ORD01967	Mobile Money	28370.48	2024-01-07 07:00:00
PAY01472	ORD01969	Cash on Delivery	363859.64	2023-09-08 14:00:00
PAY01473	ORD01972	Card	257220.91	2024-07-04 01:00:00
PAY01474	ORD01973	Card	433699.07	2024-03-17 15:00:00
PAY01475	ORD01975	Card	487091.15	2024-05-23 19:00:00
PAY01476	ORD01976	Bank Transfer	1016135.30	2023-05-26 09:00:00
PAY01477	ORD01977	Bank Transfer	\N	2024-11-14 04:00:00
PAY01478	ORD01978	Card	515939.67	2023-07-31 07:00:00
PAY01479	ORD01979	Card	135777.09	2024-12-30 07:00:00
PAY01480	ORD01980	Card	156645.15	2024-10-16 03:00:00
PAY01481	ORD01981	Mobile Money	35280.59	2024-12-05 13:00:00
PAY01482	ORD01982	Bank Transfer	186774.13	2024-11-02 09:00:00
PAY01483	ORD01983	Card	179754.67	2024-01-25 14:00:00
PAY01484	ORD01985	Cash on Delivery	47930.68	2024-02-21 19:00:00
PAY01485	ORD01987	Mobile Money	82713.56	2024-02-14 20:00:00
PAY01486	ORD01988	Mobile Money	18690.33	2024-06-17 15:00:00
PAY01487	ORD01990	Cash on Delivery	1375465.84	2023-12-10 18:00:00
PAY01488	ORD01992	Card	18117.48	2024-09-24 17:00:00
PAY01489	ORD01993	Cash on Delivery	17515.94	2024-06-03 08:00:00
PAY01490	ORD01995	Card	51228.88	2023-11-21 22:00:00
PAY01491	ORD01997	Mobile Money	133191.00	2024-09-08 04:00:00
PAY01492	ORD01998	Cash on Delivery	957676.93	2024-08-15 05:00:00
PAY01493	ORD02000	Card	\N	2024-04-24 06:00:00
PAY01494	ORD02001	Cash on Delivery	1228137.40	2024-01-28 20:00:00
PAY01495	ORD02002	Bank Transfer	643395.88	2024-09-01 15:00:00
PAY01496	ORD02003	Bank Transfer	209097.61	2024-09-02 00:00:00
PAY01497	ORD02005	Card	1235650.44	2024-01-18 10:00:00
PAY01498	ORD02006	Mobile Money	164442.78	2023-09-01 01:00:00
PAY01499	ORD02007	Card	219422.34	2024-05-01 14:00:00
PAY01500	ORD02008	Cash on Delivery	\N	2024-09-01 01:00:00
PAY01501	ORD02009	Mobile Money	275127.81	2024-08-10 10:00:00
PAY01502	ORD02013	Card	991771.17	2024-05-27 22:00:00
PAY01503	ORD02015	Cash on Delivery	1124082.02	2024-04-30 12:00:00
PAY01504	ORD02016	Mobile Money	28180.48	2024-09-09 13:00:00
PAY01505	ORD02017	Mobile Money	242070.75	2024-09-19 11:00:00
PAY01506	ORD02018	Card	34967.80	2024-10-17 04:00:00
PAY01507	ORD02019	Bank Transfer	1720355.06	2024-02-03 06:00:00
PAY01508	ORD02021	Card	69996.63	2024-10-31 19:00:00
PAY01509	ORD02022	Bank Transfer	557154.99	2024-10-07 05:00:00
PAY01510	ORD02023	Card	2802.33	2024-08-20 06:00:00
PAY01511	ORD02024	Card	245496.97	2024-10-10 02:00:00
PAY01512	ORD02026	Card	3871.20	2023-03-15 00:00:00
PAY01513	ORD02028	Card	46035.40	2024-08-28 01:00:00
PAY01514	ORD02029	Mobile Money	3548.64	2024-11-24 00:00:00
PAY01515	ORD02030	Cash on Delivery	271616.18	2024-12-11 10:00:00
PAY01516	ORD02031	Cash on Delivery	2017488.79	2024-08-20 12:00:00
PAY01517	ORD02034	Mobile Money	58333.34	2024-07-17 08:00:00
PAY01518	ORD02035	Mobile Money	548636.31	2024-10-10 09:00:00
PAY01519	ORD02036	Cash on Delivery	45302.42	2024-11-16 16:00:00
PAY01520	ORD02038	Card	369351.72	2024-10-21 17:00:00
PAY01521	ORD02039	Card	191629.85	2024-08-26 20:00:00
PAY01522	ORD02040	Card	367940.95	2024-08-31 15:00:00
PAY01523	ORD02041	Bank Transfer	867436.59	2024-11-04 17:00:00
PAY01524	ORD02043	Cash on Delivery	212476.89	2024-02-02 06:00:00
PAY01525	ORD02044	Cash on Delivery	82804.12	2024-11-30 03:00:00
PAY01526	ORD02045	Mobile Money	281964.48	2024-07-28 04:00:00
PAY01527	ORD02046	Bank Transfer	1260871.90	2024-07-20 15:00:00
PAY01528	ORD02047	Cash on Delivery	1018541.18	2024-03-09 08:00:00
PAY01529	ORD02048	Cash on Delivery	150697.55	2023-10-23 01:00:00
PAY01530	ORD02050	Mobile Money	25910.95	2023-05-24 01:00:00
PAY01531	ORD02051	Bank Transfer	407731.20	2024-01-22 20:00:00
PAY01532	ORD02052	Mobile Money	\N	2024-07-10 01:00:00
PAY01533	ORD02054	Mobile Money	870698.52	2024-01-14 14:00:00
PAY01534	ORD02055	Bank Transfer	25484.84	2024-03-27 14:00:00
PAY01535	ORD02056	Card	40877.16	2023-04-25 05:00:00
PAY01536	ORD02057	Card	\N	2024-06-28 19:00:00
PAY01537	ORD02058	Card	1180810.69	2024-12-09 07:00:00
PAY01538	ORD02059	Mobile Money	29665.75	2024-12-13 20:00:00
PAY01539	ORD02061	Card	459768.00	2024-06-19 09:00:00
PAY01540	ORD02062	Card	1517372.93	2024-03-23 05:00:00
PAY01541	ORD02063	Cash on Delivery	139211.89	2024-12-03 04:00:00
PAY01542	ORD02064	Mobile Money	83437.72	2024-09-15 12:00:00
PAY01543	ORD02065	Cash on Delivery	33029.61	2024-12-09 15:00:00
PAY01544	ORD02066	Bank Transfer	140129.81	2024-09-12 03:00:00
PAY01545	ORD02068	Mobile Money	\N	2024-12-29 09:00:00
PAY01546	ORD02069	Mobile Money	47233.84	2024-08-22 16:00:00
PAY01547	ORD02070	Card	51993.13	2024-08-10 00:00:00
PAY01548	ORD02071	Bank Transfer	\N	2024-07-18 21:00:00
PAY01549	ORD02072	Cash on Delivery	1057590.73	2024-12-14 12:00:00
PAY01550	ORD02073	Bank Transfer	770041.63	2024-12-02 23:00:00
PAY01551	ORD02075	Card	\N	2024-10-26 04:00:00
PAY01552	ORD02076	Cash on Delivery	1330904.90	2024-04-15 19:00:00
PAY01553	ORD02079	Mobile Money	857314.46	2024-07-31 07:00:00
PAY01554	ORD02080	Mobile Money	736882.44	2024-12-23 16:00:00
PAY01555	ORD02081	Bank Transfer	184401.52	2023-11-26 13:00:00
PAY01556	ORD02082	Bank Transfer	195886.35	2023-11-21 23:00:00
PAY01557	ORD02083	Bank Transfer	80339.85	2024-11-23 18:00:00
PAY01558	ORD02084	Cash on Delivery	207992.10	2024-07-06 18:00:00
PAY01559	ORD02085	Card	54388.95	2024-03-11 00:00:00
PAY01560	ORD02086	Mobile Money	678632.38	2024-08-04 02:00:00
PAY01561	ORD02087	Card	60421.06	2024-09-14 16:00:00
PAY01562	ORD02088	Cash on Delivery	111904.54	2024-12-15 14:00:00
PAY01563	ORD02089	Mobile Money	86352.92	2024-04-13 15:00:00
PAY01564	ORD02090	Bank Transfer	5261.71	2024-11-30 14:00:00
PAY01565	ORD02091	Card	56642.17	2024-04-21 13:00:00
PAY01566	ORD02092	Bank Transfer	17515.94	2024-09-20 21:00:00
PAY01567	ORD02093	Mobile Money	169273.30	2024-12-31 11:00:00
PAY01568	ORD02094	Mobile Money	342064.22	2024-12-14 03:00:00
PAY01569	ORD02096	Bank Transfer	45926.31	2024-11-09 18:00:00
PAY01570	ORD02097	Bank Transfer	\N	2024-12-27 17:00:00
PAY01571	ORD02098	Mobile Money	48285.65	2024-08-26 08:00:00
PAY01572	ORD02099	Mobile Money	11209.32	2024-09-26 08:00:00
PAY01573	ORD02100	Mobile Money	174074.54	2024-09-15 21:00:00
PAY01574	ORD02101	Card	\N	2023-12-26 00:00:00
PAY01575	ORD02105	Cash on Delivery	770562.66	2024-10-18 19:00:00
PAY01576	ORD02106	Cash on Delivery	15315.45	2024-02-08 23:00:00
PAY01577	ORD02107	Card	796626.60	2024-04-23 10:00:00
PAY01578	ORD02108	Cash on Delivery	65858.60	2024-11-11 16:00:00
PAY01579	ORD02112	Card	661180.78	2024-06-21 20:00:00
PAY01580	ORD02113	Card	62292.43	2024-05-09 22:00:00
PAY01581	ORD02115	Cash on Delivery	24288.60	2024-04-13 15:00:00
PAY01582	ORD02117	Mobile Money	274063.06	2024-08-16 03:00:00
PAY01583	ORD02118	Mobile Money	204806.12	2024-10-22 22:00:00
PAY01584	ORD02119	Mobile Money	345924.48	2024-11-10 13:00:00
PAY01585	ORD02120	Card	580632.46	2024-09-24 15:00:00
PAY01586	ORD02121	Card	\N	2024-07-25 20:00:00
PAY01587	ORD02122	Card	47669.61	2024-12-12 14:00:00
PAY01588	ORD02123	Mobile Money	711191.81	2024-10-10 16:00:00
PAY01589	ORD02124	Bank Transfer	246601.80	2024-12-06 08:00:00
PAY01590	ORD02125	Mobile Money	32407.34	2024-11-23 16:00:00
PAY01591	ORD02126	Cash on Delivery	35044.30	2024-11-24 10:00:00
PAY01592	ORD02127	Mobile Money	575752.52	2024-12-12 13:00:00
PAY01593	ORD02128	Card	446216.60	2023-11-02 03:00:00
PAY01594	ORD02131	Mobile Money	\N	2024-01-30 15:00:00
PAY01595	ORD02132	Bank Transfer	137481.28	2023-11-16 19:00:00
PAY01596	ORD02133	Cash on Delivery	19738.96	2024-09-21 02:00:00
PAY01597	ORD02136	Card	1633.04	2024-11-15 22:00:00
PAY01598	ORD02137	Card	14077.14	2024-12-28 11:00:00
PAY01599	ORD02138	Card	52507.89	2024-10-25 00:00:00
PAY01600	ORD02139	Bank Transfer	\N	2024-11-24 19:00:00
PAY01601	ORD02140	Mobile Money	27088.10	2024-12-14 21:00:00
PAY01602	ORD02141	Bank Transfer	85978.02	2023-09-03 00:00:00
PAY01603	ORD02142	Bank Transfer	402619.27	2023-10-10 19:00:00
PAY01604	ORD02143	Card	31766.85	2024-09-22 22:00:00
PAY01605	ORD02144	Card	616971.17	2024-01-27 20:00:00
PAY01606	ORD02145	Bank Transfer	177974.85	2024-03-01 14:00:00
PAY01607	ORD02146	Mobile Money	182969.82	2023-12-31 18:00:00
PAY01608	ORD02147	Cash on Delivery	47233.84	2023-12-10 19:00:00
PAY01609	ORD02148	Bank Transfer	13475.96	2024-09-30 08:00:00
PAY01610	ORD02149	Mobile Money	562883.38	2023-12-07 11:00:00
PAY01611	ORD02150	Bank Transfer	88185.56	2024-04-18 09:00:00
PAY01612	ORD02153	Cash on Delivery	29665.75	2024-01-15 12:00:00
PAY01613	ORD02154	Card	9800.57	2023-12-31 08:00:00
PAY01614	ORD02156	Card	\N	2024-06-20 12:00:00
PAY01615	ORD02158	Bank Transfer	2195798.60	2024-10-12 11:00:00
PAY01616	ORD02159	Card	23616.92	2024-04-16 23:00:00
PAY01617	ORD02160	Mobile Money	6970.88	2024-12-20 19:00:00
PAY01618	ORD02162	Card	63753.88	2024-10-28 16:00:00
PAY01619	ORD02163	Cash on Delivery	14965.75	2024-10-28 04:00:00
PAY01620	ORD02166	Card	327229.73	2023-11-25 02:00:00
PAY01621	ORD02167	Card	156709.08	2023-09-25 23:00:00
PAY01622	ORD02168	Card	22657.06	2024-02-11 13:00:00
PAY01623	ORD02170	Card	1769642.81	2024-12-10 10:00:00
PAY01624	ORD02171	Card	1148191.33	2023-11-29 22:00:00
PAY01625	ORD02172	Bank Transfer	409790.96	2024-07-04 03:00:00
PAY01626	ORD02173	Mobile Money	2511.26	2024-05-11 02:00:00
PAY01627	ORD02175	Cash on Delivery	289033.42	2024-11-15 21:00:00
PAY01628	ORD02176	Mobile Money	121527.21	2024-10-25 08:00:00
PAY01629	ORD02177	Card	506005.84	2023-11-14 13:00:00
PAY01630	ORD02179	Bank Transfer	50265.21	2024-06-09 18:00:00
PAY01631	ORD02180	Cash on Delivery	2253493.62	2024-10-05 01:00:00
PAY01632	ORD02181	Bank Transfer	2195842.84	2024-12-07 16:00:00
PAY01633	ORD02182	Card	124125.36	2024-12-19 15:00:00
PAY01634	ORD02183	Cash on Delivery	370104.20	2024-11-25 16:00:00
PAY01635	ORD02184	Mobile Money	\N	2024-11-22 17:00:00
PAY01636	ORD02185	Card	86352.92	2024-11-17 16:00:00
PAY01637	ORD02186	Card	87588.60	2024-10-26 10:00:00
PAY01638	ORD02187	Mobile Money	1030921.60	2024-11-19 00:00:00
PAY01639	ORD02189	Cash on Delivery	91572.30	2024-11-08 00:00:00
PAY01640	ORD02190	Card	\N	2024-04-17 11:00:00
PAY01641	ORD02191	Bank Transfer	133191.00	2024-07-25 04:00:00
PAY01642	ORD02192	Mobile Money	1322728.85	2024-12-28 16:00:00
PAY01643	ORD02194	Cash on Delivery	109628.52	2024-04-23 03:00:00
PAY01644	ORD02196	Mobile Money	8968.44	2024-04-12 01:00:00
PAY01645	ORD02198	Card	49985.97	2024-02-05 06:00:00
PAY01646	ORD02201	Cash on Delivery	44052.51	2024-11-21 20:00:00
PAY01647	ORD02202	Card	582657.42	2024-09-13 04:00:00
PAY01648	ORD02203	Card	13938.18	2024-12-28 20:00:00
PAY01649	ORD02204	Card	66052.59	2024-05-09 06:00:00
PAY01650	ORD02205	Bank Transfer	13912.80	2024-07-24 00:00:00
PAY01651	ORD02206	Cash on Delivery	5971.28	2024-08-25 00:00:00
PAY01652	ORD02207	Card	20220.48	2024-03-01 16:00:00
PAY01653	ORD02208	Card	12989.38	2024-09-03 05:00:00
PAY01654	ORD02210	Bank Transfer	116663.65	2024-07-08 02:00:00
PAY01655	ORD02211	Bank Transfer	926737.83	2024-10-12 18:00:00
PAY01656	ORD02213	Mobile Money	458267.45	2024-07-16 00:00:00
PAY01657	ORD02215	Card	189651.37	2024-09-06 02:00:00
PAY01658	ORD02216	Cash on Delivery	181209.68	2024-12-21 18:00:00
PAY01659	ORD02219	Bank Transfer	332973.30	2024-10-30 15:00:00
PAY01660	ORD02220	Card	120790.15	2024-10-30 13:00:00
PAY01661	ORD02221	Bank Transfer	45054.25	2024-08-18 00:00:00
PAY01662	ORD02222	Card	515460.80	2024-08-08 17:00:00
PAY01663	ORD02223	Cash on Delivery	35007.70	2023-10-03 03:00:00
PAY01664	ORD02224	Cash on Delivery	48314.36	2023-10-11 05:00:00
PAY01665	ORD02225	Card	923433.55	2024-04-16 05:00:00
PAY01666	ORD02227	Bank Transfer	564648.56	2023-09-29 10:00:00
PAY01667	ORD02228	Cash on Delivery	442560.44	2023-02-21 07:00:00
PAY01668	ORD02229	Card	72814.92	2023-06-10 14:00:00
PAY01669	ORD02232	Mobile Money	61391.40	2024-07-15 06:00:00
PAY01670	ORD02233	Bank Transfer	1110726.95	2024-10-04 10:00:00
PAY01671	ORD02234	Mobile Money	166785.29	2023-10-12 17:00:00
PAY01672	ORD02235	Cash on Delivery	370314.78	2024-04-23 22:00:00
PAY01673	ORD02237	Card	962914.49	2024-01-29 16:00:00
PAY01674	ORD02238	Card	251980.85	2023-10-30 21:00:00
PAY01675	ORD02239	Card	1230207.90	2024-03-20 00:00:00
PAY01676	ORD02240	Mobile Money	27621.24	2024-06-14 14:00:00
PAY01677	ORD02242	Card	167564.56	2024-05-22 16:00:00
PAY01678	ORD02243	Mobile Money	780584.55	2024-04-13 16:00:00
PAY01679	ORD02244	Mobile Money	\N	2024-08-04 17:00:00
PAY01680	ORD02245	Bank Transfer	172705.84	2024-09-23 05:00:00
PAY01681	ORD02247	Cash on Delivery	518985.79	2023-08-14 13:00:00
PAY01682	ORD02248	Mobile Money	107668.84	2023-10-24 13:00:00
PAY01683	ORD02249	Card	\N	2024-12-17 06:00:00
PAY01684	ORD02250	Card	417590.00	2024-08-29 01:00:00
PAY01685	ORD02251	Card	1405617.22	2024-07-29 02:00:00
PAY01686	ORD02253	Card	281964.48	2024-11-20 13:00:00
PAY01687	ORD02254	Bank Transfer	84659.35	2024-11-27 01:00:00
PAY01688	ORD02255	Bank Transfer	20510.26	2024-06-17 11:00:00
PAY01689	ORD02256	Card	\N	2024-07-18 02:00:00
PAY01690	ORD02257	Card	41020.52	2024-05-26 05:00:00
PAY01691	ORD02258	Card	135100.29	2024-11-19 22:00:00
PAY01692	ORD02259	Mobile Money	464020.29	2024-12-10 15:00:00
PAY01693	ORD02260	Card	142379.88	2024-12-31 21:00:00
PAY01694	ORD02261	Card	105159.48	2024-06-14 09:00:00
PAY01695	ORD02263	Cash on Delivery	98694.80	2024-11-28 06:00:00
PAY01696	ORD02265	Cash on Delivery	876706.12	2023-11-08 16:00:00
PAY01697	ORD02266	Cash on Delivery	9866.86	2024-03-14 22:00:00
PAY01698	ORD02267	Cash on Delivery	61685.11	2024-04-18 11:00:00
PAY01699	ORD02268	Bank Transfer	17265.90	2024-05-23 19:00:00
PAY01700	ORD02269	Cash on Delivery	54814.26	2024-11-02 03:00:00
PAY01701	ORD02270	Mobile Money	11129.13	2023-11-17 16:00:00
PAY01702	ORD02272	Bank Transfer	5399.76	2024-10-18 16:00:00
PAY01703	ORD02273	Cash on Delivery	108471.43	2024-10-31 20:00:00
PAY01704	ORD02274	Card	118094.97	2024-10-16 20:00:00
PAY01705	ORD02275	Card	89272.26	2024-10-10 23:00:00
PAY01706	ORD02276	Card	44745.78	2024-06-04 20:00:00
PAY01707	ORD02277	Cash on Delivery	202825.74	2024-03-25 20:00:00
PAY01708	ORD02278	Mobile Money	32284.63	2024-10-20 06:00:00
PAY01709	ORD02279	Cash on Delivery	422203.94	2024-08-23 04:00:00
PAY01710	ORD02280	Card	\N	2024-04-13 06:00:00
PAY01711	ORD02281	Card	\N	2024-10-26 06:00:00
PAY01712	ORD02283	Bank Transfer	711932.45	2024-02-06 05:00:00
PAY01713	ORD02284	Bank Transfer	8406.99	2024-12-17 14:00:00
PAY01714	ORD02285	Card	77977.95	2024-10-30 21:00:00
PAY01715	ORD02286	Card	24750.33	2024-11-24 12:00:00
PAY01716	ORD02287	Card	\N	2024-12-16 04:00:00
PAY01717	ORD02288	Bank Transfer	646542.53	2024-11-02 01:00:00
PAY01718	ORD02290	Card	175369.76	2024-11-16 03:00:00
PAY01719	ORD02291	Bank Transfer	607290.96	2024-10-10 19:00:00
PAY01720	ORD02293	Card	180084.64	2024-09-01 15:00:00
PAY01721	ORD02294	Mobile Money	886785.03	2024-06-02 19:00:00
PAY01722	ORD02295	Mobile Money	1169138.42	2024-06-15 12:00:00
PAY01723	ORD02296	Card	1597548.44	2024-11-10 11:00:00
PAY01724	ORD02297	Card	173134.33	2024-10-02 04:00:00
PAY01725	ORD02298	Card	30854.05	2024-12-27 12:00:00
PAY01726	ORD02299	Card	158270.04	2024-09-27 06:00:00
PAY01727	ORD02300	Card	26191.00	2024-11-27 12:00:00
PAY01728	ORD02301	Card	536510.96	2024-09-22 00:00:00
PAY01729	ORD02302	Mobile Money	58000.93	2024-05-15 18:00:00
PAY01730	ORD02304	Mobile Money	9871.34	2024-04-10 23:00:00
PAY01731	ORD02305	Cash on Delivery	2395014.01	2024-07-02 19:00:00
PAY01732	ORD02307	Bank Transfer	1030921.60	2024-10-12 22:00:00
PAY01733	ORD02308	Bank Transfer	57806.00	2024-11-29 19:00:00
PAY01734	ORD02309	Mobile Money	2989.48	2024-05-01 04:00:00
PAY01735	ORD02310	Bank Transfer	11608.58	2024-03-15 06:00:00
PAY01736	ORD02311	Bank Transfer	1191248.26	2024-11-08 22:00:00
PAY01737	ORD02314	Mobile Money	325573.42	2024-10-29 09:00:00
PAY01738	ORD02315	Mobile Money	506890.19	2024-11-23 07:00:00
PAY01739	ORD02316	Cash on Delivery	229390.82	2024-12-20 21:00:00
PAY01740	ORD02317	Cash on Delivery	280938.65	2024-08-28 05:00:00
PAY01741	ORD02318	Bank Transfer	57806.00	2024-12-08 14:00:00
PAY01742	ORD02319	Card	185321.91	2024-12-27 19:00:00
PAY01743	ORD02320	Card	36567.08	2024-12-03 08:00:00
PAY01744	ORD02321	Cash on Delivery	194836.46	2024-12-29 08:00:00
PAY01745	ORD02322	Bank Transfer	1147155.41	2024-12-25 13:00:00
PAY01746	ORD02323	Bank Transfer	572061.17	2024-12-23 01:00:00
PAY01747	ORD02324	Card	179452.02	2023-10-16 00:00:00
PAY01748	ORD02326	Card	66958.68	2024-04-13 20:00:00
PAY01749	ORD02328	Card	316366.34	2024-05-30 18:00:00
PAY01750	ORD02329	Bank Transfer	538786.92	2023-04-17 01:00:00
PAY01751	ORD02330	Mobile Money	86986.03	2024-10-14 03:00:00
PAY01752	ORD02331	Cash on Delivery	40185.68	2024-10-04 09:00:00
PAY01753	ORD02333	Bank Transfer	35221.95	2024-04-01 17:00:00
PAY01754	ORD02334	Card	297926.52	2024-08-09 15:00:00
PAY01755	ORD02336	Card	166648.45	2024-02-25 20:00:00
PAY01756	ORD02338	Card	64122.63	2024-07-27 04:00:00
PAY01757	ORD02339	Bank Transfer	147420.82	2024-11-29 15:00:00
PAY01758	ORD02340	Cash on Delivery	105588.96	2024-04-29 20:00:00
PAY01759	ORD02341	Mobile Money	1196417.96	2024-10-03 05:00:00
PAY01760	ORD02342	Cash on Delivery	245349.52	2024-12-02 10:00:00
PAY01761	ORD02343	Card	13642.52	2024-04-20 01:00:00
PAY01762	ORD02345	Card	363459.87	2024-09-11 19:00:00
PAY01763	ORD02346	Mobile Money	1086701.68	2024-10-22 08:00:00
PAY01764	ORD02347	Card	29691.10	2024-12-23 19:00:00
PAY01765	ORD02348	Cash on Delivery	\N	2024-09-29 22:00:00
PAY01766	ORD02349	Cash on Delivery	117531.81	2024-09-20 21:00:00
PAY01767	ORD02350	Mobile Money	176210.04	2024-04-28 11:00:00
PAY01768	ORD02351	Cash on Delivery	187599.69	2024-04-17 19:00:00
PAY01769	ORD02352	Card	166393.68	2023-04-11 09:00:00
PAY01770	ORD02355	Card	14461.31	2024-03-04 13:00:00
PAY01771	ORD02356	Bank Transfer	109628.52	2023-08-14 11:00:00
PAY01772	ORD02357	Cash on Delivery	67745.32	2024-05-07 18:00:00
PAY01773	ORD02358	Mobile Money	52910.92	2023-12-06 05:00:00
PAY01774	ORD02360	Card	\N	2024-05-12 17:00:00
PAY01775	ORD02361	Mobile Money	96291.59	2024-01-05 15:00:00
PAY01776	ORD02362	Bank Transfer	38151.06	2024-11-14 16:00:00
PAY01777	ORD02363	Bank Transfer	395756.90	2023-10-17 03:00:00
PAY01778	ORD02364	Card	1461335.07	2023-12-12 08:00:00
PAY01779	ORD02365	Bank Transfer	602615.41	2023-09-22 01:00:00
PAY01780	ORD02366	Card	567895.40	2024-10-25 00:00:00
PAY01781	ORD02367	Mobile Money	373173.62	2023-03-11 04:00:00
PAY01782	ORD02370	Cash on Delivery	126037.11	2023-05-31 06:00:00
PAY01783	ORD02371	Mobile Money	23357.67	2023-07-05 09:00:00
PAY01784	ORD02372	Card	80530.64	2023-11-09 16:00:00
PAY01785	ORD02374	Cash on Delivery	962.48	2024-06-25 16:00:00
PAY01786	ORD02376	Cash on Delivery	55939.01	2024-08-30 01:00:00
PAY01787	ORD02378	Bank Transfer	11275.57	2024-09-15 16:00:00
PAY01788	ORD02379	Mobile Money	159247.16	2024-09-26 02:00:00
PAY01789	ORD02380	Card	631738.02	2024-12-01 10:00:00
PAY01790	ORD02381	Card	8224.90	2024-10-05 14:00:00
PAY01791	ORD02382	Card	111972.04	2024-10-05 11:00:00
PAY01792	ORD02383	Cash on Delivery	1116444.00	2024-12-03 10:00:00
PAY01793	ORD02384	Cash on Delivery	10094.25	2024-11-27 14:00:00
PAY01794	ORD02385	Cash on Delivery	1019787.06	2024-11-25 08:00:00
PAY01795	ORD02386	Cash on Delivery	\N	2024-12-21 18:00:00
PAY01796	ORD02388	Mobile Money	718474.40	2024-09-21 10:00:00
PAY01797	ORD02389	Card	468599.00	2024-09-07 00:00:00
PAY01798	ORD02390	Bank Transfer	15172.98	2024-09-01 15:00:00
PAY01799	ORD02391	Card	138284.58	2024-10-28 20:00:00
PAY01800	ORD02393	Cash on Delivery	322328.61	2024-11-23 06:00:00
PAY01801	ORD02394	Cash on Delivery	86940.02	2024-11-25 17:00:00
PAY01802	ORD02395	Mobile Money	2457784.65	2024-07-29 02:00:00
PAY01803	ORD02397	Card	\N	2024-12-01 05:00:00
PAY01804	ORD02398	Mobile Money	1162569.20	2024-12-31 18:00:00
PAY01805	ORD02399	Cash on Delivery	70846.58	2024-11-04 10:00:00
PAY01806	ORD02400	Card	322428.84	2024-12-31 17:00:00
PAY01807	ORD02401	Bank Transfer	965244.47	2024-12-15 09:00:00
PAY01808	ORD02402	Mobile Money	\N	2024-07-04 21:00:00
PAY01809	ORD02403	Cash on Delivery	287162.35	2023-12-21 05:00:00
PAY01810	ORD02405	Cash on Delivery	73459.05	2024-09-28 04:00:00
PAY01811	ORD02406	Mobile Money	465732.88	2024-05-13 20:00:00
PAY01812	ORD02408	Card	140423.37	2024-12-24 21:00:00
PAY01813	ORD02409	Bank Transfer	106282.78	2024-09-17 00:00:00
PAY01814	ORD02413	Cash on Delivery	124795.26	2024-11-16 04:00:00
PAY01815	ORD02414	Card	\N	2024-10-17 16:00:00
PAY01816	ORD02415	Card	359945.69	2024-08-19 18:00:00
PAY01817	ORD02418	Mobile Money	4792.40	2024-09-16 00:00:00
PAY01818	ORD02419	Mobile Money	16693.05	2024-01-20 10:00:00
PAY01819	ORD02420	Cash on Delivery	602012.32	2024-11-03 01:00:00
PAY01820	ORD02422	Cash on Delivery	20728.76	2024-12-24 15:00:00
PAY01821	ORD02423	Card	2690559.32	2024-07-27 23:00:00
PAY01822	ORD02424	Cash on Delivery	80490.90	2024-09-21 12:00:00
PAY01823	ORD02425	Card	27425.31	2024-08-16 20:00:00
PAY01824	ORD02426	Card	643395.88	2024-08-20 20:00:00
PAY01825	ORD02427	Bank Transfer	\N	2024-10-22 09:00:00
PAY01826	ORD02429	Card	86080.60	2024-10-14 11:00:00
PAY01827	ORD02430	Card	59216.26	2024-06-25 11:00:00
PAY01828	ORD02431	Cash on Delivery	164442.78	2023-09-29 00:00:00
PAY01829	ORD02433	Card	124099.07	2024-06-23 10:00:00
PAY01830	ORD02434	Bank Transfer	513753.00	2024-08-18 09:00:00
PAY01831	ORD02437	Card	54574.89	2023-12-30 00:00:00
PAY01832	ORD02439	Cash on Delivery	15152.82	2023-04-16 21:00:00
PAY01833	ORD02440	Card	441311.10	2024-12-25 09:00:00
PAY01834	ORD02441	Card	567444.59	2024-11-05 09:00:00
PAY01835	ORD02443	Mobile Money	2887.44	2024-12-28 22:00:00
PAY01836	ORD02444	Mobile Money	51056.48	2024-11-05 03:00:00
PAY01837	ORD02445	Bank Transfer	2365.76	2024-11-09 00:00:00
PAY01838	ORD02446	Cash on Delivery	24556.56	2024-10-26 10:00:00
PAY01839	ORD02447	Mobile Money	180785.23	2024-12-28 12:00:00
PAY01840	ORD02449	Bank Transfer	14402.86	2024-12-22 13:00:00
PAY01841	ORD02450	Mobile Money	678774.80	2024-12-04 00:00:00
PAY01842	ORD02451	Card	166842.38	2024-11-12 07:00:00
PAY01843	ORD02453	Cash on Delivery	492503.63	2024-11-20 20:00:00
PAY01844	ORD02454	Mobile Money	16768.75	2024-09-03 11:00:00
PAY01845	ORD02456	Cash on Delivery	1611658.56	2024-09-21 19:00:00
PAY01846	ORD02458	Card	793406.76	2023-12-10 08:00:00
PAY01847	ORD02460	Card	157895.28	2024-07-08 20:00:00
PAY01848	ORD02461	Bank Transfer	23275.64	2024-11-25 09:00:00
PAY01849	ORD02462	Cash on Delivery	177033.40	2024-07-23 21:00:00
PAY01850	ORD02463	Bank Transfer	267405.41	2024-10-21 19:00:00
PAY01851	ORD02464	Mobile Money	42851.74	2024-07-21 00:00:00
PAY01852	ORD02465	Mobile Money	1456956.16	2024-08-01 16:00:00
PAY01853	ORD02466	Card	76579.25	2024-10-18 17:00:00
PAY01854	ORD02469	Card	128378.51	2024-12-23 14:00:00
PAY01855	ORD02470	Mobile Money	3538.98	2024-09-13 23:00:00
PAY01856	ORD02471	Card	32317.65	2024-09-18 23:00:00
PAY01857	ORD02472	Card	323877.39	2024-11-04 05:00:00
PAY01858	ORD02473	Card	253301.20	2024-12-02 08:00:00
PAY01859	ORD02475	Card	11018.01	2024-12-05 17:00:00
PAY01860	ORD02476	Card	513753.00	2023-11-16 14:00:00
PAY01861	ORD02477	Card	50986.52	2024-12-25 18:00:00
PAY01862	ORD02478	Card	127701.09	2024-09-28 11:00:00
PAY01863	ORD02479	Card	94456.29	2024-01-20 20:00:00
PAY01864	ORD02483	Mobile Money	81994.48	2024-02-26 05:00:00
PAY01865	ORD02484	Mobile Money	\N	2024-12-26 18:00:00
PAY01866	ORD02485	Bank Transfer	190414.55	2024-10-04 19:00:00
PAY01867	ORD02487	Bank Transfer	201079.90	2024-11-25 19:00:00
PAY01868	ORD02488	Card	7571.15	2024-12-29 20:00:00
PAY01869	ORD02489	Card	245132.44	2023-09-28 02:00:00
PAY01870	ORD02492	Mobile Money	611372.36	2024-10-23 08:00:00
PAY01871	ORD02493	Mobile Money	34344.46	2024-11-13 06:00:00
PAY01872	ORD02494	Bank Transfer	286186.93	2024-07-03 10:00:00
PAY01873	ORD02495	Cash on Delivery	21115.71	2024-08-21 15:00:00
PAY01874	ORD02499	Card	1398698.82	2024-04-18 10:00:00
PAY01875	ORD02502	Card	27810.90	2024-08-10 09:00:00
PAY01876	ORD02504	Mobile Money	965078.43	2024-12-14 17:00:00
PAY01877	ORD02507	Cash on Delivery	82134.60	2024-12-29 02:00:00
PAY01878	ORD02508	Cash on Delivery	44547.39	2024-04-06 11:00:00
PAY01879	ORD02509	Mobile Money	148168.66	2023-09-25 01:00:00
PAY01880	ORD02510	Card	337634.60	2024-07-19 01:00:00
PAY01881	ORD02512	Card	55613.62	2024-08-12 11:00:00
PAY01882	ORD02514	Bank Transfer	257919.31	2024-12-01 11:00:00
PAY01883	ORD02515	Cash on Delivery	33482.97	2024-08-19 05:00:00
PAY01884	ORD02518	Cash on Delivery	46511.08	2024-06-29 07:00:00
PAY01885	ORD02520	Card	14461.31	2023-07-18 00:00:00
PAY01886	ORD02522	Bank Transfer	38612.32	2024-04-06 04:00:00
PAY01887	ORD02524	Cash on Delivery	20703.44	2024-03-07 15:00:00
PAY01888	ORD02525	Cash on Delivery	11779.00	2023-10-05 20:00:00
PAY01889	ORD02526	Bank Transfer	7571.15	2024-04-15 02:00:00
PAY01890	ORD02527	Mobile Money	110269.71	2023-11-30 11:00:00
PAY01891	ORD02528	Mobile Money	\N	2024-10-22 22:00:00
PAY01892	ORD02529	Cash on Delivery	165613.95	2023-07-06 20:00:00
PAY01893	ORD02532	Cash on Delivery	201713.20	2023-08-13 13:00:00
PAY01894	ORD02536	Cash on Delivery	40996.15	2023-12-18 21:00:00
PAY01895	ORD02539	Mobile Money	75063.14	2023-09-03 19:00:00
PAY01896	ORD02540	Card	\N	2024-02-16 02:00:00
PAY01897	ORD02542	Bank Transfer	252370.13	2024-02-09 22:00:00
PAY01898	ORD02544	Mobile Money	133677.94	2024-06-19 01:00:00
PAY01899	ORD02545	Card	140361.00	2024-06-22 08:00:00
PAY01900	ORD02546	Card	38469.79	2024-08-13 03:00:00
PAY01901	ORD02547	Bank Transfer	563928.96	2024-09-26 06:00:00
PAY01902	ORD02548	Bank Transfer	112214.93	2024-06-12 18:00:00
PAY01903	ORD02549	Card	1810580.04	2024-10-06 05:00:00
PAY01904	ORD02550	Bank Transfer	199058.95	2024-09-05 03:00:00
PAY01905	ORD02551	Card	1053964.00	2024-04-02 21:00:00
PAY01906	ORD02552	Mobile Money	18283.54	2024-08-06 14:00:00
PAY01907	ORD02554	Mobile Money	38310.15	2024-04-15 19:00:00
PAY01908	ORD02555	Mobile Money	9270.30	2024-04-18 02:00:00
PAY01909	ORD02556	Mobile Money	251501.84	2024-06-30 19:00:00
PAY01910	ORD02557	Mobile Money	\N	2024-05-04 08:00:00
PAY01911	ORD02558	Card	351651.77	2024-04-15 08:00:00
PAY01912	ORD02559	Card	\N	2024-10-30 12:00:00
PAY01913	ORD02560	Mobile Money	337113.25	2024-11-24 12:00:00
PAY01914	ORD02561	Card	160055.92	2024-01-08 15:00:00
PAY01915	ORD02562	Bank Transfer	207023.97	2023-12-23 03:00:00
PAY01916	ORD02564	Bank Transfer	276649.37	2024-06-29 00:00:00
PAY01917	ORD02567	Card	198153.24	2024-07-17 06:00:00
PAY01918	ORD02568	Bank Transfer	71484.11	2024-06-03 23:00:00
PAY01919	ORD02569	Card	125318.47	2024-11-29 21:00:00
PAY01920	ORD02571	Mobile Money	131993.61	2024-10-24 00:00:00
PAY01921	ORD02572	Card	17641.20	2024-12-06 22:00:00
PAY01922	ORD02573	Mobile Money	353048.88	2024-11-22 17:00:00
PAY01923	ORD02575	Card	108888.85	2025-01-01 09:00:00
PAY01924	ORD02576	Card	252324.34	2024-01-29 08:00:00
PAY01925	ORD02578	Cash on Delivery	341616.01	2024-10-24 03:00:00
PAY01926	ORD02579	Cash on Delivery	577031.11	2024-07-18 16:00:00
PAY01927	ORD02580	Cash on Delivery	712905.14	2023-07-05 15:00:00
PAY01928	ORD02581	Card	32929.20	2023-12-03 08:00:00
PAY01929	ORD02583	Mobile Money	2087573.62	2024-09-25 16:00:00
PAY01930	ORD02584	Card	87684.88	2024-07-19 18:00:00
PAY01931	ORD02586	Cash on Delivery	342501.25	2024-10-07 07:00:00
PAY01932	ORD02587	Cash on Delivery	219122.04	2024-11-27 02:00:00
PAY01933	ORD02588	Mobile Money	127701.09	2024-11-10 13:00:00
PAY01934	ORD02589	Card	198852.85	2024-11-15 03:00:00
PAY01935	ORD02590	Card	70928.68	2024-07-28 06:00:00
PAY01936	ORD02592	Card	130707.25	2024-05-06 13:00:00
PAY01937	ORD02593	Cash on Delivery	101814.33	2024-10-16 10:00:00
PAY01938	ORD02595	Bank Transfer	804244.85	2024-08-01 23:00:00
PAY01939	ORD02596	Card	403051.28	2024-05-31 12:00:00
PAY01940	ORD02597	Card	39288.15	2024-09-24 09:00:00
PAY01941	ORD02599	Mobile Money	25947.77	2024-11-15 15:00:00
PAY01942	ORD02602	Mobile Money	700393.60	2023-11-25 18:00:00
PAY01943	ORD02604	Mobile Money	81167.53	2024-07-17 05:00:00
PAY01944	ORD02605	Bank Transfer	108875.43	2024-12-24 22:00:00
PAY01945	ORD02606	Card	180084.64	2024-10-11 06:00:00
PAY01946	ORD02607	Card	33826.71	2024-10-23 20:00:00
PAY01947	ORD02608	Card	223132.14	2024-11-10 12:00:00
PAY01948	ORD02609	Bank Transfer	71981.01	2024-08-21 10:00:00
PAY01949	ORD02611	Cash on Delivery	378000.32	2024-07-27 13:00:00
PAY01950	ORD02612	Mobile Money	134609.96	2024-07-26 04:00:00
PAY01951	ORD02614	Card	321009.41	2024-10-13 19:00:00
PAY01952	ORD02615	Mobile Money	217385.44	2024-11-06 06:00:00
PAY01953	ORD02620	Mobile Money	651771.68	2024-12-26 16:00:00
PAY01954	ORD02622	Card	87218.15	2024-12-19 20:00:00
PAY01955	ORD02623	Card	687279.15	2024-11-15 13:00:00
PAY01956	ORD02624	Card	1198474.16	2024-06-22 01:00:00
PAY01957	ORD02625	Cash on Delivery	34507.56	2024-06-08 09:00:00
PAY01958	ORD02628	Mobile Money	26230.02	2024-12-27 00:00:00
PAY01959	ORD02629	Mobile Money	1636649.83	2024-12-07 09:00:00
PAY01960	ORD02630	Card	15371.06	2024-12-16 12:00:00
PAY01961	ORD02631	Mobile Money	290642.30	2024-12-19 16:00:00
PAY01962	ORD02632	Mobile Money	70682.86	2024-12-23 20:00:00
PAY01963	ORD02633	Mobile Money	716591.83	2024-08-31 02:00:00
PAY01964	ORD02634	Cash on Delivery	160965.44	2024-12-28 20:00:00
PAY01965	ORD02635	Cash on Delivery	\N	2024-11-19 02:00:00
PAY01966	ORD02636	Cash on Delivery	468450.06	2024-11-28 07:00:00
PAY01967	ORD02637	Cash on Delivery	871926.90	2024-01-13 16:00:00
PAY01968	ORD02638	Card	586313.81	2024-07-18 19:00:00
PAY01969	ORD02639	Mobile Money	\N	2024-12-27 10:00:00
PAY01970	ORD02640	Bank Transfer	75662.76	2024-12-10 03:00:00
PAY01971	ORD02642	Card	1459370.17	2024-12-23 06:00:00
PAY01972	ORD02643	Card	299192.34	2024-07-16 05:00:00
PAY01973	ORD02644	Card	245007.21	2024-07-25 15:00:00
PAY01974	ORD02646	Card	246601.80	2024-05-29 09:00:00
PAY01975	ORD02647	Card	45816.72	2024-10-31 13:00:00
PAY01976	ORD02649	Cash on Delivery	227490.03	2023-08-19 23:00:00
PAY01977	ORD02650	Mobile Money	255676.46	2024-01-24 16:00:00
PAY01978	ORD02652	Mobile Money	427359.18	2024-06-17 12:00:00
PAY01979	ORD02653	Card	340737.24	2024-10-15 09:00:00
PAY01980	ORD02654	Mobile Money	38292.36	2024-10-30 18:00:00
PAY01981	ORD02656	Bank Transfer	923488.82	2024-07-05 04:00:00
PAY01982	ORD02658	Bank Transfer	\N	2024-09-03 11:00:00
PAY01983	ORD02659	Card	6057.15	2024-07-01 13:00:00
PAY01984	ORD02660	Bank Transfer	430074.55	2024-08-15 18:00:00
PAY01985	ORD02662	Card	288258.95	2024-10-15 02:00:00
PAY01986	ORD02663	Card	7958.84	2024-04-10 03:00:00
PAY01987	ORD02664	Cash on Delivery	86513.92	2024-01-21 16:00:00
PAY01988	ORD02665	Bank Transfer	\N	2023-10-29 08:00:00
PAY01989	ORD02666	Cash on Delivery	\N	2024-03-08 00:00:00
PAY01990	ORD02668	Mobile Money	1118094.17	2024-03-17 07:00:00
PAY01991	ORD02669	Mobile Money	8076.20	2023-02-24 17:00:00
PAY01992	ORD02672	Card	\N	2024-09-21 02:00:00
PAY01993	ORD02673	Mobile Money	56478.55	2024-11-14 23:00:00
PAY01994	ORD02674	Bank Transfer	486073.96	2024-08-22 15:00:00
PAY01995	ORD02676	Card	\N	2024-11-27 04:00:00
PAY01996	ORD02678	Mobile Money	10193.83	2024-07-08 13:00:00
PAY01997	ORD02681	Mobile Money	\N	2024-12-03 07:00:00
PAY01998	ORD02682	Cash on Delivery	100741.91	2024-07-17 09:00:00
PAY01999	ORD02684	Mobile Money	16449.80	2024-08-31 05:00:00
PAY02000	ORD02685	Mobile Money	294318.98	2024-06-26 22:00:00
PAY02001	ORD02686	Card	95598.42	2024-06-08 06:00:00
PAY02002	ORD02689	Mobile Money	14928.20	2024-02-27 18:00:00
PAY02003	ORD02690	Card	\N	2024-06-23 02:00:00
PAY02004	ORD02691	Mobile Money	46511.08	2024-05-18 18:00:00
PAY02005	ORD02694	Card	237309.76	2024-07-09 00:00:00
PAY02006	ORD02697	Bank Transfer	45877.96	2024-05-19 09:00:00
PAY02007	ORD02698	Bank Transfer	173094.92	2024-05-06 21:00:00
PAY02008	ORD02700	Card	68496.96	2023-11-21 10:00:00
PAY02009	ORD02701	Bank Transfer	313387.28	2024-01-27 22:00:00
PAY02010	ORD02702	Bank Transfer	18690.33	2023-10-06 15:00:00
PAY02011	ORD02703	Card	38061.27	2024-06-27 04:00:00
PAY02012	ORD02706	Bank Transfer	\N	2024-05-20 15:00:00
PAY02013	ORD02709	Card	44272.74	2024-04-15 17:00:00
PAY02014	ORD02710	Mobile Money	74227.75	2023-07-20 06:00:00
PAY02015	ORD02711	Mobile Money	19732.78	2024-05-22 12:00:00
PAY02016	ORD02712	Card	140246.84	2024-04-22 02:00:00
PAY02017	ORD02714	Card	24463.34	2024-11-08 18:00:00
PAY02018	ORD02715	Card	219581.43	2024-04-19 22:00:00
PAY02019	ORD02716	Card	\N	2024-10-31 13:00:00
PAY02020	ORD02717	Card	527912.66	2023-08-11 09:00:00
PAY02021	ORD02718	Bank Transfer	\N	2024-12-27 15:00:00
PAY02022	ORD02719	Card	8757.97	2024-12-20 09:00:00
PAY02023	ORD02721	Mobile Money	222485.82	2024-04-13 02:00:00
PAY02024	ORD02723	Cash on Delivery	48431.34	2024-10-23 23:00:00
PAY02025	ORD02724	Bank Transfer	818092.87	2024-03-19 12:00:00
PAY02026	ORD02725	Cash on Delivery	\N	2024-06-01 15:00:00
PAY02027	ORD02726	Bank Transfer	110331.26	2024-12-04 01:00:00
PAY02028	ORD02728	Cash on Delivery	217385.44	2024-11-23 19:00:00
PAY02029	ORD02729	Card	44730.34	2024-05-20 05:00:00
PAY02030	ORD02730	Card	6965.45	2024-02-03 06:00:00
PAY02031	ORD02737	Card	403980.41	2024-05-19 21:00:00
PAY02032	ORD02738	Bank Transfer	280143.99	2023-08-19 22:00:00
PAY02033	ORD02739	Card	161331.95	2024-11-12 00:00:00
PAY02034	ORD02740	Bank Transfer	\N	2024-09-11 02:00:00
PAY02035	ORD02741	Card	235978.86	2024-08-14 01:00:00
PAY02036	ORD02743	Card	21790.46	2024-04-16 23:00:00
PAY02037	ORD02744	Cash on Delivery	1006071.55	2024-09-06 12:00:00
PAY02038	ORD02745	Cash on Delivery	124245.93	2023-11-09 16:00:00
PAY02039	ORD02746	Cash on Delivery	494280.20	2024-04-03 15:00:00
PAY02040	ORD02747	Mobile Money	1097468.41	2024-07-06 02:00:00
PAY02041	ORD02748	Bank Transfer	397767.20	2024-07-02 06:00:00
PAY02042	ORD02749	Cash on Delivery	4809.30	2024-12-25 15:00:00
PAY02043	ORD02751	Cash on Delivery	22153.16	2023-12-13 13:00:00
PAY02044	ORD02754	Mobile Money	168684.73	2024-01-12 05:00:00
PAY02045	ORD02755	Bank Transfer	16538.43	2024-09-08 09:00:00
PAY02046	ORD02756	Bank Transfer	1330904.90	2024-10-01 09:00:00
PAY02047	ORD02757	Cash on Delivery	232342.08	2023-12-12 09:00:00
PAY02048	ORD02758	Mobile Money	851701.63	2024-03-23 19:00:00
PAY02049	ORD02762	Bank Transfer	671864.12	2024-10-17 07:00:00
PAY02050	ORD02764	Mobile Money	356067.36	2024-08-02 08:00:00
PAY02051	ORD02765	Bank Transfer	87419.50	2024-06-26 19:00:00
PAY02052	ORD02766	Card	636407.49	2024-07-25 14:00:00
PAY02053	ORD02768	Card	23962.00	2024-11-15 01:00:00
PAY02054	ORD02769	Mobile Money	38177.68	2024-04-09 20:00:00
PAY02055	ORD02772	Cash on Delivery	6169.57	2024-07-01 12:00:00
PAY02056	ORD02774	Card	838846.42	2023-11-11 14:00:00
PAY02057	ORD02775	Mobile Money	1924.96	2024-04-26 10:00:00
PAY02058	ORD02776	Cash on Delivery	57745.17	2024-07-12 03:00:00
PAY02059	ORD02777	Mobile Money	170697.47	2024-09-11 12:00:00
PAY02060	ORD02778	Bank Transfer	298987.09	2024-03-29 21:00:00
PAY02061	ORD02779	Card	789376.88	2024-10-01 20:00:00
PAY02062	ORD02780	Cash on Delivery	2388424.82	2024-10-29 07:00:00
PAY02063	ORD02781	Card	801.07	2024-10-12 17:00:00
PAY02064	ORD02782	Mobile Money	3172.89	2024-10-08 17:00:00
PAY02065	ORD02783	Card	88011.45	2024-12-04 00:00:00
PAY02066	ORD02784	Bank Transfer	102447.74	2024-10-07 10:00:00
PAY02067	ORD02785	Bank Transfer	3329.98	2024-10-22 14:00:00
PAY02068	ORD02786	Card	504259.73	2024-08-27 23:00:00
PAY02069	ORD02788	Cash on Delivery	\N	2024-12-07 17:00:00
PAY02070	ORD02789	Card	622086.94	2024-10-09 17:00:00
PAY02071	ORD02790	Mobile Money	97086.56	2024-12-04 01:00:00
PAY02072	ORD02791	Bank Transfer	199481.86	2024-10-11 00:00:00
PAY02073	ORD02792	Card	772795.08	2024-05-22 12:00:00
PAY02074	ORD02794	Mobile Money	31709.48	2024-08-01 21:00:00
PAY02075	ORD02795	Bank Transfer	760793.62	2024-03-01 10:00:00
PAY02076	ORD02796	Card	48182.26	2024-07-27 12:00:00
PAY02077	ORD02797	Mobile Money	27918.16	2023-11-21 18:00:00
PAY02078	ORD02798	Mobile Money	305522.26	2023-12-18 10:00:00
PAY02079	ORD02799	Mobile Money	273170.78	2023-11-17 05:00:00
PAY02080	ORD02800	Mobile Money	329436.98	2024-10-17 11:00:00
PAY02081	ORD02801	Cash on Delivery	545026.24	2024-12-29 08:00:00
PAY02082	ORD02802	Card	99076.62	2024-01-14 10:00:00
PAY02083	ORD02803	Card	43039.35	2024-10-03 10:00:00
PAY02084	ORD02804	Bank Transfer	644680.18	2023-08-10 12:00:00
PAY02085	ORD02805	Mobile Money	656895.94	2024-12-13 12:00:00
PAY02086	ORD02806	Bank Transfer	46265.11	2024-07-08 11:00:00
PAY02087	ORD02807	Card	4038.10	2024-01-22 14:00:00
PAY02088	ORD02809	Card	181459.05	2023-09-05 07:00:00
PAY02089	ORD02810	Mobile Money	249085.34	2023-06-14 21:00:00
PAY02090	ORD02811	Bank Transfer	17976.54	2024-08-05 02:00:00
PAY02091	ORD02812	Mobile Money	5994.32	2024-11-17 17:00:00
PAY02092	ORD02815	Card	27116.85	2023-06-14 21:00:00
PAY02093	ORD02816	Card	158091.35	2023-10-30 09:00:00
PAY02094	ORD02818	Card	52486.04	2024-09-22 04:00:00
PAY02095	ORD02819	Card	22093.77	2023-08-26 17:00:00
PAY02096	ORD02820	Mobile Money	619843.72	2024-01-25 14:00:00
PAY02097	ORD02821	Mobile Money	117073.40	2024-06-25 22:00:00
PAY02098	ORD02822	Card	\N	2024-03-22 10:00:00
PAY02099	ORD02823	Mobile Money	87588.60	2024-07-16 12:00:00
PAY02100	ORD02825	Bank Transfer	131032.85	2024-11-20 17:00:00
PAY02101	ORD02829	Bank Transfer	286376.81	2024-12-19 21:00:00
PAY02102	ORD02830	Bank Transfer	153518.44	2024-11-17 14:00:00
PAY02103	ORD02831	Card	105815.87	2024-09-29 08:00:00
PAY02104	ORD02832	Mobile Money	196582.07	2024-10-26 15:00:00
PAY02105	ORD02833	Bank Transfer	841978.87	2024-12-22 15:00:00
PAY02106	ORD02834	Card	21277.86	2024-09-23 02:00:00
PAY02107	ORD02835	Mobile Money	614201.88	2024-10-05 21:00:00
PAY02108	ORD02836	Card	493640.21	2024-02-15 22:00:00
PAY02109	ORD02837	Mobile Money	142961.41	2024-07-20 11:00:00
PAY02110	ORD02838	Bank Transfer	52486.04	2023-10-20 08:00:00
PAY02111	ORD02840	Mobile Money	44862.34	2024-05-20 19:00:00
PAY02112	ORD02841	Cash on Delivery	5399.76	2024-07-06 00:00:00
PAY02113	ORD02842	Bank Transfer	272051.99	2024-07-13 04:00:00
PAY02114	ORD02844	Mobile Money	64022.61	2023-09-09 19:00:00
PAY02115	ORD02846	Card	553178.86	2024-01-06 19:00:00
PAY02116	ORD02847	Card	199684.92	2023-07-11 16:00:00
PAY02117	ORD02849	Card	982884.07	2024-06-07 15:00:00
PAY02118	ORD02850	Card	560667.61	2023-09-09 23:00:00
PAY02119	ORD02851	Mobile Money	21755.58	2023-04-23 23:00:00
PAY02120	ORD02852	Mobile Money	83872.29	2024-12-06 00:00:00
PAY02121	ORD02853	Mobile Money	194669.49	2024-09-15 08:00:00
PAY02122	ORD02854	Bank Transfer	\N	2024-11-11 18:00:00
PAY02123	ORD02855	Cash on Delivery	248810.57	2024-11-13 08:00:00
PAY02124	ORD02856	Card	539592.87	2024-10-22 16:00:00
PAY02125	ORD02857	Card	1557795.44	2024-09-12 16:00:00
PAY02126	ORD02858	Cash on Delivery	2661200.53	2024-01-21 18:00:00
PAY02127	ORD02859	Mobile Money	52304.59	2023-11-26 23:00:00
PAY02128	ORD02860	Card	13464.64	2024-07-23 17:00:00
PAY02129	ORD02861	Cash on Delivery	508025.72	2024-08-11 03:00:00
PAY02130	ORD02865	Cash on Delivery	602198.00	2024-01-20 17:00:00
PAY02131	ORD02866	Bank Transfer	1633.04	2024-08-20 12:00:00
PAY02132	ORD02868	Bank Transfer	262877.04	2024-08-27 23:00:00
PAY02133	ORD02869	Card	35114.37	2024-12-03 06:00:00
PAY02134	ORD02870	Card	193988.83	2024-09-14 17:00:00
PAY02135	ORD02871	Card	1454233.82	2024-10-13 20:00:00
PAY02136	ORD02872	Bank Transfer	36035.42	2024-09-20 09:00:00
PAY02137	ORD02873	Card	236487.25	2024-10-12 22:00:00
PAY02138	ORD02874	Card	719457.16	2024-11-24 02:00:00
PAY02139	ORD02875	Card	\N	2024-11-27 14:00:00
PAY02140	ORD02876	Cash on Delivery	1698546.23	2024-10-31 18:00:00
PAY02141	ORD02878	Bank Transfer	247085.24	2024-12-29 13:00:00
PAY02142	ORD02879	Card	687406.40	2023-10-23 21:00:00
PAY02143	ORD02880	Mobile Money	1332354.35	2024-04-13 02:00:00
PAY02144	ORD02881	Card	287162.35	2024-05-03 02:00:00
PAY02145	ORD02882	Mobile Money	43501.45	2024-02-10 01:00:00
PAY02146	ORD02883	Bank Transfer	7958.84	2024-01-27 23:00:00
PAY02147	ORD02884	Bank Transfer	20952.80	2024-06-19 04:00:00
PAY02148	ORD02885	Card	26206.57	2024-03-03 23:00:00
PAY02149	ORD02886	Bank Transfer	\N	2024-03-24 01:00:00
PAY02150	ORD02888	Card	113221.27	2024-03-17 04:00:00
PAY02151	ORD02889	Cash on Delivery	776806.99	2024-07-08 04:00:00
PAY02152	ORD02890	Mobile Money	240879.20	2024-01-03 18:00:00
PAY02153	ORD02891	Card	26579.20	2024-11-02 16:00:00
PAY02154	ORD02892	Card	527670.35	2024-07-16 05:00:00
PAY02155	ORD02894	Mobile Money	114123.99	2024-05-06 05:00:00
PAY02156	ORD02895	Mobile Money	201980.35	2024-10-07 22:00:00
PAY02157	ORD02896	Cash on Delivery	264292.34	2024-11-23 08:00:00
PAY02158	ORD02897	Bank Transfer	573477.05	2024-07-20 18:00:00
PAY02159	ORD02898	Cash on Delivery	126318.52	2024-12-26 01:00:00
PAY02160	ORD02899	Card	606004.23	2024-06-27 08:00:00
PAY02161	ORD02900	Mobile Money	1110784.70	2024-08-18 06:00:00
PAY02162	ORD02902	Mobile Money	264386.43	2024-11-15 01:00:00
PAY02163	ORD02903	Card	581859.80	2024-08-23 04:00:00
PAY02164	ORD02904	Mobile Money	11209.32	2024-12-08 22:00:00
PAY02165	ORD02905	Card	\N	2024-09-27 12:00:00
PAY02166	ORD02907	Mobile Money	1583210.41	2024-11-03 18:00:00
PAY02167	ORD02908	Card	\N	2024-07-04 01:00:00
PAY02168	ORD02909	Mobile Money	88105.02	2024-03-11 01:00:00
PAY02169	ORD02911	Card	64966.29	2024-10-27 03:00:00
PAY02170	ORD02912	Cash on Delivery	649434.60	2024-03-22 04:00:00
PAY02171	ORD02913	Cash on Delivery	32521.50	2024-12-04 17:00:00
PAY02172	ORD02915	Card	1458423.30	2024-09-03 01:00:00
PAY02173	ORD02916	Card	487075.95	2024-03-14 00:00:00
PAY02174	ORD02918	Card	47755.52	2024-12-08 09:00:00
PAY02175	ORD02919	Card	758332.90	2024-08-26 02:00:00
PAY02176	ORD02920	Cash on Delivery	\N	2024-06-20 03:00:00
PAY02177	ORD02921	Bank Transfer	145167.24	2024-07-29 17:00:00
PAY02178	ORD02922	Cash on Delivery	38929.45	2024-12-21 09:00:00
PAY02179	ORD02923	Bank Transfer	952072.75	2024-08-26 21:00:00
PAY02180	ORD02924	Mobile Money	8757.97	2024-11-07 07:00:00
PAY02181	ORD02925	Cash on Delivery	290501.34	2024-08-28 05:00:00
PAY02182	ORD02927	Mobile Money	41185.06	2024-10-13 04:00:00
PAY02183	ORD02928	Card	44137.50	2024-10-30 00:00:00
PAY02184	ORD02929	Bank Transfer	26461.80	2024-02-01 07:00:00
PAY02185	ORD02930	Bank Transfer	308912.61	2023-08-23 03:00:00
PAY02186	ORD02933	Mobile Money	69517.54	2024-11-14 06:00:00
PAY02187	ORD02934	Mobile Money	24683.24	2024-10-03 15:00:00
PAY02188	ORD02935	Card	\N	2024-07-17 01:00:00
PAY02189	ORD02936	Bank Transfer	\N	2024-12-10 20:00:00
PAY02190	ORD02937	Card	45902.74	2024-09-02 20:00:00
PAY02191	ORD02938	Card	18483.24	2024-11-10 20:00:00
PAY02192	ORD02939	Card	69610.56	2024-10-17 20:00:00
PAY02193	ORD02940	Card	246866.05	2024-11-15 04:00:00
PAY02194	ORD02941	Cash on Delivery	141179.30	2024-09-30 09:00:00
PAY02195	ORD02942	Cash on Delivery	494813.66	2024-10-23 17:00:00
PAY02196	ORD02944	Card	138696.11	2024-10-20 22:00:00
PAY02197	ORD02945	Card	\N	2024-07-28 01:00:00
PAY02198	ORD02946	Card	110681.85	2024-08-30 02:00:00
PAY02199	ORD02948	Card	569946.78	2024-11-21 13:00:00
PAY02200	ORD02949	Bank Transfer	646154.12	2024-07-06 14:00:00
PAY02201	ORD02950	Card	132529.29	2024-09-07 06:00:00
PAY02202	ORD02952	Bank Transfer	118060.60	2024-12-30 13:00:00
PAY02203	ORD02954	Mobile Money	456816.78	2024-09-16 15:00:00
PAY02204	ORD02955	Bank Transfer	29614.02	2024-12-02 13:00:00
PAY02205	ORD02956	Bank Transfer	13361.05	2024-12-06 21:00:00
PAY02206	ORD02957	Bank Transfer	554133.17	2024-12-07 01:00:00
PAY02207	ORD02958	Mobile Money	\N	2024-01-14 08:00:00
PAY02208	ORD02959	Bank Transfer	762526.05	2024-11-25 15:00:00
PAY02209	ORD02960	Mobile Money	142340.25	2024-02-15 13:00:00
PAY02210	ORD02962	Mobile Money	1028522.50	2024-03-11 17:00:00
PAY02211	ORD02964	Card	8757.97	2024-05-30 19:00:00
PAY02212	ORD02965	Card	\N	2024-09-16 13:00:00
PAY02213	ORD02966	Card	782053.66	2024-10-21 09:00:00
PAY02214	ORD02968	Card	\N	2024-08-31 12:00:00
PAY02215	ORD02969	Card	150550.83	2024-08-02 02:00:00
PAY02216	ORD02970	Card	16010.80	2024-05-07 17:00:00
PAY02217	ORD02971	Card	17522.15	2024-08-19 21:00:00
PAY02218	ORD02972	Mobile Money	1446927.23	2024-09-13 01:00:00
PAY02219	ORD02974	Bank Transfer	937404.21	2024-07-12 11:00:00
PAY02220	ORD02976	Cash on Delivery	3849.92	2024-10-16 21:00:00
PAY02221	ORD02977	Mobile Money	70592.32	2024-10-31 12:00:00
PAY02222	ORD02978	Cash on Delivery	73176.91	2024-10-04 05:00:00
PAY02223	ORD02979	Card	12599.24	2024-08-15 01:00:00
PAY02224	ORD02980	Card	202145.72	2024-09-06 07:00:00
PAY02225	ORD02981	Card	140213.78	2024-05-26 00:00:00
PAY02226	ORD02983	Card	194757.85	2024-07-15 00:00:00
PAY02227	ORD02984	Card	233857.94	2024-10-17 08:00:00
PAY02228	ORD02987	Cash on Delivery	300935.13	2024-08-28 15:00:00
PAY02229	ORD02988	Mobile Money	\N	2023-12-24 05:00:00
PAY02230	ORD02989	Bank Transfer	26929.28	2024-05-30 14:00:00
PAY02231	ORD02991	Mobile Money	249606.15	2023-11-06 22:00:00
PAY02232	ORD02992	Card	213156.97	2024-01-08 11:00:00
PAY02233	ORD02995	Card	156737.85	2024-12-08 03:00:00
PAY02234	ORD02996	Bank Transfer	756814.31	2024-04-30 00:00:00
PAY02235	ORD02997	Cash on Delivery	126350.44	2024-03-10 04:00:00
PAY02236	ORD02998	Bank Transfer	150088.30	2023-08-08 13:00:00
PAY02237	ORD02999	Card	17641.20	2024-08-04 07:00:00
PAY02238	ORD03000	Card	1071290.74	2024-02-16 01:00:00
PAY02239	ORD03001	Mobile Money	361991.39	2023-03-25 02:00:00
PAY02240	ORD03002	Cash on Delivery	20728.76	2023-06-19 07:00:00
PAY02241	ORD03003	Bank Transfer	29754.99	2024-10-22 01:00:00
PAY02242	ORD03004	Cash on Delivery	418447.53	2024-11-26 15:00:00
PAY02243	ORD03005	Mobile Money	94625.99	2024-12-29 11:00:00
PAY02244	ORD03006	Mobile Money	697032.82	2024-11-19 06:00:00
PAY02245	ORD03007	Card	854934.30	2024-11-08 00:00:00
PAY02246	ORD03008	Mobile Money	423407.40	2024-12-01 02:00:00
PAY02247	ORD03009	Bank Transfer	61427.21	2024-12-09 13:00:00
PAY02248	ORD03013	Mobile Money	56807.28	2024-12-19 22:00:00
PAY02249	ORD03014	Card	596650.80	2024-09-20 01:00:00
PAY02250	ORD00474	Card	234437.08	2024-11-18 00:00:00
PAY02251	ORD00390	Cash on Delivery	46462.10	2024-12-19 01:00:00
PAY02252	ORD00930	Cash on Delivery	310936.87	2024-04-11 02:00:00
PAY02253	ORD01486	Bank Transfer	294670.24	2024-08-04 19:00:00
PAY02254	ORD02895	Card	201980.35	2024-10-06 02:00:00
PAY02255	ORD02050	Mobile Money	25910.95	2023-05-24 23:00:00
PAY02256	ORD00010	Mobile Money	87246.65	2024-03-27 00:00:00
PAY02257	ORD01159	Cash on Delivery	382139.74	2024-11-25 23:00:00
PAY02258	ORD00791	Bank Transfer	984241.89	2024-10-15 19:00:00
PAY02259	ORD00969	Mobile Money	176857.47	2023-11-02 23:00:00
PAY02260	ORD01536	Cash on Delivery	91572.30	2024-10-01 08:00:00
PAY02261	ORD02758	Card	851701.63	2024-03-23 01:00:00
PAY02262	ORD01723	Cash on Delivery	994838.80	2024-02-13 11:00:00
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.products (product_id, product_name, category, unit_price, seller_id) FROM stdin;
PROD0110	Wooden Bookshelf 5-Tier - v2	Home & Garden	23332.73	SELL025
PROD0111	Garden Hose 30m Expandable - v2	Home & Garden	2676.03	SELL036
PROD0112	Indoor Plant Pot Set Ceramic - v2	Home & Garden	35280.59	SELL081
PROD0113	LED Desk Lamp USB Rechargeable - v2	Home & Garden	145706.19	SELL064
PROD0114	Microwave Oven 20L Digital - v2	Home & Garden	7586.49	SELL078
PROD0115	Electric Kettle 1.8L Stainless - v2	Home & Garden	2277.24	SELL082
PROD0116	Iron Box Steam 2400W Dry - v2	Home & Garden	20859.43	SELL065
PROD0117	Washing Machine 7KG Front Load - v2	Home & Garden	31515.40	SELL073
PROD0118	Refrigerator 200L Double Door - v2	Home & Garden	12699.55	SELL009
PROD0119	Air Purifier HEPA Filter - v2	Home & Garden	47472.78	SELL030
PROD0120	Doormat Anti-Slip Rubber - v2	Home & Garden	35341.43	SELL089
PROD0121	Shea Butter Moisturiser 500ml	Beauty & Personal Care	17176.67	SELL001
PROD0122	African Black Soap Bar 200g	Beauty & Personal Care	16203.67	SELL007
PROD0123	Vitamin C Face Serum 30ml	Beauty & Personal Care	11097.43	SELL036
PROD0124	Argan Oil Hair Treatment 100ml	Beauty & Personal Care	17164.25	SELL047
PROD0125	Electric Face Cleanser Brush	Beauty & Personal Care	22153.16	SELL036
PROD0126	Men's Grooming Kit 8 Piece	Beauty & Personal Care	13544.05	SELL051
PROD0127	Natural Deodorant Roll-On 75ml	Beauty & Personal Care	8700.29	SELL004
PROD0128	Teeth Whitening Kit LED Light	Beauty & Personal Care	24463.34	SELL010
PROD0129	Facial Sunscreen SPF50 50ml	Beauty & Personal Care	5323.48	SELL009
PROD0130	Keratin Hair Straightener Brush	Beauty & Personal Care	1182.88	SELL004
PROD0131	Lip Gloss Set 12 Colours	Beauty & Personal Care	21092.44	SELL061
PROD0132	Foundation Stick Matte Finish	Beauty & Personal Care	23990.67	SELL043
PROD0133	Lash & Brow Growth Serum	Beauty & Personal Care	23616.92	SELL080
PROD0134	Body Scrub Sugar Vanilla 300g	Beauty & Personal Care	19220.41	SELL075
PROD0135	Perfume Eau de Toilette 100ml	Beauty & Personal Care	2595.60	SELL005
PROD0136	Nail Polish Set 24 Colours	Beauty & Personal Care	8175.35	SELL009
PROD0137	Rose Water Toner 200ml	Beauty & Personal Care	2019.05	SELL008
PROD0138	Charcoal Peel Off Face Mask	Beauty & Personal Care	15463.10	SELL014
PROD0139	Hair Relaxer Cream Mild 500g	Beauty & Personal Care	14201.82	SELL049
PROD0140	Beard Oil & Balm Combo Pack	Beauty & Personal Care	2847.84	SELL030
PROD0141	Shea Butter Moisturiser 500ml - v2	Beauty & Personal Care	11608.58	SELL055
PROD0142	African Black Soap Bar 200g - v2	Beauty & Personal Care	8820.60	SELL004
PROD0143	Vitamin C Face Serum 30ml - v2	Beauty & Personal Care	13171.72	SELL014
PROD0144	Argan Oil Hair Treatment 100ml - v2	Beauty & Personal Care	801.07	SELL076
PROD0145	Electric Face Cleanser Brush - v2	Beauty & Personal Care	22657.06	SELL066
PROD0146	Men's Grooming Kit 8 Piece - v2	Beauty & Personal Care	9207.08	SELL080
PROD0147	Natural Deodorant Roll-On 75ml - v2	Beauty & Personal Care	5055.12	SELL006
PROD0148	Teeth Whitening Kit LED Light - v2	Beauty & Personal Care	3628.18	SELL066
PROD0149	Facial Sunscreen SPF50 50ml - v2	Beauty & Personal Care	8124.11	SELL019
PROD0150	Keratin Hair Straightener Brush - v2	Beauty & Personal Care	12003.33	SELL038
PROD0151	Lip Gloss Set 12 Colours - v2	Beauty & Personal Care	24271.64	SELL085
PROD0152	Foundation Stick Matte Finish - v2	Beauty & Personal Care	1904.28	SELL072
PROD0153	Lash & Brow Growth Serum - v2	Beauty & Personal Care	10840.50	SELL026
PROD0154	Body Scrub Sugar Vanilla 300g - v2	Beauty & Personal Care	19738.96	SELL086
PROD0155	Perfume Eau de Toilette 100ml - v2	Beauty & Personal Care	17522.15	SELL077
PROD0156	Nail Polish Set 24 Colours - v2	Beauty & Personal Care	21374.21	SELL043
PROD0157	Rose Water Toner 200ml - v2	Beauty & Personal Care	10758.03	SELL059
PROD0158	Charcoal Peel Off Face Mask - v2	Beauty & Personal Care	12650.30	SELL082
PROD0159	Hair Relaxer Cream Mild 500g - v2	Beauty & Personal Care	17483.90	SELL028
PROD0161	Yoga Mat Non-Slip 6mm Thick	Sports & Fitness	25829.99	SELL001
PROD0162	Resistance Bands Set 5 Levels	Sports & Fitness	2672.21	SELL072
PROD0163	Adjustable Dumbbell Set 20KG	Sports & Fitness	18374.63	SELL081
PROD0164	Jump Rope Speed Adjustable	Sports & Fitness	6702.72	SELL026
PROD0165	Nike Air Zoom Running Shoes	Sports & Fitness	22136.37	SELL023
PROD0166	Football Size 5 Adidas	Sports & Fitness	101932.80	SELL026
PROD0167	Basketball Indoor Outdoor Size 7	Sports & Fitness	22365.17	SELL013
PROD0168	Badminton Racket Set 2 Player	Sports & Fitness	100026.32	SELL084
PROD0169	Swimming Goggles Anti-Fog	Sports & Fitness	41598.42	SELL059
PROD0170	Cycling Helmet Adjustable	Sports & Fitness	45302.42	SELL022
PROD0171	Gym Gloves Weightlifting Pair	Sports & Fitness	105588.96	SELL019
PROD0172	Protein Shaker Bottle 700ml	Sports & Fitness	95695.43	SELL049
PROD0173	Exercise Bike Magnetic Resistance	Sports & Fitness	39177.27	SELL082
PROD0174	Pull Up Bar Door Frame	Sports & Fitness	110640.11	SELL076
PROD0175	Tennis Racket Beginner Aluminium	Sports & Fitness	102750.60	SELL020
PROD0176	Sports Compression Shorts	Sports & Fitness	30789.84	SELL036
PROD0177	Foam Roller Muscle Recovery	Sports & Fitness	102403.06	SELL063
PROD0178	Treadmill Foldable Electric 1HP	Sports & Fitness	87684.88	SELL085
PROD0179	Boxing Gloves 12oz Leather	Sports & Fitness	21340.87	SELL083
PROD0180	Volleyball Beach Ball Set	Sports & Fitness	60582.65	SELL042
PROD0181	Yoga Mat Non-Slip 6mm Thick - v2	Sports & Fitness	63768.87	SELL064
PROD0182	Resistance Bands Set 5 Levels - v2	Sports & Fitness	33297.75	SELL075
PROD0183	Adjustable Dumbbell Set 20KG - v2	Sports & Fitness	26053.15	SELL058
PROD0184	Jump Rope Speed Adjustable - v2	Sports & Fitness	48414.15	SELL049
PROD0185	Nike Air Zoom Running Shoes - v2	Sports & Fitness	112356.62	SELL071
PROD0186	Football Size 5 Adidas - v2	Sports & Fitness	17418.14	SELL057
PROD0187	Basketball Indoor Outdoor Size 7 - v2	Sports & Fitness	28776.04	SELL066
PROD0188	Badminton Racket Set 2 Player - v2	Sports & Fitness	51993.13	SELL053
PROD0189	Swimming Goggles Anti-Fog - v2	Sports & Fitness	96833.78	SELL049
PROD0190	Cycling Helmet Adjustable - v2	Sports & Fitness	22778.54	SELL083
PROD0191	Gym Gloves Weightlifting Pair - v2	Sports & Fitness	44052.51	SELL065
PROD0192	Protein Shaker Bottle 700ml - v2	Sports & Fitness	94625.99	SELL013
PROD0193	Exercise Bike Magnetic Resistance - v2	Sports & Fitness	9954.82	SELL026
PROD0194	Pull Up Bar Door Frame - v2	Sports & Fitness	24802.59	SELL039
PROD0195	Tennis Racket Beginner Aluminium - v2	Sports & Fitness	24091.13	SELL018
PROD0196	Sports Compression Shorts - v2	Sports & Fitness	2511.26	SELL045
PROD0197	Foam Roller Muscle Recovery - v2	Sports & Fitness	113579.08	SELL084
PROD0198	Treadmill Foldable Electric 1HP - v2	Sports & Fitness	57432.47	SELL020
PROD0199	Boxing Gloves 12oz Leather - v2	Sports & Fitness	28468.05	SELL027
PROD0200	Volleyball Beach Ball Set - v2	Sports & Fitness	29196.20	SELL071
PROD0201	Milo Chocolate Drink 900g Tin	Food & Beverages	10976.40	SELL011
PROD0202	Golden Morn Maize Cereal 1KG	Food & Beverages	12764.12	SELL090
PROD0203	Indomie Noodles Instant 40 Pack	Food & Beverages	3538.98	SELL072
PROD0204	Lipton Yellow Label Tea 100 Bags	Food & Beverages	5933.15	SELL017
PROD0205	Ribena Blackcurrant Drink 1L	Food & Beverages	\N	SELL085
PROD0206	Organic Honey Raw Unfiltered 500g	Food & Beverages	5427.42	SELL088
PROD0207	Groundnut Oil Refined 5 Litres	Food & Beverages	11561.20	SELL039
PROD0208	Tomato Paste Canned 400g x6	Food & Beverages	9010.85	SELL005
PROD0209	Bournvita Malted Drink 900g	Food & Beverages	2728.52	SELL043
PROD0210	Peak Whole Milk Powder 900g	Food & Beverages	14712.50	SELL051
PROD0211	Cashew Nuts Premium 500g Pack	Food & Beverages	8250.11	SELL014
PROD0212	Dates Medjool Premium 500g	Food & Beverages	8757.97	SELL039
PROD0213	Garri White Fine 10KG Bag	Food & Beverages	2985.64	SELL023
PROD0214	Semovita Semolina 5KG Bag	Food & Beverages	12483.89	SELL004
PROD0215	Ofada Rice Local Premium 10KG	Food & Beverages	3385.48	SELL050
PROD0216	Egusi Ground Melon Seeds 500g	Food & Beverages	3485.44	SELL068
PROD0217	Crayfish Dried Ground 200g	Food & Beverages	7092.62	SELL002
PROD0218	Suya Spice Mix Authentic 100g	Food & Beverages	5238.20	SELL051
PROD0219	Palm Oil Red Refined 5L	Food & Beverages	14849.13	SELL054
PROD0220	Zobo Hibiscus Drink 1.5L	Food & Beverages	11275.57	SELL027
PROD0221	Milo Chocolate Drink 900g Tin - v2	Food & Beverages	13121.51	SELL086
PROD0222	Golden Morn Maize Cereal 1KG - v2	Food & Beverages	2802.33	SELL040
PROD0223	Indomie Noodles Instant 40 Pack - v2	Food & Beverages	7785.89	SELL036
PROD0224	Lipton Yellow Label Tea 100 Bags - v2	Food & Beverages	607.93	SELL009
PROD0225	Ribena Blackcurrant Drink 1L - v2	Food & Beverages	9270.30	SELL043
PROD0226	Organic Honey Raw Unfiltered 500g - v2	Food & Beverages	7172.97	SELL012
PROD0227	Groundnut Oil Refined 5 Litres - v2	Food & Beverages	9871.34	SELL045
PROD0228	Tomato Paste Canned 400g x6 - v2	Food & Beverages	6170.81	SELL023
PROD0229	Bournvita Malted Drink 900g - v2	Food & Beverages	4112.45	SELL056
PROD0230	Peak Whole Milk Powder 900g - v2	Food & Beverages	6077.64	SELL090
PROD0231	Cashew Nuts Premium 500g Pack - v2	Food & Beverages	6206.49	SELL031
PROD0232	Dates Medjool Premium 500g - v2	Food & Beverages	4469.76	SELL038
PROD0233	Garri White Fine 10KG Bag - v2	Food & Beverages	10621.64	SELL028
PROD0234	Semovita Semolina 5KG Bag - v2	Food & Beverages	6463.53	SELL016
PROD0235	Ofada Rice Local Premium 10KG - v2	Food & Beverages	1609.74	SELL042
PROD0236	Egusi Ground Melon Seeds 500g - v2	Food & Beverages	7038.57	SELL065
PROD0237	Crayfish Dried Ground 200g - v2	Food & Beverages	7201.43	SELL089
PROD0238	Suya Spice Mix Authentic 100g - v2	Food & Beverages	6026.76	SELL025
PROD0239	Palm Oil Red Refined 5L - v2	Food & Beverages	1047.73	SELL018
PROD0240	Zobo Hibiscus Drink 1.5L - v2	Food & Beverages	10219.29	SELL060
PROD0241	Things Fall Apart Chinua Achebe	Books & Stationery	1174.07	SELL057
PROD0242	Purple Hibiscus Chimamanda Adichie	Books & Stationery	5755.30	SELL021
PROD0243	Half of a Yellow Sun Adichie	Books & Stationery	10094.25	SELL023
PROD0244	WAEC Past Questions Math 2023	Books & Stationery	1664.99	SELL022
PROD0245	JAMB CBT Practice Questions	Books & Stationery	\N	SELL035
PROD0246	Oxford Advanced Learner Dictionary	Books & Stationery	5399.76	SELL005
PROD0247	Accounting Principles Textbook	Books & Stationery	5416.29	SELL082
PROD0248	Biology for Senior Secondary	Books & Stationery	4809.30	SELL007
PROD0249	Ballpoint Pens Blue Box of 50	Books & Stationery	774.24	SELL026
PROD0250	Ruled Exercise Books Pack of 10	Books & Stationery	4620.81	SELL012
PROD0251	Stapler Heavy Duty 24/6	Books & Stationery	5175.86	SELL044
PROD0252	Scientific Calculator Casio FX-991	Books & Stationery	8223.52	SELL013
PROD0253	A4 Printing Paper 80gsm 500 Sheets	Books & Stationery	8743.34	SELL066
PROD0254	Spiral Notebook Hardcover A5	Books & Stationery	9824.37	SELL081
PROD0255	Highlighter Set 6 Colours	Books & Stationery	7571.15	SELL051
PROD0256	Geometry Set Complete Maths	Books & Stationery	1625.49	SELL046
PROD0257	English Grammar in Use Murphy	Books & Stationery	2248.73	SELL041
PROD0258	Business Law Nigerian Edition	Books & Stationery	4792.40	SELL009
PROD0259	Sticky Notes Set 4 Colours 400PC	Books & Stationery	7869.35	SELL009
PROD0260	Atlas of Nigeria Schools Edition	Books & Stationery	5050.94	SELL064
PROD0261	Things Fall Apart Chinua Achebe - v2	Books & Stationery	8607.87	SELL073
PROD0262	Purple Hibiscus Chimamanda Adichie - v2	Books & Stationery	3172.89	SELL042
PROD0263	Half of a Yellow Sun Adichie - v2	Books & Stationery	8199.23	SELL089
PROD0264	WAEC Past Questions Math 2023 - v2	Books & Stationery	4118.15	SELL089
PROD0265	JAMB CBT Practice Questions - v2	Books & Stationery	11740.65	SELL009
PROD0266	Oxford Advanced Learner Dictionary - v2	Books & Stationery	408.26	SELL058
PROD0267	Accounting Principles Textbook - v2	Books & Stationery	6230.11	SELL065
PROD0268	Biology for Senior Secondary - v2	Books & Stationery	2944.75	SELL016
PROD0269	Ballpoint Pens Blue Box of 50 - v2	Books & Stationery	2989.48	SELL032
PROD0270	Ruled Exercise Books Pack of 10 - v2	Books & Stationery	907.09	SELL038
PROD0271	Stapler Heavy Duty 24/6 - v2	Books & Stationery	1989.71	SELL005
PROD0272	Scientific Calculator Casio FX-991 - v2	Books & Stationery	11096.23	SELL057
PROD0273	A4 Printing Paper 80gsm 500 Sheets - v2	Books & Stationery	1784.35	SELL006
PROD0274	Spiral Notebook Hardcover A5 - v2	Books & Stationery	7846.95	SELL004
PROD0275	Highlighter Set 6 Colours - v2	Books & Stationery	10193.83	SELL032
PROD0276	Geometry Set Complete Maths - v2	Books & Stationery	6563.88	SELL086
PROD0277	English Grammar in Use Murphy - v2	Books & Stationery	9657.13	SELL029
PROD0278	Business Law Nigerian Edition - v2	Books & Stationery	6353.37	SELL081
PROD0279	Sticky Notes Set 4 Colours 400PC - v2	Books & Stationery	962.48	SELL025
PROD0280	Atlas of Nigeria Schools Edition - v2	Books & Stationery	7685.53	SELL027
PROD0001	Samsung Galaxy A54 Smartphone 128GB	Electronics	279610.57	SELL021
PROD0002	Tecno Camon 20 Pro Phone	Electronics	102447.74	SELL086
PROD0003	Infinix Hot 30 Play Smartphone	Electronics	49538.31	SELL078
PROD0004	HP Pavilion 15 Laptop Intel i5	Electronics	39811.79	SELL064
PROD0005	Lenovo IdeaPad 3 Laptop 8GB RAM	Electronics	85978.02	SELL003
PROD0006	JBL Bluetooth Speaker Portable	Electronics	308912.61	SELL021
PROD0007	Anker PowerBank 20000mAh USB-C	Electronics	290642.30	SELL005
PROD0008	TP-Link WiFi Router AC1200	Electronics	121518.49	SELL030
PROD0009	Canon PIXMA Inkjet Printer	Electronics	198883.60	SELL044
PROD0010	Sony WH-1000XM5 Headphones	Electronics	270434.00	SELL072
PROD0011	Apple AirPods Pro 2nd Gen	Electronics	314229.61	SELL066
PROD0012	Samsung 43 inch Smart TV	Electronics	248709.70	SELL057
PROD0013	Hisense 32 inch LED TV	Electronics	337113.25	SELL014
PROD0014	Xiaomi Mi Band 7 Smartwatch	Electronics	289145.53	SELL014
PROD0015	Garmin Forerunner 255 Watch	Electronics	222324.51	SELL047
PROD0016	Seagate 1TB External Hard Drive	Electronics	256280.50	SELL065
PROD0017	Kingston 256GB USB Flash Drive	Electronics	257730.40	SELL083
PROD0018	Logitech MX Master 3 Mouse	Electronics	120439.60	SELL026
PROD0019	Mechanical Keyboard RGB Backlit	Electronics	339524.65	SELL001
PROD0020	Ring Doorbell Video Security Cam	Electronics	293010.61	SELL037
PROD0021	Samsung Galaxy A54 Smartphone 128GB - v2	Electronics	34405.68	SELL054
PROD0022	Tecno Camon 20 Pro Phone - v2	Electronics	222156.94	SELL068
PROD0023	Infinix Hot 30 Play Smartphone - v2	Electronics	276589.43	SELL055
PROD0024	HP Pavilion 15 Laptop Intel i5 - v2	Electronics	321716.92	SELL067
PROD0025	Lenovo IdeaPad 3 Laptop 8GB RAM - v2	Electronics	330590.39	SELL002
PROD0026	JBL Bluetooth Speaker Portable - v2	Electronics	34248.48	SELL022
PROD0027	Anker PowerBank 20000mAh USB-C - v2	Electronics	26206.57	SELL085
PROD0028	TP-Link WiFi Router AC1200 - v2	Electronics	316366.34	SELL081
PROD0029	Canon PIXMA Inkjet Printer - v2	Electronics	149660.33	SELL090
PROD0030	Sony WH-1000XM5 Headphones - v2	Electronics	253935.11	SELL045
PROD0031	Apple AirPods Pro 2nd Gen - v2	Electronics	290316.23	SELL079
PROD0032	Samsung 43 inch Smart TV - v2	Electronics	246601.80	SELL027
PROD0033	Hisense 32 inch LED TV - v2	Electronics	245627.48	SELL084
PROD0034	Xiaomi Mi Band 7 Smartwatch - v2	Electronics	272513.12	SELL011
PROD0035	Garmin Forerunner 255 Watch - v2	Electronics	190414.55	SELL017
PROD0036	Seagate 1TB External Hard Drive - v2	Electronics	78738.41	SELL040
PROD0037	Kingston 256GB USB Flash Drive - v2	Electronics	266180.98	SELL004
PROD0047	Men's Leather Oxford Shoes	Fashion	5512.81	SELL017
PROD0048	Women's Block Heel Sandals	Fashion	10843.12	SELL087
PROD0049	Boys' School Uniform Set	Fashion	27088.42	SELL051
PROD0050	Girls' Party Dress Tulle	Fashion	26917.21	SELL057
PROD0051	Men's Agbada Senator Suit Set	Fashion	33329.69	SELL021
PROD0052	Women's Gele Head Tie Aso-Oke	Fashion	23501.69	SELL059
PROD0053	Unisex Denim Jacket Blue	Fashion	43609.38	SELL068
PROD0054	Men's Polo Shirt Slim Fit	Fashion	31709.48	SELL005
PROD0055	Women's Ankara Maxi Skirt	Fashion	42567.03	SELL016
PROD0056	Kids' Rain Boots Waterproof	Fashion	6299.62	SELL038
PROD0057	Women's Handbag Leather Tote	Fashion	24240.82	SELL040
PROD0058	Men's Wristwatch Stainless Steel	Fashion	14691.81	SELL019
PROD0059	Unisex Baseball Cap Adjustable	Fashion	35594.97	SELL040
PROD0060	Women's Sunglasses UV400	Fashion	10877.79	SELL063
PROD0061	Men's Ankara Print Kaftan XL - v2	Fashion	6821.26	SELL006
PROD0062	Women's Lace Blouse Embroidered - v2	Fashion	22431.17	SELL058
PROD0063	Ladies' Bodycon Dress Floral - v2	Fashion	35488.70	SELL078
PROD0064	Men's Chinos Slim Fit Trouser - v2	Fashion	34644.88	SELL059
PROD0065	Women's High Waist Palazzo Pants - v2	Fashion	30524.10	SELL042
PROD0066	Unisex Sneakers Nike Air Max - v2	Fashion	36291.81	SELL053
PROD0067	Men's Leather Oxford Shoes - v2	Fashion	11627.77	SELL070
PROD0068	Women's Block Heel Sandals - v2	Fashion	43176.46	SELL036
PROD0069	Boys' School Uniform Set - v2	Fashion	39168.98	SELL074
PROD0070	Girls' Party Dress Tulle - v2	Fashion	25905.43	SELL072
PROD0071	Men's Agbada Senator Suit Set - v2	Fashion	9870.56	SELL074
PROD0072	Women's Gele Head Tie Aso-Oke - v2	Fashion	43142.24	SELL061
PROD0073	Unisex Denim Jacket Blue - v2	Fashion	6732.32	SELL024
PROD0074	Men's Polo Shirt Slim Fit - v2	Fashion	13460.87	SELL075
PROD0075	Women's Ankara Maxi Skirt - v2	Fashion	5182.19	SELL042
PROD0076	Kids' Rain Boots Waterproof - v2	Fashion	27116.85	SELL003
PROD0077	Women's Handbag Leather Tote - v2	Fashion	20510.26	SELL068
PROD0078	Men's Wristwatch Stainless Steel - v2	Fashion	18117.48	SELL013
PROD0079	Unisex Baseball Cap Adjustable - v2	Fashion	13912.80	SELL012
PROD0080	Women's Sunglasses UV400 - v2	Fashion	14845.55	SELL022
PROD0081	Non-Stick Cooking Pot Set 5PC	Home & Garden	110991.10	SELL004
PROD0082	Blender Juicer 1.5L 600W	Home & Garden	54346.36	SELL019
PROD0160	Beard Oil & Balm Combo Pack - v2	Beauty & Personal Care	12278.28	SELL043
PROD0083	Pressure Cooker 7 Litre Stainless	Home & Garden	160848.97	SELL016
PROD0084	Standing Fan 18 inch 5-Speed	Home & Garden	37258.14	SELL076
PROD0085	Wall Clock Modern Minimalist	Home & Garden	89243.32	SELL050
PROD0086	Bed Sheet Set Queen Size Cotton	Home & Garden	49202.47	SELL071
PROD0087	Curtain Blackout Window 2 Panels	Home & Garden	12717.02	SELL082
PROD0088	Kitchen Knife Set 7 Piece	Home & Garden	\N	SELL071
PROD0089	Ceramic Dinner Set 24 Piece	Home & Garden	45090.58	SELL017
PROD0090	Wooden Bookshelf 5-Tier	Home & Garden	102715.97	SELL082
PROD0091	Garden Hose 30m Expandable	Home & Garden	141135.80	SELL070
PROD0092	Indoor Plant Pot Set Ceramic	Home & Garden	140982.24	SELL055
PROD0093	LED Desk Lamp USB Rechargeable	Home & Garden	8480.78	SELL080
PROD0094	Microwave Oven 20L Digital	Home & Garden	117897.53	SELL008
PROD0095	Electric Kettle 1.8L Stainless	Home & Garden	49921.23	SELL088
PROD0096	Iron Box Steam 2400W Dry	Home & Garden	179864.29	SELL028
PROD0097	Washing Machine 7KG Front Load	Home & Garden	9141.77	SELL073
PROD0098	Refrigerator 200L Double Door	Home & Garden	54814.26	SELL016
PROD0099	Air Purifier HEPA Filter	Home & Garden	130788.21	SELL056
PROD0100	Doormat Anti-Slip Rubber	Home & Garden	110269.71	SELL041
PROD0101	Non-Stick Cooking Pot Set 5PC - v2	Home & Garden	114695.41	SELL058
PROD0102	Blender Juicer 1.5L 600W - v2	Home & Garden	45021.16	SELL044
PROD0103	Pressure Cooker 7 Litre Stainless - v2	Home & Garden	83304.08	SELL003
PROD0104	Standing Fan 18 inch 5-Speed - v2	Home & Garden	\N	SELL061
PROD0105	Wall Clock Modern Minimalist - v2	Home & Garden	162358.65	SELL053
PROD0106	Bed Sheet Set Queen Size Cotton - v2	Home & Garden	137481.28	SELL084
PROD0107	Curtain Blackout Window 2 Panels - v2	Home & Garden	97418.23	SELL086
PROD0108	Kitchen Knife Set 7 Piece - v2	Home & Garden	121332.02	SELL049
PROD0109	Ceramic Dinner Set 24 Piece - v2	Home & Garden	70228.44	SELL090
PROD0038	Logitech MX Master 3 Mouse - v2	Electronics	88262.22	SELL055
PROD0039	Mechanical Keyboard RGB Backlit - v2	Electronics	257535.23	SELL034
PROD0040	Ring Doorbell Video Security Cam - v2	Electronics	47715.49	SELL016
PROD0041	Men's Ankara Print Kaftan XL	Fashion	14461.31	SELL059
PROD0042	Women's Lace Blouse Embroidered	Fashion	44258.35	SELL075
PROD0043	Ladies' Bodycon Dress Floral	Fashion	16739.67	SELL074
PROD0044	Men's Chinos Slim Fit Trouser	Fashion	32574.27	SELL032
PROD0045	Women's High Waist Palazzo Pants	Fashion	15761.34	SELL047
PROD0046	Unisex Sneakers Nike Air Max	Fashion	5762.47	SELL053
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reviews (review_id, product_id, customer_id, order_id, rating, review_date) FROM stdin;
REV00001	PROD0247	CUST0002	ORD00002	4	2024-09-21
REV00002	PROD0247	CUST0003	ORD00004	2	2023-12-22
REV00003	PROD0060	CUST0004	ORD00009	4	2024-05-12
REV00004	PROD0036	CUST0004	ORD00012	4	2024-06-03
REV00005	PROD0069	CUST0004	ORD00013	1	2024-12-31
REV00006	PROD0031	CUST0004	ORD00014	4	2024-02-22
REV00007	PROD0267	CUST0004	ORD00017	5	2024-01-16
REV00008	PROD0244	CUST0008	ORD00024	4	2023-09-28
REV00009	PROD0189	CUST0008	ORD00026	4	2023-11-08
REV00010	PROD0114	CUST0008	ORD00027	2	2024-11-16
REV00011	PROD0075	CUST0009	ORD00028	5	2023-10-14
REV00012	PROD0053	CUST0012	ORD00033	5	2024-06-29
REV00013	PROD0275	CUST0014	ORD00038	4	2024-11-30
REV00014	PROD0066	CUST0014	ORD00040	3	2024-08-21
REV00015	PROD0275	CUST0017	ORD00045	3	2023-07-17
REV00016	PROD0034	CUST0018	ORD00047	5	2024-01-04
REV00017	PROD0058	CUST0022	ORD00057	3	2024-10-23
REV00018	PROD0056	CUST0024	ORD00062	1	2024-08-04
REV00019	PROD0219	CUST0029	ORD00070	1	2024-07-15
REV00020	PROD0021	CUST0031	ORD00082	2	2024-07-17
REV00021	PROD0108	CUST0031	ORD00083	4	2024-07-16
REV00022	PROD0197	CUST0034	ORD00094	4	2024-04-16
REV00023	PROD0171	CUST0034	ORD00095	3	2023-11-09
REV00024	PROD0147	CUST0034	ORD00097	3	2024-06-06
REV00025	PROD0140	CUST0040	ORD00107	4	2024-11-06
REV00026	PROD0172	CUST0040	ORD00109	4	2024-08-20
REV00027	PROD0104	CUST0040	ORD00110	3	2023-10-02
REV00028	PROD0119	CUST0040	ORD00114	3	2023-07-12
REV00029	PROD0152	CUST0041	ORD00118	5	2023-05-24
REV00030	PROD0243	CUST0041	ORD00119	3	2024-02-18
REV00031	PROD0192	CUST0041	ORD00121	5	2023-06-26
REV00032	PROD0206	CUST0044	ORD00123	4	2024-04-06
REV00033	PROD0075	CUST0044	ORD00124	1	2024-10-04
REV00034	PROD0232	CUST0044	ORD00126	2	2024-03-15
REV00035	PROD0002	CUST0046	ORD00130	5	2024-06-09
REV00036	PROD0190	CUST0047	ORD00132	3	2024-03-23
REV00037	PROD0004	CUST0049	ORD00138	5	2024-07-22
REV00038	PROD0145	CUST0052	ORD00146	3	2023-11-25
REV00039	PROD0082	CUST0054	ORD00149	5	2024-03-03
REV00040	PROD0016	CUST0055	ORD00150	1	2023-09-02
REV00041	PROD0160	CUST0058	ORD00152	3	2024-11-27
REV00042	PROD0166	CUST0058	ORD00155	1	2024-08-29
REV00043	PROD0034	CUST0058	ORD00157	5	2024-03-22
REV00044	PROD0232	CUST0059	ORD00159	5	2024-11-05
REV00045	PROD0009	CUST0059	ORD00161	5	2024-08-03
REV00046	PROD0195	CUST0061	ORD00165	4	2024-07-24
REV00047	PROD0212	CUST0061	ORD00166	4	2024-12-12
REV00048	PROD0097	CUST0061	ORD00170	5	2024-08-13
REV00049	PROD0196	CUST0062	ORD00173	3	2024-05-25
REV00050	PROD0088	CUST0063	ORD00179	4	2024-04-12
REV00051	PROD0185	CUST0064	ORD00183	5	2024-11-27
REV00052	PROD0022	CUST0065	ORD00184	5	2024-12-25
REV00053	PROD0001	CUST0066	ORD00187	2	2024-09-10
REV00054	PROD0155	CUST0067	ORD00190	5	2024-12-18
REV00055	PROD0266	CUST0069	ORD00194	4	2024-12-31
REV00056	PROD0028	CUST0069	ORD00196	5	2024-12-28
REV00057	PROD0035	CUST0071	ORD00197	3	2023-10-07
REV00058	PROD0093	CUST0072	ORD00205	5	2024-08-23
REV00059	PROD0130	CUST0075	ORD00208	4	2024-11-05
REV00060	PROD0037	CUST0076	ORD00210	5	2024-12-31
REV00061	PROD0169	CUST0077	ORD00215	4	2024-10-11
REV00062	PROD0121	CUST0081	ORD00225	4	2024-03-10
REV00063	PROD0278	CUST0081	ORD00228	4	2024-10-16
REV00064	PROD0148	CUST0081	ORD00230	5	2024-12-02
REV00065	PROD0186	CUST0082	ORD00232	5	2024-06-09
REV00066	PROD0226	CUST0083	ORD00234	5	2024-10-22
REV00067	PROD0209	CUST0083	ORD00239	5	2024-08-14
REV00068	PROD0109	CUST0084	ORD00240	4	2024-10-05
REV00069	PROD0276	CUST0087	ORD00245	4	2024-01-25
REV00070	PROD0161	CUST0090	ORD00254	3	2024-06-02
REV00071	PROD0136	CUST0093	ORD00260	5	2024-01-02
REV00072	PROD0223	CUST0093	ORD00261	2	2024-01-29
REV00073	PROD0048	CUST0099	ORD00274	4	2023-07-26
REV00074	PROD0009	CUST0099	ORD00275	1	2024-08-20
REV00075	PROD0119	CUST0100	ORD00276	5	2024-06-21
REV00076	PROD0160	CUST0100	ORD00278	4	2024-12-16
REV00077	PROD0269	CUST0100	ORD00281	3	2024-07-03
REV00078	PROD0235	CUST0101	ORD00285	3	2023-05-08
REV00079	PROD0001	CUST0102	ORD00289	5	2023-10-06
REV00080	PROD0268	CUST0102	ORD00291	4	2024-04-15
REV00081	PROD0008	CUST0105	ORD00298	4	2023-05-29
REV00082	PROD0180	CUST0105	ORD00300	4	2024-07-03
REV00083	PROD0096	CUST0106	ORD00301	4	2024-06-05
REV00084	PROD0195	CUST0107	ORD00302	3	2024-10-21
REV00085	PROD0258	CUST0107	ORD00305	3	2024-12-18
REV00086	PROD0194	CUST0107	ORD00307	3	2024-10-11
REV00087	PROD0105	CUST0110	ORD00313	4	2024-09-29
REV00088	PROD0202	CUST0111	ORD00314	4	2024-11-22
REV00089	PROD0278	CUST0114	ORD00325	4	2024-11-22
REV00090	PROD0125	CUST0116	ORD00330	1	2024-11-29
REV00091	PROD0033	CUST0116	ORD00333	4	2024-03-13
REV00092	PROD0207	CUST0117	ORD00335	5	2024-12-05
REV00093	PROD0082	CUST0119	ORD00338	2	2023-11-16
REV00094	PROD0274	CUST0121	ORD00347	4	2024-05-25
REV00095	PROD0156	CUST0123	ORD00353	5	2024-03-21
REV00096	PROD0101	CUST0123	ORD00360	1	2024-06-20
REV00097	PROD0141	CUST0124	ORD00363	5	2024-12-24
REV00098	PROD0214	CUST0126	ORD00367	5	2024-04-09
REV00099	PROD0158	CUST0126	ORD00368	3	2024-06-27
REV00100	PROD0193	CUST0127	ORD00372	4	2024-11-22
REV00101	PROD0112	CUST0129	ORD00385	5	2024-12-14
REV00102	PROD0106	CUST0129	ORD00386	2	2024-12-08
REV00103	PROD0182	CUST0130	ORD00389	5	2024-11-30
REV00104	PROD0242	CUST0130	ORD00390	5	2024-12-21
REV00105	PROD0266	CUST0130	ORD00391	4	2024-10-15
REV00106	PROD0241	CUST0131	ORD00394	5	2024-10-03
REV00107	PROD0087	CUST0131	ORD00395	4	2024-06-10
REV00108	PROD0154	CUST0134	ORD00409	4	2024-02-04
REV00109	PROD0153	CUST0135	ORD00413	5	2024-11-11
REV00110	PROD0129	CUST0137	ORD00416	4	2024-11-10
REV00111	PROD0050	CUST0139	ORD00433	2	2023-06-21
REV00112	PROD0043	CUST0145	ORD00450	5	2024-11-16
REV00113	PROD0261	CUST0145	ORD00453	5	2024-11-17
REV00114	PROD0190	CUST0148	ORD00460	5	2024-11-20
REV00115	PROD0185	CUST0149	ORD00468	5	2024-06-25
REV00116	PROD0208	CUST0149	ORD00470	3	2024-06-27
REV00117	PROD0212	CUST0150	ORD00472	4	2024-05-31
REV00118	PROD0052	CUST0152	ORD00477	4	2024-07-01
REV00119	PROD0241	CUST0152	ORD00478	3	2024-02-15
REV00120	PROD0182	CUST0152	ORD00481	4	2024-10-27
REV00121	PROD0013	CUST0152	ORD00482	5	2024-04-02
REV00122	PROD0007	CUST0156	ORD00494	2	2024-12-26
REV00123	PROD0088	CUST0157	ORD00496	4	2024-09-09
REV00124	PROD0238	CUST0157	ORD00497	1	2024-11-18
REV00125	PROD0143	CUST0158	ORD00500	4	2024-01-11
REV00126	PROD0252	CUST0158	ORD00502	3	2024-07-28
REV00127	PROD0100	CUST0159	ORD00505	3	2024-10-02
REV00128	PROD0049	CUST0159	ORD00506	3	2024-01-10
REV00129	PROD0009	CUST0162	ORD00513	5	2024-11-23
REV00130	PROD0106	CUST0163	ORD00525	3	2024-09-08
REV00131	PROD0098	CUST0165	ORD00527	3	2023-06-21
REV00132	PROD0079	CUST0169	ORD00529	4	2024-01-12
REV00133	PROD0007	CUST0169	ORD00530	5	2023-05-11
REV00134	PROD0184	CUST0170	ORD00535	3	2024-11-24
REV00135	PROD0060	CUST0171	ORD00538	1	2023-12-25
REV00136	PROD0184	CUST0171	ORD00542	4	2024-12-09
REV00137	PROD0233	CUST0173	ORD00545	1	2024-11-14
REV00138	PROD0232	CUST0174	ORD00548	3	2024-12-24
REV00139	PROD0040	CUST0174	ORD00549	3	2024-12-19
REV00140	PROD0044	CUST0175	ORD00563	5	2024-12-24
REV00141	PROD0136	CUST0178	ORD00567	4	2024-04-11
REV00142	PROD0201	CUST0178	ORD00570	5	2024-05-08
REV00143	PROD0036	CUST0181	ORD00573	3	2024-06-13
REV00144	PROD0198	CUST0183	ORD00578	3	2024-02-06
REV00145	PROD0269	CUST0183	ORD00580	4	2024-03-24
REV00146	PROD0207	CUST0183	ORD00581	2	2024-01-25
REV00147	PROD0252	CUST0183	ORD00583	4	2023-07-19
REV00148	PROD0096	CUST0185	ORD00586	4	2024-11-17
REV00149	PROD0121	CUST0187	ORD00587	3	2024-11-29
REV00150	PROD0196	CUST0188	ORD00593	1	2024-05-14
REV00151	PROD0267	CUST0190	ORD00598	4	2024-12-19
REV00152	PROD0260	CUST0190	ORD00600	4	2024-12-10
REV00153	PROD0078	CUST0190	ORD00602	1	2024-11-01
REV00154	PROD0161	CUST0193	ORD00608	5	2023-10-04
REV00155	PROD0270	CUST0196	ORD00615	5	2024-10-12
REV00156	PROD0255	CUST0196	ORD00616	5	2024-02-11
REV00157	PROD0038	CUST0198	ORD00619	5	2024-11-13
REV00158	PROD0143	CUST0198	ORD00624	2	2024-11-25
REV00159	PROD0002	CUST0198	ORD00625	2	2024-12-25
REV00160	PROD0098	CUST0200	ORD00639	1	2024-06-12
REV00161	PROD0049	CUST0203	ORD00648	5	2024-12-02
REV00162	PROD0127	CUST0203	ORD00649	4	2024-09-12
REV00163	PROD0096	CUST0207	ORD00665	5	2024-11-23
REV00164	PROD0117	CUST0207	ORD00667	2	2024-04-23
REV00165	PROD0023	CUST0207	ORD00668	2	2023-07-28
REV00166	PROD0004	CUST0209	ORD00671	4	2024-04-09
REV00167	PROD0154	CUST0209	ORD00675	5	2024-02-08
REV00168	PROD0213	CUST0209	ORD00677	4	2024-02-02
REV00169	PROD0058	CUST0210	ORD00681	1	2024-11-03
REV00170	PROD0016	CUST0211	ORD00685	4	2024-01-14
REV00171	PROD0192	CUST0212	ORD00699	5	2024-09-08
REV00172	PROD0019	CUST0216	ORD00712	2	2024-10-02
REV00173	PROD0109	CUST0217	ORD00716	3	2024-09-05
REV00174	PROD0074	CUST0217	ORD00718	3	2024-09-25
REV00176	PROD0012	CUST0220	ORD00726	4	2024-08-28
REV00177	PROD0223	CUST0220	ORD00730	4	2023-11-21
REV00178	PROD0008	CUST0220	ORD00731	4	2024-07-05
REV00179	PROD0268	CUST0221	ORD00736	5	2024-01-29
REV00180	PROD0030	CUST0221	ORD00737	4	2024-09-08
REV00181	PROD0088	CUST0222	ORD00740	5	2024-01-16
REV00182	PROD0193	CUST0223	ORD00742	2	2024-05-08
REV00183	PROD0087	CUST0223	ORD00743	2	2024-12-31
REV00184	PROD0082	CUST0223	ORD00751	1	2023-12-08
REV00185	PROD0047	CUST0225	ORD00757	4	2024-08-03
REV00186	PROD0094	CUST0227	ORD00763	4	2024-12-24
REV00187	PROD0157	CUST0228	ORD00768	4	2024-12-31
REV00188	PROD0046	CUST0228	ORD00770	3	2024-10-08
REV00189	PROD0110	CUST0229	ORD00771	3	2024-03-07
REV00190	PROD0182	CUST0229	ORD00773	2	2024-03-09
REV00191	PROD0119	CUST0231	ORD00779	4	2024-05-07
REV00192	PROD0213	CUST0232	ORD00786	4	2024-10-26
REV00193	PROD0240	CUST0236	ORD00796	4	2024-06-21
REV00194	PROD0266	CUST0236	ORD00797	4	2024-06-30
REV00195	PROD0013	CUST0238	ORD00802	4	2024-12-06
REV00196	PROD0213	CUST0238	ORD00803	5	2024-12-31
REV00197	PROD0059	CUST0238	ORD00805	4	2024-12-31
REV00198	PROD0093	CUST0238	ORD00806	5	2024-12-07
REV00199	PROD0271	CUST0238	ORD00807	4	2024-12-31
REV00200	PROD0155	CUST0238	ORD00808	4	2024-12-22
REV00201	PROD0203	CUST0238	ORD00809	5	2024-12-29
REV00202	PROD0277	CUST0244	ORD00812	5	2024-12-18
REV00203	PROD0086	CUST0244	ORD00814	4	2024-12-22
REV00204	PROD0065	CUST0245	ORD00815	2	2024-05-26
REV00205	PROD0114	CUST0245	ORD00816	5	2024-06-10
REV00206	PROD0023	CUST0245	ORD00819	5	2024-12-12
REV00207	PROD0231	CUST0246	ORD00820	3	2023-05-25
REV00208	PROD0272	CUST0247	ORD00823	5	2024-02-28
REV00209	PROD0223	CUST0247	ORD00824	2	2024-08-18
REV00210	PROD0016	CUST0248	ORD00825	5	2024-06-18
REV00211	PROD0071	CUST0248	ORD00827	4	2024-01-16
REV00212	PROD0257	CUST0249	ORD00830	3	2024-11-10
REV00213	PROD0090	CUST0250	ORD00833	5	2024-01-09
REV00214	PROD0110	CUST0250	ORD00835	4	2024-04-30
REV00215	PROD0171	CUST0252	ORD00846	4	2024-05-21
REV00216	PROD0174	CUST0253	ORD00849	3	2024-05-31
REV00217	PROD0022	CUST0254	ORD00851	1	2024-05-01
REV00218	PROD0184	CUST0254	ORD00853	4	2024-02-12
REV00219	PROD0206	CUST0254	ORD00854	3	2024-01-07
REV00220	PROD0220	CUST0254	ORD00855	2	2024-06-19
REV00221	PROD0034	CUST0254	ORD00856	4	2024-10-29
REV00222	PROD0140	CUST0254	ORD00857	4	2024-11-27
REV00223	PROD0276	CUST0255	ORD00862	4	2023-12-30
REV00224	PROD0167	CUST0259	ORD00877	4	2024-09-24
REV00225	PROD0170	CUST0260	ORD00882	2	2023-11-02
REV00226	PROD0185	CUST0261	ORD00884	5	2024-06-06
REV00227	PROD0112	CUST0261	ORD00885	4	2024-09-22
REV00228	PROD0193	CUST0261	ORD00888	1	2024-07-27
REV00229	PROD0201	CUST0261	ORD00890	3	2023-11-19
REV00230	PROD0207	CUST0264	ORD00895	4	2023-10-18
REV00231	PROD0008	CUST0267	ORD00898	3	2024-09-20
REV00232	PROD0249	CUST0267	ORD00901	4	2024-08-28
REV00233	PROD0122	CUST0268	ORD00902	3	2024-11-19
REV00234	PROD0164	CUST0272	ORD00908	3	2024-12-31
REV00235	PROD0010	CUST0272	ORD00909	3	2024-11-09
REV00236	PROD0258	CUST0272	ORD00910	4	2024-12-25
REV00237	PROD0265	CUST0272	ORD00911	5	2024-11-27
REV00238	PROD0151	CUST0273	ORD00917	1	2024-10-18
REV00239	PROD0132	CUST0273	ORD00918	1	2024-09-26
REV00240	PROD0277	CUST0275	ORD00926	5	2024-07-08
REV00241	PROD0043	CUST0275	ORD00929	1	2024-08-10
REV00242	PROD0227	CUST0275	ORD00931	4	2024-10-01
REV00243	PROD0179	CUST0277	ORD00940	3	2024-01-12
REV00244	PROD0055	CUST0277	ORD00941	5	2024-09-05
REV00245	PROD0228	CUST0277	ORD00944	2	2024-04-12
REV00246	PROD0231	CUST0277	ORD00945	2	2023-08-11
REV00247	PROD0181	CUST0278	ORD00948	3	2023-05-16
REV00248	PROD0160	CUST0280	ORD00952	1	2024-10-26
REV00249	PROD0028	CUST0280	ORD00953	4	2024-07-02
REV00250	PROD0080	CUST0280	ORD00954	5	2024-10-13
REV00251	PROD0066	CUST0280	ORD00957	1	2024-07-05
REV00252	PROD0037	CUST0280	ORD00960	3	2024-10-31
REV00253	PROD0030	CUST0281	ORD00972	3	2024-11-13
REV00254	PROD0261	CUST0285	ORD00977	5	2024-04-08
REV00255	PROD0254	CUST0288	ORD00982	5	2024-07-16
REV00256	PROD0144	CUST0289	ORD00983	2	2024-11-11
REV00257	PROD0256	CUST0289	ORD00984	5	2024-07-30
REV00258	PROD0112	CUST0290	ORD00989	4	2024-01-30
REV00259	PROD0091	CUST0290	ORD00990	5	2023-10-15
REV00260	PROD0255	CUST0291	ORD00994	5	2024-12-06
REV00261	PROD0094	CUST0291	ORD00995	5	2024-12-08
REV00262	PROD0073	CUST0292	ORD00997	4	2023-11-13
REV00263	PROD0063	CUST0292	ORD01000	3	2023-07-10
REV00264	PROD0176	CUST0293	ORD01003	5	2024-03-04
REV00265	PROD0165	CUST0293	ORD01004	4	2024-12-31
REV00266	PROD0087	CUST0293	ORD01005	2	2023-04-26
REV00267	PROD0231	CUST0296	ORD01014	4	2024-11-09
REV00268	PROD0126	CUST0297	ORD01015	4	2023-05-26
REV00269	PROD0005	CUST0297	ORD01017	3	2023-11-15
REV00270	PROD0125	CUST0298	ORD01020	5	2024-02-07
REV00271	PROD0246	CUST0299	ORD01023	5	2024-11-15
REV00272	PROD0190	CUST0299	ORD01024	2	2024-12-15
REV00273	PROD0237	CUST0302	ORD01026	4	2024-10-11
REV00274	PROD0150	CUST0302	ORD01030	4	2024-06-15
REV00275	PROD0102	CUST0304	ORD01037	4	2023-11-07
REV00276	PROD0035	CUST0304	ORD01041	3	2024-10-18
REV00277	PROD0076	CUST0305	ORD01045	5	2024-09-14
REV00278	PROD0058	CUST0307	ORD01052	2	2024-11-03
REV00279	PROD0069	CUST0310	ORD01058	4	2024-12-24
REV00280	PROD0166	CUST0310	ORD01059	5	2024-12-31
REV00281	PROD0079	CUST0312	ORD01060	4	2024-04-08
REV00282	PROD0021	CUST0312	ORD01062	3	2024-06-26
REV00283	PROD0145	CUST0313	ORD01067	4	2024-12-31
REV00284	PROD0050	CUST0316	ORD01072	4	2024-11-01
REV00285	PROD0173	CUST0317	ORD01076	4	2023-12-31
REV00286	PROD0039	CUST0317	ORD01077	4	2024-12-31
REV00287	PROD0277	CUST0317	ORD01078	4	2023-11-20
REV00288	PROD0259	CUST0320	ORD01088	4	2024-12-31
REV00289	PROD0207	CUST0324	ORD01094	1	2024-07-06
REV00290	PROD0063	CUST0325	ORD01097	4	2024-05-11
REV00291	PROD0029	CUST0329	ORD01103	4	2024-12-08
REV00292	PROD0246	CUST0332	ORD01117	5	2023-03-30
REV00293	PROD0210	CUST0332	ORD01118	5	2024-02-02
REV00294	PROD0169	CUST0334	ORD01123	5	2023-10-13
REV00295	PROD0114	CUST0335	ORD01127	4	2024-06-20
REV00296	PROD0162	CUST0336	ORD01129	3	2024-07-31
REV00297	PROD0255	CUST0338	ORD01131	5	2024-09-03
REV00298	PROD0267	CUST0343	ORD01136	4	2024-10-15
REV00299	PROD0136	CUST0343	ORD01138	5	2024-07-18
REV00300	PROD0217	CUST0343	ORD01139	2	2024-07-21
REV00301	PROD0163	CUST0343	ORD01140	1	2024-08-23
REV00302	PROD0169	CUST0344	ORD01142	2	2024-12-31
REV00303	PROD0114	CUST0345	ORD01144	5	2024-06-18
REV00304	PROD0015	CUST0346	ORD01150	4	2024-07-27
REV00305	PROD0018	CUST0347	ORD01156	2	2024-07-11
REV00306	PROD0047	CUST0350	ORD01163	5	2023-10-17
REV00307	PROD0066	CUST0350	ORD01167	2	2023-09-12
REV00308	PROD0005	CUST0350	ORD01169	4	2024-05-12
REV00309	PROD0129	CUST0352	ORD01179	4	2024-05-24
REV00310	PROD0045	CUST0353	ORD01186	5	2024-03-28
REV00311	PROD0180	CUST0353	ORD01187	5	2024-05-12
REV00312	PROD0215	CUST0353	ORD01189	5	2024-06-28
REV00313	PROD0248	CUST0356	ORD01194	5	2023-08-29
REV00314	PROD0130	CUST0357	ORD01196	4	2024-05-07
REV00315	PROD0108	CUST0359	ORD01204	5	2024-11-14
REV00316	PROD0182	CUST0359	ORD01205	1	2024-12-23
REV00317	PROD0241	CUST0361	ORD01208	5	2024-03-28
REV00318	PROD0055	CUST0361	ORD01210	2	2024-05-28
REV00319	PROD0203	CUST0363	ORD01212	2	2024-12-20
REV00320	PROD0005	CUST0363	ORD01216	5	2024-12-06
REV00321	PROD0253	CUST0366	ORD01222	4	2023-06-11
REV00322	PROD0186	CUST0366	ORD01225	1	2024-05-24
REV00323	PROD0165	CUST0370	ORD01234	5	2024-12-25
REV00324	PROD0219	CUST0370	ORD01238	3	2024-09-15
REV00325	PROD0144	CUST0370	ORD01243	3	2024-09-25
REV00326	PROD0012	CUST0371	ORD01249	5	2024-02-10
REV00327	PROD0143	CUST0377	ORD01258	3	2024-04-24
REV00328	PROD0118	CUST0377	ORD01260	5	2024-11-02
REV00329	PROD0078	CUST0377	ORD01261	3	2024-08-08
REV00330	PROD0054	CUST0378	ORD01264	4	2024-04-02
REV00331	PROD0253	CUST0379	ORD01267	3	2024-01-05
REV00332	PROD0111	CUST0381	ORD01272	4	2024-04-28
REV00333	PROD0180	CUST0381	ORD01273	5	2024-06-20
REV00334	PROD0210	CUST0384	ORD01276	2	2024-03-20
REV00335	PROD0205	CUST0385	ORD01280	3	2024-08-06
REV00336	PROD0071	CUST0386	ORD01284	5	2024-12-25
REV00337	PROD0228	CUST0386	ORD01287	4	2023-09-26
REV00338	PROD0017	CUST0388	ORD01292	3	2024-07-02
REV00339	PROD0232	CUST0389	ORD01294	4	2024-09-01
REV00340	PROD0011	CUST0391	ORD01297	4	2024-06-10
REV00341	PROD0227	CUST0392	ORD01304	5	2024-10-20
REV00342	PROD0252	CUST0392	ORD01306	3	2024-11-20
REV00343	PROD0175	CUST0392	ORD01309	4	2024-07-30
REV00344	PROD0143	CUST0393	ORD01310	3	2024-10-08
REV00345	PROD0022	CUST0394	ORD01313	5	2023-09-20
REV00346	PROD0077	CUST0394	ORD01314	4	2024-11-22
REV00347	PROD0196	CUST0394	ORD01319	4	2024-02-15
REV00348	PROD0193	CUST0394	ORD01322	4	2024-09-01
REV00349	PROD0102	CUST0396	ORD01326	5	2024-06-07
REV00350	PROD0165	CUST0396	ORD01330	1	2024-05-16
REV00351	PROD0268	CUST0398	ORD01331	4	2023-06-01
REV00352	PROD0279	CUST0398	ORD01334	5	2023-06-01
REV00353	PROD0082	CUST0398	ORD01335	4	2024-11-22
REV00354	PROD0066	CUST0401	ORD01345	2	2024-12-14
REV00355	PROD0086	CUST0402	ORD01347	5	2024-05-01
REV00356	PROD0146	CUST0402	ORD01350	5	2024-06-06
REV00357	PROD0105	CUST0403	ORD01354	5	2024-08-16
REV00358	PROD0258	CUST0403	ORD01355	4	2024-05-14
REV00359	PROD0022	CUST0407	ORD01364	5	2024-09-01
REV00360	PROD0005	CUST0407	ORD01365	3	2023-12-20
REV00361	PROD0188	CUST0407	ORD01367	4	2024-12-06
REV00362	PROD0238	CUST0407	ORD01368	5	2024-07-07
REV00363	PROD0062	CUST0407	ORD01370	3	2024-06-05
REV00364	PROD0217	CUST0408	ORD01372	4	2024-06-11
REV00365	PROD0118	CUST0409	ORD01374	3	2024-12-16
REV00366	PROD0269	CUST0409	ORD01377	4	2024-12-11
REV00367	PROD0203	CUST0410	ORD01382	4	2024-02-02
REV00368	PROD0018	CUST0412	ORD01389	1	2023-11-17
REV00369	PROD0122	CUST0412	ORD01390	4	2024-11-24
REV00370	PROD0148	CUST0412	ORD01391	4	2024-03-20
REV00371	PROD0081	CUST0414	ORD01397	1	2024-11-11
REV00372	PROD0166	CUST0416	ORD01405	3	2023-11-07
REV00373	PROD0027	CUST0417	ORD01407	1	2024-10-05
REV00374	PROD0129	CUST0418	ORD01416	4	2024-07-28
REV00375	PROD0072	CUST0419	ORD01417	5	2023-09-12
REV00376	PROD0185	CUST0419	ORD01421	3	2024-01-17
REV00377	PROD0002	CUST0419	ORD01422	1	2024-11-15
REV00378	PROD0240	CUST0421	ORD01423	4	2024-04-28
REV00379	PROD0216	CUST0421	ORD01424	3	2024-08-04
REV00380	PROD0140	CUST0421	ORD01426	4	2024-08-01
REV00381	PROD0227	CUST0421	ORD01430	3	2024-01-18
REV00382	PROD0056	CUST0422	ORD01431	5	2024-05-10
REV00383	PROD0119	CUST0422	ORD01434	4	2023-11-09
REV00384	PROD0116	CUST0422	ORD01436	4	2024-04-09
REV00385	PROD0166	CUST0422	ORD01437	3	2024-10-22
REV00386	PROD0114	CUST0423	ORD01438	5	2023-12-16
REV00387	PROD0061	CUST0425	ORD01443	5	2024-08-09
REV00388	PROD0046	CUST0426	ORD01445	3	2024-12-14
REV00389	PROD0033	CUST0427	ORD01449	1	2024-11-26
REV00390	PROD0147	CUST0427	ORD01450	4	2023-08-23
REV00391	PROD0016	CUST0427	ORD01453	5	2023-07-29
REV00392	PROD0197	CUST0429	ORD01460	5	2024-06-13
REV00393	PROD0131	CUST0429	ORD01463	5	2024-06-20
REV00394	PROD0185	CUST0430	ORD01464	5	2024-08-23
REV00395	PROD0102	CUST0430	ORD01465	5	2024-09-06
REV00396	PROD0100	CUST0434	ORD01472	4	2024-12-31
REV00397	PROD0039	CUST0435	ORD01474	4	2023-04-13
REV00398	PROD0048	CUST0437	ORD01482	5	2024-08-28
REV00399	PROD0101	CUST0440	ORD01493	4	2024-11-22
REV00400	PROD0018	CUST0444	ORD01498	4	2023-10-09
REV00401	PROD0020	CUST0444	ORD01500	5	2024-03-05
REV00402	PROD0164	CUST0445	ORD01503	5	2024-03-03
REV00403	PROD0166	CUST0445	ORD01504	4	2023-07-17
REV00404	PROD0110	CUST0446	ORD01507	2	2024-05-05
REV00405	PROD0123	CUST0446	ORD01508	3	2024-11-07
REV00406	PROD0255	CUST0446	ORD01511	4	2024-06-17
REV00407	PROD0043	CUST0449	ORD01516	5	2023-06-13
REV00408	PROD0117	CUST0451	ORD01527	3	2024-03-06
REV00409	PROD0129	CUST0451	ORD01528	5	2023-12-13
REV00410	PROD0115	CUST0452	ORD01532	4	2023-09-26
REV00411	PROD0144	CUST0452	ORD01533	4	2023-08-31
REV00412	PROD0110	CUST0453	ORD01539	5	2024-11-06
REV00413	PROD0119	CUST0455	ORD01544	4	2024-10-08
REV00414	PROD0144	CUST0455	ORD01547	4	2024-10-23
REV00415	PROD0220	CUST0458	ORD01550	3	2024-11-30
REV00416	PROD0177	CUST0460	ORD01561	4	2024-12-29
REV00417	PROD0111	CUST0461	ORD01566	1	2024-12-12
REV00418	PROD0101	CUST0462	ORD01571	1	2024-08-05
REV00419	PROD0071	CUST0462	ORD01572	1	2024-12-19
REV00420	PROD0130	CUST0462	ORD01573	2	2024-12-19
REV00421	PROD0032	CUST0464	ORD01579	5	2023-08-02
REV00422	PROD0057	CUST0464	ORD01582	3	2023-07-04
REV00423	PROD0179	CUST0468	ORD01586	5	2024-12-12
REV00424	PROD0261	CUST0468	ORD01587	5	2024-12-12
REV00425	PROD0035	CUST0468	ORD01588	4	2024-12-03
REV00426	PROD0197	CUST0469	ORD01590	4	2024-05-16
REV00427	PROD0241	CUST0472	ORD01596	4	2023-12-26
REV00428	PROD0207	CUST0472	ORD01597	5	2024-07-28
REV00429	PROD0133	CUST0473	ORD01600	2	2024-12-27
REV00430	PROD0259	CUST0475	ORD01605	2	2024-12-14
REV00431	PROD0214	CUST0478	ORD01612	5	2024-12-31
REV00432	PROD0204	CUST0479	ORD01617	5	2024-12-09
REV00433	PROD0006	CUST0480	ORD01619	5	2024-06-19
REV00434	PROD0001	CUST0481	ORD01620	4	2024-04-10
REV00435	PROD0097	CUST0481	ORD01622	5	2024-07-31
REV00436	PROD0226	CUST0481	ORD01623	5	2023-06-09
REV00437	PROD0072	CUST0481	ORD01624	3	2024-04-28
REV00438	PROD0059	CUST0481	ORD01625	1	2024-06-28
REV00439	PROD0073	CUST0481	ORD01627	4	2024-10-09
REV00440	PROD0097	CUST0481	ORD01629	5	2023-06-06
REV00441	PROD0269	CUST0482	ORD01636	5	2024-02-18
REV00442	PROD0238	CUST0482	ORD01639	1	2024-10-20
REV00443	PROD0240	CUST0483	ORD01640	1	2024-08-22
REV00444	PROD0003	CUST0486	ORD01642	3	2023-12-20
REV00445	PROD0233	CUST0491	ORD01647	5	2024-05-23
REV00446	PROD0198	CUST0491	ORD01648	5	2024-05-30
REV00447	PROD0055	CUST0494	ORD01654	4	2024-06-24
REV00448	PROD0033	CUST0494	ORD01655	3	2024-06-23
REV00449	PROD0112	CUST0495	ORD01660	5	2024-12-06
REV00450	PROD0110	CUST0497	ORD01663	5	2024-09-24
REV00451	PROD0025	CUST0497	ORD01664	4	2024-05-29
REV00452	PROD0002	CUST0497	ORD01667	1	2024-05-07
REV00453	PROD0072	CUST0502	ORD01676	2	2024-11-27
REV00454	PROD0129	CUST0503	ORD01680	5	2024-10-05
REV00455	PROD0177	CUST0503	ORD01682	4	2024-03-30
REV00456	PROD0075	CUST0504	ORD01683	2	2024-02-01
REV00457	PROD0045	CUST0505	ORD01684	4	2024-09-30
REV00459	PROD0019	CUST0507	ORD01693	5	2024-07-31
REV00460	PROD0152	CUST0507	ORD01694	5	2024-06-22
REV00461	PROD0133	CUST0511	ORD01698	4	2024-09-25
REV00462	PROD0112	CUST0511	ORD01699	3	2024-10-04
REV00463	PROD0214	CUST0513	ORD01708	3	2024-12-08
REV00464	PROD0099	CUST0513	ORD01709	3	2024-12-07
REV00465	PROD0029	CUST0513	ORD01710	2	2024-12-07
REV00466	PROD0137	CUST0513	ORD01711	4	2024-12-06
REV00467	PROD0196	CUST0513	ORD01712	5	2024-12-14
REV00468	PROD0169	CUST0518	ORD01720	4	2024-04-30
REV00469	PROD0012	CUST0518	ORD01723	5	2024-02-22
REV00470	PROD0167	CUST0518	ORD01725	3	2024-08-31
REV00471	PROD0044	CUST0519	ORD01731	4	2024-08-05
REV00472	PROD0044	CUST0519	ORD01732	5	2024-07-24
REV00473	PROD0245	CUST0519	ORD01736	2	2024-07-13
REV00474	PROD0107	CUST0522	ORD01741	1	2024-10-06
REV00475	PROD0077	CUST0522	ORD01742	4	2024-12-31
REV00476	PROD0182	CUST0526	ORD01751	4	2024-12-31
REV00477	PROD0125	CUST0526	ORD01752	4	2024-11-23
REV00478	PROD0247	CUST0528	ORD01754	3	2024-11-10
REV00479	PROD0061	CUST0529	ORD01757	2	2023-09-12
REV00480	PROD0236	CUST0529	ORD01759	4	2024-07-02
REV00481	PROD0165	CUST0532	ORD01763	2	2024-07-16
REV00482	PROD0164	CUST0534	ORD01764	5	2024-07-22
REV00483	PROD0048	CUST0535	ORD01767	3	2024-06-12
REV00484	PROD0075	CUST0536	ORD01772	5	2024-12-09
REV00485	PROD0252	CUST0540	ORD01776	5	2024-11-04
REV00486	PROD0041	CUST0540	ORD01779	4	2024-06-19
REV00487	PROD0166	CUST0540	ORD01780	3	2024-02-21
REV00488	PROD0202	CUST0540	ORD01782	3	2024-06-22
REV00489	PROD0275	CUST0540	ORD01785	3	2023-10-01
REV00490	PROD0172	CUST0541	ORD01790	4	2024-11-19
REV00491	PROD0079	CUST0541	ORD01800	1	2024-01-12
REV00492	PROD0245	CUST0542	ORD01802	3	2024-05-22
REV00493	PROD0142	CUST0542	ORD01804	4	2024-05-22
REV00494	PROD0037	CUST0546	ORD01810	5	2024-12-31
REV00495	PROD0192	CUST0546	ORD01812	1	2024-11-20
REV00496	PROD0102	CUST0549	ORD01822	3	2024-10-20
REV00497	PROD0251	CUST0550	ORD01823	4	2024-12-29
REV00498	PROD0159	CUST0550	ORD01825	5	2024-07-07
REV00499	PROD0263	CUST0552	ORD01835	4	2024-09-22
REV00500	PROD0227	CUST0553	ORD01837	4	2024-04-05
REV00501	PROD0034	CUST0556	ORD01839	1	2024-10-25
REV00502	PROD0201	CUST0557	ORD01845	5	2024-12-31
REV00503	PROD0128	CUST0557	ORD01846	4	2024-12-09
REV00504	PROD0099	CUST0558	ORD01853	5	2024-05-13
REV00505	PROD0032	CUST0558	ORD01856	1	2024-07-03
REV00506	PROD0225	CUST0561	ORD01866	4	2024-09-03
REV00507	PROD0228	CUST0561	ORD01867	4	2024-05-22
REV00508	PROD0196	CUST0561	ORD01872	3	2024-04-17
REV00509	PROD0272	CUST0563	ORD01875	3	2024-07-14
REV00510	PROD0089	CUST0563	ORD01879	2	2024-07-07
REV00511	PROD0100	CUST0563	ORD01880	5	2024-09-30
REV00512	PROD0270	CUST0563	ORD01881	3	2024-10-12
REV00513	PROD0185	CUST0563	ORD01882	2	2024-12-05
REV00514	PROD0278	CUST0565	ORD01885	5	2024-11-15
REV00515	PROD0206	CUST0566	ORD01887	4	2024-02-04
REV00516	PROD0081	CUST0568	ORD01898	4	2024-11-02
REV00517	PROD0026	CUST0568	ORD01899	1	2024-11-06
REV00518	PROD0138	CUST0569	ORD01901	4	2024-01-20
REV00519	PROD0094	CUST0569	ORD01902	5	2024-02-14
REV00520	PROD0230	CUST0569	ORD01904	1	2024-01-19
REV00521	PROD0207	CUST0569	ORD01906	5	2023-11-20
REV00522	PROD0114	CUST0570	ORD01912	3	2024-11-22
REV00523	PROD0092	CUST0571	ORD01913	5	2023-11-17
REV00524	PROD0128	CUST0574	ORD01918	1	2024-02-19
REV00525	PROD0143	CUST0575	ORD01920	3	2024-07-14
REV00526	PROD0206	CUST0577	ORD01933	3	2024-09-12
REV00527	PROD0076	CUST0577	ORD01934	5	2024-12-20
REV00528	PROD0031	CUST0579	ORD01939	5	2023-10-16
REV00529	PROD0003	CUST0582	ORD01942	5	2024-05-27
REV00530	PROD0133	CUST0582	ORD01947	4	2024-05-06
REV00531	PROD0048	CUST0582	ORD01950	4	2024-07-06
REV00533	PROD0258	CUST0586	ORD01955	3	2024-11-29
REV00534	PROD0162	CUST0586	ORD01956	4	2024-06-27
REV00535	PROD0024	CUST0587	ORD01960	3	2024-04-28
REV00536	PROD0240	CUST0590	ORD01964	3	2023-12-01
REV00537	PROD0247	CUST0591	ORD01973	3	2024-03-28
REV00538	PROD0264	CUST0592	ORD01979	4	2024-12-31
REV00539	PROD0163	CUST0592	ORD01982	5	2024-11-06
REV00540	PROD0212	CUST0593	ORD01985	4	2024-02-29
REV00541	PROD0134	CUST0593	ORD01987	3	2024-02-20
REV00542	PROD0256	CUST0593	ORD01990	5	2023-12-20
REV00543	PROD0240	CUST0593	ORD01995	5	2023-11-29
REV00544	PROD0033	CUST0596	ORD02001	5	2024-02-07
REV00545	PROD0083	CUST0597	ORD02002	4	2024-09-12
REV00546	PROD0006	CUST0598	ORD02005	3	2024-01-27
REV00547	PROD0098	CUST0598	ORD02006	2	2023-09-15
REV00548	PROD0025	CUST0599	ORD02013	3	2024-06-08
REV00549	PROD0055	CUST0599	ORD02015	4	2024-05-14
REV00550	PROD0184	CUST0599	ORD02017	4	2024-09-27
REV00551	PROD0159	CUST0599	ORD02018	5	2024-10-23
REV00552	PROD0222	CUST0602	ORD02023	3	2024-08-27
REV00553	PROD0146	CUST0605	ORD02030	5	2024-12-21
REV00554	PROD0261	CUST0606	ORD02034	5	2024-07-19
REV00555	PROD0170	CUST0610	ORD02036	5	2024-11-26
REV00556	PROD0141	CUST0610	ORD02039	4	2024-09-03
REV00557	PROD0220	CUST0611	ORD02043	2	2024-02-11
REV00558	PROD0166	CUST0614	ORD02051	2	2024-01-26
REV00559	PROD0219	CUST0614	ORD02054	2	2024-01-24
REV00560	PROD0239	CUST0614	ORD02055	4	2024-03-29
REV00561	PROD0280	CUST0614	ORD02057	2	2024-07-10
REV00562	PROD0116	CUST0617	ORD02064	5	2024-09-16
REV00563	PROD0212	CUST0617	ORD02065	5	2024-12-10
REV00564	PROD0118	CUST0617	ORD02068	4	2024-12-31
REV00565	PROD0188	CUST0618	ORD02070	2	2024-08-14
REV00566	PROD0230	CUST0618	ORD02071	4	2024-07-20
REV00567	PROD0024	CUST0618	ORD02072	2	2024-12-18
REV00568	PROD0170	CUST0618	ORD02079	5	2024-08-02
REV00569	PROD0173	CUST0621	ORD02082	4	2023-12-04
REV00570	PROD0220	CUST0621	ORD02083	4	2024-12-02
REV00571	PROD0169	CUST0621	ORD02084	3	2024-07-19
REV00572	PROD0130	CUST0621	ORD02090	3	2024-12-08
REV00573	PROD0054	CUST0621	ORD02093	4	2024-12-31
REV00574	PROD0277	CUST0624	ORD02098	3	2024-09-07
REV00575	PROD0115	CUST0626	ORD02106	3	2024-02-08
REV00576	PROD0025	CUST0626	ORD02112	4	2024-07-03
REV00577	PROD0047	CUST0626	ORD02113	1	2024-05-13
REV00578	PROD0236	CUST0628	ORD02115	5	2024-04-23
REV00579	PROD0031	CUST0631	ORD02120	4	2024-10-02
REV00580	PROD0263	CUST0631	ORD02121	4	2024-08-06
REV00581	PROD0047	CUST0631	ORD02123	3	2024-10-13
REV00582	PROD0085	CUST0633	ORD02128	4	2023-11-15
REV00583	PROD0106	CUST0634	ORD02132	4	2023-11-23
REV00584	PROD0266	CUST0635	ORD02136	5	2024-11-22
REV00585	PROD0236	CUST0635	ORD02137	5	2024-12-31
REV00587	PROD0094	CUST0636	ORD02142	4	2023-10-20
REV00588	PROD0177	CUST0638	ORD02149	5	2023-12-16
REV00589	PROD0204	CUST0640	ORD02153	3	2024-01-15
REV00590	PROD0145	CUST0642	ORD02168	5	2024-02-19
REV00591	PROD0196	CUST0643	ORD02173	2	2024-05-12
REV00592	PROD0084	CUST0644	ORD02177	3	2023-11-15
REV00593	PROD0069	CUST0644	ORD02179	1	2024-06-19
REV00594	PROD0175	CUST0645	ORD02183	2	2024-12-01
REV00595	PROD0258	CUST0645	ORD02184	5	2024-12-05
REV00596	PROD0200	CUST0645	ORD02186	1	2024-11-02
REV00597	PROD0065	CUST0645	ORD02189	5	2024-11-18
REV00598	PROD0209	CUST0646	ORD02190	4	2024-04-24
REV00599	PROD0114	CUST0648	ORD02198	4	2024-02-06
REV00600	PROD0147	CUST0653	ORD02207	4	2024-03-01
REV00601	PROD0252	CUST0653	ORD02208	5	2024-09-14
REV00602	PROD0006	CUST0654	ORD02211	1	2024-10-13
REV00603	PROD0012	CUST0656	ORD02213	2	2024-07-27
REV00604	PROD0170	CUST0656	ORD02216	4	2024-12-22
REV00605	PROD0081	CUST0656	ORD02219	3	2024-10-31
REV00606	PROD0208	CUST0656	ORD02221	5	2024-08-20
REV00607	PROD0236	CUST0657	ORD02224	3	2023-10-24
REV00608	PROD0208	CUST0657	ORD02225	1	2024-04-27
REV00609	PROD0206	CUST0658	ORD02227	5	2023-10-01
REV00610	PROD0004	CUST0662	ORD02242	5	2024-05-30
REV00611	PROD0227	CUST0665	ORD02247	3	2023-08-15
REV00612	PROD0077	CUST0666	ORD02255	4	2024-06-23
REV00613	PROD0061	CUST0666	ORD02256	1	2024-07-28
REV00614	PROD0056	CUST0666	ORD02258	2	2024-11-21
REV00615	PROD0239	CUST0666	ORD02259	1	2024-12-23
REV00616	PROD0059	CUST0666	ORD02260	5	2024-12-31
REV00617	PROD0042	CUST0666	ORD02261	5	2024-06-16
REV00618	PROD0096	CUST0667	ORD02265	5	2023-11-12
REV00619	PROD0280	CUST0667	ORD02267	5	2024-04-24
REV00620	PROD0242	CUST0667	ORD02268	3	2024-06-02
REV00621	PROD0247	CUST0667	ORD02270	5	2023-11-19
REV00622	PROD0278	CUST0670	ORD02274	4	2024-10-26
REV00623	PROD0252	CUST0671	ORD02276	1	2024-06-07
REV00624	PROD0066	CUST0671	ORD02280	5	2024-04-20
REV00625	PROD0222	CUST0673	ORD02284	4	2024-12-26
REV00626	PROD0178	CUST0673	ORD02290	5	2024-11-29
REV00627	PROD0100	CUST0675	ORD02296	5	2024-11-24
REV00628	PROD0050	CUST0675	ORD02299	1	2024-10-07
REV00629	PROD0013	CUST0677	ORD02305	5	2024-07-11
REV00630	PROD0146	CUST0679	ORD02314	2	2024-11-12
REV00631	PROD0101	CUST0680	ORD02316	5	2024-12-30
REV00632	PROD0207	CUST0682	ORD02318	5	2024-12-13
REV00633	PROD0082	CUST0682	ORD02319	5	2024-12-31
REV00634	PROD0276	CUST0682	ORD02323	3	2024-12-31
REV00635	PROD0028	CUST0683	ORD02328	4	2024-06-11
REV00636	PROD0181	CUST0684	ORD02330	5	2024-10-21
REV00637	PROD0265	CUST0685	ORD02333	2	2024-04-14
REV00638	PROD0061	CUST0688	ORD02343	4	2024-05-02
REV00639	PROD0176	CUST0689	ORD02346	3	2024-10-27
REV00640	PROD0104	CUST0689	ORD02348	3	2024-10-08
REV00641	PROD0173	CUST0689	ORD02349	5	2024-09-24
REV00642	PROD0183	CUST0690	ORD02351	3	2024-04-29
REV00643	PROD0169	CUST0690	ORD02352	4	2023-04-14
REV00644	PROD0016	CUST0691	ORD02360	5	2024-05-23
REV00645	PROD0087	CUST0691	ORD02362	4	2024-11-18
REV00646	PROD0139	CUST0692	ORD02367	3	2023-03-22
REV00647	PROD0223	CUST0692	ORD02371	5	2023-07-13
REV00648	PROD0279	CUST0694	ORD02374	5	2024-06-26
REV00649	PROD0040	CUST0695	ORD02376	3	2024-09-03
REV00650	PROD0220	CUST0695	ORD02378	4	2024-09-17
REV00651	PROD0004	CUST0695	ORD02379	5	2024-10-02
REV00652	PROD0006	CUST0695	ORD02380	2	2024-12-08
REV00653	PROD0045	CUST0695	ORD02382	5	2024-10-15
REV00654	PROD0124	CUST0696	ORD02386	2	2024-12-31
REV00655	PROD0114	CUST0697	ORD02390	4	2024-09-06
REV00656	PROD0004	CUST0697	ORD02391	2	2024-10-30
REV00657	PROD0007	CUST0700	ORD02398	2	2024-12-31
REV00658	PROD0082	CUST0700	ORD02399	5	2024-11-11
REV00659	PROD0145	CUST0702	ORD02406	5	2024-05-18
REV00660	PROD0145	CUST0703	ORD02408	4	2024-12-31
REV00661	PROD0064	CUST0703	ORD02409	5	2024-09-22
REV00662	PROD0075	CUST0708	ORD02422	2	2024-12-31
REV00663	PROD0269	CUST0709	ORD02423	3	2024-07-31
REV00664	PROD0098	CUST0712	ORD02431	5	2023-10-13
REV00665	PROD0175	CUST0712	ORD02434	5	2024-08-26
REV00666	PROD0202	CUST0714	ORD02444	4	2024-11-14
REV00667	PROD0155	CUST0714	ORD02447	2	2024-12-31
REV00668	PROD0273	CUST0714	ORD02450	4	2024-12-13
REV00669	PROD0098	CUST0714	ORD02451	5	2024-11-15
REV00670	PROD0042	CUST0714	ORD02453	3	2024-11-20
REV00671	PROD0250	CUST0719	ORD02461	1	2024-12-05
REV00672	PROD0112	CUST0720	ORD02464	2	2024-07-25
REV00673	PROD0028	CUST0720	ORD02465	5	2024-08-12
REV00674	PROD0131	CUST0721	ORD02469	4	2024-12-25
REV00675	PROD0040	CUST0721	ORD02473	5	2024-12-11
REV00676	PROD0115	CUST0722	ORD02475	5	2024-12-05
REV00677	PROD0175	CUST0722	ORD02476	4	2023-11-19
REV00678	PROD0212	CUST0723	ORD02483	4	2024-03-11
REV00679	PROD0239	CUST0725	ORD02489	4	2023-10-04
REV00680	PROD0126	CUST0726	ORD02493	5	2024-11-15
REV00681	PROD0100	CUST0730	ORD02504	4	2024-12-25
REV00682	PROD0251	CUST0731	ORD02507	3	2024-12-31
REV00683	PROD0149	CUST0731	ORD02510	3	2024-07-24
REV00684	PROD0074	CUST0732	ORD02512	5	2024-08-20
REV00685	PROD0067	CUST0733	ORD02518	3	2024-07-07
REV00686	PROD0216	CUST0734	ORD02522	5	2024-04-10
REV00687	PROD0251	CUST0736	ORD02524	3	2024-03-14
REV00688	PROD0100	CUST0736	ORD02527	5	2023-12-12
REV00689	PROD0263	CUST0737	ORD02536	4	2023-12-18
REV00690	PROD0175	CUST0740	ORD02549	4	2024-10-14
REV00691	PROD0004	CUST0740	ORD02550	4	2024-09-09
REV00692	PROD0127	CUST0740	ORD02554	5	2024-04-24
REV00693	PROD0184	CUST0741	ORD02556	1	2024-07-10
REV00694	PROD0003	CUST0744	ORD02567	4	2024-07-21
REV00695	PROD0084	CUST0747	ORD02569	3	2024-12-03
REV00696	PROD0176	CUST0747	ORD02571	1	2024-11-03
REV00697	PROD0038	CUST0747	ORD02573	3	2024-11-25
REV00698	PROD0025	CUST0748	ORD02578	4	2024-11-06
REV00699	PROD0201	CUST0748	ORD02581	5	2023-12-05
REV00700	PROD0028	CUST0749	ORD02583	3	2024-10-08
REV00701	PROD0178	CUST0749	ORD02584	4	2024-07-21
REV00702	PROD0090	CUST0750	ORD02586	5	2024-10-11
REV00703	PROD0055	CUST0750	ORD02588	2	2024-11-19
REV00704	PROD0066	CUST0750	ORD02589	5	2024-11-28
REV00705	PROD0076	CUST0751	ORD02592	4	2024-05-11
REV00706	PROD0244	CUST0751	ORD02599	2	2024-11-22
REV00707	PROD0220	CUST0753	ORD02607	4	2024-10-25
REV00708	PROD0086	CUST0753	ORD02609	5	2024-08-26
REV00709	PROD0267	CUST0756	ORD02620	4	2024-12-31
REV00710	PROD0253	CUST0758	ORD02622	4	2024-12-31
REV00711	PROD0248	CUST0758	ORD02625	5	2024-06-14
REV00712	PROD0253	CUST0760	ORD02628	4	2024-12-27
REV00713	PROD0280	CUST0760	ORD02630	5	2024-12-17
REV00714	PROD0007	CUST0760	ORD02631	4	2024-12-30
REV00715	PROD0120	CUST0760	ORD02632	5	2024-12-27
REV00716	PROD0120	CUST0762	ORD02636	5	2024-12-10
REV00717	PROD0230	CUST0763	ORD02638	4	2024-07-22
REV00719	PROD0236	CUST0768	ORD02644	3	2024-08-03
REV00720	PROD0070	CUST0771	ORD02650	5	2024-02-04
REV00721	PROD0009	CUST0772	ORD02652	4	2024-06-27
REV00722	PROD0040	CUST0772	ORD02660	3	2024-08-17
REV00723	PROD0134	CUST0774	ORD02664	4	2024-01-23
REV00724	PROD0088	CUST0774	ORD02665	5	2023-11-04
REV00725	PROD0137	CUST0774	ORD02669	3	2023-03-02
REV00726	PROD0258	CUST0778	ORD02676	3	2024-12-10
REV00727	PROD0045	CUST0778	ORD02681	3	2024-12-10
REV00728	PROD0181	CUST0779	ORD02685	2	2024-07-08
REV00729	PROD0087	CUST0779	ORD02686	4	2024-06-14
REV00730	PROD0213	CUST0779	ORD02689	4	2024-02-29
REV00731	PROD0067	CUST0779	ORD02691	5	2024-05-23
REV00732	PROD0082	CUST0782	ORD02697	3	2024-05-26
REV00733	PROD0026	CUST0783	ORD02700	1	2023-11-24
REV00734	PROD0099	CUST0783	ORD02701	3	2024-02-02
REV00735	PROD0267	CUST0783	ORD02702	5	2023-10-10
REV00736	PROD0071	CUST0783	ORD02703	5	2024-07-01
REV00737	PROD0080	CUST0784	ORD02710	5	2023-07-29
REV00738	PROD0250	CUST0784	ORD02711	3	2024-06-03
REV00739	PROD0217	CUST0784	ORD02712	2	2024-04-25
REV00740	PROD0128	CUST0784	ORD02714	3	2024-11-18
REV00741	PROD0045	CUST0784	ORD02715	5	2024-04-28
REV00742	PROD0065	CUST0784	ORD02716	5	2024-10-31
REV00743	PROD0041	CUST0786	ORD02723	5	2024-10-27
REV00744	PROD0056	CUST0786	ORD02724	2	2024-03-30
REV00745	PROD0178	CUST0786	ORD02725	4	2024-06-12
REV00746	PROD0167	CUST0789	ORD02729	3	2024-05-21
REV00747	PROD0025	CUST0792	ORD02737	1	2024-05-30
REV00748	PROD0018	CUST0792	ORD02744	1	2024-09-14
REV00749	PROD0035	CUST0793	ORD02747	4	2024-07-13
REV00750	PROD0247	CUST0797	ORD02769	4	2024-04-16
REV00751	PROD0266	CUST0797	ORD02772	1	2024-07-12
REV00752	PROD0126	CUST0800	ORD02777	5	2024-09-23
REV00753	PROD0272	CUST0800	ORD02778	5	2024-03-30
REV00754	PROD0083	CUST0801	ORD02779	1	2024-10-07
REV00755	PROD0257	CUST0801	ORD02783	5	2024-12-11
REV00756	PROD0002	CUST0801	ORD02784	5	2024-10-10
REV00757	PROD0244	CUST0801	ORD02785	2	2024-10-28
REV00758	PROD0091	CUST0801	ORD02789	4	2024-10-16
REV00759	PROD0054	CUST0802	ORD02794	3	2024-08-13
REV00760	PROD0238	CUST0804	ORD02799	2	2023-11-26
REV00761	PROD0261	CUST0809	ORD02803	4	2024-10-13
REV00762	PROD0081	CUST0809	ORD02804	4	2023-08-13
REV00763	PROD0248	CUST0812	ORD02811	4	2024-08-19
REV00764	PROD0221	CUST0813	ORD02818	5	2024-09-28
REV00765	PROD0162	CUST0814	ORD02819	4	2023-09-04
REV00766	PROD0097	CUST0814	ORD02821	1	2024-07-02
REV00767	PROD0200	CUST0814	ORD02823	5	2024-07-19
REV00768	PROD0086	CUST0815	ORD02829	3	2024-12-31
REV00769	PROD0052	CUST0815	ORD02830	4	2024-11-30
REV00770	PROD0110	CUST0815	ORD02831	3	2024-10-08
REV00771	PROD0031	CUST0815	ORD02833	1	2024-12-31
REV00772	PROD0170	CUST0816	ORD02835	2	2024-10-10
REV00773	PROD0211	CUST0817	ORD02842	4	2024-07-26
REV00774	PROD0023	CUST0817	ORD02846	4	2024-01-08
REV00775	PROD0005	CUST0818	ORD02853	3	2024-09-29
REV00776	PROD0065	CUST0818	ORD02854	5	2024-11-12
REV00777	PROD0018	CUST0820	ORD02865	5	2024-01-30
REV00778	PROD0266	CUST0821	ORD02866	4	2024-08-29
REV00779	PROD0109	CUST0822	ORD02871	3	2024-10-14
REV00780	PROD0149	CUST0822	ORD02872	5	2024-09-21
REV00781	PROD0165	CUST0822	ORD02875	3	2024-12-05
REV00782	PROD0189	CUST0823	ORD02876	3	2024-11-03
REV00783	PROD0127	CUST0825	ORD02882	3	2024-02-15
REV00784	PROD0027	CUST0825	ORD02885	3	2024-03-11
REV00785	PROD0067	CUST0825	ORD02888	5	2024-03-24
REV00786	PROD0101	CUST0830	ORD02897	5	2024-07-23
REV00787	PROD0253	CUST0830	ORD02898	4	2024-12-30
REV00788	PROD0092	CUST0830	ORD02899	2	2024-06-29
REV00789	PROD0191	CUST0831	ORD02909	3	2024-03-16
REV00790	PROD0184	CUST0831	ORD02915	4	2024-09-10
REV00791	PROD0066	CUST0833	ORD02921	4	2024-08-02
REV00792	PROD0223	CUST0833	ORD02922	5	2024-12-31
REV00793	PROD0035	CUST0833	ORD02923	5	2024-09-09
REV00794	PROD0210	CUST0833	ORD02928	4	2024-10-31
REV00795	PROD0148	CUST0836	ORD02936	5	2024-12-14
REV00796	PROD0180	CUST0836	ORD02940	3	2024-11-26
REV00797	PROD0011	CUST0837	ORD02949	3	2024-07-13
REV00798	PROD0177	CUST0839	ORD02954	4	2024-09-21
REV00799	PROD0245	CUST0840	ORD02958	3	2024-01-22
REV00800	PROD0007	CUST0843	ORD02966	4	2024-11-04
REV00801	PROD0046	CUST0843	ORD02970	4	2024-05-20
REV00802	PROD0197	CUST0844	ORD02972	4	2024-09-16
REV00803	PROD0279	CUST0847	ORD02976	3	2024-10-23
REV00804	PROD0057	CUST0847	ORD02977	4	2024-11-05
REV00805	PROD0204	CUST0847	ORD02978	4	2024-10-08
REV00806	PROD0056	CUST0847	ORD02979	5	2024-08-25
REV00807	PROD0225	CUST0847	ORD02980	3	2024-09-14
REV00808	PROD0182	CUST0849	ORD02981	3	2024-06-02
REV00809	PROD0043	CUST0849	ORD02983	2	2024-07-22
REV00810	PROD0074	CUST0850	ORD02984	4	2024-10-30
REV00811	PROD0181	CUST0851	ORD02987	5	2024-09-08
REV00812	PROD0073	CUST0852	ORD02989	1	2024-06-10
REV00813	PROD0230	CUST0854	ORD02992	5	2024-01-15
REV00814	PROD0055	CUST0857	ORD02996	5	2024-05-10
REV00815	PROD0062	CUST0858	ORD02998	2	2023-08-13
REV00816	PROD0012	CUST0859	ORD03000	4	2024-02-26
REV00817	PROD0012	CUST0518	ORD01723	3	2024-02-17
REV00175	PROD0085	CUST0217	ORD00722	\N	2024-11-03
REV00458	PROD0230	CUST0506	ORD01689	\N	2023-08-17
REV00532	PROD0002	CUST0586	ORD01954	\N	2024-07-21
REV00586	PROD0005	CUST0636	ORD02141	\N	2023-09-10
REV00718	PROD0232	CUST0764	ORD02639	\N	2024-12-31
\.


--
-- Data for Name: sellers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sellers (seller_id, seller_name, onboarding_date, product_category, city, state, account_status) FROM stdin;
SELL087	TechBase NG	2022-12-22	Food & Beverages	Kano	Kano	Active
SELL088	StyleKraft NG	2022-07-16	Food & Beverages	Lagos	Lagos	Active
SELL089	GardenHouse NG	2023-12-03	Sports & Fitness	Abuja	FCT	Active
SELL090	AthleticNG	2023-12-30	Food & Beverages	Port Harcourt	Rivers	Active
SELL011	FitLife Nigeria	2023-03-26	Fashion	Lagos	Lagos	Active
SELL012	FreshFarm NG	2024-04-22	Electronics	Lagos	Lagos	Active
SELL022	UrbanStyle NG	2022-09-26	Fashion	Ibadan	Oyo	Active
SELL013	KidsWorld NG	2022-12-07	Books & Stationery	Kano	Kano	Active
SELL014	HomeEssentials NG	2022-03-09	Sports & Fitness	Kano	Kano	Active
SELL015	GadgetKing NG	2022-02-23	Books & Stationery	Kano	Kano	Active
SELL016	TrendyFash	2022-01-04	Fashion	Port Harcourt	Rivers	Active
SELL017	OrganicLife NG	2022-06-11	Electronics	Abuja	FCT	Active
SELL018	ReadMore NG	2023-04-08	Home & Garden	Port Harcourt	Rivers	Active
SELL019	ActiveWear NG	2024-04-26	Sports & Fitness	Lagos	Lagos	Active
SELL020	TasteOfNigeria	2022-07-06	Home & Garden	Lagos	Lagos	Active
SELL021	SmartGadgets NG	2023-07-26	Electronics	Lagos	Lagos	Active
SELL023	CleanHome NG	2023-09-07	Beauty & Personal Care	Abuja	FCT	Active
SELL024	SportsCentral NG	2022-05-01	Sports & Fitness	Lagos	Lagos	Suspended
SELL025	PureBeauty NG	2022-05-02	Beauty & Personal Care	Port Harcourt	Rivers	Active
SELL026	HealthyEats NG	2024-03-11	Books & Stationery	Ibadan	Oyo	Active
SELL027	TechStore NG	2022-07-31	Books & Stationery	Lagos	Lagos	Active
SELL028	FashionHub NG	2022-07-04	Beauty & Personal Care	Kano	Kano	Active
SELL029	GardenPlus NG	2022-08-30	Home & Garden	Lagos	Lagos	Active
SELL030	WellnessHub NG	2023-04-15	Food & Beverages	Abuja	FCT	Active
SELL031	ElectroMart NG	2023-02-12	Food & Beverages	Port Harcourt	Rivers	Active
SELL032	ChicStyle NG	2022-03-16	Home & Garden	Kano	Kano	Active
SELL033	EcoHome NG	2023-04-28	Fashion	Lagos	Lagos	Active
SELL034	RunFast NG	2023-01-26	Sports & Fitness	Lagos	Lagos	Active
SELL035	SkincareNG	2022-02-12	Sports & Fitness	Lagos	Lagos	Active
SELL036	NaijaSnacks NG	2023-04-25	Home & Garden	Abuja	FCT	Active
SELL037	EduBooks NG	2022-11-17	Electronics	Lagos	Lagos	Suspended
SELL038	PowerTech NG	2022-10-15	Books & Stationery	Port Harcourt	Rivers	Active
SELL039	LuxeBeauty NG	2023-09-20	Home & Garden	Ibadan	Oyo	Active
SELL040	AfricanFoods NG	2022-11-20	Fashion	Abuja	FCT	Active
SELL041	DigiTech NG	2023-10-14	Food & Beverages	Abuja	FCT	Active
SELL042	StreetStyle NG	2022-07-07	Fashion	Lagos	Lagos	Suspended
SELL043	HomePlus NG	2022-04-29	Beauty & Personal Care	Kano	Kano	Active
SELL044	FitnessFirst NG	2023-07-29	Food & Beverages	Abuja	FCT	Active
SELL045	BeautyBox NG	2022-06-01	Books & Stationery	Port Harcourt	Rivers	Active
SELL046	LocalFarm NG	2024-05-04	Fashion	Port Harcourt	Rivers	Active
SELL047	LearnMore NG	2022-08-06	Sports & Fitness	Port Harcourt	Rivers	Active
SELL048	MaxGadget NG	2023-03-03	Fashion	Port Harcourt	Rivers	Active
SELL049	VogueNG	2022-01-27	Home & Garden	Kano	Kano	Active
SELL050	SportsGear NG	2024-05-07	Electronics	Lagos	Lagos	Active
SELL051	HealthFood NG	2023-11-07	Food & Beverages	Abuja	FCT	Active
SELL052	TechZone NG	2023-11-03	Electronics	Lagos	Lagos	Active
SELL053	ModaNG	2024-03-27	Food & Beverages	Ibadan	Oyo	Active
SELL054	GreenSpace NG	2022-11-27	Home & Garden	Port Harcourt	Rivers	Active
SELL055	GymPro NG	2022-04-05	Beauty & Personal Care	Ibadan	Oyo	Active
SELL056	SkinGlow NG	2023-02-13	Books & Stationery	Ibadan	Oyo	Active
SELL057	AgriMart NG	2022-10-19	Beauty & Personal Care	Lagos	Lagos	Active
SELL058	PageTurner NG	2023-03-19	Books & Stationery	Lagos	Lagos	Active
SELL059	TechPower NG	2023-11-13	Home & Garden	Kano	Kano	Active
SELL060	AllFashion NG	2023-05-03	Beauty & Personal Care	Abuja	FCT	Active
SELL061	CozyHome NG	2023-01-13	Books & Stationery	Port Harcourt	Rivers	Active
SELL062	ActiveLife NG	2022-12-16	Sports & Fitness	Lagos	Lagos	Active
SELL063	PureSkin NG	2023-05-23	Fashion	Kano	Kano	Active
SELL064	Naija Grains	2024-03-31	Electronics	Abuja	FCT	Active
SELL065	BrightMinds NG	2024-05-11	Home & Garden	Kano	Kano	Active
SELL066	GadgetPro NG	2022-03-20	Sports & Fitness	Abuja	FCT	Active
SELL067	FreshStyle NG	2023-11-08	Beauty & Personal Care	Abuja	FCT	Active
SELL068	EarthHome NG	2024-02-27	Electronics	Lagos	Lagos	Active
SELL069	SweatZone NG	2024-03-16	Fashion	Kano	Kano	Active
SELL070	GlowUp NG	2022-11-01	Food & Beverages	Lagos	Lagos	Active
SELL071	FarmFresh NG	2022-09-29	Books & Stationery	Abuja	FCT	Active
SELL072	ReadRight NG	2023-09-11	Food & Beverages	Lagos	Lagos	Active
SELL073	SmartShop NG	2023-02-09	Electronics	Abuja	FCT	Active
SELL074	TrendHub NG	2023-11-05	Beauty & Personal Care	Abuja	FCT	Active
SELL075	LivingPlus NG	2023-01-05	Sports & Fitness	Kano	Kano	Active
SELL076	SportNation NG	2022-01-15	Fashion	Lagos	Lagos	Active
SELL077	BeautyNation NG	2022-01-28	Books & Stationery	Ibadan	Oyo	Active
SELL078	NaijaFoods NG	2024-05-28	Food & Beverages	Abuja	FCT	Active
SELL079	ScholarsNG	2022-06-01	Beauty & Personal Care	Lagos	Lagos	Active
SELL080	UltraTech NG	2024-01-27	Fashion	Lagos	Lagos	Active
SELL081	FashionKraft NG	2023-08-23	Beauty & Personal Care	Lagos	Lagos	Active
SELL082	HomeNest NG	2022-02-22	Beauty & Personal Care	Port Harcourt	Rivers	Active
SELL083	FitZone NG	2023-05-23	Books & Stationery	Ibadan	Oyo	Active
SELL084	GlowBar NG	2023-06-10	Beauty & Personal Care	Abuja	FCT	Active
SELL085	HarvestPlus NG	2022-01-20	Sports & Fitness	Kano	Kano	Active
SELL086	KnowledgeHub NG	2023-03-04	Food & Beverages	Lagos	Lagos	Active
SELL001	TechHub Nigeria	2023-09-07	Fashion	Port Harcourt	Rivers	Active
SELL002	FashionVault NG	2023-02-04	Food & Beverages	Port Harcourt	Rivers	Active
SELL003	GreenHome Stores	2022-06-29	Electronics	Lagos	Lagos	Active
SELL004	GlowBeauty Shop	2023-08-27	Books & Stationery	Abuja	FCT	Active
SELL005	SportsPro Nigeria	2023-05-02	Beauty & Personal Care	Lagos	Lagos	Active
SELL006	FoodBasket NG	2023-01-12	Food & Beverages	Lagos	Lagos	Active
SELL007	BookWorld Nigeria	2022-02-05	Sports & Fitness	Ibadan	Oyo	Active
SELL008	QuickTech NG	2022-11-13	Beauty & Personal Care	Lagos	Lagos	Active
SELL009	StyleZone Lagos	2022-08-31	Books & Stationery	Lagos	Lagos	Active
SELL010	NaturalGlow NG	2022-09-19	Beauty & Personal Care	Ibadan	Oyo	Active
\.


--
-- Name: order_items_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_items_item_id_seq', 6435, true);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (item_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (review_id);


--
-- Name: sellers sellers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sellers
    ADD CONSTRAINT sellers_pkey PRIMARY KEY (seller_id);


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- Name: order_items order_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: orders orders_seller_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_seller_id_fkey FOREIGN KEY (seller_id) REFERENCES public.sellers(seller_id);


--
-- Name: payments payments_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- Name: products products_seller_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_seller_id_fkey FOREIGN KEY (seller_id) REFERENCES public.sellers(seller_id);


--
-- Name: reviews reviews_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: reviews reviews_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- PostgreSQL database dump complete
--

\unrestrict SYAMAAJiE0u9sCSKVktyg9mLeUqsbJNriacbEs9s1ieJuFTF7h1bYnWQfi4dd68

