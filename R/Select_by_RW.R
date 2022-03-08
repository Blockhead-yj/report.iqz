#' @title Select predictor games by relative weight of predictors
#'
#' @description Usually users will have lots of iquizoo games test at once,
#' however it is bad idea to put all the games into a model to predict academic
#' score, which might cause the problem of overfitting or a decline of adjust r squared.
#' So we choose a subset of iquizoo games to be placed into the model by drop the
#' least import variable, according to relative analysis.
#'
#' @param data_wider Data.frame, which each row contains all the observations of a single person.
#' @param formula Formula, indicate which variables should be included in model. Or a lm object,
#' the formula will be the call of model, ie. model$call.
#' @param n_tasks Numerical, a selection standard indicate how many tasks preserve.
#' @param least_RW Numerical, a selection standard indicate the least relative weight
#' the final selected task should have.
#'
#' @return a lm object with additional attribution "rw", relative weight
#' @export

select_by_RW <- function(data_wider, formula, n_tasks = 5, least_RW = NULL){
  stopifnot(is.numeric(n_tasks)&&(is.numeric(least_RW)|is.null(least_RW)))
  if(class(formula) == "lm") formula = as.formula(formula$call)

  complete_data <- data_wider |> tidyr::drop_na()
  outcome <- all.vars(formula)[[1]]
  predictors <- terms(formula, data = data_wider) |>  attr("term.labels")

  res_rw <- rwa::rwa(complete_data, outcome = outcome, predictors = predictors)$result
  if(!is.null(least_RW)){
    while(min(res_rw$Rescaled.RelWeight) < least_RW) {
      predictors <- res_rw |>
        dplyr::filter(Rescaled.RelWeight != min(Rescaled.RelWeight)) |>
        dplyr::pull("Variables")
      res_rw <- rwa::rwa(complete_data, outcome = outcome, predictors = predictors)$result
    }
  } else {
    while(nrow(res_rw) > n_tasks) {
      predictors <- res_rw |>
        dplyr::filter(Rescaled.RelWeight != min(Rescaled.RelWeight)) |>
        dplyr::pull("Variables")
      res_rw <- rwa::rwa(complete_data, outcome = outcome, predictors = predictors)$result
    }
  }
  out <- lm(as.formula(paste(outcome, "~", paste(predictors, collapse = "+"))), data = complete_data)
  out[["rw"]] <- res_rw
  out
}
