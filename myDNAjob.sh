#!/bin/bash

#BATCH --job-name=DNAalign      ## Name of the job.
#SBATCH -A ecoevo283         ## account to charge 
#SBATCH -p standard          ## partition/queue name
#SBATCH --array=1-12         ## number of tasks to launch, given hint below wc -l $file is helpful
#SBATCH --cpus-per-task=2    ## number of cores the job needs, can the programs you run make used of multiple cores?

module load bwa/0.7.8
module load samtools/1.10
module load java/1.8.0

# or pass the file name to the shell script, how would I do this?
file="prefixes.txt"
# is the file indexed for bwa?
ref="mydata/ref/dmel-all-chromosome-r6.13.fasta"
dir="AdvancedInformatics2021Directory/johnnl15/johnnl15"
# here is a hint if you had a tab delimited input file
prefix=`head -n $SLURM_ARRAY_TASK_ID  $file | tail -n 1` 
samplename=`echo $prefix | sed -e "s/DNAseq/DNAseqout/"`
idname=`echo $prefix | cut -d "/" -f 4 | cut -d "_" -f 1`

# alignments
bwa mem -t 2 -M $dir/$ref $dir/${prefix}_1.fq.gz $dir/${prefix}_2.fq.gz | samtools view -bS - > $dir/$samplename.bam
samtools sort $dir/$samplename.bam -o $dir/$samplename.sort.bam
# GATK likes readgroups
java -jar  /opt/apps/picard-tools/1.87/AddOrReplaceReadGroups.jar I=$dir/$samplename.sort.bam O=$dir/$samplename.RG.bam SORT_ORDER=coordinate RGPL=illumina RGPU=D109LACXX RGLB=Lib1 RGID=$idname RGSM=$idname VALIDATION_STRINGENCY=LENIENT
samtools index $dir/$samplename.RG.bam

