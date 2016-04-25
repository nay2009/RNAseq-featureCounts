## source("https://bioconductor.org/biocLite.R")
## biocLite("Rsubread")

library(Rsubread)

setwd("/Volumes/IBD/Yudanin/RNAseq/3-1A-3 RNAseq/3-1A-3 Aligned Files")
files <- list.files(pattern = "sorted.bam")
files <- files[-grep("bai", files)]

## Get and export feature counts from aligned BAM files
counts <- featureCounts(files,
              annot.inbuilt="mm10",
              useMetaFeatures=TRUE,
              allowMultiOverlap=FALSE,
              isPairedEnd=FALSE,
              requireBothEndsMapped=FALSE,
              checkFragLength=FALSE,
              minFragLength=50,
              maxFragLength=600,
              nthreads=1,
              strandSpecific=0,
              minMQS=0,
              readExtension5=0,
              readExtension3=0,
              read2pos=NULL,
              minOverlap=1,
              countMultiMappingReads=FALSE,
              countChimericFragments=TRUE,
              ignoreDup=FALSE,
              chrAliases=NULL,
              reportReads=FALSE)

save.image("/Volumes/IBD/Yudanin/RNAseq/3-1A-3 RNAseq/3-1A-3 Aligned Files/3-1A-3 featureCounts.RData")

write.table(x=data.frame(counts$annotation[,c("GeneID")],
                         counts$counts,
                         stringsAsFactors=FALSE),
            file="3-1A-3 Raw Counts.txt",
            quote=FALSE,sep="\t",
            row.names=FALSE)


Entrez2Symbol <- read.delim("/Volumes/IBD/Yudanin/RNAseq/EC-SM-3509 RNAseq/EC-SM-3509 Raw Counts/Entrez2Symbol.txt", stringsAsFactors=FALSE)
geneCounts <- merge(Entrez2Symbol, counts, by="GeneID", all=FALSE)
write.table (geneCounts, file="3-1A-3 Raw Counts.txt", sep="\t" )

