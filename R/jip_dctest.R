#' apply jip test data analysis to the data measured by LI-6800 in batch
#' @description return jip test parameters from the induction data measured by
#' LI-6800.
#'
#' @param file_dir is the file directory only contains all the measured data saved as .xlsx.

#' @details
#'
#' the aim is to quickly calculate all the jip test parameters in batch, as one usually
#' take large number of data in one measurement.
#'
#' @examples
#' \dontrun{
#' library(jiptest)
#' jip_dctest('./ojip', 'd:/testdata/')
#' }
#'
#' @export

jip_dctest <- function(file_dir) {
  message("for the current version, we suggest you use the default settings of the duration (1000 ms or more)
          in the induction settings of LI-6800")
  read_files <- match.fun(read_files)
  ojip <- read_dcfiles(file_dir)

  jip_comp <- match.fun(jip_comp)

  fi <- list.files(file_dir, full.names = TRUE)
  #  fi_names <- stringr::str_replace(fi, paste(file_dir, "/", sep = ""), "")
  #  fi_names <- stringr::str_replace(fi_names, ".xlsx", "")
  fi_names <- gsub(paste0(file_dir, "/"), "", fi, ignore.case = TRUE)
  fi_names <- gsub(".xlsx", "", fi_names, ignore.case = TRUE)
  n <- length(fi_names)

  array_results <- array(NA, dim = c(34, 1, n))
  para_names <- c("Fo", "Fm", "F300", "FJ", "FI", "Tfmax", "Area", "Fv", "Vj", "Mo", "Sm", "Ss", "N", "Vav", "phi_po", "phi_ET2o", "phi_RE1o", "psi_ET2o", "psi_RE1o", "delta_RE1o", "phi_Do", "phi_Pav",
                  "ABS_RC", "TR0_RC", "ET2o_RC", "RE1o_RC", "DI0_RC", "ABC_CS", "TR0_CS", "ET0_CS", "DI0_CS", "PIabs"," PItotal", "DFabs")
  for (i in 1:n) {
    array_results[, , i] <- jip_comp(ojip[which(ojip$SOURCE == fi_names[[i]]), ])

    output <- data.frame(para = para_names, values = array_results[, , 1:n])
    names(output) <- c("parameters", fi_names)
  }

  return(output)
}

