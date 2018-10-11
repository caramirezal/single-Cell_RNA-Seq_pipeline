library(readr)
library(caret)
library(dplyr)

data <- read.delim("../data/GSE102130_K27Mproject.RSEM.vh20170621.txt", 
                   sep = "\t", 
                   nrows = 6, 
                   stringsAsFactors = FALSE, 
                   header = TRUE)

col_classes <- sapply(data, class)

data <- read_tsv("../data/GSE102130_K27Mproject.RSEM.vh20170621.txt")

dim(data)

## tomar slide

gene_names <- data[,1]

## drop col names
data.p <- data[, -1] %>%
                 t() %>% 
                 as.data.frame()
dim(data.p)

## droping constant variables
data.smtv <- select(data.smt, -nearZeroVar(data.smt))
dim(data.smtv)

## select non constant variables
heatmap(as.matrix(data.smtv), labCol = "")

