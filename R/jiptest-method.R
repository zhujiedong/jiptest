#' @title plot jip test data measured by LI-6800
#'
#' @description {a quick way to preview the quality
#' of measured data.graphical preview of all the data
#' curves in log axis (BLUE > 1.2.2)}
#'
#' @param df files read by \code{read_files} or \code{read_dcfiles}
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
#' @param normalized whether use normorlized fluor signal
#' @param add_leg defaut is true, add lengend directly
#' @param ... other parameters in \code{plot}
#' @importFrom graphics points
#' @importFrom graphics abline
#' @importFrom graphics legend
#' @importFrom graphics text
#' @importFrom grDevices palette.colors
#' @importFrom graphics axis
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
                     xlim = c(5e-06, 1.1),
                     ylim=NULL,
                     log = "x",
                     xlab = "Time (Secs)",
                     ylab = "Fluorescence signal",
                     xmark = c(expression(10^{-5}, 10^{-4}, 10^{-3},
                                          10^{-2}, 10^{-1}, 10^0)),
                     xat = c(0.00001, 0.0001, 0.001, 0.01, 0.1, 1),
                     normalized = TRUE, add_leg = TRUE,
                     ...){

# colors ------------------------------------------------------------------

  ncols <- length(unique(df$SOURCE))
  fct <- as.factor(df$SOURCE)
  if(is.null(col)){
  col <-
    palette.colors(n = ncols,
                   "set 1",
                   alpha = alpha,
                   recycle = TRUE)
  }
# normalized y axis -------------------------------------------------------

  max_flr <- with(df, tapply(FLUOR, as.factor(SOURCE), max))
  #no. of each factors
  n_group <- table(fct)
  n_source <- unlist(mapply(rep, max_flr, each = n_group))
  #if each elements in n_group are the same, n_source will be arry
  n_source <- as.vector(n_source)
  df$NORM_FLUOR <- df$FLUOR/n_source

# plot --------------------------------------------------------------------
 if(length(def_pch) > 1){ #plot with given multiple pch
    if(normalized){
      ylim <- c(0, 1.1)
      with(
        df,
        plot(
          SECS,
          NORM_FLUOR,
          log = "x",
          ylim = ylim,
          xlab = xlab,
          ylab = ylab,
          col = col[fct],
          pch = def_pch[fct],
          xaxt = "n",
          ...
        )
      )
      axis(1, at = xat, labels = xmark)
      if(add_leg){
        legend(
          legend_pos,
          unique(df$SOURCE),
          col = col,
          pch = def_pch,
          cex = leg_cex,
          pt.cex = leg_point_cex,
          bty = leg_bty,
          ...
        )}
    } else{
      if (is.null(ylim)) {
        ylim <- with(df, c(min(FLUOR), 1.1 * max(FLUOR)))
      }
      with(
        df,
        plot(
          SECS,
          FLUOR,
          log = "x",
          ylim = ylim,
          xlab = xlab,
          ylab = ylab,
          col = col[fct],
          pch = def_pch[fct],
          xaxt = "n"
        )
      )
      axis(1, at = xat, labels = xmark)
      if(add_leg){
        legend(
          legend_pos,
          unique(df$SOURCE),
          col = col,
          pch = def_pch,
          cex = leg_cex,
          pt.cex = leg_point_cex,
          bty = leg_bty,
          ...
        )}
    }
  } else{## plot with given pch
    if(normalized){
      ylim <- c(0, 1.1)
      with(
        df,
        plot(
          SECS,
          NORM_FLUOR,
          log = "x",
          ylim = ylim,
          xlab = xlab,
          ylab = ylab,
          col = col[fct],
          pch = def_pch,
          xaxt = "n",
          ...
        )
      )
      axis(1, at = xat, labels = xmark)
      if(add_leg){
        legend(
          legend_pos,
          unique(df$SOURCE),
          col = col,
          pch = def_pch,
          cex = leg_cex,
          pt.cex = leg_point_cex,
          bty = leg_bty,
          ...
        )}
    } else{
      if (is.null(ylim)) {
        ylim <- with(df, c(min(FLUOR), 1.1 * max(FLUOR)))
      }
      with(
        df,
        plot(
          SECS,
          FLUOR,
          log = "x",
          ylim = ylim,
          xlab = xlab,
          ylab = ylab,
          col = col[fct],
          pch = def_pch,
          xaxt = "n"
        )
      )
      axis(1, at = xat, labels = xmark)
      if(add_leg){
        legend(
          legend_pos,
          unique(df$SOURCE),
          col = col,
          pch = def_pch,
          cex = leg_cex,
          pt.cex = leg_point_cex,
          bty = leg_bty,
          ...
        )}
    }
  }
  }
