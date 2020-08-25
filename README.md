# cutfrequency
	Simple script to calculate cut frequency from BAM files (pair-end reads): greenCUT&RUN or CUT&RUN protocol

REQUIREMENTS:

	Samtools
	Bedtools
	R, optparse, data.table. svMisc
	perl, List::Util
	Linux/Unix operating system


USAGE:

	Rscript run.R [options]

Options:
	
	-a CHARACTER, --bam1=CHARACTER
		name of bam file: experiment (without .bam extension)

	-b CHARACTER, --bam2=CHARACTER
		name of bam file: control (without .bam extension)

	-c CHARACTER, --bam3=CHARACTER
		name of bam file - spikeIn: experiment (without .bam extension)

	-d CHARACTER, --bam4=CHARACTER
		name of bam file - spikeIn: control (without .bam extension)

	-m CHARACTER, --motifFile=CHARACTER
		File having location of motif; generated by Homer

	-x NUMERIC, --centreOfmotif=NUMERIC
		Desired centre of motif on positive DNA strand

	-s CHARACTER, --script_folder=CHARACTER
		Folder location with other assessory scripts of this tool

	-n NUMERIC, --thread=NUMERIC
		Number of thread

	-h, --help
		Show this help message and exit

EXAMPLE:

	Rscript ./run.R -a ./example/experiment -b ./example/control -c ./example/SpikeIn-experiment -d ./example/SpikeIn-control  -m ./example/FOS-motifs.txt -x 7 --script_folder ./ -n 20 

OUTPUT:

	experiment.bed3 - Genomic coordinates of the pair-end reads
	experiment.input - Experiment's read overlapping with motifs
	control.bed3 - Genomic coordinates of the pair-end reads
	control.input - Control's read overlapping with motifs
	SpikeIn-experiment.bed3 - Genomic coordinates of the pair-end reads. For counting Spike-In reads in the experiment.
	SpikeIn-control.bed3 - Genomic coordinates of the pair-end reads. For counting Spike-In reads in the control.
	control.counts.txt: Count of read ends for each motif's location. -100 to 100 bps from centre of motif 
	experiment.counts.txt:  Count of read ends for each motif's location. -100 to 100 bps from centre of motif 
	experiment.normalize.txt: Spike-in normalized read ends in experiment compare to control, for each motif's location. -100 to 100 bps from centre of motif 
	experiment.cutfrequency.txt: Cutfrquency at each location from -100 to 100
	experiment.jpeg: visualization

