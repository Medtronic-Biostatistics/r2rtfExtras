#' Transform RTF Title to Heading
#' 
#' \code{rtf_insert_heading} transforms the RTF title into a specified heading style.
#'
#' @param rtf list. List with 3 elements created by \code{r2rtf::rtf_encode}.
#' 
#' @param heading_level integer. The heading level to apply to the title (1, 2, 3, or 4).
#' 
#' @param caption character. The title already present in the RTF.
#' 
#' @param font_family integer. The font family number used in the RTF.
#'  
#' @details \code{rtf_insert_heading} modifies the RTF body to change the title 
#'   into the specified heading style. Note that a stylesheet 
#'   with defined heading level must be present and the title must be bold.
#'
#' @returns The input RTF object with the modified body
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
#' rtf <- rtf_insert_stylesheet_headings(rtf)
#' 
#' # Insert heading level 2
#' rtf <- rtf_insert_heading(rtf, 
#'                           heading_level = 2, 
#'                           caption = "This is the body of the RTF document.", 
#'                           font_family = 1)
#' 
#' @export
rtf_insert_heading <- function(rtf, heading_level, caption, font_family){
  # Input checks
  if(!"list" %in% class(rtf)) stop("Input 'rtf' must be of class 'list'.")
  if(length(rtf) != 3) stop("Input 'rtf' must be of length 3.")
  if(!all(names(rtf) == c("start","body","end"))) stop("Input 'rtf' must have elements start, body, and end.")
  if(!heading_level %in% 1:4) stop("Heading level must have a value of 1, 2, 3, or 4.")
  if(!any(grepl("stylesheet", rtf))) stop("RTF must have a stylesheet defined.")
  
  head_style <- paste0("\\s", heading_level)
  
  # Check that head_level is defined in the stylesheet
  if(!grepl(head_style, rtf$start)){
    msg_hl <- sprintf("RTF must have an s%s style defined.", heading_level) 
    stop(msg_hl)
  }
  
  rtf_body <- rtf$body
  
  # Set up string to replace and replace text
  rtf_text_repl <- paste0("{\\f", font_family-1, "\\b ", caption)  
  rtf_text      <- paste0(head_style, rtf_text_repl)  
  rtf_body      <- gsub(rtf_text_repl, rtf_text, rtf_body, fixed=TRUE)
  rtf$body      <- rtf_body
  return(rtf)
}
