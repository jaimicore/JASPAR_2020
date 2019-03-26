#!/usr/bin/env perl
#####################################
## Robin van der Lee               ##
## robinvanderlee AT gmail DOT com ##
#####################################
use warnings;
use strict;
use Getopt::Long;
use File::Basename;
use File::Spec;




### MAKE SURE THE EXPERIMENT_MAP HAS:
my $EXP_ID_FIELD = 0;
my $EXP_TF_FIELD = 2;






### BASED ON CODE FROM SNAKEFILE:
# ## NOTE 4: the awk variables are relative to the ChIP-atlas experiment table.
# rule annotate_best_centrimo_experiment:
#     """
#     Assign the TF name to the selected motif.

#     This rule is executed for the best experiment of each dataset (experiment).
#     """
#     input:
#         tf_jaspar_map = config["TF_Experiment_map"],
#         best_exp = os.path.join(config["out_dir"], "{TF}", "central_enrichment", "selected_motif", "{TF}.501bp.fa.sites.centrimo.best")
#     output:
#         os.path.join(config["out_dir"], "{TF}", "central_enrichment", "selected_motif", "{TF}.501bp.fa.sites.centrimo.best.TF_associated")
#     message:
#         "; Assigning TF name to the experiment: {wildcards.TF} "
#     priority:
#         86
#     shell:
#         """
#         motif_name="$(more {input.best_exp} | cut -f1 | xargs basename | cut -d'.' -f1 | perl -lne '$_ =~ s/_m(\\d+)$/_peak-motifs_m$1/g; print $_ ')";

#         motif_folder="$(more {input.best_exp} | cut -f1 | xargs dirname | perl -lne '$_ =~ s/central_enrichment/motifs\/jaspar\/logos/gi; print $_')";

#         ##  -v: Pass variable as arguments
#         ##
#         awk -v motif_n=$motif_name -v motif_f=$motif_folder 'NR==FNR{{mapping[$11] = $1}} NR!=FNR{{split($1, arr, "/"); split(arr[3], enc, "_"); print enc[1]"\\t"enc[3]"\\t"enc[3]"\\t"$0"\\t"motif_f"/"motif_n"_logo.png"}}' {input.tf_jaspar_map} {input.best_exp} > {output}
#         """
#
#
# --------------------------------------------------------------------------------- 
# SPECIFICALLY REPLACES THE THREE SHELL COMMANDS AT THE END OF THAT RULE


### PARSE OPTIONS
my $tf_jaspar_map = ""; # tf_jaspar_map = config["TF_Experiment_map"],
my $best_exp = ""; # best_exp = os.path.join(config["out_dir"], "{TF}", "central_enrichment", "selected_motif", "{TF}.501bp.fa.sites.centrimo.best")
my $output = ""; # os.path.join(config["out_dir"], "{TF}", "central_enrichment", "selected_motif", "{TF}.501bp.fa.sites.centrimo.best.TF_associated")

my $USAGE = "Usage: $0 --best BEST_EXP_FILE --map TF_JASPAR_MAP_FILE --output OUTPUT_FILE\n";
if( scalar @ARGV != 6 ){
	die $USAGE;
}
GetOptions( 'best=s' => \$best_exp,
			'map=s' => \$tf_jaspar_map,
			'output=s' => \$output) or die $USAGE;

# print $tf_jaspar_map . "\n";
# print $best_exp . "\n";
# print $output . "\n";



### STEP 1
my $motif = "";
my $motif_folder  = "";

my $centrimo_best_file_name = "";
my $centrimo_best_file_name__basename = "";
my $centrimo_best_pvalue  = "";

