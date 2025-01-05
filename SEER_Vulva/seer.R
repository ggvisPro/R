library(tidyverse)

data <- read_csv("export.csv") |> janitor::clean_names()

# 打印排除标准的数量
data |>
  summarise(
    all = n(),
    NA_survival_months = sum(survival_months == "Unknown"),
    NA_cause_death = sum(
      seer_cause_specific_death_classification == "Dead (missing/unknown COD)" |
        seer_other_cause_of_death_classification == "Dead (missing/unknown COD)"
    ),
    NA_tumor_size = sum(
      as.numeric(cs_tumor_size_2004_2015) == 0 |
        as.numeric(cs_tumor_size_2004_2015) > 988
    )
  )

# 排除标准
data <- data |> filter(
  survival_months != "Unknown",
  seer_cause_specific_death_classification != "Dead (missing/unknown COD)",
  seer_cause_specific_death_classification != "Dead (missing/unknown COD)",
  as.numeric(cs_tumor_size_2004_2015) > 0 & as.numeric(cs_tumor_size_2004_2015) < 989,
)

# 处理变量


data |> # 肿瘤大小
  mutate(tumor_size = case_when( # 年龄
    as.numeric(cs_tumor_size_2004_2015) <= 24 ~ "≤24",
    as.numeric(cs_tumor_size_2004_2015) <= 46 ~ "25-46",
    TRUE ~ "≥47"
  )) |> # 组织分期
  mutate(grade = case_when(
    grade_recode_thru_2017 %in% c("Well differentiated; Grade I", "Moderately differentiated; Grade II") ~ "Grade_I_II",
    grade_recode_thru_2017 %in% c("Poorly differentiated; Grade III", "Undifferentiated; anaplastic; Grade IV") ~ "Grade_III_IV",
    grade_recode_thru_2017 == "Unknown" ~ "Unknown"
  )) |> 
  mutate( # FIGO
    FIGO_stage = case_when(
      derived_ajcc_stage_group_6th_ed_2004_2015 %in% c("I", "IA", "IB") ~ "FIGO_I",
      derived_ajcc_stage_group_6th_ed_2004_2015 %in% c("II") ~ "FIGO_II",
      derived_ajcc_stage_group_6th_ed_2004_2015 %in% c("III") ~ "FIGO_III",
      derived_ajcc_stage_group_6th_ed_2004_2015 %in% c("IVA", "IVB", "IVNOS") ~ "FIGO_IV",
      derived_ajcc_stage_group_6th_ed_2004_2015 == "UNK Stage" ~ "Unknown"
    )
  )
data |> 
  count(cs_lymph_nodes_2004_2015) |> print(n = Inf)
