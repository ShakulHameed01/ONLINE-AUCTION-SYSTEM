--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.0

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
-- Name: add_department_request(); Type: FUNCTION; Schema: public; Owner: postgres
--

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

--
-- Name: insert_into_department_details(); Type: FUNCTION; Schema: public; Owner: postgres
--

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

--
-- Name: insert_student_and_department_data(character varying, character varying, character varying, character varying, integer, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_student_and_department_data(p_roll_number character varying, p_student_name character varying, p_photo_url character varying, p_school_of_study character varying, p_year_of_admission integer, p_address character varying, p_contact_number character varying, p_email_id character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    p_department_name VARCHAR(255);
BEGIN
    -- Assume you want to get the department name dynamically based on some logic, for example, the first 8 departments in the list
    SELECT department_name INTO p_department_name
    FROM department
    ORDER BY department_id
    LIMIT 8;

    -- Insert into student_profile
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

    -- Insert into department_requests
    INSERT INTO department_requests (student_roll_number, department_name, status)
    VALUES (p_roll_number, p_department_name, 'pending');

    -- Insert into department_details
    INSERT INTO department_details (student_roll_number, department_name, status, other_columns)
    VALUES (p_roll_number, p_department_name, 'pending', 'other_values');
END;
$$;


ALTER FUNCTION public.insert_student_and_department_data(p_roll_number character varying, p_student_name character varying, p_photo_url character varying, p_school_of_study character varying, p_year_of_admission integer, p_address character varying, p_contact_number character varying, p_email_id character varying) OWNER TO postgres;

--
-- Name: insert_student_and_department_data(character varying, character varying, character varying, character varying, integer, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_student_and_department_data(p_roll_number character varying, p_student_name character varying, p_photo_url character varying, p_school_of_study character varying, p_year_of_admission integer, p_address character varying, p_contact_number character varying, p_email_id character varying, p_department_name character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insert into student_profile
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

    -- Insert into department_requests
    INSERT INTO department_requests (student_roll_number, department_name, status)
    VALUES (p_roll_number, p_department_name, 'pending');
END;
$$;


ALTER FUNCTION public.insert_student_and_department_data(p_roll_number character varying, p_student_name character varying, p_photo_url character varying, p_school_of_study character varying, p_year_of_admission integer, p_address character varying, p_contact_number character varying, p_email_id character varying, p_department_name character varying) OWNER TO postgres;

--
-- Name: insert_student_and_department_data(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_student_and_department_data(p_roll_number character varying, p_student_name character varying, p_photo_url character varying, p_school_of_study character varying, p_year_of_admission character varying, p_address character varying, p_contact_number character varying, p_email_id character varying, p_department_name character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insert into student_profile
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

    -- Insert into department_requests
    INSERT INTO department_requests (student_roll_number, department_name)
    VALUES (p_roll_number, p_department_name);

    COMMIT;
END;
$$;


ALTER FUNCTION public.insert_student_and_department_data(p_roll_number character varying, p_student_name character varying, p_photo_url character varying, p_school_of_study character varying, p_year_of_admission character varying, p_address character varying, p_contact_number character varying, p_email_id character varying, p_department_name character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin (
    roll_number character varying(8) NOT NULL,
    password character varying(255) NOT NULL,
    department character varying(255)
);


ALTER TABLE public.admin OWNER TO postgres;

--
-- Name: application; Type: TABLE; Schema: public; Owner: postgres
--

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

--
-- Name: application_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.application_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.application_id_seq OWNER TO postgres;

--
-- Name: application_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.application_id_seq OWNED BY public.application.id;


--
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    id integer NOT NULL,
    department_name character varying(255) NOT NULL,
    status character varying(20) DEFAULT 'pending'::character varying
);


ALTER TABLE public.department OWNER TO postgres;

--
-- Name: department_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department_details (
    id integer NOT NULL,
    student_roll_number character varying(10),
    department_name character varying(255),
    status character varying(20) DEFAULT 'pending'::character varying
);


ALTER TABLE public.department_details OWNER TO postgres;

--
-- Name: department_details_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.department_details_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.department_details_id_seq OWNER TO postgres;

--
-- Name: department_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.department_details_id_seq OWNED BY public.department_details.id;


--
-- Name: department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.department_id_seq OWNER TO postgres;

--
-- Name: department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.department_id_seq OWNED BY public.department.id;


--
-- Name: request_approval; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.request_approval (
    id integer NOT NULL,
    roll_number character varying(8) NOT NULL,
    department_name character varying(255) NOT NULL,
    status character varying(50) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.request_approval OWNER TO postgres;

--
-- Name: request_approval_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.request_approval_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.request_approval_id_seq OWNER TO postgres;

--
-- Name: request_approval_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.request_approval_id_seq OWNED BY public.request_approval.id;


--
-- Name: student_profile; Type: TABLE; Schema: public; Owner: postgres
--

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

--
-- Name: application id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application ALTER COLUMN id SET DEFAULT nextval('public.application_id_seq'::regclass);


--
-- Name: department id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department ALTER COLUMN id SET DEFAULT nextval('public.department_id_seq'::regclass);


--
-- Name: department_details id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department_details ALTER COLUMN id SET DEFAULT nextval('public.department_details_id_seq'::regclass);


--
-- Name: request_approval id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.request_approval ALTER COLUMN id SET DEFAULT nextval('public.request_approval_id_seq'::regclass);


--
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (roll_number);


--
-- Name: application application_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application
    ADD CONSTRAINT application_pkey PRIMARY KEY (id);


--
-- Name: department_details department_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department_details
    ADD CONSTRAINT department_details_pkey PRIMARY KEY (id);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (id);


--
-- Name: request_approval request_approval_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.request_approval
    ADD CONSTRAINT request_approval_pkey PRIMARY KEY (id);


--
-- Name: student_profile student_profile_email_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_profile
    ADD CONSTRAINT student_profile_email_id_key UNIQUE (email_id);


--
-- Name: student_profile student_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_profile
    ADD CONSTRAINT student_profile_pkey PRIMARY KEY (roll_number);


--
-- Name: idx_roll_number; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_roll_number ON public.student_profile USING btree (roll_number);


--
-- Name: student_profile student_profile_after_insert; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER student_profile_after_insert AFTER INSERT ON public.student_profile FOR EACH ROW EXECUTE FUNCTION public.insert_into_department_details();


--
-- PostgreSQL database dump complete
--

