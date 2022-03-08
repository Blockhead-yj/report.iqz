#' @title Quik Histogram Plot
#'
#' @description This function is a wrapper of [ggplot2::geom_histogram()], usually used to
#' check the distribution of game scores or academic scores. If group is assigned, it will
#' plot the distribution by groups (usually game_name or subject_name).
#'
#' @param data Data.frame, the data
#' @param x Unquoted expression, colname of the observation value, default game_score_raw
#' @param group Formula, indicate the facet variables
#' @param bins Numerical, how much bins are used in geom_histogram, default 50
#'
#' @return a ggplot object
#'
#' @export

plot_distribution <- function(data, x = game_score_raw, group = NULL, bins = 50){
  x <- rlang::enquo(x)

  p <- data |>
    ggplot2::ggplot(aes(!!x)) +
    ggplot2::geom_histogram(bins = bins) +
    ggplot2::theme_minimal()
  if(!is.null(group)){
    stopifnot("group must be a formula" = (class(group)=="formula"))
    p <- p + ggplot2::facet_wrap(group, scales = "free")
  }
  p
}
