# Output a figure to RTF with opinionated formatting.

`fig_to_rtf` is a convenience wrapper around `r2rtf` functionality for
outputting a plot object to RTF.

## Usage

``` r
fig_to_rtf(
  plot_obj,
  file_name,
  org,
  header_page,
  figure_title,
  footer_snapshot,
  path_program,
  path_output,
  font.family = 6,
  fig_width = 5,
  fig_height = 5,
  orientation = "landscape",
  margin = c(1, 1, 0.75, 0.75, 0.5, 0.5),
  title_as_heading = 2,
  bookmark = TRUE,
  bookmark_inc_title = FALSE
)
```

## Arguments

- plot_obj:

  plot object. An object of class \`ggplot\` or \`recordedplot\`.

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

- figure_title:

  character. Title of the figure, the figure caption. Required.

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

- fig_width:

  numeric. Width of the figure in inches. Default is 5.

- fig_height:

  numeric. Height of the figure in inches. Default is 5.

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

`fig_to_rtf` creates a formatted RTF file from a figure input.

## Examples

``` r
if (FALSE) { # \dontrun{
# Create ggplot object
plt <- ggplot(mtcars, aes(x=mpg, y=disp)) +
  geom_point() +
  theme_classic()

fig_to_rtf(plot_obj        = plt,
           file_name       = "MyFigure.rtf", 
           figure_title    = "Figure 1. My figure",
           footer_snapshot = "Analysis 2025", 
           path_program    = "C:\\\\program\\\\path\\\\code.r",
           path_output     = "C:\\\\output\\\\path\\\\MyFigure.rtf",
           fig_width       = 7, 
           fig_height      = 3.2)

# Using recordPlot with base R plot
plot(1:10, 1:10, xlab="X-axis", ylab="Y-axis")
plt_record <- recordPlot()

# Will return an error
fig_to_rtf(plot_obj        = plt_record,
           file_name       = "MyRecordedFigure.rtf", 
           figure_title    = "Figure 1. My figure",
           footer_snapshot = "Analysis 2025", 
           path_program    = "C:\\\\program\\\\path\\\\code.r",
           path_output     = "C:\\\\output\\\\path\\\\MyRecordedFigure.rtf",
           fig_width       = 7, 
           fig_height      = 3.2)

# Fix the class of the recorded plot object and try again
class(plt_record) <- c(class(plt_record), "ggplot")
fig_to_rtf(plot_obj        = plt_record,
           file_name       = "MyRecordedFigure.rtf", 
           figure_title    = "Figure 1. My figure",
           footer_snapshot = "Analysis 2025", 
           path_program    = "C:\\\\program\\\\path\\\\code.r",
           path_output     = "C:\\\\output\\\\path\\\\MyRecordedFigure.rtf",
           fig_width       = 7, 
           fig_height      = 3.2)
} # }
```
