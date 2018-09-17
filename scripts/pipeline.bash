## setting paths
export PATH=$PATH:/usr/local/bin/FastQC
export PATH=$PATH:~/.local/bin/cutadapt
export PATH=$PATH:/usr/local/bin/TrimGalore-0.4.5/

## quality control  
fastqc ../data/fastq/ERR1211176_1.fastq.gz -o ../reports/

## trimming results
trim_galore --nextera ../data/fastq/ERR1211176_1.fastq.gz -o ../data/ 
