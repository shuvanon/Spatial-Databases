create table sylhet_restaurant (
  rest_id number primary key,
  rest_name varchar2(32),
  shape sdo_geometry
);

SELECT * FROM SYLHET_RESTAURANT;

insert into sylhet_restaurant values(
1, 'Royal Kitchen',
  sdo_geometry(
  2003,
  8307,
  null,
  sdo_elem_info_array(1,1003,1),
  sdo_ordinate_array(
   91.867580, 24.902151,
   91.867577, 24.902193,
   91.867621, 24.902190,
   91.867621, 24.902151,
   91.867580, 24.902151
  )  )
);

SELECT * FROM SYLHET_RESTAURANT;

insert into sylhet_restaurant values(
2, 'Blue Mango',
  sdo_geometry(
  2003,
  8307,
  null,
  sdo_elem_info_array(1,1003,1),
  sdo_ordinate_array(
  91.868801, 24.902114,
  91.868810, 24.902206,
  91.869116, 24.902191,
  91.869116, 24.902183,
  91.869129, 24.902183,
  91.869116, 24.902091,
  91.868801, 24.902114
  )  )
);

SELECT * FROM SYLHET_RESTAURANT;

insert into sylhet_restaurant values(
3, 'Al-pine',
  sdo_geometry(
  2003,
  8307,
  null,
  sdo_elem_info_array(1,1003,1),
  sdo_ordinate_array(
  91.869428, 24.899302,
  91.869446, 24.899356,
  91.869566, 24.899336,
  91.869546, 24.899279,
  91.869428, 24.899302
  )  )
);

SELECT * FROM SYLHET_RESTAURANT;

insert into sylhet_restaurant values(
4, 'Rainbow Chinese Restaurant',
  sdo_geometry(
  2003,
  8307,
  null,
  sdo_elem_info_array(1,1003,1),
  sdo_ordinate_array(
  91.871787, 24.899085,
  91.871779, 24.899192,
  91.871931, 24.899206,
  91.871936, 24.899094,
  91.871787, 24.899085
  )  )
);
SELECT * FROM SYLHET_RESTAURANT;

insert into sylhet_restaurant values(
5, 'Hungry Station',
  sdo_geometry(
  2003,
  8307,
  null,
  sdo_elem_info_array(1,1003,1),
  sdo_ordinate_array(
  91.878470, 24.896611,
  91.878345, 24.896581,
  91.878293, 24.896717,
  91.878423, 24.896756,
  91.878470, 24.896611
  )  )
);
SELECT * FROM SYLHET_RESTAURANT;

insert into sylhet_restaurant values(
6, 'Hotel Dallas',
  sdo_geometry(
  2003,
  8307,
  null,
  sdo_elem_info_array(1,1003,1),
  sdo_ordinate_array(
  91.874236, 24.895443,
  91.874221, 24.895782,
  91.874393, 24.895765,
  91.874393, 24.895438,
  91.874236, 24.895443
  )  )
);
SELECT * FROM SYLHET_RESTAURANT;

insert into sylhet_restaurant values(
7, 'Chicken Hut',
  sdo_geometry(
  2003,
  8307,
  null,
  sdo_elem_info_array(1,1003,1),
  sdo_ordinate_array(
  91.873838, 24.897438,
  91.873753, 24.897572,
  91.873909, 24.897492,
  91.873838, 24.897438
  )  )
);
SELECT * FROM SYLHET_RESTAURANT;

insert into sylhet_restaurant values(
8, 'Kings Castle',
  sdo_geometry(
  2003,
  8307,
  null,
  sdo_elem_info_array(1,1003,1),
  sdo_ordinate_array(
  91.870619, 24.895142,
  91.870599, 24.895318,
  91.870624, 24.895320,
  91.870626, 24.895370,
  91.870604, 24.895373,
  91.870656, 24.895603,
  91.870637, 24.895618,
  91.870653, 24.895665,
  91.870803, 24.895651,
  91.870789, 24.895559,
  91.870753, 24.895549,
  91.870764, 24.895202,
  91.870619, 24.895142
  )  )
);
SELECT * FROM SYLHET_RESTAURANT;

insert into sylhet_restaurant values(
9, 'Cafe La Vista',
  sdo_geometry(
  2003,
  8307,
  null,
  sdo_elem_info_array(1,1003,1),
  sdo_ordinate_array(
  91.871144, 24.895310,
  91.871105, 24.895433,
  91.871174, 24.895663,
  91.871191, 24.895670,
  91.871397, 24.895393,
  91.871144, 24.895310
  )  )
);
SELECT * FROM SYLHET_RESTAURANT;

insert into sylhet_restaurant values(
10, 'Woondal',
  sdo_geometry(
  2003,
  8307,
  null,
  sdo_elem_info_array(1,1003,1),
  sdo_ordinate_array(
  91.870876, 24.895194,
  91.870828, 24.895331,
  91.870900, 24.895366,
  91.870968, 24.895230,
  91.870876, 24.895194
  )  )
);
SELECT * FROM SYLHET_RESTAURANT;

