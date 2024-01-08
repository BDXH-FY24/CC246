
#!/bin/bash 






tar -Oxzvf data/ghcnd_all.tar.gz |grep "PRCP" | gzip > data/ghcnd.cat.gz 


# Jan 5th, 2024
tar -Oxzvf data/ghcnd_all.tar.gz |grep "PRCP" |gsplit -l 1000000 --filter 'gzip > data/temp/$FILE.gz' 

# Jan 6th, 2024
# Executte R script: CC251.R
code/CC251.R 

rm -rf data/temp



