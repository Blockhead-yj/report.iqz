#' @title Calculate the missing proportion of predictors by relative weight
#'
#' @description There is a situation that we want to make prediction for
#' incomplete observation, which a linear model don't support. However, we try to
#' approximitly predict those imcomplete observation with small missing part.
#' So, this function is used to calculate the missing proportion of predictors,
#' the weight fo each predictor is from relative weight analysis.
#'
#' @param data_wider Data.frame, which each row contains all the observations of a single person.
#' @param RelativeWeight Data.frame, generate by rwa::rwa, contains the relative weight of
#' each variable
#'
#' @return A [tibble][tibble::tibble-package] with the missing proportion of predictors add on the right
#'
#' @export

calc_missing_prop <- function(data_wider, RelativeWeight){
  complete_prop <- data_wider %>%
    select(RelativeWeight[["Variables"]]) %>%
    mutate_all(~!is.na(.x)) %>%
    as.matrix() %>%
    `%*%`(RelativeWeight[["Rescaled.RelWeight"]]) %>%
    drop()
  data_wider %>%
    mutate(missing_prop = round(100 - complete_prop, 1))
}
