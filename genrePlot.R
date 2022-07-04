library(rvest)
library(janitor)
library(tidyverse)
library(distill)
library(readxl)

#data1 <- read_excel(path = "webtoon_originals_en.xlsx")

data <- read_csv(file = "webtoon_originals_en.csv") |>
  mutate(title = str_replace(title, pattern = "â€™", "\'")) |>
  mutate(title = str_replace(synopsis, pattern = "â€™", "\'")) |>
  arrange(genre)

data |>
  ggplot(aes(x = genre)) +
  geom_bar()+
  labs(x = "Genre",
       y = "Number of Webtoon Originals",
       title = "Most Popular Genres Among WEBTOON Originals",
       subtitle = "The most popular genre is Fantasy, closely followed by Romance",
       caption = "Source: Iridazzle on Kaggle (sourced on June 30, 2022)")
