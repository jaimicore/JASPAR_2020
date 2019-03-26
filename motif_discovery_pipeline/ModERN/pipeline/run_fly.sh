SNAKEFILE='Snakefile'
CONFIGFILE='config_fly.yaml'

snakemake --cores 20 --snakefile $SNAKEFILE --configfile $CONFIGFILE
snakemake --dag --snakefile $SNAKEFILE --configfile $CONFIGFILE | dot -Tsvg > "${CONFIGFILE}_part1_DAG.svg"
snakemake --cores 10 --snakefile $SNAKEFILE --configfile $CONFIGFILE
snakemake --dag --snakefile $SNAKEFILE --configfile $CONFIGFILE | dot -Tsvg > "${CONFIGFILE}_part2_DAG.svg"
