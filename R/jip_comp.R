#' compute the parameters of jip test
#' @description only functions to calulate the parameters of jip test
#'
#' @param jip_data  data for jip test
#'
#' @details
#'
#'  provide core functions for jip_test, by changing the names of the data, it can also be used by other instruments.
#'
#' @examples
#' \dontrun{
#' library(jiptest)
#' jip_comp(data)
#' }
#'
#' @export
jip_comp <- function(jip_data) {
  # basic parameters for jip test
  Fo <- min(jip_data$FLUOR)
  To <- jip_data[which.min(jip_data$FLUOR), ]
  Tm <- jip_data[which.max(jip_data$FLUOR), ]
  Fm <- max(jip_data$FLUOR)
  TJ <- jip_data[which(jip_data$SECS > 0.0018 & jip_data$SECS < 0.0022), ]
  FJ <- max(TJ$FLUOR)
  TI <- jip_data[which(jip_data$SECS > 0.028 & jip_data$SECS < 0.032), ]
  FI <- max(TI$FLUOR)
  Tfmax <- Tm$SECS * 1000
  F300 <- mean(jip_data[which(jip_data$SECS > 0.00029 & jip_data$SECS < 0.00031), ]$FLUOR)
  Fmx <- Tm$SECS

  Area <- (max(jip_data$SECS)-min(jip_data$SECS)) * max(jip_data$FLUOR) -
    MESS::auc(jip_data$SECS, jip_data$FLUOR, type = "spline")

  We100 <- 1 - (1 - (F300 - Fo)/(Fm - Fo))^(1/5)
  W100 <- (mean(jip_data[which(jip_data$SECS > 9e-05 & jip_data$SECS < 0.00011), ]$FLUOR) - Fo)/(Fm - Fo)

  # basic parameters
  Fv <- Fm - Fo
  Vj <- (FJ - Fo)/(Fm - Fo)
  Vi <- (FI - Fo)/(Fm - Fo)
  Mo <- 4 * (F300 - Fo)/Fv
  Sm <- Area/Fv
  Ss <- Vj/Mo
  N <- Sm/Ss
  Vav <- 1 - (Sm/Tfmax)

  # PSII photochemical yield
  phi_po <- 1 - (Fo/Fm)
  phi_ET2o <- phi_po * (1 - Vj)
  phi_RE1o <- phi_po * (1 - Vi)
  psi_ET2o <- 1 - Vj
  psi_RE1o <- 1 - Vi
  delta_RE1o <- (1 - Vi)/(1 - Vj)
  phi_Do <- Fo/Fm
  phi_Pav <- phi_po * (1 - Vav)

  # RC
  ABS_RC <- Mo * (1/Vj) * (1/phi_po)
  RC_ABS <- phi_po * (Vj/Mo)
  TR0_RC <- Mo/Vj
  ET2o_RC <- (Mo/Vj) * (1 - Vj)
  RE1o_RC <- (Mo/Vj) * (1 - Vi)
  DI0_RC <- ABS_RC - TR0_RC

  #CS
  ABS_CS <- Fo
  TR0_CS <- phi_po * ABS_RC
  ET0_CS <- phi_po * psi_ET2o * ABS_RC
  DI0_CS <- ABS_CS - TR0_CS

  # PI(Performance indexes)
  PIabs <- RC_ABS * phi_po/(1 - phi_po) * psi_ET2o/(1 - psi_ET2o)
  PItotal <- PIabs * (delta_RE1o/(1 - delta_RE1o))
  #
  DFabs <- log(RC_ABS) + log(phi_po/(1 - phi_po)) + log(psi_ET2o/(1 - psi_ET2o))



  para_values <- c(Fo, Fm, F300, FJ, FI, Tfmax, Area, Fv, Vj, Mo, Sm, Ss, N, Vav, phi_po, phi_ET2o, phi_RE1o, psi_ET2o, psi_RE1o, delta_RE1o, phi_Do, phi_Pav,
                   ABS_RC, TR0_RC, ET2o_RC, RE1o_RC, DI0_RC, ABS_CS, TR0_CS, ET0_CS, DI0_CS, PIabs, PItotal, DFabs)

  return(para_values)

}


