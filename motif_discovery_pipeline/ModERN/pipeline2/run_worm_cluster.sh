SNAKEFILE='Snakefile'
CONFIGFILE='config_worm_cluster.yaml'

LOGDIR='/home/rvdlee/JASPAR/ModERN/results_cluster/ModERN_worm/logs/'
JOBNAME=RSAT_worm

mkdir -p $LOGDIR



#snakemake --snakefile $SNAKEFILE --configfile $CONFIGFILE
#; snakemake --snakefile $SNAKEFILE --configfile $CONFIGFILE
snakemake --cores 100 --cluster 'qsub -V -w e -N $JOBNAME -l h_vmem=2G' --snakefile $SNAKEFILE --configfile $CONFIGFILE --forcerun

mv ~/$JOBNAME.o* $LOGDIR
mv ~/$JOBNAME.e* $LOGDIR


## MONITOR
# qstat -f
# watch -n 0.2 qstat -f
# logs are in home folder
# head RSAT.o* | less
# head RSAT.e* | less
