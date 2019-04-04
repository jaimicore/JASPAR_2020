## Assuming you launch this script from: /storage/scratch/JASPAR_2020/jaspar_2020/motif_discovery_pipeline/GTRD

################################################################
## Download 2bit to fasta converter
mkdir -p ./data/utils
wget http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/twoBitToFa -O ./data/utils/twoBitToFa
chmod +x ./data/utils/twoBitToFa


################################################################
## Download genome and chromosome sizes for dm3
rm -rf ./data/genomes/dm6 
mkdir -p ./data/genomes/dm6 
wget http://hgdownload.cse.ucsc.edu/goldenPath/dm6/bigZips/dm6.2bit -O ./data/genomes/dm6/dm6.2bit
wget http://hgdownload.cse.ucsc.edu/goldenPath/dm6/bigZips/dm6.chrom.sizes -O ./data/genomes/dm6/dm6.chrom.sizes
./data/utils/twoBitToFa ./data/genomes/dm6/dm6.2bit ./data/genomes/dm6/dm6.fa


################################################################
## Download genome for TAIR10

## Genome folders
rm -rf ./data/genomes/TAIR10
mkdir -p ./data/genomes/TAIR10

## Download each chromosome individually :(
wget ftp://ftp.ensemblgenomes.org/pub/plants/release-42/fasta/arabidopsis_thaliana/dna/Arabidopsis_thaliana.TAIR10.dna.chromosome.1.fa.gz -O ./data/genomes/TAIR10/Arabidopsis_thaliana.TAIR10.dna.chromosome.1.fa.gz

wget ftp://ftp.ensemblgenomes.org/pub/plants/release-42/fasta/arabidopsis_thaliana/dna/Arabidopsis_thaliana.TAIR10.dna.chromosome.2.fa.gz -O ./data/genomes/TAIR10/Arabidopsis_thaliana.TAIR10.dna.chromosome.2.fa.gz

wget ftp://ftp.ensemblgenomes.org/pub/plants/release-42/fasta/arabidopsis_thaliana/dna/Arabidopsis_thaliana.TAIR10.dna.chromosome.3.fa.gz -O ./data/genomes/TAIR10/Arabidopsis_thaliana.TAIR10.dna.chromosome.3.fa.gz

wget ftp://ftp.ensemblgenomes.org/pub/plants/release-42/fasta/arabidopsis_thaliana/dna/Arabidopsis_thaliana.TAIR10.dna.chromosome.4.fa.gz -O ./data/genomes/TAIR10/Arabidopsis_thaliana.TAIR10.dna.chromosome.4.fa.gz

wget ftp://ftp.ensemblgenomes.org/pub/plants/release-42/fasta/arabidopsis_thaliana/dna/Arabidopsis_thaliana.TAIR10.dna.chromosome.5.fa.gz -O ./data/genomes/TAIR10/Arabidopsis_thaliana.TAIR10.dna.chromosome.5.fa.gz

wget ftp://ftp.ensemblgenomes.org/pub/plants/release-42/fasta/arabidopsis_thaliana/dna/Arabidopsis_thaliana.TAIR10.dna.chromosome.Mt.fa.gz -O ./data/genomes/TAIR10/Arabidopsis_thaliana.TAIR10.dna.chromosome.Mt.fa.gz

wget ftp://ftp.ensemblgenomes.org/pub/plants/release-42/fasta/arabidopsis_thaliana/dna/Arabidopsis_thaliana.TAIR10.dna.chromosome.Pt.fa.gz -O ./data/genomes/TAIR10/Arabidopsis_thaliana.TAIR10.dna.chromosome.Pt.fa.gz

