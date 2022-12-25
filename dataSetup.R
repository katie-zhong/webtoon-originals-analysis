library(distill)
library(DT)
library(gt)
library(janitor)
library(rvest)
library(tidyverse)


# In the original CSV, apostrophes are replaced with unquoted string "â€™" in the synopses. 
# To improve reader understanding, mutate() is used to remedy this error

# str_replace() for pattern = "_" is used twice to change the second pattern occurrence in SLICE_OF_LIFE

# The TIPTOON genre was renamed as INFORMATIVE by WEBTOON


webt_data <- read_csv(file = "webtoon_originals_en.csv") |>
  clean_names() |>
  as_tibble() |>
  mutate(genre = str_replace(genre, pattern = "SF", "SCI-FI")) |>
  mutate(genre = str_replace(genre, pattern = "TIPTOON", "INFORMATIVE")) |>
  mutate(genre = str_replace(genre, pattern = "_", " ")) |>
  mutate(genre = str_replace(genre, pattern = "_", " ")) |>
  mutate(genre = str_replace(genre, pattern = "SUPER HERO", "SUPERHERO")) |>
  mutate(sypnosis = str_replace(synopsis, pattern = "â€™", "'"))

write_rds(webt_data, "webtoon-data.rds")
working_data <- read_rds("webtoon-data.rds")

high_green <- "#00ff74"
webt_green <- "#00dc64"
mid_green <- "#128b4f"
dark_green <- "#117945"
