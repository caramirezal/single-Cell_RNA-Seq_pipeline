## setting paths
export PATH=$PATH:/usr/local/bin/FastQC
export PATH=$PATH:~/.local/bin/cutadapt
export PATH=$PATH:/usr/local/bin/TrimGalore-0.4.5/
export PATH=$PATH:/usr/local/bin/bowtie2-2.1.0


## trimming fastqc
trim_galore --nextera data/fastq/*.fastq.gz -o data/fastqc_processed/ 

## quality control  
fastqc data/fastq_processed/*.fastq.gz -o reports/

## alignment
bowtie2 -x data/bowtie2_index/Mus_musculus_GRCm38 --threads 7 --end-to-end --very-fast -1 data/fastq/*_1.fastq.gz -2 data/fastq/*_2.fastq.gz -S data/sam/alignment.sam

## sam to bam
samtools view -Sb data/sam/alignment.sam > data/bam/alignment.bam

## quantification
featureCounts -Q 30 -p -a data/gtf_reference/Mus_musculus.GRCm38.94.gtf -o data/rna_quant.tsv data/bam/alignment.bam
