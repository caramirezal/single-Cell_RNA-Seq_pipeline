## Programmatic downloading data from

url <- "https://www.ebi.ac.uk/arrayexpress/files/E-MTAB-2600/E-MTAB-2600.sdrf.txt"
info_file <- read.delim(url, 
                   sep = "\t", 
                   stringsAsFactors = FALSE,
                   nrows = 2, 
                   colClasses = "character")

fastq_urls <- info_file$Comment.FASTQ_URI.
head(fastq_urls)

for ( dir in fastq_urls ){
        download.file(dir, "../data/")
}