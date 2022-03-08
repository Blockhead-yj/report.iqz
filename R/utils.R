#' @export
#'
RPT_r2 <- function(model, adj=FALSE){
  if(adj) {
    out <- summary(model)$r.squared
  } else{
    out <- summary(model)$adj.r.squared
  }
  out
}

