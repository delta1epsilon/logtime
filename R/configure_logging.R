#' Configure logging options
#'
#' @param threshold_level a string. Defines threshold level for printing logs. Should be one of 'DEBUG', 'INFO', 'WARNING' or 'ERROR'. Default to 'DEBUG'.
#' @param output_file either a character string naming a file or a connection open for writing logs. By default logs are printed to console.
#'
#' @details
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
