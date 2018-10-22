
####################################
## subsample pair-end fastq files ##
####################################

## Install seqtk, see https://github.com/lh3/seqtk
git clone https://github.com/lh3/seqtk.git;
cd seqtk; make

## See https://www.biostars.org/p/142705/
## -s#number parameter is used to set a seed
## the number 2 parameter indicates the selection of 2 random sequences
seqtk sample -s3 data/fastq/ERR523111_1.fastq.gz 2 > data/fastq/ERR523111_1_slide.fastq
seqtk sample -s3 data/fastq/ERR523111_2.fastq.gz 2 > data/fastq/ERR523111_2_slide.fastq

#########################################################################################