# RECREATE:
# 1. motif_name="$(more $best_exp | cut -f1 | xargs basename | cut -d'.' -f1 | perl -lne '$_ =~ s/_m(\\d+)$/_peak-motifs_m$1/g; print $_ ')";
# 2. motif_folder="$(more {input.best_exp} | cut -f1 | xargs dirname | perl -lne '$_ =~ s/central_enrichment/motifs\/jaspar\/logos/gi; print $_')";
open(BEST_EXP_FH, "<$best_exp") or die "File $best_exp does not exist";
while(<BEST_EXP_FH>){
	chomp;
	
	my @F = split /\t/;
	$centrimo_best_file_name = $F[0];
	$centrimo_best_pvalue = $F[1];
	
	$centrimo_best_file_name__basename = basename($centrimo_best_file_name);
	my $centrimo_best_file_name__dirname  = dirname($centrimo_best_file_name);

	# get first part of centrimo_best_file_name and rename it, e.g.
	# from dm_Stat92E-GFP_Stat92E_E12-24_m1
	# to dm_Stat92E-GFP_Stat92E_E12-24_peak-motifs_m1
	my @F2 = split /\./, $centrimo_best_file_name__basename;
	$motif = $F2[0];
	$motif =~ s/_m(\d+)$/_peak-motifs_m$1/g;

	# rename the path name, e.g.
	# from /home/rvdlee/JASPAR/ModERN/results/ModERN_fly/output/dm_Stat92E-GFP_Stat92E_E12-24/central_enrichment
	# to /home/rvdlee/JASPAR/ModERN/results/ModERN_fly/output/dm_Stat92E-GFP_Stat92E_E12-24/motifs/jaspar/logos
	$motif_folder = $centrimo_best_file_name__dirname;
	$motif_folder =~ s/central_enrichment/motifs\/jaspar\/logos/gi;

	# print $motif . "\n";
	# print $motif_folder . "\n";
}
close(BEST_EXP_FH);



### STEP 2

# RECREATE:
#         awk -v motif_n=$motif_name -v motif_f=$motif_folder 'NR==FNR{{mapping[$11] = $1}} NR!=FNR{{split($1, arr, "/"); split(arr[3], enc, "_"); print enc[1]"\\t"enc[3]"\\t"enc[3]"\\t"$0"\\t"motif_f"/"motif_n"_logo.png"}}' {input.tf_jaspar_map} {input.best_exp} > {output}
# 
# THIS PRODUCES SOMETHING LIKE THIS: 
# $ cat SRX977484_BY4741_TAF4.501bp.fa.sites.centrimo.best.TF_associated 
# SRX977484	TAF4	TAF4	ChIP-atlas_results/sacCer3/SRX977484_BY4741_TAF4/central_enrichment/SRX977484_BY4741_TAF4_m4.501bp.fa.sites.centrimo	-2.22045e-16	ChIP-atlas_results/sacCer3/SRX977484_BY4741_TAF4/motifs/jaspar/logos/SRX977484_BY4741_TAF4_peak-motifs_m4_logo.png



## get all the parts required for the output

# find the information corresponding to the best_exp in the tf_jaspar_map
my $exp_id = "";
my $exp_tf = "";
open(TF_JASPAR_MAP_FH, "<$tf_jaspar_map");
while(<TF_JASPAR_MAP_FH>){
	chomp;
	my @F = split /\t/;

	# the experiment ID is in the first field of the map file
	my $exp_id_current = $F[$EXP_ID_FIELD];

	# if the current line of the map file corresponds to the experiment ID in the centrimo best file, then we've found the right information, and we can save it.
	if(begins_with($centrimo_best_file_name__basename, $exp_id_current)){
		$exp_id = $exp_id_current;

		# the TF name is in the third field
		$exp_tf = $F[$EXP_TF_FIELD];
	}
}
close(TF_JASPAR_MAP_FH);

my $logo_png_filepath = File::Spec->catfile($motif_folder, $motif . "_logo.png");


## create the output file
open(OUTFILE_FG, ">$output");
print OUTFILE_FG $exp_id . "\t" . $exp_tf . "\t" . $exp_tf . "\t" . $centrimo_best_file_name . "\t" . $centrimo_best_pvalue . "\t" . $logo_png_filepath . "\n"; 
close(OUTFILE_FG);




#################
### FUNCTIONS ###
#################

# check if the string in the first agrument starts with the string in the second argument
sub begins_with
{
    return substr($_[0], 0, length($_[1])) eq $_[1];
}