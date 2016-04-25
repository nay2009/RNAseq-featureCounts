biocLite("Rsubread")
library(Rsubread)


## Get and export feature counts from aligned BAM files
files <- list.files(pattern = "sorted.bam")
files <- files[-grep("bai", files)]

counts <- featureCounts(files,
                        annot.inbuilt="mm10",
                        useMetaFeatures=FALSE,
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

write.table(x=data.frame(counts$annotation,
                         counts$counts,
                         stringsAsFactors=FALSE),
            file="2-1A-4 Exon Counts.txt",
            quote=FALSE,
            sep="\t",
            row.names=FALSE)



write.table (geneCounts, file="2-1A-4 Raw Counts.txt", sep="\t" )

