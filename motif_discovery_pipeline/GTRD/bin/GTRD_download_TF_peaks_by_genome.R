#!/usr/bin/env Rscript

################
## How to run ##
################
## Rscript GTRD_download_TF_peaks_by_genome.R out_folder genome

#####################
## Load R packages ##
#####################
required.libraries <- c("data.table",
                        "dplyr",
                        "reshape2")

for (lib in required.libraries) {
  if (!require(lib, character.only=TRUE)) {
    install.packages(lib)
    suppressPackageStartupMessages(library(lib, character.only=TRUE))
  }
}


#################################
## Read command line arguments ##
#################################
message("; Reading arguments from command line")
args = commandArgs(trailingOnly=TRUE)

## Test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
}

out.folder <- args[1]
genome <- args[2]
GTRD.version <- 18.06

message("; ")
message("; Output_folder: ", out.folder)
message("; Genome: ", genome)
message("; GTRD version: ", GTRD.version)


## Debug
# out.folder <- "/home/jamondra/Downloads/Tmp"
# genome <- "Arabidopsis_thaliana"
# GTRD.data.folder <- "/home/jamondra/Downloads/Tmp/"

## Genomes
# genome <- "Arabidopsis_thaliana"      # TAIR10
# genome <- "Drosophila_melanogaster"   # dm6
# genome <- "Saccharomyces_cerevisiae"  # R64
# genome <- "Schizosaccharomyces_pombe" # ASM294v2
# genome <- "Caenorhabditis_elegans"    # WBcel235


###########################
## Create output folders ##
###########################
GTRD.data.folder <- file.path(out.folder, "data", "peaks", genome)
GTRD.experiment.table.folder <- file.path(out.folder, "data", "experiment_table",  genome)
message("; ")
message("; Creating output folders")
message("; ", GTRD.data.folder)
message("; ", GTRD.experiment.table.folder)
dir.create(GTRD.data.folder, recursive = TRUE, showWarnings = FALSE)
dir.create(GTRD.experiment.table.folder, recursive = TRUE, showWarnings = FALSE)


######################################
## Download and uncompress ZIP file ##
######################################
genome.link <- gsub(genome, pattern = "_", replacement = "%20")
zip.file.url <- paste0("http://gtrd.biouml.org/downloads/", GTRD.version , "/", genome.link,"_macs_peaks.interval.gz")
file.download <- file.path(GTRD.data.folder, paste0("GTRD_macs_peaks_", genome, ".gz"))

## Download
message("; Downloading peaks (GZ file)")
download.file(url = zip.file.url,
              destfile = file.download, 
              method = "wget",
              quiet = TRUE)

## Uncompress
message("; Uncompressing peaks (GZ file)")
system(paste("gunzip", file.download))
peaks.file <- gsub(file.download, pattern = "\\.gz", replacement = "")


#####################
## Read peaks file ##
#####################
peaks.tab <- fread(peaks.file)
peaks.tab$ID <- paste(peaks.tab$experiment, peaks.tab$tfTitle, sep = "_")
peaks.tab$ID <- gsub(peaks.tab$ID, pattern = "\\.", replacement = "-")
peaks.tab$ID <- gsub(peaks.tab$ID, pattern = "\\(", replacement = "-")
peaks.tab$ID <- gsub(peaks.tab$ID, pattern = "\\)", replacement = "-")
peaks.tab$ID <- gsub(peaks.tab$ID, pattern = ":", replacement = "-")
peaks.tab$ID <- gsub(peaks.tab$ID, pattern = "\\", replacement = "-", fixed=TRUE)


###################################
## Split the table by experiment ##
###################################
message("; Splitting table by experiments")
peaks.tab.list <- split(peaks.tab, f = peaks.tab$ID)

silence <- sapply(names(peaks.tab.list), function(ID){
  
  if(nrow(peaks.tab.list[[ID]]) >= 30){
    
    ## Create output folder following the folder structure required by the Snakefile
    peaks.out.folder <- file.path(GTRD.data.folder, ID)
    dir.create(peaks.out.folder, recursive = TRUE, showWarnings = FALSE)
    
    message("; Exporting peaks - Experiment: ", ID)
    experiment.peaks.file <- file.path(peaks.out.folder, paste0(ID, "_peaks.narrowPeak"))
    fwrite(peaks.tab.list[[ID]], file = experiment.peaks.file, quote = FALSE, sep = "\t", row.names = FALSE, col.names = FALSE)
  }
})

## Export experiment table
message("; Exporting experiment table ")
peaks.tab <- peaks.tab[,c("experiment", "cellLine", "tfTitle")]
experiment.tab.file <- file.path(GTRD.experiment.table.folder, paste0(genome, "_GTRD_experiment_table.tab"))
fwrite(peaks.tab, file = experiment.tab.file, quote = FALSE, sep = "\t", col.names = FALSE, row.names = FALSE)

## Remove files
file.remove(peaks.file)