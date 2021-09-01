use List::Util qw(min max);

if (@ARGV < 3) {
	die "empty arguments.\ncommand is: perl this.pl file motif threads\nfile should be bam file without .bam extension\n";
}

$bam1=$ARGV[0];
$threads=$ARGV[2];
$motifFile=$ARGV[1];


die "Install samtools\n" unless `samtools --help`;
die "Install bedtools\n" unless `bedtools --help`;

$present_file = 0;
if(! -e "$bam1.bam") {
		print "$bam1 file does not exist\n";
}
 
if (! -e $motifFile) {
	print "$motifFile does not exist\n";
}

if ($present_file > 0){
	die "";
}

system("samtools sort -n -@ $threads -O BAM -o $bam1-sortedByName.bam $bam1.bam");
system("bedtools bamtobed -i $bam1-sortedByName.bam -bedpe  > $bam1.bam2bed.txt");


open(f,"$bam1.bam2bed.txt") || die "$bam1.bam2bed.txt file does not exist; error in the file preparation";
open(out,">$bam1.bed3") || die "You do not have permission to write here";
while(<f>){
	chomp $_; @s=split(' ',$_);
	$f0=$s[1]; $f1=$s[2]; $f2=$s[4]; $f3=$s[5];
	@array=(); push(@array,$f0); push(@array,$f1);push(@array,$f2);push(@array,$f3);
	$min = min @array;
	$max = max @array;
	print out "$s[0]\t$min\t$max\t$s[6]\t$s[7]\t.\n";
	}

system("sort -k1,1 -k2,2n $bam1.bed3 > $bam1.sorted.bed3");
system("mv $bam1.sorted.bed3  $bam1.bed3");
system("rm $bam1.bam2bed.txt $bam1-sortedByName.bam");
system("windowBed -a $motifFile -b $bam1.bed3 -w 1000 > $bam1.input");

#$frmt = "chr1	23409	23420	-	8.227320	GGTGAGTCAGTG	chr1	23159	23370	M01516:364:000000000-CLDFT:1:1115:26082:22502	1	.";

#$v = `head  $bam1.input -n1 | awk '{print NF}'`;
#chomp $v;

#if ($v != 12) {
#	print "format of the $bam1.input is not correct\n";
#}
