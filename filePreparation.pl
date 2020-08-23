use List::Util qw(min max);

$bam1=$ARGV[0];
$threads=$ARGV[2];
$motifFile=$ARGV[1];

`samtools sort -n -@ $threads -O BAM -o $bam1-sortedByName.bam $bam1.bam`;
`bedtools bamtobed -i $bam1-sortedByName.bam -bedpe  > $bam1.bam2bed.txt`;


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

`sort -k1,1 -k2,2n $bam1.bed3 > $bam1.sorted.bed3`;
`mv $bam1.sorted.bed3  $bam1.bed3`;
`rm $bam1.bam2bed.txt $bam1-sortedByName.bam`;
`windowBed -a $motifFile -b $bam1.bed3 -w 1000 > $bam1.input`;
