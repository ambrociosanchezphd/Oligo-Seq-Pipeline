## Oligo-seq script for extracting, trimming, and aligning raw sequences after of sequencing reads obtained from an Oligo-seq experiment.
## This script will prepare your sequences for subsequent analysis.

# The following packages are needed to prepare your sequences for analysis
library(devtools)
library(Biostrings)
library(stringr)
library(readr)

# Read in the previously prepared text file containing only the raw reads from the sequencing read file.
RawReads <- read.table("Oligoseq_sequences.fq")

# Trim each sequence to remove the adaptor sequence and any bases after.
TrimSeq <- data.frame(word(RawReads$V1,1,sep="AGATCGGAAGAGCACACGTCT"))
colnames(TrimSeq) <- c('Sequences')

# Define the sequence of the target oligonucleotide used in the Oligo-seq experiment.
# A '.' symbol denotes any random letter
# A '|' symbol denotes an OR statement
# A '$' symbol denotes the end of your sequence
# By using the $ symbol, you avoid extracting sequences with additional nucleotides that are a result of sequencing errors.
myoligo <- "GATAGCTAC...T(C|T)GTAGCAGG$"

# Extract all sequences that contain the correct full sequence of the target oligonucleotide.
CleanSeq <- data.frame(TrimSeq[str_detect(TrimSeq$'Sequences', myoligo),])
colnames(CleanSeq) <- c('Sequences')

## Output a text file containing all of the trimmed and aligned sequences, using a line break to separate every row of the data frame.
write_delim(CleanSeq, "Trimmed_Sequences.fq", "\n")
