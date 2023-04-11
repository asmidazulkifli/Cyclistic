/*

Cyclistic Bike Share Data Cleaning

*/

-------------------------------------------------------------------------------------------------------------------------------------------------

-- Create a MasterList table to compile all data for 2022

DROP TABLE IF EXISTS [dbo].[MasterList];
SELECT * INTO [dbo].[MasterList] FROM (
  SELECT * FROM [dbo].[01Jan2022]
  UNION ALL
  SELECT * FROM [dbo].[02Feb2022]
  UNION ALL
  SELECT * FROM [dbo].[03Mar2022]
  UNION ALL
  SELECT * FROM [dbo].[04Apr2022]
  UNION ALL
  SELECT * FROM [dbo].[05May2022]
  UNION ALL
  SELECT * FROM [dbo].[06Jun2022]
  UNION ALL
  SELECT * FROM [dbo].[07Jul2022]
  UNION ALL
  SELECT * FROM [dbo].[08Aug2022]
  UNION ALL
  SELECT * FROM [dbo].[09Sep2022]
  UNION ALL
  SELECT * FROM [dbo].[10Oct2022]
  UNION ALL
  SELECT * FROM [dbo].[11Nov2022]
  UNION ALL
  SELECT * FROM [dbo].[12Dec2022]
  ) AS all_data;

  SELECT * FROM [dbo].[MasterList]

-------------------------------------------------------------------------------------------------------------------------------------------------

-- Check for empty rows

SELECT * 
FROM [dbo].[MasterList]
WHERE [ride_id] IS NULL

-------------------------------------------------------------------------------------------------------------------------------------------------

-- Rename data in rideable_type

SELECT DISTINCT [rideable_type] 
FROM [dbo].[MasterList]

SELECT TOP (50) [rideable_type],
CASE
	WHEN [rideable_type] = 'electric_bike' THEN 'electric'
	WHEN [rideable_type] = 'classic_bike' THEN 'classic'
	WHEN [rideable_type] = 'docked_bike' THEN 'docked'
	ELSE [rideable_type]
	END
FROM [dbo].[MasterList]


UPDATE [dbo].[MasterList]
SET [rideable_type] =
CASE
	WHEN [rideable_type] = 'electric_bike' THEN 'electric'
	WHEN [rideable_type] = 'classic_bike' THEN 'classic'
	WHEN [rideable_type] = 'docked_bike' THEN 'docked'
	ELSE [rideable_type]
	END

-------------------------------------------------------------------------------------------------------------------------------------------------

-- Rename column member_casual to usertype
sp_rename '[dbo].[MasterList].[member_casual]', 'user_type', 'COLUMN'

-------------------------------------------------------------------------------------------------------------------------------------------------

-- Extract Date information from started_at column

SELECT TOP (50) 
	CONVERT(DATE, [started_at]) AS ride_date
FROM [dbo].[MasterList]


ALTER TABLE [dbo].[MasterList] ADD ride_date DATE;

UPDATE [dbo].[MasterList]
SET [ride_date] = CONVERT(DATE, [started_at])

-------------------------------------------------------------------------------------------------------------------------------------------------

-- Create Quarter column to show breakdown by quarter

SELECT TOP (50)
	[ride_date],
	DATEPART(QUARTER, [ride_date]) AS Quarter
FROM [dbo].[MasterList]


ALTER TABLE [dbo].[MasterList] ADD quarter varchar;

UPDATE [dbo].[MasterList]
SET [quarter] = DATEPART(QUARTER, [ride_date])

-------------------------------------------------------------------------------------------------------------------------------------------------

-- Extract Day of Week information from ride_date columns

SELECT TOP (50) 
	[ride_date],
	DATEPART(WEEKDAY, [ride_date]) AS dayofweek,
	CASE
	WHEN DATEPART(WEEKDAY, [ride_date]) = 1 THEN 'Monday'
	WHEN DATEPART(WEEKDAY, [ride_date]) = 2 THEN 'Tuesday'
	WHEN DATEPART(WEEKDAY, [ride_date]) = 3 THEN 'Wednesday'
	WHEN DATEPART(WEEKDAY, [ride_date]) = 4 THEN 'Thursday'
	WHEN DATEPART(WEEKDAY, [ride_date]) = 5 THEN 'Friday'
	WHEN DATEPART(WEEKDAY, [ride_date]) = 6 THEN 'Saturday'
	WHEN DATEPART(WEEKDAY, [ride_date]) = 7 THEN 'Sunday'
	ELSE 'Unknown'
	END AS day_of_week
FROM [dbo].[MasterList]


ALTER TABLE [dbo].[MasterList] ADD day_of_week VARCHAR(50)

UPDATE [dbo].[MasterList]
SET [day_of_week] =
CASE
	WHEN DATEPART(WEEKDAY, [ride_date]) = 1 THEN 'Monday'
	WHEN DATEPART(WEEKDAY, [ride_date]) = 2 THEN 'Tuesday'
	WHEN DATEPART(WEEKDAY, [ride_date]) = 3 THEN 'Wednesday'
	WHEN DATEPART(WEEKDAY, [ride_date]) = 4 THEN 'Thursday'
	WHEN DATEPART(WEEKDAY, [ride_date]) = 5 THEN 'Friday'
	WHEN DATEPART(WEEKDAY, [ride_date]) = 6 THEN 'Saturday'
	WHEN DATEPART(WEEKDAY, [ride_date]) = 7 THEN 'Sunday'
	ELSE 'Unknown'
	END

SELECT * FROM [dbo].[MasterList]
WHERE [day_of_week] = 'Unknown'

-------------------------------------------------------------------------------------------------------------------------------------------------

-- Extract Time information from started_at and ended_at column

SELECT TOP (50)
	CONVERT(TIME, [started_at], 108) AS start_time,
	CONVERT(TIME, [ended_at], 108) AS end_time
FROM [dbo].[MasterList]


ALTER TABLE [dbo].[MasterList] ADD start_time VARCHAR(8);
ALTER TABLE [dbo].[MasterList] ADD end_time VARCHAR(8);

UPDATE [dbo].[MasterList]
SET [start_time] = CONVERT(TIME, [started_at], 108)

UPDATE [dbo].[MasterList]
SET [end_time] = CONVERT(TIME, [ended_at], 108)

-------------------------------------------------------------------------------------------------------------------------------------------------

-- New column to calculate ride_length 

SELECT TOP (50)
	[start_time],
	[end_time],
	DATEDIFF(MINUTE, [start_time],[end_time]) AS ride_length
FROM [dbo].[MasterList]


ALTER TABLE [dbo].[MasterList] ADD ride_length VARCHAR(50);

UPDATE [dbo].[MasterList]
SET [ride_length] = DATEDIFF(MINUTE, [start_time],[end_time])

-------------------------------------------------------------------------------------------------------------------------------------------------

-- Delete unused column; started_at and ended_at

ALTER TABLE [dbo].[MasterList]
DROP COLUMN [started_at],[ended_at]

-------------------------------------------------------------------------------------------------------------------------------------------------

-- Rename column member_casual to usertype
sp_rename '[dbo].[MasterList].[member_casual]', 'user_type', 'COLUMN'

-------------------------------------------------------------------------------------------------------------------------------------------------

-- Table now ready for Data Exploration

SELECT * FROM [dbo].[MasterList]