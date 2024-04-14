#' calculate the area under curve (BLUE > 1.2.2)
#' @description use a method similar method like trapezium intergration
#'
#' @param df data of a type dataframe.
#' @param use_PAM indicate to use PAM or continuous fluorescence signals
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

area_cal <- function(df, use_PAM = FALSE) {
  df$logs <- log(df$MILLI_SEC)
  j <- which(df$FLUOR == max(df$FLUOR))
  df <- df[1:j, ]
  if (use_PAM) {
    auc <- with(df, sum(diff(logs) * zoo::rollmean(FLUOR, 2)))
    a_total <- with(df, (max(FLUOR) - min(FLUOR)) * (max(logs) - min(logs)))
  } else{
    # df$logs <- log(df$MILLI_SEC)
    # j <- which(df$DC == max(df$DC))
    # df <- df[1:j, ]
    auc <- with(df, sum(diff(logs) * zoo::rollmean(DC, 2)))
    a_total <- with(df, (max(DC) - min(DC)) * (max(logs) - min(logs)))

  }
  return(a_total-auc)
}
