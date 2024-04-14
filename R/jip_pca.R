#' @title return the prcomp
#'
#' @description {help to tidy the \code{jiptest} result to be ready for
#' PCA analysis }
#'
#' @param jip_data data frame returned by \code{jip_test}

#'
#' @export
#'



jip_pca <- function(jip_data){
  pca_list <- split(jip_data, jip_data$OJIP_PARAMETERS)
  list_data <- lapply(pca_list, extract_ojip)
  pca_data <- Reduce(function(df1, df2){merge(df1, df2)}, list_data)
  pca_data
}
