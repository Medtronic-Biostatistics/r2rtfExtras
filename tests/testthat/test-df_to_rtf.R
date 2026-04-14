test_that("df_to_rtf fails with no filename", {
  df <- data.frame(Col1="1", Col2="2", Col3="3", Col4="4", Col5="5")
  
  expect_error(df_to_rtf(df              = df,
                         table_title     = "Table 1. My table",
                         col_widths1     = c(3, 2, 2, 2, 2),
                         col_just1       = c("l", "c", "c", "c", "c"),
                         footer_snapshot = "Analysis 2025", 
                         path_program    = "C:\\\\program\\\\path\\\\code.r",
                         path_output     = "C:\\\\output\\\\path\\\\MyTable.rtf",
                         output          = FALSE)
  )
})

test_that("df_to_rtf fails with no table title", {
  df <- data.frame(Col1="1", Col2="2", Col3="3", Col4="4", Col5="5")
  
  expect_error(df_to_rtf(df              = df,
                         file_name       = "MyTable.rtf", 
                         col_widths1     = c(3, 2, 2, 2, 2),
                         col_just1       = c("l", "c", "c", "c", "c"),
                         footer_snapshot = "Analysis 2025", 
                         path_program    = "C:\\\\program\\\\path\\\\code.r",
                         path_output     = "C:\\\\output\\\\path\\\\MyTable.rtf",
                         output          = FALSE)
  )
})

test_that("df_to_rtf fails with no footer snapshot", {
  df <- data.frame(Col1="1", Col2="2", Col3="3", Col4="4", Col5="5")
  
  expect_error(df_to_rtf(df              = df,
                         file_name       = "MyTable.rtf", 
                         table_title     = "Table 1. My table",
                         col_widths1     = c(3, 2, 2, 2, 2),
                         col_just1       = c("l", "c", "c", "c", "c"),
                         path_program    = "C:\\\\program\\\\path\\\\code.r",
                         path_output     = "C:\\\\output\\\\path\\\\MyTable.rtf",
                         output          = FALSE)
  )
})


test_that("df_to_rtf fails with no program path", {
  df <- data.frame(Col1="1", Col2="2", Col3="3", Col4="4", Col5="5")
  
  expect_error(df_to_rtf(df              = df,
                         file_name       = "MyTable.rtf", 
                         table_title     = "Table 1. My table",
                         col_widths1     = c(3, 2, 2, 2, 2),
                         col_just1       = c("l", "c", "c", "c", "c"),
                         footer_snapshot = "Analysis 2025", 
                         path_output     = "C:\\\\output\\\\path\\\\MyTable.rtf",
                         output          = FALSE)
  )
})

test_that("df_to_rtf level 2 heading inserts", {
  df <- data.frame(Col1="1", Col2="2", Col3="3", Col4="4", Col5="5")
  
  rtf <- df_to_rtf(df              = df,
                   file_name       = "MyTable.rtf", 
                   table_title     = "Table 1. My table",
                   col_widths1     = c(3, 2, 2, 2, 2),
                   col_just1       = c("l", "c", "c", "c", "c"),
                   footer_snapshot = "Analysis 2025", 
                   path_program    = "C:\\\\program\\\\path\\\\code.r",
                   path_output     = "C:\\\\output\\\\path\\\\MyTable.rtf",
                   output          = FALSE)
  
  expect_true(grepl("s2", rtf$body))
})



test_that("df_to_rtf bookmark inserts", {
  df <- data.frame(Col1="1", Col2="2", Col3="3", Col4="4", Col5="5")
  
  rtf <- df_to_rtf(df              = df,
                   file_name       = "MyTable.rtf", 
                   table_title     = "Table 1. My table",
                   col_widths1     = c(3, 2, 2, 2, 2),
                   col_just1       = c("l", "c", "c", "c", "c"),
                   footer_snapshot = "Analysis 2025", 
                   path_program    = "C:\\\\program\\\\path\\\\code.r",
                   path_output     = "C:\\\\output\\\\path\\\\MyTable.rtf",
                   bookmark_inc_title = TRUE,
                   output          = FALSE)
  
  res_check <- grepl("bkmkstart",rtf$start) &   grepl("bkmkend",rtf$end)
  
  expect_true(res_check)
})


test_that("df_to_rtf bookmark matches filename sans extension", {
  df <- data.frame(Col1="1", Col2="2", Col3="3", Col4="4", Col5="5")
  
  rtf <- df_to_rtf(df              = df,
                   file_name       = "MyTable.rtf", 
                   table_title     = "Table 1. My table",
                   col_widths1     = c(3, 2, 2, 2, 2),
                   col_just1       = c("l", "c", "c", "c", "c"),
                   footer_snapshot = "Analysis 2025", 
                   path_program    = "C:\\\\program\\\\path\\\\code.r",
                   path_output     = "C:\\\\output\\\\path\\\\MyTable.rtf",
                   bookmark_inc_title = TRUE,
                   output          = FALSE)
  
  res_check <- grepl("bkmkstart MyTable",rtf$start) &   grepl("bkmkend MyTable",rtf$end)
  
  expect_true(res_check)
})





test_that("df_to_rtf tab inserts into header and footer", {
  df <- data.frame(Col1="1", Col2="2", Col3="3", Col4="4", Col5="5")
  
  rtf <- df_to_rtf(df              = df,
                   file_name       = "MyTable.rtf", 
                   table_title     = "Table 1. My table",
                   col_widths1     = c(3, 2, 2, 2, 2),
                   col_just1       = c("l", "c", "c", "c", "c"),
                   footer_snapshot = "Analysis 2025", 
                   path_program    = "C:\\\\program\\\\path\\\\code.r",
                   path_output     = "C:\\\\output\\\\path\\\\MyTable.rtf",
                   bookmark_inc_title = TRUE,
                   output          = FALSE)
  
  res_check <- grepl("header\\n\\{\\\\pard\\\\tqr\\\\tx", rtf$body) &
    grepl("footer\\n\\{\\\\pard\\\\tqr\\\\tx", rtf$body)
    
  expect_true(res_check)
})


