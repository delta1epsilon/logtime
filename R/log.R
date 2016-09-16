#' Create log function
#'
#'
createLogFunction <- function (level = 'DEBUG', ...) {
    logger_level = level

    function (message, level = logger_level) {
        options(digits.secs = 1)
        time <- format(Sys.time(), format = '%Y-%m-%d %H:%M:%OS')

        PrintLogMessage(message, time, level, ...)
    }
}

#' Print Log message
#'
#' @param message A string
#' @export
log <- createLogFunction()
