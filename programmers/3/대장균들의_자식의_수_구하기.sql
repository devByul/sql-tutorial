WITH CHILD_CNT AS (
    SELECT
        PARENT_ID,
        COUNT(*) AS CHILD_COUNT
    FROM ECOLI_DATA
    GROUP BY PARENT_ID
    HAVING PARENT_ID IS NOT NULL
)
SELECT
    ID,
    IFNULL(CHILD_COUNT, 0) AS CHILD_COUNT
FROM ECOLI_DATA 
    LEFT JOIN CHILD_CNT ON CHILD_CNT.PARENT_ID = ECOLI_DATA.ID
ORDER BY ID ASC