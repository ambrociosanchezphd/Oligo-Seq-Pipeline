## Oligo-seq script for generating a sequence logo plot.

# The following packages are needed to prepare your sequences for analysis
# Install the following packages and libraries using the <install.packages('PACKAGE NAME')> command
# Load them package using the <library(PACKAGE NAME)> command
library(devtools)
library(Biostrings)
library(stringr)
library(readr)
library(ggplot2)
library(ggseqlogo)
library(xlsx)

# Read in the list of sequences that were trimmed and exported in the previous script
CleanSeq2 <- read.table("Trimmed_Sequences.txt")
colnames(CleanSeq2) <-c(1)

# Separate your data into two data frame groups:
# 1. Sequences that contain TC and TT
# 2. Sequences that contain TT only
TC2 <- data.frame(CleanSeq2[str_detect(CleanSeq2$'1', "^GATAGCTAC...T(C|T)GTAGCAGG$"),])
colnames(TC2) <- c(1)
TT2 <- data.frame(CleanSeq2[str_detect(CleanSeq2$'1', "^GATAGCTAC...TTGTAGCAGG$"),])
colnames(TT2) <- c(1)

# Obtain the total number of sequences extracted in each function above 
# e.g. total and deaminated
totalTC2 <- nrow(TC2)
totalTT2 <- nrow(TT2)

# Convert sequences to character type for conversion into DNAStringSet
TC21 <- as.character(TC2[,1])
TT22 <- as.character(TT2[,1])

# Convert sequences to DNAStringSet to allow biostrings functions used later
#         e.g. nucleotideFrequenceyAt()
TC211 <- DNAStringSet(TC21)
TT211 <- DNAStringSet(TT22)

## Construct a matrix to compile all the data that will be generated through the analysis steps
DNAFreq<-matrix('',24,width(TT2[1,]))
colnames(DNAFreq)<-c(as.character(-13:8))
rownames(DNAFreq)<-c("A","C","G","T","","A","C","G","T","","A","C","G","T","","A","C","G","T","","A","C","G","T")

# Rows 1-4 correspond to the count of each base (row) at certain position (column) for the total population
# 5th row is a spacer
DNAFreq[1:4,1]<-(nucleotideFrequencyAt(TC211, 1))
DNAFreq[1:4,2]<-(nucleotideFrequencyAt(TC211, 2))
DNAFreq[1:4,3]<-(nucleotideFrequencyAt(TC211, 3))
DNAFreq[1:4,4]<-(nucleotideFrequencyAt(TC211, 4))
DNAFreq[1:4,5]<-(nucleotideFrequencyAt(TC211, 5))
DNAFreq[1:4,6]<-(nucleotideFrequencyAt(TC211, 6))
DNAFreq[1:4,7]<-(nucleotideFrequencyAt(TC211, 7))
DNAFreq[1:4,8]<-(nucleotideFrequencyAt(TC211, 8))
DNAFreq[1:4,9]<-(nucleotideFrequencyAt(TC211, 9))
DNAFreq[1:4,10]<-(nucleotideFrequencyAt(TC211, 10))
DNAFreq[1:4,11]<-(nucleotideFrequencyAt(TC211, 11))
DNAFreq[1:4,12]<-(nucleotideFrequencyAt(TC211, 12))
DNAFreq[1:4,13]<-(nucleotideFrequencyAt(TC211, 13))
DNAFreq[1:4,14]<-(nucleotideFrequencyAt(TC211, 14))
DNAFreq[1:4,15]<-(nucleotideFrequencyAt(TC211, 15))
DNAFreq[1:4,16]<-(nucleotideFrequencyAt(TC211, 16))
DNAFreq[1:4,17]<-(nucleotideFrequencyAt(TC211, 17))
DNAFreq[1:4,18]<-(nucleotideFrequencyAt(TC211, 18))
DNAFreq[1:4,19]<-(nucleotideFrequencyAt(TC211, 19))
DNAFreq[1:4,20]<-(nucleotideFrequencyAt(TC211, 20))
DNAFreq[1:4,21]<-(nucleotideFrequencyAt(TC211, 21))
DNAFreq[1:4,22]<-(nucleotideFrequencyAt(TC211, 22))

