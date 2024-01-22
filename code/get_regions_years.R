#!/usr/bin/env Rscript

## URL: CC249 https://www.youtube.com/watch?v=nNKwcIfcwgo
## URL: CC250 https://www.youtube.com/watch?v=LKprlFCLnSA
## URL: CC252 https://www.youtube.com/watch?v=NSy-WByR8Qo
## URL: CC253 https://www.youtube.com/watch?v=gy2jaP_OK_c
library(glue)
library(tidyverse)
library(lubridate)
rm(list=ls())
# tibble(x=seq(-2,2, 0.1),
#        round=round(x),
#        trunc=trunc(x),
#        ceiling=ceiling(x),
#        floor=floor(x),
#        integer=as.integer(x),
#        signif(x,digits =  1)
#       )  
#   
# 
# x <- 100*pi  
#  round(x) 
#  trunc(x) 
#  ceiling(x) 
#  floor(x) 
#  as.integer(x) 
# signif(x,digits = 4)
#  

# URL: <https://www.ncei.noaa.gov/pub/data/ghcn/daily/readme.txt>
# IV. FORMAT OF "ghcnd-stations.txt"

# ------------------------------
#   Variable   Columns   Type
# ------------------------------
#   ID            1-11   Character
# LATITUDE     13-20   Real
# LONGITUDE    22-30   Real
# ELEVATION    32-37   Real
# STATE        39-40   Character
# NAME         42-71   Character
# GSN FLAG     73-75   Character
# HCN/CRN FLAG 77-79   Character
# WMO ID       81-85   Character
# ------------------------------

read_fwf("data/ghcnd-stations.txt",
         col_positions = fwf_cols
         (id = c(1,11),
           latitude = c(13,20),
           longitude = c(22,30),
           elevation = c(32,37),
           state = c(39, 40),
           name =c (42, 71),
           gsn_flag=c(73, 75),
           hcn_flag=c(81,85),
           wmo_id = c(81,85)
         ) ,
         col_select =c(id, latitude, longitude)) %>% 
  mutate(latitude = round(latitude,1 ),
         longitude = round(longitude,1)) %>% 
  group_by(longitude, latitude) %>% 
  mutate(region = cur_group_id()) %>% 
  write_tsv("data/ghcnd_regions.tsv")