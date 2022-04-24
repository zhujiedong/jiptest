#' compute the parameters of jip test
#' @description only functions to calulate the parameters of jip test
#'
#' @param df  data for jip test
#' @param use_PAM if TRUE use the PAM fluorescence signal, else use the continiuous signal
#'
#' @details
#'
#'  provide core functions for jip_test, calculation based on Revisiting JIP-test: An educative review on concepts,
#'  assumptions, approximations, definitions and terminology
#' @examples
#' \dontrun{
#' library(jiptest)
#' jip_comp(data)
#' }
#'
#' @export
#'


jip_comp <- function(df, use_PAM = FALSE) {

  if (use_PAM) {
    #DATA EXTRACTED FROM THE RECORDED FLUORESCENCE TRANSIENT OJIP
    Ft <- df$FLUOR # MULTIPLE VALUE
    F20us <- Ft[time_us(df$SECS, 20)]
    F50us <- Ft[time_us(df$SECS, 50)]
    F100us <- Ft[time_us(df$SECS, 100)]
    F300us <- Ft[time_us(df$SECS, 300)]
    FJ <- Ft[time_ms(df$SECS, 2)]
    FI <- Ft[time_ms(df$SECS, 30)]
    FP <- max(Ft)[1]
    tFm <- df$MILLI_SEC[which(FP == max(Ft)[1])]
    Area <- area_cal(df, use_PAM = TRUE)

    # BASIC PARAMETERS CALCULATED FROM THE EXTRACTED DATA
    FO <- F20us
    FM <- FP
    Fv <- Ft - FO # MULTIPLE VALUE
    FV <- FM - FO
    # MULTIPLE VALUE
    #-----------------------------
    Vt <- Fv / FV
    W_OJ <- (Ft - FO) / (FJ - FO)
    W_OI <- (Ft - FO) / (FI - FO)
    W_JI <- (Ft - FJ) / (FI - FJ)
    W_IP <- (Ft - FI) / (FP - FI)
    W_O300us <- (Ft - FO) / (F300us - FO)

    # ----------------------------
    VJ <- (FJ - FO) / FV
    VI <- (FI - FO) / FV

    MO <- 4 * (F300us * F50us) / FV
    Sm <- Area / FV
    Ss <- VJ / MO
    #Vav <- 1 - (Sm / tFm)

    # BIOPHYSICAL PARAMETERS DERIVED FROM THE BASIC PARAMETERS BY THE JIP-TEST

    # Quantum yields and efficiencies
    phi_Pt <- 1-Ft/FM # MULTIPLE VALUE
    phi_Po <- 1 - (FO / FM)
    phi_Eo <- (1-FO/FM) * (1-VJ)
    phi_Ro <- (1-FO/FM) * (1-VI)

    Psi_Eo <- (1-VJ)
    delta_Ro <- (1-VI)/(1-VJ)

    #Specific energy fluxes (per RC: Q A -reducing PSII reaction centre)

    ABS_RC <- MO * (1 / VJ) * (1 / phi_Po)

    TRo_RC <-  MO * (1/VJ)
    ETo_RC <- MO * (1/VJ) * (1 - VJ)
    REo_RC <- MO * (1/VJ) * (1 - VI)

    # Other biophysical parameters

    ECo_RC <- Area/FV
    Sm <- ECo_RC
    N <- Sm * (MO/VJ)
    RC_ABS <- 1/ABS_RC
    gamma_RC <- RC_ABS/(RC_ABS + 1)

    # Performance indexes

    PI_ABS <- gamma_RC/(1 - gamma_RC) * (phi_Po)/(1-phi_Po) * Psi_Eo/(1-Psi_Eo)
    PI_total <-PI_ABS * delta_Ro/(1- delta_Ro)

  } else{
    #DATA EXTRACTED FROM THE RECORDED FLUORESCENCE TRANSIENT OJIP
    Ft <- df$DC # MULTIPLE VALUE
    F20us <- Ft[time_us(df$SECS, 20)]
    F50us <- Ft[time_us(df$SECS, 50)]
    F100us <- Ft[time_us(df$SECS, 100)]
    F300us <- Ft[time_us(df$SECS, 300)]
    FJ <- Ft[time_ms(df$SECS, 2)]
    FI <- Ft[time_ms(df$SECS, 30)]
    FP <- max(Ft)[1]
    tFm <- df$MILLI_SEC[which(FP == max(Ft)[1])]
    Area <- area_cal(df)

    # BASIC PARAMETERS CALCULATED FROM THE EXTRACTED DATA
    FO <- F20us
    FM <- FP
    Fv <- Ft - FO # MULTIPLE VALUE
    FV <- FM - FO
    # MULTIPLE VALUE
    #-----------------------------
    Vt <- Fv / FV
    W_OJ <- (Ft - FO) / (FJ - FO)
    W_OI <- (Ft - FO) / (FI - FO)
    W_JI <- (Ft - FJ) / (FI - FJ)
    W_IP <- (Ft - FI) / (FP - FI)
    W_O300us <- (Ft - FO) / (F300us - FO)

    # ----------------------------
    VJ <- (FJ - FO) / FV
    VI <- (FI - FO) / FV

    MO <- 4 * (F300us * F50us) / FV
    Sm <- Area / FV
    Ss <- VJ / MO
    #Vav <- 1 - (Sm / tFm)

    # BIOPHYSICAL PARAMETERS DERIVED FROM THE BASIC PARAMETERS BY THE JIP-TEST

    # Quantum yields and efficiencies
    phi_Pt <- 1-Ft/FM # MULTIPLE VALUE
    phi_Po <- 1 - (FO / FM)
    phi_Eo <- (1-FO/FM) * (1-VJ)
    phi_Ro <- (1-FO/FM) * (1-VI)

    Psi_Eo <- (1-VJ)
    delta_Ro <- (1-VI)/(1-VJ)

    #Specific energy fluxes (per RC: Q A -reducing PSII reaction centre)

    ABS_RC <- MO * (1 / VJ) * (1 / phi_Po)

    TRo_RC <-  MO * (1/VJ)
    ETo_RC <- MO * (1/VJ) * (1 - VJ)
    REo_RC <- MO * (1/VJ) * (1 - VI)

    # Other biophysical parameters

    ECo_RC <- Area/FV
    Sm <- ECo_RC
    N <- Sm * (MO/VJ)
    RC_ABS <- 1/ABS_RC
    gamma_RC <- RC_ABS/(RC_ABS + 1)

    # Performance indexes

    PI_ABS <- gamma_RC/(1 - gamma_RC) * (phi_Po)/(1-phi_Po) * Psi_Eo/(1-Psi_Eo)
    PI_total <-PI_ABS * delta_Ro/(1- delta_Ro)
  }
  VALUES <-
    c(
      F20us,
      F50us,
      F100us,
      F300us,
      FJ,
      FI,
      FP,
      #tFm,
      Area,
      FO,
      FM,
      FV,
      VJ,
      VI,
      MO,
      Ss,
      phi_Po,
      phi_Eo,
      phi_Ro,
      Psi_Eo,
      delta_Ro,
      ABS_RC,
      TRo_RC,
      ETo_RC,
      REo_RC,
      ECo_RC,
      Sm,
      N,
      RC_ABS,
      gamma_RC,
      PI_ABS,
      PI_total
    )
  OJIP_PARAMETERS <-
    c(
      'F20us',
      'F50us',
      'F100us',
      'F300us',
      'FJ',
      'FI',
      'FP',
      #tFm,
      'Area',
      'FO',
      'FM',
      'FV',
      'VJ',
      'VI',
      'MO',
      'Ss',
      'phi_Po',
      'phi_Eo',
      'phi_Ro',
      'Psi_Eo',
      'delta_Ro',
      'ABS_RC',
      'TRo_RC',
      'ETo_RC',
      'REo_RC',
      'ECo_RC',
      'Sm',
      'N',
      'RC_ABS',
      'gamma_RC',
      'PI_ABS',
      'PI_total'
    )
   return(data.frame(OJIP_PARAMETERS =OJIP_PARAMETERS,
                     VALUES = VALUES,
                     SOURCE = rep(df$SOURCE[1], length(VALUES))))
}




