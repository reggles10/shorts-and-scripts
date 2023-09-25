DECLARE schema_list ARRAY<STRING>;
DECLARE iter INT64 DEFAULT 0;
DECLARE query STRING;
DECLARE output STRING;
--DECLARE columns ARRAY<STRING>;


CREATE OR REPLACE TABLE `skyuk-uk-decis-models-01-dev.ren11.netflix_missing_features` AS
  SELECT 'init' as project, 'init' as dataset, 'init' as table_name, 'init' as column_name;

-- Ideally set a parameter containing columns to check, but not yet working
--SET columns = (
--  -- SELECT STRUCT(
--    SELECT [
-- 'col1', 'col2'] as columns);

-- Get all datasets in the project
SET schema_list =
  (
    SELECT  ARRAY_AGG(schema_name)
    FROM INFORMATION_SCHEMA.SCHEMATA
  );

-- Iterate over all datasets and insert into the new table any found results
WHILE iter < ARRAY_LENGTH(schema_list) DO
  SET query = "INSERT INTO `skyuk-uk-decis-models-01-dev.ren11.netflix_missing_features` SELECT table_catalog as project, table_schema as dataset, table_name, column_name  FROM "
  || schema_list[OFFSET(iter)] || ".INFORMATION_SCHEMA.COLUMNS" ||
-- Filter for specific columns
  " WHERE column_name IN " ||
 "('Movies_Upgrades_Ever', 'UP_SkyQ', 'Q_PrimaryBox', 'Movies_Purchases_Ever', 'Movies_Purchases_In_Last_1yr', 'BnK_Purchases_Ever', 'OTT_Purchases_In_Last_90d', 'Event_Purchases_Ever')" ||
" AND table_name NOT LIKE '%temp%' AND table_schema NOT LIKE '%temp%'";
  EXECUTE IMMEDIATE query;
  SET iter = iter + 1;
END WHILE;


