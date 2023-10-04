#' pca analysis
#'
#' this program takes input as data frame and performs principal component analysis on the data.
#'
#' @export
#' @import caret
#' @import corrplot
#' @import ggplot2
#' @import ggfortify
#' @import dplyr
#' @import tibble
#' @author Anushka Jain
#' @name input data
#' @title pcabrca
#' @param df data frame
#' @return plots and data frames

pcabrca <- function(df) {
  df$diagnosis[is.na(df$diagnosis)] <- 0
  df = pcabrca(df)
  df$diagnosis <- as.factor(df$diagnosis)
  map_int(df, function(.x) sum(is.na(.x)))
  round(prop.table(table(df$diagnosis)), 2)
  df_corr <- cor(df %>% select(-id, -diagnosis, -X))
  corrinfo <- corrplot(df_corr, order = "hclust", tl.cex = 1, addrect = 8)

  df2 <- df %>% select(-X, -findCorrelation(df_corr, cutoff = 0.8, verbose=TRUE))
  ncol(df2)

  preproc_pca_df <- prcomp(df %>% select(-id, -diagnosis, -X), scale = TRUE, center = TRUE)
  pca_df_var <- preproc_pca_df$sdev^2
  pve_df <- pca_df_var / sum(pca_df_var)
  cum_pve <- cumsum(pve_df)
  pve_table <- tibble(comp = seq(1:ncol(df %>% select(-id, -diagnosis, -X))), pve_df, cum_pve)
  cumulativedata <- ggplot(pve_table, aes(x = comp, y = cum_pve)) +
    geom_point() +
    geom_abline(intercept = 0.95, color = "red", slope = 0) +
    labs(x = "Number of components", y = "Cumulative Variance")
  pca_df <- as_tibble(preproc_pca_df$x)
  pccomp <- ggplot(pca_df, aes(x = PC1, y = PC2, col = df$diagnosis)) + geom_point()
  autocomp <- autoplot(preproc_pca_df, data = df,  colour = 'diagnosis',
                       loadings = FALSE, loadings.label = TRUE, loadings.colour = "blue")
  return(corrinfo)
  return(summary(preproc_pca_df))
  return(cumulativedata)
  return(pccomp)
  return(autocomp)
}
