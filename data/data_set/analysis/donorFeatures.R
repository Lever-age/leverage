# Read the DB of transactions and create a feature vector for each donor (based
# on EntityName).

# TODO list:
# Better clean-up EntityName
# Continue exploring features

library(dplyr)
library(tidyr)

# Get campaign donations from the DB --------------------------------------

# Create a connection to the DB
load("dblogin.RData")     # Brings in dbuser/dbpassword
db <- src_postgres(dbname = "demhack2016", 
                   host = "campaign-finance.phl.io",
                   port = 5432,
                   user = dbuser,
                   password = dbpassword)

# Fetch all transactions
allTransactions <- tbl(db, "all_transactions")

# For now, we only care about 2015 data, and we select donations ONLY.
allTransactions <- filter(allTransactions,
                          SourceFile == "../data/2015ytd.csv",
                          (DocType %LIKE% "CFR - Schedule I %" ||
                            DocType %LIKE% "CFR - Schedule II %"))

# Meghan/Josh winnowed down to council-members and the mayoral race.
# This brings in the Candidate field
allTransactions <- allTransactions %>%
  inner_join(tbl(db, "filer_candidate"), by = "FilerName")

# Pull this data into RAM
allTransactionsLocal <- collect(allTransactions)


# Narrow things down to a feature space for donors ------------------------

cleanupNames <- function(messyNames) {
  # Lower case
  cleanerNames <- tolower(messyNames)
  # Get rid of multiple spaces
  cleanerNames <- gsub("[[:space:]]{2,}", " ", cleanerNames)
  # Get rid of everything that's not a letter, number, or space
  cleanerNames <- gsub("[^[:alnum:] ]", "", cleanerNames)
  return(cleanerNames)
}

# VERY rough cleaning of donors
allTransactionsLocal <- allTransactionsLocal %>% 
  mutate(Donor = cleanupNames(EntityName))

# First pass: amount per candidate
donorData <- allTransactionsLocal %>%
  select_("Donor", "Candidate", "Amount") %>%
  group_by_("Donor", "Candidate") %>%
  summarize(Amount = sum(Amount))

donorFeatures <- donorData %>%
  spread(key = Candidate, value = Amount)
