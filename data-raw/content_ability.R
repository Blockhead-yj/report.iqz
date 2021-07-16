library(tidyverse)

content_ability <- readxl::read_xlsx("./data-raw/content_ability.xlsx")
usethis::use_data(content_ability, overwrite = TRUE)
