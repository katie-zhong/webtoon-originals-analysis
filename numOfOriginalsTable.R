library(gt)

gen_num <- working_data |>
  group_by(genre)|>
  summarize(num = n()) |>
  select(genre, num) |>
  arrange(desc(num)) |>
  
  gt() |>
  tab_header(title = md("**WEBTOON Originals per Genre**")) |>
  cols_label(genre = "Genre",
             num = "Number of Originals") |>
  tab_source_note(md("*Kaggle Dataset (iridazzle, 2022)*"))

write_rds(gen_num, "originals_per_genre.rds")
