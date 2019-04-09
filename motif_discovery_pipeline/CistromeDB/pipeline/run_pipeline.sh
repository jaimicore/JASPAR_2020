#!/usr/bin/env bash

################################################################################
usage="""
\n
$0 -c <snakemake config file .yaml>
\n
""";

options=`getopt -o hc: -- "$@"`;

if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi
eval set -- "$options";

SNAKEFILE='Snakefile'
CONFIGFILE='';

while true
do
  case "$1" in
    -c) CONFIGFILE=$2; shift 2;;
    -h) echo -e $usage; exit;;
    --) shift; break;;
    *) echo "Internal error!"; exit 1;;
  esac
done
################################################################################

echo $SNAKEFILE;
echo $CONFIGFILE;

snakemake --snakefile $SNAKEFILE --configfile $CONFIGFILE
# snakemake --cores 20 --snakefile $SNAKEFILE --configfile $CONFIGFILE

# snakemake --snakefile $SNAKEFILE --configfile $CONFIGFILE #--cores 10 
# snakemake --dag --snakefile $SNAKEFILE --configfile $CONFIGFILE | dot -Tsvg > "${CONFIGFILE}_DAG.svg"
