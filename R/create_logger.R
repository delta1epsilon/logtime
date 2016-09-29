#' Create a logger
#'
#' create_logger creates an obgect of class 'logger' with two methods log_time and log_message.
#'
#' @param name A logger name
#' @param level A logging level. One of 'DEBUG', 'INFO', 'WARNING', 'ERROR'. Default to 'DEBUG'
#' @param file either a character string naming a file or a connection open for writing logs. By default logs are printed to console.
#'
#' @return an obgect of class 'logger' - list containing two components:
#'  \code{log_time} function that alows to treck execution time (see Details)
#'  \code{log_message} a prints custom message in context of logger
#'
#' @details create_logger create a reference point in logging process and consists of two methods:
#'  \code{log_time} and \code{log_message}. log_time alows to keep track of execution time in context of logger name reference and can handle nested calls.
#'
#'  log_time is can handle nested calls and returns execution times of nested parts as well as overall execution time for the whole block
#'  which is not possible to do with system.time. Besides, it makes script a bit more organized and easier to read.
#'
#' log_message is a wrapper to cat but can be heandy when used in context of loger.
#'
#' Both log_time and log_message can be called directly without a need to create logger reference. In this scenario log_time can be useful when used in intereactive analysis.
#'
#' @note \code{log_time} function should be called with custom pipe operator `%<%` that differes from one defined in magrittr package.
#'
#' @seealso \code{\link{configure_logging}}, \code{\link{log_time}}, \code{\link{log_message}}
#'
#' @export
#'
#' @examples
#' # create an object of class Logger with name 'clean_data' and default logging level INFO
#' logger <- create_logger(name = 'clean_data', level = 'INFO')
#'
#' # create log in context of logger 'clean_data':
#' logger$log_message('Some text')
#' # example output:
#' # 2016-09-21 10:59:22 - [clean_data] - INFO - [Some text]
#'
#' # or track execution time in context of logger clean_data':
#' logger$log_time('Data Preparation') %<% {
#'      logger$log_time('Removing with NA') %<% {
#'          # code to remvoe NA
#'          Sys.sleep(0.5)
#'      }
#'
#'      logger$log_time('Transformig Data') %<% {
#'          # code to transform data
#'          Sys.sleep(1)
#'      }
#' }
#'


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


