## iteration of the pipeline

fastq_names <- readLines("../data/file_names.txt")
fastq_dir <- "data/fastq/"
fastq_full_paths <- paste(fastq_dir, fastq_names, sep = "")

nones <- seq(1, length(fastq_full_paths), by = 2)

for (i in nones) {
       cat("Subsampling", fastq_full_paths[i], "\n")
       command_line <- paste("seqtk sample -s3",
                             fastq_full_paths[i],
                             "> data/fastq/slide_1.fastq")
       system(command_line)
       cat("Subsampling", fastq_full_paths[i+1], "\n")
       command_line <- paste("seqtk sample -s3",
                             fastq_full_paths[i+1],
                             "> data/fastq/slide_2.fastq")
       system(command_line)
       
       cat("Executing pipeline for ", i+1, "of ", length(nones), "samples\n")
       system("./pipeline.bash")
}
