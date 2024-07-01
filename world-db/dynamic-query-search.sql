CREATE PROCEDURE world.spSearch(
    IN in_s_type_enum ENUM('CountryCode', 'Continent', 'Region'),
    IN in_s_keyword_var VARCHAR(128),
    IN in_order_enum ENUM('ASC','DESC'),
    IN in_limit_int INT,
    IN in_offset_int INT
)
BEGIN
	SET @search_type = in_s_type_enum;
	SET @search_keyword = in_s_keyword_var;
	SET @order_direction = in_order_enum;
	SET @limit = IFNULL(in_limit_int, 10);
	SET @offset = IFNULL(in_offset_int, 0);

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

    # WHERE - Search Tabel  `country` 
    #         Search Column `CountryCode`, `Continent`, `Region`
    IF @search_type = 'CountryCode' THEN
        SET @sql_query = CONCAT(@sql_query, " WHERE country.Code='", @search_keyword, "'");
	ELSEIF @search_type = 'Continent' THEN
        SET @sql_query = CONCAT(@sql_query, " WHERE country.Continent='", @search_keyword, "'");
	ELSEIF @search_type = 'Region' THEN
        SET @sql_query = CONCAT(@sql_query, " WHERE country.Region='", @search_keyword, "'");
    END IF;

    # ORDER BY - Order Column city.`ID`
    IF @order_direction IS NULL THEN
        SET @sql_query = CONCAT(@sql_query, " ORDER BY city.ID ASC");
    ELSE 
        SET @sql_query = CONCAT(@sql_query, " ORDER BY city.ID ", @order_direction);
    END IF;

    # LIMIT/OFFSET
    SET @sql_query = CONCAT(@sql_query, " LIMIT ", @limit ," OFFSET ", @offset);

	PREPARE stmt FROM @sql_query;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
END