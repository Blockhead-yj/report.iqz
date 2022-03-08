#' @title Predict by weighted sum
#'
#' @description This is a attempt to make prediction to observation with missing
#' predictors using the weighted sum from a linear model
#'
#' @param data_wider Data.frame, which each row contains all the observations of a single person.
#' @param model A lm object, the fitted linear model.
#'
#' @return A vector with length nrow(data_wider), indicate the weighted sum prediction
#'
#' @export

wt_sum_predict <- function(data_wider, model){
  intercept <- model$coefficients[[1]]
  weights <- model$coefficients[-1]
  if(any(model$coefficients[-1]<0)) warning("There is negative weight, weighted sum is not corrected!\n")

  sum_weights <- sum(weights)
  weighted_sum <- data_wider |>
    dplyr::select(dplyr::all_of(names(weights))) |>
    as.matrix() |>
    apply(1, function(x) weighted.mean(x, weights, na.rm = TRUE))
  wt_sum_predict <- weighted_sum*sum_weights + intercept
  wt_sum_predict
}
