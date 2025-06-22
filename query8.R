# Install and load the DBI package if not already installed
if (!require(DBI)) install.packages("DBI", dependencies=TRUE)
library(DBI)

database_path <- "C:/Users/Marku/Documents/database.db3"

district_name <- "Cherwell"

# Create an SQL query to find the town with the lowest council tax charges for Band B properties in a specific district
sql_query_lowest_band_b <- sprintf("
  SELECT 
    CouncilTax.\"Area\" AS town_name,
    CouncilTax.\"District\" AS district_name,
    COALESCE(CouncilTax.\"Band.B\", 0) AS band_b_charge
  FROM CouncilTax
  WHERE CouncilTax.\"District\" = '%s'
  ORDER BY band_b_charge ASC
  LIMIT 1
", district_name)

# Connect to the SQLite database using DBI
con <- dbConnect(RSQLite::SQLite(), dbname = database_path)

# Execute the query and fetch the result
result_lowest_band_b <- dbGetQuery(con, sql_query_lowest_band_b)

# Close the database connection
dbDisconnect(con)

# Print the result
print(result_lowest_band_b)