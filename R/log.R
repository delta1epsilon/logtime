#' Create log function
#'
#' 
createLogFunction <- function (...) {
    function (message) {
        options(digits.secs = 1)
        time <- format(Sys.time(), format = '%Y-%m-%d %H:%M:%OS')

        PrintLogMessage(message, time, ...)
    }
}

#' Print Log message
#'
#' @param message A string
#' @export
log <- createLogFunction()
