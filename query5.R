# Install and load the DBI package if not already installed
if (!require(DBI)) install.packages("DBI", dependencies=TRUE)
library(DBI)

database_path <- "C:/Users/Marku/Documents/database.db3"

area_name <- "Churchill"

# Create an SQL query to join tables and retrieve Area.name, area.code, and average download speed for a given Area.name
sql_query_join_speed <- sprintf("
  SELECT 
    AreaTable.\"Area.name\" AS area_name,
    AvailabilityTable.\"Area.code\" AS area_code,
    SpeedTable.\"Average.download.speed\" AS avg_download_speed_in_mbs
  FROM AvailabilityTable
  INNER JOIN AreaTable ON AvailabilityTable.\"Area.code\" = AreaTable.\"area.code\"
  INNER JOIN SpeedTable ON AvailabilityTable.\"Area.code\" = SpeedTable.\"Area.code\"
  WHERE AreaTable.\"Area.name\" = '%s'
", area_name)

# Connect to the SQLite database using DBI
con <- dbConnect(RSQLite::SQLite(), dbname = database_path)

# Execute the query and fetch the result
result_join_speed <- dbGetQuery(con, sql_query_join_speed)

# Close the database connection
dbDisconnect(con)

# Print the result
print(result_join_speed)
