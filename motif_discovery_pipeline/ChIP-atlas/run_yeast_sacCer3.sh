SNAKEFILE='Snakefile'
CONFIGFILE='config_files/config_yeast_sacCer3.yaml'

snakemake --cores 75 --snakefile $SNAKEFILE --configfile $CONFIGFILE
#snakemake --dag --snakefile $SNAKEFILE --configfile $CONFIGFILE | dot -Tsvg > "${CONFIGFILE}_part1_DAG.svg"
snakemake --cores 75 --snakefile $SNAKEFILE --configfile $CONFIGFILE
#snakemake --dag --snakefile $SNAKEFILE --configfile $CONFIGFILE | dot -Tsvg > "${CONFIGFILE}_part2_DAG.svg"
