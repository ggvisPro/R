library(tidyverse)
library(readxl)

data <- read_excel("E:\\梦娇\\自然分娩2024.8-12（北院）.xls") |> janitor::clean_names()

data2 <- data |> 
  select(chan_fu_fen_mian_ri_qi, bing_li_hao, chan_fu_xing_ming, jie_sheng_ren_yuan) |> 
  mutate(jie_sheng_ren_yuan = paste(jie_sheng_ren_yuan, "王梦娇")) |> 
  filter(chan_fu_fen_mian_ri_qi >= as_date("20240821")) |>
  head(100)

write_tsv(data2, "E:\\梦娇\\delivery_data.txt")
         