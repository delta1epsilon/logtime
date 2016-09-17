#' Create a logger
#'
#' @param name A logger name
#' @param level A logging level. One of 'DEBUG', 'INFO', 'WARNING', 'ERROR'.
#' @param file A connection, or a character string naming the file to print to.
#' @export
#'
#' @examples
#' # create an object of class Logger with name 'clean_data' and
#' # default logging level INFO
#' logger <- createLogger(name = 'clean_data', level = 'INFO')
#'
#' # create log in context of logger
#' logger$log('Message 1')
#'
#' # output:
#' # 2016-09-16 16:33:55.9 - [clean_data] - INFO - [Some text]
#'
#'
#' # create log with changed level to DEBUG in context of logger
#' logger$log('Some text', level = 'DEBUG')
#'
#' # output:
#' # 2016-09-16 16:34:45.6 - [clean_data] - DEBUG - [Some text]
#'
#'
#' # create logtime in context of logger
#' logger$logtime('Some message') %<% {
#'     Sys.sleep(1)
#' }
#'
#' # output:
#' # 2016-09-16 16:35:33.0 - [clean_data] - INFO - [Start] - [Some message]
#' # 2016-09-16 16:35:34.0 - [clean_data] - INFO - [End] -
#' #   [Some message] - [Done by 1.01 sec. (0.02 min.)]
#'
#'
#' # create logtime with changed level to DEBUG in context of logger
#' logger$logtime('Some message', level = 'DEBUG') %<% {
#'     Sys.sleep(1)
#' }
#'
#' # output:
#' # 2016-09-16 16:37:21.4 - [clean_data] - DEBUG - [Start] - [Some message]
#' # 2016-09-16 16:37:22.4 - [clean_data] - DEBUG - [End] -
#' #   [Some message] - [Done by 1.01 sec. (0.02 min.)]
#'
#'
createLogger <- function (name, level, file = '') {
    CheckIfLevelValid(level)

    logger <-
      list(logtime = ContextManager(start = OnStart,
                                    end = OnEnd,
                                    level = level,
                                    logger_name = name,
                                    file = file
                                    ),
           log = createLogFunction(level = level,
                                   logger_name = name,
                                   file = file
                                   )
           )

    class(logger) <- append(class(logger), 'Logger')
    return(logger)
}
