# Bellabeat Fitness Tracker Case Study

## Project Overview

This case study analyzes Fitbit fitness tracker data to identify trends in consumer activity and sleep behavior. The goal is to determine how these insights could help Bellabeat better understand smart device users and support its marketing strategy.

## Business Task

Analyze smart device usage data to identify trends in consumer behavior and determine how these insights could be applied to Bellabeat customers and used to support Bellabeat's marketing strategy.

## Tools Used

- SQL
- Google BigQuery
- Python (pandas) - initial data inspection and cleaning
- Google Sheets - data visualization

## Dataset

The analysis uses the Fitbit Fitness Tracker Data dataset available on Kaggle.

The daily activity dataset contains:
- 940 records
- 33 unique users
- Data from April 12, 2016 to May 12, 2016

Sleep data is available for only a subset of users.

## Analysis

The analysis explored:
- Average daily steps and calories
- Time spent at different activity levels
- Activity patterns by day of the week
- Relationship between steps and calories burned
- User activity levels
- Zero-step days
- Sleep duration and sleep efficiency
- Relationship between sleep and physical activity

## Key Findings

- Users averaged approximately 7,638 steps per day.
- Users spent approximately 991 minutes per day sedentary.
- Saturday had the highest average number of steps (8,153), while Sunday had the lowest (6,933).
- Daily steps and calories burned showed a moderate positive correlation (r = 0.592).
- 7 of 33 users averaged at least 10,000 steps per day.
- Users slept approximately 7 hours per night on average.
- Sleep duration showed little relationship with daily steps or calories burned.

## Recommendations

1. Encourage regular daily movement through personalized reminders and activity goals.

2. Use activity patterns to provide personalized notifications and encouragement based on individual user behavior.

3. Promote combined activity and sleep tracking to help users better understand their wellness habits.

## Limitations

The dataset contains a relatively small number of users and covers approximately one month. Sleep data is available for only a subset of the activity records.

Therefore, the findings should not be assumed to represent the broader population of fitness tracker users. A larger and more diverse dataset collected over a longer period would provide more reliable insights.

## Project Files

- `bellabeat_analysis.sql` - SQL queries used for the analysis
- `Bellabeat_Case_Study.pdf` - complete case study
- `Visualizations/` - charts presenting the key findings