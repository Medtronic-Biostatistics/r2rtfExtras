# Extra Functionality

Beyond convenient wrapper functions, `r2rtfExtras` also offers
additional RTF functionality that is called internally:

- `rtf_bookmark` for inserting RTF bookmarks.
- `rtf_insert_heading` for styling table or figure titles as headings.
- `rtf_insert_stylesheet_headings` for inserting a heading stylesheet
  into the RTF.
- `rtf_tabstop` for inserting tab stops into the RTF header and/or
  footer.

With each function, the input is an RTF object created by
[`r2rtf::rtf_encode`](https://merck.github.io/r2rtf/reference/rtf_encode.html)
and the output is the same RTF object with modifications. Each function
manipulates the underlying RTF code.

Additionally, these functions are not exported, but are used internally
within the `df_to_rtf` and `fig_to_rtf` functions; the underlying code
is readily available in the Github repository.

## rtf_bookmark()

The `rtf_bookmark` function inserts an RTF bookmark around the table or
figure content in the RTF body. Given a bookmark name, e.g., mybkmk, the
RTF tags `{\\*\\bkmkstart mybkmk}` and `{\\*\\bkmkend mybkmk}` are added
within the RTF code to define the bookmarked area. This is very useful
for auto-linking RTFs within MS Word, e.g., in the context of Clinical
Study Reports (CSRs) where external table and figure RTFs may be
auto-linked.

The `rtf_bookmark` function also allows you to specify whether the
bookmark should include the table or figure title. If `inc_title` is
TRUE, the bookmark will be placed so that it includes the title and the
table or figure, otherwise, if FALSE, the bookmark will only include the
table or figure content.

When `inc_title` is FALSE, it is important to note that the function
uses string matching to find where the table or figure content begins:

- Table content: first occurrence of `trowd`
- Figure content: first occurrence of `pict`

## rtf_insert_heading()

The `rtf_insert_heading` function allows users to transform the table or
figure title into a specified heading style. This is accomplished by
first inserting a heading definition stylesheet into the RTF using
[`rtf_insert_stylesheet_headings()`](https://medtronic-biostatistics.github.io/r2rtfExtras/reference/rtf_insert_stylesheet_headings.md).
Next, `rtf_insert_heading` function uses a string match to find the
title in the RTF body and inserts the corresponding heading level tag
(e.g., `\s1` for heading level 1) before the title text.

It is important to note that the function uses string matching to find
the title in the RTF body by searching for the first occurrence of the
specified font family and bold tags. For example, if using the Calibri
font, the function will search for the first occurrence of `\f6\b` and
insert the heading level tag before that to transform the title, e.g.,
`\s1\f6\b`.

## rtf_insert_stylesheet_headings()

The `rtf_insert_stylesheet_headings` function inserts a stylesheet
within the RTF that defines heading levels 1 through 4:

`{\stylesheet{\s1 heading 1;}{\s2 heading 2;}{\s3 heading 3;}{\s4 heading 4;}}`

This allows users to then specify the heading level of table and figure
titles up to level 4.

## rtf_tabstop()

The `rtf_tabstop` function adds a right-aligned tab stop to the first
line of the RTF page header or footer. This is useful for formatting the
header and footer content, such as aligning page numbers or timestamps
to the right.

The function sets the tabstop at a location specified in twips (1 inch =
1440 twips) using the `\tqr\tx n_twips` tag, where `n_twips` is replaced
with the actual twips value; a little arithmetic is needed to align the
tab to the right margin. The `type` argument specifies whether to modify
the header or footer.

It is assumed that the first line of the header or footer already
contains a tab character, as is expected, for instance:

``` r
hdr <- c("My Organization \\tab Page \\pagenumber of \\pagefield",
         "My Study Analysis")
```

This will result in a page header with 2 lines:

- Line 1: “My Organization” followed by a tab stop, then “Page X of Y”
  (where X is the current page number and Y is the total number of
  pages).
- Line 2: “My Study Analysis”.

Similarly, for the footer, the first line will have the snapshot
information followed by a tab character and the date of RTF creation.
