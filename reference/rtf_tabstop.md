# Insert a right-aligned tab stop in the first line of an RTF page header or footer

`rtf_tabstop` inserts a tabstop into the first line of an RTF page
header or footer.

## Usage

``` r
rtf_tabstop(rtf, twips, type = "header")
```

## Arguments

- rtf:

  list. List with 3 elements created by
  [`r2rtf::rtf_encode`](https://merck.github.io/r2rtf/reference/rtf_encode.html).

- twips:

  integer. The position of the tab stop in twips (1440 twips per inch).

- type:

  character. Either "header" or "footer", indicating whether to modify
  the page header or footer.

## Value

The input RTF object with the modified body

## Details

`rtf_tabstop` modifies the RTF body to insert a right-aligned tabstop.
It is assumed that the first line of the header or footer already
contains a tab character, as is expected, i.e., the first line of the
header should be the name of the organization followed by a tab
character and the page number field. The first line of the footer should
be the data (snapshot) information followed by a tab character and the
date of creation.
