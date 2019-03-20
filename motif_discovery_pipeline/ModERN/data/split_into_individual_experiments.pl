#!/usr/bin/env perl
#####################################
## Robin van der Lee               ##
## robinvanderlee AT gmail DOT com ##
#####################################
use warnings;
use strict;
use File::Path qw(make_path);
use File::Spec::Functions 'catfile';


### command line arguments
# 1: infile
my $peakfile_all = "";
if(scalar @ARGV == 0){
	die "Please provide a input file with peaks\n";
} else {
	$peakfile_all = shift @ARGV;
}

#
my $BASEDIR = "${peakfile_all}_DATA/";

### MAIN
open(IN ,"<$peakfile_all");
while(<IN>){
	my @F = split /\t/;

	# only print first 10 fields
	@F = @F[0..9];

	# split file based on fourth field, first part of :-separated expression
	my $expname_and_peak = $F[3];
	my @expname_and_peak_split = split /\:/, $F[3];
	my $expname = $expname_and_peak_split[0];


	# create directory structure
	my $expdir = catfile($BASEDIR, $expname);
	eval { make_path($expdir) };
	if ($@) {
		print "Couldn't create $expdir: $@";
	}

	# create or append to file
	my $peakfile = catfile($expdir, "${expname}_peaks.narrowPeak");
	open(PEAKFILE, ">>$peakfile");
	print PEAKFILE join("\t", @F) . "\n";
	close PEAKFILE;
}
close IN;
