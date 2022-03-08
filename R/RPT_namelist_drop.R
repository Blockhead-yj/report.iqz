#' @title The namelist that we don't make prediction
#'
#' @description This function is used to make name list
#' that we didn't make prediction, on which users had
#' too many predictors missing
#'
#' @param data_wider Data.frame, which each row contains all the observations of a single person
#' @param threshold Numerical, missing proportion threshold above which the user will be dropped
#'
#' @return A [tibble][tibble::tibble-package]/table can be used to report directly
#'
#' @export
#'

RPT_namelist_drop <- function(data_wider, class_NL, threshold = 30){
  data_wider |>
    dplyr::filter(missing_prop > threshold) |>
    dplyr::ungroup() |>
    dplyr::distinct(user_name) |>
    dplyr::left_join(class_NL, by=c("user_name")) |>
    dplyr::group_by(class) |>
    dplyr::summarise(学生名单=str_c(user_name,collapse = "，"))
}
