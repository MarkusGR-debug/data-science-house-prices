# Install and load the DBI package if not already installed
if (!require(DBI)) install.packages("DBI", dependencies=TRUE)
library(DBI)

database_path <- "C:/Users/Marku/Documents/database.db3"

ward <- "Summertown"
district <- "Oxford"
start_year <- 2018
end_year <- 2021

# Create an SQL query to calculate the average price for the specified conditions
sql_query <- paste0("
  SELECT 
    WardName AS ward_name,
    LocalAuthorityName AS district_name,
    WardCode AS ward_code,
    AVG(", paste0("\"Year.ending.Mar.", start_year, "\" + \"Year.ending.Jun.", start_year, "\" + \"Year.ending.Sep.", start_year, "\" + \"Year.ending.Dec.", start_year, "\"", collapse = " + "), ") / 4 AS avg_price_start_year,
    AVG(", paste0("\"Year.ending.Mar.", end_year, "\" + \"Year.ending.Jun.", end_year, "\" + \"Year.ending.Sep.", end_year, "\" + \"Year.ending.Dec.", end_year, "\"", collapse = " + "), ") / 4 AS avg_price_end_year,
    ((AVG(", paste0("\"Year.ending.Mar.", end_year, "\" + \"Year.ending.Jun.", end_year, "\" + \"Year.ending.Sep.", end_year, "\" + \"Year.ending.Dec.", end_year, "\"", collapse = " + "), ") / 4) - 
      (AVG(", paste0("\"Year.ending.Mar.", start_year, "\" + \"Year.ending.Jun.", start_year, "\" + \"Year.ending.Sep.", start_year, "\" + \"Year.ending.Dec.", start_year, "\"", collapse = " + "), ") / 4)) / 
      (AVG(", paste0("\"Year.ending.Mar.", start_year, "\" + \"Year.ending.Jun.", start_year, "\" + \"Year.ending.Sep.", start_year, "\" + \"Year.ending.Dec.", start_year, "\"", collapse = " + "), ") / 4) * 100 AS avg_price_change_percent
  FROM MedianPricesPaid
  WHERE WardName = '", ward, "' AND LocalAuthorityName = '", district, "'
")

# Connect to the SQLite database using DBI
con <- dbConnect(RSQLite::SQLite(), dbname = database_path)

# Execute the query and fetch the result
result <- dbGetQuery(con, sql_query)

# Close the database connection
dbDisconnect(con)

# Print the result
print(result)


