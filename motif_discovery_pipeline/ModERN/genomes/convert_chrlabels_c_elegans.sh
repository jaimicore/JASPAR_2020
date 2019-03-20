cp c_elegans.PRJNA13758.WS245.genomic.fa c_elegans.PRJNA13758.WS245.genomic.chrlabels.fa
# perl -i -pe 's/\>MtDNA/>M/' c_elegans.PRJNA13758.WS245.genomic.chrlabels.fa 
perl -i -pe 's/\>/>chr/' c_elegans.PRJNA13758.WS245.genomic.chrlabels.fa 
grep \> c_elegans.PRJNA13758.WS245.genomic*fa

cp c_elegans.PRJNA13758.WS245.genomic.chrom.sizes c_elegans.PRJNA13758.WS245.genomic.chrlabels.chrom.sizes
# perl -i -pe 's/^MtDNA/M/' c_elegans.PRJNA13758.WS245.genomic.chrlabels.chrom.sizes
perl -i -pe 's/^/chr/' c_elegans.PRJNA13758.WS245.genomic.chrlabels.chrom.sizes
head -30 c_elegans.PRJNA13758.WS245.genomic*chrom.sizes
