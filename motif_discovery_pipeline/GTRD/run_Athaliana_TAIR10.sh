SNAKEFILE='Snakefile'
CONFIGFILE='config_files/config_Athaliana_TAIR10.yaml'

snakemake --cores 50 --snakefile $SNAKEFILE --configfile $CONFIGFILE
#snakemake --dag --snakefile $SNAKEFILE --configfile $CONFIGFILE | dot -Tsvg > "${CONFIGFILE}_part1_DAG.svg"

snakemake --cores 50 --snakefile $SNAKEFILE --configfile $CONFIGFILE

#snakemake --dag --snakefile $SNAKEFILE --configfile $CONFIGFILE | dot -Tsvg > "${CONFIGFILE}_part2_DAG.svg"
