library(tidyverse)

users <- jsonlite::stream_in(file("./data-raw/demo_users.ndjson"))

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
usethis::use_data(users, overwrite = FALSE, internal = TRUE)
