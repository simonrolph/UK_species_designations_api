

#read in the file
library(readxl)
taxon_designations <- read_excel("data/raw/Taxon_designations_20220202.xlsx", 
                                          sheet = "Master List", skip = 1)


#produce some data objects

taxons <- 