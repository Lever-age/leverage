# How to connect to the DB with dplyr -------------------------------------

# You'll need to use dplyr
library(dplyr)

# Create a connection to the DB
db <- src_postgres(dbname = "demhack2016", 
                   host = "campaign-finance.phl.io",
                   port = 5432,
                   user = "demhack2016",
                   password = "sense label hidden truth")

# Now get a table
allTransactionsRemote <- tbl(db, "all_transactions")

# Look, we have stuff!
head(allTransactionsRemote)

# From here, you can just use dply verbs (mutate/filter/select) to deal with the
# data, and it remains in the DB.

# How to connect to the DB withOUT dplyr ----------------------------------

# If you don't want to use dplyr at all, you can just use SQL to get what you
# need with a call to the DB and pull the data into RAM.
library(RPostgreSQL)

# We need to create a DB connection object
con <- dbConnect(dbDriver("PostgreSQL"), dbname = "demhack2016",
                 host = "campaign-finance.phl.io", port = 5432,
                 user = "demhack2016", password = "sense label hidden truth")

# Execute a SQL query to get the data. You can select specific columns and rows 
# (using WHERE) and the results are put into a local data.frame.
# 
# Note: this is VERY slow if you're pulling in a lot of data; e.g., THIS command
# takes forever.
allTransactionsLocal <- dbGetQuery(con, "SELECT * from all_transactions")

# Look at the local data!
head(allTransactionsLocal)
