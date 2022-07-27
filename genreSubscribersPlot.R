library(distill)
library(ggplot2)
library(janitor)
library(readxl)
library(rvest)
library(tidyverse)

# coord_flip() rotates bars to be horizontal (this improves readability)
# Divided number of subscribers by 1 million each to remove scientific notation & simplify subscriber values

gen_sub_plot <- working_data |>
  select(genre, subscribers) |>
  group_by(genre) |>
  summarize(milSubscribers = sum(subscribers)/1000000) |>
  
  select(genre, milSubscribers) |>
  arrange(desc(milSubscribers)) |>
  
  ggplot(aes(x = fct_reorder(genre, milSubscribers),
             y = milSubscribers,
             fill = desc(milSubscribers))) +
  geom_bar(position = "dodge", stat = "identity") +
  coord_flip() +
  
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        axis.line = element_line(colour = "black"),
        legend.position = "none") +
  scale_fill_gradient(low = "green",
                      high = dark_green) +
  labs(title = "Most Subscribed-to Genres Among WEBTOON Originals",
       subtitle = "The most subscribed-to genre is Romance",
       x = "Genre",
       y = "Number of Subscribers (in millions)",
       caption = "Source: Kaggle (June 2022)")

ggsave("genre_subscribers.png", gen_sub_plot)
