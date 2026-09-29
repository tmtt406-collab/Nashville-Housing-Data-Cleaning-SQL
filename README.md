# Nashville Housing Data Cleaning with SQL

## About the Project

This project focuses on cleaning a Nashville housing dataset using **SQL Server**.

The goal was to take raw housing data and make it more consistent and easier to work with for future analysis. I worked with fields such as property addresses, sale dates, sale prices, ownership information, and property characteristics.

## What I Did

### Standardized Sale Dates
Converted the original sale date into a cleaner `DATE` format and created a new field for the standardized value.

### Filled Missing Property Addresses
Some records were missing a property address. I used `ParcelID` to match properties with other records and populate the missing values.

### Split Address Fields
Separated combined address fields into more useful columns:

- Property Address
- Property City
- Owner Address
- Owner City
- Owner State

This makes the data easier to filter, group, and analyze later.

### Standardized Categorical Data
The `SoldAsVacant` field contained different formats such as `Y`, `N`, `Yes`, and `No`.

I standardized these values into:

- `Yes`
- `No`

### Removed Duplicate Records
Used a **CTE and `ROW_NUMBER()`** to identify duplicate property transactions based on fields such as Parcel ID, property address, sale price, sale date, and legal reference.

### Removed Unnecessary Columns
After creating cleaner versions of several fields, I removed columns that were no longer needed.

## SQL Skills Used

- `SELECT`
- `UPDATE`
- `ALTER TABLE`
- `CASE`
- `ISNULL`
- `SUBSTRING`
- `CHARINDEX`
- `PARSENAME`
- Self Joins
- CTEs
- `ROW_NUMBER()`
- `PARTITION BY`

## Why This Matters

Cleaning data is an important step before analysis or reporting. Small issues such as duplicate records, inconsistent categories, missing addresses, or poorly formatted columns can affect the quality of the final results.

This project helped me practice turning raw data into a cleaner and more structured dataset that could later be used for **reporting, dashboards, or deeper analysis**.

## Project Workflow

**Raw Housing Data → Identify Data Quality Issues → Clean & Standardize → Remove Duplicates → Analysis-Ready Data**

## What I Learned

This project gave me more hands-on experience working with SQL beyond basic queries. I learned how to use SQL to solve common data-quality problems and became more comfortable working with joins, string functions, CTEs, and window functions.
