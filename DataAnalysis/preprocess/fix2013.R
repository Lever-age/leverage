# 2013 was downloaded as a text file. Convert to CSV

library(readr)
data2013 <- read.table("../data/Explorer.Transactions.2013.YTD.txt", 
                       header = TRUE, stringsAsFactors = FALSE)

# Compare to a "sensible" table
data2014 <- read.csv("../data/2014ytd.csv",
                     stringsAsFactors = FALSE)

if (!all.equal(colnames(data2014), colnames(data2013))) {
  stop("The colnames don't match: life got harder.")
} else {
  cat("Hooray! Something is reasonably easy.\n")
}

write.csv(data2013, "../data/2013ytd.csv", row.names = FALSE)
