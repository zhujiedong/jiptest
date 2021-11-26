#' calculate the area under curve (BLUE > 1.2.2)
#' @description use a method similar method like trapezium intergration
#'
#' @param df data of a type dataframe.
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

area_cal <- function(df) {
  df$logs <- log(df$SECS)
  n <- nrow(df)
  auc <- with(df, sum(diff(logs)*rollmean(NORM_FLUOR,2)))
  auc
}
