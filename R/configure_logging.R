#' Configure logging options
#'
#' @param threshold_level a string. Defines threshold level for printing logs. Should be one of 'DEBUG', 'INFO', 'WARNING' or 'ERROR'. Default to 'DEBUG'.
#' @param output_file either a character string naming a file or a connection open for writing logs. By default logs are printed to console.
#'
#' @details \code{configure_logging} sets global behaviour for logging with logtime package. Basically is a filter of how detailed logs appear in output.
#'
#' threshold_level - defines the lowes level that appears in log output. Possible levels are 'DEBUG', 'INFO', 'WARNING' and 'ERROR' and form a kind of hierarchy with lowest level 'DEBUG'.
#' If set to 'INFO' every log with level 'INFO' or higher will be in output and log with 'DEBUG' level will not show up. This can be rely useful when there is a need to shorten log output.
#'
#' output_file tells where to store logs. By default prints to console. If file path is given, all loging information is apended unless owerwritten in \code{create_logger} function.
#'
#' @seealso \code{\link{create_logger}}
#' @examples
#'
#' # set logging threshold level to INFO
#' configure_logging(threshold_level = 'INFO')
#'
#' @export
#'
configure_logging <- function (threshold_level = 'DEBUG', output_file = '') {
    set_logging_level(level = threshold_level)
    set_logging_file(file = output_file)
}
