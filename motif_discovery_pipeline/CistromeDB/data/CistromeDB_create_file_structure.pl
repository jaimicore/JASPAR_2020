#!/usr/bin/env perl
#####################################
## Robin van der Lee               ##
## robinvanderlee AT gmail DOT com ##
#####################################
use warnings;
use strict;
use File::Path qw(make_path);
use File::Spec::Functions 'catfile';
use File::Copy qw(move mv);


### command line arguments
my $BASEDIR = "";
if(scalar @ARGV == 0){
	die "Please provide an input directory with CistromeDB narrowpeak files\n";
} else {
	$BASEDIR = shift @ARGV;
}

# loop over all files
opendir(BDIR, $BASEDIR) or die "Could not open $BASEDIR\n";
while (my $filename = readdir(BDIR)) {

	## get the first part of the file name (the experiment ID, which is just an integer) AND make sure to do it only for file ending on narrowPeak.bed
	# 1006_sort_peaks.narrowPeak.bed
	# 1007_sort_peaks.narrowPeak.bed
	# 1009_sort_peaks.narrowPeak.bed
	next if $filename !~ /^(\d+)\_.*narrowPeak\.bed$/;
	my $experiment_id = $1;

	# create directory structure
	my $expdir = catfile($BASEDIR, $experiment_id);
	eval { make_path($expdir) };
	if ($@) {
		print "Couldn't create $expdir: $@";
	}

	# move the current file to that new directory and rename it according to the expected format for our snakemake pipeline
	my $filename_new = "${experiment_id}_peaks.narrowPeak";
	rename catfile($BASEDIR, $filename), catfile($BASEDIR, $filename_new);
    move catfile($BASEDIR, $filename_new), $expdir;
}
closedir(BDIR);
