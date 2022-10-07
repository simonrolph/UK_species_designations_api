# Load in the data
library(readxl)
taxon_designations <-read_excel("data/raw/Taxon_designations_20220202.xlsx", 
                                sheet = "Master List", col_types = c("text", 
                                                                     "text", "text", "text", "text", "text", 
                                                                     "text", "text", "text", "text", "text", 
                                                                     "date", "text", "text", "text", "text", 
                                                                     "text", "text", "text", "text"), 
                                skip = 1)

library(dplyr)
library(knitr)
library(janitor)

#taxon pages
taxon_names <- taxon_designations$`Recommended taxon name` %>% unique()
template_new <- readLines("taxon_page_template.html")

#loop through taxons
for(taxon in taxon_names){
  template <- template_new
  taxon_info <- taxon_designations %>% filter(`Recommended taxon name` == taxon)
  
  template[8] <- gsub("TAXON_NAME",taxon,template[8])
  template[11] <- gsub("TAXON_NAME",taxon,template[11])
  
  
  template[13] <- taxon_info[1,1:6] %>%t %>% kable("html")
  
  
  template[14] <- paste0("<p><a href='https://species.nbnatlas.org/species/",taxon_info$`Recommended taxon version`[1],"' target='_blank'> View on NBN Atlas</a></p>")
  #template[15] <- taxon_info[,7:20]%>% kable("html")
  
  designations <- taxon_info[,7:20] %>% arrange(desc(`Date designated`)) %>%unique() 
  
  
  
  #make the mini tables for each designation
  des_html <- c()
  for(i in 1:nrow(designations)){
    des_html <- append(des_html,paste("<h3>",
                                      designations$Designation[i],"-",
                                      designations$Source[i],
                                      "</h3>"))
    des_html <- append(des_html,designations[i,] %>% t() %>% kable("html"))
    
  }
  template <- append(template,des_html,after = 15)
  
  template <- enc2utf8(template)
  
  #write the page
  con <- file(paste0("view/",make_clean_names(taxon),".html"), open = "w+", encoding = "UTF-8")
  writeLines(template,con = con, useBytes = FALSE)
  close(con)
  
  cat("\r",round(match(taxon ,taxon_names)/length(taxon_names)*100,2),"%")
}




