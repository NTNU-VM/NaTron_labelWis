library(qrencoder)
library(uuid)
library(jsonlite)

# generate test data for input
N <- 100 # for testing
recordNumber <- as.numeric()
occurrenceID <- as.character()
for (i in 1:N){
  occurrenceID[i] <- as.character(UUIDgenerate())
  recordNumber[i] <- as.numeric(seq(1:N)[i])
}

inndata <- data.frame(occurrenceID=occurrenceID,
                      recordNumber=recordNumber)
                      