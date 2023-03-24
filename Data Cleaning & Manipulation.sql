--Creating a new table (MasterList) to store data for 2022
--SELECT * INTO [dbo].[MasterList] FROM (
  SELECT * FROM [dbo].[Jan2022]
  UNION ALL
  SELECT * FROM [dbo].[Feb2022]
  UNION ALL
  SELECT * FROM [dbo].[Mar2022]
  UNION ALL
  SELECT * FROM [dbo].[Apr2022]
  UNION ALL
  SELECT * FROM [dbo].[May2022]
  UNION ALL
  SELECT * FROM [dbo].[Jun2022]
  UNION ALL
  SELECT * FROM [dbo].[Jul2022]
  UNION ALL
  SELECT * FROM [dbo].[Aug2022]
  UNION ALL
  SELECT * FROM [dbo].[Sep2022]
  UNION ALL
  SELECT * FROM [dbo].[Oct2022]
  UNION ALL
  SELECT * FROM [dbo].[Nov2022]
  UNION ALL
  SELECT * FROM [dbo].[Dec2022]
) AS all_data;


-- DATA CLEANING & MANIPULATION

-- Create new columns for start date, end date, ride length, quarter, and day of week
SELECT 
  [ride_id],
  [rideable_type],
  [start_station_name],
  [start_station_id],
  [end_station_name],
  [end_station_id],
  [member_casual],
  [start_lat],
  [start_lng],
  [end_lat],
  [end_lng],
  CONVERT(DATE, started_at) AS start_date,
  CONVERT(DATE, ended_at) AS end_date,
  CONVERT(varchar, started_at, 108) AS start_time,
  CONVERT(varchar, ended_at, 108) AS end_time,
  DATEDIFF(MINUTE, started_at, ended_at) AS ride_length,
  MONTH(started_at) AS ride_month,
  REPLACE('Quarter' + CAST(DATEPART(QUARTER, started_at) AS VARCHAR(1)), 'Quarter', 'Q') AS quarter,
  DATENAME(WEEKDAY, started_at) AS day_of_week
FROM [dbo].[MasterList];
