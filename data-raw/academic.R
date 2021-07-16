library(tidyverse)

academic <- readxl::read_xlsx("./data-raw/demo_academic.xlsx")
academic <- academic %>%
  rowwise() %>%
  mutate(姓名 = str_c(姓名 %>%
                      utf8ToInt() %>%
                      as.hexmode() %>%
                      str_sub(1,3),
                    collapse = ""),
        姓名 = str_c("demo", 姓名))

usethis::use_data(academic, overwrite = TRUE)


