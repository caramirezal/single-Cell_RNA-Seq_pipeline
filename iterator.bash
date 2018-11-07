## setting paths
export PATH=$PATH:inst/seqtk/
export PATH=$PATH:inst/TrimGalore-0.4.5/
export PATH=$PATH:inst/FastQC
export PATH=$PATH:inst/bowtie2-2.3.4.3-linux-x86_64/
export PATH=$PATH:inst/subread-1.6.3-Linux-x86_64/bin/
##export PATH=$PATH:~/.local/bin/cutadapt
 

## Trimming sequences
#for filename in data/fastq/*1.fastq.gz; do
	######################################################################################################
	## fastq Subsampling 
	#echo "... seqtk subsampling $filename"
	#seqtk sample -s3 "$filename" 10 > "${filename/1.fastq.gz/slide_1.fastq}"
	#echo "Writting random samples to ${filename/1.fastq.gz/slide_1.fastq}"

	#echo "... seqtk subsampling ${filename/1.fastq.gz/2.fastq.gz}"
	#seqtk sample -s3 "${filename/1.fastq.gz/2.fastq.gz}" 10 > "${filename/1.fastq.gz/slide_2.fastq}"
	#echo "Writting random samples to ${filename/1.fastq.gz/slide_2.fastq}"
	#echo 'seqtk subsampling finished'
        #######################################################################################################

	#######################################################################################################
	## trimming fastqc
	#echo '... trim_galore trimming sequencues ...'
	#trim_galore --nextera \
        #            --paired "${filename/1.fastq.gz/slide_1.fastq}" "${filename/1.fastq.gz/slide_2.fastq}" \
        #            --trim1 -o data/fastq_processed/
	#echo 'trim_galore finished'
        ######################################################################################################
#done



## Fastq base call quality control visualization 
#echo '... fastqc quality control visualization ...'
#fastqc data/fastq_processed/*.fq -o data/reports/
#echo 'fastqc finished'


## Alignment
echo '... Performing alignment with bowtie2 ...'
for filename in data/fastq_processed/*_slide_1_val_1.fq; do
	echo "... Performing alignment with bowtie2 p1 = $filename, p2=${filename/_slide_1_val_1.fq/_slide_2_val_2.fq}..."
	bowtie2 -x data/bowtie2_index/Mus_musculus_GRCm38 \
		--threads 3 \
		--end-to-end \
		--very-fast \
		-1 "$filename" -2 "${filename/_slide_1_val_1.fq/_slide_2_val_2.fq}" \
		-S "data/sam${filename/data\/fastq_processed/}.sam"
	echo "bowtie2 aligment finished: Writting to data/sam${filename/data\/fastq_processed/}.sam"
done




