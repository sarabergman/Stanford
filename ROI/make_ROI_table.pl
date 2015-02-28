
#!/usr/bin/perl

use strict;
use warnings;

use File::Spec;
use Data::Dumper;

my $datapath = File::Spec->catdir($ENV{'HOME'},'net','munin','data','Huettel','EmoExpect.01','Analysis','FSL');

if (! -d  $datapath) {
	die "invalid file path: $datapath\n";
}

#my $model = '23_1.gfeat';

#my $cope = 'cope1.feat';

#my $outputName = File::Spec->catfile($ENV{'HOME'},'experiments','CUD.01','Analysis','Outcome','ROI','!Plots','lOFC.csv');
my $outputName = File::Spec->catfile($ENV{'HOME'},'net','munin','data','Huettel','EmoExpect.01','Analysis','FSL','ROI','Model04_Smooth_5mm_motion_denoised','featquery_all_subjects.csv');


my @file1Glob = glob("$datapath/1*/Model04_FNIRT/Smooth_5mm_motion_denoised/Level2.gfeat/cope*.feat/left_vSTR/report.txt");
my @file2Glob = glob("$datapath/1*/Model04_FNIRT/Smooth_5mm_motion_denoised/Level2.gfeat/cope*.feat/right_vSTR/report.txt");
my @file3Glob = glob("$datapath/1*/Model04_FNIRT/Smooth_5mm_motion_denoised/Level2.gfeat/cope*.feat/vmPFC/report.txt");
my @file4Glob = glob("$datapath/1*/Model04_FNIRT/Smooth_5mm_motion_denoised/Level2.gfeat/cope*.feat/cuneus/report.txt");

my @roiList;


open(my $OUTPUT, '>', $outputName ) or die "cannot create output file: $!";

my $out_line = join(',','subject','ROI','cope','PE');
print $OUTPUT "$out_line\n";


FLIST:
foreach my $file ( @file1Glob,@file2Glob,@file3Glob,@file4Glob ) {

	my @split_stuff = split(/\//,$file);
	my $subj = $split_stuff[10];
	#my @roiInfo = split(/\_/,$split_stuff[13]);

	my $mean = get_featquery_info( $file );
	$out_line = join(',',$subj,$split_stuff[15], $split_stuff[14],$mean);

	print $OUTPUT "$out_line\n";
}
close($OUTPUT);



sub get_featquery_info {

	my ( $fname ) = @_;
	my $fq_info = qx(awk '{print \$6}' $fname);
	chomp($fq_info);

	return $fq_info;
}
