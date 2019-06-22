## Create Scripts

### insert_all_files_psql.sh
Shell script to import the Dunnhumby data. Perfroms 3 steps:
<ol>
<li>Creates the import tables</li>
<li>Loops through all the files in ../data/raw and imports into the raw import table</li>
<li>Transforms the imported data into the Dim/Fact model.</li>
</ol>

### dunnhumpy_raw_import.sql
Creates the raw table and data types for the import of the raw csv data.

### dunnhumby_import_dimension_checks.sql
SQL queries to check the dimensional data for unique primary keys.

### dunnhumby_transform.sql
SQL that transform the raw, single table import to the Dim/Fact star schema.

