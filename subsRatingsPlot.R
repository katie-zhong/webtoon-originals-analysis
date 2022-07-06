library(distill)
library(ggplot2)
library(janitor)
library(readxl)
library(rvest)
library(tidyverse)

# Divided number of subscribers by 1 million each to remove scientific notation & simplify subscriber values

subVrat_data <- read_rds("webtoon-data.rds")

subVrat_plot <- subVrat_data |>
  select(title, genre, authors, weekdays, length, subscribers, rating, status, synopsis, length) |>
  #filter(length >) |>
  mutate(subscribers = subscribers/1000000) |>
  arrange(desc(subscribers)) |>
  ggplot(aes(x = subscribers,
             y = rating,
             color = rating,
             text = paste("Title:", title, "\n",
                                "Author(s):", authors, "\n",
                                "Genre:", genre, "\n",
                                "Status:", status, "\n",
                                "Synopsis:", synopsis, "\n"))) +
  geom_point(size = 0.8) +
  geom_smooth(method = "loess", formula = y~x, se = FALSE) +
  facet_wrap(~ genre) +
  labs(x = "Number of Subscribers (in millions)",
       y = "Series Rating",
       title = "Relationship between Subscribers and Ratings for WEBTOON Originals\n with more than X Episodes Released",
       subtitle = "",
       caption = "Source: Iridazzle on Kaggle (June, 2022)",
       color = "Rating") +
  theme(plot.title = element_text(face = "bold"))

ggplotly(subVrat_plot, tooltip = "text")

# +
#   scale_fill_manual(values = c("#F8766D", "#7CAE00", "#00BFC4", "#C77CFF"),
#                     limits = c("4", "3", "2", "1"),
#                     labels = c("Top 10 Originals, All Genres",
#                                "Top in Genre"))