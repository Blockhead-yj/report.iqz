library(tidyverse)

scores <- jsonlite::stream_in(file("./data-raw/demo_scores.ndjson"))
users <- jsonlite::stream_in((file("./data-raw/demo_users.ndjson")))
set.seed(39)
scores <- scores %>%
  filter(!str_detect(game_name, "量表|问卷|信息|同意书|极速版|简版")) %>%
  semi_join(users %>% filter(grade=="初一"), by = "user_id") %>%
  filter(game_name %in% sample(.$game_name, 12))

usethis::use_data(scores, overwrite = FALSE, internal = TRUE)

