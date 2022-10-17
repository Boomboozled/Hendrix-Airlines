PGDMP         &            	    z           postgres    14.5    14.4 6    @           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            A           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            B           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            C           1262    13754    postgres    DATABASE     l   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United States.1252';
    DROP DATABASE postgres;
                postgres    false            D           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3395                        3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            E           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2            �            1259    16458    account    TABLE     �  CREATE TABLE public.account (
    email character varying(30) NOT NULL,
    password character varying(40) NOT NULL,
    firstname character varying(30) NOT NULL,
    middlename character varying(30),
    lastname character varying(30) NOT NULL,
    suffix character varying(3),
    dob date NOT NULL,
    gender character(1) NOT NULL,
    address text NOT NULL,
    address2 text,
    phonenumber character varying(10) NOT NULL
);
    DROP TABLE public.account;
       public         heap    postgres    false            �            1259    16433    airport    TABLE     �   CREATE TABLE public.airport (
    code character(3) NOT NULL,
    numberofstaff integer NOT NULL,
    city character varying(20) NOT NULL,
    state character(2) NOT NULL
);
    DROP TABLE public.airport;
       public         heap    postgres    false            �            1259    16593    books    TABLE     �   CREATE TABLE public.books (
    email character varying(30) NOT NULL,
    flightno character(5) NOT NULL,
    confirmationno character(6) NOT NULL
);
    DROP TABLE public.books;
       public         heap    postgres    false            �            1259    16683 
   firstclass    TABLE     �   CREATE TABLE public.firstclass (
    regno character(6) NOT NULL,
    "row" character varying(2) NOT NULL,
    columnletter character(1) NOT NULL,
    status character varying(30) NOT NULL
);
    DROP TABLE public.firstclass;
       public         heap    postgres    false            �            1259    16526    flight    TABLE     �   CREATE TABLE public.flight (
    flightno character(5) NOT NULL,
    departure timestamp(0) without time zone NOT NULL,
    status character varying(10) NOT NULL,
    airport character(3)
);
    DROP TABLE public.flight;
       public         heap    postgres    false            �            1259    16438    gate    TABLE     k   CREATE TABLE public.gate (
    code character(3) NOT NULL,
    gatenumber character varying(3) NOT NULL
);
    DROP TABLE public.gate;
       public         heap    postgres    false            �            1259    16670 	   maincabin    TABLE       CREATE TABLE public.maincabin (
    regno character(6) NOT NULL,
    "row" character varying(2) NOT NULL,
    columnletter character(1) NOT NULL,
    status character varying(30) NOT NULL,
    type character varying(20) NOT NULL,
    exitrow boolean NOT NULL
);
    DROP TABLE public.maincabin;
       public         heap    postgres    false            �            1259    16608 	   passenger    TABLE     u  CREATE TABLE public.passenger (
    ticketno character(13) NOT NULL,
    firstname character varying(30) NOT NULL,
    middlename character varying(30),
    lastname character varying(30) NOT NULL,
    dob date NOT NULL,
    gender character(1) NOT NULL,
    country character varying(30) NOT NULL,
    state character(2) NOT NULL,
    checkedbags numeric(1,0) NOT NULL
);
    DROP TABLE public.passenger;
       public         heap    postgres    false            �            1259    16426    pilot    TABLE     v  CREATE TABLE public.pilot (
    eid character(7) NOT NULL,
    firstname character varying(30) NOT NULL,
    middlename character varying(30) NOT NULL,
    lastname character varying(30) NOT NULL,
    dob date NOT NULL,
    gender character varying(10) NOT NULL,
    address text NOT NULL,
    phonenumber character varying(10) NOT NULL,
    salary numeric(8,2) NOT NULL
);
    DROP TABLE public.pilot;
       public         heap    postgres    false            �            1259    16660    plane    TABLE     �   CREATE TABLE public.plane (
    regno character(6) NOT NULL,
    model character varying(8) NOT NULL,
    maincabinseats integer NOT NULL,
    firstclassseats integer NOT NULL,
    airportcode character(3)
);
    DROP TABLE public.plane;
       public         heap    postgres    false            �            1259    16620    trip    TABLE     
  CREATE TABLE public.trip (
    email character varying(30) NOT NULL,
    flightno character(5) NOT NULL,
    passenger1 character(13) NOT NULL,
    passenger2 character(13),
    passenger3 character(13),
    passenger4 character(13),
    passenger5 character(13)
);
    DROP TABLE public.trip;
       public         heap    postgres    false            6          0    16458    account 
   TABLE DATA           �   COPY public.account (email, password, firstname, middlename, lastname, suffix, dob, gender, address, address2, phonenumber) FROM stdin;
    public          postgres    false    213    C       4          0    16433    airport 
   TABLE DATA           C   COPY public.airport (code, numberofstaff, city, state) FROM stdin;
    public          postgres    false    211   cC       8          0    16593    books 
   TABLE DATA           @   COPY public.books (email, flightno, confirmationno) FROM stdin;
    public          postgres    false    215   �C       =          0    16683 
   firstclass 
   TABLE DATA           H   COPY public.firstclass (regno, "row", columnletter, status) FROM stdin;
    public          postgres    false    220   D       7          0    16526    flight 
   TABLE DATA           F   COPY public.flight (flightno, departure, status, airport) FROM stdin;
    public          postgres    false    214   8D       5          0    16438    gate 
   TABLE DATA           0   COPY public.gate (code, gatenumber) FROM stdin;
    public          postgres    false    212   �D       <          0    16670 	   maincabin 
   TABLE DATA           V   COPY public.maincabin (regno, "row", columnletter, status, type, exitrow) FROM stdin;
    public          postgres    false    219   &E       9          0    16608 	   passenger 
   TABLE DATA           x   COPY public.passenger (ticketno, firstname, middlename, lastname, dob, gender, country, state, checkedbags) FROM stdin;
    public          postgres    false    216   CE       3          0    16426    pilot 
   TABLE DATA           p   COPY public.pilot (eid, firstname, middlename, lastname, dob, gender, address, phonenumber, salary) FROM stdin;
    public          postgres    false    210   `E       ;          0    16660    plane 
   TABLE DATA           [   COPY public.plane (regno, model, maincabinseats, firstclassseats, airportcode) FROM stdin;
    public          postgres    false    218   }E       :          0    16620    trip 
   TABLE DATA           k   COPY public.trip (email, flightno, passenger1, passenger2, passenger3, passenger4, passenger5) FROM stdin;
    public          postgres    false    217   �E       �           2606    16464    account account_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (email);
 >   ALTER TABLE ONLY public.account DROP CONSTRAINT account_pkey;
       public            postgres    false    213            �           2606    16516    airport airport_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.airport
    ADD CONSTRAINT airport_pkey PRIMARY KEY (code);
 >   ALTER TABLE ONLY public.airport DROP CONSTRAINT airport_pkey;
       public            postgres    false    211            �           2606    16597    books books_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (email, flightno);
 :   ALTER TABLE ONLY public.books DROP CONSTRAINT books_pkey;
       public            postgres    false    215    215            �           2606    16687    firstclass firstclass_pk 
   CONSTRAINT     n   ALTER TABLE ONLY public.firstclass
    ADD CONSTRAINT firstclass_pk PRIMARY KEY (regno, "row", columnletter);
 B   ALTER TABLE ONLY public.firstclass DROP CONSTRAINT firstclass_pk;
       public            postgres    false    220    220    220            �           2606    16588    flight flightexample_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flightexample_pkey PRIMARY KEY (flightno);
 C   ALTER TABLE ONLY public.flight DROP CONSTRAINT flightexample_pkey;
       public            postgres    false    214            �           2606    16582    gate gate_pk 
   CONSTRAINT     X   ALTER TABLE ONLY public.gate
    ADD CONSTRAINT gate_pk PRIMARY KEY (code, gatenumber);
 6   ALTER TABLE ONLY public.gate DROP CONSTRAINT gate_pk;
       public            postgres    false    212    212            �           2606    16674    maincabin maincabin_pk 
   CONSTRAINT     l   ALTER TABLE ONLY public.maincabin
    ADD CONSTRAINT maincabin_pk PRIMARY KEY (regno, "row", columnletter);
 @   ALTER TABLE ONLY public.maincabin DROP CONSTRAINT maincabin_pk;
       public            postgres    false    219    219    219            �           2606    16612    passenger passenger_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.passenger
    ADD CONSTRAINT passenger_pkey PRIMARY KEY (ticketno);
 B   ALTER TABLE ONLY public.passenger DROP CONSTRAINT passenger_pkey;
       public            postgres    false    216            �           2606    16432    pilot pilot_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY public.pilot
    ADD CONSTRAINT pilot_pkey PRIMARY KEY (eid);
 :   ALTER TABLE ONLY public.pilot DROP CONSTRAINT pilot_pkey;
       public            postgres    false    210            �           2606    16664    plane plane_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.plane
    ADD CONSTRAINT plane_pkey PRIMARY KEY (regno);
 :   ALTER TABLE ONLY public.plane DROP CONSTRAINT plane_pkey;
       public            postgres    false    218            �           2606    16624    trip trip_pk 
   CONSTRAINT     W   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_pk PRIMARY KEY (email, flightno);
 6   ALTER TABLE ONLY public.trip DROP CONSTRAINT trip_pk;
       public            postgres    false    217    217            �           2606    16598    books books_email_fkey    FK CONSTRAINT     x   ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_email_fkey FOREIGN KEY (email) REFERENCES public.account(email);
 @   ALTER TABLE ONLY public.books DROP CONSTRAINT books_email_fkey;
       public          postgres    false    3211    215    213            �           2606    16603    books books_flightno_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_flightno_fkey FOREIGN KEY (flightno) REFERENCES public.flight(flightno);
 C   ALTER TABLE ONLY public.books DROP CONSTRAINT books_flightno_fkey;
       public          postgres    false    214    3213    215            �           2606    16688     firstclass firstclass_regno_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.firstclass
    ADD CONSTRAINT firstclass_regno_fkey FOREIGN KEY (regno) REFERENCES public.plane(regno) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.firstclass DROP CONSTRAINT firstclass_regno_fkey;
       public          postgres    false    218    3221    220            �           2606    16531 !   flight flightexample_airport_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flightexample_airport_fkey FOREIGN KEY (airport) REFERENCES public.airport(code);
 K   ALTER TABLE ONLY public.flight DROP CONSTRAINT flightexample_airport_fkey;
       public          postgres    false    214    3207    211            �           2606    16538    gate gate_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.gate
    ADD CONSTRAINT gate_code_fkey FOREIGN KEY (code) REFERENCES public.airport(code) ON DELETE CASCADE;
 =   ALTER TABLE ONLY public.gate DROP CONSTRAINT gate_code_fkey;
       public          postgres    false    212    211    3207            �           2606    16675    maincabin maincabin_regno_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.maincabin
    ADD CONSTRAINT maincabin_regno_fkey FOREIGN KEY (regno) REFERENCES public.plane(regno) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.maincabin DROP CONSTRAINT maincabin_regno_fkey;
       public          postgres    false    219    218    3221            �           2606    16665    plane plane_airportcode_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.plane
    ADD CONSTRAINT plane_airportcode_fkey FOREIGN KEY (airportcode) REFERENCES public.airport(code);
 F   ALTER TABLE ONLY public.plane DROP CONSTRAINT plane_airportcode_fkey;
       public          postgres    false    218    211    3207            �           2606    16625    trip trip_email_fkey    FK CONSTRAINT     v   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_email_fkey FOREIGN KEY (email) REFERENCES public.account(email);
 >   ALTER TABLE ONLY public.trip DROP CONSTRAINT trip_email_fkey;
       public          postgres    false    3211    213    217            �           2606    16630    trip trip_flightno_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_flightno_fkey FOREIGN KEY (flightno) REFERENCES public.flight(flightno);
 A   ALTER TABLE ONLY public.trip DROP CONSTRAINT trip_flightno_fkey;
       public          postgres    false    214    217    3213            �           2606    16635    trip trip_passenger1_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_passenger1_fkey FOREIGN KEY (passenger1) REFERENCES public.passenger(ticketno);
 C   ALTER TABLE ONLY public.trip DROP CONSTRAINT trip_passenger1_fkey;
       public          postgres    false    217    216    3217            �           2606    16640    trip trip_passenger2_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_passenger2_fkey FOREIGN KEY (passenger2) REFERENCES public.passenger(ticketno);
 C   ALTER TABLE ONLY public.trip DROP CONSTRAINT trip_passenger2_fkey;
       public          postgres    false    216    217    3217            �           2606    16645    trip trip_passenger3_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_passenger3_fkey FOREIGN KEY (passenger3) REFERENCES public.passenger(ticketno);
 C   ALTER TABLE ONLY public.trip DROP CONSTRAINT trip_passenger3_fkey;
       public          postgres    false    3217    217    216            �           2606    16650    trip trip_passenger4_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_passenger4_fkey FOREIGN KEY (passenger4) REFERENCES public.passenger(ticketno);
 C   ALTER TABLE ONLY public.trip DROP CONSTRAINT trip_passenger4_fkey;
       public          postgres    false    3217    217    216            �           2606    16655    trip trip_passenger5_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_passenger5_fkey FOREIGN KEY (passenger5) REFERENCES public.passenger(ticketno);
 C   ALTER TABLE ONLY public.trip DROP CONSTRAINT trip_passenger5_fkey;
       public          postgres    false    216    3217    217            6   S   x�+�L-rH�M���K����H�K)ʬP6�,Jp�p�U���q��q���q�r&����F��0����� 
m�      4   �   x��K
�@��u�)r�<@c�ND�@�4�H I:��q��T�2\�(�G���9����.*c�P��Sg�+��
��2�����J���Ƿ��`��C�v?͖Y_:���tRW�"G���%7���ߢezn����)      8      x������ � �      =      x������ � �      7   i   x�34261�4202�54�5�P04�22�20������M�	p�25162��2�20�2�rI�I�LM��2F�2�2�20AWefif�Pe`�`d����͛+F��� ]="      5   e   x�5�=�0�Yc�?&�`��Mt�������K�=(��T*x@l("+H`���h�y�T�z��Ć*"����#��=�X# ���dzG"� �d-�      <      x������ � �      9      x������ � �      3      x������ � �      ;   r   x�m�1�0��>L���D��t����邢�^�$�uHT��JRڿ�c��S!q�s�J��em�O���ҡ��ɛ��hIcS˱yj�*x��@�٧�|���\('�      :      x������ � �     