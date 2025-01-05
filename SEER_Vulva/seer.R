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
