#' Output a dataframe to a table in RTF with opinionated formatting.
#' 
#' \code{df_to_rtf} is a convenience wrapper around \code{r2rtf} functionality
#'   for outputting an RTF table, and optionally with at least one colspan in the column headers. 
#'
#' @param df data.frame. Dataframe to be output to RTF. Required.
#' 
#' @param file_name character. File path where the RTF file will be saved. Required.
#'   Strongly suggested to not include spaces in the file name to avoid issues with the bookmark functionality.
#'
#' @param header_page character. Header text for the page, typically the name of the study.
#' 
#' @param table_title character. Title of the table, the table caption. Required.
#' 
#' @param header_table0 character vector. Column spanning header for the table. Length of vector
#'   must be less than number of columns in \code{df}. Optional. 
#' 
#' @param header_table1 character vector. Column headers for the table. Length of vector
#'  must equal number of columns in \code{df}. Required.
#' 
#' @param col_widths0 numeric vector. Relative widths for the column spanning header.
#'   Optional. Only used if \code{header_table0} is entered. The total sum of 
#'   \code{col_widths0} must equal the total sum of \code{col_widths1}.
#' 
#' @param col_widths1 numeric vector. Relative widths for the column headers.
#' 
#' @param col_just0 character vector. Justification for the column spanning header.
#'   Optional. Only used if \code{header_table0} is entered.
#' 
#' @param col_just1 character vector. Justification for the column headers.
#' 
#' @param border_top1 character vector. Border style for the top border of each column header.
#'   Optional. Length of vector must equal number of columns in \code{df}.
#' 
#' @param footnote_table character vector. Footnotes for the table, if any.
#'
#' @param cell_indents numeric vector. Indentation for each cell in the table, in twips. Default
#'   is 0, no indentation. \code{cell_indents} must be a vector of length \code{nrow(df)*ncol(df)}.
#'   The first value controls the indentation of the cell at row 1, column 1; the second value
#'   controls the indentation of the cell at row 1, column 2; and so on.
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
#' @param font_size numeric. Font size for the body of the table, including table text,
#'   column headers, and table footnote. Default is 10.
#'   
#' @param font_size_header numeric. Font size for the header and footer text. Default is 10.
#'   
#' @param col_header_bg_color character. Background color for the column header rows, default is \code{"gray94"}. 
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
#' @details \code{df_to_rtf} creates a formatted RTF file from a data frame input with optional
#'   colspans in the column headers. See example for how to specify colspans. 
#'
#' @returns An RTF file, \code{file_name}.
#'
#' @examples
#' df <- data.frame(Col1="1", Col2="2", Col3="3", Col4="4", Col5="5")
#' 
#' # Example: simple table without colspans
#' df_to_rtf(df              = df,
#'           file_name       = "MyTable.rtf", 
#'           table_title     = "Table 1. My table",
#'           col_widths1     = c(3, 2, 2, 2, 2),
#'           col_just1       = c("l", "c", "c", "c", "c"),
#'           footer_snapshot = "Analysis 2025", 
#'           path_program    = "C:\\\\program\\\\path\\\\code.r",
#'           path_output     = "C:\\\\output\\\\path\\\\MyTable.rtf",
#'           output          = FALSE)
#' 
#' 
#' # Example: table with colspans
#' # - Cspan1 spans Col2 and Col3, Cspan2 spans Col4 and Col5
#' df_to_rtf(df              = df,
#'           file_name       = "MyColSpanTable.rtf", 
#'           table_title     = "Table 1. My table",
#'           header_table0   = c(" ", "Cspan1", "CSpan2"), 
#'           col_widths0     = c(3, 4, 4),
#'           col_widths1     = c(3, 2, 2, 2, 2),
#'           col_just0       = c("l", "c", "c"), 
#'           col_just1       = c("l", "c", "c", "c", "c"),
#'           footer_snapshot = "Analysis 2025", 
#'           path_program    = "C:\\\\program\\\\path\\\\code.r",
#'           path_output     = "C:\\\\output\\\\path\\\\MyColSpanTable.rtf",
#'           output          = FALSE)
#'
#' @importFrom r2rtf rtf_page rtf_page_header rtf_title rtf_colheader rtf_body rtf_footnote rtf_page_footer rtf_encode write_rtf
#' @importFrom tools file_path_sans_ext
#' 
#' @export
df_to_rtf <- function(df, file_name, org, header_page, table_title, 
                      header_table0, header_table1,
                      col_widths0,col_widths1,
                      col_just0, col_just1,border_top1,
                      footnote_table,cell_indents,
                      footer_snapshot, path_program, path_output,
                      font_family=6,
                      font_size=10,
                      font_size_header=10,
                      col_header_bg_color="gray94",
                      orientation="landscape",
                      margin=c(1,1, 0.75, 0.75, 0.5, 0.5),
                      title_as_heading=2,
                      bookmark=TRUE,
                      bookmark_inc_title=FALSE,
                      output=TRUE){
  
  #-----------------------------------------------------------------------------
  # Get call and check inputs
  #-----------------------------------------------------------------------------
  m  <- match.call()
  mn <- names(m)
  
  # Check if colspans were entered
  has_colspans <- "header_table0" %in% mn
  
  # Return error of required values not entered
  if(!"df" %in% mn) stop("Dataframe 'df' is required.")
  if(!"file_name" %in% mn) stop("File save path 'file_name' is required.")  
  if(!"table_title" %in% mn) stop("Table caption 'table_title' is required.")  
  if(!"footer_snapshot" %in% mn) stop("Footer snapshot 'footer_snapshot' is required.")  
  if(!"path_program" %in% mn) stop("Path to program 'path_program' is required.")  
  
  # Return error if incorrect values entered
  if(!font_family %in% 1:10) stop("Invalid font_family entered. See r2rtf:::font_type() for valid options.")
  
  # Set-up defaults if not entered
  if(!"org" %in% mn) org <- ""
  if(!"header_page" %in% mn) header_page <- ""
  if(!"header_table1" %in% mn) header_table1 <- names(df)
  if(!"col_widths1" %in% mn) col_widths1 <- rep(1, ncol(df))
  if(!"col_just1" %in% mn) col_just1 <- rep("l",length(col_widths1))
  if(!"border_top1" %in% mn) border_top1 <- rep("single",length(col_widths1))
  if(!"cell_indents" %in% mn) cell_indents <- rep(0,nrow(df)*ncol(df))
  if(!"footnote_table" %in% mn) footnote_table <- NULL
  if(!"path_output" %in% mn) path_output <- gsub("\\", "\\\\", normalizePath(file_name,mustWork=FALSE), fixed=TRUE)

  # Colspan-specific checks and defaults
  if(has_colspans){
    # Return error of required values not entered or entered incorrectly
    if(!"col_widths0" %in% mn) stop("Column widths for spanning header 'col_widths0' is required.")
    if(abs(sum(col_widths0) - sum(col_widths1)) > 1e-6) stop("Sum of 'col_widths0' must equal sum of 'col_widths1'.")  
    if(length(header_table0) > ncol(df)) stop("Length of 'header_table0' must be less than or equal to number of columns in 'df'.")
    
    # Set-up defaults if not entered
    if(!"col_just0" %in% mn) col_just0 <- rep("l",length(col_widths0))
  }
  
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
  
  out <- rtf_page(df,
                  orientation  = orientation,
                  col_width    = ifelse(orientation == "portrait", 6.5, 9),
                  margin       = margin,
                  border_first = "single", 
                  border_last  = "single",
                  nrow         = 1000) 
  
  out <- rtf_page_header(out, 
                         text=header_page, 
                         text_font_size = font_size_header, 
                         text_justification="l",
                         text_font = font_family,
                         text_format = "b")
  
  out <- rtf_title(out, 
                   title = table_title, 
                   text_format="b", 
                   text_justification="l",
                   text_font = font_family)
  
  attr_title <- attr(out, "rtf_title")
  
  if(has_colspans){
    out <- rtf_colheader(out, 
                         colheader = paste0(header_table0, collapse="|"),
                         col_rel_width = col_widths0,
                         text_format = "b",
                         text_font_size = font_size,
                         text_justification = col_just0,
                         text_background_color=col_header_bg_color,
                         text_font = font_family)
  }
  
  out <- rtf_colheader(out, 
                       colheader = paste0(header_table1, collapse="|"),
                       col_rel_width = col_widths1,
                       border_top = border_top1,
                       text_format = "b",
                       text_font_size = font_size,
                       text_justification = col_just1,
                       text_background_color=col_header_bg_color,
                       text_font = font_family)
  
  out <- rtf_body(out, 
                  col_rel_width = col_widths1,
                  text_indent_left=cell_indents,
                  text_font_size = font_size,
                  text_justification = col_just1,
                  border_top = "single",
                  border_bottom = "single",
                  text_font = font_family)
  
  if(!is.null(footnote_table)){
    out <- rtf_footnote(out,
                        text_font_size = font_size,
                        footnote = footnote_table,
                        text_font = font_family)
  }
  
  out <- rtf_page_footer(out, 
                         text               = footer_page,
                         text_font_size     = font_size_header,
                         text_justification = "l",
                         text_convert       = FALSE,
                         text_font          = font_family,
                         text_format        = "b") 
  
  out <- rtf_encode(out) 
  
  if(title_as_heading %in% 1:4){
    # Check that title is bold, if not, raise error
    if(attr(attr_title, "text_format")[1] != "b") stop("Table title must be bold to insert as heading.")
    
    # Insert a stylesheet defining heading style
    out <- rtf_insert_stylesheet_headings(out)
    
    # Insert heading
    out <- rtf_insert_heading(out, heading_level=title_as_heading, caption = table_title, font_family = font_family)  
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