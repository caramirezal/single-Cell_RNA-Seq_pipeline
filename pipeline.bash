## single cell rna seq data processing workflow

## setting paths
export PATH=$PATH:inst/seqtk/
export PATH=$PATH:inst/TrimGalore-0.4.5/
export PATH=$PATH:inst/FastQC
export PATH=$PATH:inst/bowtie2-2.3.4.3-linux-x86_64/
#export PATH=$PATH:~/.local/bin/cutadapt
#export PATH=$PATH:/usr/local/bin/subread-1.6.3-Linux-x86_64/bin/
 


## subsample fastq files
echo '... seqtk subsampling fastq files ...'
seqtk sample -s3 data/fastq/ERR523111_1.fastq.gz 10 > data/fastq/ERR523111_1_slide.fastq
seqtk sample -s3 data/fastq/ERR523111_2.fastq.gz 10 > data/fastq/ERR523111_2_slide.fastq
echo 'seqtk subsampling finished'

## trimming fastqc
echo '... trim_galore trimming sequencues ...'
trim_galore --nextera --paired data/fastq/E*1_slide.fastq data/fastq/E*1_slide.fastq --trim1 -o data/fastq_processed/
echo 'trim_galore finished'

## quality control 
echo '... fastqc quality control visualization'
fastqc data/fastq_processed/*.fq -o reports/
echo 'fastqc finished'

## alignment
bowtie2 -x data/bowtie2_index/Mus_musculus_GRCm38 --threads 3 --end-to-end --very-fast -1 data/fastq_processed/*1.fq -2 data/fastq_processed/*2.fq -S data/sam/alignment.sam

## sam to bam
#samtools view -Sb data/sam/alignment.sam > data/bam/alignment.bam

## quantification
#featureCounts -Q 30 -p -a data/gtf_reference/Mus_musculus.GRCm38.94.gtf -o data/rna_quant.tsv data/bam/alignment.bam
