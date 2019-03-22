#!/usr/bin/env perl
#####################################
## Robin van der Lee               ##
## robinvanderlee AT gmail DOT com ##
#####################################
use warnings;
use strict;


### command line arguments
# 1: infile
my $peakfile_all = "";
my $fly_or_worm = "";
if( scalar @ARGV != 2 ){
	die "Please provide a (1) input file with peaks and (2) \"fly\" or \"worm\"\n";
} else {
	$peakfile_all = shift @ARGV;
	$fly_or_worm = shift @ARGV;
}

#
my $experiment_map_file = "${peakfile_all}_experiment_map.txt";


### MAIN
open(IN ,"<$peakfile_all");
my %experiment_map; # hash to store unique experiment_map strings for writing to a file later
while(<IN>){
	chomp;
	my @F = split /\t/;

	# split file based on fourth field, first part of :-separated expression
	my $expname_and_peak = $F[3];
	my @expname_and_peak_split = split /\:/, $F[3];
	my $expname = $expname_and_peak_split[0];

	# store relevant information to experiment map hash
	# experiment_id    genome    tf    other
	my $experiment_map_current = "";
	if($fly_or_worm eq "worm"){
		$experiment_map_current = $expname . "\t" . $F[11] . "\t" . $F[14] . "\t" . "";
	}elsif($fly_or_worm eq "fly"){
		#dm_wt_Trl_E16-24 or dm_ac-GFP_E0-8 or ...
		my $regex = qr/^(dm_wt|dm)_(\S+?(?=_)|\S+$)/mp;

		if ( $expname =~ /$regex/g ) {
  			#print "$expname		$1		$2\n";

			$experiment_map_current = $expname . "\t" . $1 . "\t" . $2 . "\t" . "";
		}else{
			die("could not find TF information in: $expname\n");
		}
		
	}else{
		die("please specify either \"fly\" or \"worm\" as the second argument\n");
	}
	
	$experiment_map{$experiment_map_current} = "";
}
close IN;

# write experiment_map file
open(EXPMAP ,">$experiment_map_file");
for(keys %experiment_map){
	print EXPMAP $_ . "\n";
}
close EXPMAP;
