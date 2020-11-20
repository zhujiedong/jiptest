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
#' read_files('./ojip1_2_2')
#' }

#' @export

read_files <- function(file_dir) {
  message(
    "\ncurrently we should use the default 1 secs settings of saturate pulse\n"
  )
  fi <- list.files(file_dir, full.names = TRUE)
#  fi_names <- stringr::str_replace(fi, paste(file_dir, "/", sep = ""), "")
#  fi_names <- stringr::str_replace(fi_names, ".xlsx", "")
  fi_names <- gsub(paste0(file_dir, "/"), "", fi, ignore.case = TRUE)
  fi_names <- gsub(".xlsx", "", fi_names, ignore.case = TRUE)

  jip_list <- lapply(fi, readxl::read_excel, range = "D8:E931",
                     col_names = FALSE)
  ojip <- do.call("rbind", jip_list)

  l <- length(8:931)

  ojip$SOURCE <- rep(fi_names, 1, each = l)
  names(ojip) <- c("SECS", "FLUOR", "SOURCE")
  ojip <- as.data.frame(ojip)
  ojip <- ojip[order(ojip$SOURCE),]
  # normalized y axis -------------------------------------------
  #no. of each factors
  fct <- as.factor(ojip$SOURCE)
  max_flr <- with(ojip, tapply(FLUOR, fct, max))
  n_group <- table(fct)
  n_source <- unlist(mapply(rep, max_flr, each = n_group))
  #if each elements in n_group are the same, n_source will be arry
  n_source <- as.vector(n_source)
  ojip$NORM_FLUOR <- ojip$FLUOR / n_source
  #-------------------------------------------------------
  ojip <- ojip[c('SECS', 'FLUOR', 'NORM_FLUOR', "SOURCE")]
  # important to make jip the first class attribute
  class(ojip) <- c("jip", class(ojip))
  return(ojip)
}


