mycurrentdirectory = dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(mycurrentdirectory)

RNAseq384_SampleCoding <- read.delim("~/Documents/ee283/RNAseq384_SampleCoding.txt")

mytab<- RNAseq384_SampleCoding
mytab2 = mytab[,9:12]
# select a subset of samples
mytab3 = mytab2[c(1:10,93:102),]
# rearrange and drop another column
mytab4 = mytab3[,c(4,1,2)]

if (file.exists("shortRNAseq.names.txt")) {file.remove("shortRNAseq.names.txt")}
for(i in 1:nrow(mytab4)){
  cat("RNAseq/bam/",mytab4$FullSampleName[i],".bam\n",file="shortRNAseq.names.txt",append=TRUE,sep='')
}
write.table(mytab4,"shortRNAseq.txt")
