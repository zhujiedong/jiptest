#' apply jip test data analysis to the data measured by LI-6800
#' @description return jip test parameters from the induction data measured by
#' LI-6800.
#'
#' @param df dataframe that contains the induction data.
#' @param use_PAM if TRUE use the PAM fluorescence signal, else use the continiuous signal
#'
#' @details
#'
#' the aim is to quickly calculate all the jip test parameters in batch, as one usually
#' take large number of data in one measurement.
#'
#' @examples
#' \dontrun{
#' library(jiptest)
#' jip_test('./ojip1_2_2', 'd:/testdata/')
#' }
#' @importFrom data.table rbindlist
#' @export
#'

jip_test <- function(df, use_PAM = FALSE) {

  split_data <- split(df, df$SOURCE)

  if(use_PAM){
    list_df <- lapply(split_data, jip_comp, use_PAM = TRUE)
  }else{
    list_df <- lapply(split_data, jip_comp)
  }
  ojip_data <- data.table::rbindlist(list_df)
}
