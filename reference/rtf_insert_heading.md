# Transform RTF Title to Heading

`rtf_insert_heading` transforms the RTF title into a specified heading
style.

## Usage

``` r
rtf_insert_heading(rtf, heading_level, caption, font.family)
```

## Arguments

- rtf:

  list. List with 3 elements created by
  [`r2rtf::rtf_encode`](https://merck.github.io/r2rtf/reference/rtf_encode.html).

- heading_level:

  integer. The heading level to apply to the title (1, 2, 3, or 4).

- caption:

  character. The title already present in the RTF.

- font.family:

  integer. The font family number used in the RTF.

## Value

The input RTF object with the modified body

## Details

`rtf_insert_heading` is an internal function that modifies the RTF body
to change the title into the specified heading style. Note that a
stylesheet with defined heading level must be present and the title must
be bold.
