# DOWNLOAD FROM http://cistrome.org/db/#/bdown
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

perl CistromeDB_create_file_structure.pl human_factor
perl CistromeDB_create_file_structure.pl mouse_factor

# perl split_into_individual_experiments_and_create_experiment_map.pl ModERN_worm_peaks
# perl create_experiment_maps.pl ModERN_worm_peaks worm

# perl split_into_individual_experiments_and_create_experiment_map.pl ModERN_fly_peaks
# perl create_experiment_maps.pl ModERN_fly_peaks fly

