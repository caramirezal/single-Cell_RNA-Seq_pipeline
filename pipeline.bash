## single cell rna seq data processing workflow

## setting paths
export PATH=$PATH:/usr/local/bin/FastQC
export PATH=$PATH:~/.local/bin/cutadapt
export PATH=$PATH:/usr/local/bin/TrimGalore-0.4.5/
export PATH=$PATH:/usr/local/bin/bowtie2-2.1.0
export PATH=$PATH:/usr/local/bin/subread-1.6.3-Linux-x86_64/bin/
export PATH=$PATH:inst/seqtk/ 


## subsample fastq files
seqtk sample -s3 data/fastq/ERR523111_1.fastq.gz 2 > data/fastq/ERR523111_1_slide.fastq
seqtk sample -s3 data/fastq/ERR523111_2.fastq.gz 2 > data/fastq/ERR523111_2_slide.fastq


## trimming fastqc
trim_galore --nextera data/fastq/ERR523111_*_slide.fastq -o data/fastq_processed/

## quality control  
fastqc data/fastq_processed/*.fastq.gz -o reports/

## alignment
bowtie2 -x data/bowtie2_index/Mus_musculus_GRCm38 --threads 7 --end-to-end --very-fast -1 data/fastq/*_1.fastq.gz -2 data/fastq/*_2.fastq.gz -S data/sam/alignment.sam

## sam to bam
samtools view -Sb data/sam/alignment.sam > data/bam/alignment.bam

## quantification
featureCounts -Q 30 -p -a data/gtf_reference/Mus_musculus.GRCm38.94.gtf -o data/rna_quant.tsv data/bam/alignment.bam
