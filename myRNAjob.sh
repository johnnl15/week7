#!/bin/bash

#BATCH --job-name=RNAalign      ## Name of the job.
#SBATCH -A ecoevo283         ## account to charge 
#SBATCH -p standard          ## partition/queue name
#SBATCH --array=1-20         ## number of tasks to launch, given hint below wc -l $file is helpful
#SBATCH --cpus-per-task=2    ## number of cores the job needs, can the programs you run make used of multiple cores?

module load samtools/1.10
module load hisat2/2.2.1

# or pass the file name to the shell script, how would I do this?
file="shortRNAseq.names.txt"
# is the file indexed for bwa?
ref="mydata/ref/dmel-all-chromosome-r6.13.fasta"
dir="AdvancedInformatics2021Directory/johnnl15/johnnl15"
# here is a hint if you had a tab delimited input file
prefix=`head -n $SLURM_ARRAY_TASK_ID  $file | tail -n 1` 
samplename=`echo $prefix | sed -e "s/RNAseq/RNAseqout/"`

hisat2 -p 2 -x $dir/$ref -1 ${prefix}_R1_fq.gz -2 ${prefix}_R2_fq.gz | samtools view -bS > $samplename.bam
samtools sort $samplename.bam -o $samplename.sorted.bam
samtools index $samplename.sorted.bam

