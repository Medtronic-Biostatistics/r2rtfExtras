#' Insert Stylesheet for Heading into an RTF file
#' 
#' \code{rtf_insert_stylesheet_headings} inserts a stylesheet defining heading   
#'   levels 1 through 4 into an RTF file created by \code{r2rtf::rtf_encode}. 
#'
#' @param rtf list. List with 3 elements created by \code{r2rtf::rtf_encode}. The list 
#'   must have elements named start, body, and end.
#'  
#' @details \code{rtf_insert_stylesheet_headings} inserts into an RTF a stylesheet that 
#'   defines heading levels. 
#'
#' @returns The input RTF object with the stylesheet added.
#' 
#' @examples
#' # Create a simple RTF object
#' rtf <- list(
#'  start = "{\\rtf1\\ansi\\deff0{\\fonttbl{\\f0 Arial;}}",
#'  body = "{\\f0\\b This is the body of the RTF document.}",
#'  end = "}"
#'  )
#'  
#' # Insert the stylesheet for headings
#' rtf_insert_stylesheet_headings(rtf)
#' 
#' @export
rtf_insert_stylesheet_headings <- function(rtf){
  # Input checks
  if(!"list" %in% class(rtf)) stop("Input 'rtf' must be of class 'list'.")
  if(length(rtf) != 3) stop("Input 'rtf' must be of length 3.")
  if(!all(names(rtf) == c("start","body","end"))) stop("Input 'rtf' must have elements start, body, and end.")

  # Define style sheet through heading level 4
  stylesheet <- "\n{\\stylesheet{\\s1 heading 1;}
{\\s2 heading 2;}
{\\s3 heading 3;}
{\\s4 heading 4;}
}\n\n"
  
  # Insert stylesheet at end of rtf$start
  rtf_start <- rtf$start
  rtf_start <- paste(rtf_start, stylesheet)
  rtf$start <- rtf_start
  return(rtf)
}




  