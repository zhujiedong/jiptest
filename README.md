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

here are some examples：

1. the default way, use normalized fluorescence signals

```
plot(jip_data)
```

```
plot(jip_dcdata)
```

[default Normalized AC signal](https://imgchr.com/i/Du0tsS)

[default Normalized DC signal](https://imgchr.com/i/Du08RP)

2. customized way

please refer to: `?plot.jip`.

```
cls <- palette.colors(n = 5,  "set 2", alpha = 0.8)
plot(jip_data,
     ylab = 'Normalized fluorescence signals',
     add_leg = FALSE,
     def_pch = 14:18,
     col = cls,
     main = "Demodulated signals", pch = 14, normalized = FALSE)

legend(
  "topleft",
  unique(jip_data$SOURCE),
  col = cls,
  pch = 14:18,
  cex = 0.6,
  pt.cex = 1.2,
  bty = "n")
```


```{r, cus-dc-plot-leg-cls, fig.cap="定制连续光图形示例"}
plot(jip_dcdata, legend_pos = "bottomright", normalized = FALSE)
```

[customized AC raw signal](https://imgchr.com/i/Du0YM8)

[customized DC raw signal](https://imgchr.com/i/Du0Gxf)

if you can read Chinese, please follow:

[Chinese guide](https://zhujiedong.github.io/photoanalysis/)

