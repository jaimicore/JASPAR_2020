SNAKEFILE='Snakefile'
CONFIGFILE='config_worm.yaml'

# snakemake --dag --snakefile $SNAKEFILE --configfile $CONFIGFILE | dot -Tsvg > "${CONFIGFILE}_DAG.svg"
snakemake --cores 20 --snakefile $SNAKEFILE --configfile $CONFIGFILE
snakemake --cores 10 --snakefile $SNAKEFILE --configfile $CONFIGFILE
