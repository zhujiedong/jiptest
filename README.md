# install and library

```
devtools::install_github("zhujiedong/jiptest")
library(jiptest)
```

# jiptest
this is an R package for jip test of LI-6800 (from licor) measured fluorescence induction data. there are 3 functions for now.
## read_file
`read_files` is a function to import all the xlsx files that measured by the induction of li-6800, with there files names added to the final output.

example:
```
jip_data <- read_files("./jipdata")
```
where "./jipdata" jipdata is a file contains all your measured data, and only contains the xlsx data files

## jip_test
`jip_test` is a function performs the jip test of all your data in batch

example:

```
jip_test("./jipdata", "d:/")

```
here d:/ is the path you want to store all your data.

## jip_ggplot
`jip_ggplot` is a function provides you a quick way to check the data by a graph of all your data, based on ggplot2

example:

```
jip_ggplot("./jipdata")
```
where "./jipdata" jipdata is a file contains all your measured data,  and you will see all the data
