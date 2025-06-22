# Install and load the DBI package if not already installed
if (!require(DBI)) install.packages("DBI", dependencies=TRUE)
library(DBI)

database_path <- "C:/Users/Marku/Documents/database.db3"

town_name_1 <- "Littlemore"
town_name_2 <- "Old Marston"  
district_name <- "Oxford"  

# Create an SQL query to calculate the difference between council tax charges for the same bands in two different towns
sql_query_diff_council_tax <- sprintf("
  SELECT 
    CouncilTax1.\"Area\" AS town_name_1,
    CouncilTax2.\"Area\" AS town_name_2,
    CouncilTax1.\"District\" AS district_name,
    (CouncilTax1.\"Band.A\" - CouncilTax2.\"Band.A\") AS diff_band_A,
    (CouncilTax1.\"Band.B\" - CouncilTax2.\"Band.B\") AS diff_band_B,
    (CouncilTax1.\"Band.C\" - CouncilTax2.\"Band.C\") AS diff_band_C
  FROM CouncilTax CouncilTax1
  INNER JOIN CouncilTax CouncilTax2 ON CouncilTax1.\"District\" = CouncilTax2.\"District\"
  WHERE CouncilTax1.\"Area\" = '%s' AND CouncilTax2.\"Area\" = '%s' AND CouncilTax1.\"District\" = '%s'
", town_name_1, town_name_2, district_name)

# Connect to the SQLite database using DBI
con <- dbConnect(RSQLite::SQLite(), dbname = database_path)

# Execute the query and fetch the result
result_diff_council_tax <- dbGetQuery(con, sql_query_diff_council_tax)

# Close the database connection
dbDisconnect(con)

# Print the result
print(result_diff_council_tax)
