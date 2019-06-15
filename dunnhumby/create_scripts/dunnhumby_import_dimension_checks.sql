/* Check to see if store_code can have multiple attributes */
SELECT
	store_code
	,COUNT(DISTINCT store_format) str_fmt_cnt
	,COUNT(DISTINCT store_region) str_reg_cnt
FROM
	dunnhumby.dunnhumby_raw_import
GROUP BY
	store_code
HAVING
	COUNT(DISTINCT store_format) > 1
	OR COUNT(DISTINCT store_region) > 1;


/* Check to see if basket_id can have multiple attributes */
SELECT
	basket_id
	,COUNT(DISTINCT basket_size) bskt_size_cnt
	,COUNT(DISTINCT basket_price_sensitivity) bskt_price_sens_cnt
	,COUNT(DISTINCT basket_type) bskt_type_cnt
	,COUNT(DISTINCT basket_dominant_mission) bskt_dom_mission_cnt
FROM
	dunnhumby.dunnhumby_raw_import
GROUP BY
	basket_id
HAVING
	COUNT(DISTINCT basket_size) > 1
	OR COUNT(DISTINCT basket_price_sensitivity) > 1
	OR COUNT(DISTINCT basket_type) > 1
	OR COUNT(DISTINCT basket_dominant_mission) > 1;

/* Check to see if cust_code can have multiple attributes */
SELECT
	cust_code,
	COUNT(DISTINCT cust_price_sensitivity) cust_price_sensitivity_count,
	COUNT(DISTINCT cust_lifestage) cust_lifestage_count
FROM
	dunnhumby.dunnhumby_raw_import
GROUP BY
	cust_code
HAVING
	count(distinct cust_price_sensitivity) > 1
	or count(distinct cust_lifestage) > 1;

/* Check to see if prod_code can have multiple attributes */
SELECT 
	prod_code
	,count(distinct prod_code_10) code10cnt
	,count(distinct prod_code_20) code20cnt
	,count(distinct prod_code_30) code30cnt
	,count(distinct prod_code_40) code40cnt
FROM
	dunnhumby.dunnhumby_raw_import
GROUP BY
	prod_code
HAVING
	count(distinct prod_code_10) > 1
	or count(distinct prod_code_20) > 1
	or count(distinct prod_code_30) > 1
	or count(distinct prod_code_40) > 1;