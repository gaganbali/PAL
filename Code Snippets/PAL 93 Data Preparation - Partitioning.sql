SELECT *, RANDOM_PARTITION(0.6,0.2,0.2,0) OVER () AS "PARTITION_ID" 
 FROM "PAL"."CUSTOMERS"
 ;
