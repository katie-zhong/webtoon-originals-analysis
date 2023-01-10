library(distill)
library(DT)
library(gt)
library(janitor)
library(rvest)
library(tidyverse)


# In the original CSV, apostrophes are replaced with unquoted string "â€™" in the synopses. 
# Also, multiple authors are separated with a comma with no space after.
# To improve readibility, mutate() is used to make these fixes

# str_replace() for pattern = "_" is used twice to change the second pattern occurrence in SLICE_OF_LIFE

# The TIPTOON genre was renamed as INFORMATIVE by WEBTOON


webt_data <- read_csv(file = "webtoon_originals_en.csv") |>
  clean_names() |>
  as_tibble() |>
  mutate(authors = str_replace_all(authors, pattern = ",", ", ")) |>
  mutate(genre = str_replace(genre, pattern = "SF", "SCI-FI")) |>
  mutate(genre = str_replace(genre, pattern = "TIPTOON", "INFORMATIVE")) |>
  mutate(genre = str_replace(genre, pattern = "_", " ")) |>
  mutate(genre = str_replace(genre, pattern = "_", " ")) |>
  mutate(genre = str_replace(genre, pattern = "SUPER HERO", "SUPERHERO")) |>
  mutate(sypnosis = str_replace(synopsis, pattern = "â€™", "'"))

write_rds(webt_data, "webtoon-data.rds")
working_data <- read_rds("webtoon-data.rds")

data_by_genres <- working_data |>
  select(genre, rating) |>
  group_by(genre)

cleaned_data_all <- working_data |>
  select(title, genre, authors, weekdays, length, subscribers, rating, status, synopsis, length) |>
  mutate(subscribers = round(subscribers/1000000, 2),
         synopsis = str_wrap(synopsis, width = 90, exdent = 18)) |>
  arrange(desc(subscribers))

write_rds(cleaned_data_all, "cleaned_data_all.rds")

high_green <- "#00ff74"
webt_green <- "#00dc64"
mid_green <- "#128b4f"
dark_green <- "#117945" 
darkish_green <- "#0c4e2d"
darkest_green <- "#083a21"
          