library(distill)
library(ggplot2)
library(janitor)
library(plotly)
library(readxl)
library(rvest)
library(tidyverse)

# Divided number of subscribers by 1 million each to remove scientific notation & simplify subscriber values
# Longer synopses are split onto multiple lines using str_wrap() to show up better in the hover interactivity of the plot

# Note that newly-launched Originals (those with three or more episodes) were included within the data used for these graphs,
# as success can still be measured with the same variables that apply to older Originals. Though newer Originals are more heavily promoted,
# older Originals also received the same treatment when they were launched.

sub_rat_all_plot <- working_data |>
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
  
    labs(x = "Number of Subscribers (in millions)",
         y = "Series Rating",
         title = "Relationship between Subscribers and\nRatings of WEBTOON Originals",
         caption = "Source: Iridazzle on Kaggle (June, 2022)",
         color = "Rating") +
    theme(plot.title = element_text(face = "bold",
                                    margin = margin(0,0,30,0),
                                    size = 18)) +
    scale_colour_gradient(low = dark_green,
                          high = webt_green,
                          space = "Lab",
                          na.value = "grey50",
                          guide = "colourbar",
                          aesthetics = "colour")

gg_sub_rat_all <- ggplotly(sub_rat_all_plot, tooltip = "text")
write_rds(gg_sub_rat_all, "subscribers_ratings_all.rds")