PGDMP         !                z            postgres    14.5    14.4 5    9           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            :           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ;           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            <           1262    25862    postgres    DATABASE     l   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United States.1252';
    DROP DATABASE postgres;
                postgres    false                        3079    25863 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            =           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2            ?            1255    25873    canceltrip(character)    FUNCTION       CREATE FUNCTION public.canceltrip(confirm_no character) RETURNS integer
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
       public          postgres    false            ?            1255    25874    check_same_passenger()    FUNCTION       CREATE FUNCTION public.check_same_passenger() RETURNS trigger
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
       public          postgres    false            ?            1255    26003 +   generateplane(character, character varying) 	   PROCEDURE     ?  CREATE PROCEDURE public.generateplane(IN regno character, IN model character varying DEFAULT 'B747'::character varying)
    LANGUAGE plpgsql
    AS $$

DECLARE

col char;

BEGIN
    
    INSERT INTO PLANE VALUES (regno, model, null);
    IF model = 'B747' THEN

    FOR r IN 1..4 LOOP --rows
        
        FOREACH COL IN ARRAY ARRAY['A','B','C','D'] LOOP -- columns

            INSERT INTO SEAT VALUES (regno, r, col,  null);
        END LOOP;
    END LOOP;
    
    ELSIF model = 'A380' THEN --add elsif later for other models
	FOR r in 1..4 LOOP --ROWS
		
		FOREACH COL IN ARRAY ARRAY['A', 'B', 'C', 'D', 'F'] LOOP
			INSERT INTO SEAT VALUES (regno, r, col, null);
		END LOOP;
	END LOOP;
    END IF;

