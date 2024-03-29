% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/area_cal.R
\name{area_cal}
\alias{area_cal}
\title{calculate the area under curve (BLUE > 1.2.2)}
\usage{
area_cal(df, use_PAM = FALSE)
}
\arguments{
\item{df}{data of a type dataframe.}

\item{use_PAM}{indicate to use PAM or continuous fluorescence signals}
}
\description{
use a method similar method like trapezium intergration
}
\details{
use Soto's answer as
 https://stackoverflow.com/questions/4954507/calculate-the-area-under-a-curve
}
\examples{
\dontrun{
library(jiptest)
area_cal(df)
}
}
