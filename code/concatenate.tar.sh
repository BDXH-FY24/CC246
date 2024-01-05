
#!/bin/bash 

tar -Oxzvf data/ghcnd_all.tar.gz |grep "PRCP" | gzip > data/ghcnd.cat.gz