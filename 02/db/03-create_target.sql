\connect target pentaho

CREATE TABLE IF NOT EXISTS t_country
(
 id             int NOT NULL,
 code           varchar(2) NOT NULL,
 name           varchar(255) NOT NULL,
 continent      varchar(2) NOT NULL,
 wikipedia_link varchar(1000) NULL,
 keywords       varchar(255) NULL,
 CONSTRAINT PK_t_country PRIMARY KEY ( id )
);

-- ************************************** t_airline

CREATE TABLE IF NOT EXISTS t_airline
(
 id               int NOT NULL,
 name             varchar(255) NOT NULL,
 alternative_name varchar(255) NULL,
 IATA             varchar(5) NULL,
 ICAO             varchar(5) NULL,
 callsign         varchar(255) NULL,
 active           boolean NOT NULL,
 fk_country       int NULL,
 CONSTRAINT PK_t_airline PRIMARY KEY ( id ),
 CONSTRAINT FK_t_airline_t_country FOREIGN KEY ( fk_country ) REFERENCES t_country ( id )
);

CREATE INDEX IF NOT EXISTS t_airline_fk_country_fkey ON t_airline
(
 fk_country
);

-- ************************************** t_airport

CREATE TABLE IF NOT EXISTS t_airport
(
 id            int NOT NULL,
 name          varchar(255) NOT NULL,
 city          varchar(255) NULL,
 IATA          varchar(3) NULL,
 ICAO          varchar(4) NULL,
 latitude      double precision NOT NULL,
 longtitude    double precision NOT NULL,
 altitude      int NULL,
 timezone      double precision NULL,
 DST           varchar(1) NULL,
 tz_time_zone  varchar(255) NULL,
 source        varchar(50) NOT NULL,
 type          varchar(50) NOT NULL,
 fk_country_id int NULL,
 CONSTRAINT PK_t_airport PRIMARY KEY ( id ),
 CONSTRAINT FK_t_airport_t_country FOREIGN KEY ( fk_country_id ) REFERENCES t_country ( id )
);

CREATE INDEX IF NOT EXISTS t_airport_fk_country_id_fkey ON t_airport
(
 fk_country_id
);

-- ************************************** t_airport_frequency

CREATE TABLE IF NOT EXISTS t_airport_frequency
(
 id            int NOT NULL,
 type          varchar(50) NOT NULL,
 description   varchar(255) NULL,
 frequency_mhz double precision NULL,
 fk_airport_id int NULL,
 CONSTRAINT PK_t_airport_frequency PRIMARY KEY ( id ),
 CONSTRAINT FK_t_airport_frequency_t_airport FOREIGN KEY ( fk_airport_id ) REFERENCES t_airport ( id )
);

CREATE INDEX IF NOT EXISTS t_airport_frequency_fk_airport_id_fkey ON t_airport_frequency
(
 fk_airport_id
);

-- ************************************** t_navaid

CREATE TABLE IF NOT EXISTS t_navaid
(
 id                     int NOT NULL,
 filename               varchar(255)  NULL,
 ident                  varchar(50)  NULL,
 name                   varchar(50)  NULL,
 type                   varchar(50)  NULL,
 frequency_khz          int  NULL,
 latitude_deg           double precision  NULL,
 longitude_deg          double precision  NULL,
 elevation_ft           double precision NULL,
 iso_country            varchar(2)  NULL,
 dme_frequency_khz      double precision NULL,
 dme_channel            varchar(50) NULL,
 dme_latitude_deg       double precision NULL,
 dme_longitude_deg      double precision NULL,
 dme_elevation_ft       double precision NULL,
 slaved_variation_deg   double precision NULL,
 magnetic_variation_deg double precision NULL,
 usageType              varchar(50)  NULL,
 power                  varchar(50)  NULL,
 fk_airport_id          int NULL,
 CONSTRAINT PK_t_navaid PRIMARY KEY ( id ),
 CONSTRAINT FK_t_navaid_t_airport FOREIGN KEY ( fk_airport_id ) REFERENCES t_airport ( id )
);

CREATE INDEX IF NOT EXISTS t_navaid_fk_airport_id_fkey ON t_navaid
(
 fk_airport_id
);

-- ************************************** t_region

CREATE TABLE IF NOT EXISTS t_region
(
 id             int NOT NULL,
 code           varchar(10) NOT NULL,
 local_code     varchar(4) NOT NULL,
 name           varchar(255) NULL,
 continent      varchar(2) NOT NULL,
 wikipedia_link varchar(2048) NULL,
 keywords       varchar(255) NULL,
 country_id     int NOT NULL,
 CONSTRAINT PK_t_region PRIMARY KEY ( id ),
 CONSTRAINT FK_t_region_t_country FOREIGN KEY ( country_id ) REFERENCES t_country ( id )
);

CREATE INDEX IF NOT EXISTS t_region_country_id_fkey ON t_region
(
 country_id
);

