# Insert Stylesheet for Heading into an RTF file

`rtf_insert_stylesheet_headings` inserts a stylesheet defining heading
levels 1 through 4 into an RTF file created by
[`r2rtf::rtf_encode`](https://merck.github.io/r2rtf/reference/rtf_encode.html).

## Usage

``` r
rtf_insert_stylesheet_headings(rtf)
```

## Arguments

- rtf:

  list. List with 3 elements created by
  [`r2rtf::rtf_encode`](https://merck.github.io/r2rtf/reference/rtf_encode.html).
  The list must have elements named start, body, and end.

## Value

The input RTF object with the stylesheet added.

## Details

`rtf_insert_stylesheet_headings` inserts into an RTF a stylesheet that
defines heading levels.

## Examples

``` r
# Create a simple RTF object
rtf <- list(
 start = "{\\rtf1\\ansi\\deff0{\\fonttbl{\\f0 Arial;}}",
 body = "{\\f0\\b This is the body of the RTF document.}",
 end = "}"
 )
 
# Insert the stylesheet for headings
rtf_insert_stylesheet_headings(rtf)
#> $start
#> [1] "{\\rtf1\\ansi\\deff0{\\fonttbl{\\f0 Arial;}} \n{\\stylesheet{\\s1 heading 1;}\n{\\s2 heading 2;}\n{\\s3 heading 3;}\n{\\s4 heading 4;}\n}\n\n"
#> 
#> $body
#> [1] "{\\f0\\b This is the body of the RTF document.}"
#> 
#> $end
#> [1] "}"
#> 
```
