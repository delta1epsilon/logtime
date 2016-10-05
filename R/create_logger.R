#' Create a logger
#'
#' @description Create a logger object with two attributes log_time and log_message
#'
#' @param name A logger name
#' @param level A logging level. One of 'DEBUG', 'INFO', 'WARNING', 'ERROR'. Default to 'DEBUG'.
#' @param file Either a path to a file or a connection. By default logs are printed to console.
#'
#' @return Returns a list with two attributes log_time and log_message.
#' \code{\link{log_time}} alows to keep track of execution time in context of logger name reference and can handle nested calls.
#' \code{\link{log_message}} prints output message in context of logger.
#'
#' @details create_logger create a reference point in logging process. If it's level argument is higher or equal to threshold_level argument set inside \code{configure_logging},
#' the log will be printed to console or log file. If level is set to lower value than threshold_level is, log will not show up in the output.
#'
#' If file argument is specified it overwrites output_file configs defined inside configure_logging function.
#'
#' @note Both \code{log_time} and \code{log_message} are functions that be called directly without a need to create logger reference.
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
#'#2016-10-02 23:17:16.3 - [clean_data] - INFO - [Start] - [Data Preparation]
#'# 2016-10-02 23:17:16.3 - [clean_data] - INFO - [Start] - [Removing with NA]
#'# 2016-10-02 23:17:16.9 - [clean_data] - INFO - [End] - [Removing with NA] - [Done in 0.5 sec. (0 min.)]
#'# 2016-10-02 23:17:16.9 - [clean_data] - INFO - [Start] - [Transformig Data]
#'# 2016-10-02 23:17:17.9 - [clean_data] - INFO - [End] - [Transformig Data] - [Done in 1 sec. (0 min.)]
#'# 2016-10-02 23:17:17.9 - [clean_data] - INFO - [End] - [Data Preparation] - [Done in 1.5 sec. (0 min.)]
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
