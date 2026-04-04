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

## Value

The input RTF object with the stylesheet added.

## Details

`rtf_insert_stylesheet_headings` is an internal function that inserts a
stylesheet into the RTF.
