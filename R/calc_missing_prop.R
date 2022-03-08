#' @title Calculate the missing proportion of predictors by relative weight
#'
#' @description There is a situation that we want to make prediction for
#' incomplete observation, which a linear model don't support. However, we try to
#' approximately predict those incomplete observation with small missing part.
#' So, this function is used to calculate the missing proportion of predictors,
#' the weight fo each predictor is from relative weight analysis.
#'
#' @param data_wider Data.frame, which each row contains all the observations of a single person.
#' @param RelativeWeight Data.frame, generate by [rwa::rwa()], contains the relative weight of
#' each variable
#' @param digits, Numerical, the digits missing_prop reserved
#'
#' @return A vector with length nrow(data_wider), indicate the missing proportion of predictors
#'
#' @export

calc_missing_prop <- function(data_wider, RelativeWeight, digits){
  complete_prop <- data_wider |>
    dplyr::select(all_of(RelativeWeight[["Variables"]])) |>
    dplyr::mutate_all(~!is.na(.x)) |>
    as.matrix() %>%
    `%*%`(RelativeWeight[["Rescaled.RelWeight"]]) |>
    drop()
  round(100 - complete_prop, digits)
}
