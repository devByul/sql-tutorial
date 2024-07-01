# 누적합 SQL Example
WITH counted_duplicates AS (
	SELECT
		`Language`,
		COUNT(*) AS `duplicate_count`
	FROM `countrylanguage`
	GROUP BY `Language`
	HAVING COUNT(*) >= 1
)
SELECT 
	`Language`,
    `duplicate_count`,
    SUM(`duplicate_count`) OVER (ORDER BY `duplicate_count` ASC 
                                    ROWS BETWEEN # 윈도우의 범위를 지정하는 역할
                                        UNBOUNDED PRECEDING # 윈도우의 시작점 - 윈도우 첫번째 행을 가르킴
                                        AND CURRENT ROW # 윈도우의 현재행 - 현재 처리중인 행에 대해 계산되는 범위를 의미
                                ) AS cumulative_sum
FROM `counted_duplicates`
ORDER BY `duplicate_count` ASC;