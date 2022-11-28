

#read in the file
library(readxl)
library(janitor)
taxon_designations <-read_excel("data/raw/Taxon_designations_20220202.xlsx", 
                                sheet = "Master List", col_types = c("text", 
                                                                     "text", "text", "text", "text", "text", 
                                                                     "text", "text", "text", "text", "text", 
                                                                     "date", "text", "text", "text", "text", 
                                                                     "text", "text", "text", "text"), 
                                skip = 1) %>% clean_names()
View(taxon_designations)

#produce some data objects and convert to json
library(dplyr)
library(rjson)

#list of taxon
taxons <- taxon_designations %>% 
  group_by(
    category,
    taxon_group,
    recommended_taxon_name,
    recommended_authority,
    recommended_qualifier,
    recommended_taxon_version) %>% 
  summarise(n_designations=n(),
            most_recent_designation = max(date_designated)) %>%
  as.data.frame()

taxons <- list(taxons)
names(taxons) <- "taxons"

taxons %>% toJSON %>% jsonlite::prettify() %>%
  writeLines("api_v1/taxa.json")
  

#by taxon
n<-nrow(taxons[[1]])
for(i in 1:n){
  taxon <- taxons[[1]]$recommended_taxon_name[i]
  
  #get the common valaues for the taxon
  taxon_as_list <- taxon_designations %>% 
    filter(recommended_taxon_name == taxon) %>%
    select(category,
           taxon_group,
           recommended_taxon_name,
           recommended_authority,
           recommended_qualifier,
           recommended_taxon_version) %>%
    head(1) %>%
    as.data.frame() %>% as.list()
  
  #get all the disctint values for each designation
  designations <- taxon_designations %>% 
    filter(recommended_taxon_name == taxon) %>%
    select(-category,
           -taxon_group,
           -recommended_taxon_name,
           -recommended_authority,
           -recommended_qualifier,
           -recommended_taxon_version) %>% 
    as.data.frame()
  
  #taxon_as_list$designations <- setNames(split(designations, seq(nrow(designations))), rownames(designations))
  taxon_as_list$designations <- designations
    
  taxon_as_list %>% toJSON %>% jsonlite::prettify() %>%
    writeLines(paste0("api_v1/taxon/",make_clean_names(taxon),".json"))
  
  cat("\r",round(i/n*100,2),"%")
  
}

  
  
