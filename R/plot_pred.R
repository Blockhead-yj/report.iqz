#' @title Plot the prediction and judgment
#'
#' @description This function is used to visualize the result of prediction and
#' judgment.
#'
#' @param model_report List, the output of function [prepare_report()].
#'
#' @return A ggplot object
#'
#' @export

plot_pred <- function(model_report){
  x <- model_report$plot_x
  y <- model_report$plot_y
  # remove NA and rename columns
  detail_pred <- model_report$detail_pred %>%
    filter(across(all_of(c(x,y)), ~!is.na(.x))) %>%
    select(x = x, y = y)
  # determine the range of plot, x axis and y axis will be the same length
  XYmin = min(detail_pred[c(x, y)], na.rm = TRUE)
  XYmax = max(detail_pred[c(x, y)], na.rm = TRUE)
  # show the number of people in each judgment level on legend
  RPT_judgment_lvls <- judgment_lvls[-9] %>% as_tibble_col(column_name = color)
  legend_label <- detail_pred %>%
    group_by(across(all_of(color))) %>%
    summarise(n = n()) %>%
    right_join(RPT_judgment_lvls, by = color) %>%
    mutate_if(is.numeric, ~replace_na(., 0)) %>%
    mutate(n = str_pad(n,width = ceiling(log10(max(n))), side = "left") %>%
               str_c("人")) %>%
    unite("labels",c(judgment, n), sep = ":")
  # plot the prediction and judgment
  if(!is.null(model_report$background)){
    p <- ggplot() +
      geom_point(data = model_report$background,
                 aes(x, y, color = judgment),
                 alpha = 0.6) +
      geom_point(data = detail_pred,
                 aes(x, y),
                 alpha = 0.8,
                 size = 1) +
      geom_abline(aes(intercept = 0, slope = 1), color = "green") +
      scale_shape_manual(name = "潜力评价",values = 1:n_distinct(detail_pred$judgement)) +
      scale_color_brewer(name = "潜力评价", label = legend_label$labels, palette = "Spectral")+
      scale_x_continuous(limits = c(XYmin - 0.1*(XYmax - XYmin), XYmax + 0.1*(XYmax - XYmin))) +
      scale_y_continuous(limits = c(XYmin - 0.1*(XYmax - XYmin), XYmax + 0.1*(XYmax - XYmin))) +
      xlab("学业学习力分数") +
      ylab("学业成绩标准分") +
      theme_minimal()+
      annotate("text",x = XYmin , y = XYmax , label = str_c("italic(R) ^ 2 == ",round(model_report$adj_r2,2)),parse = TRUE)+
      theme(text = element_text(family = "SimHei"))
  } else {
    p <- ggplot(detail_pred) +
      geom_point(aes(x, y, color = judgment)) +
      geom_abline(aes(intercept = 0, slope = 1), color = "green") +
      scale_color_brewer(name = "潜力评价", label = legend_label$labels, palette = "Spectral")+
      scale_x_continuous(limits = c(XYmin - 0.1*(XYmax - XYmin), XYmax + 0.1*(XYmax - XYmin))) +
      scale_y_continuous(limits = c(XYmin - 0.1*(XYmax - XYmin), XYmax + 0.1*(XYmax - XYmin))) +
      xlab("学业学习力分数") +
      ylab("学业成绩标准分") +
      theme_minimal()+
      annotate("text",x = XYmin , y = XYmax , label = str_c("italic(R) ^ 2 == ",round(model_report$adj_r2,2)),parse = TRUE)+
      theme(text = element_text(family = "SimHei"))
  }
  p
}
