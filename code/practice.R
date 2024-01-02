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

archive("write_dir.tar.gz")
archive("data/ghcnd_all.tar.gz")



