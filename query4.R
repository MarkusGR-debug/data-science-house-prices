# Install and load the DBI package if not already installed
if (!require(DBI)) install.packages("DBI", dependencies=TRUE)
library(DBI)

database_path <- "C:/Users/Marku/Documents/database.db3"

area_name <- "Holywell"

# Create an SQL query to join tables and retrieve Area.name, area.code, and Superfast.availability for a given Area.name
sql_query_join_name <- sprintf("
  SELECT 
    AreaTable.\"Area.name\" AS area_name,
    AvailabilityTable.\"Area.code\" AS area_code,
    AvailabilityTable.\"Superfast.availability\" AS superfast_availability
  FROM AvailabilityTable
  INNER JOIN AreaTable ON AvailabilityTable.\"Area.code\" = AreaTable.\"area.code\"
  WHERE AreaTable.\"Area.name\" = '%s'
", area_name)

# Connect to the SQLite database using DBI
con <- dbConnect(RSQLite::SQLite(), dbname = database_path)

# Execute the query and fetch the result
result_join_name <- dbGetQuery(con, sql_query_join_name)

# Close the database connection
dbDisconnect(con)

# Print the result
print(result_join_name)



