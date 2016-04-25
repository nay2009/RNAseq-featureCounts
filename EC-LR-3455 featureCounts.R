library(Rsubread)

## Get and export feature counts from aligned BAM files
counts <- featureCounts(c("EC-LR-3455 ILC2_SI_GF1_sorted.bam",
                          "EC-LR-3455 ILC2_SI_GF2_sorted.bam",
                          "EC-LR-3455 ILC2_SI_GF3_sorted.bam",
                          "EC-LR-3455 ILC2_SI_SPF1_sorted.bam",
                          "EC-LR-3455 ILC2_SI_SPF2_sorted.bam",
                          "EC-LR-3455 ILC2_SI_SPF3_sorted.bam",
                          "EC-LR-3455 ILC3_SI_GF1_sorted.bam",
                          "EC-LR-3455 ILC3_SI_GF2_sorted.bam",
                          "EC-LR-3455 ILC3_SI_GF3_sorted.bam",
                          "EC-LR-3455 ILC3_SI_SPF1_sorted.bam",
                          "EC-LR-3455 ILC3_SI_SPF2_sorted.bam",
                          "EC-LR-3455 ILC3_SI_SPF3_sorted.bam"),
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

write.table(x=data.frame(counts$annotation[,c("GeneID")],
                         counts$counts,
                         stringsAsFactors=FALSE),
            file="counts.txt",
            quote=FALSE,sep="\t",
            row.names=FALSE)

geneCounts <- merge(counts,ConversionList, by="RefSeq", all=FALSE)

write.table (geneCounts, file="EC-LR-3455 Raw Counts.txt", sep="\t" )

