## export variables to environment
export PATH=$PATH:~/.local/bin/cutadapt
export PATH=$PATH:/usr/local/bin/TrimGalore-0.4.5/

trim_galore --nextera ../data/fastq/ERR1211176_1.fastq.gz -o ../data/ 




