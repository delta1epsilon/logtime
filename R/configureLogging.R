#' Configure logging options
#'
#' @param level A logging level. One of  'DEBUG' or 'INFO'. Default is 'DEBUG'
#' @param file A connection, or a character string naming the file to print to.
#'
#' @examples
#'
#' # set logging level to INFO
#' configureLogging(level = 'INFO')
#'
#' @export
configureLogging <- function (level = 'DEBUG', file = '') {
    SetLoggingLevel(level = level)
    SetLoggingFile(file = file)
}
