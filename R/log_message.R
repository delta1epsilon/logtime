#' Create log function
#'
#' @param level A default logging level for log function
#' @param ... Aditionla argumets passed to log output
#'
#' @return a function
create_log_function <- function (level = 'DEBUG', ...) {
    logger_level = level

    function (message, level = logger_level) {
        check_if_level_valid(level)

        options(digits.secs = 1)
        time <- format(Sys.time(), format = '%Y-%m-%d %H:%M:%OS')

        print_log_message(message, time, level, ...)
    }
}

#' Create log message
#'
#' @param message A string
#' @param level A logging level. One of 'DEBUG', 'INFO', 'WARNING', 'ERROR'. Default is 'DEBUG'.
#' @return Prints message to console or file. This can be controlled with \code{configure_logging} or \code{create_logger} if \code{log_message} is used inside logger context.
#'
#' @seealso \code{\link{log_time}}
#'
#' @examples
#'
#' # create a log with message 'Some text'
#' log_message('Some text')  # default level is DEBUG
#'
#' # output:
#' # 2016-09-21 10:55:18.8 - DEBUG - [Some text]
#'
#'
#' # create the same log with changed level to INFO
#' log_message('Some text', level = 'INFO')
#'
#' # output:
#' # 2016-09-21 10:55:38.0 - INFO - [Some text]
#'
#' @export
log_message <- create_log_function()
