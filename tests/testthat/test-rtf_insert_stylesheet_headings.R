test_that("rtf_insert_stylesheet_headings error when RTF object is incomplete", {
  rtf <- list(
    start = "{\\rtf1\\ansi\\deff0{\\fonttbl{\\f0 Arial;}}",
    end = "}"
  )
  
  expect_error(rtf_insert_stylesheet_headings(rtf))
})



test_that("rtf_insert_stylesheet_headings stylesheet inserts into start element", {
  rtf <- list(
    start = "{\\rtf1\\ansi\\deff0{\\fonttbl{\\f0 Arial;}}",
    body = "{\\f0\\b This is the body of the RTF document.}",
    end = "}"
  )
  
  rtf <- rtf_insert_stylesheet_headings(rtf)
  
  check_heading <- grepl("s1 heading 1", rtf$start) &
    grepl("s2 heading 2", rtf$start) &
    grepl("s3 heading 3", rtf$start) &
    grepl("s4 heading 4", rtf$start) 
  

  expect_true(check_heading)
})


