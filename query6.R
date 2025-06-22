# Install and load the DBI package if not already installed
if (!require(DBI)) install.packages("DBI", dependencies=TRUE)
library(DBI)

database_path <- "C:/Users/Marku/Documents/database.db3"

town_name <- "Littlemore" 
district_name <- "Oxford" 

# Create an SQL query to calculate the average council tax charge for Band A, Band B, and Band C for a specific town
sql_query_council_tax <- sprintf("
  SELECT 
    CouncilTax.\"Area\" AS town_name,
    CouncilTax.\"District\" AS district_name,
    (COALESCE(CouncilTax.\"Band.A\", 0) + COALESCE(CouncilTax.\"Band.B\", 0) + COALESCE(CouncilTax.\"Band.C\", 0)) / 3 AS avg_three_bands
  FROM CouncilTax
  WHERE CouncilTax.\"Area\" = '%s' AND CouncilTax.\"District\" = '%s'
", town_name, district_name)

# Connect to the SQLite database using DBI
con <- dbConnect(RSQLite::SQLite(), dbname = database_path)

# Execute the query and fetch the result
result_council_tax <- dbGetQuery(con, sql_query_council_tax)

# Close the database connection
dbDisconnect(con)

# Print the result
print(result_council_tax)







