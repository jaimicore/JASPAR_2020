# DOWNLOAD FROM https://figshare.com/articles/Supplemental_Data_for_Kudron_et_al_2018_The_modERN_Resource_Genome-wide_Binding_Profiles_for_Hundreds_of_Drosophila_and_C_elegans_Transcription_Factors_/5729667
#Supplemental Table 7 fly sites.txt
#Supplemental Table 8 worm sites.txt

ln -s Supplemental\ Table\ 7\ fly\ sites.txt ModERN_fly_peaks
ln -s Supplemental\ Table\ 8\ worm\ sites.txt ModERN_worm_peaks

perl split_into_individual_experiments_and_create_experiment_map.pl ModERN_worm_peaks
perl create_experiment_maps.pl ModERN_worm_peaks worm

perl split_into_individual_experiments_and_create_experiment_map.pl ModERN_fly_peaks
perl create_experiment_maps.pl ModERN_fly_peaks fly
