SNAKEFILE='Snakefile'
CONFIGFILE='config_fly_cluster.yaml'
LOGDIR='/home/rvdlee/JASPAR/ModERN/results_cluster/ModERN_fly/logs/'

mkdir -p $LOGDIR



#snakemake --snakefile $SNAKEFILE --configfile $CONFIGFILE
#; snakemake --snakefile $SNAKEFILE --configfile $CONFIGFILE
snakemake --cores 100 --cluster 'qsub -V -w e -N RSAT_fly -e $LOGDIR -o $LOGDIR -l h_vmem=2G' --snakefile $SNAKEFILE --configfile $CONFIGFILE



## MONITOR
# qstat -f
# watch -n 0.2 qstat -f
# logs are in home folder
# head RSAT.o* | less
# head RSAT.e* | less
