SELECT ROWNUM AS idx ,
  calendar_date ,
  to_char(calendar_date, 'DAY')             AS day_of_week_name ,
  to_number(to_char(calendar_date, 'D'))    AS day_of_week_number ,
  to_number(to_char(calendar_date, 'WW'))   AS week_of_year_number ,
  to_number(to_char(calendar_date, 'DD'))   AS day_of_month_number ,
  to_number(to_char(calendar_date, 'MM'))   AS month_of_year_number ,
  to_char(calendar_date, 'MONTH')           AS month_of_year ,
  to_number(to_char(calendar_date, 'YY'))   AS year_number_double_digit ,
  to_number(to_char(calendar_date, 'YYYY')) AS year_number_four_digit ,
  to_number(to_char(calendar_date, 'Q'))    AS quarter_number ,
  ceil(ROWNUM/7)                            AS fy_week ,
  CASE
    WHEN EXTRACT(MONTH FROM calendar_date) IN (4,5,6)
    THEN 'Q1'
    WHEN EXTRACT(MONTH FROM calendar_date) IN (7,8,9)
    THEN 'Q2'
    WHEN EXTRACT(MONTH FROM calendar_date) IN (10,11,12)
    THEN 'Q3'
    WHEN EXTRACT(MONTH FROM calendar_date) IN (1,2,3)
    THEN 'Q4'
    ELSE NULL
  END AS fy_quarter ,
  CASE
    WHEN EXTRACT(MONTH FROM calendar_date) IN (4,5,6)
    THEN 1
    WHEN EXTRACT(MONTH FROM calendar_date) IN (7,8,9)
    THEN 2
    WHEN EXTRACT(MONTH FROM calendar_date) IN (10,11,12)
    THEN 3
    WHEN EXTRACT(MONTH FROM calendar_date) IN (1,2,3)
    THEN 4
    ELSE NULL
  END  AS fy_quarter_number ,
  '24' AS fy_year ,
  CASE
    WHEN to_number(to_char(calendar_date, 'D')) IN (6,7)
    THEN 'N'
    ELSE 'Y'
  END AS is_work_day
FROM
  (SELECT to_date('01-APR-24','DD-MON-YY') + LEVEL -1 AS calendar_date
  FROM dual
    CONNECT BY LEVEL <= to_date('31-MAR-25', 'DD-MON-YY') - to_date('01-APR-24','DD-MON-YY') +1
  ) ;
