ALTER TABLE 
  "Salinity_EPED"
ALTER COLUMN 
  "SamplingDate" TYPE character(20);
SELECT 
  "Salinity_EPED"."ID", 
  "Salinity_EPED"."WellNumber", 
  "Salinity_EPED"."SerialNumber", 
  "Salinity_EPED"."Lon", 
  "Salinity_EPED"."Lat", 
  "Salinity_EPED"."MonitorType", 
  "Salinity_EPED"."CL", 
  "Salinity_EPED"."TDS", 
  "Salinity_EPED"."GroundwaterLevel", 
  "Salinity_EPED"."Tempreture", 
  "Salinity_EPED"."SamplingDate"
INTO 
  "Salinity_PED"
FROM 
  public."Salinity_EPED"
UNION ALL 
SELECT 
  "Salinity_WPED"."ID", 
  "Salinity_WPED"."WellNumber", 
  "Salinity_WPED"."SerialNumber", 
  "Salinity_WPED"."Lon", 
  "Salinity_WPED"."Lat", 
  "Salinity_WPED"."MonitorType", 
  "Salinity_WPED"."CL", 
  "Salinity_WPED"."TDS", 
  "Salinity_WPED"."GroundwaterLevel", 
  "Salinity_WPED"."Tempreture", 
  "Salinity_WPED"."SamplingDate"
FROM 
  public."Salinity_WPED";

ALTER TABLE 
  "Salinity_PED"
ADD 
  "IDD" serial;
UPDATE 
  public."Salinity_PED" 
SET 
  "SamplingDate"=LEFT("SamplingDate" , 10);  
 