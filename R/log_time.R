#' Print starting log with message before execution of
#' expresion in context of logtime
#'
#' @param msg A message to print in log
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


#' Track time of code execution
#'
#' Time your code in easy, efficient and nice looking way
#'
#' @usage log_time(message, level = 'DEBUG') \%<\% \{
#'    expression
#' \}
#'
#' @param message A string describing context of code
#' @param level A logging level. One of 'DEBUG', 'INFO', 'WARNING', 'ERROR'. Default is DEBUG.
#'
#' @return Prints 2 log messages with start, end of code execution and time of code execution
#'
#' @seealso \code{\link{log_message}}
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
