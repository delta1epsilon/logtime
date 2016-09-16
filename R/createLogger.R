#' Create a logger
#'
#' @param name A string
#' @param file A connection, or a character string naming the file to print to.
#' @export
createLogger <- function (name, level, file = '') {
    logger <-
      list(logtime = ContextManager(start = OnStart, end = OnEnd, logger_name = name, file = file),
           log = createLogFunction(level = level, logger_name = name, file = file)
           )

    class(logger) <- append(class(logger), 'Logger')
    return(logger)
}
