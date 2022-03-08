#' @title Summary prediction and potential judgment
#'
#' @description This function is used to make a summary table of academic potential
#' prediction and potential judgment.
#'
#' @param data_wider Data.frame, which each row contains all the observations of a single person
#' @param threshold Numerical, missing proportion threshold above which the user will be dropped
#'
#' @return A [tibble][tibble::tibble-package]/table can be used to report directly
#'
#' @export
#'

RPT_summary_pred <- function(data_wider, threshold = 30){
  data_wider |>
    dplyr::filter(missing_prop <= threshold) |>
    dplyr::group_by(judgment) |>
    dplyr::summarise(人数 = n(), .groups = "drop") |>
    dplyr::mutate(比例 = scales::percent(人数/sum(人数), 0.1)) |>
    dplyr::left_join(judgment_description, by = "judgment") |>
    dplyr::rename(潜力评价等级 = judgment, 评价等级描述 = description)
}
