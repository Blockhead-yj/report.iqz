#' @title Make a name list of every class
#'
#' @description To present the prediction details and those people who are not
#' involved in prediction for some reason, it is a good idea to make a name list
#' for every class. So the teachers can easily know the details in his/her class.
#'
#' @param class_NL Data.frame, class name list, has a column indicate the name and
#' a corresponding column indicate it's class. user_name and class
#' @param user_NL Data.frame or character vector, if input is a data.frame, it should has a column
#' indicate the name and a corresponding potential judgment(see [judge_Pot()] for more information).
#' If input is a character vector, it will be considered as user name.
#'
#' @return A [tibble][tibble::tibble-package] contains class and the name list of every class as a single long string
#'
#' @export

make_NL_by_class <- function(class_NL, user_NL) {
  stopifnot("class_NL should have least two columns: 'class' and 'user_name'!"=
              all(c("user_name", "class") %in% colnames(class_NL)))
  if(is.character(user_NL)) {
    user_NL <- tibble(user_name = user_NL)
    out <- class_NL %>%
      right_join(user_NL, by = "user_name") %>%
      group_by(class) %>%
      summarise(user_name = str_c(user_name, collapse = "，"), .groups = "drop") %>%
      rename(班级 = class, 名单 = user_name)
  } else if(is.data.frame(user_NL) && all(c("user_name", "judgment") %in% colnames(user_NL))){
    out <- class_NL %>%
      right_join(user_NL, by = "user_name") %>%
      group_by(class, judgment) %>%
      summarise(user_name = str_c(user_name, collapse = "，"), .groups = "drop") %>%
      pivot_wider(names_from = "judgment", values_from = "user_name") %>%
      rename(班级 = class)
  } else stop("Data.frame user_NL should have least two columns: 'user_name' and 'judgment'!")
  out
}

