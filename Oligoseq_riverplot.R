## Oligo-seq script for generating a River Plot.

# The following packages are needed to prepare your sequences for analysis
library(devtools)
library(Biostrings)
library(stringr)
library(readr)
library(ggalluvial)
library(dplyr)
library(mlr3verse)
library(mlr3misc)

# Read in the list of sequences that were trimmed and exported in the previous script 
B5L <- read.table("Trimmed_Sequences.fq")

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

# Split every base from every sequence and convert it into a data frame to allow individual counting of bases in the next commands.
B5L12 <- data.frame(str_split_fixed(B5L11, "", width(B5L1[1,])))%>% modify_if(is.character, as.factor)
B5L22 <- data.frame(str_split_fixed(B5L21, "", width(B5L1[1,])))%>% modify_if(is.character, as.factor)

names(B5L12) <- c("Pos -13","Pos -12","Pos -11","Pos -10","Pos -9","Pos -8","Pos -7","Pos -6","Pos -5","Pos -4","Pos -3","Pos -2","Pos -1","Pos 0","Pos 1","Pos 2","Pos 3","Pos 4","Pos 5","Pos 6","Pos 7","Pos 8")
names(B5L22) <- c("Pos -13","Pos -12","Pos -11","Pos -10","Pos -9","Pos -8","Pos -7","Pos -6","Pos -5","Pos -4","Pos -3","Pos -2","Pos -1","Pos 0","Pos 1","Pos 2","Pos 3","Pos 4","Pos 5","Pos 6","Pos 7","Pos 8")


# Count the number and calculate the frequency of possible nucleotide combinations at the "N" positions in your target oligonucleotide sequence.
fB5L1 <- B5L12 %>% 
  group_by(`Pos -4`, `Pos -3`, `Pos -2`, `Pos -1`, .drop = FALSE) %>%
  summarise(n = n()) 
fB5L1 <- fB5L1 %>%
  mutate(freq = n / (sum(fB5L1$n)))

# Count the number and calculate the frequency of possible nucleotide combinations at the "N" positions in your target oligonucleotide sequence.
fB5L2 <- B5L22 %>% 
  group_by(`Pos -4`, `Pos -3`, `Pos -2`, `Pos -1`, `Pos 0`, .drop = FALSE) %>%
  summarise(n = n()) 
fB5L2 <- fB5L2 %>%
  mutate(freq = n / (sum(fB5L2$n)))


# Divide the frequency of nucleotide combinations found in the deaminated samples by the frequency of nucleotide combinations found in the total population represented by non-deaminated and deaminated sequences.
f6 <- (fB5L2$freq/fB5L1$freq)

# Create a table of the possible nucleotide frequencies
f66 <- fB5L2[,1:(length(fB5L2)-2)] 

# Replace the last column with C > T to indicate the targeted cytosine.
f66[,length(f66)] <- "C>T"

# Set a color palette for each individual base
colorfill <- c("A" = "palegreen3", "C" = "cyan3", "G"="lightgoldenrod", "T"="indianred2", "C>T" = "red")

# The following set of commands creates the desired River plot
# Adjust as needed
pB5L <- data.frame(to_lodes_form(f66),
                   n = f6)
pB5L1 <- ggplot(pB5L, aes(
  x = x,
  stratum = stratum,
  alluvium = alluvium,
  y = n
)) + 
  geom_flow(aes(fill = stratum), width = 1/12) +
  geom_stratum(aes(fill=stratum), width = 0.2, discern = FALSE)+
  theme(
    panel.background = element_blank(),
    axis.text.y = element_blank(),
    axis.text.x = element_text(size = 10, face = "bold"),
    axis.title = element_blank(),
    axis.ticks = element_blank(),
    legend.position = "none")+
  scale_fill_manual(values = colorfill) +
  
  ggtitle("A3B 5 Loop Hairpin") +
  geom_text(stat = "stratum", color = "black", fontface = "bold", aes(label = after_stat(stratum)))
plot(pB5L1)

# Output the river plot into a pdf file
pdf(file="Oligoseq River Plot.pdf",width=9,height=5.25)
print(pB5L1)
dev.off()
