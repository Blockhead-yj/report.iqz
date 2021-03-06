#' @title Report model tasks
#'
#' @description This function summary the result of linear model and relative
#' weight analysis, and then make a tibble for report
#'
#' @param model A lm object, with additional rw part, generated by select_by_RW.
#' @param abilities Data.frame, including two essential column, the game_name and the represent
#' ability of it(ab_name_second). And a alternative column, ab_type.
#'
#' @return A [tibble][tibble::tibble-package]/table can be used to report directly
#'
#' @export

RPT_model_tasks <- function(model, abilities){
  model_coef <- model$coefficients |>
    tibble::as_tibble_row() |>
    tidyr::pivot_longer(cols = dplyr::everything(),
                 names_to = "Variables",
                 values_to = "coefficients")
  if("ab_type" %in% colnames(abilities)){
    report_ab <-  abilities |>
      dplyr::rename(Variables = game_name) |>
      dplyr::filter(ab_type == "基础能力") |>
      dplyr::group_by(Variables) |>
      summarise(ability = paste0(unique(ab_name_second), collapse = ","), .groups = "drop")
  } else {
    report_ab <-  abilities |>
      dplyr::rename(Variables = game_name) |>
      dplyr::group_by(Variables) |>
      dplyr::summarise(ability = paste0(unique(ab_name_second), collapse = ","), .groups = "drop")
  }
  report_ab |>
    dplyr::right_join(model$rw, by = "Variables") |>
    dplyr::left_join(model_coef, by = "Variables") |>
    dplyr::mutate(
      coefficients = round(coefficients, 2),
      Rescaled.RelWeight = scales::percent(Rescaled.RelWeight / sum(Rescaled.RelWeight), 0.1)
    ) |>
    dplyr::select(
      预测变量 = Variables,
      能力 = ability,
      系数 = coefficients,
      相对权重 = Rescaled.RelWeight
    )
}
