/* Set schema to dunnhumby so we don't have to type schema every time*/
SET search_path TO dunnhumby;

/* Drop dim_product and repopulate */
DROP TABLE IF EXISTS dim_product CASCADE;
SELECT DISTINCT
	prod_code
	,prod_code_10
	,prod_code_20
	,prod_code_30
	,prod_code_40
INTO
	dim_product
FROM
	dunnhumby_raw_import;
	
ALTER TABLE dim_product
    ADD CONSTRAINT constraint_dim_product_prod_code UNIQUE (prod_code);
	
/* Drop dim_customer and repopulate */
DROP TABLE IF EXISTS dim_customer CASCADE;
SELECT DISTINCT
	cust_code,
	cust_price_sensitivity,
	cust_lifestage
INTO
	dim_customer
FROM
	dunnhumby_raw_import;
	
ALTER TABLE dim_customer
    ADD CONSTRAINT constraint_dim_customer_cust_code UNIQUE (cust_code);
	
/* Drop dim_basket and repopulate */
DROP TABLE IF EXISTS dim_basket CASCADE;
SELECT DISTINCT
	basket_id,
	basket_size,
	basket_price_sensitivity,
	basket_type,
	basket_dominant_mission
INTO
	dim_basket
FROM
	dunnhumby_raw_import;

ALTER TABLE dim_basket
    ADD CONSTRAINT constraint_dim_basket_basket_id UNIQUE (basket_id);
	
/* Drop dim_store and repopulate */
DROP TABLE IF EXISTS dim_store CASCADE;
SELECT DISTINCT
	store_code,
	store_format,
	store_region
INTO
	dim_store
FROM
	dunnhumby_raw_import;	
	
ALTER TABLE dim_store
    ADD CONSTRAINT constraint_dim_store UNIQUE (store_code);	

/* Drop dim_calendar and repopulate */
DROP TABLE IF EXISTS dim_calendar CASCADE;
SELECT DISTINCT
	shop_date,
	shop_week,
	shop_weekday
INTO
	dim_calendar
FROM
	dunnhumby_raw_import;	

ALTER TABLE dim_calendar
    ADD CONSTRAINT constraint_dim_calendar_shop_date UNIQUE (shop_date);

/* Drop fact_sales and repopulate */
DROP TABLE IF EXISTS fact_sales CASCADE;
SELECT
	shop_date,
	shop_hour,
	prod_code,
	cust_code,
	basket_id,
	store_code,
	quantity,
	spend
INTO
	fact_sales
FROM
	dunnhumby_raw_import;
	
ALTER TABLE fact_sales
    ADD CONSTRAINT fk_fact_sales_shop_date FOREIGN KEY (shop_date)
    	REFERENCES dim_calendar (shop_date) MATCH SIMPLE
    	ON UPDATE NO ACTION
    	ON DELETE NO ACTION,
	ADD CONSTRAINT fk_fact_sales_prod_code FOREIGN KEY (prod_code)
    	REFERENCES dim_product (prod_code) MATCH SIMPLE
    	ON UPDATE NO ACTION
    	ON DELETE NO ACTION,
	ADD CONSTRAINT fk_fact_sales_cust_code FOREIGN KEY (cust_code)
    	REFERENCES dim_customer (cust_code) MATCH SIMPLE
    	ON UPDATE NO ACTION
    	ON DELETE NO ACTION,
	ADD CONSTRAINT fk_fact_sales_basket_id FOREIGN KEY (basket_id)
    	REFERENCES dim_basket (basket_id) MATCH SIMPLE
    	ON UPDATE NO ACTION
    	ON DELETE NO ACTION,
	ADD CONSTRAINT fk_fact_sales_store_code FOREIGN KEY (store_code)
    	REFERENCES dim_store (store_code) MATCH SIMPLE
    	ON UPDATE NO ACTION
    	ON DELETE NO ACTION;

CREATE INDEX idx_fact_sales_prod_code
    ON fact_sales USING btree
    (prod_code);

CREATE INDEX idx_fact_sales_shop_date
    ON fact_sales USING btree
    (shop_date);

CREATE INDEX idx_fact_sales_store_code
    ON fact_sales USING btree
    (store_code);

CREATE INDEX idx_fact_sales_cust_code
    ON fact_sales USING btree
    (cust_code);

DROP TABLE IF EXISTS dunnhumby_raw_import CASCADE;