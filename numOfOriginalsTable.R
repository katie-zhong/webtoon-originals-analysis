num_table <- read_rds("webtoon-data.rds") |>
  group_by(genre) |>
  summarize(num = n()) |>
  select(genre, num, rating) |>
  summarize(num = num)

num_table2 <- num_table |>
  mutate(rating = median(num_table$rating) |>
  arrange(desc(num)) |>
  rename("Genre" = genre,
         "Number of Originals" = num,
         "Average Rating" = rating) |>
    gt() |>
    tab_header(title = md("Table 1: Originals per genre in the sample dataset of 774 WEBTOONs.")) |>
    tab_source_note(source_note = md("*Kaggle, 2022*"))
  
write_rds(num_table2, "originals_per_genre.rds")