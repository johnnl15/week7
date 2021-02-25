1) First create prefixes for all of my data. 

```

ls DNAseq2/*1.fq.gz | sed 's/_1.fq.gz//' >prefixes.txt 
ls AdvancedInformatics2021Directory/johnnl15/johnnl15/mydata/ATACseq/rawdata/*R1.fq.gz | sed 's/_R1.fq.gz//' >prefixesATAC.txt 

```

For RNA, since there's so many we'll use some R code. I used your code Dr. Long [RNAfew](RNAfew.R) by inputting our [RNA sample info sheet](RNAseq384_SampleCoding.txt) which generates this file [RNA sample paths](shortRNAseq.names.txt). 

With all of my prefixes made, I then ran the following slurms [DNA](myDNAjob.sh),[RNA](MyRNAjob.sh),[ATAC](MyATACjob.sh). DNA took 2 hours in total with RNA and ATAC taking no more than 10-15 minutes, super quick. 
