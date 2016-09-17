#' Create log function
#'
#' @param level A default logging level for log function
createLogFunction <- function (level = 'DEBUG', ...) {
    logger_level = level

    function (message, level = logger_level) {
        CheckIfLevelValid(level)

        options(digits.secs = 1)
        time <- format(Sys.time(), format = '%Y-%m-%d %H:%M:%OS')

        PrintLogMessage(message, time, level, ...)
    }
}

#' Print Log message
#'
#' Create log message with specific level
#'
#' @usage log(message, level = 'DEBUG')
#'
#' @param message A string
#' @param level A logging level. One of 'DEBUG', 'INFO', 'WARNING', 'ERROR'. Default is 'DEBUG'.
#' @return Prints a message
#'
#'
#' @examples
#'
#' # create a log with message 'Some text'
#' log('Some text')  # default level is DEBUG
#'
#' # output:
#' # 2016-09-16 16:17:20.9 - DEBUG - [Some text]
#'
#'
#' # create the same log with changed level to INFO
#' log('Some text', level = 'INFO')
#'
#' # output:
#' # 2016-09-16 16:18:00.5 - INFO - [Some text]
#'
#' @export
log <- createLogFunction()
