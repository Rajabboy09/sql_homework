CREATE TABLE Shipments (
    N INT PRIMARY KEY,
    Num INT
);

INSERT INTO Shipments (N, Num) VALUES
    (1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1),
    (9, 2), (10, 2), (11, 2), (12, 2), (13, 2),
    (14, 4), (15, 4), (16, 4), (17, 4), (18, 4), (19, 4), (20, 4), (21, 4), (22, 4), (23, 4), (24, 4), (25, 4),
    (26, 5), (27, 5), (28, 5), (29, 5), (30, 5), (31, 5),
    (32, 6),
    (33, 7);



with alldays as (
	SELECT 1 AS days
	UNION ALL
	SELECT days+1 
	FROM alldays
	WHERE days <40
),
fulltable AS (
	SELECT 
	ad.days,
	ISNULL(s.Num,0) AS Numbers,
	ROW_NUMBER() OVER(ORDER BY ISNULL(s.Num,0)) as t,
	COUNT(days) OVER() AS Total
	FROM alldays ad
	LEFT JOIN Shipments s
	ON ad.days = s.N
)
SELECT AVG(Numbers) AS MEDIAN 
FROM fulltable
