# Reads in the 2015 campaign finance data and unifies the filer names so 
#  variations in punctuation, capitalization, and whitespace are ignored

library(stringr)

datapath <- "../data/"

# read in the data
data2015 <- read.csv(paste(datapath, "2015ytd.csv", sep=""), header=TRUE, stringsAsFactors=FALSE, sep=",")
# create a new column that is upper case FilerName without punctuation or spaces
data2015$FilerNameNoPunctSpaces <- str_replace_all(toupper(data2015$FilerName), "[^[:alnum:]]", "")
# build a lookup to map a human readable name to the stripped down name
lookup <- data2015[, which(names(data2015) %in% c("FilerName","FilerNameNoPunctSpaces"))]
lookup <- lookup[!duplicated(lookup[,c('FilerNameNoPunctSpaces')]),]
# rename the human readable name column in the lookup
colnames(lookup)[colnames(lookup)=="FilerName"] <- "FilerNameUnified"
# merge the data and the lookup table
newdata2015 <- inner_join(data2015, lookup, by = "FilerNameNoPunctSpaces")
# clean up the helper column
newdata2015$FilerNameNoPunctSpaces <- NULL
# replace the FilerName column
newdata2015$FilerName <- NULL
colnames(newdata2015)[colnames(newdata2015)=="FilerNameUnified"] <- "FilerName"