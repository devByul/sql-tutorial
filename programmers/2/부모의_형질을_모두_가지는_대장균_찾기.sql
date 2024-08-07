SELECT
    CHILD.ID,
    CHILD.GENOTYPE,
    PARENT.GENOTYPE AS PARENT_GENOTYPE
FROM ECOLI_DATA CHILD
    LEFT JOIN ECOLI_DATA PARENT ON PARENT.ID = CHILD.PARENT_ID
WHERE CHILD.GENOTYPE & PARENT.GENOTYPE = PARENT.GENOTYPE
ORDER BY ID ASC