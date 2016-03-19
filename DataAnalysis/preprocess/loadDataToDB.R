# Read all the CSVs and load them into the brand new DB.

library(RPostgreSQL)

# Get all the data files
dataDir <- "../data"
csvFiles <- list.files(dataDir, pattern = "[0-9]{4}ytd\\.csv$")
csvFiles <- file.path(dataDir, csvFiles)

# Read all the data files
csvDataList <- list()
for (i in seq_along(csvFiles)) {
  csvDataList[[i]] <- cbind(SourceFile = csvFiles[i],
                            read.csv(csvFiles[i], stringsAsFactors = FALSE))
}

# Can I fit all this into RAM at once?
csvData <- do.call(rbind, csvDataList)

# Connect to the DB and put data there.
# Note: This is the wrong DB.
con <- dbConnect(dbDriver("PostgreSQL"), dbname = "demhack2016",
                 host = "127.0.0.1", port = 5432,
                 user = "demhack2016", password = "sense label hidden truth")
dbWriteTable(con, name = "all_transactions", csvData, row.names = FALSE)
