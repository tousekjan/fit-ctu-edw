\connect stage pentaho
-- ************************************** stage_airline

CREATE TABLE IF NOT EXISTS stage_airline
(
 id               int NOT NULL,
 name             varchar(255) NOT NULL,
 alternative_name varchar(255) NULL,
 IATA             varchar(3) NULL,
 ICAO             varchar(5) NULL,
 callsign         varchar(255) NULL,
 country          varchar(255) NULL,
 active           boolean NOT NULL,
 CONSTRAINT PK_stage_airline PRIMARY KEY (id)
);

-- ************************************** stage_airport

CREATE TABLE IF NOT EXISTS stage_airport
(
 id           int NOT NULL,
 name         varchar(255) NOT NULL,
 city         varchar(255) NULL,
 country      varchar(255) NOT NULL,
 IATA         varchar(3) NULL,
 ICAO         varchar(4) NULL,
 latitude     double precision NOT NULL,
 longtitude   double precision NOT NULL,
 altitude     int NULL,
 timezone     double precision NULL,
 DST          varchar(5) NULL,
 tz_time_zone varchar(255) NULL,
 type         varchar(50) NOT NULL,
 source       varchar(50) NOT NULL,
 CONSTRAINT PK_stage_airport PRIMARY KEY (id)
);

-- ************************************** stage_airport_frequency

CREATE TABLE IF NOT EXISTS stage_airport_frequency
(
 id            int NOT NULL,
 airport_ref   int NOT NULL,
 airport_ident varchar(50) NOT NULL,
 type          varchar(50) NOT NULL,
 description   varchar(255) NULL,
 frequency_mhz double precision NOT NULL,
 CONSTRAINT PK_stage_airport_frequency PRIMARY KEY (id)
);


-- ************************************** stage_country

CREATE TABLE IF NOT EXISTS stage_country
(
 id             int NOT NULL,
 code           varchar(2) NOT NULL,
 name           varchar(255) NOT NULL,
 continent      varchar(2) NOT NULL,
 wikipedia_link varchar(1000) NULL,
 keywords       varchar(255) NULL,
 CONSTRAINT PK_stage_country PRIMARY KEY (id)
);

-- ************************************** stage_navaid

CREATE TABLE IF NOT EXISTS stage_navaid
(
 id                     int NOT NULL,
 filename               varchar(255) NULL,
 ident                  varchar(50)  NULL,
 name                   varchar(50)  NULL,
 type                   varchar(50)  NULL,
 frequency_khz          int  NULL,
 latitude_deg           double precision  NULL,
 longitude_deg          double precision  NULL,
 elevation_ft           double precision NULL,
 iso_country            varchar(10)  NULL,
 dme_frequency_khz      double precision NULL,
 dme_channel            varchar(50) NULL,
 dme_latitude_deg       double precision NULL,
 dme_longitude_deg      double precision NULL,
 dme_elevation_ft       double precision NULL,
 slaved_variation_deg   double precision NULL,
 magnetic_variation_deg double precision NULL,
 usageType              varchar(50)  NULL,
 power                  varchar(50)  NULL,
 associated_airport     varchar(10) NULL,
 CONSTRAINT PK_stage_navaid PRIMARY KEY (id)
);

-- ************************************** stage_plane

CREATE TABLE IF NOT EXISTS stage_plane
(
 --id   serial NOT NULL,
 name varchar(255) NOT NULL,
 IATA varchar(3) NULL,
 ICAO varchar(4) NULL
 --CONSTRAINT PK_stage_plane PRIMARY KEY (id)
);

-- ************************************** stage_region

CREATE TABLE IF NOT EXISTS stage_region
(
 id             int NOT NULL,
 code           varchar(10) NOT NULL,
 local_code     varchar(4) NOT NULL,
 name           varchar(255) NULL,
 continent      varchar(2) NOT NULL,
 iso_country    varchar(2) NOT NULL,
 wikipedia_link varchar(2048) NULL,
 keywords       varchar(255) NULL,
 CONSTRAINT PK_stage_region PRIMARY KEY (id)
);

-- ************************************** stage_route

CREATE TABLE IF NOT EXISTS stage_route
(
 airline_code             varchar(3) NOT NULL,
 airline_id               int NULL,
 source_airport_code      varchar(4) NOT NULL,
 source_airport_id        int NULL,
 destination_airport_code varchar(4) NOT NULL,
 destination_airport_id   int NULL,
 codeshare                boolean NULL,
 number_of_stops          int NOT NULL,
 equipment                varchar(255)  NULL
);

-- ************************************** stage_runway

CREATE TABLE IF NOT EXISTS stage_runway
(
 id                        int NOT NULL,
 airport_ref               int NOT NULL,
 airport_ident             varchar(50) NOT NULL,
 length_ft                 int NULL,
 width_ft                  int NULL,
 surface                   varchar(255) NULL,
 lighted                   int NOT NULL,
 closed                    int NOT NULL,
 le_ident                  varchar(50) NULL,
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
 CONSTRAINT PK_stage_runway PRIMARY KEY (id)
);