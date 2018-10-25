## plot heatmap of Filbin et al, 2018
library(dplyr)

## loading data
gliomas <- read.table("../data/GSE102130_K27Mproject.RSEM.vh20170621.txt", 
           header = TRUE,
           sep="\t", 
           nrows = 5)


## processing cell sample names
cells <- names(gliomas)

## remove oligos
cells.p <- cells[!grepl("Oligo", cells)]
## assign "normal" to MGH tagged cells
cells.p <- sapply(cells.p, 
                  function(x) ifelse(grepl("MGH", x), 
                                     "normal",
                                     "malignant"))
## assign malignant