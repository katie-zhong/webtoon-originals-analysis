rat_table <- working_data |>
  select(title, genre, authors, subscribers, rating) |>
  mutate(subscribers = round(subscribers/1000000, 2))

rat_table2 <- rat_table |>
  arrange(desc(rating)) |>
  slice(1:10) |>
  rename("Title" = title,
         "Genre" = genre,
         "Author(s)" = authors,
         "Subscribers (mil)" = subscribers,
         "Rating" = rating)

rat_datatable <- datatable(rat_table2,
                           options = list(scrollx = TRUE,
                                          editable = FALSE,
                                          pageLength = 16),
                           caption = "Table 4: Top 10 popular series with the highest series ratings in the sample dataset.")

write_rds(rat_datatable, "top_ratings.rds")