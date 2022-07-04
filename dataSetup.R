library(rvest)
library(janitor)
library(tidyverse)
library(distill)

# Note: In the original CSV, apostrophes are replaced with unquoted string "â€™". 
# To improve reader understanding, mutate() is used to remedy this error

read_csv(file = "webtoon_originals_en.csv") |>
  mutate(title = str_replace(title, pattern = "â€™", "\'")) |>
  mutate(title = str_replace(synopsis, pattern = "â€™", "\'")) |>
  arrange(subscribers)
