#' @title Calculate the finish rate of every game and plot it
#'
#' @description This function is used to check the finish rate of multiple games,
#' since there is always some missing value in the iquizoo data. To get a more
#' complete data, it is useful to drop some games that finish rate is too low.
#' Given a `data.frame` contains essential columns (usually "game_name",
#' "user_name"/"user_id", and "game_score_raw"), this function will calculate
#' the finish rate of every game and plot it if needed.
#'
#' @param data Data.frame, contains the essential data(index of game, index of user,
#' observed value).
#' @param plot Logical value indicate if plot the finish rate or not, default `FALSE`
#' @param idx_game String, colname of the unique index of game, default "game_name"
#' @param idx_user String, colname of the unique index of user, default "user_id"
#' @param ob_value String, colname of the observed value, default "game_score_raw"
#'
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{idx_game}{index of game, will be the same as input.}
#'   \item{finish_rate}{finish rate of the games}
#'
#' @export


rate_GameFinish <- function(data, plot = FALSE, idx_game = "game_name", idx_user = "user_id", ob_value = "game_score_raw"){
  stopifnot(exprObject = length(idx_game)==1&&length(idx_user)==1&&length(ob_value)==1)
  minimal_data <- data %>%
    ungroup() %>%
    select(idx_game = all_of(idx_game),
           idx_user = all_of(idx_user),
           ob_value = all_of(ob_value)) %>%
    mutate(ob_value = !is.na(ob_value)) %>%
    unique() %>%
    complete(idx_game, idx_user, fill = list(ob_value = FALSE))
  out <- minimal_data %>%
    group_by(idx_game) %>%
    summarise(finish_rate = mean(ob_value), .groups = "drop")
  if(plot) {
    p <-  ggplot() +
      geom_raster(data = minimal_data, aes(
        reorder(idx_game, ob_value, sum),
        reorder(idx_user, ob_value, sum),
        fill = ob_value),
        alpha = 0.8) +
      scale_fill_manual(name = "",
                        values = c("tomato3", "steelblue"),
                        labels = c("Missing", "Present")) +
      labs(x = "Game Name", y = "user", title = "Missing values") +
      theme_minimal() +
      scale_y_discrete(breaks = NULL) +
      geom_text(data = out, aes(idx_game, n_distinct(minimal_data$idx_user)*0.1, label = format(finish_rate, digits = 3))) +
      coord_flip()
    plot(p)
    }
  out
  }


