st <- sub_table |>
  arrange(desc(subscribers)) |>
  slice(1:10)

rt <- rat_table |>
  arrange(desc(rating)) |>
  slice(1:10)

org_table <- full_join(st, rt)
  
org_table2 <- org_table |>
  filter(subscribers >= mean(org_table$subscribers),
         rating >= mean(org_table$subscribers)) |>
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
                           caption = "Table 5: Predicted Top 10 most popular series in the sample dataset.")

write_rds(org_datatable, "custom_top_originals.rds")