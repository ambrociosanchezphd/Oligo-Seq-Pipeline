## Oligo-seq script for performing sequence combination enrichment/depletion analysis.

# The following packages are needed to prepare your sequences for analysis
# Install the following packages and libraries using the <install.packages('PACKAGE NAME')> command
# Load them package using the <library(PACKAGE NAME)> command
library(devtools)
library(Biostrings)
library(stringr)
library(readr)
library(dplyr)
library(mlr3verse)
library(mlr3misc)
library(xlsx)
library(tidyr)

# Read in the list of sequences that were trimmed and exported using the Oligoseq_trim script. 
B5L <- read.table("Trimmed_Sequences.txt")

# Separate your data into two data frame groups:
# 1. Sequences that contain TC and TT
# 2. Sequences that contain TT only
B5L1 <- data.frame(B5L[str_detect(B5L$V1, "^GATAGCTAC...T(C|T)GTAGCAGG$"),])
colnames(B5L1) <- c(1)
B5L2 <- data.frame(B5L[str_detect(B5L$V1, "^GATAGCTAC...TTGTAGCAGG$"),])
colnames(B5L2) <- c(1)

# Convert the sequences in the data frames into character class types.
B5L11 <- as.character(B5L1[,1])
B5L21 <- as.character(B5L2[,1])

# Split every base from every sequence and convert it into a data frame of strings to allow individual counting of bases in the next commands.
B5L12 <- data.frame(str_split_fixed(B5L11, "", width(B5L1[1,])))%>% modify_if(is.character, as.factor)
names(B5L12) <- c("Pos1","Pos2","Pos3","Pos4","Pos5","Pos6","Pos7","Pos8","Pos9","Pos10","Pos11","Pos12","Pos13","Pos14","Pos15","Pos16","Pos17","Pos18","Pos19","Pos20","Pos21","Pos22")
B5L22 <- data.frame(str_split_fixed(B5L21, "", width(B5L1[1,])))%>% modify_if(is.character, as.factor)
names(B5L22) <- c("Pos1","Pos2","Pos3","Pos4","Pos5","Pos6","Pos7","Pos8","Pos9","Pos10","Pos11","Pos12","Pos13","Pos14","Pos15","Pos16","Pos17","Pos18","Pos19","Pos20","Pos21","Pos22")

# Count the number and calculate the frequency of possible nucleotide NNN combinations at the "N" positions in your target oligonucleotide sequence.
tfB5L1 <- B5L12 %>% 
  group_by(Pos10,Pos11,Pos12, .drop = FALSE) %>%
  summarise(n = n()) 
tfB5L1 <- tfB5L1 %>%
  mutate(freq = n/(sum(tfB5L1$n)))

# Count the number and calculate the frequency of possible nucleotide NNN combinations at the "N" positions in your target oligonucleotide sequence.
tfB5L2 <- B5L22 %>% 
  group_by(Pos10,Pos11,Pos12, .drop = FALSE) %>%
  summarise(n = n()) 
tfB5L2 <- tfB5L2 %>%
  mutate (freq = n/(sum(tfB5L2$n)))

# Convert the previous data into data frames
n1 <- as.data.frame(tfB5L1)
n2 <- as.data.frame(tfB5L2)

# Create a new table that contains the enrichment and depletion values of each NNN combination
table1 <- n1 %>% 
  unite(col = "NNN", c("Pos10", "Pos11", "Pos12"), sep ="", remove = TRUE)
table1$n <- NULL
table1$freq <- NULL
table1 <- table1 %>%
  mutate("Frequency Ratio" = n2$freq / n1$freq)

# Change the name of the columns of the previous data frames. 
colnames(n1) <- c("Pos -4", "Pos -3", "Pos -2", "Occurrence", "Frequency")
colnames(n2) <- c("Pos -4", "Pos -3", "Pos -2", "Occurrence", "Frequency")

## Export the data frames into an excel spreadsheet
# This is for record-keeping and to double check all raw numbers output during
# the analysis

# Sheet number 1 contains the enrichment and depletion values to generate a bar plot
write.xlsx2(table1, file = "Oligoseq Enrichment Analysis.xlsx", row.names = FALSE, sheetName = "Enrichment-Depletion")
# Sheet number 2 contains the occurrence and frequency values of NNN combinations in sequences that contain TC and TT
write.xlsx2(n1, file = "Oligoseq Enrichment Analysis.xlsx", row.names = FALSE, sheetName = "All Sequences", append = TRUE)
# Sheet number 3 contains the occurrence and frequency values of NNN combinations in sequences that contain TT only
write.xlsx2(n2, file = "Oligoseq Enrichment Analysis.xlsx", row.names = FALSE, sheetName = "Deaminated Sequences", append = TRUE)
