#!/bin/bash 

# extract file names from archive 
# any more changes
echo "file name" > data/ghcnd_all_files.txt 

tar -tf data/ghcnd_all.tar.gz | grep ".dly" >> data/ghcnd_all_files.txt 
