library(tidyverse)

data <- read_csv("export.csv") |> janitor::clean_names()


# 排除标准
data <- data |> filter(
  survival_months == "Unknown",
  seer_cause_specific_death_classification == "Dead (missing/unknown COD)",
  seer_cause_specific_death_classification == "Dead (missing/unknown COD)",
as.numeric(cs_tumor_size_2004_2015) > 0 & as.numeric(cs_tumor_size_2004_2015) < 989,
)

data |> count(vital_status_recode_study_cutoff_used) 
data |> count(seer_cause_specific_death_classification)
data |> count(seer_other_cause_of_death_classification)

date |> group_by()
