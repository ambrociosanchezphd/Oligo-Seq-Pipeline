# Oligo-Seq-Pipeline
The Oligo-seq sequencing analysis pipeline to the accompanying methods paper published by Dr. Pedro Ortega, Ambrocio Sanchez, and Dr. Remi Buisson.

## Required software

1. Any operating system terminal
2. RStudio
3. Optional: Microsoft Excel or equivalent (for manual statistical analysis)

## We subdivided the pipeline into the following steps:

Step 1. Extracting Raw Sequence Reads from the Fastq File(s)
Step 2. Sequence Trimming and Quality Control Filtering
Step 3. Sequence Count and Statistical Analysis
Step 4. Generating a Sequence Logo Plot
Step 5. Generating a Sequence River Plot 

## Example files to follow along with this pipeline.

The following files were used in the accompanying methods paper: 

1. AD18_read1.txt.gz (donwload here: https://drive.google.com/file/d/1djceocB9oKtbb5zGnbByp0oK-QtWiH2s/view?usp=drive_link)
2. Oligo_seq_trim.R
3. Oligo_seq_seq_analysis.R
4. Oligo_seq_seq_logo.R
5. Oligo_seq_river.R

## Step 1. Extracting Raw Sequence Reads from the FastQ File(s)

The series of steps required to process Oligo-seq sequencing data require the usage of a terminal command line system and specific RStudio scripts that were created for this protocol and provided below. Additionally, we have provided a copy of our sequencing file “AD18_read1.txt.gz” to follow along. 

Note: There are other pipelines and R commands that can be used to process the data but have not been tested. 

1.	Download and retrieve the zipped (.gz) files that correspond to read 1 and read 2 of your Illumina sequencing sample(s). We will use AD18_read1.txt.gz for our example. 

Note: Only read 1 is necessary to perform all steps described below.

2.	Open your operating system’s terminal command line prompt and unzip read 1 of your sequencing sample using the following command:

    > gunzip AD18_read1.txt.gz

Note: In the code shown above, a MacOS terminal command line system was used.
Note: Depending on the number of reads, the resulting .txt file may take up a large amount of memory space on your operating system.
Note: Depending on the size of the sequencing file, the unzipping process may take a long time to complete.

3.	Extract the raw sequences from the txt/fastq file using the following command:

    > awk ' NR % 4 == 2' AD18_read1.txt > AD18_rawseqs.txt
    
Note: Typically, high-throughput sequencing files are formatted such that every 4th line starting from the 2nd line of the file corresponds to a full sequence read.

Pause point: Once the raw sequences have been extracted you may repeat the process for other samples while making sure that the file names are changed accordingly. The next steps can be performed at any time after.

## Step 2. Sequence Trimming and Quality Control Filtering

4.	Navigate to the repository https://github.com/ambrociosanchezphd/Oligo-Seq-Pipeline to obtain the R scripts necessary to 1) trim and filter the previously extracted sequences, 2) conduct the sequence enrichment and depletion analysis 3) generate a sequence logo plot, and 4) generate a river plot.

5.	Open the “Oligo_seq_trim.R” script and set your working directory to the folder of the text file obtained in step 56.

6.	Source or run the script and a new text file called “Final_Seq_List.txt” will be output into your directory. This new file will contain a list of all the sequence reads that were trimmed and aligned. The sequences in the new file will be used for subsequent data processing.

Pause point: Once the extracted sequences have been trimmed and aligned, you may repeat the process for other samples while making sure that the file names are changed accordingly. The next steps can be performed at any time after.

## Step 3. Sequence Count and Statistical Analysis

7.	Open the “Oligo_seq_seq_analysis.R” script and set your working directory to the folder of the text file obtained in step 59. 

8.	Source or run the script and a new csv file called “Sequqnece_Enrichment_Analysis.csv” will be output into your working directory. This csv file contains the enrichment and depletion analysis of all possible sequence combinations after deamination of your target oligonucleotide sequence. The purpose of this analysis is to create a bar plot to visualize the enrichment and depletion of all possible sequence combinations after deamination.

Pause point: Once the sequence enrichment analysis has been completed, you may repeat the process for other samples while making sure that the file names are changed accordingly. The next steps can be performed at any time after.

## Step 4. Generating a Sequence Logo Plot

9.	Open the “Oligo_seq_seq_logo.R” script and set your working directory to the folder contianing text file obtained in step 59.

10.	Source or run the script and a new csv file called “DNAFreq.csv” will be output into your working directory. Also, a preview of the sequence logo plots will open in the “plots” viewer window of RStudio. The csv file contains the enrichment and depletion analysis of all possible sequence combinations after deamination of your target oligonucleotide sequence. Additionally, two PDF files called “Oligo-seq Sequence Logo Plot-Target Sequence Only.pdf” and “Oligo-seq Sequence Logo Plot-Deaminated Sequence Enrichment and Depletion”.pdf will be output into your working directory. The PDF files of the sequence logo plots are publication-ready and can be used at your discretion. 

Pause point: Once the sequence logo has been generated, you may repeat the process for other samples while making sure that the file names are changed accordingly. The next steps can be performed at any time after.

## Step 5. Generating a Sequence River Plot 

11.	Open the “Oligo_seq_river_plot.R” script and set your working directory to the folder containing the text file obtained in step 59.

12.	Source or run the script and a preview of the river plot will open in the “plots” viewer window of RStudio. Additionally, a PDF file called “Oligo-seq River Plot.pdf” will be output into your working directory. The PDF file of the river plot is publication-ready and can be used at your discretion.

## Acknowledgements 

We would like to thank   

Any questions/comments regarding the analysis pipeline, please contact sanchez.ambrocio98@gmail.com
