# DOWNLOAD FROM http://cistrome.org/db/#/bdown

mkdir DATA_FILES
cd DATA_FILES

MOUSE=cistromedb_mouse_factor_batch.gz
HUMAN=cistromedb_human_factor_batch.gz

wget -O $MOUSE http://cistrome.org/db/batchdata/R9MXVUTB72SQ8FJLMWXU.tar.gz
wget -O $HUMAN http://cistrome.org/db/batchdata/24KRO157XZ5Y204IEVFN.tar.gz

tar xfz $HUMAN
rm -rf $HUMAN
tar xfz human_factor.tar.gz
rm -rf human_factor.tar.gz

tar xfz $MOUSE
rm -rf $MOUSE
tar xfz mouse_factor.tar.gz
rm -rf mouse_factor.tar.gz

perl CistromeDB_create_file_structure.pl DATA_FILES/human_factor
perl CistromeDB_create_file_structure.pl DATA_FILES/mouse_factor

tail -n +2 DATA_FILES/human_factor.txt | cut -f 1,2,7 > CistromeDB_human_experiment_map.txt
tail -n +2 DATA_FILES/mouse_factor.txt | cut -f 1,2,7 > CistromeDB_mouse_experiment_map.txt

## Remove Non-DNA-binding Transcriptional regulators
Rscript Remove_non_TF_folders.R -t CistromeDB_mouse_experiment_map.txt -f DATA_FILES/mouse_factor -o mouse




#perl CistromeDB_create_file_structure.pl DATA_FILES/human_factor
#perl CistromeDB_create_file_structure.pl DATA_FILES/mouse_factor

#tail -n +2 DATA_FILES/human_factor.txt | cut -f 1,2,7 > CistromeDB_human_experiment_map.txt
#tail -n +2 DATA_FILES/mouse_factor.txt | cut -f 1,2,7 > CistromeDB_mouse_experiment_map.txt
