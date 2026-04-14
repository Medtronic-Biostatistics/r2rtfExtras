test_that("rtf_heading error when RTF object is incomplete", {
  rtf <- list(
    start = "{\\rtf1\\ansi\\deff0{\\fonttbl{\\f0 Arial;}}",
    end = "}"
    )
  
  expect_error(rtf_insert_heading(rtf,2,"table title",1))
})


test_that("rtf_heading error when no stylesheet defined", {
  rtf <- list(
    start = "{\\rtf1\\ansi\\deff0{\\fonttbl{\\f0 Arial;}}",
    body = "{\\f0\\b This is the body of the RTF document.}",
    end = "}"
  )
  
  expect_error(rtf_insert_heading(rtf,2,"table title",1))
})


test_that("rtf_heading error when bad level entered", {
  rtf <- list(
    start = "{\\rtf1\\ansi\\deff0{\\fonttbl{\\f0 Arial;}}",
    body = "{\\f0\\b This is the body of the RTF document.}",
    end = "}"
  )
  
  rtf <- rtf_insert_stylesheet_headings(rtf)
  
  expect_error(rtf_insert_heading(rtf,8,"table title",1))
})


test_that("rtf_heading correctly insert heading", {
  rtf <- list(
    start = "{\\rtf1\\ansi\\deff0{\\fonttbl{\\f0 Arial;}}",
    body = "{\\f0\\b This is the body of the RTF document.}",
    end = "}"
  )
  
  rtf <- rtf_insert_stylesheet_headings(rtf)
  
  rtf <- rtf_insert_heading(rtf           = rtf,
                            heading_level = 2,
                            caption       = "This is the body of the RTF document.",
                            font_family   = 1)
  
  expect_true(grepl("s2", rtf$body))
})


test_that("rtf_heading quiet fail when heading not entered", {
  rtf <- list(
    start = "{\\rtf1\\ansi\\deff0{\\fonttbl{\\f0 Arial;}}",
    body = "{\\f0\\b This is the body of the RTF document.}",
    end = "}"
  )
  
  rtf <- rtf_insert_stylesheet_headings(rtf)
  
  rtf <- rtf_insert_heading(rtf           = rtf,
                            heading_level = 2,
                            caption       = "XThis is the body of the RTF document.",
                            font_family   = 1)
  expect_false(grepl("s2", rtf$body))
})



