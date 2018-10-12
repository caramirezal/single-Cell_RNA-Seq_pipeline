library(readr)
library(caret)
library(dplyr)

## counting the number of samples
local_path <- "../data/filbin/GSE102130_K27Mproject.RSEM.vh20170621.txt" 
data <- read_tsv("../data/filbin/GSE102130_K27Mproject.RSEM.vh20170621.txt")


## sampĺing data
set.seed(333)
n <- ncol(data)
sampling <- sample(2:n, 30)
data.s <- data[, sampling]
dim(data.s)
data.s <- t(data.s)
rownames(data.s) <- colnames(data)[sampling]
colnames(data.s) <- data$Gene
head(data.s[, 1:6])

## drop constant variables
drop <- nearZeroVar(data.s)
data.m <- as.matrix(data.s[, -drop]) 

## select non constant variables
heatmap(data.m)

