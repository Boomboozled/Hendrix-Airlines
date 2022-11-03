PGDMP                     
    z           postgres    14.5    14.4 ,    1           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            2           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            3           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            4           1262    16748    postgres    DATABASE     l   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United States.1252';
    DROP DATABASE postgres;
                postgres    false                        3079    16749 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            5           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2            �            1259    16759    account    TABLE     P  CREATE TABLE public.account (
    email character varying(30) NOT NULL,
    password character varying(40) NOT NULL,
    first_name character varying(30) NOT NULL,
    middle_name character varying(30),
    last_name character varying(30) NOT NULL,
    suffix character varying(10),
    dob date NOT NULL,
    gender character(1) NOT NULL,
    address text NOT NULL,
    address2 text,
    phone_number character varying(20) NOT NULL,
    city character varying(30) NOT NULL,
    zip character(5) NOT NULL,
    state character varying(30) NOT NULL,
    type character varying(30) NOT NULL
);
    DROP TABLE public.account;
       public         heap    postgres    false            �            1259    16764    airport    TABLE     �   CREATE TABLE public.airport (
    code character(3) NOT NULL,
    number_of_staff integer NOT NULL,
    city character varying(20) NOT NULL,
    state character(2) NOT NULL
);
    DROP TABLE public.airport;
       public         heap    postgres    false            �            1259    16773    flight    TABLE     �  CREATE TABLE public.flight (
    flight_no character(5) NOT NULL,
    departure timestamp(0) without time zone NOT NULL,
    status character varying(10) NOT NULL,
    source_gate_code character(3) NOT NULL,
    source_gate_number character varying(3) NOT NULL,
    destination_gate_number character varying(3) NOT NULL,
    destination_gate_code character(3) NOT NULL,
    arrival timestamp(0) without time zone NOT NULL,
    passengers integer NOT NULL,
    regno character(6) NOT NULL
);
    DROP TABLE public.flight;
       public         heap    postgres    false            �            1259    16776    gate    TABLE     k   CREATE TABLE public.gate (
    code character(3) NOT NULL,
    gatenumber character varying(3) NOT NULL
);
    DROP TABLE public.gate;
       public         heap    postgres    false            �            1259    16782 	   passenger    TABLE     u  CREATE TABLE public.passenger (
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
       public         heap    postgres    false            �            1259    16785    pilot    TABLE     v  CREATE TABLE public.pilot (
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
       public         heap    postgres    false            �            1259    16790    plane    TABLE     �   CREATE TABLE public.plane (
    regno character(6) NOT NULL,
    model character varying(8) NOT NULL,
    maincabinseats integer NOT NULL,
    firstclassseats integer NOT NULL,
    airportcode character(3)
);
    DROP TABLE public.plane;
       public         heap    postgres    false            �            1259    16779    seat    TABLE     /  CREATE TABLE public.seat (
    regno character(6) NOT NULL,
    "row" character varying(2) NOT NULL,
    columnletter character(1) NOT NULL,
    status character varying(30) NOT NULL,
    type character varying(20),
    exitrow boolean,
    isfirstclass boolean NOT NULL,
    passenger character(13)
);
    DROP TABLE public.seat;
       public         heap    postgres    false            �            1259    16893    trip    TABLE     ,  CREATE TABLE public.trip (
    email character varying(30) NOT NULL,
    flightno character(5) NOT NULL,
    passenger1 character(13) NOT NULL,
    passenger2 character(13),
    passenger3 character(13),
    passenger4 character(13),
    passenger5 character(13),
    confirmation_no character(6)
);
    DROP TABLE public.trip;
       public         heap    postgres    false            &          0    16759    account 
   TABLE DATA           �   COPY public.account (email, password, first_name, middle_name, last_name, suffix, dob, gender, address, address2, phone_number, city, zip, state, type) FROM stdin;
    public          postgres    false    210   9       '          0    16764    airport 
   TABLE DATA           E   COPY public.airport (code, number_of_staff, city, state) FROM stdin;
    public          postgres    false    211   :       (          0    16773    flight 
   TABLE DATA           �   COPY public.flight (flight_no, departure, status, source_gate_code, source_gate_number, destination_gate_number, destination_gate_code, arrival, passengers, regno) FROM stdin;
    public          postgres    false    212   �:       )          0    16776    gate 
   TABLE DATA           0   COPY public.gate (code, gatenumber) FROM stdin;
    public          postgres    false    213   �;       +          0    16782 	   passenger 
   TABLE DATA           x   COPY public.passenger (ticketno, firstname, middlename, lastname, dob, gender, country, state, checkedbags) FROM stdin;
    public          postgres    false    215   <       ,          0    16785    pilot 
   TABLE DATA           p   COPY public.pilot (eid, firstname, middlename, lastname, dob, gender, address, phonenumber, salary) FROM stdin;
    public          postgres    false    216   6<       -          0    16790    plane 
   TABLE DATA           [   COPY public.plane (regno, model, maincabinseats, firstclassseats, airportcode) FROM stdin;
    public          postgres    false    217   S<       *          0    16779    seat 
   TABLE DATA           j   COPY public.seat (regno, "row", columnletter, status, type, exitrow, isfirstclass, passenger) FROM stdin;
    public          postgres    false    214   �<       .          0    16893    trip 
   TABLE DATA           |   COPY public.trip (email, flightno, passenger1, passenger2, passenger3, passenger4, passenger5, confirmation_no) FROM stdin;
    public          postgres    false    218   =       }           2606    16797    account account_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (email);
 >   ALTER TABLE ONLY public.account DROP CONSTRAINT account_pkey;
       public            postgres    false    210                       2606    16799    airport airport_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.airport
    ADD CONSTRAINT airport_pkey PRIMARY KEY (code);
 >   ALTER TABLE ONLY public.airport DROP CONSTRAINT airport_pkey;
       public            postgres    false    211            �           2606    16914    flight flight_regno_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flight_regno_key UNIQUE (regno);
 A   ALTER TABLE ONLY public.flight DROP CONSTRAINT flight_regno_key;
       public            postgres    false    212            �           2606    16805    flight flightexample_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flightexample_pkey PRIMARY KEY (flight_no);
 C   ALTER TABLE ONLY public.flight DROP CONSTRAINT flightexample_pkey;
       public            postgres    false    212            �           2606    16807    gate gate_pk 
   CONSTRAINT     X   ALTER TABLE ONLY public.gate
    ADD CONSTRAINT gate_pk PRIMARY KEY (code, gatenumber);
 6   ALTER TABLE ONLY public.gate DROP CONSTRAINT gate_pk;
       public            postgres    false    213    213            �           2606    16809    seat maincabin_pk 
   CONSTRAINT     g   ALTER TABLE ONLY public.seat
    ADD CONSTRAINT maincabin_pk PRIMARY KEY (regno, "row", columnletter);
 ;   ALTER TABLE ONLY public.seat DROP CONSTRAINT maincabin_pk;
       public            postgres    false    214    214    214            �           2606    16811    passenger passenger_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.passenger
    ADD CONSTRAINT passenger_pkey PRIMARY KEY (ticketno);
 B   ALTER TABLE ONLY public.passenger DROP CONSTRAINT passenger_pkey;
       public            postgres    false    215            �           2606    16813    pilot pilot_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY public.pilot
    ADD CONSTRAINT pilot_pkey PRIMARY KEY (eid);
 :   ALTER TABLE ONLY public.pilot DROP CONSTRAINT pilot_pkey;
       public            postgres    false    216            �           2606    16815    plane plane_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.plane
    ADD CONSTRAINT plane_pkey PRIMARY KEY (regno);
 :   ALTER TABLE ONLY public.plane DROP CONSTRAINT plane_pkey;
       public            postgres    false    217            �           2606    16921    seat seat_passenger_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.seat
    ADD CONSTRAINT seat_passenger_key UNIQUE (passenger);
 A   ALTER TABLE ONLY public.seat DROP CONSTRAINT seat_passenger_key;
       public            postgres    false    214            �           2606    16897    trip trip_pk 
   CONSTRAINT     W   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_pk PRIMARY KEY (email, flightno);
 6   ALTER TABLE ONLY public.trip DROP CONSTRAINT trip_pk;
       public            postgres    false    218    218            �           2606    16828    flight destination_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flight
    ADD CONSTRAINT destination_fk FOREIGN KEY (destination_gate_code, destination_gate_number) REFERENCES public.gate(code, gatenumber);
 ?   ALTER TABLE ONLY public.flight DROP CONSTRAINT destination_fk;
       public          postgres    false    212    213    213    3205    212            �           2606    16838    flight flight_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flight_fk FOREIGN KEY (source_gate_code, source_gate_number) REFERENCES public.gate(code, gatenumber);
 :   ALTER TABLE ONLY public.flight DROP CONSTRAINT flight_fk;
       public          postgres    false    3205    212    212    213    213            �           2606    16908    flight flight_regno_fkey    FK CONSTRAINT     x   ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flight_regno_fkey FOREIGN KEY (regno) REFERENCES public.plane(regno);
 B   ALTER TABLE ONLY public.flight DROP CONSTRAINT flight_regno_fkey;
       public          postgres    false    217    212    3215            �           2606    16843    gate gate_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.gate
    ADD CONSTRAINT gate_code_fkey FOREIGN KEY (code) REFERENCES public.airport(code) ON DELETE CASCADE;
 =   ALTER TABLE ONLY public.gate DROP CONSTRAINT gate_code_fkey;
       public          postgres    false    3199    213    211            �           2606    16848    seat maincabin_regno_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.seat
    ADD CONSTRAINT maincabin_regno_fkey FOREIGN KEY (regno) REFERENCES public.plane(regno) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.seat DROP CONSTRAINT maincabin_regno_fkey;
       public          postgres    false    217    3215    214            �           2606    16853    plane plane_airportcode_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.plane
    ADD CONSTRAINT plane_airportcode_fkey FOREIGN KEY (airportcode) REFERENCES public.airport(code);
 F   ALTER TABLE ONLY public.plane DROP CONSTRAINT plane_airportcode_fkey;
       public          postgres    false    217    211    3199            �           2606    16922    seat seat_passenger_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.seat
    ADD CONSTRAINT seat_passenger_fkey FOREIGN KEY (passenger) REFERENCES public.passenger(ticketno);
 B   ALTER TABLE ONLY public.seat DROP CONSTRAINT seat_passenger_fkey;
       public          postgres    false    3211    214    215            �           2606    16898    trip trip_email_fkey    FK CONSTRAINT     v   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_email_fkey FOREIGN KEY (email) REFERENCES public.account(email);
 >   ALTER TABLE ONLY public.trip DROP CONSTRAINT trip_email_fkey;
       public          postgres    false    218    3197    210            �           2606    16903    trip trip_flightno_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_flightno_fkey FOREIGN KEY (flightno) REFERENCES public.flight(flight_no);
 A   ALTER TABLE ONLY public.trip DROP CONSTRAINT trip_flightno_fkey;
       public          postgres    false    3203    212    218            &   �   x�u��N�0E�7_a��#�����>D�`��ذ1�ۺ�	�IK�z ;�Ռ�tϙ�l��vM��<nlk����)�A{�m�c�2Ny	mL�1�q���Q�7.�*�i���FmȎ���4��!�t�{���VP&�`����eKV��,0�򻽬�g�?��>�rkz���5��~{rM��dy�f2j��k�ٴ�LQ�V	&�:'����@'����k"_�$:��T!M�,��h��wm��gY�'g�      '   �   x��K
�@��u�)r�<@c�ND�@�4�H I:��q��T�2\�(�G���9����.*c�P��Sg�+��
��2�����J���Ƿ��`��C�v?͖Y_:���tRW�"G���%7���ߢezn����)      (   �   x��пj�0��Y�~��ݝ�ț!dH�v0t���Bӽo�d�PpZ��_>�D-a��ʺ��=sx�n���Ʒ!��/���1y��tMs�8�V���u����0���^1)تg{�u~[�.u銱5"� �D���	�����wV���:���|���s�1��~.�]���!c&\�[��/��O�;�`����E�F��&x����ue��L�&��BDg.�[      )   e   x�5�=�0�Yc�?&�`��Mt�������K�=(��T*x@l("+H`���h�y�T�z��Ć*"����#��=�X# ���dzG"� �d-�      +      x������ � �      ,      x������ � �      -   �   x�m�K
�0���0���N�6��B!�v����VR�q��F��XtJ�Ys1���mTgbY�G���� ��i�`��m���J���Q��l�v�H(Dgq�_�qW��x�N�%ZP�G#������Br      *      x������ � �      .      x������ � �     