with max_date as (

      select date(max(date)) as max_date from {{ source('splitwise_expenses', 'splitwise_expenses') }}

  )
)
,
generic_date_dim AS (

SELECT
  FORMAT_DATE('%F', d) as id,
  d AS full_date,
  EXTRACT(YEAR FROM d) AS year,
  EXTRACT(WEEK FROM d) AS year_week,
  EXTRACT(DAY FROM d) AS year_day,
  EXTRACT(YEAR FROM d) AS fiscal_year,
  FORMAT_DATE('%Q', d) as fiscal_qtr,
  EXTRACT(MONTH FROM d) AS month,
  FORMAT_DATE('%Y %b', d) as year_month,
  FORMAT_DATE('%B', d) as month_name,
  FORMAT_DATE('%w', d) AS week_day,
  FORMAT_DATE('%A', d) AS day_name,
  (CASE WHEN FORMAT_DATE('%A', d) IN ('Sunday', 'Saturday') THEN 0 ELSE 1 END) AS day_is_weekday,
FROM (
  SELECT
    *
  FROM
    UNNEST(GENERATE_DATE_ARRAY('2014-01-01', '2050-01-01', INTERVAL 1 DAY)) AS d )
)
SELECT *,
CASE
WHEN 
  EXTRACT(MONTH FROM dd.full_date) = EXTRACT(MONTH FROM a.max_date) then "Current Month"
WHEN
  EXTRACT(MONTH FROM dd.full_date) = EXTRACT(MONTH FROM a.max_date) then "Previous Month"

ELSE year_month
END AS year_month_report FROM generic_date_dim dd
CROSS JOIN max_date a
WHERE dd.full_date <= a.max_date AND dd.full_date > '2020-03-01'