-- ************************************** t_runway

CREATE TABLE IF NOT EXISTS t_runway
(
 id                        int NOT NULL,
 length_ft                 int  NULL,
 width_ft                  int  NULL,
 surface                   varchar(255)  NULL,
 lighted                   int NOT NULL,
 closed                    int NOT NULL,
 le_ident                  varchar(50)  NULL,
 le_latitude_deg           double precision NULL,
 le_longitude_deg          double precision NULL,
 le_elevation_ft           double precision NULL,
 le_heading_degT           int NULL,
 le_displaced_threshold_ft int NULL,
 he_ident                  varchar(50) NULL,
 he_latitude_deg           double precision NULL,
 he_longitude_deg          double precision NULL,
 he_elevation_ft           double precision NULL,
 he_heading_degT           int NULL,
 he_displaced_threshold_ft double precision NULL,
 fk_airport_id             int NULL,
 CONSTRAINT PK_t_runway PRIMARY KEY ( id ),
 CONSTRAINT FK_t_runway_t_airport FOREIGN KEY ( fk_airport_id ) REFERENCES t_airport ( id )
);

CREATE INDEX IF NOT EXISTS t_runway_fk_airport_id_fkey ON t_runway
(
 fk_airport_id
);

-- ************************************** t_route

CREATE TABLE IF NOT EXISTS t_route
(
 id                        SERIAL NOT NULL,
 codeshare                 boolean NULL,
 number_of_stops           int NOT NULL,
 equipment                 varchar(255) NULL,
 fk_source_airport_id      int NULL,
 fk_destination_airport_id int NULL,
 fk_airline_id             int NULL,
 CONSTRAINT PK_t_route PRIMARY KEY ( id ),
 CONSTRAINT FK_t_route_t_airport_id FOREIGN KEY ( fk_source_airport_id ) REFERENCES t_airport ( id ),
 CONSTRAINT FK_t_route_t_airport_id_2 FOREIGN KEY ( fk_destination_airport_id ) REFERENCES t_airport ( id ),
 CONSTRAINT FK_t_route_t_airline FOREIGN KEY ( fk_airline_id ) REFERENCES t_airline ( id )
);

CREATE INDEX IF NOT EXISTS t_route_fk_source_airport_id_fkey ON t_route
(
 fk_source_airport_id
);

CREATE INDEX IF NOT EXISTS t_route_fk_destination_airport_id_fkey ON t_route
(
 fk_destination_airport_id
);

CREATE INDEX IF NOT EXISTS t_route_fk_airline_id_fkey ON t_route
(
 fk_airline_id
);


-- ************************************** t_plane

create sequence seq_plane
    increment 1
    minvalue 1
    maxvalue 9223372036854775807
    start 1
    cache 1;

create table if not exists t_plane
(
    plane_tk bigint not null default nextval('seq_plane'::regclass),
	name varchar(255) not null,
	iata varchar(3),
	icao varchar(4),
	version bigint,
	date_from timestamp without time zone,
	date_to timestamp without time zone,
	constraint pk_t_plane
		primary key (plane_tk)
);

CREATE INDEX IF NOT EXISTS t_plane_iata ON t_plane
(
 iata
);

INSERT INTO t_plane values (0, '', null, -1, null, null);

-- ************************************** t_plane_route

CREATE TABLE IF NOT EXISTS t_plane_route (
    plane_id INTEGER NULL,
    route_id INTEGER NULL,
    CONSTRAINT pk_plane_route PRIMARY KEY (plane_id, route_id),
    CONSTRAINT fk_plane_route_plane FOREIGN KEY (plane_id) REFERENCES t_plane (plane_tk),
    CONSTRAINT fk_plane_route_route FOREIGN KEY (route_id) REFERENCES t_route (id)
);

-- create sequence seq_plane_route
--     increment 1
--     minvalue 1
--     maxvalue 9223372036854775807
--     start 1
--     cache 1;

-- CREATE TABLE t_plane_route (
--     plane_route_tk bigint not null default nextval('seq_plane_route'::regclass),
--     plane_id INTEGER NULL,
--     route_id INTEGER NULL,
--     version bigint,
--     date_from timestamp without time zone,
-- 	date_to timestamp without time zone,
--     CONSTRAINT pk_plane_route PRIMARY KEY (plane_route_tk),
--     CONSTRAINT fk_plane_route_plane FOREIGN KEY (plane_id) REFERENCES t_plane (plane_tk),
--     CONSTRAINT fk_plane_route_route FOREIGN KEY (route_id) REFERENCES t_route (id)
-- );

-- CREATE INDEX IF NOT EXISTS t_plane_route_plane_id ON t_plane_route
-- (
--  plane_id
-- );
-- CREATE INDEX IF NOT EXISTS t_plane_route_route_id ON t_plane_route
-- (
--  route_id
-- );

-- INSERT INTO t_plane_route values (0, NULL, NULL, NULL, NULL, NULL);
