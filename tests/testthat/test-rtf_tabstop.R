test_that("rtf_tabstop error when RTF object is incomplete", {
  rtf <- list(
    start = "{\\rtf1\\ansi\\deff0{\\fonttbl{\\f0 Arial;}}",
    end = "}"
  )
  
  expect_error(rtf_tabstop(rtf,12960))
})


test_that("rtf_tabstop error when wrong type", {
  rtf <- list(
    start = "{\\rtf1\\ansi\\deff0{\\fonttbl{\\f0 Arial;}}",
    body = "{\\header\n{\\pard{Header Left \\tab Header Right}\\par}\n}{\\f0\\b RTF text.}",
    end = "}"
  )
  
  expect_error(rtf_tabstop(rtf,12960,"foter"))
})


test_that("rtf_tabstop ", {
  rtf <- list(
    start = "{\\rtf1\\ansi\\deff0{\\fonttbl{\\f0 Arial;}}",
    body = "{\\header\n{\\pard{Header Left \\tab Header Right}\\par}\n}{\\f0\\b RTF text.}",
    end = "}"
  )
  
  rtf <- rtf_tabstop(rtf,12960,"header")
  
  check_bookmark <- grepl("tqr\\\\tx", rtf$body)
  
  expect_true(check_bookmark)
})


