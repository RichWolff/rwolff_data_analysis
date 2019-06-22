#!/bin/bash
start=`date +%s`


# Get list of all files in data/raw
FILES=../data/raw/transactions_*.csv

#C reate import table and enumerations
psql -U postgres -d postgres -a -p 5433 -f create_scripts/dunnhumby_raw_import.sql

# For each file, copy into import table
for f in $FILES
do
  echo "Processing $f file..."

  # Import each file into psql db
  psql -U postgres -d postgres -w -p 5433 -c \
  "\COPY dunnhumby.dunnhumby_raw_import (
  		shop_week,shop_date,shop_weekday,shop_hour,Quantity,spend,
  		prod_code,prod_code_10,prod_code_20,prod_code_30,prod_code_40,
  		cust_code,cust_price_sensitivity,cust_lifestage,
  		basket_id,basket_size,basket_price_sensitivity,basket_type,
  		basket_dominant_mission,store_code,store_format,store_region) 
  	FROM 
  		'$f' delimiter ',' HEADER csv;"
done

# Move data from import table to dim / fact tables
psql -U postgres -d postgres -a -p 5433 -f create_scripts/dunnhumby_transform.sql

end=`date +%s`
echo $((end-start))