test_that("fig_to_rtf fails with no filename", {
  library(ggplot2)
  plt <- ggplot(data    = mtcars, 
                mapping = aes(x=.data$mpg, y=.data$disp)) +
    geom_point() +
    theme_classic()
  
  expect_error(fig_to_rtf(plot_obj        = plt,
                          figure_title    = "Figure 1. My figure",
                          footer_snapshot = "Analysis 2025", 
                          path_program    = "C:\\\\program\\\\path\\\\code.r",
                          path_output     = "C:\\\\output\\\\path\\\\MyFigure.rtf",
                          fig_width       = 7, 
                          fig_height      = 3.2,
                          output          = FALSE)
  )
})


test_that("fig_to_rtf fails with no figure title", {
  library(ggplot2)
  plt <- ggplot(data    = mtcars, 
                mapping = aes(x=.data$mpg, y=.data$disp)) +
    geom_point() +
    theme_classic()
  
  expect_error(fig_to_rtf(plot_obj        = plt,
                          file_name       = "MyFigure.rtf", 
                          footer_snapshot = "Analysis 2025", 
                          path_program    = "C:\\\\program\\\\path\\\\code.r",
                          path_output     = "C:\\\\output\\\\path\\\\MyFigure.rtf",
                          fig_width       = 7, 
                          fig_height      = 3.2,
                          output          = FALSE)
  )
})



test_that("fig_to_rtf fails with no footer snapshot", {
  library(ggplot2)
  plt <- ggplot(data    = mtcars, 
                mapping = aes(x=.data$mpg, y=.data$disp)) +
    geom_point() +
    theme_classic()
  
  expect_error(fig_to_rtf(plot_obj        = plt,
                          file_name       = "MyFigure.rtf", 
                          figure_title    = "Figure 1. My figure",
                          path_program    = "C:\\\\program\\\\path\\\\code.r",
                          path_output     = "C:\\\\output\\\\path\\\\MyFigure.rtf",
                          fig_width       = 7, 
                          fig_height      = 3.2,
                          output          = FALSE)
  )
})


test_that("fig_to_rtf fails with no program path", {
  library(ggplot2)
  plt <- ggplot(data    = mtcars, 
                mapping = aes(x=.data$mpg, y=.data$disp)) +
    geom_point() +
    theme_classic()
  
  expect_error(fig_to_rtf(plot_obj        = plt,
                          file_name       = "MyFigure.rtf", 
                          figure_title    = "Figure 1. My figure",
                          footer_snapshot = "Analysis 2025", 
                          path_output     = "C:\\\\output\\\\path\\\\MyFigure.rtf",
                          fig_width       = 7, 
                          fig_height      = 3.2,
                          output          = FALSE)
  )
})

test_that("fig_to_rtf level 2 heading inserts", {
  library(ggplot2)
  plt <- ggplot(data    = mtcars, 
                mapping = aes(x=.data$mpg, y=.data$disp)) +
    geom_point() +
    theme_classic()
  
  rtf <- fig_to_rtf(plot_obj        = plt,
                    file_name       = "MyFigure.rtf", 
                    figure_title    = "Figure 1. My figure",
                    footer_snapshot = "Analysis 2025", 
                    path_program    = "C:\\\\program\\\\path\\\\code.r",
                    path_output     = "C:\\\\output\\\\path\\\\MyFigure.rtf",
                    fig_width       = 7, 
                    fig_height      = 3.2,
                    output          = FALSE)
  
  expect_true(grepl("s2", rtf$body))
})



test_that("fig_to_rtf bookmark inserts", {
  library(ggplot2)
  plt <- ggplot(data    = mtcars, 
                mapping = aes(x=.data$mpg, y=.data$disp)) +
    geom_point() +
    theme_classic()
  
  rtf <- fig_to_rtf(plot_obj        = plt,
                    file_name       = "MyFigure.rtf", 
                    figure_title    = "Figure 1. My figure",
                    footer_snapshot = "Analysis 2025", 
                    path_program    = "C:\\\\program\\\\path\\\\code.r",
                    path_output     = "C:\\\\output\\\\path\\\\MyFigure.rtf",
                    fig_width       = 7, 
                    fig_height      = 3.2,
                    bookmark_inc_title = TRUE,
                    output          = FALSE)
  
  res_check <- grepl("bkmkstart",rtf$start) &   grepl("bkmkend",rtf$end)
  
  expect_true(res_check)
})



test_that("fig_to_rtf bookmark matches filename sans extension", {
  library(ggplot2)
  plt <- ggplot(data    = mtcars, 
                mapping = aes(x=.data$mpg, y=.data$disp)) +
    geom_point() +
    theme_classic()
  
  rtf <- fig_to_rtf(plot_obj        = plt,
                    file_name       = "MyFigure.rtf", 
                    figure_title    = "Figure 1. My figure",
                    footer_snapshot = "Analysis 2025", 
                    path_program    = "C:\\\\program\\\\path\\\\code.r",
                    path_output     = "C:\\\\output\\\\path\\\\MyFigure.rtf",
                    fig_width       = 7, 
                    fig_height      = 3.2,
                    bookmark_inc_title = TRUE,
                    output          = FALSE)
  
  res_check <- grepl("bkmkstart MyFigure",rtf$start) &   grepl("bkmkend MyFigure",rtf$end)
  
  expect_true(res_check)
})



test_that("fig_to_rtf tab inserts into header and footer", {
  library(ggplot2)
  plt <- ggplot(data    = mtcars, 
                mapping = aes(x=.data$mpg, y=.data$disp)) +
    geom_point() +
    theme_classic()
  
  rtf <- fig_to_rtf(plot_obj        = plt,
                    file_name       = "MyFigure.rtf", 
                    figure_title    = "Figure 1. My figure",
                    footer_snapshot = "Analysis 2025", 
                    path_program    = "C:\\\\program\\\\path\\\\code.r",
                    path_output     = "C:\\\\output\\\\path\\\\MyFigure.rtf",
                    fig_width       = 7, 
                    fig_height      = 3.2,
                    bookmark_inc_title = TRUE,
                    output          = FALSE)
  
  res_check <- grepl("header\\n\\{\\\\pard\\\\tqr\\\\tx", rtf$body) &
    grepl("footer\\n\\{\\\\pard\\\\tqr\\\\tx", rtf$body)
  
  expect_true(res_check)
})


