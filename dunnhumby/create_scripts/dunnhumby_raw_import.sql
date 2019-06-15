/* Use dunnhumby schema */
SET search_path TO dunnhumby;


/* DROP raw import table */
DROP TABLE IF EXISTS dunnhumby_raw_import;

/* Drop and create enumeration types */
DROP TYPE IF EXISTS price_sensitivity CASCADE;
DROP TYPE IF EXISTS cust_lifestage CASCADE;
DROP TYPE IF EXISTS basket_size CASCADE;
DROP TYPE IF EXISTS basket_type CASCADE;
DROP TYPE IF EXISTS basket_dominant_mission CASCADE;
DROP TYPE IF EXISTS store_format CASCADE;
DROP TYPE IF EXISTS store_region CASCADE;

CREATE TYPE price_sensitivity AS ENUM('LA','MM','UM','XX');
CREATE TYPE cust_lifestage AS ENUM('YA','OA','YF','OF','PE','OT','XX');
CREATE TYPE basket_size AS ENUM('L','M','S');
CREATE TYPE basket_type AS ENUM('Small Shop', 'Top Up', 'Full Shop', 'XX');
CREATE TYPE basket_dominant_mission AS ENUM('Fresh', 'Grocery', 'Mixed', 'Non Food', 'Nonfood', 'XX');
CREATE TYPE store_format AS ENUM('LS', 'MS', 'SS', 'XLS');
CREATE TYPE store_region AS ENUM('E01','E02','E03','N01','N02','N03','S01','S02','S03','W01','W02','W03');


/* Drop and create raw import table */
CREATE TABLE dunnhumby_raw_import (
	shop_week VARCHAR(6),
	shop_date VARCHAR(8),
	shop_weekday smallint,
	shop_hour smallint,
	Quantity int,
	spend float(2),
	prod_code varchar(25),
	prod_code_10 varchar(25),
	prod_code_20 varchar(25),
	prod_code_30 varchar(25),
	prod_code_40 varchar(25),
	cust_code varchar(25),
	cust_price_sensitivity dunnhumby.price_sensitivity,
	cust_lifestage dunnhumby.cust_lifestage,
	basket_id bigint,
	basket_size dunnhumby.basket_size,
	basket_price_sensitivity dunnhumby.price_sensitivity,
	basket_type dunnhumby.basket_type,
	basket_dominant_mission dunnhumby.basket_dominant_mission,
	store_code varchar(25),
	store_format dunnhumby.store_format,
	store_region dunnhumby.store_region,
	imported_at timestamp DEFAULT NOW()
);

CREATE INDEX idx_dunnhumby_raw_import_prod_code
    ON dunnhumby_raw_import USING btree
    (prod_code);

CREATE INDEX idx_dunnhumby_raw_import_shop_date
    ON dunnhumby_raw_import USING btree
    (shop_date);

CREATE INDEX idx_dunnhumby_raw_import_store_code
    ON dunnhumby_raw_import USING btree
    (store_code);

CREATE INDEX idx_dunnhumby_raw_import_cust_code
    ON dunnhumby_raw_import USING btree
    (cust_code);