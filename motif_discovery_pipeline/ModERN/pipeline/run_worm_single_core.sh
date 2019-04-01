SNAKEFILE='Snakefile'
CONFIGFILE='config_worm.yaml'

snakemake --snakefile $SNAKEFILE --configfile $CONFIGFILE
snakemake --dag --snakefile $SNAKEFILE --configfile $CONFIGFILE | dot -Tsvg > "${CONFIGFILE}_part1_DAG.svg"
snakemake --snakefile $SNAKEFILE --configfile $CONFIGFILE
snakemake --dag --snakefile $SNAKEFILE --configfile $CONFIGFILE | dot -Tsvg > "${CONFIGFILE}_part2_DAG.svg"
