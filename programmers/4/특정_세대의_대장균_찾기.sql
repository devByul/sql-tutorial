-- https://im-codding.tistory.com/82#google_vignette
WITH RECURSIVE GEN_DATA AS (
    SELECT
        ID,
        PARENT_ID,
        1 AS GEN
    FROM ECOLI_DATA 
    WHERE PARENT_ID IS NULL
    UNION ALL
    SELECT
        ECOLI_DATA.ID,
        ECOLI_DATA.PARENT_ID,
        (GEN + 1) AS GEN
    FROM ECOLI_DATA
        JOIN GEN_DATA ON ECOLI_DATA.PARENT_ID = GEN_DATA.ID
)
SELECT 
    ID
FROM GEN_DATA 
WHERE GEN = 3 