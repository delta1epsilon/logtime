#' Print starting log with message before execution of 
#' expresion in context of Logtime
#' 
#' @param msg A message to print in log
OnStart <- function (msg) {
    options(digits.secs = 1)
    time <- format(Sys.time(), format = '%Y-%m-%d %H:%M:%OS')
    
    # print log message
    cat(time, '[Start]', paste0('[', msg, ']'), sep = ' - ', fill = TRUE)

    # save start time of execution to .RTiming  environment
    assign('start_time', Sys.time(), envir = .RTiming)
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
    start_time <- get('start_time', envir = .RTiming)
    
    # calculate execution time
    exec_time_sec <- difftime(end_time, start_time, units = 'secs')
    exec_time_min <- round(exec_time_sec / 60, 2)

    # execution time message
    exec_time_msg <- 
        paste0('[Done by ', round(exec_time_sec, 2), 
               ' sec. ', '(', exec_time_min, ' min.',')', ']'
               )

    # print log message
    cat(time, '[End]', paste0('[', msg, ']'), exec_time_msg, sep = ' - ', fill = TRUE)
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
#' @return Prints 2 log messages with start, end of code execution and prints time of code execution  
#' 
#' @examples 
#' Logtime('Generate random numbers') %<% {
#'      rnorm(10000) 
#' }
#' 
#' # output:
#' #
#'
#'
#' @export
Logtime <- ContextManager(start = OnStart, end = OnEnd)
