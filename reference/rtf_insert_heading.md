# Transform RTF Title to Heading

`rtf_insert_heading` transforms the RTF title into a specified heading
style.

## Usage

``` r
rtf_insert_heading(rtf, heading_level, caption, font_family)
```

## Arguments

- rtf:

  list. List with 3 elements created by
  [`r2rtf::rtf_encode`](https://merck.github.io/r2rtf/reference/rtf_encode.html).

- heading_level:

  integer. The heading level to apply to the title (1, 2, 3, or 4).

- caption:

  character. The title already present in the RTF.

- font_family:

  integer. The font family number used in the RTF.

## Value

The input RTF object with the modified body

## Details

`rtf_insert_heading` modifies the RTF body to change the title into the
specified heading style. Note that a stylesheet with defined heading
level must be present and the title must be bold.

## Examples

``` r
# Create a simple RTF object
rtf <- list(
 start = "{\\rtf1\\ansi\\deff0{\\fonttbl{\\f0 Arial;}}",
 body = "{\\f0\\b This is the body of the RTF document.}",
 end = "}"
 )
 
# Insert the stylesheet for headings
rtf <- rtf_insert_stylesheet_headings(rtf)

# Insert heading level 2
rtf <- rtf_insert_heading(rtf, 
                          heading_level = 2, 
                          caption = "This is the body of the RTF document.", 
                          font_family = 1)
```
