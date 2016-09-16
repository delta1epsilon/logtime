#' Print starting log with message before execution of
#' expresion in context of logtime
#'
#' @param msg A message to print in log
OnStart <- function (msg, level = NULL, ...) {
    options(digits.secs = 1)
    time <- format(Sys.time(), format = '%Y-%m-%d %H:%M:%OS')

    # save start time of execution to .RTiming  environment
    # and get indentation level
    indentation_level <- SetStartTime()

    PrintLogtimeMessage(msg, time,
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
OnEnd <- function (msg, level = NULL, ...) {
    end_time <- Sys.time()

    options(digits.secs = 1)
    time <- format(end_time, format = '%Y-%m-%d %H:%M:%OS')

    # fetch start time of execurion
    # and indentation level
    time_indentation <- GetAndRemoveStartTime()
    start_time <- time_indentation$start_time
    indentation_level <- time_indentation$indentation

    # calculate execution time
    exec_time_sec <- difftime(end_time, start_time, units = 'secs')

    PrintLogtimeMessage(msg, time,
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
#' @usage logtime(message, level = 'DEBUG') \%<\% \{
#'    expression
#' \}
#'
#' @param message A string describing context of code
#' @param level A logging level. One of 'INFO' or 'DEBUG'. Default is DEBUG.
#'
#' @return Prints 2 log messages with start, end of code execution and time of code execution
#'
#' @examples
#'
#' # create a logtime with message 'Some text';
#' # default level is DEBUG
#' logtime('Some text') %<% {
#'    Sys.sleep(1)
#' }
#'
#' # output:
#' # 2016-09-16 16:19:29.8 - DEBUG - [Start] - [Some text]
#' # 2016-09-16 16:19:30.8 - DEBUG - [End] -
#' #  [Some text] - [Done by 1 sec. (0.02 min.)]
#'
#'
#' # create the same logtime with changed level to INFO
#' logtime('Some text', level = 'INFO') %<% {
#'    Sys.sleep(1)
#' }
#'
#' # output:
#' # 2016-09-16 16:24:15.7 - INFO - [Start] - [Some message]
#' # 2016-09-16 16:24:16.7 - INFO - [End] -
#' #  [Some message] - [Done by 1 sec. (0.02 min.)]
#'
#' @export
logtime <- ContextManager(start = OnStart, end = OnEnd)
