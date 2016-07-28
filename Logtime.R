#'
#'
#'
#'
OnStart <- function (x) {
    cat('Start', x, '\n')
    start_time <<- Sys.time()
}


#'
#'
#'
#'
OnEnd <- function (x) {
    cat('End', x, '\n')
    exec_time <- Sys.time() - start_time
    cat('Done by', exec_time, '\n')
}


# Track time of code execution
Logtime <- ContextManager(start = OnStart, end = OnEnd)
