library(distill)
library(ggplot2)
library(janitor)
library(readxl)
library(rvest)
library(tidyverse)

working_data <- read_rds("webtoon-data.rds")

working_data |>
  group_by(genre) |>
  summarize(avg_rating = mean(rating)) |>
  arrange(desc(avg_rating)) |>
  ggplot(aes(x = genre)) +
  geom_histogram(binwidth = 1) +
  labs(title = "Average Ratings Per Genre",
       subtitle = "Originals from the Heartwarming genre receive the highest ratings",
       x = "Genre",
       y = "Average Rating") +
  scale_fill_manual(values = "#00dc64",
                    labels = "Average Rating") +
  theme_minimal()