#' Print starting log with message before execution of
#' expresion in context of logtime
#'
#' @param msg A message to print in log
#' @param level A string, NULL by default
#' @param ... pass aditional info to construct log ouput
on_start <- function (msg, level = NULL, ...) {
    options(digits.secs = 1)
    time <- format(Sys.time(), format = '%Y-%m-%d %H:%M:%OS')

    # save start time of execution to .Timing  environment
    # and get indentation level
    indentation_level <- set_start_time()

    print_logtime_message(msg, time,
                          start_or_end = 'start',
                          indentation_level = indentation_level,
                          level = level,
                          ...
                          )
}


#' Print ending log with message and exec time after execution of
#' expresion in context of logtime
#'
#' @param msg A message to print in log
#' @param level A string, NULL by default
#' @param ... pass aditional info to construct log ouput
on_end <- function (msg, level = NULL, ...) {
    end_time <- Sys.time()

    options(digits.secs = 1)
    time <- format(end_time, format = '%Y-%m-%d %H:%M:%OS')

    # fetch start time of execurion
    # and indentation level
    time_indentation <- get_and_remove_start_time()
    start_time <- time_indentation$start_time
    indentation_level <- time_indentation$indentation

    # calculate execution time
    exec_time_sec <- difftime(end_time, start_time, units = 'secs')

    print_logtime_message(msg, time,
                          start_or_end = 'end',
                          exec_time_sec = exec_time_sec,
                          indentation_level = indentation_level,
                          level = level,
                          ...
                          )
}


#' Track time of code execution in easy, efficient and nice looking way
#' @description NULL
#' @param message A string describing context of code. Can't be empty.
#' @param level A logging level. One of 'DEBUG', 'INFO', 'WARNING', 'ERROR'. Default is DEBUG.
#'
#' @return Start and end messages. Execution time is appended to the end message.
#'
#' Pattern for start msg: [Date Time] - [Logger Name (if called in logger context)] - [Level] - [Start] - [Message]
#'
#' Pattern for end msg: [Date Time] - [Logger Name (if called in logger context)] - [Level] - [End] - [Message] - [Execution Time]
#'
#' @seealso \code{\link{create_logger}}, \code{\link{\%<\%}}
#'
#' @details  \code{log_time} can be called dicetly with or without reference point created with \code{create_logger} function.
#' The only difference is in output message.
#' If called directly, the block that reprent reference point is empty otherwise it will contain the logger name.
#'
#' \code{log_time} can handle nested calls and returns execution times of nested parts as well as overall execution time for the whole block
#'  which is not possible to do with system.time. Besides, it makes script much more organized and easier to read.
#'
#' By default, log_time will print messages to console. This can be overwritten by \code{configure_logging} or, if used inside logger context, by \code{create_logger} function.
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
