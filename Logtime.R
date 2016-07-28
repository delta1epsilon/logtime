#' Print starting log with message before execution of 
#' expresion in context of Logtime
#' 
#' @param msg A message to print in log
OnStart <- function (msg) {
    cat('Start', msg, '\n')
    start_time <<- Sys.time()
}


#' Print ending log with message and exec time after execution of 
#' expresion in context of Logtime
#'
#' @param msg A message to print in log
OnEnd <- function (msg) {
    cat('End', msg, '\n')
    exec_time <- Sys.time() - start_time
    cat('Done by', exec_time, '\n')
}


# Track time of code execution
Logtime <- ContextManager(start = OnStart, end = OnEnd)
