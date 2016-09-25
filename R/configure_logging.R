#' Configure logging options
#'
#' @param threshold_level A threshold logging level for printing logs. One of 'DEBUG', 'INFO', 'WARNING', 'ERROR'. Default is 'DEBUG'.
#' @param output_file A connection, or a character string naming the file to print to. By default all logs are being printed to console.
#'
#' @examples
#'
#' # set logging threshold level to INFO
#' configure_logging(threshold_level = 'INFO')
#'
#' @export
configure_logging <- function (threshold_level = 'DEBUG', output_file = '') {
    set_logging_level(level = threshold_level)
    set_logging_file(file = output_file)
}
