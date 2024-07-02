CREATE PROCEDURE world.spSearch(
    IN in_search_type_enum ENUM('CountryCode', 'Continent', 'Region'),
    IN in_search_keyword_var VARCHAR(128),
    IN in_order_enum ENUM('ASC','DESC'),
    IN in_limit_int INT,
    IN in_offset_int INT
)
BEGIN
	SET @sql_query = CONCAT("
		SELECT 
			city.ID,
			city.Name,
			city.CountryCode,
			city.District,
			city.Population,
			country.Name,
			country.Continent,
			country.Region,
			country.SurfaceArea,
			country.IndepYear,
			country.Population,
			country.LifeExpectancy,
			country.GNP,
			country.GNPOld,
			country.LocalName,
			country.GovernmentForm,
			country.HeadOfState,
			country.Capital,
			country.Code2,
			countrylanguage.Language,
			countrylanguage.IsOfficial,
			countrylanguage.Percentage
		FROM city
			JOIN country ON country.Code = city.CountryCode
			JOIN (SELECT 
						CountryCode,
		                Language,
		                IsOfficial,
		                MAX(Percentage) AS Percentage
		            FROM countrylanguage
		            GROUP BY CountryCode
		        ) AS countrylanguage ON countrylanguage.CountryCode = city.CountryCode"
	);

    -- WHERE - Search Tabel  `country` 
    --         Search Column `CountryCode`, `Continent`, `Region`
    IF in_search_type_enum = 'CountryCode' THEN
        SET @sql_query = CONCAT(@sql_query, " WHERE country.Code='", in_search_keyword_var, "'");
	ELSEIF in_search_type_enum = 'Continent' THEN
        SET @sql_query = CONCAT(@sql_query, " WHERE country.Continent='", in_search_keyword_var, "'");
	ELSEIF in_search_type_enum = 'Region' THEN
        SET @sql_query = CONCAT(@sql_query, " WHERE country.Region='", in_search_keyword_var, "'");
    END IF;

    -- ORDER BY - Order Column city.`ID`
    IF in_order_enum IS NULL THEN
        SET @sql_query = CONCAT(@sql_query, " ORDER BY city.ID ASC");
    ELSE 
        SET @sql_query = CONCAT(@sql_query, " ORDER BY city.ID ", in_order_enum);
    END IF;

    -- LIMIT/OFFSET - DEFAULT 10 / 0
    SET @sql_query = CONCAT(@sql_query, " LIMIT ", IFNULL(in_limit_int, 10) ," OFFSET ", IFNULL(in_offset_int, 0));

	PREPARE stmt FROM @sql_query;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
END