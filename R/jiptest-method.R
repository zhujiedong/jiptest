#' @title plot jip test data measured by LI-6800
#'
#' @description {a quick way to preview the quality
#' of measured data.graphical preview of all the data
#' curves in log axis (BLUE > 1.2.2), use normalized signal}
#'
#' @param df files read by \code{read_induction} or \code{read_all_induction}
#' @param def_pch the pch of default plot method
#' @param alpha the transparent degree of colors in the plot
#' @param legend_pos inherited from \code{legend} position
#' @param leg_cex text size of legend
#' @param leg_point_cex point size of legend
#' @param leg_bty bty in \code{legend}
#' @param xlim Limits for the Y axis, the default should be enough
#' for most cases
#' @param ylim Limits for the Y axis, if left blank estimated from data
#' @param xlab inherited from plot.default
#' @param ylab inherited from plot.default
#' @param col inherited from plot.default
#' @param log inherited from plot.default
#' @param xmark x tick marks values
#' @param xat at which the x axis tick marks are ploted
#' @param use_PAM whether to use pam signal, default FALSE
#' @param add_leg defaut is true, add lengend directly
#' @param add_grid add grid lines in the plot if TRUE(default)
#' @param ... other parameters in \code{plot}
#' @importFrom graphics points
#' @importFrom graphics abline
#' @importFrom graphics legend
#' @importFrom graphics text
#' @importFrom grDevices palette.colors
#' @importFrom graphics axis
#' @importFrom graphics grid
#' @export
#'

plot.jip <- function(df,
                     alpha = 0.6,
                     def_pch = 19,
                     col = NULL,
                     leg_bty = "n",
                     leg_cex = 0.6,
                     leg_point_cex = 0.9,
                     legend_pos = "topleft",
                     xlim = NULL,
                     ylim = c(0, 1),
                     log = "x",
                     xlab = "Time (ms)",
                     ylab = "Fluorescence signal",
                     xmark = c(expression(10^{-3}, 10^{-2}, 10^{-1},
                                          10^{0}, 10^{1}, 10^2, 10^3)),
                     xat = c(0.001, 0.01, 0.1, 1, 10, 100, 1000),
                     use_PAM = FALSE,
                     add_leg = TRUE,
                     add_grid = TRUE,
                     ...){

  # colors ------------------------------------------------------------------

  ncols <- length(unique(df$SOURCE))
  fct <- as.factor(df$SOURCE)
  if (is.null(col)) {
    col <-
      palette.colors(n = ncols,
                     "set 1",
                     alpha = alpha,
                     recycle = TRUE)
  }

# define pch --------------------------------------------------------------
  #ifelse returns a value with the same shape as test
  if(length(def_pch)>1){
    def_pch <- def_pch[fct]
  } else{
    def_pch
  }

# plot --------------------------------------------------
  if (use_PAM){
    with(
      df,
      plot(
        MILLI_SEC,
        NORM_FLUOR,
        log = "x",
        xlim = xlim,
        ylim = ylim,
        xlab = xlab,
        ylab = ylab,
        col = col[fct],
        pch = def_pch,
        xaxt = "n",
        ...
      )
    )
    if(add_grid){grid()}
    axis(1, at = xat, labels = xmark)
    if (add_leg){
      legend(
        legend_pos,
        unique(df$SOURCE),
        col = col,
        pch = def_pch,
        cex = leg_cex,
        pt.cex = leg_point_cex,
        bty = leg_bty,
        ...
      )
    }} else{
    with(
      df,
      plot(
        MILLI_SEC,
        NORM_DC,
        log = "x",
        xlim = xlim,
        ylim = ylim,
        xlab = xlab,
        ylab = ylab,
        col = col[fct],
        pch = def_pch,
        xaxt = "n"
      )
    )
    if(add_grid){grid()}
    axis(1, at = xat, labels = xmark)
    if (add_leg) {
      legend(
        legend_pos,
        unique(df$SOURCE),
        col = col,
        pch = def_pch,
        cex = leg_cex,
        pt.cex = leg_point_cex,
        bty = leg_bty,
        ...
      )
    }}
}
