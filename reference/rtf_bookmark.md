# Insert an RTF bookmark

`rtf_bookmark` inserts an RTF bookmark around the RTF body contents.

## Usage

``` r
rtf_bookmark(rtf, bookmark, inc_title = FALSE)
```

## Arguments

- rtf:

  list. List with 3 elements created by
  [`r2rtf::rtf_encode`](https://merck.github.io/r2rtf/reference/rtf_encode.html).

- bookmark:

  character. Name of the bookmark to insert. This should be a unique
  name that does not contain spaces.

- inc_title:

  logical. If TRUE, the bookmark will include the table or figure title.
  Otherwise, if FALSE, the title will omitted. Default is FALSE.

## Value

The input RTF object with the modified start and end elements

## Details

`rtf_bookmark` modifies the RTF to insert bookmark start and end tags
within the document. The bookmark start tag is inserted either at the
end of the RTF header (if `inc_title` is TRUE) or immediately before the
table/figure content in the body (if `inc_title` is FALSE). The bookmark
end tag is inserted at the beginning of the RTF end element.

## Examples

``` r
# Create a simple RTF object
rtf <- list(
 start = "{\\rtf1\\ansi\\deff0{\\fonttbl{\\f0 Arial;}}",
 body = "{\\f0\\b This is the body of the RTF document.}",
 end = "}"
 )
 
# Insert the bookmark and capture all contents
rtf_bookmark(rtf       = rtf, 
             bookmark  = "mybookmark", 
             inc_title = TRUE)
#> $start
#> [1] "{\\rtf1\\ansi\\deff0{\\fonttbl{\\f0 Arial;}}{\\*\\bkmkstart mybookmark}"
#> 
#> $body
#> [1] "{\\f0\\b This is the body of the RTF document.}"
#> 
#> $end
#> [1] "{\\*\\bkmkend mybookmark}\n}"
#> 
```
