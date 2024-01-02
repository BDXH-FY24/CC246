
## URL: CC249 https://www.youtube.com/watch?v=nNKwcIfcwgo
## URL: CC250 https://www.youtube.com/watch?v=LKprlFCLnSA

library(glue)
library(tidyverse)
library(lubridate)

quadruple <- function(x){
  
c(glue("VALUE{x}"), glue("MFLAG{x}"), glue("QFLAG{x}"), glue("SFLAG{x}"))
}


widths <- c(11,4,2,4,rep(c(5,1,1,1), 31))
headers <- c("ID","YEAR","MONTH", "ELEMENT", unlist(map(1:31,quadruple)))

read_fwf("data/ghcnd_all/ASN00008255.dly", fwf_widths(widths, headers)) 


read_fwf("data/ghcnd_all/ASN00008255.dly", 
         fwf_widths(widths, headers), 
         na=c("NA", -9999),
         col_types = cols(.default = col_character()),
         col_select = c(ID, YEAR, MONTH, ELEMENT, starts_with("VALUE"))
) 



# NA value is -9999 

# Read multiple files

# dly.files <- list.files("data/ghcnd_all/", full.names = T)
dly.files <- archive("data/ghcnd_all.tar.gz") %>% 
  filter(str_detect(path, "dly")) %>% 
  slice_sample(n=12) %>% # It took some time to run 5
  pull(path)

# archive("write_dir.tar.gz") %>% 
#   pull(path) %>% 
#   map_dfr(., ~read_tsv(archive_read("write_dir.tar.gz",  .x)))

# redo using the map_dfr and archive_read
Sys.time()
dly.files %>% map_dfr(., ~read_fwf(archive_read("data/ghcnd_all.tar.gz", .x),
         fwf_widths(widths, headers), 
         na=c("NA", -9999),
         col_types = cols(.default = col_character()),
         col_select = c(ID, YEAR, MONTH, ELEMENT, starts_with("VALUE")))
# composite <- .Last.value
# count(composite, ID)
# Sys.time()



%>% rename_all(tolower) %>% 
  filter(element=="PRCP") %>% 
  select(-element) %>% 
  pivot_longer(cols = starts_with("VALUE"), 
               names_to = "day", 
               values_to = "prcp") %>% 
  drop_na() %>% 
  mutate(day=str_replace(day, "value", ""), date=ymd(glue("{year}-{month}-{day}")), 
         prcp=as.numeric(prcp)/100) %>% # manipulate pcrp and prcp now in cm   
  select(id,date, prcp) %>% 
  write_tsv("data/composite_dly.tsv"))
     

#### CC250: Using the archive R package to read and write tar.gz and other archive files 

# install.packages("archive")

library(tidyverse)
library(archive)
library(dplyr)

# to create an archive
archive_write_files("write_files.tar.gz",
                    c("data/ghcnd_all/ASN00008255.dly" ,  # nolint
                      "data/ghcnd_all/ASN00017066.dly" ,   # nolint: indentation_linter, commas_linter.
                      "data/ghcnd_all/ASN00040510.dly")
                    # nolint: trailing_whitespace_linter.
)

# CC250: 

library(tidyverse)
library(archive)
library(dplyr)

# to create an archive
archive_write_files("write_files.tar.gz",
                    c("data/ghcnd_all/ASN00008255.dly" ,  # nolint
                      "data/ghcnd_all/ASN00017066.dly" ,   # nolint: indentation_linter, commas_linter.
                      "data/ghcnd_all/ASN00040510.dly")
                    # nolint: trailing_whitespace_linter.
)


archive_write_dir("write_dir.tar.gz",
                  "data/ghcnd_all")

archive("write_dir.tar.gz") %>% select(path)
archive("write_dir.tar.gz") %>% pull(path)


archive("data/ghcnd_all.tar.gz")

read_tsv(archive_read("data/ghcnd_all.tar.gz",  2))
read_tsv(archive_read("data/ghcnd_all.tar.gz",8))

archive("write_dir.tar.gz") %>% 
  pull(path) %>% 
  map_dfr(., ~read_tsv(archive_read("write_dir.tar.gz",  .x)))
  













