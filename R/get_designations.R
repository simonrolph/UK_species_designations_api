# get designations from static API
library(httr)
library(jsonlite)

get_taxa_summary <- function(){
  taxa_url <- "https://simonrolph.github.io/UK_species_designations_api/api_v1/taxa.json"
  taxa_data <- httr::GET(taxa_url)
  taxa_data <- jsonlite::fromJSON(rawToChar(taxa_data$content))
  taxa_data <- as.data.frame(taxa_data)
  taxa_data
}

#returns a dataframe with the taxa summaries
get_taxa_summary() |> head()

get_taxon_designations <- function(taxon_names){
  taxon_names <- tolower(taxon_names)
  taxon_names <- gsub(" ", "_", taxon_names)
  urls <- paste0("https://simonrolph.github.io/UK_species_designations_api/api_v1/taxon/",taxon_names,".json")
  
  #get the data
  res <- lapply( urls ,FUN = GET)
  content <- lapply(res,FUN = function(x){jsonlite::fromJSON(rawToChar(x$content))})
  
  
  ret <- lapply(content,FUN = as.data.frame)
  
  names(ret) = taxon_names #rename the list items
  ret
}

#get designations for species returned as a list of dataframes for each species
c("Bufo bufo") |> get_taxon_designations()
c("Bufo bufo","Vulpes vulpes") |> get_taxon_designations()
