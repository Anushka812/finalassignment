#' read dataset
#'
#' this program reads datasets in from the local system.
#'
#' @export
#' @import dplyr
#' @author Anushka Jain
#' @title inputData
#' @param na.rm
#' @return data frame

readdata <- function() {
  df <- data("~/data/df.rda")
  return(df)
}
