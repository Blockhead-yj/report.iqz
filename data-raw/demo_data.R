library(tidyverse)

academic <- readxl::read_xlsx("./data-raw/demo_academic.xlsx")
users <- jsonlite::stream_in(file("./data-raw/demo_users.ndjson"))
scores <- jsonlite::stream_in(file("./data-raw/demo_scores.ndjson"))
content_ability <- readxl::read_xlsx("./data-raw/content_ability.xlsx")

academic <- academic %>%
  rowwise() %>%
  mutate(姓名 = str_c(姓名 %>%
                        utf8ToInt() %>%
                        as.hexmode() %>%
                        str_sub(1,3),
                      collapse = ""),
           姓名 = str_c("demo", 姓名))

users <- users %>%
  filter(grade=="初一",!str_detect(user_name, "测试")) %>%
  rowwise() %>%
  mutate(user_name =
           str_c(user_name %>%
                   utf8ToInt() %>%
                   as.hexmode() %>%
                   str_sub(1,3),
                 collapse = ""),
         user_name = str_c("demo", user_name),
         school = "demo_school",
         province = "demo_province",
         city = "demo_city",
         district = "demo_district") %>%
  ungroup()

set.seed(39)
scores <- scores %>%
  filter(!str_detect(game_name, "量表|问卷|信息|同意书|极速版|简版")) %>%
  semi_join(users %>% filter(grade=="初一"), by = "user_id") %>%
  filter(game_name %in% sample(.$game_name, 20))


usethis::use_data(users, scores, academic, content_ability, overwrite = TRUE, internal = TRUE)
