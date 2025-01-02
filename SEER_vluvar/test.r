library(tidyverse)
data <- read_csv("data.csv")

data |> 
  janitor::clean_names() |> # 清理列名
  select(-sex) |> # 删除无用列
mutate(age_recode_with_1_year_olds = parse_number(age_recode_with_1_year_olds)) |>
rename(age = age_recode_with_1_year_olds) |>
  glimpse()
