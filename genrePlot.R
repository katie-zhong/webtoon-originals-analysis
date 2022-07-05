library(distill)
library(ggplot2)
library(janitor)
library(readxl)
library(rvest)
library(tidyverse)

# coord_flip() rotates bars to be horizontal (this improves readability)
# Divided number of subscribers by 1 million each to remove scientific notation & simplify subscriber values

working_data <- read_rds("webtoon-data.rds")

working_data |>
  select(genre, subscribers) |>
  group_by(genre) |>
  summarize(milSubscribers = sum(subscribers)/1000000,
            tracker = as.numeric(c(milSubscribers, n()))) |>
  
  select(genre, milSubscribers) |>
  arrange(desc(milSubscribers)) |>
  
  ggplot(aes(x = fct_reorder(genre, milSubscribers),
             y = milSubscribers)) +
  geom_bar(position = "dodge", stat = "identity") +
  coord_flip() +
  scale_fill_manual(values = c("#00DC64")) +
  labs(x = "Genre",
       y = "Number of Subscribers (in millions)",
       title = "Most Popular Genres Among WEBTOON Originals",
       subtitle = "The most popular genre is Fantasy, closely followed by Romance",
       caption = "Source: Iridazzle on Kaggle \n(774 WEBTOON Originals, sourced on June 30, 2022)") +
  theme_minimal() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank())

# Include number of Webtoon Originals
# Include daily pass stats for each genre