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
#' @param idx_game Unquoted expression, colname of the unique index of game, default game_name
#' @param idx_user Unquoted expression, colname of the unique index of user, default user_id
#' @param ob_value Unquoted expression, colname of the observed value, default game_score_raw
#'
#' @return A [tibble][tibble::tibble-package] contains following values:
#'   \item{idx_game}{index of game, will be the same as input.}
#'   \item{finish_rate}{finish rate of the games}
#'
#' @export


rate_GameFinish <- function(data,
                            idx_game = game_name,
                            idx_user = user_id,
                            ob_value = game_score_raw,
                            plot = FALSE){

  idx_game <- rlang::enquo(idx_game)
  idx_user <- rlang::enquo(idx_user)
  ob_value <- rlang::enquo(ob_value)

  minimal_data <- data |>
    dplyr::ungroup() |>
    dplyr::select(!!idx_game, !!idx_user, !!ob_value) |>
    dplyr::mutate(ob_value = !is.na(!!ob_value), .keep="unused") |>
    unique() |>
    tidyr::complete(!!idx_game, !!idx_user, fill = list(ob_value = FALSE))

  n_users <- minimal_data |>
    dplyr::distinct(!!idx_user) |>
    nrow()

  out <- minimal_data |>
    dplyr::group_by(!!idx_game) |>
    dplyr::summarise(
      finish_rate = mean(ob_value),
      .groups = "drop"
      )
  if(plot) {
    p <-  ggplot2::ggplot() +
      ggplot2::geom_raster(
        data = minimal_data,
        ggplot2::aes(reorder(!!idx_game, ob_value, sum),
                     reorder(!!idx_user, ob_value, sum),
                     fill = ob_value),
        alpha = 0.8) +
      ggplot2::scale_fill_manual(
        name = "",
        values = c("tomato3", "steelblue"),
        labels = c("Missing", "Present")) +
      ggplot2::labs(x = "Game Name",
                    y = "user",
                    title = "Missing values") +
      ggplot2::theme_minimal() +
      ggplot2::scale_y_discrete(breaks = NULL) +
      ggplot2::geom_text(
        data = out,
        ggplot2::aes(!!idx_game, n_users*0.1,
                     label = format(finish_rate, digits = 3))) +
      ggplot2::coord_flip()
    plot(p)
  }
  out
}
