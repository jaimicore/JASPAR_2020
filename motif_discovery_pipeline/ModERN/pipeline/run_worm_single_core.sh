SNAKEFILE='Snakefile'
CONFIGFILE='config_worm.yaml'

snakemake --snakefile $SNAKEFILE --configfile $CONFIGFILE #--cores 20 
snakemake --snakefile $SNAKEFILE --configfile $CONFIGFILE #--cores 10 
snakemake --dag --snakefile $SNAKEFILE --configfile $CONFIGFILE | dot -Tsvg > "${CONFIGFILE}_DAG.svg"
