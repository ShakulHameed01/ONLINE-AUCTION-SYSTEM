
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

CREATE FUNCTION public.add_department_request() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO department_requests (student_roll_number, department_name)
  SELECT NEW.roll_number, d.departmentName
  FROM department d
  WHERE d.departmentName = NEW.department;

  RETURN NEW;
END;
$$;


ALTER FUNCTION public.add_department_request() OWNER TO postgres;


CREATE FUNCTION public.insert_into_department_details() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO department_details (student_roll_number, department_name, status)
    SELECT NEW.roll_number, d.department_name, 'pending'
    FROM department d;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.insert_into_department_details() OWNER TO postgres;


CREATE FUNCTION public.insert_student_and_department_data(p_roll_number character varying, p_student_name character varying, p_photo_url character varying, p_school_of_study character varying, p_year_of_admission integer, p_address character varying, p_contact_number character varying, p_email_id character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    p_department_name VARCHAR(255);
BEGIN
    SELECT department_name INTO p_department_name
    FROM department
    ORDER BY department_id
    LIMIT 8;

    INSERT INTO student_profile (
        roll_number,
        student_name,
        photo_url,
        school_of_study,
        year_of_admission,
        address,
        contact_number,
        email_id
    ) VALUES (
        p_roll_number,
        p_student_name,
        p_photo_url,
        p_school_of_study,
        p_year_of_admission,
        p_address,
        p_contact_number,
        p_email_id
    );

    INSERT INTO department_requests (student_roll_number, department_name, status)
    VALUES (p_roll_number, p_department_name, 'pending');

    INSERT INTO department_details (student_roll_number, department_name, status, other_columns)
    VALUES (p_roll_number, p_department_name, 'pending', 'other_values');
END;
$$;


ALTER FUNCTION public.insert_student_and_department_data(p_roll_number character varying, p_student_name character varying, p_photo_url character varying, p_school_of_study character varying, p_year_of_admission integer, p_address character varying, p_contact_number character varying, p_email_id character varying) OWNER TO postgres;



CREATE FUNCTION public.insert_student_and_department_data(p_roll_number character varying, p_student_name character varying, p_photo_url character varying, p_school_of_study character varying, p_year_of_admission integer, p_address character varying, p_contact_number character varying, p_email_id character varying, p_department_name character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO student_profile (
        roll_number,
        student_name,
        photo_url,
        school_of_study,
        year_of_admission,
        address,
        contact_number,
        email_id
    ) VALUES (
        p_roll_number,
        p_student_name,
        p_photo_url,
        p_school_of_study,
        p_year_of_admission,
        p_address,
        p_contact_number,
        p_email_id
    );

    INSERT INTO department_requests (student_roll_number, department_name, status)
    VALUES (p_roll_number, p_department_name, 'pending');
END;
$$;


ALTER FUNCTION public.insert_student_and_department_data(p_roll_number character varying, p_student_name character varying, p_photo_url character varying, p_school_of_study character varying, p_year_of_admission integer, p_address character varying, p_contact_number character varying, p_email_id character varying, p_department_name character varying) OWNER TO postgres;


CREATE FUNCTION public.insert_student_and_department_data(p_roll_number character varying, p_student_name character varying, p_photo_url character varying, p_school_of_study character varying, p_year_of_admission character varying, p_address character varying, p_contact_number character varying, p_email_id character varying, p_department_name character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO student_profile (
        roll_number,
        student_name,
        photo_url,
        school_of_study,
        year_of_admission,
        address,
        contact_number,
        email_id
    ) VALUES (
        p_roll_number,
        p_student_name,
        p_photo_url,
        p_school_of_study,
        p_year_of_admission,
        p_address,
        p_contact_number,
        p_email_id
    );

    INSERT INTO department_requests (student_roll_number, department_name)
    VALUES (p_roll_number, p_department_name);

    COMMIT;
END;
$$;


ALTER FUNCTION public.insert_student_and_department_data(p_roll_number character varying, p_student_name character varying, p_photo_url character varying, p_school_of_study character varying, p_year_of_admission character varying, p_address character varying, p_contact_number character varying, p_email_id character varying, p_department_name character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;



CREATE TABLE public.admin (
    roll_number character varying(8) NOT NULL,
    password character varying(255) NOT NULL,
    department character varying(255)
);


ALTER TABLE public.admin OWNER TO postgres;


CREATE TABLE public.application (
    id integer NOT NULL,
    roll_number character varying(20),
    student_name character varying(255),
    photo_url character varying(255),
    school_of_study character varying(255),
    year_of_admission integer,
    address character varying(255),
    contact_number character varying(20),
    email_id character varying(255),
    password character varying(255)
);


ALTER TABLE public.application OWNER TO postgres;


CREATE SEQUENCE public.application_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.application_id_seq OWNER TO postgres;



ALTER SEQUENCE public.application_id_seq OWNED BY public.application.id;




CREATE TABLE public.department (
    id integer NOT NULL,
    department_name character varying(255) NOT NULL,
    status character varying(20) DEFAULT 'pending'::character varying
);


ALTER TABLE public.department OWNER TO postgres;


CREATE TABLE public.department_details (
    id integer NOT NULL,
    student_roll_number character varying(10),
    department_name character varying(255),
    status character varying(20) DEFAULT 'pending'::character varying
);


ALTER TABLE public.department_details OWNER TO postgres;



CREATE SEQUENCE public.department_details_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.department_details_id_seq OWNER TO postgres;



ALTER SEQUENCE public.department_details_id_seq OWNED BY public.department_details.id;




CREATE SEQUENCE public.department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.department_id_seq OWNER TO postgres;



ALTER SEQUENCE public.department_id_seq OWNED BY public.department.id;



CREATE TABLE public.request_approval (
    id integer NOT NULL,
    roll_number character varying(8) NOT NULL,
    department_name character varying(255) NOT NULL,
    status character varying(50) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.request_approval OWNER TO postgres;



CREATE SEQUENCE public.request_approval_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.request_approval_id_seq OWNER TO postgres;


ALTER SEQUENCE public.request_approval_id_seq OWNED BY public.request_approval.id;




CREATE TABLE public.student_profile (
    roll_number character varying(10) NOT NULL,
    student_name character varying(255) NOT NULL,
    photo_url character varying(255),
    school_of_study character varying(255),
    year_of_admission integer,
    address character varying(255),
    contact_number character varying(15),
    email_id character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    password character varying(255)
);


ALTER TABLE public.student_profile OWNER TO postgres;



ALTER TABLE ONLY public.application ALTER COLUMN id SET DEFAULT nextval('public.application_id_seq'::regclass);




ALTER TABLE ONLY public.department ALTER COLUMN id SET DEFAULT nextval('public.department_id_seq'::regclass);


ALTER TABLE ONLY public.department_details ALTER COLUMN id SET DEFAULT nextval('public.department_details_id_seq'::regclass);




ALTER TABLE ONLY public.request_approval ALTER COLUMN id SET DEFAULT nextval('public.request_approval_id_seq'::regclass);




COPY public.admin (roll_number, password, department) FROM stdin;
20000001	Hits@123	HOD
20000002	Hits@123	DEAN
20000003	Hits@123	Student Affairs
20000004	Hits@123	Alumni
20000005	Hits@123	Transport
20000006	Hits@123	Finance
20000007	Hits@123	Library
20000008	Hits@123	NAD
\.




COPY public.application (id, roll_number, student_name, photo_url, school_of_study, year_of_admission, address, contact_number, email_id, password) FROM stdin;
\.




COPY public.department (id, department_name, status) FROM stdin;
1	HOD	pending
2	DEAN	pending
3	Student Affairs	pending
4	Alumni	pending
5	Transport	pending
6	Finance	pending
7	Library	pending
8	NAD	pending
\.



COPY public.department_details (id, student_roll_number, department_name, status) FROM stdin;
75	23275011	HOD	approved
76	23275011	DEAN	approved
77	23275011	Student Affairs	approved
78	23275011	Alumni	approved
79	23275011	Transport	approved
80	23275011	Finance	approved
81	23275011	Library	approved
82	23275011	NAD	approved
74	23275006	NAD	approved
19	2327500	HOD	pending
20	2327500	DEAN	pending
21	2327500	Student Affairs	pending
22	2327500	Alumni	pending
23	2327500	Transport	pending
24	2327500	Finance	pending
25	2327500	Library	pending
26	2327500	NAD	pending
69	23275006	Student Affairs	approved
68	23275006	DEAN	approved
83	23248001	HOD	approved
84	23248001	DEAN	approved
85	23248001	Student Affairs	pending
86	23248001	Alumni	pending
27	23275002	HOD	approved
28	23275002	DEAN	approved
29	23275002	Student Affairs	approved
30	23275002	Alumni	approved
31	23275002	Transport	approved
32	23275002	Finance	approved
33	23275002	Library	approved
34	23275002	NAD	approved
35	23275002	HOD	approved
36	23275002	DEAN	approved
37	23275002	Student Affairs	approved
38	23275002	Alumni	approved
39	23275002	Transport	approved
40	23275002	Finance	approved
41	23275002	Library	approved
42	23275002	NAD	approved
43	23275002	HOD	approved
87	23248001	Transport	pending
88	23248001	Finance	pending
89	23248001	Library	pending
90	23248001	NAD	pending
72	23275006	Finance	pending
73	23275006	Library	pending
70	23275006	Alumni	pending
51	23275001	HOD	pending
52	23275001	DEAN	pending
53	23275001	Student Affairs	pending
54	23275001	Alumni	pending
67	23275006	HOD	approved
71	23275006	Transport	pending
99	23275001	HOD	pending
100	23275001	DEAN	pending
101	23275001	Student Affairs	pending
102	23275001	Alumni	pending
103	23275001	Transport	pending
55	23275001	Transport	pending
56	23275001	Finance	pending
57	23275001	Library	pending
58	23275001	NAD	pending
59	23275001	HOD	pending
60	23275001	DEAN	pending
61	23275001	Student Affairs	pending
62	23275001	Alumni	pending
63	23275001	Transport	pending
64	23275001	Finance	pending
65	23275001	Library	pending
66	23275001	NAD	pending
104	23275001	Finance	pending
105	23275001	Library	pending
106	23275001	NAD	pending
91	23248007	HOD	pending
92	23248007	DEAN	pending
93	23248007	Student Affairs	pending
94	23248007	Alumni	pending
95	23248007	Transport	pending
96	23248007	Finance	pending
97	23248007	Library	pending
98	23248007	NAD	pending
44	23275002	DEAN	approved
45	23275002	Student Affairs	approved
46	23275002	Alumni	approved
47	23275002	Transport	approved
48	23275002	Finance	approved
49	23275002	Library	approved
50	23275002	NAD	approved
\.




COPY public.request_approval (id, roll_number, department_name, status, created_at) FROM stdin;
194	23275001	DEAN	approved	2024-03-02 20:59:05.017183+05:30
195	23275001	Student Affairs	approved	2024-03-02 20:59:05.019618+05:30
196	23275001	Alumni	approved	2024-03-02 20:59:05.020064+05:30
197	23275001	Transport	approved	2024-03-02 20:59:05.020617+05:30
198	23275001	Finance	approved	2024-03-02 20:59:05.021083+05:30
199	23275001	Library	approved	2024-03-02 20:59:05.021484+05:30
200	23275001	HOD	approved	2024-03-02 20:59:05.021858+05:30
282	23275006	NAD	approved	2024-03-07 15:20:03.670474+05:30
202	23275001	DEAN	approved	2024-03-02 21:04:18.034054+05:30
203	23275001	Student Affairs	approved	2024-03-02 21:04:18.036245+05:30
204	23275001	Alumni	approved	2024-03-02 21:04:18.036782+05:30
205	23275001	Transport	approved	2024-03-02 21:04:18.03722+05:30
206	23275001	Finance	approved	2024-03-02 21:04:18.037602+05:30
207	23275001	Library	approved	2024-03-02 21:04:18.038079+05:30
208	23275001	HOD	approved	2024-03-02 21:04:18.03846+05:30
283	23275006	Student Affairs	approved	2024-03-07 15:20:03.673386+05:30
210	23275001	DEAN	approved	2024-03-02 21:11:08.214898+05:30
211	23275001	Student Affairs	approved	2024-03-02 21:11:08.220653+05:30
212	23275001	Alumni	approved	2024-03-02 21:11:08.221356+05:30
213	23275001	Transport	approved	2024-03-02 21:11:08.221863+05:30
214	23275001	Finance	approved	2024-03-02 21:11:08.22244+05:30
215	23275001	Library	approved	2024-03-02 21:11:08.223491+05:30
216	23275001	HOD	approved	2024-03-02 21:11:08.224186+05:30
284	23275006	DEAN	approved	2024-03-07 15:20:03.675086+05:30
218	23275002	HOD	approved	2024-03-03 13:53:44.772635+05:30
219	23275002	DEAN	approved	2024-03-03 13:53:44.774862+05:30
220	23275002	Student Affairs	approved	2024-03-03 13:53:44.775874+05:30
221	23275002	Alumni	approved	2024-03-03 13:53:44.776827+05:30
222	23275002	Transport	approved	2024-03-03 13:53:44.777834+05:30
223	23275002	Finance	approved	2024-03-03 13:53:44.778543+05:30
224	23275002	Library	approved	2024-03-03 13:53:44.7791+05:30
225	23275002	NAD	approved	2024-03-03 13:53:44.779707+05:30
287	23275006	Finance	pending	2024-03-07 15:20:03.67743+05:30
288	23275006	Library	pending	2024-03-07 15:20:03.678143+05:30
289	23275006	Alumni	pending	2024-03-07 15:20:03.678948+05:30
272	23275006	NAD	approved	2024-03-03 14:31:23.097291+05:30
\.



COPY public.student_profile (roll_number, student_name, photo_url, school_of_study, year_of_admission, address, contact_number, email_id, created_at, password) FROM stdin;
23275002	JohnWick	https://images.hdqwalls.com/wallpapers/john-wick-art-l3.jpg	HITS	2323	Chennai	9566564687	smohanakrishnan1@gmail.com	2024-03-03 13:12:50.994223	Hits@123
23275003	Jonny S	https://th.bing.com/th/id/OIP.w9T3PmDAqYPuQVDusDCAwgHaFj?w=212&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7	ADT	2023	EEEE	9566564687	jons.exaple@gmail.com	2024-03-02 15:58:54.418526	Hits@123
23275006	JohnWick	https://images.hdqwalls.com/wallpapers/john-wick-art-l3.jpg	HITS	2323	Chennai	9566564687	smohanak4rishnan@gmail.com	2024-03-03 13:30:49.361292	HIts@123
23275011	JohnWick	https://images.hdqwalls.com/wallpapers/john-wick-art-l3.jpg	HITS	2323	Chennai	9566564687	smohanakrishnan82@gmail.com	2024-03-03 13:42:17.845641	Hits@123
23248001	JohnWick	https://images.hdqwalls.com/wallpapers/john-wick-art-l3.jpg	HITS	2024	1A,Arun	9566564687	smohanakrishnan777@gmail.com	2024-03-04 10:40:06.684417	Hits@123
23248007	Mohanakrishnan S	https://images.hdqwalls.com/wallpapers/john-wick-art-l3.jpg	HITS	2024	1A,Arun	9566564687	smohanakrishnan2@gmail.com	2024-03-07 15:24:26.470587	Hits@123
23275001	Mohanakrishnan S	https://th.bing.com/th/id/OIP.HhgMJRaugfbaT10QxSp6ogHaHa?rs=1&pid=ImgDetMain	Hits	2023	1A,Arun	9566564687	mohanakrishnan.dev@gmail.com	2024-03-07 19:58:32.062898	Mohan@123
\.




SELECT pg_catalog.setval('public.application_id_seq', 58, true);



SELECT pg_catalog.setval('public.department_details_id_seq', 106, true);



SELECT pg_catalog.setval('public.department_id_seq', 8, true);




SELECT pg_catalog.setval('public.request_approval_id_seq', 289, true);




ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (roll_number);




ALTER TABLE ONLY public.application
    ADD CONSTRAINT application_pkey PRIMARY KEY (id);



ALTER TABLE ONLY public.department_details
    ADD CONSTRAINT department_details_pkey PRIMARY KEY (id);




ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.request_approval
    ADD CONSTRAINT request_approval_pkey PRIMARY KEY (id);



ALTER TABLE ONLY public.student_profile
    ADD CONSTRAINT student_profile_email_id_key UNIQUE (email_id);




ALTER TABLE ONLY public.student_profile
    ADD CONSTRAINT student_profile_pkey PRIMARY KEY (roll_number);




CREATE INDEX idx_roll_number ON public.student_profile USING btree (roll_number);




CREATE TRIGGER student_profile_after_insert AFTER INSERT ON public.student_profile FOR EACH ROW EXECUTE FUNCTION public.insert_into_department_details();




