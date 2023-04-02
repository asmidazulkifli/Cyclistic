# Cyclistic
##### Google Data Analytics Capstone Project - Cyclistic Bike-Share

##### Data Set - https://divvy-tripdata.s3.amazonaws.com/index.html 
##### The data has been made available by Motivate International Inc. under this license - https://ride.divvybikes.com/data-license-agreement
### Project Goal
##### The goal of this project is to analyze the data from the Cyclistic bike-share program in Chicago to gain insights into the usage patterns of casual riders and annual members. 
##### By understanding the differences in how these two groups use Cyclistic bikes, we hope to identify opportunities to convert casual riders into annual members. 
From the data findings, the team will design a new marketing strategy to convert casual riders into annual members.

##### Tools use
##### Microsoft SQL for data cleaning and exploration. PowerBI for data visualization

### Data Cleaning and Wrangling
##### To start the data cleaning and wrangling process, I imported all CSV files for the Cyclistic bike-share program into a database named CyclisticCaseStudy. 
##### Next, I merged all the tables for Jan 2022 to Dec 2022 using the Union All statement to create a single master table named dbo.Masterlist. 
##### This master table contains all the necessary data for further analysis.

##### For further details on cleaning and transformation process, please check file - Data Cleaning & Manipulation.sql (https://github.com/asmidazulkifli/Cyclistic)

### Data Exploration
##### 3 crucial questions to be answered which will guide the future marketing program:

1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

##### To answer the listed questions, I have breakdown the rides pattern to Quarterly, Monthly, Hourly and Day of Week.

##### For further details on data exploration, please check file - Data Exploration.sql (https://github.com/asmidazulkifli/Cyclistic)

## Result - Data Visualization
![dashboard01](https://user-images.githubusercontent.com/127869781/229340480-cf099e06-0bc6-4ba6-9d23-0eceffafed99.png)
