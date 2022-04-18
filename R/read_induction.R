#' calculate the area under curve (BLUE > 1.2.2)
#' @description read fluorescence files and keep the normal data
#'
#' @param path path of and excel file.
#'
#' @details {read a single LI-6800 INDUCTION  EXCEL FILE}
#'

#' @examples
#' \dontrun{
#' library(jiptest)
#' read_induction('df.xlsx')
#' }

#' @export

read_induction <- function(path) {
  df <- readxl::read_excel(path, skip = 1, col_names = FALSE)
  df$SOURCE <- gsub(".xlsx", "", basename(path), ignore.case = TRUE)
  names(df) <-
    c('EVENT_ID',
      'TRACE_NO',
      'space',
      'SECS',
      'FLUOR',
      'DC',
      'PFD',
      'REDMODAVG',
      'CODE',
      'SOURCE')
  # normalized y axis -------------------------------------------
  #no. of each factors
  n <- which(df$CODE %in% (3:6))
  df <- df[n, ]
  df$space <- NULL

  df$NORM_FLUOR <- (df$FLUOR - min(df$FLUOR)) / (max(df$FLUOR) - min(df$FLUOR))
  df$NORM_DC <- (df$DC-min(df$DC))/(max(df$DC)-min(df$DC))
  df$MILLI_SEC <- df$SECS * 1000

  # important to make jip the first class attribute
  class(df) <- c("jip", class(df))
  return(df)
}
