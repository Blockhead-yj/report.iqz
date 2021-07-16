#' @title plot the scatter plot of game score and academic score by group
#'
#' @description This function is used to check the scatter distribution of
#' game scores and academic scores, correlation will be calculate if specified
#'
#' @param data Data.frame, contains two observation value column and groups column
#' @param ob_value_x,ob_value_y String, colname of the observation value
#' @param group Formula, indicate the facet variables
#' @param cor Logical, indicate whether plot correlation or not
#'
#' @return a ggplot object
#'
#' @export

plot_scatter <- function(data, ob_value_x = "game_score_raw", ob_value_y = "acd_score", group, cor = FALSE){
  stopifnot("multiple observation value column is not supported!" = length(ob_value_x)==1&&length(ob_value_y)==1)
  p <- data %>%
    select(all_of(all.vars(group)), ob_value_x = all_of(ob_value_x), ob_value_y = all_of(ob_value_y)) %>%
    ggplot(aes(ob_value_x, ob_value_y)) +
    geom_point() +
    facet_wrap(group, scales = "free", labeller = "label_both") +
    labs(x = ob_value_x, y = ob_value_y)
  if(cor) p <- p + ggpubr::stat_cor()
  p
}
