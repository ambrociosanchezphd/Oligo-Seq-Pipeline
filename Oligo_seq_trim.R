## Oligo-seq script for extracting, trimming, and aligning raw sequences after of sequencing reads obtained from an Oligo-seq experiment.
## This script will prepare your sequences for subsequent analysis.

# The following packages are needed to prepare your sequences for analysis
# Install the following packages and libraries using the <install.packages('PACKAGE NAME')> command
# Load them package using the <library(PACKAGE NAME)> command
library(devtools)
library(Biostrings)
library(stringr)
library(readr)

# Read in the previously prepared text file containing only the raw reads from the sequencing read file.
RawReads <- read.table("AD18_rawseqs.txt")

# Trim the adaptor sequence from every sequence, allowing for alignment of every sequence.
TrimSeq <- data.frame(word(RawReads$V1,1,sep="AGATCGGAAGAGCACACGTCT"))
colnames(TrimSeq) <- c(1)

TrimSeq <- data.frame(TrimSeq)

# Define the sequence of the target oligonucleotide used in the Oligo-seq experiment.
# A '.' symbol denotes any random letter
# A '|' symbol denotes an OR statement
# A '$' symbol denotes the end of your sequence
# By using the $ symbol, you avoid extracting sequences with additional nucleotides that are a result of sequencing errors.
myoligo <- "GATAGCTAC...T(C|T)GTAGCAGG$"

CleanSeq <- data.frame(TrimSeq[str_detect(TrimSeq$'1', myoligo),])
colnames(CleanSeq) <- c(1)

## Output a text file containing all of the trimmed and aligned sequences, using a line break to separate every row of the data frame.
write_delim(CleanSeq, "Final_Seq_List.txt", "\n")
