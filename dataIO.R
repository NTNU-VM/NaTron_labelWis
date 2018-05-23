library(qrencoder)
library(uuid)
library(jsonlite)

# generate test data for input
N <- 2500 # for testing
recordNumber <- as.numeric()
materialSampleID <- as.character()
scientificName <- as.character()
collectionCode <- as.character()
catalogNumber <- as.numeric()
datasetName <- as.character()

for (i in 1:N){
  materialSampleID[i] <- as.character(UUIDgenerate())
  recordNumber[i] <- as.numeric(seq(1:N)[i])
  scientificName[i] <- sample(x=c("Microtus agrestis Linnaeus, 1761",
                                  "Castor fiber Linnaeus, 1758",
                                  "Rattus norvegicus Berkenhout, 1769"),
                              size=1)
  collectionCode[i] <- sample(x=c("MA","XXX"),size=1)
  catalogNumber[i] <- as.numeric(c(1182:(1182+N)))[i]
  datasetName[i] <- sample(x=c("Knarrmyra","dodraugen"),size=1)
}

inndata <- data.frame(materialSampleID=materialSampleID,
                      recordNumber=recordNumber,
                      scientificName=scientificName,
                      collectionCode=collectionCode,
                      catalogNumber=catalogNumber,
                      datasetName=datasetName)
                      