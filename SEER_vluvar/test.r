# 加载tidyverse包
library(tidyverse)

# 读取数据并清理列名
data_origin <- read_csv("data.csv") |> janitor::clean_names() 

# 数据清洗:
# 1. 过滤掉生存月份未知的记录
# 2. 过滤掉死亡原因未知的记录
# 3. 转换并过滤肿瘤大小数据
data <- data_origin |> 
  filter(survival_months != "Unknown",
         seer_other_cause_of_death_classification != "Dead (missing/unknown COD)",
         seer_cause_specific_death_classification != "Dead (missing/unknown COD)") |> 
  mutate(cs_tumor_size_2004_2015 = parse_number(cs_tumor_size_2004_2015)) |> 
  filter(cs_tumor_size_2004_2015 > 0 & cs_tumor_size_2004_2015 < 990) 

# 重命名年龄变量
data <- data |>
  rename(all_of(
    c("age" = "age_recode_with_1_year_olds")
  ))

data |>  select(-sex, 
                -race_recode_w_b_ai_api, 
                cs_tumor_size_ext_eval_2004_2015) |> 
  mutate(age = parse_number(age)) |> 
  mutate(age = factor(case_when(
           age <= 64 ~ "<=64",
           age >= 85 ~ ">=85",
           TRUE ~ "65-84"
         ))) |>
  mutate(race_recode_white_black_other = factor(race_recode_white_black_other)) |> 
  count(survival_months) |> arrange(desc(survival_months))
