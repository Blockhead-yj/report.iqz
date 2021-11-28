#' @title prepare the prediction template
#'
#' @description copy the prediction template into current work directory
#'
#' @param None
#'
#' @return None
#'
#' @export
#'

prepare_template <- function(){
  usethis::use_directory("archetypes")
  usethis::use_template("report.predict.tmpl.Rmd", save_as = "archetypes/report.predict.tmpl.Rmd", package = "report.iqz")
}