# Rows 6-9 correspond to the count of each base (row) at certain position (column) for the *deaminated* sequences
# 10th row is a spacer
DNAFreq[6:9,1]<-(nucleotideFrequencyAt(TT211, 1))
DNAFreq[6:9,2]<-(nucleotideFrequencyAt(TT211, 2))
DNAFreq[6:9,3]<-(nucleotideFrequencyAt(TT211, 3))
DNAFreq[6:9,4]<-(nucleotideFrequencyAt(TT211, 4))
DNAFreq[6:9,5]<-(nucleotideFrequencyAt(TT211, 5))
DNAFreq[6:9,6]<-(nucleotideFrequencyAt(TT211, 6))
DNAFreq[6:9,7]<-(nucleotideFrequencyAt(TT211, 7))
DNAFreq[6:9,8]<-(nucleotideFrequencyAt(TT211, 8))
DNAFreq[6:9,9]<-(nucleotideFrequencyAt(TT211, 9))
DNAFreq[6:9,10]<-(nucleotideFrequencyAt(TT211, 10))
DNAFreq[6:9,11]<-(nucleotideFrequencyAt(TT211, 11))
DNAFreq[6:9,12]<-(nucleotideFrequencyAt(TT211, 12))
DNAFreq[6:9,13]<-(nucleotideFrequencyAt(TT211, 13))
DNAFreq[6:9,14]<-(nucleotideFrequencyAt(TT211, 14))
DNAFreq[6:9,15]<-(nucleotideFrequencyAt(TT211, 15))
DNAFreq[6:9,16]<-(nucleotideFrequencyAt(TT211, 16))
DNAFreq[6:9,17]<-(nucleotideFrequencyAt(TT211, 17))
DNAFreq[6:9,18]<-(nucleotideFrequencyAt(TT211, 18))
DNAFreq[6:9,19]<-(nucleotideFrequencyAt(TT211, 19))
DNAFreq[6:9,20]<-(nucleotideFrequencyAt(TT211, 20))
DNAFreq[6:9,21]<-(nucleotideFrequencyAt(TT211, 21))
DNAFreq[6:9,22]<-(nucleotideFrequencyAt(TT211, 22))

# Rows 11-14 correspond to the ratio of counts in rows 1-4 relative to the total number of sequences in the total population
# 15th row is a spacer
DNAFreq[11:14,1]<-(nucleotideFrequencyAt(TC211, 1))/totalTC2
DNAFreq[11:14,2]<-(nucleotideFrequencyAt(TC211, 2))/totalTC2
DNAFreq[11:14,3]<-(nucleotideFrequencyAt(TC211, 3))/totalTC2
DNAFreq[11:14,4]<-(nucleotideFrequencyAt(TC211, 4))/totalTC2
DNAFreq[11:14,5]<-(nucleotideFrequencyAt(TC211, 5))/totalTC2
DNAFreq[11:14,6]<-(nucleotideFrequencyAt(TC211, 6))/totalTC2
DNAFreq[11:14,7]<-(nucleotideFrequencyAt(TC211, 7))/totalTC2
DNAFreq[11:14,8]<-(nucleotideFrequencyAt(TC211, 8))/totalTC2
DNAFreq[11:14,9]<-(nucleotideFrequencyAt(TC211, 9))/totalTC2
DNAFreq[11:14,10]<-(nucleotideFrequencyAt(TC211, 10))/totalTC2
DNAFreq[11:14,11]<-(nucleotideFrequencyAt(TC211, 11))/totalTC2
DNAFreq[11:14,12]<-(nucleotideFrequencyAt(TC211, 12))/totalTC2
DNAFreq[11:14,13]<-(nucleotideFrequencyAt(TC211, 13))/totalTC2
DNAFreq[11:14,14]<-(nucleotideFrequencyAt(TC211, 14))/totalTC2
DNAFreq[11:14,15]<-(nucleotideFrequencyAt(TC211, 15))/totalTC2
DNAFreq[11:14,16]<-(nucleotideFrequencyAt(TC211, 16))/totalTC2
DNAFreq[11:14,17]<-(nucleotideFrequencyAt(TC211, 17))/totalTC2
DNAFreq[11:14,18]<-(nucleotideFrequencyAt(TC211, 18))/totalTC2
DNAFreq[11:14,19]<-(nucleotideFrequencyAt(TC211, 19))/totalTC2
DNAFreq[11:14,20]<-(nucleotideFrequencyAt(TC211, 20))/totalTC2
DNAFreq[11:14,21]<-(nucleotideFrequencyAt(TC211, 21))/totalTC2
DNAFreq[11:14,22]<-(nucleotideFrequencyAt(TC211, 22))/totalTC2

