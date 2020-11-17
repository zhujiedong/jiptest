#' graphical preview of all the data curves in log axis (BLUE > 1.2.2)
#' @description a quick way to preview the quality of measured data.
#'
#' @param file_dir dataframe aquired by read_files.
#'
#' @details
#'
#' a quick preview the tendency of all measured data, based on ggplot2.
#'
#' @examples
#' \dontrun{
#' library(jiptest)
#' ojip <- read_files('./ojip1_2_2')
#' jip_plot(ojip)
#' }
#'
#' @import ggplot2
#' @import scales
# @export
jip_plot <- function(file_dir) {
  read_files <- match.fun(read_files)
  ojip <- read_files(file_dir)

  acplot <- ggplot(ojip, aes(SECS, FLUOR, group = SOURCE, colour = SOURCE)) +
    geom_point(aes()) + labs(x = "Time (secs)",
             y = "fluoresence signal") + scale_colour_hue(name =
             "Data files", labels = unique(as.character(ojip$SOURCE))) +
    scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                           labels = trans_format("log10", math_format(10^.x))) +
    ggtitle("AC fluorescence")
  acplot
}
