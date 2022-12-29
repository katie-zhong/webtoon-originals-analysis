library(distill)
library(ggplot2)
library(janitor)
library(readxl)
library(rvest)
library(tidyverse)

rat_data <- working_data |>
  group_by(genre) |>
  summarize(avg_rating = mean(rating)) |>
  arrange(desc(avg_rating))

gen_rat_plot <- rat_data |>
  ggplot(aes(x = fct_reorder(genre, avg_rating, .desc = TRUE),
             y = avg_rating,
             fill = avg_rating)) +
  geom_col(position = "dodge") +
  coord_cartesian(ylim = c(8.8,9.7)) +
  
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
  
  scale_fill_gradient(low = "black",
                      high = "green") +
  
  geom_hline(yintercept = mean(rat_data$avg_rating),
             color = "brown2") +
  
  labs(title = "Series Average Ratings Per Genre",
       subtitle = "Originals from the Heartwarming genre receive the highest ratings (9.70) \nwhile Superhero Originals receive the lowest (8.84).",
       x = "Genre",
       y = "Average Rating",
       caption = "Source: Kaggle (June 2022)") + 
  
  annotate("text",
           x = 15.5,
           y = mean(rat_data$avg_rating)+0.1, 
           label = sprintf("μ = %s\nδ = %s", 
                           round(mean(rat_data$avg_rating), 2),
                           round(sd(rat_data$avg_rating), 2)),
           color = "brown2")

write_rds(gen_rat_plot, "genre_ratings.rds")
