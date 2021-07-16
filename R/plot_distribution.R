#' @title Plot the distribution by group
#'
#' @description Check the distribution of game scores or academic scores is often
#' needed, this function is used to do this. It plot the distribution by groups
#' (game_name or subject_name).
#'
#' @param data Data.frame, contains group column and observation value column
#' @param ob_value String, colname of the observed value, default "game_score_raw"
#' @param group Formula, indicate the facet variables, default ~ game_name
#' @param bins Numerical, how much bins are used in geom_histogram, default 50
#'
#' @return a ggplot object
#'
#' @export

plot_distribution <- function(data, ob_value = "game_score_raw", group = ~ game_name, bins = 50){
  stopifnot("multiple observation value column is not supported!" = length(ob_value)==1)
  p <- data %>%
    rename(ob_value = all_of(ob_value)) %>%
    filter(!is.na(ob_value)) %>%
    ggplot(aes(ob_value)) +
    geom_histogram(bins = bins) +
    facet_wrap(group, scales = "free") +
    theme_minimal() +
    xlab(ob_value)
  p
}

