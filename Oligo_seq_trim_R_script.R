## Script for extracting, trimming, and aligning raw sequences after Oligo-seq experiment.
## This script will prepare your sequences for subsequent analysis in the next script.

# The following packages are needed to prepare your sequences for analysis
# Install the following packages and libraries using the <install.packages('PACKAGE NAME')> command
# Load them package using the <library(PACKAGE NAME)> command
library(devtools)
library(Biostrings)
library(stringr)
library(readr)

## Preparing Raw Reads for Analysis: Selecting, Shifting, & Trimming.
# Change the working directory to the location of the raw reads text file

# Read in the prepared text file containing only the raw sequences from the sequencer.
RawReads <- read.table("AD18rawseq.txt")

# Calculate the number of sequences in your raw reads text file.
NumofSeq <- nrow(RawReads)

# Trim the adaptor sequence from every sequence, allowing for alignement and quantification of only your sequence used in Oligo-seq.
# Note that trimmed sequences are a 'character' class vector.
TrimSeq <- word(RawReads$V1,1,sep="AGATCGGAAGAGCACACGTCT")
colnames(TrimSeq) <- c(1)

TableTrimSeq <- data.frame(TrimSeq)

# Define the sequence of the oligonucleotide used in your Oligo-seq experiment.
# A '.' symbol denotes any random letter
# A '$' symbol denotes the end of your sequence
# Note that 
# By using the $ symbol, you avoid extracting sequences with additional nucleotides that are a result of sequencing errors.
myoligo <- "GATAGCTAC...T.GTAGCAGG$"

CleanSeq <- data.frame(TableTrimSeq[str_detect(TableTrimSeq$TrimSeq, myoligo),])
colnames(CleanSeq) <- c(1)

## Output a text file containing all of the trimmed and aligned sequences, using a line break to separate every row of the data frame.
write_delim(CleanSeq, "FinalSeqList.txt", "\n")
