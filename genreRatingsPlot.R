library(distill)
library(ggplot2)
library(janitor)
library(readxl)
library(rvest)
library(tidyverse)

gen_rat_plot <- working_data |>
  group_by(genre) |>
  summarize(avg_rating = mean(rating)) |>
  arrange(desc(avg_rating)) |>
  
  ggplot(aes(x = fct_reorder(genre, avg_rating, .desc = TRUE),
             y = avg_rating,
             fill = webt_green)) +
  geom_col(position = "dodge") +
  coord_cartesian(ylim = c(8.5,10)) +
  
  theme(plot.title = element_text(face = "bold"),
        axis.text.x = element_text(angle = 45,
                                   vjust = 0.53,
                                   hjust = 0.5,
                                   margin = margin(t = 0, r = 0, b = 0, l = 0)),
        panel.background = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        axis.line = element_line(colour = "black"),
        legend.position = "none") +
  labs(title = "Average Ratings Per Genre",
       subtitle = "Originals from the Heartwarming genre receive the highest ratings\nwhile Superhero Originals receive the lowest",
       x = "Genre",
       y = "Average Rating",
       caption = "Source: Iridazzle on Kaggle (June 2022)") +
  scale_fill_manual(values = "#00dc64",
                    labels = "Users' Average Rating of all Originals per Genre")

ggsave("genre_ratings.png", gen_rat_plot)