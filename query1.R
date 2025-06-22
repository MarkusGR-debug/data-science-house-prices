# Install and load the DBI package if not already installed
if (!require(DBI)) install.packages("DBI", dependencies=TRUE)
library(DBI)

database_path <- "C:/Users/Marku/Documents/database.db3"

ward <- "Carfax"
district <- "Oxford"
years <- c(2018, 2019)

# Create a list of conditions for each quarter within the specified years
conditions <- sapply(years, function(year) {
  paste(
    sprintf("\"Year.ending.Mar.%d\"", year),
    sprintf("\"Year.ending.Jun.%d\"", year),
    sprintf("\"Year.ending.Sep.%d\"", year),
    sprintf("\"Year.ending.Dec.%d\"", year),
    sep = " + "
  )
}, simplify = TRUE)

# Combine the conditions into a single string
conditions_string <- paste(conditions, collapse = " + ")

# Create an SQL query to calculate the average price for the specified conditions
sql_query <- sprintf("
  SELECT 
  WardName AS ward_name,
  LocalAuthorityName AS district_name,
  WardCode AS ward_code,
  (%s) / 4 AS avg_price_in_2_years
  FROM MedianPricesPaid
  WHERE WardName = '%s' AND LocalAuthorityName = '%s'
", conditions_string, ward, district)

# Connect to the SQLite database using DBI
con <- dbConnect(RSQLite::SQLite(), dbname = database_path)

# Execute the query and fetch the result
result <- dbGetQuery(con, sql_query)

# Close the database connection
dbDisconnect(con)

# Print the result
print(result$avg_price)
