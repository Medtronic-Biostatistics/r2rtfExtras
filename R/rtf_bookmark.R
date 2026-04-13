#' Insert an RTF bookmark
#' 
#' \code{rtf_bookmark} inserts an RTF bookmark around the RTF body contents.
#'
#' @param rtf list. List with 3 elements created by \code{r2rtf::rtf_encode}.
#' 
#' @param bookmark character. Name of the bookmark to insert. This should be a unique name
#'   that does not contain spaces.
#' 
#' @param inc_title logical. If TRUE, the bookmark will include the table or figure title. 
#'   Otherwise, if FALSE, the title will omitted. Default is FALSE.
#'  
#' @details \code{rtf_bookmark} modifies the RTF to 
#'   insert bookmark start and end tags within the document. The bookmark start tag 
#'   is inserted either at the end of the RTF header (if \code{inc_title} is TRUE) 
#'   or immediately before the table/figure content in the body (if \code{inc_title} 
#'   is FALSE). The bookmark end tag is inserted at the beginning of the RTF end element.
#'
#' @returns The input RTF object with the modified start and end elements
#' 
#' @examples
#' # Create a simple RTF object
#' rtf <- list(
#'  start = "{\\rtf1\\ansi\\deff0{\\fonttbl{\\f0 Arial;}}",
#'  body = "{\\f0\\b This is the body of the RTF document.}",
#'  end = "}"
#'  )
#'  
#' # Insert the bookmark and capture all contents
#' rtf <- rtf_bookmark(rtf, 
#'                     bookmark  = "mybookmark", 
#'                     inc_title = TRUE)
#' 
#' @export
rtf_bookmark <- function(rtf, bookmark, inc_title=FALSE){
  # Input checks
  if(!"list" %in% class(rtf)) stop("Input 'rtf' must be of class 'list'.")
  if(length(rtf) != 3) stop("Input 'rtf' must be of length 3.")
  if(!all(names(rtf) == c("start","body","end"))) stop("Input 'rtf' must have elements start, body, and end.")
  
  if(inc_title){
    # Add bookmark start at end of rtf$start
    rtf$start <- paste0(rtf$start, "{\\*\\bkmkstart ", bookmark, "}")
  } else {
    # Add bookmark prior to table/figure in the body
    loc_fig <- gregexpr(pattern ='\\\\pict',rtf$body)[[1]][1]    
    loc_tab <- gregexpr(pattern ='\\\\trowd',rtf$body)[[1]][1]
    
    if(loc_fig != -1){
      rtf$body <- paste0(substr(rtf$body, 1, loc_fig-1), 
                         "{\\*\\bkmkstart ", bookmark, "}", 
                         substr(rtf$body, loc_fig, nchar(rtf$body)))      
    } else if(loc_tab != -1){
      rtf$body <- paste0(substr(rtf$body, 1, loc_tab-1), 
                         "{\\*\\bkmkstart ", bookmark, "}", 
                         substr(rtf$body, loc_tab, nchar(rtf$body)))
    } else {
      stop("Could not find figure or table content in RTF body to insert bookmark.")
    }
  }
  
  # Add bookmark end at beginning of rtf$end
  rtf$end <- paste0("{\\*\\bkmkend ", bookmark, "}\n", rtf$end)
  
  return(rtf)
}