# Outputting Tables

## Introduction

This vignette demonstrates how to output dataframes to RTF using the
`df_to_rtf` function. The `df_to_rtf` function takes a dataframe as
input and outputs an RTF, the format of which is fairly opinionated, as
you will see.

## Get started

First load the package and format some example data.

``` r
library(r2rtfExtras)

df       <- mtcars[1:10,]
df$Model <- row.names(df)
df       <- df[c("Model", "mpg", "cyl", "disp", "hp")]
```

Next, we’ll use the `df_to_rtf` function with defaults, providing only
the minimally required arguments.

``` r
df_to_rtf(df              = df,
          file_name       = "MyTable.rtf",
          table_title     = "Table 1. MTCARS Dataset",
          footer_snapshot = "Henderson and Velleman (1981)", 
          path_program    = "C:\\\\program\\\\path\\\\tables.Rmd")
```

There are some enforced opinions in the output: the page header has a
right-aligned page number and the page footer has a left-aligned
snapshot and a right-aligned timestamp, as well as rows for the paths to
the program and output.

You should also notice in the output:

- The page header is largely empty as it only includes the page number.
- The table column names are not very informative.
- The page footer Output Name is less than desirable.

Let’s improve on these issues to generate a more informative RTF:

``` r
df_to_rtf(df              = df,
          file_name       = "MyTableImproved.rtf",
          org             = "My Organization",
          header_page     = "My MTCARS Analysis",
          table_title     = "Table 1. MTCARS Dataset",
          header_table1   = c("Model", "Miles Per Gallon", "Cylinders", 
                              "Displacement", "Horsepower"), 
          footer_snapshot = "Henderson and Velleman (1981)", 
          path_program    = "C:\\\\program\\\\path\\\\tables.Rmd",
          path_output     = "C:\\\\output\\\\path\\\\MyTableImproved.rtf")
```

Much better!

Finally, a few things that are not readily apparent. By default, the
`df_to_rtf` function will add the following:

- A stylesheet that allows for setting the table title to a heading
  style of level 1 through 4.
- A table title that is set to the heading style of level 2 by default
  and is recognized by Word.
- Bookmark start and end tags around the table. Very useful for
  auto-linking within other documents.

## Tables with column spanning headers

We can also output tables with column spanning headers. Let’s see how
this works:

``` r
df_to_rtf(df              = df,
          file_name       = "MyColSpanTable.rtf",
          org             = "My Organization",
          header_page     = "My MTCARS Analysis",
          table_title     = "Table 1. MTCARS Dataset",
          header_table0   = c(" ", "Performance", "Engine"),
          header_table1   = c("Model", "Miles Per Gallon", "Cylinders", 
                              "Displacement", "Horsepower"), 
          col_widths0     = c(1, 4, 4),
          col_widths1     = c(1, 2, 2, 2, 2),
          col_just0       = c("l", "c", "c"),
          col_just1       = c("l", "c", "c", "c", "c"),
          footer_snapshot = "Henderson and Velleman (1981)", 
          path_program    = "C:\\\\program\\\\path\\\\tables.Rmd",
          path_output     = "C:\\\\output\\\\path\\\\MyColSpanTable.rtf")
```

Currently, `df_to_rtf` only allows for one level of column spanning, as
shown in the example output above. Here are some key details:

- `header_table0` specifies the column spanning header row.
- `header_table1` specifies the column names for the second header row,
  which is the row that is directly above the data rows.
- `col_widths0` and `col_widths1` must sum to the same value. The
  alignment between the spanning row and the column names is largely
  controlled by the `col_widths0` and `col_widths1` arguments.
- `col_just0` is the justification of the column spanning header row.
- `col_just1` is the justification of the column names row and the data
  rows.

What happens if the inputs are not quite consistent? Below, the
`col_widths0` and `col_widths1` sum to the same value, but the header
row is not consistent with the spanning row.

``` r
df_to_rtf(df              = df,
          file_name       = "MyColSpanTableProblem.rtf",
          org             = "My Organization",
          header_page     = "My MTCARS Analysis",
          table_title     = "Table 1. MTCARS Dataset",
          header_table0   = c(" ", "Performance", "Engine"),
          header_table1   = c("Model", "Miles Per Gallon", "Cylinders", 
                              "Displacement", "Horsepower"), 
          col_widths0     = c(1, 4, 4),
          col_widths1     = c(1, 2.2, 1.7, 2.1, 2),
          col_just0       = c("l", "c", "c"),
          col_just1       = c("l", "c", "c", "c", "c"),
          footer_snapshot = "Henderson and Velleman (1981)", 
          path_program    = "C:\\\\program\\\\path\\\\tables.Rmd",
          path_output     = "C:\\\\output\\\\path\\\\MyColSpanTableProblem.rtf")
```

As you can see above, the spanning header row, Performance, has a right
border that is sligthly misaligned due to inconsistency between the
`col_widths0` and `col_widths1` arguments.

For more information on inputs, check out the function documentation
[`?df_to_rtf`](https://medtronic-biostatistics.github.io/r2rtfExtras/reference/df_to_rtf.md).
