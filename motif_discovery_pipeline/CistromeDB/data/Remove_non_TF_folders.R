#####################
## Load R packages ##
#####################
required.libraries <- c("data.table",
                        "dplyr",
                        "optparse")
for (lib in required.libraries) {
  if (!require(lib, character.only=TRUE)) {
    install.packages(lib)
    library(lib, character.only=TRUE)
  }
}


####################
## Read arguments ##
####################
option_list = list(
  make_option(c("-t", "--tf_assoc_table"), type="character", default=NULL, 
              help="Input table 1", metavar="character"),
  make_option(c("-f", "--data_folder"), type="character", default=NULL, 
              help="Input table 2", metavar="character"),
  make_option(c("-o", "--organism"), type="character", default=NULL, 
              help="Input table 2", metavar="character")
  
);
opt_parser = OptionParser(option_list = option_list);
opt = parse_args(opt_parser);

organism <- opt$organism
data.folder <- opt$data_folder

# tf.tab.file <- "CistromeDB_mouse_experiment_map.txt"
# organism <- "mouse"
# data.folder <- "DATA_FILES/mouse_factor_bk"


###############################
## Read TF association table ##
###############################
tf.tab <- fread(opt$tf_assoc_table)
colnames(tf.tab) <- c("ExpID", "Organism", "TF_name")


##############################################
## Read TFcheckpoint table - for mouse only ##
##############################################

## Non-DNA Transcriptional Regulator  
blacklist.TR <- list()

if(organism == "mouse"){
  
  TF.checkpoint.tab <- read.csv("http://www.tfcheckpoint.org/data/TFCheckpoint_download_180515.txt", sep = "\t")
  
  ## Filter checkpoint table
  TF.checkpoint.tab <- data.table(TF.checkpoint.tab[,c("gene_symbol", "entrez_mouse", "gene_name", "DBD")])
  
  TF.checkpoint.filt <- TF.checkpoint.tab %>% 
                          dplyr::filter(entrez_mouse != 0)
  
  ## Polymerase subunits
  RNAP.subunits <- TF.checkpoint.filt %>% 
                    dplyr::filter(grepl(gene_name, pattern = "polymerase"))
  RNAP.subunits <- as.vector(RNAP.subunits$gene_symbol)
  
  ## Histones genes + marks
  histones <- TF.checkpoint.filt %>% 
    dplyr::filter(grepl(gene_name, pattern = "histone"))
  histones <- as.vector(histones$gene_symbol)
  histones <- c(histones, "H2AFX", "H2AZ", "H3F3B", "H3K3me1", "H3Pan", "H3S10ph", "H3S28ph", "H4K5BU")
  
  ## RAD related proteins
  rad <- TF.checkpoint.filt %>% 
    dplyr::filter(grepl(gene_name, pattern = "rad"))
  rad <- as.vector(rad$gene_symbol)
  
  ## E1A related proteins
  E1A <- TF.checkpoint.filt %>% 
    dplyr::filter(grepl(gene_name, pattern = "E1A"))
  E1A <- as.vector(E1A$gene_symbol)
  
  ## P300
  P300 <- TF.checkpoint.filt %>% 
    dplyr::filter(grepl(gene_name, pattern = "E1A"))
  P300 <- as.vector(P300$gene_symbol)
  P300 <- c(P300, "EP300")
  
  ## EZH*
  EZH <- c("EZH1", "EZH2")
  
  ## Some cofactors
  cofactors <- TF.checkpoint.filt %>% 
    dplyr::filter(grepl(gene_name, pattern = "cofactor"))
  cofactors <- as.vector(cofactors$gene_symbol)
  
  ## Bromodomains
  bromo <- c("BRD2", "BRD4", "BRD9", "BRDT", "BRDU")
  
  ## TET
  TET <- c("TET1", "TET2", "TET3")
  
  ## CDK
  CDK <- c("CDK7", "CDK8", "CDK9")
  
  ## DNMT
  DNMT <- c("DNMTA", "DNMTB", "DNMTL")
  
  ## miRNA machinery
  mirna <- c("DROSHA")
  
  ## Histone demethylase
  HDM <- c("KDM1A", "KDM2A", "KDM3A", "KDM4A", "KDM4B", "KDM4C", "KDM4D", "KDM5A", "KDM5B", "KDM5C", "KDM6A", "KDM6B")
  
  ## Cohesin-related
  cohesin <- c("RAD21", "RAD23B", "RAD51", "SMC1A", "SMC1B", "SMC3", "SMC5", "SMCHD1")
  
  ## Ubiquitin
  Ubiquitin <- c("Ubiquitin", "ubiquitin")
  
  blacklist.TR[["mouse"]] <- c(RNAP.subunits,
                             histones,
                             P300,
                             E1A,
                             rad,
                             EZH,
                             cofactors,
                             bromo,
                             TET,
                             CDK,
                             DNMT,
                             mirna, 
                             HDM,
                             cohesin,
                             Ubiquitin)

  
} else if(organism == "human"){
  
  ## ROBIN: insert your code here!
}


###########################################################
## Remove the Non-DNA binding transcriptional regulators ##
###########################################################
tf.tab$TF_check <- !tf.tab$TF_name %in% blacklist.TR[[organism]]

tf.tab.keep <- tf.tab %>% 
  dplyr::filter(TF_check == TRUE)

tf.tab.remove <- tf.tab %>% 
  dplyr::filter(TF_check == FALSE)


####################
## Stats messages ##
####################
message("; # Experiments (before filtering): ", nrow(tf.tab), " - Organism: ", organism)
message("; # Unique datasets (before filtering): ", length(unique(tf.tab$TF_name)), " - Organism: ", organism)

message("; # Experiments (after filtering): ", nrow(tf.tab.keep), " - Organism: ", organism)
message("; # Unique datasets (after filtering): ", length(unique(tf.tab.keep$TF_name)), " - Organism: ", organism)


#######################
## Export black list ##
#######################
message("; Exportin black list of non-DNA-binding transcriptional regulators")
fwrite(data.table(blacklist.TR[["mouse"]]),
       file = paste0("Blacklist_non-DNA_binding_transcriptional_regulation_", organism, ".txt"),
       col.names = F, row.names = F,
       sep = "\t")


###########################################
## Remove folders for non-considered TRs ##
###########################################
sapply(as.vector((tf.tab.remove$ExpID)), function(folder.id){
  
  rm.folder <- file.path(data.folder, folder.id)
  message("; Removing folder:", rm.folder)
  unlink(rm.folder,
         recursive = TRUE)
})

