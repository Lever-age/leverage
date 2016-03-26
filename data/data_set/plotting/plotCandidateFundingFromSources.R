# Create a demo plot

library(dplyr)
library(grid)
library(ggplot2)
library(gridExtra)

# Plots will either be displayed or saved
saveCandidatePlots <- FALSE

# Grab the data from the DB -----------------------------------------------

# Create a connection to the DB
load("dblogin.RData")     # Brings in dbuser/dbpassword
db <- src_postgres(dbname = "demhack2016", 
                   host = "campaign-finance.phl.io",
                   port = 5432,
                   user = dbuser,
                   password = dbpassword)

# Join up the data and pull it into RAM
#SELECT * FROM candidate_sources LEFT JOIN candidate_position USING ( "Candidate" );
financeData <- tbl(db, "candidate_sources") %>%
  left_join(tbl(db, "candidate_position"), by = "Candidate") %>%
  arrange(Position, Candidate) %>%
  collect() %>%
  mutate_each(funs(factor), Candidate, DonorType, Position)


# Plot function -----------------------------------------------------------

ggCandidatePlot <- function(candidateData, ylim) {
  # Figure out if this will be in thousands or millions
  if (log10(ylim) >= 6) {
    # Millions
    barYlab <- "Amount (millions)"
    barYlim <- ylim/1e6
    candidateData <- mutate(candidateData, Amount = Amount/1e6)
  } else {
    # Thousands
    barYlab <- "Amount (thousands)"
    barYlim <- ylim/1e3
    candidateData <- mutate(candidateData, Amount = Amount/1e3)
  }
  
  # Donut chart
  candidateData <- mutate(candidateData, 
                          Fraction = Amount / sum(Amount),
                          ymax = cumsum(Fraction),
                          ymin = lag(ymax, default = 0))
  ggDonut <- ggplot(candidateData, 
                    aes(fill=DonorType, ymax=ymax, ymin=ymin, xmax=4, xmin=2)) +
    geom_rect(colour="white") +
    coord_polar(theta="y") +
    xlim(c(0, 4)) +
    theme_bw() +
    theme(panel.grid=element_blank()) +
    theme(panel.border=element_blank()) +
    theme(axis.text=element_blank()) +
    theme(axis.ticks=element_blank()) +
    theme(legend.position="none")
  
  ggBar <- ggplot(candidateData, aes(x = DonorType, y = Amount, fill = DonorType)) +
    geom_bar(stat = "identity") +
    ylim(0, barYlim) + 
    ylab(barYlab) +
    xlab("") + 
    theme(axis.title.y=element_text(size=25)) +
    theme(axis.text=element_text(size=20)) +
    #coord_fixed(ratio = 0.4) +
    theme(legend.position="none") +
    theme(panel.grid=element_blank()) +
    theme(panel.background=element_rect(fill = "white"))
  
  return(arrangeGrob(ggDonut, ggBar, ncol = 1,
                     top = textGrob(paste0(candidateData$Candidate[1], 
                                           "\n(", candidateData$Position[1], ")"),
                                    gp=gpar(fontsize=25))))
}


# Plots for every candidate -----------------------------------------------

for (positionIdx in seq_len(nlevels(financeData$Position))) {
  positionData <- filter(financeData, 
                         Position == levels(financeData$Position)[positionIdx])
  
  # Pretty y axis limits are ugly code
  maxAmount <- max(positionData$Amount)
  maxAmountDigits <- floor(log10(maxAmount))
  positionYlim <- ceiling(maxAmount/10^maxAmountDigits)*10^maxAmountDigits
  
  positionCandidates <- unique(positionData$Candidate)
  for (candidateIdx in seq_along(positionCandidates)) {
    candidateData <- filter(positionData, 
                            Candidate == positionCandidates[candidateIdx])
    gg <- ggCandidatePlot(candidateData, ylim = positionYlim)
    if (saveCandidatePlots) {
      ggsave(paste0("position", positionIdx, "candidate", candidateIdx, ".png"),
             gg,
             width = 5,
             height = 10)
    } else{
      plot(gg)
    }
  }
}


