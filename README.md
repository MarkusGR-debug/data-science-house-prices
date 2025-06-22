# 🏠 House Prices & Broadband Coverage – Data Science Project

Welcome to a real-world data science project where I explored **house prices, council tax, and broadband coverage** across Oxfordshire using R, SQL, and Excel. The project focused on **data cleaning, normalization**, and **insight extraction** using queries and visualizations.

---

## 📌 Overview

- 📊 **Multi-source data collection** (Excel files from gov.uk, Ofcom, ONS)
- 🧼 **Data transformation and cleaning**
- 🗃️ **Normalization to 1NF, 2NF, 3NF**
- 🧠 **Query logic for meaningful insights**
- 💻 Coded in **R** using **SQLite database** with custom schema

---
## 💡 Example Queries (R + SQL)

```r
# 📌 Average price by ward in 2022
query <- "
SELECT Ward, AVG(Price) AS AvgPrice
FROM HousePrices
WHERE Year = 2022
GROUP BY Ward
ORDER BY AvgPrice DESC;
"

# 📌 Superfast broadband postcodes and house prices
query <- "
SELECT h.Postcode, h.Price, b.DownloadSpeed
FROM HousePrices h
JOIN Broadband b ON h.Postcode = b.Postcode
WHERE b.Availability = 'Superfast';
"

🛠️ Tools & Technologies
Language	Libraries	Database	Formats Used
R	dplyr, DBI, readxl	SQLite	.xlsx, .db3
SQL	SQLite dialect		
Excel	Manual filtering, merge		.xlsx
📖 What's Included

    ✅ Relational schema for normalized housing data

    ✅ SQL & R queries answering specific domain questions

    ✅ Documentation: full report on process + findings

    ✅ Recording: showing queries running in RStudio

🧠 Learning Highlights

    Working with real-world, messy government data

    Building efficient, normalized relational datasets

    Writing complex SQL queries for dynamic filtering

    Automating analysis using R scripting
