PGDMP     0                
    z            postgres    14.5    14.4 6    ;           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            <           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            =           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            >           1262    25862    postgres    DATABASE     l   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United States.1252';
    DROP DATABASE postgres;
                postgres    false                        3079    25863 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            ?           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2            �            1255    25873    canceltrip(character)    FUNCTION       CREATE FUNCTION public.canceltrip(confirm_no character) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  p1 char(13);
  p2 char(13);
  p3 char(13);
  p4 char(13);
  p5 char(13);
  dep timestamp;
BEGIN
    select departure into dep from flight join trip on flight_no=flightno where confirmation_no=confirm_no;

    if dep - now() < interval '24 hours' then
        return 0;
    end if;

    select passenger1, passenger2, passenger3, passenger4, passenger5 into p1, p2, p3, p4, p5 from trip where confirmation_no=confirm_no;

    update seat set passenger = null where passenger in (p1, p2, p3, p4, p5);
    
    delete from trip where confirmation_no=confirm_no;
    
    delete from passenger where ticketno in (p1, p2, p3, p4, p5);
    
    return 1;
END;
$$;
 7   DROP FUNCTION public.canceltrip(confirm_no character);
       public          postgres    false            �            1255    25874    check_same_passenger()    FUNCTION       CREATE FUNCTION public.check_same_passenger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF EXISTS(select count(*) 
			from trip join passenger on passenger1=ticketno 
			or passenger2=ticketno 
			or passenger3=ticketno 
			or passenger4=ticketno 
			or passenger5=ticketno 
			where email=NEW.email and flightno=NEW.flightno 
			group by firstname, middlename, lastname, dob, gender having count(*) > 1) THEN
				RAISE EXCEPTION 'duplicate passengers';
				RETURN NULL;
        END IF;
        RETURN NEW;
    END;
$$;
 -   DROP FUNCTION public.check_same_passenger();
       public          postgres    false            �            1255    26003 +   generateplane(character, character varying) 	   PROCEDURE     4  CREATE PROCEDURE public.generateplane(IN regno character, IN model character varying DEFAULT 'B747'::character varying)
    LANGUAGE plpgsql
    AS $$

DECLARE

col char;

BEGIN
    
    INSERT INTO PLANE VALUES (regno, model, null);
    IF model = 'B747' THEN

    FOR i IN 1..4 LOOP --rows
        
        FOREACH COL IN ARRAY ARRAY['A','B','C','D'] LOOP -- columns

            INSERT INTO SEAT VALUES (regno, i, col, 'type placeholder', false, false, null);
        END LOOP;
    END LOOP;
    
        --add elsif later for other models
    END IF;

