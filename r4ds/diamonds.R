library(tidyverse)
library(nycflights13)
library(lubridate)

flights_dt %>%
  count(week = floor_date(dep_time, "week")) %>% 
  ggplot(aes(week, n)) +
  geom_line()

(x1 <- ymd_hms("2015-06-01 12:00:00", tz = "America/New_York")) #> [1] "2015-06-01 12:00:00 EDT"
(x2 <- ymd_hms("2015-06-01 18:00:00", tz = "Europe/Copenhagen")) #> [1] "2015-06-01 18:00:00 CEST"
(x3 <- ymd_hms("2015-06-02 04:00:00", tz = "Pacific/Auckland")) #> [1] "2015-06-02 04:00:00 NZST"

x4 <- c(x1, x2, x3)

install.packages("magrittr")
