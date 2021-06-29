\connect target root

create schema datamart;

CREATE EXTENSION cube;
CREATE EXTENSION earthdistance;

create view datamart.dim_country as
select * from public.t_country;

create view datamart.dim_airport as
select * from public.t_airport;

create view datamart.dim_route as
select * from public.t_route;

create view datamart.dim_airline as
select * from public.t_airline;

create view datamart.fact_distance as
select
    r.id as route_id,
    src.id as source_airport_id,
    dst.id as destination_airport_id,
    earth_distance (ll_to_earth(src.latitude, src.longtitude), ll_to_earth(dst.latitude, dst.longtitude)) as distance
from public.t_route r
join t_airport src on r.fk_source_airport_id = src.id
join t_airport dst on r.fk_destination_airport_id = dst.id;


create view datamart.fact_country as
select
    c.id as country_id,
    count(distinct a.id) as count_airport,
    count(distinct r.id) as count_route
from public.t_country c
left join public.t_airport a on a.fk_country_id = c.id
left join public.t_route r on r.fk_source_airport_id = a.id
group by c.id;

create view datamart.fact_route as

select row_number() over (order by route_id, time) as id, *
from(
    select
        r.id as route_id,
        1 as time,
        src.latitude as latitude,
        src.longtitude as longtitude
    from t_route r
    join t_airport src on r.fk_source_airport_id = src.id
    union
    select
        r.id as route_id,
        2 as time,
        dst.latitude as latitude,
        dst.longtitude as longtitude
    from t_route r
    join t_airport dst on r.fk_destination_airport_id = dst.id) x;


-- create analytics role and powerbi user
create role analytics;

GRANT CONNECT
ON DATABASE target
TO analytics;

GRANT USAGE ON SCHEMA datamart TO analytics;
grant select on all tables in schema "datamart" to analytics;

create role powerbi
login
password 'niedw';

grant analytics to powerbi;