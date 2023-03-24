-- DATA EXPLORATION

--total number of rides in 2022
SELECT COUNT(*) AS total_rides FROM MasterList;

--average number of rides per day
SELECT AVG(total_rides) AS average_rides_per_day FROM (
  SELECT CONVERT(DATE, started_at) AS ride_date, COUNT(*) AS total_rides
  FROM MasterList
  GROUP BY CONVERT(DATE, started_at)
) AS daily_rides;

--averag number of rides per week for each quarter
SELECT quarter, AVG(total_rides) AS average_rides_per_week FROM (
  SELECT 'Quarter' + CAST(DATEPART(QUARTER, started_at) AS VARCHAR(1)) AS quarter, COUNT(*) AS total_rides, DATEPART(WEEK, started_at) AS week_number
  FROM MasterList
  GROUP BY 'Quarter' + CAST(DATEPART(QUARTER, started_at) AS VARCHAR(1)), DATEPART(WEEK, started_at)
) AS quarter_rides GROUP BY quarter;


--rides count by rideable_type
SELECT rideable_type, COUNT(*) AS total_rides FROM MasterList GROUP BY rideable_type;

--rides by member v casual
SELECT member_casual, COUNT(*) AS total_rides FROM MasterList GROUP BY member_casual;

--average ride length
SELECT AVG(ride_length) AS average_ride_length FROM MasterList;

--total ride time in minutes for each quarter
SELECT quarter, SUM(ride_length) AS total_ride_time FROM MasterList GROUP BY quarter;

--average ride length in minutes for each day of week
SELECT quarter, SUM(ride_length) AS total_ride_time FROM MasterList GROUP BY quarter;

--top10 start stations by number of rides
SELECT start_station_name, COUNT(*) AS total_rides FROM MasterList GROUP BY start_station_name ORDER BY total_rides DESC LIMIT 10;

--top10 end stations by number of rides
SELECT end_station_name, COUNT(*) AS total_rides FROM MasterList GROUP BY end_station_name ORDER BY total_rides DESC LIMIT 10;

--top10 routes by number of rides
SELECT CONCAT(start_station_name, ' to ', end_station_name) AS route, COUNT(*) AS total_rides FROM MasterList GROUP BY start_station_name, end_station_name ORDER BY total_rides DESC LIMIT 10;


