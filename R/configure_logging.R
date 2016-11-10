#' Configure logging options
#'
#' @param threshold_level Defines threshold level for printing logs.
#' Should be one of 'DEBUG', 'INFO', 'WARNING' or 'ERROR'. Default to 'DEBUG'.
#' It defines which logs should be printed. It prints logs which have level higher or equal to threshold_level.
#' The hierarchy is 'DEBUG' < 'INFO' < 'WARNING' < 'ERROR'.
#' @param output_file Either a path to a file or a connection. With default settings "" logs are printed to console.
#'
#' @details \code{configure_logging} sets global behaviour for logging and acts as a filter of how detailed logs should appear in the output.
#'
#' @seealso \code{\link{create_logger}}
#' @examples
#'
#' # set logging threshold level to INFO
#' configure_logging(threshold_level = 'INFO')
#'
#' # set logging threshold level to WARNING and
#' # set writing all logs to 'log.log' file
#' configure_logging(threshold_level = 'WARNING', output_file = 'log.log')
#'
#' @export
#'
configure_logging <- function (threshold_level = 'DEBUG', output_file = '') {
    set_logging_level(level = threshold_level)
    set_logging_file(file = output_file)
}