END
$$;
 U   DROP PROCEDURE public.generateplane(IN regno character, IN model character varying);
       public          postgres    false            �            1259    25875    account    TABLE     '  CREATE TABLE public.account (
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
    state character varying(30) NOT NULL
);
    DROP TABLE public.account;
       public         heap    postgres    false            �            1259    25880    airport    TABLE     �   CREATE TABLE public.airport (
    code character(3) NOT NULL,
    number_of_staff integer NOT NULL,
    city character varying(20) NOT NULL,
    state character(2) NOT NULL
);
    DROP TABLE public.airport;
       public         heap    postgres    false            �            1259    25883    credit_card    TABLE     �   CREATE TABLE public.credit_card (
    card_number character(16) NOT NULL,
    exp_date date NOT NULL,
    cvv character(3) NOT NULL,
    zip character(5) NOT NULL,
    name character varying(50) NOT NULL,
    account character varying(30) NOT NULL
);
    DROP TABLE public.credit_card;
       public         heap    postgres    false            �            1259    25886    flight    TABLE     �  CREATE TABLE public.flight (
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
       public         heap    postgres    false            �            1259    25889    gate    TABLE     k   CREATE TABLE public.gate (
    code character(3) NOT NULL,
    gatenumber character varying(3) NOT NULL
);
    DROP TABLE public.gate;
       public         heap    postgres    false            �            1259    25892 	   passenger    TABLE     R  CREATE TABLE public.passenger (
    ticketno character(13) NOT NULL,
    firstname character varying(30) NOT NULL,
    middlename character varying(30),
    lastname character varying(30) NOT NULL,
    dob date NOT NULL,
    gender character(1) NOT NULL,
    state character varying(30) NOT NULL,
    checkedbags numeric(1,0) NOT NULL
);
    DROP TABLE public.passenger;
       public         heap    postgres    false            �            1259    25895    plane    TABLE     �   CREATE TABLE public.plane (
    regno character(6) NOT NULL,
    model character varying(8) NOT NULL,
    airportcode character(3)
);
    DROP TABLE public.plane;
       public         heap    postgres    false            �            1259    25898    seat    TABLE       CREATE TABLE public.seat (
    regno character(6) NOT NULL,
    "row" character varying(2) NOT NULL,
    columnletter character(1) NOT NULL,
    type character varying(20),
    exitrow boolean,
    isfirstclass boolean NOT NULL,
    passenger character(13)
);
    DROP TABLE public.seat;
       public         heap    postgres    false            �            1259    25901    trip    TABLE     5  CREATE TABLE public.trip (
    email character varying(30) NOT NULL,
    flightno character(5) NOT NULL,
    passenger1 character(13) NOT NULL,
    passenger2 character(13),
    passenger3 character(13),
    passenger4 character(13),
    passenger5 character(13),
    confirmation_no character(6) NOT NULL
);
    DROP TABLE public.trip;
       public         heap    postgres    false            0          0    25875    account 
   TABLE DATA           �   COPY public.account (email, password, first_name, middle_name, last_name, suffix, dob, gender, address, address2, phone_number, city, zip, state) FROM stdin;
    public          postgres    false    210   }K       1          0    25880    airport 
   TABLE DATA           E   COPY public.airport (code, number_of_staff, city, state) FROM stdin;
    public          postgres    false    211   �L       2          0    25883    credit_card 
   TABLE DATA           U   COPY public.credit_card (card_number, exp_date, cvv, zip, name, account) FROM stdin;
    public          postgres    false    212   bM       3          0    25886    flight 
   TABLE DATA           �   COPY public.flight (flight_no, departure, status, source_gate_code, source_gate_number, destination_gate_number, destination_gate_code, arrival, passengers, regno) FROM stdin;
    public          postgres    false    213   �M       4          0    25889    gate 
   TABLE DATA           0   COPY public.gate (code, gatenumber) FROM stdin;
    public          postgres    false    214   �N       5          0    25892 	   passenger 
   TABLE DATA           o   COPY public.passenger (ticketno, firstname, middlename, lastname, dob, gender, state, checkedbags) FROM stdin;
    public          postgres    false    215   BO       6          0    25895    plane 
   TABLE DATA           :   COPY public.plane (regno, model, airportcode) FROM stdin;
    public          postgres    false    216   �O       7          0    25898    seat 
   TABLE DATA           b   COPY public.seat (regno, "row", columnletter, type, exitrow, isfirstclass, passenger) FROM stdin;
    public          postgres    false    217   �P       8          0    25901    trip 
   TABLE DATA           |   COPY public.trip (email, flightno, passenger1, passenger2, passenger3, passenger4, passenger5, confirmation_no) FROM stdin;
    public          postgres    false    218   �Q       �           2606    25905    account account_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (email);
 >   ALTER TABLE ONLY public.account DROP CONSTRAINT account_pkey;
       public            postgres    false    210            �           2606    25907    airport airport_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.airport
    ADD CONSTRAINT airport_pkey PRIMARY KEY (code);
 >   ALTER TABLE ONLY public.airport DROP CONSTRAINT airport_pkey;
       public            postgres    false    211            �           2606    25909    credit_card credit_card_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.credit_card
    ADD CONSTRAINT credit_card_pkey PRIMARY KEY (card_number);
 F   ALTER TABLE ONLY public.credit_card DROP CONSTRAINT credit_card_pkey;
       public            postgres    false    212            �           2606    25911    flight flight_regno_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flight_regno_key UNIQUE (regno);
 A   ALTER TABLE ONLY public.flight DROP CONSTRAINT flight_regno_key;
       public            postgres    false    213            �           2606    25913    flight flightexample_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flightexample_pkey PRIMARY KEY (flight_no);
 C   ALTER TABLE ONLY public.flight DROP CONSTRAINT flightexample_pkey;
       public            postgres    false    213            �           2606    25915    gate gate_pk 
   CONSTRAINT     X   ALTER TABLE ONLY public.gate
    ADD CONSTRAINT gate_pk PRIMARY KEY (code, gatenumber);
 6   ALTER TABLE ONLY public.gate DROP CONSTRAINT gate_pk;
       public            postgres    false    214    214            �           2606    25917    seat maincabin_pk 
   CONSTRAINT     g   ALTER TABLE ONLY public.seat
    ADD CONSTRAINT maincabin_pk PRIMARY KEY (regno, "row", columnletter);
 ;   ALTER TABLE ONLY public.seat DROP CONSTRAINT maincabin_pk;
       public            postgres    false    217    217    217            �           2606    25919    passenger passenger_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.passenger
    ADD CONSTRAINT passenger_pkey PRIMARY KEY (ticketno);
 B   ALTER TABLE ONLY public.passenger DROP CONSTRAINT passenger_pkey;
       public            postgres    false    215            �           2606    25921    plane plane_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.plane
    ADD CONSTRAINT plane_pkey PRIMARY KEY (regno);
 :   ALTER TABLE ONLY public.plane DROP CONSTRAINT plane_pkey;
       public            postgres    false    216            �           2606    25923    seat seat_passenger_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.seat
    ADD CONSTRAINT seat_passenger_key UNIQUE (passenger);
 A   ALTER TABLE ONLY public.seat DROP CONSTRAINT seat_passenger_key;
       public            postgres    false    217            �           2606    25925    trip trip_pk 
   CONSTRAINT     W   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_pk PRIMARY KEY (confirmation_no);
 6   ALTER TABLE ONLY public.trip DROP CONSTRAINT trip_pk;
       public            postgres    false    218            �           2620    25926    trip check_trip_insert    TRIGGER     z   CREATE TRIGGER check_trip_insert AFTER INSERT ON public.trip FOR EACH ROW EXECUTE FUNCTION public.check_same_passenger();
 /   DROP TRIGGER check_trip_insert ON public.trip;
       public          postgres    false    223    218            �           2606    25927 $   credit_card credit_card_account_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.credit_card
    ADD CONSTRAINT credit_card_account_fkey FOREIGN KEY (account) REFERENCES public.account(email);
 N   ALTER TABLE ONLY public.credit_card DROP CONSTRAINT credit_card_account_fkey;
       public          postgres    false    210    212    3200            �           2606    25932    flight destination_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flight
    ADD CONSTRAINT destination_fk FOREIGN KEY (destination_gate_code, destination_gate_number) REFERENCES public.gate(code, gatenumber);
 ?   ALTER TABLE ONLY public.flight DROP CONSTRAINT destination_fk;
       public          postgres    false    213    214    213    214    3210            �           2606    25937    flight flight_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flight_fk FOREIGN KEY (source_gate_code, source_gate_number) REFERENCES public.gate(code, gatenumber);
 :   ALTER TABLE ONLY public.flight DROP CONSTRAINT flight_fk;
       public          postgres    false    214    213    213    3210    214            �           2606    25942    flight flight_regno_fkey    FK CONSTRAINT     x   ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flight_regno_fkey FOREIGN KEY (regno) REFERENCES public.plane(regno);
 B   ALTER TABLE ONLY public.flight DROP CONSTRAINT flight_regno_fkey;
       public          postgres    false    3214    216    213            �           2606    25947    gate gate_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.gate
    ADD CONSTRAINT gate_code_fkey FOREIGN KEY (code) REFERENCES public.airport(code) ON DELETE CASCADE;
 =   ALTER TABLE ONLY public.gate DROP CONSTRAINT gate_code_fkey;
       public          postgres    false    3202    214    211            �           2606    25952    seat maincabin_regno_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.seat
    ADD CONSTRAINT maincabin_regno_fkey FOREIGN KEY (regno) REFERENCES public.plane(regno) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.seat DROP CONSTRAINT maincabin_regno_fkey;
       public          postgres    false    3214    216    217            �           2606    25957    trip passenger1_fk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT passenger1_fk FOREIGN KEY (passenger1) REFERENCES public.passenger(ticketno);
 <   ALTER TABLE ONLY public.trip DROP CONSTRAINT passenger1_fk;
       public          postgres    false    215    218    3212            �           2606    25962    trip passenger2_fk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT passenger2_fk FOREIGN KEY (passenger2) REFERENCES public.passenger(ticketno);
 <   ALTER TABLE ONLY public.trip DROP CONSTRAINT passenger2_fk;
       public          postgres    false    3212    218    215            �           2606    25967    trip passenger3_fk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT passenger3_fk FOREIGN KEY (passenger3) REFERENCES public.passenger(ticketno);
 <   ALTER TABLE ONLY public.trip DROP CONSTRAINT passenger3_fk;
       public          postgres    false    3212    215    218            �           2606    25972    trip passenger4_fk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT passenger4_fk FOREIGN KEY (passenger4) REFERENCES public.passenger(ticketno);
 <   ALTER TABLE ONLY public.trip DROP CONSTRAINT passenger4_fk;
       public          postgres    false    215    218    3212            �           2606    25977    trip passenger5_fk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT passenger5_fk FOREIGN KEY (passenger5) REFERENCES public.passenger(ticketno);
 <   ALTER TABLE ONLY public.trip DROP CONSTRAINT passenger5_fk;
       public          postgres    false    3212    218    215            �           2606    25982    plane plane_airportcode_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.plane
    ADD CONSTRAINT plane_airportcode_fkey FOREIGN KEY (airportcode) REFERENCES public.airport(code);
 F   ALTER TABLE ONLY public.plane DROP CONSTRAINT plane_airportcode_fkey;
       public          postgres    false    3202    211    216            �           2606    25987    seat seat_passenger_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.seat
    ADD CONSTRAINT seat_passenger_fkey FOREIGN KEY (passenger) REFERENCES public.passenger(ticketno);
 B   ALTER TABLE ONLY public.seat DROP CONSTRAINT seat_passenger_fkey;
       public          postgres    false    215    217    3212            �           2606    25992    trip trip_email_fkey    FK CONSTRAINT     v   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_email_fkey FOREIGN KEY (email) REFERENCES public.account(email);
 >   ALTER TABLE ONLY public.trip DROP CONSTRAINT trip_email_fkey;
       public          postgres    false    210    218    3200            �           2606    25997    trip trip_flightno_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_flightno_fkey FOREIGN KEY (flightno) REFERENCES public.flight(flight_no);
 A   ALTER TABLE ONLY public.trip DROP CONSTRAINT trip_flightno_fkey;
       public          postgres    false    218    3208    213            0   :  x�m��N�0E�7_a��#;S�E���H � 6l��m]b�_�����ֳ�=�)�F[-T���B�ʩ�3��`>��M�A�XL�<���*'�������"��$�0��S��J�E1.�pk�{��OtEe	���2^�I��AC�|烓5��O�m6��Z�j�ܼ9�U]+�Nw�
{,�K�b8�,�<��i�b2���k��� M+1�����)�G�� ��4K~!�$��=D�^[��k�y�R��1҅���0���"*#�P�s��Y-���DR�Z�����tI��I�F�)x�� ��T      1   �   x��K
�@��u�)r�<@c�ND�@�4�H I:��q��T�2\�(�G���9����.*c�P��Sg�+��
��2�����J���Ƿ��`��C�v?͖Y_:���tRW�"G���%7���ߢezn����)      2   W   x�34264142161!#N##3]]#KNC#c61�L�O����ͭtH�M���K����B4�P��H:M8�s1t��qqq {��      3   �   x��ѱN�0�9~��@���]��tb��J,,Ht@v����.BH=�����D-a��˾��#sx��総%̏S���8?}'�=�'9�����`��1��츼�|-��0����1)�nd��}�-ѐ�t��:��`�X����Jg���;+X����=#�1��Ĝp������LM��C�L�޷�_0#�����5�����&x������UL�ɀ;H�Y[Ȋi����Uz�!���q      4   e   x�5�=�0�Yc�?&�`��Mt�������K�=(��T*x@l("+H`���h�y�T�z��Ć*"����#��=�X# ���dzG"� �d-�      5   �   x�Mα� ���]j��ծ�1Ѥ�5qq�KQ0P*%�>�Mt����So�zۃA�����)[g4��Zh�ƀN %8oT4�2�%�K:��\@�Q���Fʾ�t��?R��T������l�EY^����Õl�7�d�/5@�.Jk�f��c���[�8������?�      6   |   x�]�=�@Fk8�'0À3k�1vM������n����=��C�KXZ���BIB^�� oD(50���}
�yv�Ǝ<4Ӭ)�Q��`��t�Ӊ��w������p0L7��mϲ����;4      7   7  x����n�0���S�	�$6�z�p�iG$TJ:�@-P���_�I�h�߽����N�u�e�\5�ڭ�C^�]uغ�*U�V��C#<��O�Q� ټ0V���a��0F�,�0C�!c�֧�i�§�������BgCQD���J~��/H�/yA�df1�	�I�;�\��,�݈\����w��zIڥ��P�Q��$g���7U�����n�����5#�/���X%���9��m�V׮���hF��{����TظK�����ݑ#�,b���.�X�B؅�a�.�]�0v���-��_}�      8   l   x����ͭtH�M���K���4�412�4�7+ɨ((O�L40���C�"�J��"�,����3+r��rˋ��L�,+
R��ӳ�����Ԕ|ˊ´d����%ƹ�\1z\\\ �H)�     