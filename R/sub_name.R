#' set the category of the data
#' @description to separate the data related to the excel files. add a new column
#' of data that represent the treatment/replications etc.
#'
#' @param df data of a type dataframe (contains the SOURCE column that specify which
#' excel files that the data have come fromm).
#'
#' @details
#'
#' use Soto's answer as
#'  https://stackoverflow.com/questions/4954507/calculate-the-area-under-a-curve
#'
#' @examples
#' \dontrun{
#' library(jiptest)
#' area_cal(df)
#' }

#' @export


sub_name <- function(df, category) {
  sub_source <- df$SOURCE
  source <- unique(df$SOURCE)
  stopifnot(
    "category must have the same length with unique(df$SOURCE)" =
      length(source) == length(category)
  )
  for (i in 1:length(source)) {
    sub_source <- gsub(source[i], category[i], sub_source)
  }
  sub_source
}
