#' @title Quick Scatter Plot
#'
#' @description This function is a wrapper of [ggplot2::geom_point()], usually
#' used to check the scatter distribution of game scores and academic scores,
#' correlation will be calculate if specified
#'
#' @param data Data.frame, the data
#' @param x,y Unquoted expression, colname of the observation value
#' @param group Formula, indicate the facet variables
#' @param cor Logical, indicate whether plot correlation or not
#'
#'
#' @return a ggplot object
#'
#' @importFrom ggpubr stat_cor
#' @export

plot_scatter <- function(data, x = game_score_raw, y = acd_score, group = NULL, cor = FALSE){
  x <- rlang::enquo(x)
  y <- rlang::enquo(y)
  p <- data |>
    dplyr::select(!!x, !!y, all_of(all.vars(group))) |>
    ggplot2::ggplot(aes(!!x, !!y)) +
    ggplot2::geom_point()
  if(!is.null(group)) {
    stopifnot("group must be a formula" = (class(group)=="formula"))
    p <- p + ggplot2::facet_wrap(group, scales = "free")}
  if(cor) p <- p + ggpubr::stat_cor()
  p
}
