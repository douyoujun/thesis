UPDATE 
  public."GWLevel_PED" 
SET 
  "SamplingDate"=LEFT("SamplingDate" , 10);
UPDATE 
  public."Salinity_PED"
SET 
  "GWLc" = public."GWLevel_PED"."GroundwaterLevel" 
FROM 
  public."GWLevel_PED"
WHERE 
  public."Salinity_PED"."WellNumber"=public."GWLevel_PED"."WellNumber"
AND 
  public."Salinity_PED"."SamplingDate"=public."GWLevel_PED"."SamplingDate";