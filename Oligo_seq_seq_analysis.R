## Oligo-seq script for performing sequence combination analysis.

# The following packages are needed to prepare your sequences for analysis
# Install the following packages, if needed, and load them.
library(devtools)
library(Biostrings)
library(stringr)
library(readr)
library(dplyr)
library(mlr3verse)
library(mlr3misc)

# Read in the list of sequences that were trimmed and aligned in the previous script. 
B5L <- read.table("Final_Seq_List.txt")

# Separate your data into two data frame groups:
# 1. Sequences that were deaminated and non-deaminated
# 2. Sequences that were deaminated only
B5L1 <- data.frame(B5L[str_detect(B5L$V1, "^GATAGCTAC...T(C|T)GTAGCAGG$"),])
colnames(B5L1) <- c(1)
B5L2 <- data.frame(B5L[str_detect(B5L$V1, "^GATAGCTAC...TTGTAGCAGG$"),])
colnames(B5L2) <- c(1)

# Convert the sequences in the data frames into character class types.
B5L11 <- as.character(B5L1[,1])
B5L21 <- as.character(B5L2[,1])

# Split every base from every sequence and convert it into a data frame to allow individual counting of bases in the next commands.
B5L12 <- data.frame(str_split_fixed(B5L11, "", width(B5L1[1,])))%>% modify_if(is.character, as.factor)
names(B5L12) <- c("Pos1","Pos2","Pos3","Pos4","Pos5","Pos6","Pos7","Pos8","Pos9","Pos10","Pos11","Pos12","Pos13","Pos14","Pos15","Pos16","Pos17","Pos18","Pos19","Pos20","Pos21","Pos22")
B5L22 <- data.frame(str_split_fixed(B5L21, "", width(B5L1[1,])))%>% modify_if(is.character, as.factor)
names(B5L22) <- c("Pos1","Pos2","Pos3","Pos4","Pos5","Pos6","Pos7","Pos8","Pos9","Pos10","Pos11","Pos12","Pos13","Pos14","Pos15","Pos16","Pos17","Pos18","Pos19","Pos20","Pos21","Pos22")

# Count the number and calculate the frequency of possible nucleotide combinations at the "N" positions in your target oligonucleotide sequence.
tfB5L1 <- B5L12 %>% 
  group_by(Pos10,Pos11,Pos12, .drop = FALSE) %>%
  summarise(n = n()) 
tfB5L1 <- tfB5L1 %>%
  mutate(freq = n/(sum(tfB5L1$n)))

# Count the number and calculate the frequency of possible nucleotide combinations at the "N" positions in your target oligonucleotide sequence.
tfB5L2 <- B5L22 %>% 
  group_by(Pos10,Pos11,Pos12, .drop = FALSE) %>%
  summarise(n = n()) 
tfB5L2 <- tfB5L2 %>%
  mutate (freq = n/(sum(tfB5L2$n)))

# Divide the frequency of nucleotide combinations found in the deaminated samples by the frequency of nucleotide combinations found in the total population represented by non-deaminated and deaminated sequences.
f6 <- (tfB5L2$freq/tfB5L1$freq)
f61 <- f6-1

n1 <- as.data.frame(tfB5L1)
n2 <- as.data.frame(tfB5L2)

# Create a new table to compile all of the data obtained during the sequence analysis.
# Columns 1:5 correspond to the possible sequences combinations that are non-deaminated and deaminated (total population)
# Columns 6:10 correspond to the possible sequence combinations that are deaminated only
# Columns 11:12 are basic math functions to calculate enrcichment and depletion of each sequence combination
SeqComp <- cbind(n1,n2,f6,f61)
colnames(SeqComp) <- c("Pos10","Pos11","Pos12","N","Freq","Pos10","Pos11","Pos12","N","Freq","DeaminatedFreq/TotalFreq","Normalized")

## Exports the SeqComp table into a spreadsheet
# This is for record-keeping and to double check all raw numbers output during
# the analysis
write.csv(SeqComp, "Sequence_Enrichment_Analysis.csv")