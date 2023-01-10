library(distill)
library(ggplot2)
library(janitor)
library(readxl)
library(rvest)
library(tidyverse)

# coord_flip() rotates bars to be horizontal (this improves readability)
# Divided number of subscribers by 1 million each to remove scientific notation & simplify subscriber values

sub_data <- working_data |>
  select(genre, subscribers) |>
  group_by(genre) |>
  summarize(mil_subscribers = sum(subscribers)/1000000) |>
  select(genre, mil_subscribers) |>
  arrange(desc(mil_subscribers))

gen_sub_plot <- sub_data |>  
  ggplot(aes(x = fct_reorder(genre, mil_subscribers),
             y = mil_subscribers,
             fill = desc(mil_subscribers))) +
  geom_bar(position = "dodge", stat = "identity") +
  coord_flip() +
  
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        axis.line = element_line(colour = "black"),
        legend.position = "none") +
  
  scale_fill_gradient(low = "green",
                      high = darkish_green) +
  
  geom_hline(yintercept = mean(sub_data$mil_subscribers),
             color = "brown2") +
  
  labs(title = "Most Subscribed-to Genres Among WEBTOON Originals",
       subtitle = "The most subscribed-to genre is Romance (102 million) and the least is Heartwarming (0.47 million).",
       x = "Genre",
       y = "Subscribers (millions)",
       caption = "Source: Kaggle (June 2022)") + 
  
  annotate("text",
           x = 2.2,
           y = 30, 
           label = sprintf("μ = %s\nδ = %s", 
                           round(mean(sub_data$mil_subscribers), 2),
                           round(sd(sub_data$mil_subscribers), 2)),
           color = "brown2")

write_rds(gen_sub_plot, "genre_subscribers.rds")
