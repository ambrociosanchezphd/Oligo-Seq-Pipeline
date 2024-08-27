# Oligo-Seq-Pipeline
The Oligo-seq sequencing analysis pipeline to the accompanying methods paper published by Dr. Pedro Ortega, Ambrocio Sanchez, and Dr. Remi Buisson.


## Required software

1. Any operating system terminal
2. RStudio (2020 or newer)
3. Optional: Microsoft Excel or equivalent (for manual statistical analysis)

## We subdivided the pipeline into the following steps:

Step 1. Extracting Raw Sequence Reads from the FastQ File(s)
Step 2. Sequence Trimming and Quality Control Filtering
Step 3. Generating a Sequence Logo Plot
Step 4. Generating a Sequence River Plot
Step 5. Sequence Count and Statistical Analysis

## Example files to follow along with this pipeline.

The following files were used in the accompanying methods paper: 

1. AD18_read1.txt.gz 
2. Oligo_seq_trim_R_script.R
3. Oligo_seq_seq_logo_R_script.R
4. Oligo_seq_river_plot_R_script.R
5. Oligo_seq_statistical_analysis_R_script.R

## Step 1. Extracting Raw Sequence Reads from the FastQ File(s)

Following high-throughput sequencing, the sequence reads are extracted from the fastq files so that they may be used in the subsequent steps. In the code shown here, a MacOS Terminal Command Line system was used. If needed, adjust the code to be compatible with your operating system terminal.

1.	Create a new working directory on your system. Download the sequencing reads file listed above or your own personal sequencing reads file(s), and the associated R scripts to follow along with this pipeline.

Note: Only Read 1 is necessary to perform all steps in this anaylsis pipeline.
Note: A txt file and fastq file extension name is interchangeable and considered the same.

2.	Open your operating system’s terminal command line prompt and unzip the Read 1 sequencing file using the following command:
For MacOS users:

    > gunzip AD18_read1.txt.gz

Note: Depending on the size of the sequencing file, the resulting .txt file may take up large amount of memory space on your operating system.
Note: Depending on the size of the sequencing file, this process may a long time to complete.

3.	Extract the raw sequences from the fastq file using the following terminal line command:
Ror MacOS users:
 
    > awk ‘ NR % 4 == 2 ’ AD18_read1.txt > AD18_seq_only.txt
    
Note: Typically, fasta/q files are formatted such that every 4th line starting from the 2nd line of the file corresponds to a full sequence read.

4.	Proceed to the next section which requires RStudio (2020 or newer) installed on your operating system.

Pause point: Once the raw sequences have been extracted from the fasta/q read file, the next steps can be performed later.



## Acknowledgements 
We would like to thank   


Any questions/comments, please contact sanchez.ambrocio98@gmail.com
