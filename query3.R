# Install and load the DBI package if not already installed
if (!require(DBI)) install.packages("DBI", dependencies=TRUE)
library(DBI)

database_path <- "C:/Users/Marku/Documents/database.db3"

district <- "South Oxfordshire"
year <- "2021"
quarter <- "Mar"

# Create an SQL query to find the ward with the highest house price
sql_query <- sprintf("
  SELECT 
    WardName AS ward_name,
    LocalAuthorityName AS district_name,
    WardCode AS ward_code,
    \"Price.%s.%s.%s\" AS max_house_price
  FROM MedianPricesPaid
  WHERE LocalAuthorityName = '%s'
  ORDER BY \"Price.%s.%s.%s\" DESC
  LIMIT 1
", year, quarter, year, district, year, quarter, year)

# Connect to the SQLite database using DBI
con <- dbConnect(RSQLite::SQLite(), dbname = database_path)

# Execute the query and fetch the result
result <- dbGetQuery(con, sql_query)

# Close the database connection
dbDisconnect(con)

# Print the result
print(result)