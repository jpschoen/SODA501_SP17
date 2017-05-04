SELECT gid, statefp10, countyfp10, tractce10, blockce10, geoid10, name10, 
       mtfcc10, ur10, uace10, uatype, funcstat10, aland10, awater10, 
       intptlat10, intptlon10, geom
  FROM la_blocks_wgs84;


COPY work_501 FROM 'F:\\6.gradcourse\\SoDA501\\work.csv' DELIMITER ',' CSV HEADER

alter table home_501 ADD COLUMN geom geometry(POINT,4326);
UPDATE home_501 SET geom = ST_SetSRID(ST_MakePoint(lon,lat),4326);
select user_id, lon, lat, tw_time, geoid from tweets_p_t p1, county_wgs84 p2 where st_within (p1.geom, p2.geom)
select geoid10, count(*) from home_501 p1, la_blocks_wgs84 p2 where st_within(p1.geom, p2.geom) group by geoid10

SELECT f_table_name, f_geometry_column, srid FROM geometry_columns;

SELECT UpdateGeometrySRID('la_blocks_wgs84','geom',4326);

create index aba on la_blocks_wgs84 using GIST (geom)
create index abaa on home_501 using GIST (geom)
CREATE INDEX jacksonco_streets_gix ON jacksonco_streets USING GIST (the_geom);


alter table work_501 ADD COLUMN geom geometry(POINT,4326);
UPDATE work_501 SET geom = ST_SetSRID(ST_MakePoint(lon,lat),4326);
create index abaass on home_501 using GIST (geom)
select geoid10, count(*) from work_501 p1, la_blocks_wgs84 p2 where st_within(p1.geom, p2.geom) group by geoid10


select geoid10, count(*) from (select distinct geoid10, userid from home_501 p1, la_blocks_wgs84 p2 where st_within(p1.geom, p2.geom)) a group by geoid10

select geoid10, count(*) from (select distinct geoid10, userid from home_501 p1, la_blocks_wgs84 p2 where st_within(p1.geom, p2.geom)) a group by geoid10


select geoid10, count(*) as usercnt from(
select distinct on (userid) userid, geoid10, count(*) as freq from home_501 p1, la_blocks_wgs84 p2 where st_within(p1.geom, p2.geom) group by userid, geoid10 order by userid, freq) b
group by geoid10


select geoid10, count(*) as usercnt from(
select distinct on (userid) userid, geoid10, count(*) as freq from work_501 p1, la_blocks_wgs84 p2 where st_within(p1.geom, p2.geom) group by userid, geoid10 order by userid, freq) b
group by geoid10