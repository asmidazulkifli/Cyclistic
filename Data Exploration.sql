-- DATA EXPLORATION

--Three crucial questions to be answered which will guide the future marketing program:
--1. How do annual members and casual riders use Cyclistic bikes differently?
--2. Why would casual riders buy Cyclistic annual memberships?
--3. How can Cyclistic use digital media to influence casual riders to become members?

SELECT * FROM [dbo].[MasterList]

--total number of rides in 2022
SELECT COUNT(*) AS total_rides FROM [dbo].[MasterList]

--average number of rides per day
SELECT 
	AVG(total_rides) AS average_rides_per_day 
FROM 
	(SELECT ride_date, COUNT(*) AS total_rides
	FROM [dbo].[MasterList]
	GROUP BY ride_date
) AS daily_rides;

--rides by member v casual
SELECT 
	user_type, 
	COUNT(*) AS total_rides 
FROM [dbo].[MasterList] 
GROUP BY user_type;

--rides count by rideable_type and user type
SELECT 
	rideable_type, 
	user_type, 
	COUNT(*) AS total_rides 
FROM [dbo].[MasterList] 
GROUP BY rideable_type, user_type;

--average ride length
SELECT AVG(CAST([ride_length] AS FLOAT)) AS average_ride_length FROM [dbo].[MasterList];

--average number of rides per week for each quarter
SELECT 
	quarter, 
	AVG(total_rides) AS average_rides_per_week 
FROM 
	(SELECT 'Quarter' + CAST(DATEPART(QUARTER, started_at) AS VARCHAR(1)) AS quarter, COUNT(*) AS total_rides, DATEPART(WEEK, started_at) AS week_number
	FROM [dbo].[MasterList]
	GROUP BY 'Quarter' + CAST(DATEPART(QUARTER, started_at) AS VARCHAR(1)), DATEPART(WEEK, started_at)
) AS quarter_rides GROUP BY quarter

--rides by quarter
SELECT 
	quarter, 
	COUNT(*) AS total_rides,
	100.0 * COUNT(*) / SUM(COUNT(*)) OVER() AS percent_total_rides 
FROM [dbo].[MasterList] GROUP BY quarter

--rides by month
SELECT  
	MONTH([ride_date]) AS ride_month,
	CASE
		WHEN MONTH([ride_date]) = 1 THEN 'Jan'
        WHEN MONTH([ride_date]) = 2 THEN 'Feb'
        WHEN MONTH([ride_date]) = 3 THEN 'Mar'
        WHEN MONTH([ride_date]) = 4 THEN 'Apr'
        WHEN MONTH([ride_date]) = 5 THEN 'May'
        WHEN MONTH([ride_date]) = 6 THEN 'Jun'
        WHEN MONTH([ride_date]) = 7 THEN 'Jul'
        WHEN MONTH([ride_date]) = 8 THEN 'Aug'
        WHEN MONTH([ride_date]) = 9 THEN 'Sep'
        WHEN MONTH([ride_date]) = 10 THEN 'Oct'
        WHEN MONTH([ride_date]) = 11 THEN 'Nov'
        WHEN MONTH([ride_date]) = 12 THEN 'Dec'
	END as ride_month01,
	COUNT(*) AS total_rides,
	100.0 * COUNT(*) / SUM(COUNT(*)) OVER() AS percent_total_rides 
FROM [dbo].[MasterList] 
GROUP BY MONTH([ride_date])
ORDER BY MONTH([ride_date]);

--rides by hour
SELECT 
	DATEPART(hour, [start_time]) AS ride_hour, 
	COUNT(*) AS total_rides
FROM [dbo].[MasterList] 
GROUP BY DATEPART(hour, [start_time])
ORDER BY DATEPART(hour, [start_time])

--rides by dayofweek
SELECT 
	[dayofweek],
	[user_type],
	COUNT(*) AS total_rides
FROM [dbo].[MasterList] 
GROUP BY [dayofweek], [user_type]
ORDER BY COUNT(*) DESC;

--total ride time in minutes for each quarter
SELECT 
	quarter, 
	SUM(ride_length) AS total_ride_time 
FROM [dbo].[MasterList] 
GROUP BY quarter;

--average ride length in minutes for each day of week
SELECT 
	quarter, 
	SUM(ride_length) AS total_ride_time 
FROM [dbo].[MasterList] 
GROUP BY quarter;

--top10 start stations by number of rides
SELECT 
	start_station_name, 
	COUNT(*) AS total_rides 
FROM [dbo].[MasterList] 
GROUP BY start_station_name 
ORDER BY total_rides DESC LIMIT 10;

--top10 end stations by number of rides
SELECT 
	end_station_name, 
	COUNT(*) AS total_rides 
FROM [dbo].[MasterList] 
GROUP BY end_station_name 
ORDER BY total_rides DESC LIMIT 10;

--top10 routes by number of rides
SELECT 
	CONCAT(start_station_name, ' to ', end_station_name) AS route, 
	COUNT(*) AS total_rides 
FROM [dbo].[MasterList] 
GROUP BY start_station_name, end_station_name 
ORDER BY total_rides DESC LIMIT 10;


