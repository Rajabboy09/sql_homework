DECLARE @date DATE = '20241105';
DECLARE @firstDay DATE = DATEFROMPARTS(YEAR(@date), MONTH(@date), 1);
DECLARE @lastDay DATE = EOMONTH(@firstDay);

WITH Calendar AS (
    SELECT 
        1 AS DayNumber,
        @firstDay AS FullDate
    UNION ALL
    SELECT 
        DayNumber + 1,
        DATEADD(DAY, 1, FullDate)
    FROM Calendar
    WHERE DATEADD(DAY, 1, FullDate) <= @lastDay
),
PivotData AS (
    SELECT 
        DayNumber,
        FullDate,
        DATENAME(WEEKDAY, FullDate) AS WeekDayName,
        DATEPART(WEEKDAY, FullDate) AS WeekDayNumber
    FROM Calendar
)
SELECT 
    MAX(CASE WHEN WeekDayNumber = 1 THEN DayNumber END) AS Sunday,
    MAX(CASE WHEN WeekDayNumber = 2 THEN DayNumber END) AS Monday,
    MAX(CASE WHEN WeekDayNumber = 3 THEN DayNumber END) AS Tuesday,
    MAX(CASE WHEN WeekDayNumber = 4 THEN DayNumber END) AS Wednesday,
    MAX(CASE WHEN WeekDayNumber = 5 THEN DayNumber END) AS Thursday,
    MAX(CASE WHEN WeekDayNumber = 6 THEN DayNumber END) AS Friday,
    MAX(CASE WHEN WeekDayNumber = 7 THEN DayNumber END) AS Saturday
FROM PivotData
GROUP BY DATEPART(WEEK, FullDate)
OPTION (MAXRECURSION 31);
