# Print starting log with message before execution of
# expresion in context of logtime
#
# @param msg A message to print in log
# @param level A string, NULL by default
# @param ... pass aditional info to construct log ouput
on_start <- function (msg, level = NULL, ...) {
    time <- format(Sys.time(), format = '%Y-%m-%d %H:%M:%S')

    # save start time of execution to .Timing  environment
    # and get indentation level
    indentation_level <- set_start_time()

    log <- get_log(msg, time,
                   start_or_end = 'Start',
                   indentation_level = indentation_level,
                   level = level,
                   ...
                   )
   print_log(log, ...)
}


# Print ending log with message and exec time after execution of
# expresion in context of logtime
#
# @param msg A message to print in log
# @param level A string, NULL by default
# @param ... pass aditional info to construct log ouput
on_end <- function (msg, level = NULL, ...) {
    end_time <- Sys.time()

    time <- format(end_time, format = '%Y-%m-%d %H:%M:%S')

    # fetch start time of execurion
    # and indentation level
    time_indentation <- get_and_remove_start_time()
    start_time <- time_indentation$start_time
    indentation_level <- time_indentation$indentation

    # calculate execution time
    exec_time_sec <- difftime(end_time, start_time, units = 'secs')

    log <- get_log(msg, time,
                   start_or_end = 'End',
                   exec_time_sec = exec_time_sec,
                   indentation_level = indentation_level,
                   level = level,
                   ...
                   )
    print_log(log, ...)
}


#' Track time of code execution
#'
#' Time your code in easy, efficient and nice looking way
#'
#' @param message A string describing context of code. Can't be empty.
#' @param level A logging level. One of 'DEBUG', 'INFO', 'WARNING', 'ERROR'. Default is DEBUG.
#'
#' @return Start and end messages. Execution time appended to the end message.
#'
#' @seealso \code{\link{create_logger}}, \code{\link{\%<\%}}
#'
#' @details log_time has special call that requires using pipe operator  \code{\link{\%<\%}}. It can be useful when dealing with multiple complex steps of perocessing data (e.g. data munging, etc.)
#'
#' log_time is can handle nested calls and returns execution times of nested parts as well as overall execution time for the whole block
#'  which is not possible to do with system.time. Besides, it makes script a bit more organized and easier to read.
#'
#' By default, log_time will print messages to console. Use configure_logging to overwrite this behaviour. Another option is to use log_time in context of logger. See \code{\link{create_logger}} for more details.
#' Both messages have pattern: [date_time] - [reference (if called in logger context)] - [level] - [message] - [execution time (appear only in end message)]
#' Curently there is no native way to overwrite output style.
#'
#'
#' @examples
#'
#' # create a logtime with message 'Some text';
#' # default level is DEBUG
#' log_time('Some text') %<% {
#'    Sys.sleep(1)
#' }
#'
#' # output:
#' # 2016-09-21 10:54:31.8 - DEBUG - [Start] - [Some text]
#' # 2016-09-21 10:54:32.9 - DEBUG - [End] - [Some text] - [Done in 1 sec. (0 min.)]
#'
#'
#' # create the same logtime with changed level to INFO
#' log_time('Some text', level = 'INFO') %<% {
#'    Sys.sleep(1)
#' }
#'
#' # output:
#' # 2016-09-21 10:53:20.6 - INFO - [Start] - [Some text]
#' # 2016-09-21 10:53:21.6 - INFO - [End] - [Some text] - [Done in 1 sec. (0 min.)]
#'
#' @export
log_time <- create_log_time(start = on_start, end = on_end)
