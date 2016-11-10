#' Create a logger
#'
#' @description Create an object of class 'Logger' with two attributes \code{log_time} and \code{log_message}
#'
#' @param name A logger name
#' @param level A logging level. One of 'DEBUG', 'INFO', 'WARNING', 'ERROR'. Default to 'DEBUG'.
#' @param file Either a path to a file or a connection. By default logs are printed to console.
#'
#' @return 
#' An object of class 'Logger' - list with two attributes \code{log_time} and \code{log_message}.
#' \code{\link{log_time}} allows to track execution time in context of logger.
#' \code{\link{log_message}} prints log message in context of logger.
#'
#' @details 
#' \code{create_logger} creates a reference point in logging process. If it's level argument is higher or equal to threshold_level argument set inside \code{configure_logging},
#' the log will be printed to console or log file, otherwise a log will not show up in the output.
#'
#' NOTE that if file argument is specified, it overwrites output_file config defined inside \code{configure_logging} function.
#'
#' @note Both \code{log_time} and \code{log_message} are functions that can be called directly without a need to create 'logger' reference.
#'
#' @seealso \code{\link{configure_logging}}, \code{\link{log_time}}, \code{\link{log_message}}
#'
#' @export
#'
#' @examples
#' # create an object of class 'Logger' with name 'clean_data' and default logging level INFO
#' logger <- create_logger(name = 'clean_data', level = 'INFO')
#'
#' # create log in context of logger 'clean_data':
#' logger$log_message('Some text')
#' # 2016-09-21 10:59:22 - [clean_data] - INFO - [Some text]
#'
#' # or track execution time in context of logger clean_data':
#' logger$log_time('Cleaning') %<% {
#'      logger$log_time('Removing NA') %<% {
#'          # code to remvoe NA
#'          Sys.sleep(0.5)
#'      }
#'
#'      logger$log_time('Transforming') %<% {
#'          # code to transform data
#'          Sys.sleep(1)
#'      }
#' }
#'# 2016-10-02 23:17:16 - [clean_data] - INFO - [Start] - [Cleaning]
#'#  2016-10-02 23:17:16 - [clean_data] - INFO - [Start] - [Removing NA]
#'#  2016-10-02 23:17:16 - [clean_data] - INFO - [End] - [Removing NA] - [Done in 0.5 sec. (0 min.)]
#'#  2016-10-02 23:17:16 - [clean_data] - INFO - [Start] - [Transforming]
#'#  2016-10-02 23:17:17 - [clean_data] - INFO - [End] - [Transforming] - [Done in 1 sec. (0 min.)]
#'# 2016-10-02 23:17:17 - [clean_data] - INFO - [End] - [Cleaning] - [Done in 1.5 sec. (0 min.)]
create_logger <- function (name, level, file = '') {
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
