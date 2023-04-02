
--Perform data wrangling and cleaning to clean and transform the dataset

--Creating a new table (MasterList) to compile all data for 2022
DROP TABLE IF EXISTS [dbo].[MasterList];
SELECT * INTO [dbo].[MasterList] FROM (
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

SELECT * FROM [dbo].[MasterList]

--Perform data wrangling and cleaning to clean and transform the dataset
SELECT * FROM [dbo].[MasterList]

SELECT * 
FROM [dbo].[MasterList]
WHERE [ride_id] IS NULL

--split date and time information from started_at and ended_at column
--SELECT 
--	CONVERT(DATE, started_at) AS ride_date,
--	CONVERT(varchar, started_at, 108) AS start_time,
--	CONVERT(varchar, ended_at, 108) AS end_time
--FROM [dbo].[MasterList]

ALTER TABLE [dbo].[MasterList] ADD ride_date DATE;
ALTER TABLE [dbo].[MasterList] ADD start_time VARCHAR(8);
ALTER TABLE [dbo].[MasterList] ADD end_time VARCHAR(8);

--update details in ride_date column
UPDATE [dbo].[MasterList]
SET [ride_date] = CONVERT(DATE, [started_at])

--update details in start_time column
UPDATE [dbo].[MasterList]
SET [start_time] = CONVERT(varchar, [started_at], 108)

--update details in start_time column
UPDATE [dbo].[MasterList]
SET [end_time] = CONVERT(varchar, [ended_at], 108)

--remove started_at and ended_at column 
ALTER TABLE [dbo].[MasterList]
DROP COLUMN [started_at],[ended_at]

--Rename the column member_casual to user type
sp_rename '[dbo].[MasterList].[member_casual]', 'user_type', 'COLUMN'

--create new column named Quarter to see the breakdown by quarter
--SELECT 
--	[ride_date],
--	DATEPART(QUARTER, [ride_date]) AS Quarter
--FROM [dbo].[MasterList]

ALTER TABLE [dbo].[MasterList] ADD quarter varchar;

UPDATE [dbo].[MasterList]
SET [quarter] = DATEPART(QUARTER, [ride_date])

--create new column dayofweek to identify ride trend by weekdays/weekends
--SELECT 
--	[ride_date],
--	DATENAME(WEEKDAY, [ride_date]) AS day_of_week
--FROM [dbo].[MasterList]

ALTER TABLE [dbo].[MasterList] ADD dayofweek VARCHAR(50);

UPDATE [dbo].[MasterList]
SET [dayofweek] = DATENAME(WEEKDAY, [ride_date])

--create new column ride_length
--SELECT 
--	[start_time],
--	[end_time],
--	DATEDIFF(MINUTE, [start_time],[end_time]) AS ride_length
--FROM [dbo].[MasterList]

ALTER TABLE [dbo].[MasterList] ADD ride_length VARCHAR(50);

UPDATE [dbo].[MasterList]
SET [ride_length] = DATEDIFF(MINUTE, [start_time],[end_time])

--check final table
SELECT * FROM [dbo].[MasterList]



