create table person (
  person_id number primary key,
  person_name varchar2(32),
  position sdo_geometry
);

insert into person values(
1, 'AAA',
  SDO_GEOMETRY(
  2001, 
  8307, 
  SDO_POINT_TYPE (
  91.832008, 24.919753,
  NULL), 
  NULL, 
  NULL)
);

select * from person;

insert into person values(
2, 'BBB',
  SDO_GEOMETRY(
  2001, 
  8307, 
  SDO_POINT_TYPE (
  91.832787, 24.922327,
  NULL), 
  NULL, 
  NULL)
);

select * from person;

insert into person values(
3, 'CCC',
  SDO_GEOMETRY(
  2001, 
  8307, 
  SDO_POINT_TYPE (
  91.869979, 24.905209,
  NULL), 
  NULL, 
  NULL)
);

select * from person;

insert into user_sdo_geom_metadata
  values (
    'person',
    'position',    
    sdo_dim_array(
      sdo_dim_element('Longitude',-180,180,10), --10 meter tolerance
      sdo_dim_element('Latitude', -90, 90, 10)
      ),
    8307
  );

create index person_idx
    on person(position)
    indextype is MDSYS.Spatial_index;
    
SELECT * 
  FROM person s_i, person s_r, 
  user_sdo_geom_metadata m 
  WHERE m.table_name = 'PERSON' AND 
  m.column_name = 'POSITION' 
  AND s_i.person_name = 'AAA' AND 
  SDO_GEOM.WITHIN_DISTANCE(s_i.position, m.diminfo, 5000,
     s_r.position, m.diminfo) = 'TRUE';

SELECT SDO_GEOM.SDO_INTERSECTION(p_i.position, p_r.position, 0.005)
   FROM person p_i, person p_r 
   WHERE p_i.person_name = 'AAA' AND p_r.person_name = 'BBB';
   
SELECT p_i.person_name,
  SDO_GEOM.RELATE(p_i.position, 'determine', p_r.position, 0.005) relationship 
  FROM person p_i, person p_r WHERE p_r.person_name = 'AAA';