# Output a dataframe to a table in RTF with opinionated formatting.

`df_to_rtf` is a convenience wrapper around `r2rtf` functionality for
outputting an RTF table, and optionally with at least one colspan in the
column headers.

## Usage

``` r
df_to_rtf(
  df,
  file_name,
  org,
  header_page,
  table_title,
  header_table0,
  header_table1,
  col_widths0,
  col_widths1,
  col_just0,
  col_just1,
  border_top1,
  footnote_table,
  cell_indents,
  footer_snapshot,
  path_program,
  path_output,
  font.family = 6,
  col_header_bg_color = "gray94",
  orientation = "landscape",
  margin = c(1, 1, 0.75, 0.75, 0.5, 0.5),
  title_as_heading = 2,
  bookmark = TRUE,
  bookmark_inc_title = FALSE
)
```

## Arguments

- df:

  data.frame. Dataframe to be output to RTF. Required.

- file_name:

  character. File path where the RTF file will be saved. Required.
  Strongly suggested to not include spaces in the file name to avoid
  issues with the bookmark functionality.

- org:

  character. Organization name, placed in the top line of the page
  header, left-aligned on the same line as the right-aligned page
  number. Default is "" (no organization name).

- header_page:

  character. Header text for the page, typically the name of the study.

- table_title:

  character. Title of the table, the table caption. Required.

- header_table0:

  character vector. Column spanning header for the table. Length of
  vector must be less than number of columns in `df`. Optional.

- header_table1:

  character vector. Column headers for the table. Length of vector must
  equal number of columns in `df`. Required.

- col_widths0:

  numeric vector. Relative widths for the column spanning header.
  Optional. Only used if `header_table0` is entered. The total sum of
  `col_widths0` must equal the total sum of `col_widths1`.

- col_widths1:

  numeric vector. Relative widths for the column headers.

- col_just0:

  character vector. Justification for the column spanning header.
  Optional. Only used if `header_table0` is entered.

- col_just1:

  character vector. Justification for the column headers.

- border_top1:

  character vector. Border style for the top border of each column
  header. Optional. Length of vector must equal number of columns in
  `df`.

- footnote_table:

  character vector. Footnotes for the table, if any.

- cell_indents:

  numeric vector. Indentation for each cell in the table, in twips.
  Default is 0, no indentation. `cell_indents` must be a vector of
  length `nrow(df)*ncol(df)`. The first value controls the indentation
  of the cell at row 1, column 1; the second value controls the
  indentation of the cell at row 1, column 2; and so on.

- footer_snapshot:

  character. Data snapshot used, placed in top row of the page footer.
  Required.

- path_program:

  character. Path to the program that generated the table, e.g.,
  "path/to/program.R", placed in second row of the footer. Required.

- path_output:

  character. Path to the output file, e.g., "path/to/output.rtf", placed
  in third row of the footer. If not entered, will use `file_name`.

- font.family:

  numeric. Font family for the RTF document. Default is 6 (Calibri). See
  `r2rtf:::font_type()` for other options.

- col_header_bg_color:

  character. Background color for the column header rows, default is
  `"gray94"`.

- orientation:

  character. Orientation of the page, either "portrait" or "landscape".
  Default is "landscape".

- margin:

  numeric vector. The value sets left, right, top, bottom, header and
  footer margin in order. Default is `c(1, 1, 0.75, 0.75, 0.5, 0.5)`.

- title_as_heading:

  numeric. If non-missing, the table title will be inserted as a Word
  heading style. Expected input is a value of 1, 2, 3, or 4. Default
  is 2. If no title style desired, set to 0 or do not specify in the
  function call.

- bookmark:

  logical. If TRUE, a bookmark will be created in the RTF file with the
  same name as the file (without extension).

- bookmark_inc_title:

  logical. If TRUE, the bookmark will be placed in the RTF file such
  that the title of the table is included. Otherwise, the title is
  excluded. Default is FALSE.

## Value

An RTF file, `file_name`.

## Details

`df_to_rtf` creates a formatted RTF file from a data frame input with
optional colspans in the column headers. See example for how to specify
colspans.

## Examples

``` r
if (FALSE) { # \dontrun{
df <- data.frame(Col1="1", Col2="2", Col3="3", Col4="4", Col5="5")

# Example: simple table without colspans
df_to_rtf(df              = df,
          file_name       = "MyTable.rtf", 
          table_title     = "Table 1. My table",
          col_widths1     = c(3, 2, 2, 2, 2),
          col_just1       = c("l", "c", "c", "c", "c"),
          footer_snapshot = "Analysis 2025", 
          path_program    = "C:\\\\program\\\\path\\\\code.r",
          path_output     = "C:\\\\output\\\\path\\\\MyTable.rtf")


# Example: table with colspans
# - Cspan1 spans Col2 and Col3, Cspan2 spans Col4 and Col5
df_to_rtf(df              = df,
          file_name       = "MyColSpanTable.rtf", 
          table_title     = "Table 1. My table",
          header_table0   = c(" ", "Cspan1", "CSpan2"), 
          col_widths0     = c(3, 4, 4),
          col_widths1     = c(3, 2, 2, 2, 2),
          col_just0       = c("l", "c", "c"), 
          col_just1       = c("l", "c", "c", "c", "c"),
          footer_snapshot = "Analysis 2025", 
          path_program    = "C:\\\\program\\\\path\\\\code.r",
          path_output     = "C:\\\\output\\\\path\\\\MyColSpanTable.rtf")
} # }
```
