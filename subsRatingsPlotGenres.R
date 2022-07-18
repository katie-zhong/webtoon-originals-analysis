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

gen_num <- working_data |>
  group_by(genre)|>
  summarize(num = n()) |>
  select(genre, num)

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
    geom_smooth(method = "loess", formula = y~s, color = "black", size = 60, se = FALSE) +
    facet_wrap(~ genre) +
  
    labs(x = "Number of Subscribers (in millions)",
         y = "Series Rating",
         title = "Relationship between Subscribers and\nRatings of WEBTOON Originals by Genre",
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
                          aesthetics = "colour") #+

    # annotate("text",
    #          x = Inf,
    #          y = Inf,
    #          label = "🔔📚") #paste(toString(num), "Originals", sep = " ")))
  
gg_sub_rat_gen <- ggplotly(sub_rat_gen_plot, tooltip = "text") |>
  add_text(x = 800, y = 800,
           text = "🔔📚")
  
  # add_annotations(x = title,
  #                 y = title,
  #                 text = #paste("🔔", sub_rat_gen_plot$subscribers,
  #                              #"📚", gen_num$num),
  #                 showarrow = FALSE)
  
  # layout(annotations = list(x = title,
  #                           y = title,
  #                           #text = "🔔📚",
  #                           text = paste("🔔", sub_rat_gen_plot$subscribers,
  #                                        "📚", gen_num$num),
  #                           showarrow = F))
  
write_rds(gg_sub_rat_gen, "subscribers_ratings_genre.rds")