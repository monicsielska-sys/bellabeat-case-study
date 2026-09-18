-- =====================================================
-- BELLABEAT FITNESS TRACKER CASE STUDY
-- SQL DATA ANALYSIS
-- Tool: Google BigQuery
-- =====================================================

-- Dataset analyzed:
-- Fitbit Fitness Tracker Data
-- Analysis period: April 12, 2016 - May 12, 2016


-- =====================================================
-- 1. DATA OVERVIEW
-- =====================================================

-- Check the number of records, unique users,
-- and the date range of the daily activity data.

SELECT
  COUNT(*) AS total_records,
  COUNT(DISTINCT Id) AS unique_users,
  MIN(ActivityDate) AS start_date,
  MAX(ActivityDate) AS end_date
FROM `project-cc460086-9b8c-420d-b4b.Portfolio.daily_activity`;


-- =====================================================
-- 2. DAILY ACTIVITY SUMMARY
-- =====================================================

-- Calculate basic statistics for daily activity.

SELECT
  ROUND(AVG(TotalSteps), 2) AS avg_steps,
  MIN(TotalSteps) AS min_steps,
  MAX(TotalSteps) AS max_steps,
  ROUND(AVG(TotalDistance), 2) AS avg_distance,
  ROUND(AVG(Calories), 2) AS avg_calories
FROM `project-cc460086-9b8c-420d-b4b.Portfolio.daily_activity`;
-- =====================================================
-- 3. ACTIVITY LEVELS
-- =====================================================

-- Calculate average daily minutes spent at each activity level.

SELECT
  ROUND(AVG(VeryActiveMinutes), 2) AS avg_very_active,
  ROUND(AVG(FairlyActiveMinutes), 2) AS avg_fairly_active,
  ROUND(AVG(LightlyActiveMinutes), 2) AS avg_lightly_active,
  ROUND(AVG(SedentaryMinutes), 2) AS avg_sedentary
FROM `project-cc460086-9b8c-420d-b4b.Portfolio.daily_activity`;
-- =====================================================
-- 4. ACTIVITY BY DAY OF WEEK
-- =====================================================

-- Calculate average daily steps and calories by day of week.

SELECT
  FORMAT_DATE('%A', ActivityDate) AS day_of_week,
  ROUND(AVG(TotalSteps), 2) AS avg_steps,
  ROUND(AVG(Calories), 2) AS avg_calories
FROM `project-cc460086-9b8c-420d-b4b.Portfolio.daily_activity`
GROUP BY day_of_week
ORDER BY
  CASE day_of_week
    WHEN 'Monday' THEN 1
    WHEN 'Tuesday' THEN 2
    WHEN 'Wednesday' THEN 3
    WHEN 'Thursday' THEN 4
    WHEN 'Friday' THEN 5
    WHEN 'Saturday' THEN 6
    WHEN 'Sunday' THEN 7
  END;
  -- =====================================================
-- 5. STEPS AND CALORIES RELATIONSHIP
-- =====================================================

-- Measure the correlation between daily steps and calories burned.

SELECT
  ROUND(CORR(TotalSteps, Calories), 3) AS steps_calories_correlation
FROM `project-cc460086-9b8c-420d-b4b.Portfolio.daily_activity`;
-- =====================================================
-- 6. USER ACTIVITY LEVELS
-- =====================================================

-- Calculate average daily steps for each user.

SELECT
  Id,
  ROUND(AVG(TotalSteps), 2) AS avg_daily_steps
FROM `project-cc460086-9b8c-420d-b4b.Portfolio.daily_activity`
GROUP BY Id
ORDER BY avg_daily_steps DESC;


-- Count users averaging at least 10,000 steps per day.

WITH user_steps AS (
  SELECT
    Id,
    AVG(TotalSteps) AS avg_daily_steps
  FROM `project-cc460086-9b8c-420d-b4b.Portfolio.daily_activity`
  GROUP BY Id
)

SELECT
  COUNT(*) AS total_users,
  COUNTIF(avg_daily_steps >= 10000) AS users_10k_or_more,
  COUNTIF(avg_daily_steps < 10000) AS users_below_10k
FROM user_steps;
-- =====================================================
-- 7. ZERO-STEP DAYS
-- =====================================================

-- Check how many daily records contain zero recorded steps.

SELECT
  COUNT(*) AS zero_step_days,
  ROUND(
    COUNT(*) * 100.0 /
    (SELECT COUNT(*)
     FROM `project-cc460086-9b8c-420d-b4b.Portfolio.daily_activity`),
    2
  ) AS percentage
FROM `project-cc460086-9b8c-420d-b4b.Portfolio.daily_activity`
WHERE TotalSteps = 0;
-- =====================================================
-- 8. SLEEP ANALYSIS
-- =====================================================

-- Calculate basic sleep statistics.

SELECT
  ROUND(AVG(TotalMinutesAsleep), 2) AS avg_minutes_asleep,
  ROUND(AVG(TotalTimeInBed), 2) AS avg_time_in_bed,
  MIN(TotalMinutesAsleep) AS min_minutes_asleep,
  MAX(TotalMinutesAsleep) AS max_minutes_asleep
FROM `project-cc460086-9b8c-420d-b4b.Portfolio.sleep_day`;


-- Calculate average sleep efficiency.

SELECT
  ROUND(
    AVG(TotalMinutesAsleep / TotalTimeInBed) * 100,
    2
  ) AS avg_sleep_efficiency
FROM `project-cc460086-9b8c-420d-b4b.Portfolio.sleep_day`
WHERE TotalTimeInBed > 0;
-- =====================================================
-- 9. JOIN ACTIVITY AND SLEEP DATA
-- =====================================================

-- Join daily activity and sleep data using user ID and date.

SELECT
  a.Id,
  a.ActivityDate,
  a.TotalSteps,
  a.Calories,
  s.TotalMinutesAsleep,
  s.TotalTimeInBed
FROM `project-cc460086-9b8c-420d-b4b.Portfolio.daily_activity` AS a
INNER JOIN `project-cc460086-9b8c-420d-b4b.Portfolio.sleep_day` AS s
  ON a.Id = s.ID
  AND a.ActivityDate =
      DATE(PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', s.SleepDay));
 -- =====================================================
-- 10. SLEEP AND ACTIVITY RELATIONSHIPS
-- =====================================================

-- Measure the relationship between sleep duration,
-- daily steps, and calories burned.

SELECT
  ROUND(CORR(a.TotalSteps, s.TotalMinutesAsleep), 3)
    AS sleep_steps_correlation,
  ROUND(CORR(a.Calories, s.TotalMinutesAsleep), 3)
    AS sleep_calories_correlation
FROM `project-cc460086-9b8c-420d-b4b.Portfolio.daily_activity` AS a
INNER JOIN `project-cc460086-9b8c-420d-b4b.Portfolio.sleep_day` AS s
  ON a.Id = s.ID
  AND a.ActivityDate =
      DATE(PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', s.SleepDay));     