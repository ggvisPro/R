# 读取SLM文件
library(tidyverse)
data <- read_csv("export.csv")

# 修正第一个 filter 语句
data |> filter(!is.na(SLM)) |> head(5)

# 修正第二个 filter 语句
seer <- data |> filter(!`CS tumor size (2004-2015)` %in% c("999", "000"))

seer$`CS tumor size (2004-2015)` <- as.numeric(seer$`CS tumor size (2004-2015)`)
seer <- seer |> 
    mutate(`CS tumor size (2004-2015)` = as.numeric(`CS tumor size (2004-2015)`))