END
$$;
 U   DROP PROCEDURE public.generateplane(IN regno character, IN model character varying);
       public          postgres    false            ?            1259    25875    account    TABLE     '  CREATE TABLE public.account (
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
       public         heap    postgres    false            ?            1259    25880    airport    TABLE     ?   CREATE TABLE public.airport (
    code character(3) NOT NULL,
    number_of_staff integer NOT NULL,
    city character varying(20) NOT NULL,
    state character(2) NOT NULL
);
    DROP TABLE public.airport;
       public         heap    postgres    false            ?            1259    25883    credit_card    TABLE     ?   CREATE TABLE public.credit_card (
    card_number character(16) NOT NULL,
    exp_date date NOT NULL,
    cvv character(3) NOT NULL,
    zip character(5) NOT NULL,
    name character varying(50) NOT NULL,
    account character varying(30) NOT NULL
);
    DROP TABLE public.credit_card;
       public         heap    postgres    false            ?            1259    25886    flight    TABLE     ?  CREATE TABLE public.flight (
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
       public         heap    postgres    false            ?            1259    25889    gate    TABLE     k   CREATE TABLE public.gate (
    code character(3) NOT NULL,
    gatenumber character varying(3) NOT NULL
);
    DROP TABLE public.gate;
       public         heap    postgres    false            ?            1259    25892 	   passenger    TABLE     R  CREATE TABLE public.passenger (
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
       public         heap    postgres    false            ?            1259    25895    plane    TABLE     ?   CREATE TABLE public.plane (
    regno character(6) NOT NULL,
    model character varying(8) NOT NULL,
    airportcode character(3)
);
    DROP TABLE public.plane;
       public         heap    postgres    false            ?            1259    25898    seat    TABLE     ?   CREATE TABLE public.seat (
    regno character(6) NOT NULL,
    "row" character varying(2) NOT NULL,
    columnletter character(1) NOT NULL,
    passenger character(13)
);
    DROP TABLE public.seat;
       public         heap    postgres    false            ?            1259    25901    trip    TABLE     5  CREATE TABLE public.trip (
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
       public         heap    postgres    false            .          0    25875    account 
   TABLE DATA           ?   COPY public.account (email, password, first_name, middle_name, last_name, suffix, dob, gender, address, address2, phone_number, city, zip, state) FROM stdin;
    public          postgres    false    210   mJ       /          0    25880    airport 
   TABLE DATA           E   COPY public.airport (code, number_of_staff, city, state) FROM stdin;
    public          postgres    false    211   ?K       0          0    25883    credit_card 
   TABLE DATA           U   COPY public.credit_card (card_number, exp_date, cvv, zip, name, account) FROM stdin;
    public          postgres    false    212   eL       1          0    25886    flight 
   TABLE DATA           ?   COPY public.flight (flight_no, departure, status, source_gate_code, source_gate_number, destination_gate_number, destination_gate_code, arrival, passengers, regno) FROM stdin;
    public          postgres    false    213   ?L       2          0    25889    gate 
   TABLE DATA           0   COPY public.gate (code, gatenumber) FROM stdin;
    public          postgres    false    214   ?M       3          0    25892 	   passenger 
   TABLE DATA           o   COPY public.passenger (ticketno, firstname, middlename, lastname, dob, gender, state, checkedbags) FROM stdin;
    public          postgres    false    215   .N       4          0    25895    plane 
   TABLE DATA           :   COPY public.plane (regno, model, airportcode) FROM stdin;
    public          postgres    false    216   ?N       5          0    25898    seat 
   TABLE DATA           E   COPY public.seat (regno, "row", columnletter, passenger) FROM stdin;
    public          postgres    false    217   CO       6          0    25901    trip 
   TABLE DATA           |   COPY public.trip (email, flightno, passenger1, passenger2, passenger3, passenger4, passenger5, confirmation_no) FROM stdin;
    public          postgres    false    218   ?P       ?           2606    25905    account account_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (email);
 >   ALTER TABLE ONLY public.account DROP CONSTRAINT account_pkey;
       public            postgres    false    210            ?           2606    25907    airport airport_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.airport
    ADD CONSTRAINT airport_pkey PRIMARY KEY (code);
 >   ALTER TABLE ONLY public.airport DROP CONSTRAINT airport_pkey;
       public            postgres    false    211            ?           2606    25909    credit_card credit_card_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.credit_card
    ADD CONSTRAINT credit_card_pkey PRIMARY KEY (card_number);
 F   ALTER TABLE ONLY public.credit_card DROP CONSTRAINT credit_card_pkey;
       public            postgres    false    212            ?           2606    25913    flight flightexample_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flightexample_pkey PRIMARY KEY (flight_no);
 C   ALTER TABLE ONLY public.flight DROP CONSTRAINT flightexample_pkey;
       public            postgres    false    213            ?           2606    25915    gate gate_pk 
   CONSTRAINT     X   ALTER TABLE ONLY public.gate
    ADD CONSTRAINT gate_pk PRIMARY KEY (code, gatenumber);
 6   ALTER TABLE ONLY public.gate DROP CONSTRAINT gate_pk;
       public            postgres    false    214    214            ?           2606    25917    seat maincabin_pk 
   CONSTRAINT     g   ALTER TABLE ONLY public.seat
    ADD CONSTRAINT maincabin_pk PRIMARY KEY (regno, "row", columnletter);
 ;   ALTER TABLE ONLY public.seat DROP CONSTRAINT maincabin_pk;
       public            postgres    false    217    217    217            ?           2606    25919    passenger passenger_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.passenger
    ADD CONSTRAINT passenger_pkey PRIMARY KEY (ticketno);
 B   ALTER TABLE ONLY public.passenger DROP CONSTRAINT passenger_pkey;
       public            postgres    false    215            ?           2606    25921    plane plane_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.plane
    ADD CONSTRAINT plane_pkey PRIMARY KEY (regno);
 :   ALTER TABLE ONLY public.plane DROP CONSTRAINT plane_pkey;
       public            postgres    false    216            ?           2606    25923    seat seat_passenger_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.seat
    ADD CONSTRAINT seat_passenger_key UNIQUE (passenger);
 A   ALTER TABLE ONLY public.seat DROP CONSTRAINT seat_passenger_key;
       public            postgres    false    217            ?           2606    25925    trip trip_pk 
   CONSTRAINT     W   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_pk PRIMARY KEY (confirmation_no);
 6   ALTER TABLE ONLY public.trip DROP CONSTRAINT trip_pk;
       public            postgres    false    218            ?           2620    25926    trip check_trip_insert    TRIGGER     z   CREATE TRIGGER check_trip_insert AFTER INSERT ON public.trip FOR EACH ROW EXECUTE FUNCTION public.check_same_passenger();
 /   DROP TRIGGER check_trip_insert ON public.trip;
       public          postgres    false    218    223            ?           2606    25927 $   credit_card credit_card_account_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.credit_card
    ADD CONSTRAINT credit_card_account_fkey FOREIGN KEY (account) REFERENCES public.account(email);
 N   ALTER TABLE ONLY public.credit_card DROP CONSTRAINT credit_card_account_fkey;
       public          postgres    false    3200    212    210            ?           2606    25932    flight destination_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.flight
    ADD CONSTRAINT destination_fk FOREIGN KEY (destination_gate_code, destination_gate_number) REFERENCES public.gate(code, gatenumber);
 ?   ALTER TABLE ONLY public.flight DROP CONSTRAINT destination_fk;
       public          postgres    false    3208    213    213    214    214            ?           2606    25937    flight flight_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flight_fk FOREIGN KEY (source_gate_code, source_gate_number) REFERENCES public.gate(code, gatenumber);
 :   ALTER TABLE ONLY public.flight DROP CONSTRAINT flight_fk;
       public          postgres    false    214    213    213    3208    214            ?           2606    25942    flight flight_regno_fkey    FK CONSTRAINT     x   ALTER TABLE ONLY public.flight
    ADD CONSTRAINT flight_regno_fkey FOREIGN KEY (regno) REFERENCES public.plane(regno);
 B   ALTER TABLE ONLY public.flight DROP CONSTRAINT flight_regno_fkey;
       public          postgres    false    216    213    3212            ?           2606    25947    gate gate_code_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.gate
    ADD CONSTRAINT gate_code_fkey FOREIGN KEY (code) REFERENCES public.airport(code) ON DELETE CASCADE;
 =   ALTER TABLE ONLY public.gate DROP CONSTRAINT gate_code_fkey;
       public          postgres    false    3202    214    211            ?           2606    25952    seat maincabin_regno_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.seat
    ADD CONSTRAINT maincabin_regno_fkey FOREIGN KEY (regno) REFERENCES public.plane(regno) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.seat DROP CONSTRAINT maincabin_regno_fkey;
       public          postgres    false    3212    217    216            ?           2606    25957    trip passenger1_fk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT passenger1_fk FOREIGN KEY (passenger1) REFERENCES public.passenger(ticketno);
 <   ALTER TABLE ONLY public.trip DROP CONSTRAINT passenger1_fk;
       public          postgres    false    218    215    3210            ?           2606    25962    trip passenger2_fk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT passenger2_fk FOREIGN KEY (passenger2) REFERENCES public.passenger(ticketno);
 <   ALTER TABLE ONLY public.trip DROP CONSTRAINT passenger2_fk;
       public          postgres    false    3210    218    215            ?           2606    25967    trip passenger3_fk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT passenger3_fk FOREIGN KEY (passenger3) REFERENCES public.passenger(ticketno);
 <   ALTER TABLE ONLY public.trip DROP CONSTRAINT passenger3_fk;
       public          postgres    false    218    3210    215            ?           2606    25972    trip passenger4_fk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT passenger4_fk FOREIGN KEY (passenger4) REFERENCES public.passenger(ticketno);
 <   ALTER TABLE ONLY public.trip DROP CONSTRAINT passenger4_fk;
       public          postgres    false    215    3210    218            ?           2606    25977    trip passenger5_fk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT passenger5_fk FOREIGN KEY (passenger5) REFERENCES public.passenger(ticketno);
 <   ALTER TABLE ONLY public.trip DROP CONSTRAINT passenger5_fk;
       public          postgres    false    215    218    3210            ?           2606    25982    plane plane_airportcode_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.plane
    ADD CONSTRAINT plane_airportcode_fkey FOREIGN KEY (airportcode) REFERENCES public.airport(code);
 F   ALTER TABLE ONLY public.plane DROP CONSTRAINT plane_airportcode_fkey;
       public          postgres    false    3202    216    211            ?           2606    25987    seat seat_passenger_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.seat
    ADD CONSTRAINT seat_passenger_fkey FOREIGN KEY (passenger) REFERENCES public.passenger(ticketno);
 B   ALTER TABLE ONLY public.seat DROP CONSTRAINT seat_passenger_fkey;
       public          postgres    false    3210    215    217            ?           2606    25992    trip trip_email_fkey    FK CONSTRAINT     v   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_email_fkey FOREIGN KEY (email) REFERENCES public.account(email);
 >   ALTER TABLE ONLY public.trip DROP CONSTRAINT trip_email_fkey;
       public          postgres    false    210    218    3200            ?           2606    25997    trip trip_flightno_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_flightno_fkey FOREIGN KEY (flightno) REFERENCES public.flight(flight_no);
 A   ALTER TABLE ONLY public.trip DROP CONSTRAINT trip_flightno_fkey;
       public          postgres    false    218    3206    213            .   =  x?m??N?0Eד??ҵ#;N?Fb?GZZ$*?Cl?LӺ$68$?|=.M?zc?ǚ9?TYǻUlM	K?s??!ܜ: ??ջZ~??Ŕ	2?
2?lIfU#F\??(&???;?o??X?????s?u?ȼ?LުO?Ϫ(??????=?V+??(?,?<r???d??iiɤ???0_O?`|?!?4?hŢ?b?`{?B}????t?ƔW2??_?ZK??7????e?!M)??????ҩXI?&?,?E????s?T5NH?0u???6un???L?=?5???C?8?q???-????G)?(?x??wЇv      /   ?   x???
?0?????
? |?x?kJ??1?.???s}??9p䅑??j?(ԂN?9??j=/??T?y?J?L@?K?? ???pd??E?%????^P2?B ۣv>$B?????:???H?5????w?U?b`?UwdZ??Y??n?+??#???/?      0   ?   x?%?A?0E??S?4???;???qC???DC??+????y?c?Q9a??Ȓ?,?̎,\RΩ+?<L?+?:???8?򾛡_?A??ˑ?=?=???T?W??8?s?ͣt)??\??(?~7+%U      1   ?   x???1?0???9E/P??ݴ4[?? ??20???$?T?: ?ۯOvھQ?B???`E@zrx??}??i8K?l(?1e?u.!$?4`???X&????~???E????b	?s?+"??????h%f}P????^?͉??[?H?m?E??G@ڞf????sO"
Ll      2   {   x?5?;?0E?-??J?"P0?(??:?u???>Ov?C?d(??r??\?6_???8kDH????TV?????~w?e]?㘑!????y???d(0???3xE\?o_?E??4?U      3   ?   x?=??
?0????wY???v!?D]t3?DC=K?z?&???????|????f?????P=???Ǆ?
8uv4???Wnvc&W???? ?}D(?1G	?Dl?ШD9O:??-K?5??	?4]?P?SXr?VV9,E\?????R???N?d?cP
?pi?&?}4????c?? ޅ=#      4   F   x?30 #N'ss??.???542615C?5?p]B¹?,???9?-?|CCC???%?+F??? ??[      5   D  x?]??n?@?ϛ?????c?+?}.-???	ڧoZ??_?}?3?h??:?І?s'?@	?2?:?Πt?N?	:?Ρs?????>q?9?@w?utt?????	$??pɘ? ??9??l?:.B?E??p]!??E?.?'?'$n-l?E??Έ?9??nP??y3lʣ??	?Ң??D??纉?f
:Ӯ???3eP?)x???)?2?tq?8\._??@?7?a??3QeЮ ?t?A'??邋?"?8\.??/v??m8_޾?o??8|??????C?/?-
]X5??????x))??5?o??P??UU?b??      6   {   x?E?A?0Eם?4?;N?	?`Keԡ???xzq??߼佟?i??J?????&N??Q???£thQ???P?p'潿?HOi<?CC%|T&???7k5?ntڗ? ??Z)[Z?ַ?3 >??(?     