org_table <- read_rds("webtoon-data.rds") |>
  select(title, genre, authors, subscribers, rating) |>
  mutate(subscribers = round(subscribers/1000000, 2))

org_table2 <- org_table |>
  filter(subscribers >= median(org_table$subscribers),
         rating >= median(org_table$subscribers)) |>
  arrange(desc(subscribers)) |>
  slice(1:10) |>
  rename("Title" = title,
         "Genre" = genre,
         "Author(s)" = authors,
         "Subscribers (mil)" = subscribers,
         "Rating" = rating)

org_datatable <- datatable(org_table2,
                           options = list(scrollx = TRUE,
                                          editable = FALSE,
                                          pageLength = 16),
                           caption = "Table 2: Predicted Top 10 most popular series in the sample dataset of 774 WEBTOONs.")

write_rds(org_datatable, "custom_top_originals.rds")
