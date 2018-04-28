library(qrencoder)
library(uuid)
library(jsonlite)

# generate test data for input
N <- 100 # for testing
recordNumber <- as.numeric()
materialSampleID <- as.character()
scientificName <- as.character()
collectionCode <- as.character()
catalogNumber <- as.numeric()

for (i in 1:N){
  materialSampleID[i] <- as.character(UUIDgenerate())
  recordNumber[i] <- as.numeric(seq(1:N)[i])
  scientificName[i] <- sample(x=c("Microtus agrestis Linnaeus, 1761",
                                  "Castor fiber Linnaeus, 1758",
                                  "Rattus norvegicus Berkenhout, 1769"),
                              size=1)
  collectionCode[i] <- "MA"
  catalogNumber[i] <- as.numeric(c(1182:(1182+N)))[i]
  
}

inndata <- data.frame(materialSampleID=materialSampleID,
                      recordNumber=recordNumber,
                      scientificName=scientificName,
                      collectionCode=collectionCode,
                      catalogNumber=catalogNumber)
                      