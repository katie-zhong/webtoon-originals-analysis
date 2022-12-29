library(distill)
library(ggplot2)
library(janitor)
library(readxl)
library(rvest)
library(tidyverse)

perc_data <- working_data |>
  group_by(genre) |>
  summarize(num = n()) |>
  mutate(perc = round((100*num/sum(num)), 2)) |>
  arrange(desc(perc))
  
gen_perc_plot <- perc_data |>
  ggplot(aes(x = fct_reorder(genre, perc, .desc = TRUE),
             y = perc,
             fill = perc)) +
  geom_col(position = "dodge") +
  coord_cartesian(ylim = c(0,20)) +
  
  theme(plot.title = element_text(face = "bold"),
        axis.text.x = element_text(angle = 60,
                                   vjust = 0.53,
                                   hjust = 0.5,
                                   margin = margin(t = 0, r = 0, b = 0, l = 0)),
        panel.background = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        axis.line = element_line(colour = "black"),
        legend.position = "none") +
  scale_fill_gradient(low = darkest_green,
                      high = "green") +
  labs(title = "% of All Originals Per Genre",
       subtitle = "Fantasy contains the most Originals (17.8%, 138 Originals) with Romance at a close \nsecond (16.9%, 131 Originals). Heartwarming contains the least (0.26%, 2 Originals).",
       x = "Genre",
       y = "% of All Originals",
       caption = "Source: Kaggle (June 2022)")

write_rds(gen_perc_plot, "genre_perc.rds")
