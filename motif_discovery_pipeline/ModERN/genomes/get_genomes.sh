###FLY
http://hgdownload.cse.ucsc.edu/goldenPath/dm6/bigZips/
wget http://hgdownload.cse.ucsc.edu/goldenPath/dm6/bigZips/dm6.chrom.sizes
wget http://hgdownload.cse.ucsc.edu/goldenPath/dm6/bigZips/dm6.2bit
./twoBitToFa dm6.2bit dm6.fa


### WORM
wget ftp://ftp.wormbase.org/pub/wormbase/species/c_elegans/sequence/genomic/c_elegans.PRJNA13758.WS245.genomic.fa.gz
gunzip c_elegans.PRJNA13758.WS245.genomic.fa.gz 

# https://www.biostars.org/p/173963/ =>  pip install pyfaidx
faidx c_elegans.PRJNA13758.WS245.genomic.fa -i chromsizes > c_elegans.PRJNA13758.WS245.genomic.chrom.sizes

bash convert_chrlabels_c_elegans.sh

