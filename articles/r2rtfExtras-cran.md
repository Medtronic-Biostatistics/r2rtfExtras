# Introduction to the r2rtfExtras Package

Please see
<https://medtronic-biostatistics.github.io/r2rtfExtras/index.html> for
the full documentation. Here is only a minimal example:

``` r
library(r2rtfExtras)

df       <- mtcars[1:10,]
df$Model <- row.names(df)
df       <- df[c("Model", "mpg", "cyl", "disp", "hp")]

df_to_rtf(df              = df,
          file_name       = "MyTable.rtf",
          table_title     = "Table 1. MTCARS Dataset",
          footer_snapshot = "Henderson and Velleman (1981)", 
          path_program    = "C:\\\\program\\\\path\\\\tables.Rmd")
```
