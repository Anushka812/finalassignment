#' read dataset
#'
#' this program reads datasets in from the local system.
#'
#' @export
#' @import dplyr
#' @author Anushka Jain
#' @title inputData
#' @param df data frame
#' @return data frame

readdata <- function(df) {
  df <- as.data.frame(brcawi)
  return(df)
}
