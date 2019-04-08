SNAKEFILE='Snakefile'
CONFIGFILE='config_files/config_Spombe_ASM294v2.yaml'

snakemake --cores 50 --snakefile $SNAKEFILE --configfile $CONFIGFILE
#snakemake --dag --snakefile $SNAKEFILE --configfile $CONFIGFILE | dot -Tsvg > "${CONFIGFILE}_part1_DAG.svg"

snakemake --cores 50 --snakefile $SNAKEFILE --configfile $CONFIGFILE

#snakemake --dag --snakefile $SNAKEFILE --configfile $CONFIGFILE | dot -Tsvg > "${CONFIGFILE}_part2_DAG.svg"