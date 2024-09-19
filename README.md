# Oligo-Seq-Pipeline
The Oligo-seq sequencing analysis pipeline to the accompanying methods paper published by Dr. Pedro Ortega, Ambrocio Sanchez, and Dr. Remi Buisson from the Buisson laboratory.

## Required software

1. Operating system terminal command prompt
2. RStudio (2024)
3. Microsoft Excel

## We subdivided the pipeline into the following sections:

Section 1. Extracting Raw Sequence Reads from the Fastq File(s)

Section 2. Sequence Trimming and Quality Control Filtering

Section 3. Sequence Enrichment and Depletion Analysis

Section 4. Generating a Sequence Logo Plot

Section 5. Generating a Sequence River Plot 

## Example files to follow along with this pipeline.

The following files were used in the accompanying methods paper: 

1. Oligoseq_read1.txt.gz (download here: https://drive.google.com/file/d/1djceocB9oKtbb5zGnbByp0oK-QtWiH2s/view?usp=drive_link)
2. Oligoseq_trim.R
3. Oligoseq_analysis.R
4. Oligoseq_logoplot.R
5. Oligoseq_riverplot.R

## Section 1. Extracting Raw Sequence Reads from the FastQ File(s)

The following steps describe the process of analyzing Oligo-seq sequencing data. These steps require the use of a terminal command line system and specific RStudio scripts that were created for this assay and provided below. Additionally, to illustrate the analysis of the sequencing data, we have provided the sequencing file “Oligoseq_read1.txt.gz,” obtained after sequencing the oligonucleotide target used in this protocol as well as the RStudio scripts used to analyze the sequencing data. The sequencing file and the RStudio scripts can be downloaded at:
https://github.com/ambrociosanchezphd/Oligo-Seq-Pipeline.


Note: There are other pipelines and R commands that can be used to process the data but have not been tested. 

1.	Download and retrieve the zipped (.gz) files that correspond to read 1 and read 2 of your Illumina sequencing sample(s). We will use Oligoseq_read1.txt.gz for our example. 

Note: Only read 1 is necessary to perform all steps described below.

2.	Open your operating system’s terminal command line prompt and unzip read 1 of your sequencing sample using the following command:

    > gunzip Oligoseq_read1.txt.gz

Note: In the code shown above, a MacOS terminal command line system was used.
Note: Depending on the number of reads, the resulting .txt file may take up a large amount of memory space on your operating system.
Note: Depending on the size of the sequencing file, the unzipping process may take a long time to complete.

3.	Extract the raw sequences from the fastq file using the operating system’s terminal command prompt by running the following code:

    > awk ' NR % 4 == 2' Oligoseq_read1.txt > Oligoseq_sequences.txt
    
Note: This command extracts the sequence reads from the fastq file and creates a new file called “Oligoseq_sequences.txt” output into the directory file. High-throughput sequencing files are formatted such that starting from the 2nd line, every 4th line of the file corresponds to a full sequence read. 
Note: Depending on the number of reads, the resulting .txt file may take up a few minutes to be generated.

## Section 2. Sequence Trimming and Quality Control Filtering

4.	Download the R scripts “Oligoseq_trim.R”, “Oligoseq_analysis.R” , “Oligoseq_logoplot.R”, and “Oligoseq_riverplot.R.”

5.	Open the “Oligoseq_trim.R” script in RStudio and set the working directory to the folder containing the “Oligoseq_sequences.txt” file.

6.	Run the “Oligoseq_trim.R” script, and a new text file called “Trimmed_Sequences.txt” will be output into the directory file. 
Note: This file contains all of the sequence reads trimmed by removing the adaptor sequences to select only the sequences corresponding to the target oligonucleotide that will be used in the following analyses. 

## Section 3. Sequence Enrichment and Depletion Analysis

7.	To generate a sequence enrichment/depletion bar graph (Figure 7B)
   a.	Open the “Oligoseq_analysis.R” script in RStudio and set your working directory to the folder containing the “Trimmed_Sequences.txt” file.
   b.	Run “Oligoseq_analysis.R,” and a new Excel file called “Oligoseq Enrichment Analysis.xlsx” will be output into the directory file.
Note: This file contains 3 separate tables. Table 1 displays the enrichment and depletion values for each possible sequence combination in the target oligonucleotide. Table 2 contains the occurrence and frequency values of the possible sequence combinations in sequences that have TC and TT motifs. Table 3 contains the occurrence and frequency values of the possible sequence combinations in sequences that have TT motifs only.
   c.	The values obtained in Table 1 from this analysis can be visualized by creating a bar plot graph on software such as Excel or GraphPad Prism.

## Section 4. Generating a Sequence Logo Plot

57.	To generate a sequence logo plot (Figure 7C),
a.	Open the “Oligoseq_logoplot.R” script in RStudio and set your working directory to the folder containing the “Trimmed_Sequences.txt” file. 
b.	Run “Oligoseq_logoplot.R”  and a new Excel file called “Oligoseq Logo Plot.xlsx” and a pdf file named “Oligoseq Logo Plot.pdf” which contains a publication-ready logo plot will be output into the directory file. 
Note: The “Oligoseq Logo Plot.xlsx” file contains the values used to generate the logo plot graph. 

## Section 5. Generation a River Plot

58.	To generate a river plot (Figure 7D),
a.	Open the “Oligoseq_riverplot.R” script in RStudio and set your working directory to the folder containing the “Trimmed_Sequences.txt” file.
b.	Run “Oligoseq_riverplot.R” and a pdf file called “Oligoseq River Plot.pdf” which contains a publication-ready river plot will be output into the directory file. 

## Acknowledgements 

We would like to thank Dr. Melannie Oakes, Dr. Marcus Seldin 

Any questions/comments regarding the analysis pipeline, please contact either portegam@uci.edu, ambrocis@uci.edu, or rbuisson@uci.edu.
