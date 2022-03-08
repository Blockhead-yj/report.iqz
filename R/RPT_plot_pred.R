#' @title Plot the prediction and judgment
#'
#' @description This function is used to visualize the result of prediction and
#' judgment.
#'
#' @param data_wider Data.frame, which each row contains all the observations of a single person.
#' @param x,y Unquoted expression, colname of the observation value
#' @param color Unquoted expression, colname of the potential judgment, default judgment
#'
#' @return A ggplot object
#'
#' @export

RPT_plot_pred <- function(data_wider, x = Z_acd_score, y = wt_sum_predict, color = judgment, r2 = RPT_r2(Curr_mod, adj = TRUE)){
  x <- rlang::enquo(x)
  y <- rlang::enquo(y)
  color <- rlang::enquo(color)
  # remove NA and rename columns
  detail_pred <- data_wider  |>
    filter(missing_prop <= 30) |>
    select(!!x, !!y, judgment = !!color) |>
    filter(!is.na(!!x), !is.na(!!y))

  # determine the range of plot, x axis and y axis will be the same length
  plot_range <- detail_pred |>
    summarise(
      XYmin = min(!!x, !!y, na.rm = TRUE),
      XYmax = max(!!x, !!y, na.rm = TRUE)
    ) |>
    as.list()
  # show the number of people in each judgment level on legend
  RPT_judgment_lvls <- report.iqz::judgment_lvls[-9] |>
    as_tibble_col(column_name = 'judgment') |>
    mutate(judgment = factor(judgment, levels = report.iqz::judgment_lvls))

  legend_label <- detail_pred |>
    group_by(judgment) |>
    summarise(n = n(), .groups="drop") |>
    right_join(RPT_judgment_lvls, by = 'judgment') |>
    mutate_if(is.numeric, ~replace_na(.x, 0)) |>
    mutate(n = str_pad(n,width = ceiling(log10(max(n))), side = "left") |> str_c("人"))  |>
    arrange(judgment) |>
    unite("labels",c(!!color, n), sep = ":")
  # plot the prediction and judgment
    p <- detail_pred |>
      right_join(RPT_judgment_lvls, by = 'judgment') |>
      ggplot() +
      geom_point(aes(!!x, !!y, color = judgment)) +
      geom_abline(aes(intercept = 0, slope = 1), color = "green") +
      scale_color_brewer(name = "潜力评价", label = legend_label$labels, palette = "Spectral")+
      scale_x_continuous(limits = c(plot_range$XYmin - 0.1*(plot_range$XYmax - plot_range$XYmin),
                                    plot_range$XYmax + 0.1*(plot_range$XYmax - plot_range$XYmin))) +
      scale_y_continuous(limits = c(plot_range$XYmin - 0.1*(plot_range$XYmax - plot_range$XYmin),
                                    plot_range$XYmax + 0.1*(plot_range$XYmax - plot_range$XYmin))) +
      xlab("学业学习力分数") +
      ylab("学业成绩标准分") +
      theme_minimal()+
      annotate("text",x = plot_range$XYmin , y = plot_range$XYmax , label = str_c("italic(R) ^ 2 == ",round(r2,2)),parse = TRUE)+
      theme(text = element_text(family = "SimHei"))
  p
}
