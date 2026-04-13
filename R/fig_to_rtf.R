#' Output a figure to RTF with opinionated formatting.
#' 
#' \code{fig_to_rtf} is a convenience wrapper around \code{r2rtf} functionality
#'   for outputting a plot object to RTF. 
#'
#' @param plot_obj plot object. An object of class `ggplot` or `recordedplot`.
#' 
#' @param file_name character. File path where the RTF file will be saved. Required.
#'   Strongly suggested to not include spaces in the file name to avoid issues with the bookmark functionality.
#'
#' @param header_page character. Header text for the page, typically the name of the study.
#' 
#' @param figure_title character. Title of the figure, the figure caption. Required.
#'  
#' @param footer_snapshot character. Data snapshot used, placed in top row of the page footer. Required.
#' 
#' @param path_program character. Path to the program that generated the table, e.g., "path/to/program.R",
#'   placed in second row of the footer. Required. 
#' 
#' @param path_output character. Path to the output file, e.g., "path/to/output.rtf",
#'   placed in third row of the footer. If not entered, will use \code{file_name}.
#'   
#' @param org character. Organization name, placed in the top line of the page header,
#'   left-aligned on the same line as the right-aligned page number. Default is "" (no organization name).
#' 
#' @param font_family numeric. Font family for the RTF document. Default is 6 (Calibri).
#'   See \code{r2rtf:::font_type()} for other options.
#'   
#' @param font_size_header numeric. Font size for the header and footer text. Default is 10.
#' 
#' @param fig_width numeric. Width of the figure in inches. Default is 5.
#' 
#' @param fig_height numeric. Height of the figure in inches. Default is 5.
#' 
#' @param orientation character. Orientation of the page, either "portrait" or "landscape". Default is "landscape".
#'  
#' @param margin numeric vector. The value sets left, right, top, bottom, header and footer margin in order.
#'   Default is \code{c(1, 1, 0.75, 0.75, 0.5, 0.5)}.
#' 
#' @param title_as_heading numeric. If non-missing, the table title will be inserted as a Word heading style.
#'   Expected input is a value of 1, 2, 3, or 4. Default is 2. If no title style desired, set to 0 
#'   or do not specify in the function call.
#'  
#' @param bookmark logical. If TRUE, a bookmark will be created in the RTF file with the same name as the 
#'   file (without extension).
#' 
#' @param bookmark_inc_title logical. If TRUE, the bookmark will be placed in the RTF file 
#'   such that the title of the table is included. Otherwise, the title is excluded. Default is FALSE.
#'   
#' @param output logical. If TRUE, the RTF file will be written to the location specified in \code{file_name}.
#'   Otherwise, the RTF object is returned. Default is TRUE.
#' 
#' @details \code{fig_to_rtf} creates a formatted RTF file from a figure input.
#'
#' @returns An RTF file, \code{file_name}.
#'
#' @examples
#' library(ggplot2)
#' plt <- ggplot(data    = mtcars, 
#'               mapping = aes(x=.data$mpg, y=.data$disp)) +
#'   geom_point() +
#'   theme_classic()
#' 
#' fig_to_rtf(plot_obj        = plt,
#'            file_name       = "MyFigure.rtf", 
#'            figure_title    = "Figure 1. My figure",
#'            footer_snapshot = "Analysis 2025", 
#'            path_program    = "C:\\\\program\\\\path\\\\code.r",
#'            path_output     = "C:\\\\output\\\\path\\\\MyFigure.rtf",
#'            fig_width       = 7, 
#'            fig_height      = 3.2,
#'            output          = FALSE)
#' 
#' 
#' @importFrom ggplot2 ggsave
#' @importFrom r2rtf rtf_read_figure rtf_figure
#'
#' @export
fig_to_rtf <- function(plot_obj, file_name, 
                       org, header_page, 
                       figure_title, 
                       footer_snapshot, path_program, path_output,
                       font_family=6,
                       font_size_header=10,
                       fig_width=5, fig_height=5,
                       orientation="landscape",
                       margin=c(1,1, 0.75, 0.75, 0.5, 0.5),
                       title_as_heading = 2,
                       bookmark=TRUE,
                       bookmark_inc_title=FALSE,
                       output=TRUE){
  
  #-----------------------------------------------------------------------------
  # Get call and check inputs
  #-----------------------------------------------------------------------------
  m  <- match.call()
  mn <- names(m)
  
  # Return error if required values not entered
  if(!"plot_obj" %in% mn) stop("Plot object 'plot_obj' is required.")
  if(!"file_name" %in% mn) stop("File save path 'file_name' is required.")  
  if(!"figure_title" %in% mn) stop("Figure title 'figure_title' is required.")  
  if(!"footer_snapshot" %in% mn) stop("Footer snapshot 'footer_snapshot' is required.")  
  if(!"path_program" %in% mn) stop("Path to program 'path_program' is required.")  
  
  # Check class
  if(!("ggplot" %in% class(plot_obj) | "recordedplot" %in% class(plot_obj))){
    stop("Plot object 'plot_obj' must be of class 'ggplot' or 'recordedplot'.")
  }
  
  # Return error if incorrect values entered
  if(!font_family %in% 1:10) stop("Invalid font_family entered. See r2rtf:::font_type() for valid options.")
  
  # Set-up defaults if not entered
  if(!"org" %in% mn) org <- ""
  if(!"header_page" %in% mn) header_page <- ""
  if(!"path_output" %in% mn) path_output <- gsub("\\", "\\\\", normalizePath(file_name,mustWork=FALSE), fixed=TRUE)

  #-----------------------------------------------------------------------------
  # Write figure to temp png
  #-----------------------------------------------------------------------------
  filename <- tempfile(fileext = ".png")
  ggsave(filename = filename, 
         plot     = plot_obj,
         width    = fig_width,
         height   = fig_height,
         units    = "in",
         dpi      = 300)
  
  #-----------------------------------------------------------------------------
  # Set-up page header
  #-----------------------------------------------------------------------------
  header_page <- c(paste0(org, " \\tab Page \\pagenumber of \\pagefield"),
                   header_page)
  
  # Get twips (1440 twips/inch) to right-align the page number in header
  hdr_margin <- ifelse(orientation == "portrait", 8.5, 11)-margin[1]-margin[2]
  hdr_twips  <- hdr_margin * 1440
  
  #-----------------------------------------------------------------------------
  # Set-up page footer
  #-----------------------------------------------------------------------------
  footer_line0  <- paste("Created on:",
                         toupper(paste(format(Sys.time(), "%d%b%Y %H:%M:%S %Z"))))
  footer_line_1 <- paste0("DB lock (snapshot): ", footer_snapshot,
                          " \\tab ",footer_line0)
  footer_line_2 <- paste0("Program name: ", path_program)
  footer_line_3 <- paste0("Output name: ", path_output)
  footer_page   <- c(footer_line_1, footer_line_2, footer_line_3)
  
  out <- rtf_read_figure(filename)
  
  out <- rtf_page(out,
                  orientation  = orientation,
                  col_width    = ifelse(orientation == "portrait", 6.5, 9),
                  margin       = margin,
                  border_first = "single", 
                  border_last  = "single",
                  nrow         = 1000) 
  
  out <- rtf_title(out,
                   title = figure_title, 
                   text_format="b", 
                   text_justification="l",
                   text_font = font_family)
  
  attr_title <- attr(out, "rtf_title")
  
  out <- rtf_page_header(out, 
                         text=header_page, 
                         text_font_size = font_size_header, 
                         text_justification="l",
                         text_font = font_family,
                         text_format = "b")
  
  out <- rtf_page_footer(out, 
                         text               = footer_page,
                         text_font_size     = font_size_header,
                         text_justification = "l",
                         text_convert       = FALSE,
                         text_font          = font_family,
                         text_format        = "b") 
  
  out <- rtf_figure(out,
                    fig_width = fig_width, 
                    fig_height = fig_height)
  
  out <- rtf_encode(out, doc_type = "figure") 
  
  if(title_as_heading %in% 1:4){
    # Check that title is bold, if not, raise error
    if(attr(attr_title, "text_format")[1] != "b") stop("Table title must be bold to insert as heading.")
    
    # Insert a stylesheet defining heading style
    out <- rtf_insert_stylesheet_headings(out)
    
    # Insert heading
    out <- rtf_insert_heading(out, heading_level=title_as_heading, caption = figure_title, font_family = font_family)  
  }
  
  # Insert tab stop in header to right-align page number
  out <- rtf_tabstop(out, twips=hdr_twips, type="header")
  
  # Insert tab stop in footer to right-align creation date
  out <- rtf_tabstop(out, twips=hdr_twips, type="footer")
  
  # Set-up bookmark
  if(bookmark){
    bookmark_name <- file_path_sans_ext(basename(file_name))
    out <- rtf_bookmark(out, bookmark_name, bookmark_inc_title)
  }
  
  if(output){
    write_rtf(out, file = file_name)  
  } else{
    return(out)
  }
}