test_that("rtf_bookmark error when RTF object is incomplete", {
  rtf <- list(
    start = "{\\rtf1\\ansi\\deff0{\\fonttbl{\\f0 Arial;}}",
    end = "}"
  )
  
  expect_error(rtf_bookmark(rtf,"mybookmark"))
})

test_that("rtf_bookmark error when table nor figure are present", {
  rtf <- list(
    start = "{\\rtf1\\ansi\\deff0{\\fonttbl{\\f0 Arial;}}",
    body = "{\\f0\\b This is the body of the RTF document.}",
    end = "}"
  )
  
  expect_error(rtf_bookmark(rtf,"mybookmark"))
})
