# r2rtfExtras <a href="https://medtronic-biostatistics.github.io/r2rtfExtras/"><img src="man/figures/logo.png" alt="r2rtfExtras website" align="right" height="111"/></a>

The goal of `{r2rtfExtras}` is to provide some additional helper functions
to assist in creating RTF output with `{r2rtf}`.

The primary wrapper functions are `df_to_rtf` and `fig_to_rtf` which are
opinionated wrappers around boilerplate `{r2rtf}` code. There are additional
capabilities currently not *yet* built into `{r2rtf}`. The [`{r2rtf}`
package](https://github.com/Merck/r2rtf/) remains an amazing tool for generating
output in the RTF format. Make sure to read the official documentation.


This package is currently under active development.

## Installation

The package can currently be installed from this Github repository using
the following (ensure devtools is installed):

```         
devtools::install_git("https://github.com/Medtronic-Biostatistics/r2rtfExtras.git")
```

See the [package website](https://medtronic-biostatistics.github.io/r2rtfExtras/) for
more details.