# Outputting Figures

## Introduction

This vignette demonstrates how to output figures to RTF using the
`fig_to_rtf` function. The `fig_to_rtf` function takes a plot object as
input and outputs an RTF, the format of which is fairly opinionated, as
you will see.

## Get started

First load the package and format some example data.

``` r
library(ggplot2)
library(r2rtfExtras)

# Create ggplot object
plt <- ggplot(mtcars, aes(x=mpg, y=disp)) +
  geom_point() +
  theme_classic()
```

Next, we’ll use the `fig_to_rtf` function with defaults, providing only
the minimally required arguments and figure size arguments.

``` r
fig_to_rtf(plot_obj        = plt,
           file_name       = "MyFigure.rtf", 
           figure_title    = "Figure 1. My figure",
           footer_snapshot = "Analysis 2025",
           path_program    = "C:\\\\program\\\\path\\\\code.r",
           fig_width       = 7, 
           fig_height      = 3.2)
```

It is also possible to output figures created using base R plotting
capabilities. You can record the plot using
[`recordPlot()`](https://rdrr.io/r/grDevices/recordplot.html), a
function from the `grDevices` packages, set the class, and output. An
example is shown below.

``` r
plot(mtcars$mpg, mtcars$disp, pch=16)
plt_record <- recordPlot()
class(plt_record) <- c(class(plt_record), "ggplot")

fig_to_rtf(plot_obj        = plt_record,
           file_name       = "MyRecordedFigure.rtf", 
           figure_title    = "Figure 1. My recorded figure",
           footer_snapshot = "Analysis 2025",
           path_program    = "C:\\\\program\\\\path\\\\code.r",
           fig_width       = 7, 
           fig_height      = 5)
```

For more information on inputs, check out the function documentation
[`?fig_to_rtf`](https://medtronic-biostatistics.github.io/r2rtfExtras/reference/fig_to_rtf.md).
