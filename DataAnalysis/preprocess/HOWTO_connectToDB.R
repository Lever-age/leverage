# How to connect to the DB with DPLYR

# You'll need to use dplyr
library(dplyr)

# Create a connection to the DB
db <- src_postgres(dbname = "demhack2016", 
                   host = "campaign-finance.phl.io",
                   port = 5432,
                   user = "demhack2016",
                   password = "sense label hidden truth")

# Now get a table
allTransactions <- tbl(db, "all_transactions")

# Look, we have stuff!
head(allTransactions)
