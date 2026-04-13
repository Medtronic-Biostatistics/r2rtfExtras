#' Insert a right-aligned tab stop in the first line of an RTF page header or footer
#' 
#' \code{rtf_tabstop} inserts a tabstop into the first line of an RTF page header or footer.
#'
#' @param rtf list. List with 3 elements created by \code{r2rtf::rtf_encode}.
#' 
#' @param twips integer. The position of the tab stop in twips (1440 twips per inch).
#' 
#' @param type character. Either "header" or "footer", indicating whether to modify
#'   the page header or footer.
#'  
#' @details \code{rtf_tabstop} is an internal function that modifies the RTF body to 
#'   insert a right-aligned tabstop. It is assumed that the first line of the header 
#'   or footer already contains a tab character, as is expected, i.e., the first line of the 
#'   header should be the name of the organization followed by a tab character and the page 
#'   number field. The first line of the footer should be the data (snapshot) information 
#'   followed by a tab character and the date of creation.
#'
#' @returns The input RTF object with the modified body
#' 
#' @examples
#' # Create a simple RTF object with a header that includes a tab stop
#' rtf <- list(
#'   start = "{\\rtf1\\ansi\\deff0{\\fonttbl{\\f0 Arial;}}",
#'   body = "{\\header\n{\\pard{Header Left \\tab Header Right}\\par}\n}{\\f0\\b RTF text.}",
#'   end = "}"
#'   )
#'  
#' # Insert the tabstop
#' rtf <- rtf_tabstop(rtf, 
#'                    twips = 9360, 
#'                    type = "header")
#' 
#' @export
rtf_tabstop <- function(rtf, twips, type="header"){
  # Input checks
  if(!"list" %in% class(rtf)) stop("Input 'rtf' must be of class 'list'.")
  if(length(rtf) != 3) stop("Input 'rtf' must be of length 3.")
  if(!all(names(rtf) == c("start","body","end"))) stop("Input 'rtf' must have elements start, body, and end.")
  if(!type %in% c("header","footer")) stop("Input 'type' must be either 'header' or 'footer'.")
  
  rtf_body <- rtf$body
  
  # Set up string to replace and replace text
  rtf_text_repl <- sprintf("\\%s\n{\\pard",type)  
  rtf_text      <- paste0(rtf_text_repl, "\\tqr\\tx", twips) 
  rtf_body      <- gsub(rtf_text_repl, rtf_text, rtf_body, fixed=TRUE)
  rtf$body      <- rtf_body
  return(rtf)
}