insert into user_sdo_geom_metadata
  values (
    'sylhet_restaurant',
    'shape',    
    sdo_dim_array(
      sdo_dim_element('Longitude',-180,180,10), --10 meter tolerance
      sdo_dim_element('Latitude', -90, 90, 10)
      ),
    8307
  );

SELECT * FROM SYLHET_RESTAURANT;

create index SYLHET_RESTAURANT_idx
    on SYLHET_RESTAURANT(shape)
    indextype is MDSYS.Spatial_index;

SELECT * 
  FROM SYLHET_RESTAURANT s_i, SYLHET_RESTAURANT s_r, 
  user_sdo_geom_metadata m 
  WHERE m.table_name = 'SYLHET_RESTAURANT' AND 
  m.column_name = 'SHAPE' 
  AND s_i.rest_name = 'Cafe La Vista' AND 
  SDO_GEOM.WITHIN_DISTANCE(s_i.shape, m.diminfo, 300,
     s_r.shape, m.diminfo) = 'TRUE';

SELECT SDO_GEOM.SDO_INTERSECTION(s_i.shape, s_r.shape, 0.005)
   FROM SYLHET_RESTAURANT s_i, SYLHET_RESTAURANT s_r 
   WHERE s_i.rest_name = 'Cafe La Vista' AND s_r.rest_name = 'Woondal';

SELECT r_a.rest_name,
  SDO_GEOM.RELATE(r_a.shape, 'determine', r_b.shape, 0.005) relationship 
  FROM SYLHET_RESTAURANT r_a, SYLHET_RESTAURANT r_b WHERE r_b.rest_name = 'Woondal';

SELECT r_a.rest_name,
  SDO_GEOM.RELATE(r_a.shape, 'inside+touch', r_b.shape, 0.005) relationship 
  FROM SYLHET_RESTAURANT r_a, SYLHET_RESTAURANT r_b WHERE r_b.rest_name = 'Woondal';

SELECT r_a.rest_name,
  SDO_GEOM.RELATE(r_a.shape, 'equal', r_b.shape, 0.005) relationship 
  FROM SYLHET_RESTAURANT r_a, SYLHET_RESTAURANT r_b WHERE r_b.rest_name = 'Woondal'; 
  
SELECT r_a.rest_name,
  SDO_GEOM.RELATE(r_a.shape, 'anyinteract', r_b.shape, 0.005) relationship 
  FROM SYLHET_RESTAURANT r_a, SYLHET_RESTAURANT r_b WHERE r_b.rest_name = 'Woondal';
  
SELECT rest_name, SDO_GEOM.SDO_AREA(shape, 0.005)
FROM SYLHET_RESTAURANT;  
  
SELECT rest_name, SDO_GEOM.SDO_AREA(shape, 0.005)
FROM SYLHET_RESTAURANT
where rest_name='Woondal';

SELECT SDO_GEOM.SDO_DISTANCE(s_i.shape, s_r.shape, 0.005, 'unit=m')
   FROM SYLHET_RESTAURANT s_i, SYLHET_RESTAURANT s_r
   WHERE s_i.rest_name = 'Woondal' AND s_r.rest_name = 'Hungry Station';
 
SELECT s_i.rest_name, s_r.rest_name, SDO_GEOM.SDO_DISTANCE(s_i.shape, s_r.shape, 0.005, 'unit=M')
   FROM SYLHET_RESTAURANT s_i, SYLHET_RESTAURANT s_r;

SELECT SDO_GEOM.WITHIN_DISTANCE(s_i.shape, m.diminfo, 1,
     s_r.shape, m.diminfo) 
  FROM SYLHET_RESTAURANT s_i, SYLHET_RESTAURANT s_r, 
  user_sdo_geom_metadata m 
  WHERE m.table_name = 'SYLHET_RESTAURANT' AND m.column_name = 'SHAPE' 
  AND s_i.rest_name = 'Woondal' AND s_r.rest_name = 'Hungry Station';
  
SELECT SDO_GEOM.WITHIN_DISTANCE(s_i.shape, m.diminfo, 100,
     s_r.shape, m.diminfo) 
  FROM SYLHET_RESTAURANT s_i, SYLHET_RESTAURANT s_r, 
  user_sdo_geom_metadata m 
  WHERE m.table_name = 'SYLHET_RESTAURANT' AND m.column_name = 'SHAPE' 
  AND s_i.rest_name = 'Woondal' AND s_r.rest_name = 'Hungry Station';  
  
SELECT s_i.rest_name, SDO_GEOM.SDO_BUFFER(s_i.shape, m.diminfo, 100) 
  FROM SYLHET_RESTAURANT s_i, user_sdo_geom_metadata m 
  WHERE m.table_name = 'SYLHET_RESTAURANT'  AND m.column_name = 'SHAPE' 
  AND s_i.rest_name = 'Woondal';