#' read all induction data in a file measured by LI-6800 (BLUE > 1.2.2)
#' @description use read_excel and a for loop to bombine all the data measured,
#' only contain modulation fluorescence for now.
#'
#' @param file_dir is the file directory only contains all the measured
#' data saved as .xlsx.
#'
#' @details
#'
#' the aim is to quickly import all data measured by LI-6800 to R for further use.
#' data are imported by read_excel from package readxl, by a for loop, the data are
#' all combine with rbind and we list the file name which the data come from.
#'
#' @examples
#' \dontrun{
#' library(jiptest)
#' read_all_induction('./ojip')
#' }
#'
#' @export

read_all_induction <- function(file_dir) {
  fi <- list.files(file_dir, full.names = TRUE)

  #read_induction <- match.fun(read_induction)
  jip_list <- lapply(fi, read_induction)

  ojip <- do.call("rbind", jip_list)
  # important to make jip the first class attribute
  class(ojip) <- c("jip", class(ojip))
  return(ojip)
}


