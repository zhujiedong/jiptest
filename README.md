# install and library

```
devtools::install_github("zhujiedong/jiptest")
library(jiptest)
```

# jiptest

this is an R package for jip test of LI-6800 (from licor) measured fluorescence induction data. it is designed for batch readings and writings,
currently you should put all your excel files of the measured data in a separate folder, to avoid errors.

## read_files and read_dcfiles

`read_files` is a function to import all the xlsx files that measured by the induction of li-6800, with there files names added to the final output.

`read_dcfiles` the same with `read_files`, except that it reads the dc signals, ie demodulated signals

example:

```
jip_data <- read_files("jipdata")
```

```
jip_dcdata <- read_files("jipdata")
```

where "jipdata" is a folder contains all your measured data, and only contains the xlsx data of the induction files

## jip_test and jip_dctest

`jip_test`  and `jip_dctest` iperforms the jip test calculation of all your data in batch

example:

```
jip_test("jipdata")

```

```
jip_dctest("jipdata")

```

where "jipdata" is a folder contains all your measured data, and only contains the xlsx data of the induction files

## plot

supply a method `plot.jip` to plot, we can choose to use normalized fluorescence signals or the raw fluorescence signals, that is to say, you can customized you plot

here are customized legend plot with the raw fluorescence signals 
```
plot(jip_data,
     ylab = 'Normalized fluorescence signals',
     add_leg = FALSE,
     col = palette.colors(n = 5,  "set 1", alpha = 0.8),
     main = "Demodulated signals", pch = 14, normalized = FALSE)

legend(
  "topleft",
  unique(jip_data$SOURCE),
  col = palette.colors(n = 5,  "set 1", alpha = 0.8),
  pch = 14,
  cex = 0.6,
  pt.cex = 1.2,
  bty = "n")
```

[ac-sig](https://imgchr.com/i/DevNgx)

here are examples with the defaut parameters except the legend position(normalized fluoresece signals)

```
plot(jip_dcdata, legend_pos = "bottomright")
```
[dc-sig](https://imgchr.com/i/DevUv6)

