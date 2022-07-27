num_table <- read_rds("webtoon-data.rds") |>
  group_by(genre) |>
  summarize(num = n()) |>
  select(genre, num) |>
  arrange(desc(num)) |>
  rename("Genre" = genre,
         "Number of Originals" = num)

num_datatable <- datatable(num_table,
          options = list(scrollx = TRUE,
                         editable = FALSE,
                         pageLength = 16),
          caption = "Table 1: Genre distribution in the sample dataset of 774 WEBTOONs.")

write_rds(num_datatable, "originals_per_genre.rds")