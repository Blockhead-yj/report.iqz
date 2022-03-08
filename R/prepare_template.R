#' @title prepare the prediction template
#'
#' @description copy the prediction template into current work directory
#'
#' @param template_name the name of template you want to use
#'
#' @return None
#'
#' @export
#'

prepare_template <- function(template_name = "Sreport.predict.tmpl"){
  if (file.exists(glue::glue("./archetypes/{template_name}"))) {
    file.rename(glue::glue("./archetypes/{template_name}"), glue::glue("./archetypes/{template_name}.Rmd"))
  }
  file(glue::glue("./archetypes/{template_name}.Rmd"))
}
