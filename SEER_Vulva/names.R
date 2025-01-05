library(tidyverse)
library(readxl)

# Load the data
data <- read_excel("data.xlsx") |> filter(`序号` != "序号")
data |>
  filter(`学位类型` == "专业学位") |>
  count(`拟录取专业`) |>
  arrange(desc(n)) |>
  slice_head(n = 20) |>
  ggplot(aes(x = reorder(`拟录取专业`, n), y = n)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  theme_minimal() +
  labs(x = "拟录取专业",
       y = "录取人数",
       title = "拟录取专业人数Top20") +
  theme(
    text = element_text(family = "PingFang SC"),  # 使用苹方字体
    axis.text.y = element_text(size = 8),
    plot.title = element_text(hjust = 0.5)
  )