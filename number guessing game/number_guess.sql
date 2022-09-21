--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    game_guesses integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    user_name character varying(30) NOT NULL
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (1, 254, 1);
INSERT INTO public.games VALUES (2, 362, 1);
INSERT INTO public.games VALUES (3, 852, 2);
INSERT INTO public.games VALUES (4, 277, 2);
INSERT INTO public.games VALUES (5, 951, 1);
INSERT INTO public.games VALUES (6, 508, 1);
INSERT INTO public.games VALUES (7, 992, 1);
INSERT INTO public.games VALUES (8, 264, 3);
INSERT INTO public.games VALUES (9, 829, 3);
INSERT INTO public.games VALUES (10, 410, 4);
INSERT INTO public.games VALUES (11, 788, 4);
INSERT INTO public.games VALUES (12, 439, 3);
INSERT INTO public.games VALUES (13, 915, 3);
INSERT INTO public.games VALUES (14, 802, 3);
INSERT INTO public.games VALUES (15, 260, 5);
INSERT INTO public.games VALUES (16, 731, 5);
INSERT INTO public.games VALUES (17, 267, 6);
INSERT INTO public.games VALUES (18, 599, 6);
INSERT INTO public.games VALUES (19, 706, 5);
INSERT INTO public.games VALUES (20, 148, 5);
INSERT INTO public.games VALUES (21, 750, 5);
INSERT INTO public.games VALUES (22, 608, 7);
INSERT INTO public.games VALUES (23, 3, 7);
INSERT INTO public.games VALUES (24, 62, 8);
INSERT INTO public.games VALUES (25, 941, 8);
INSERT INTO public.games VALUES (26, 431, 7);
INSERT INTO public.games VALUES (27, 455, 7);
INSERT INTO public.games VALUES (28, 718, 7);
INSERT INTO public.games VALUES (29, 677, 9);
INSERT INTO public.games VALUES (30, 837, 9);
INSERT INTO public.games VALUES (31, 255, 10);
INSERT INTO public.games VALUES (32, 150, 10);
INSERT INTO public.games VALUES (33, 9, 9);
INSERT INTO public.games VALUES (34, 895, 9);
INSERT INTO public.games VALUES (35, 325, 9);
INSERT INTO public.games VALUES (36, 270, 11);
INSERT INTO public.games VALUES (37, 659, 11);
INSERT INTO public.games VALUES (38, 982, 12);
INSERT INTO public.games VALUES (39, 84, 12);
INSERT INTO public.games VALUES (40, 7, 11);
INSERT INTO public.games VALUES (41, 480, 11);
INSERT INTO public.games VALUES (42, 449, 11);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (1, 'user_1663785023016');
INSERT INTO public.users VALUES (2, 'user_1663785023015');
INSERT INTO public.users VALUES (3, 'user_1663785031246');
INSERT INTO public.users VALUES (4, 'user_1663785031245');
INSERT INTO public.users VALUES (5, 'user_1663785038362');
INSERT INTO public.users VALUES (6, 'user_1663785038361');
INSERT INTO public.users VALUES (7, 'user_1663785042733');
INSERT INTO public.users VALUES (8, 'user_1663785042732');
INSERT INTO public.users VALUES (9, 'user_1663785046310');
INSERT INTO public.users VALUES (10, 'user_1663785046309');
INSERT INTO public.users VALUES (11, 'user_1663785049687');
INSERT INTO public.users VALUES (12, 'user_1663785049686');


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 42, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 12, true);


--
-- PostgreSQL database dump complete
--

