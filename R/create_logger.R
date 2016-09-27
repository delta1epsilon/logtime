#' Create a logger
#'
#' @param name A logger name
#' @param level A logging level. One of 'DEBUG', 'INFO', 'WARNING', 'ERROR'.
#' @param file A connection, or a character string naming the file to print to.
#'
#' @seealso \code{\link{configure_logging}}
#'
#' @export
#'
#' @examples
#' # create an object of class Logger with name 'clean_data' and
#' # default logging level INFO
#' logger <- create_logger(name = 'clean_data', level = 'INFO')
#'
#' # create log in context of logger
#' logger$log_message('Some text')
#'
#' # output:
#' # 2016-09-21 10:59:22.0 - [clean_data] - INFO - [Some text]
#'
#'
#' # create log with changed level to DEBUG in context of logger
#' logger$log_message('Some text', level = 'DEBUG')
#'
#' # output:
#' # 2016-09-21 11:00:04.1 - [clean_data] - DEBUG - [Some text]
#'
#'
#' # create logtime in context of logger
#' logger$log_time('Some text') %<% {
#'     Sys.sleep(1)
#' }
#'
#' # output:
#' # 2016-09-21 11:01:25.6 - [clean_data] - INFO - [Start] - [Some text]
#' # 2016-09-21 11:01:26.7 - [clean_data] - INFO - [End] - [Some text] -
#' #   [Done in 1 sec. (0 min.)]
#'
#'
#' # create logtime with changed level to DEBUG in context of logger
#' logger$log_time('Some text', level = 'DEBUG') %<% {
#'     Sys.sleep(1)
#' }
#'
#' # output:
#' # 2016-09-21 11:03:43.7 - [clean_data] - DEBUG - [Start] - [Some text]
#' # 2016-09-21 11:03:44.8 - [clean_data] - DEBUG - [End] - [Some text] -
#' #   [Done in 1 sec. (0 min.)]
#'
#'
create_logger <- function (name, level, file = '') {

    if (missing(level)) {
        level <- get_logging_level()
    }

    check_if_level_valid(level)

    logger <-
      list(log_time = create_log_time(start = on_start,
                                      end = on_end,
                                      level = level,
                                      logger_name = name,
                                      file = file
                                      ),
           log_message = create_log_function(level = level, logger_name = name, file = file)
           )

    class(logger) <- append(class(logger), 'Logger')
    return(logger)
}
