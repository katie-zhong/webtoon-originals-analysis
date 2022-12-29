# Decided not to use a table; visualizing number of Originals with a plot is much more effective

num_table1 <- data_by_genres |>
  summarize(rating = round(mean(rating), digits = 2))

num_table2 <- data_by_genres |>
  summarize(num = n())

num_tablef <- full_join(num_table2, num_table1, by="genre") |>
  arrange(desc(num)) |>
  rename("Genre" = genre,
         "Number of Originals" = num,
         "Average Rating" = rating)

num_datatable <- datatable(num_tablef,
                           options = list(scrollx = TRUE,
                                          editable = FALSE,
                                          pageLength = 16),
                           caption = "Table 1: Originals per genre in the sample dataset.")

write_rds(num_datatable, "originals_per_genre.rds")