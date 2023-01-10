sub_table <- working_data |>
  select(title, genre, authors, subscribers, rating) |>
  mutate(subscribers = round(subscribers/1000000, 2))

sub_table2 <- sub_table |>
  arrange(desc(subscribers)) |>
  slice(1:10) |>
  rename("Title" = title,
         "Genre" = genre,
         "Author(s)" = authors,
         "Subscribers (mil)" = subscribers,
         "Rating" = rating)

sub_datatable <- datatable(sub_table2,
                           options = list(scrollx = TRUE,
                                          editable = FALSE,
                                          pageLength = 16),
                           caption = "Table 3: Top 10 series with the most subscribers in the sample dataset.")

write_rds(sub_datatable, "top_subscribers.rds")