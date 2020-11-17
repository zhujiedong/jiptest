#' @title plot jip test data measured by LI-6800
#'
#' @description {a quick way to preview the quality
#' of measured data.graphical preview of all the data
#' curves in log axis (BLUE > 1.2.2)}
#'
#' @param df files read by \code{read_files} or \code{read_dcfiles}
#' @param pch inherited from plot.default
#' @param alpha the transparent degree of colors in the plot
#' @param legend_pos inherited from \code{legend} position
#' @param leg_cex text size of legend
#' @param leg_point_cex point size of legend
#' @param leg_bty bty in \code{legend}
#' @param ylim Limits for the Y axis, if left blank estimated from data
#' @param xlab inherited from plot.default
#' @param ylab inherited from plot.default
#' @param col inherited from plot.default
#' @param log inherited from plot.default
#' @param ... other parameters in \code{plot}
#' @importFrom graphics points
#' @importFrom graphics abline
#' @importFrom graphics legend
#' @importFrom graphics text
#' @importFrom grDevices palette.colors
#' @export
#'

plot.jip <- function(df,
                     alpha = 0.6,
                     pch = 19,
                     col,
                     leg_bty = "n",
                     leg_cex = 0.6,
                     leg_point_cex = 0.9,
                     legend_pos = "topleft",
                     ylim=NULL,
                     log = "x",
                     xlab = "Time (Secs)",
                     ylab = "Fluorescence signal",
                     ...){
  if (is.null(ylim)){
    ylims <- with(df, c(min(FLUOR), 1.1 * max(FLUOR)))
  }
  #   if(is.null(xlim))xlim <- with(df,c(0, max(SECS)))
  ncols <- length(unique(df$SOURCE))
  fct <- as.factor(df$SOURCE)
  cls <-
    palette.colors(n = ncols,
                   "set 2",
                   alpha = alpha,
                   recycle = TRUE)
    with(
      df,
      plot(
        SECS,
        FLUOR,
        log = "x",
        ylim = ylims,
        xlab = xlab,
        ylab = ylab,
        col = cls[fct],
        pch = pch,
        ...
      )
    )
    legend(
      legend_pos,
      unique(df$SOURCE),
      col = cls,
      pch = pch,
      cex = leg_cex,
      pt.cex = leg_point_cex,
      bty = leg_bty,
      ...
    )
  }

