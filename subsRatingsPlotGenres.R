library(distill)
library(ggplot2)
library(janitor)
library(plotly)
library(readxl)
library(rvest)
library(tidyverse)

# Divided number of subscribers by 1 million each to remove scientific notation & simplify subscriber values
# Longer synopses are split onto multiple lines using str_wrap() to show up better in the hover interactivity of the plot

sub_rat_gen_plot <- working_data |>
  select(title, genre, authors, weekdays, length, subscribers, rating, status, synopsis, length) |>
  mutate(subscribers = subscribers/1000000) |>
  mutate(synopsis = str_wrap(synopsis, width = 90, exdent = 18)) |>
  arrange(desc(subscribers)) |>
  ggplot(aes(x = subscribers,
             y = rating,
             color = rating,
             text = paste("Title:", title, "\n",
                          "Author(s):", authors, "\n",
                          "Genre:", genre, "\n",
                          "Status:", status, "\n",
                          "Synopsis:", synopsis, "\n"))) +
    geom_point(alpha = 0.8, size = 0.5) +
    geom_smooth(method = "loess", formula = y~s, color = "black", se = FALSE) +
    facet_wrap(~ genre) +
    labs(x = "Number of Subscribers (in millions)",
         y = "Series Rating",
         title = "Relationship between Subscribers and\nRatings of WEBTOON Originals by Genre",
         caption = "Source: Iridazzle on Kaggle (June, 2022)",
         color = "Rating") +
    theme(plot.title = element_text(face = "bold")) +
    scale_colour_gradient(low = dark_green,
                          high = webt_green,
                          space = "Lab",
                          na.value = "grey50",
                          guide = "colourbar",
                          aesthetics = "colour")

gg_sub_rat_gen <- ggplotly(sub_rat_gen_plot, tooltip = "text")
write_rds(gg_sub_rat_gen, "subscribers_ratings_genre.rds")