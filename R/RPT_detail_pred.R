#' @title Report the prediction and potential judgment in detail
#'
#' @description This function is used to make a detailed table of academic potential
#' prediction and potential judgment.
#'
#' @param data_wider Data.frame, which each row contains all the observations of a single person
#' @param threshold Numerical, missing proportion threshold above which the user will be dropped
#'
#' @return A [tibble][tibble::tibble-package]/table
#'
#' @export
#'

RPT_detail_pred <- function(data_wider, threshold){
  data_wider |>
    dplyr::filter(missing_prop <= threshold) |>
    dplyr::select(all_of(c("user_name", "mod_predict", "wt_sum_predict", "judgment")))
}
