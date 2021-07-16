#' @title Predict by weighted sum
#'
#' @description This is a attempt to make prediction to observation with missing
#' predictors using the weighted sum from a linear model
#'
#' @param data_wider Data.frame, which each row contains all the observations of a single person.
#' @param model A lm object, the fitted linear model.
#'
#' @return A [tibble][tibble::tibble-package] with the prediction values add on the right
#'
#' @export

wt_sum_predict <- function(data_wider, model){
  if(any(model$coefficients[-1]<0)) warning("There is negative weight, weighted sum is not corrected!\n")
  intercept <- model$coefficients[[1]]
  sum_weights <- sum(model$coefficients[-1])
  model_prediction <- predict(model,data_wider)
  weighted_sum <- data_wider %>%
    select(names(model$coefficients[-1])) %>%
    as.matrix() %>%
    apply(1, function(x) weighted.mean(x, model$coefficients[-1], na.rm = TRUE))
  wt_sum_predict <- weighted_sum*sum_weights + intercept
  data_wider %>%
    mutate(mod_predict = model_prediction,
           wt_sum_predict = wt_sum_predict)
}
