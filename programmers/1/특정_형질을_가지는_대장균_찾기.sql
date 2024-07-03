 SELECT
    COUNT(*) AS COUNT
FROM ECOLI_DATA
WHERE 
    NOT GENOTYPE & 2
    -- 1,4를 비교하거나 혹은 5를 비교하더라도 동일한 bit로 비교가 가능하다.
    AND (GENOTYPE & 1 OR GENOTYPE & 4) -- 0001, 0100 
    # AND GENOTYPE & 5 -- 0101