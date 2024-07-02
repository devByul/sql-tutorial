WITH FIND_PARENT_ITEM AS (
    SELECT
        DISTINCT(PARENT_ITEM_ID)
    FROM ITEM_TREE
    HAVING PARENT_ITEM_ID IS NOT NULL
)
SELECT
    ITEM_ID,
    ITEM_NAME,
    RARITY
FROM ITEM_INFO
WHERE ITEM_ID NOT IN (SELECT PARENT_ITEM_ID FROM FIND_PARENT_ITEM)
ORDER BY ITEM_ID DESC