# Rows 16-19 correspond to the ratio of counts in rows 6-9 relative to the total number of sequences in the deaminated population
# 20th row is a spacer
DNAFreq[16:19,1]<-(nucleotideFrequencyAt(TT211, 1))/totalTT2
DNAFreq[16:19,2]<-(nucleotideFrequencyAt(TT211, 2))/totalTT2
DNAFreq[16:19,3]<-(nucleotideFrequencyAt(TT211, 3))/totalTT2
DNAFreq[16:19,4]<-(nucleotideFrequencyAt(TT211, 4))/totalTT2
DNAFreq[16:19,5]<-(nucleotideFrequencyAt(TT211, 5))/totalTT2
DNAFreq[16:19,6]<-(nucleotideFrequencyAt(TT211, 6))/totalTT2
DNAFreq[16:19,7]<-(nucleotideFrequencyAt(TT211, 7))/totalTT2
DNAFreq[16:19,8]<-(nucleotideFrequencyAt(TT211, 8))/totalTT2
DNAFreq[16:19,9]<-(nucleotideFrequencyAt(TT211, 9))/totalTT2
DNAFreq[16:19,10]<-(nucleotideFrequencyAt(TT211, 10))/totalTT2
DNAFreq[16:19,11]<-(nucleotideFrequencyAt(TT211, 11))/totalTT2
DNAFreq[16:19,12]<-(nucleotideFrequencyAt(TT211, 12))/totalTT2
DNAFreq[16:19,13]<-(nucleotideFrequencyAt(TT211, 13))/totalTT2
DNAFreq[16:19,14]<-(nucleotideFrequencyAt(TT211, 14))/totalTT2
DNAFreq[16:19,15]<-(nucleotideFrequencyAt(TT211, 15))/totalTT2
DNAFreq[16:19,16]<-(nucleotideFrequencyAt(TT211, 16))/totalTT2
DNAFreq[16:19,17]<-(nucleotideFrequencyAt(TT211, 17))/totalTT2
DNAFreq[16:19,18]<-(nucleotideFrequencyAt(TT211, 18))/totalTT2
DNAFreq[16:19,19]<-(nucleotideFrequencyAt(TT211, 19))/totalTT2
DNAFreq[16:19,20]<-(nucleotideFrequencyAt(TT211, 20))/totalTT2
DNAFreq[16:19,21]<-(nucleotideFrequencyAt(TT211, 21))/totalTT2
DNAFreq[16:19,22]<-(nucleotideFrequencyAt(TT211, 22))/totalTT2

# Rows 21-24 correspond the calculation of enrichment of each base at each position using the formula:
# ratio of deaminated sequences / ratio of total population and normalized to 1
# for the purpose of this analysis it will be [(rows 16-19) / (rows 11-14)] - 1
DNAFreq[21:24,]<-0
DNAFreq[21:24,10] <- (as.numeric(DNAFreq[16:19,10])/as.numeric(DNAFreq[11:14,10]))-1
DNAFreq[21:24,11] <- (as.numeric(DNAFreq[16:19,11])/as.numeric(DNAFreq[11:14,11]))-1
DNAFreq[21:24,12] <- (as.numeric(DNAFreq[16:19,12])/as.numeric(DNAFreq[11:14,12]))-1


## This code pertains to the creation of the sequence logo plots used in the figures
# uses ggseqlogo package developed by Wagih, Omar for more details on specific lines 
# of code please refer to:
# https://omarwagih.github.io/ggseqlogo/

NewSeqLogo <- ggseqlogo(DNAFreq[21:24,], method='custom', seq_type='dna') +
  ylab('') +
  theme_logo() +
  xlab('Position') +
  annotate('rect', xmin=1, xmax=23, ymin=0, ymax=0, alpha=0.1, col='black', fill='yellow') +
  theme(
    axis.ticks = element_line(size = 0.5, color = "black"),
    axis.ticks.length = unit(.25, "cm"),
    axis.line = element_line(size = 0.5, colour = "black", linetype = 1)
  ) +
  coord_cartesian(ylim = c(-1.25, 1)) +  # Adjust y-axis limits to accommodate the adjusted data
  coord_cartesian(xlim = c(1, 22)) +
  scale_x_continuous(
    breaks = seq(1, 22, by = 1),
    labels = c("-13", "-12", "-11", "-10", "-9", "-8", "-7", "-6", "-5", "-4", "-3", "-2", "-1", "0", "+1", "+2", "+3", "+4", "+5", "+6", "+7", "+8")
  ) +
  scale_y_continuous(
    breaks = seq(-2, 2, by = 1),
    labels = function(y) as.character(y + 1)  # Adjust y-axis labels to reflect the original values
  )
plot(NewSeqLogo)


pdf(file="Oligo-seq Sequence Logo Plot.pdf",width=9,height=5.25)
print(NewSeqLogo)
dev.off()

## Exports the DNAFreq table into an excel spreadsheet
# This is for record-keeping and to double check all raw numbers output during
# the analysis
write.xlsx2(DNAFreq, file = "Oligoseq Logo Plot.xlsx", row.names = TRUE, sheetName = "Sequence Logo Data")

