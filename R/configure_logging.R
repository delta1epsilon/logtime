#' Configure logging options
#'
#' @param level A logging level. One of 'DEBUG', 'INFO', 'WARNING', 'ERROR'. Default is 'DEBUG'
#' @param file A connection, or a character string naming the file to print to.
#'
#' @examples
#'
#' # set logging level to INFO
#' configure_logging(level = 'INFO')
#'
#' @export
configure_logging <- function (level = 'DEBUG', file = '') {
    set_logging_level(level = level)
    set_logging_file(file = file)
}
