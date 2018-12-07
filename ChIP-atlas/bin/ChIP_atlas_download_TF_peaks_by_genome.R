#!/usr/bin/env Rscript


################
## How to run ##
################
## Rscript --vanilla ChIP_atlas_download_TF_peaks_by_genome.R out_folder genome

#####################
## Load R packages ##
#####################
required.libraries <- c("data.table",
                        "dplyr",
                        "future.apply",
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

message("; ")
message("; Output_folder: ", out.folder)
message("; Genome: ", genome)


# out.folder <- "/storage/mathelierarea/processed/jamondra/Projects/JASPAR/post_processing/"
# genome <- "ce10"

# experiment.tab.file <- "/storage/mathelierarea/processed/jamondra/Projects/JASPAR/post_processing/ChIP-atlas/experiment_table/experimentList_TFs_and_others.tab"
# ChIP.atlas.data.folder <- "/storage/mathelierarea/processed/jamondra/Projects/JASPAR/post_processing/ChIP-atlas/data"



##########################
## Create output folder ##
##########################
ChIP.atlas.data.folder <- file.path(out.folder, "ChIP-atlas", "data")
exp.tab.folder <- file.path(out.folder, "ChIP-atlas", "experiment_table")


message("; ")
message("; Creating output folders")
message("; ", ChIP.atlas.data.folder)
message("; ", exp.tab.folder)
dir.create(ChIP.atlas.data.folder, recursive = TRUE, showWarnings = FALSE)
dir.create(exp.tab.folder, recursive = TRUE, showWarnings = FALSE)

exp.tab.file <- file.path(exp.tab.folder, "experimentList.tab")
exp.tab.parsed.file <- file.path(exp.tab.folder, "experimentList_TFs_and_others.tab")


## Only runs this section when the parsed experiment table does not exist
if(!exists(exp.tab.parsed.file)){
 
  ###############################
  ## Download experiment table ##
  ###############################
  message("; Downloading experiment table")
  download.tab.cmd <- paste0("wget http://dbarchive.biosciencedbc.jp/kyushu-u/metadata/experimentList.tab -O ", exp.tab.file)
  
  message("; ")
  message("; ", download.tab.cmd)
  system(download.tab.cmd)
  
  
  ################################
  ## Parse the experiment table ##
  ################################
  
  ## NOTE: this is done via shell since the table cannot be loaded in R. Apparently many lines do not contain the same number of columns.
  ## Columns:
  ##
  ## 1) Experiment ID
  ## 2) Genome
  ## 4) Antigen (TF name)
  ## 5) Cell type class
  ## 6) Cell type
  message("; Parsing experiment table")
  parse.tab.cmd <- paste0("more ", exp.tab.file, " | grep 'TFs and others'  | cut -f1,2,4,5,6 > ", exp.tab.parsed.file)
  
  message("; ")
  message("; ", parse.tab.cmd)
  system(parse.tab.cmd)
  
}


###########################
## Load experiment table ##
###########################
message("; ")
message("; Reading parsed experiment table")
experiment.tab <- fread(exp.tab.parsed.file, sep = "\t", header = FALSE, fill = TRUE)
colnames(experiment.tab) <- c("Experiment_ID", "genome", "Protein", "Cell_type_class", "Cell_type")

## Remove the GFP (input) and other protein entries from the table
proteins.to.rm <- c("GFP", "Adenine N6-methylation")
experiment.tab <- experiment.tab[!experiment.tab$Protein %in% proteins.to.rm, ]


## Set genome names
# genomes <- unique(experiment.tab$genome)
# genomes <- "ce10"

## Set the number of cores to parallelize the loop
sapply(genome, function(g){
  
  ## Select the entries with a given genome
  experiment.tab.genome.parsed <- experiment.tab %>% 
                                    filter(genome == g)
  
  ## Parse the cell type names
  experiment.tab.genome.parsed$Cell_type <- as.vector(sapply(experiment.tab.genome.parsed$Cell_type, gsub, pattern = "\\s+", replacement = "-"))

  
  ## Generate download commands
  experiment.id.jaspar <- paste(experiment.tab.genome.parsed$Experiment_ID, 
                                experiment.tab.genome.parsed$Cell_type,
                                experiment.tab.genome.parsed$Protein,
                                sep = "_")
  
  ## Experiment JASPAR ID
  experiment.tab.genome.parsed$Experiment_ID_JASPAR <- experiment.id.jaspar
  
  ## Set ChIP-atlas download file name
  experiment.tab.genome.parsed$File_download <- file.path(ChIP.atlas.data.folder, experiment.tab.genome.parsed$Experiment_ID_JASPAR, paste0(experiment.tab.genome.parsed$Experiment_ID_JASPAR, "_peaks.narrowPeak "))
  
  ## Commands to create folder and download files
  message("; ")
  message("; Downloading experiment: ", experiment.tab.genome.parsed$Experiment_ID)
  experiment.tab.genome.parsed$Command_download <- paste0("mkdir -p ", file.path(ChIP.atlas.data.folder, experiment.tab.genome.parsed$Experiment_ID_JASPAR),
                             "; wget http://dbarchive.biosciencedbc.jp/kyushu-u/", g, "/eachData/bed05/", experiment.tab.genome.parsed$Experiment_ID, ".05.bed -O ", experiment.tab.genome.parsed$File_download)

  plan(multiprocess, workers = 50)
  future_sapply(experiment.tab.genome.parsed$Command_download[1:15], system)
})