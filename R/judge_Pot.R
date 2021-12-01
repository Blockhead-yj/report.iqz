#' @title Judge the potential
#'
#' @description Judge the potential of a student by his/her current academic performance
#' and predicted academic performance. It is assumed that the difference between
#' current academic performance and predicted academic performance is potential on academic.
#'
#' @param Curr_acd Numerical, current academic performance, standardized.
#' @param predict_acd, Numerical, predicted academic performance.
#' @param pot_lvl1,pot_lvl2 Numerical, the amount of potential needed for different level
#' @param abs_lvl1,abs_lvl2 Numerical, the absolute level away from average level(100) needed
#' for different level
#'
#' @return A factor vector, in which the factor levels are the predefined judgment.
#'
#' @export

judge_Pot <- function(Curr_acd, predict_acd, pot_lvl1 = 15, pot_lvl2 = 10, abs_lvl1 = 20, abs_lvl2 = 10){
  stopifnot("pot_lvl1 should be bigger than pot_lvl2"= pot_lvl1>pot_lvl2,
            "abs_lvl1 should be bigger than abs_lvl2"= abs_lvl1>abs_lvl2)
  potential = predict_acd - Curr_acd
  judge = case_when(
    potential >= pot_lvl1 & predict_acd >= (100 + abs_lvl2)                                   ~ "潜力巨大",
    potential >= pot_lvl2 & predict_acd >= 100                                                ~ "潜力较大",
    potential <= -pot_lvl2 & Curr_acd >= 100                                                  ~ "后劲较弱",
    potential <= -pot_lvl1 & Curr_acd >= (100 + abs_lvl2)                                     ~ "后劲不足",
    potential <= pot_lvl2 & predict_acd >= (100 + abs_lvl1)                                   ~ "总体优秀",
    potential <= pot_lvl2 & predict_acd >= 100 & predict_acd < (100 + abs_lvl1)               ~ "总体中等",
    predict_acd > 80 & predict_acd < 100                                                      ~ "有待改进",
    predict_acd <= 80                                                                         ~ "亟待提升",
    TRUE                                                                                      ~ "未定义"
    ) %>%
    factor(levels = judgment_lvls)
}
