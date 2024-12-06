library(tidyverse)
rdata <- read_tsv("1.txt", col_names = FALSE)
rdata <- rdata[,-1]
rdata[rdata < 7.2] <- 7.2
write_tsv(rdata, "out.txt", na = "", col_names = F)