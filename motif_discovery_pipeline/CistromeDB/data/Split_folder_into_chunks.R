#####################
## Load R packages ##
#####################
required.libraries <- c("filesstrings",
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
  make_option(c("-f", "--folder"), type="character", default=NULL, 
              help="Folder to split", metavar="character"),
  make_option(c("-s", "--chunk_size"), type="numeric", default=NULL, 
              help="Number of files on each chunk", metavar="numeric"),
  make_option(c("-p", "--prefix_folders"), type="character", default=50, 
              help="Prefix name for the created folders", metavar="character")
  
);
opt_parser = OptionParser(option_list = option_list);
opt = parse_args(opt_parser);

folder <- opt$folder
chunk.size <- as.numeric(opt$chunk_size)
prefix.name <- opt$prefix_folders


#folder <- "/home/jamondra/Downloads/Tmp/Mv"
#chunk.size <- 2
#prefix.name <- "Test_folder"


## Set the folder to split
setwd(folder)

## Count the files
files <- list.files()
nb.files <- length(files)

## Calculate number of subfolders
nb.subfolders <- ceiling(nb.files / chunk.size)

file.counter <- 1
for(s in 1:nb.subfolders){
  
  ## Create subfolder
  subfolder <- paste(prefix.name, s, sep = "_")
  dir.create(subfolder, recursive = T)
  message("; Moving ", chunk.size, " files to ", subfolder)
  
  ## Select files to move
  files.to.mv <- files[file.counter:(file.counter + chunk.size - 1)]
  
  ## Move the files
  for(f in files.to.mv){
    file.copy(f, subfolder, recursive = T)
  }
  
  file.counter <- file.counter + chunk.size
}
