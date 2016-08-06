#' Print starting log with message before execution of 
#' expresion in context of Logtime
#' 
#' @param msg A message to print in log
OnStart <- function (msg) {
    options(digits.secs = 1)
    time <- format(Sys.time(), format = '%Y-%m-%d %H:%M:%OS')
    
    # save start time of execution to .RTiming  environment
    # and get indentation level
    indentation_level <- SetStartTime()

    # print log message
    indent_string <- paste(rep(' ', indentation_level), collapse = ' ')
    cat(indent_string, time, '[Start]', paste0('[', msg, ']'), sep = ' - ', fill = TRUE)
}


#' Print ending log with message and exec time after execution of 
#' expresion in context of Logtime
#'
#' @param msg A message to print in log
OnEnd <- function (msg) {
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
    exec_time_min <- round(exec_time_sec / 60, 2)

    # execution time message
    exec_time_msg <- 
        paste0('[Done by ', round(exec_time_sec, 2), 
               ' sec. ', '(', exec_time_min, ' min.',')', ']'
               )

    # print log message
    indent_string <- paste(rep(' ', indentation_level), collapse = ' ')
    cat(indent_string, time, '[End]', paste0('[', msg, ']'), exec_time_msg, sep = ' - ', fill = TRUE)
}


#' Track time of code execution
#'
#' Time your code in easy, efficient and nice looking way
#'
#' @usage Logtime(message) \%<\% \{
#'    expression
#' \}
#'
#' @param message A string describing context of code 
#' 
#' @return Prints 2 log messages with start, end of code execution and time of code execution  
#' 
#' @examples 
#' gauss_random <- Logtime('Generate random numbers') %<% {
#'      rnorm(10000000) 
#' }
#' 
#' # prints:
#' # 2016-07-29 18:04:15.4 - [Start] - [Generate random numbers]
#' # 2016-07-29 18:04:18.9 - [End] - [Generate random numbers] - [Done by 3.48 sec. (0.06 min.)]
#'
#' @export
Logtime <- ContextManager(start = OnStart, end = OnEnd)
