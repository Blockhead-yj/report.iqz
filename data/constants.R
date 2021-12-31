#' @title Some needed constants for report
#'
#' @description some needed constants for report such as subject names, judgment
#' levels and corresponding descriptions
#'
#' @export

# potential judgment
judgment_lvls <- c("潜力巨大", "潜力较大", "后劲较弱", "后劲不足", "总体优秀", "总体中等", "有待改进", "亟待提升", "未定义")

# ability judgment descriptions
judgment_description <- dplyr::tribble(
  ~judgment, ~description,
  "潜力巨大","学业潜能分数高于当前学业成绩标准分很多，而且学业潜能分数在平均水平之上，有巨大的提升潜力",
  "潜力较大","学业潜能分数高于当前学业成绩标准分少许，而且学业潜能分数基本在平均水平之上，仍有较大的提升潜力",
  "后劲不足","学业潜能分数低于当前学业成绩标准分很多,说明当前已经充分发挥出了自己的潜力，后续提升空间不大",
  "后劲较弱","学业潜能分数低于当前学业成绩标准分少许,说明当前已经较好的发挥出了自己的潜力，后续提升空间较小",
  "总体优秀","学业潜能分数与当前学业成绩基本相当，而且学业潜能分数在较高水平，总体潜力和已经开发的潜力都很高，总体优秀，继续保持",
  "总体中等","学业潜能分数与当前学业成绩基本相当，而且学业潜能分数在中上水平，总体潜力和已经开发的潜力都较高，总体中等",
  "有待改进","学业潜能分数处于中下水平，学业潜能有待通过一定方法改进",
  "亟待提升","学业潜能分数处于较低水平，亟需通过一定方法提升潜能"
)

# possible subject names
subjects <- c("语文", "数学", "英语", "外语", "科学", "物理", "化学", "生物", "社会", "道德与法治", "道法", "政治", "历史", "地理", "总分")

# regular exepression of questionairs
questionairs <- "问卷|症状|量表|满意度|(?<!数)感|测查|社会|人格|职业"