## Uncompress all the files
gunzip ./data/genomes/TAIR10/*.fa.gz

## One fasta file
cat ./data/genomes/TAIR10/*.fa > ./data/genomes/TAIR10/TAIR10.fa
rm ./data/genomes/TAIR10/*.*.fa

## Generate the chromosome size file
samtools faidx ./data/genomes/TAIR10/TAIR10.fa
cut -f1,2 ./data/genomes/TAIR10/TAIR10.fa.fai >  ./data/genomes/TAIR10/TAIR10.chrom.sizes


################################################################
## Download genome for WBcel235

## Genome folders
rm -rf ./data/genomes/WBcel235
mkdir -p ./data/genomes/WBcel235

## Download each chromosome individually :(
wget ftp://ftp.ensembl.org/pub/release-95/fasta/caenorhabditis_elegans/dna/Caenorhabditis_elegans.WBcel235.dna.chromosome.I.fa.gz -O ./data/genomes/WBcel235/Caenorhabditis_elegans.WBcel235.dna.chromosome.I.fa.gz

wget ftp://ftp.ensembl.org/pub/release-95/fasta/caenorhabditis_elegans/dna/Caenorhabditis_elegans.WBcel235.dna.chromosome.II.fa.gz -O ./data/genomes/WBcel235/Caenorhabditis_elegans.WBcel235.dna.chromosome.II.fa.gz

wget ftp://ftp.ensembl.org/pub/release-95/fasta/caenorhabditis_elegans/dna/Caenorhabditis_elegans.WBcel235.dna.chromosome.III.fa.gz -O ./data/genomes/WBcel235/Caenorhabditis_elegans.WBcel235.dna.chromosome.III.fa.gz

wget ftp://ftp.ensembl.org/pub/release-95/fasta/caenorhabditis_elegans/dna/Caenorhabditis_elegans.WBcel235.dna.chromosome.IV.fa.gz -O ./data/genomes/WBcel235/Caenorhabditis_elegans.WBcel235.dna.chromosome.IV.fa.gz

wget ftp://ftp.ensembl.org/pub/release-95/fasta/caenorhabditis_elegans/dna/Caenorhabditis_elegans.WBcel235.dna.chromosome.V.fa.gz -O ./data/genomes/WBcel235/Caenorhabditis_elegans.WBcel235.dna.chromosome.V.fa.gz

wget ftp://ftp.ensembl.org/pub/release-95/fasta/caenorhabditis_elegans/dna/Caenorhabditis_elegans.WBcel235.dna.chromosome.X.fa.gz -O ./data/genomes/WBcel235/Caenorhabditis_elegans.WBcel235.dna.chromosome.X.fa.gz

wget ftp://ftp.ensembl.org/pub/release-95/fasta/caenorhabditis_elegans/dna/Caenorhabditis_elegans.WBcel235.dna.chromosome.MtDNA.fa.gz -O ./data/genomes/WBcel235/Caenorhabditis_elegans.WBcel235.dna.chromosome.MtDNA.fa.gz

## Uncompress all the files
gunzip ./data/genomes/WBcel235/*.fa.gz

## One fasta file
cat ./data/genomes/WBcel235/*.fa > ./data/genomes/WBcel235/WBcel235.fa
rm ./data/genomes/WBcel235/*.*.fa

## Generate the chromosome size file
samtools faidx ./data/genomes/WBcel235/WBcel235.fa
cut -f1,2 ./data/genomes/WBcel235/WBcel235.fa.fai >  ./data/genomes/WBcel235/WBcel235.chrom.sizes


################################################################
## Download genome for R64

## Genome folders
rm -rf ./data/genomes/R64
mkdir -p ./data/genomes/R64

## Download each chromosome individually :(
wget ftp://ftp.ensembl.org/pub/release-95/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.I.fa.gz -O ./data/genomes/R64/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.I.fa.gz

wget ftp://ftp.ensembl.org/pub/release-95/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.II.fa.gz -O ./data/genomes/R64/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.II.fa.gz

wget ftp://ftp.ensembl.org/pub/release-95/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.III.fa.gz -O ./data/genomes/R64/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.III.fa.gz

wget ftp://ftp.ensembl.org/pub/release-95/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.IV.fa.gz -O ./data/genomes/R64/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.IV.fa.gz

wget ftp://ftp.ensembl.org/pub/release-95/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.V.fa.gz -O ./data/genomes/R64/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.V.fa.gz

wget ftp://ftp.ensembl.org/pub/release-95/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.VI.fa.gz -O ./data/genomes/R64/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.VI.fa.gz

wget ftp://ftp.ensembl.org/pub/release-95/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.VII.fa.gz -O ./data/genomes/R64/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.VII.fa.gz

wget ftp://ftp.ensembl.org/pub/release-95/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.VIII.fa.gz -O ./data/genomes/R64/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.VIII.fa.gz

wget ftp://ftp.ensembl.org/pub/release-95/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.IX.fa.gz -O ./data/genomes/R64/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.IX.fa.gz

wget ftp://ftp.ensembl.org/pub/release-95/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.X.fa.gz -O ./data/genomes/R64/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.X.fa.gz

wget ftp://ftp.ensembl.org/pub/release-95/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.XI.fa.gz -O ./data/genomes/R64/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.XI.fa.gz

wget ftp://ftp.ensembl.org/pub/release-95/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.XII.fa.gz -O ./data/genomes/R64/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.XII.fa.gz

wget ftp://ftp.ensembl.org/pub/release-95/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.XIII.fa.gz -O ./data/genomes/R64/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.XIII.fa.gz

wget ftp://ftp.ensembl.org/pub/release-95/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.XIV.fa.gz -O ./data/genomes/R64/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.XIV.fa.gz

wget ftp://ftp.ensembl.org/pub/release-95/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.XV.fa.gz -O ./data/genomes/R64/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.XV.fa.gz

wget ftp://ftp.ensembl.org/pub/release-95/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.XVI.fa.gz -O ./data/genomes/R64/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.XVI.fa.gz

wget ftp://ftp.ensembl.org/pub/release-95/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.Mito.fa.gz -O ./data/genomes/R64/Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.Mito.fa.gz


## Uncompress all the files
gunzip ./data/genomes/R64/*.fa.gz

## One fasta file
cat ./data/genomes/R64/*.fa > ./data/genomes/R64/R64.fa.ori
rm ./data/genomes/R64/*.*.fa

## Rename chromosome
## Add the prefix 'chr'.
## Rename the mitochondrial chromosome: Mito -> chrMT
more ./data/genomes/R64/R64.fa.ori | perl -lne ' unless(/^>chr/){ $_ =~ s/^>/>chr/gi}; $_ =~ s/^>chrMito/>chrMT/gi; print $_ ' > ./data/genomes/R64/R64.fa

## Generate the chromosome size file
samtools faidx ./data/genomes/R64/R64.fa
cut -f1,2 ./data/genomes/R64/R64.fa.fai >  ./data/genomes/R64/R64.chrom.sizes


################################################################
## Download genome for ASM294v2

## Genome folders
rm -rf ./data/genomes/ASM294v2
mkdir -p ./data/genomes/ASM294v2

## Download each chromosome individually :(
wget ftp://ftp.ensemblgenomes.org/pub/fungi/release-42/fasta/schizosaccharomyces_pombe/dna/Schizosaccharomyces_pombe.ASM294v2.dna.chromosome.I.fa.gz -O ./data/genomes/ASM294v2/Schizosaccharomyces_pombe.ASM294v2.dna.chromosome.I.fa.gz

wget ftp://ftp.ensemblgenomes.org/pub/fungi/release-42/fasta/schizosaccharomyces_pombe/dna/Schizosaccharomyces_pombe.ASM294v2.dna.chromosome.II.fa.gz -O ./data/genomes/ASM294v2/Schizosaccharomyces_pombe.ASM294v2.dna.chromosome.II.fa.gz

wget ftp://ftp.ensemblgenomes.org/pub/fungi/release-42/fasta/schizosaccharomyces_pombe/dna/Schizosaccharomyces_pombe.ASM294v2.dna.chromosome.III.fa.gz -O ./data/genomes/ASM294v2/Schizosaccharomyces_pombe.ASM294v2.dna.chromosome.III.fa.gz

wget ftp://ftp.ensemblgenomes.org/pub/fungi/release-42/fasta/schizosaccharomyces_pombe/dna/Schizosaccharomyces_pombe.ASM294v2.dna.chromosome.MT.fa.gz -O ./data/genomes/ASM294v2/Schizosaccharomyces_pombe.ASM294v2.dna.chromosome.MT.fa.gz


## Uncompress all the files
gunzip ./data/genomes/ASM294v2/*.fa.gz

## One fasta file
cat ./data/genomes/ASM294v2/*.fa > ./data/genomes/ASM294v2/ASM294v2.fa.ori
rm ./data/genomes/ASM294v2/*.*.fa

## Rename chromosome
more ./data/genomes/ASM294v2/ASM294v2.fa.ori | perl -lne ' unless(/^>chr/){ $_ =~ s/^>/>chr/gi}; print $_ ' > ./data/genomes/ASM294v2/ASM294v2.fa

## Generate the chromosome size file
samtools faidx ./data/genomes/ASM294v2/ASM294v2.fa
cut -f1,2 ./data/genomes/ASM294v2/ASM294v2.fa.fai >  ./data/genomes/ASM294v2/ASM294v2.chrom.sizes


## Max contains 26 peaks
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP041809_NRG1/fasta/EXP041809_NRG1.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP041804_RTG3/fasta/EXP041804_RTG3.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP042000_YRR1/fasta/EXP042000_YRR1.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP042175_SRB7/fasta/EXP042175_SRB7.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP042166_RGR1/fasta/EXP042166_RGR1.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP042180_SSN3/fasta/EXP042180_SSN3.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP042174_SRB7/fasta/EXP042174_SRB7.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP041998_YRR1/fasta/EXP041998_YRR1.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP041601_HST2/fasta/EXP041601_HST2.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP041799_RTG3/fasta/EXP041799_RTG3.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP041585_HOT1/fasta/EXP041585_HOT1.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP042170_SRB2/fasta/EXP042170_SRB2.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP042176_SRB6/fasta/EXP042176_SRB6.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP042171_SRB2/fasta/EXP042171_SRB2.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP042178_MED7/fasta/EXP042178_MED7.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP041881_SPT16/fasta/EXP041881_SPT16.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP041798_RTG3/fasta/EXP041798_RTG3.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP042001_YRR1/fasta/EXP042001_YRR1.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP041999_YRR1/fasta/EXP041999_YRR1.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP042179_MED7/fasta/EXP042179_MED7.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP041996_YRR1/fasta/EXP041996_YRR1.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP042168_GAL1/fasta/EXP042168_GAL1.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP042083_REC114/fasta/EXP042083_REC114.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP042177_SRB6/fasta/EXP042177_SRB6.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP041797_RTG3/fasta/EXP041797_RTG3.101bp.fa | grep '>' | wc -l
# more GTRD_results/Saccharomyces_cerevisiae_R64/EXP041763_RAD51/fasta/EXP041763_RAD51.101bp.fa | grep '>' | wc -l
