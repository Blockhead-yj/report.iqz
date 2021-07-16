#' @title Select predictor games by step regression
#'
#' @description Usually users will have lots of iquizoo games test at once,
#' however it is bad idea to put all the games into a model to predict academic
#' score, which might cause the problem of overfitting or a decline of adjust r squared.
#' So we choose a subset of iquizoo games to be placed into the model by step regression.
#'
#' @param data_wider Data.frame, which each row contains all the observations of a single person
#' @param formula Formula, indicate which variables should be included in model
#' @param ... Other arguments used in stats::step function
#'
#' @return A lm object
#'
#' @export

step_lm <- function(data_wider, formula, trace = FALSE, ...){
  complete_data <- drop_na(data_wider)
  tmp_model <- lm(formula, data = complete_data)
  step(tmp_model, trace = trace, ...)
  }
