
# Track time of code execution
Logtime <- 
    ContextManager(start = function (x) {
                            cat('Start', x, '\n')
                            start_time <<- Sys.time()
                        },
                   end = function (x) {
                            cat('End', x, '\n')
                            exec_time <- Sys.time() - start_time
                            cat('Done by', exec_time, '\n')
                       }
                   )

Logtime({
    length(rnorm(500))
    }, 
    'Shit'
    )


Logtime({
    a <- rnorm(500)
    }, 
    'Shit'
    )

a <- Logtime('Generate some shit') %<% {
    rnorm(500)
}


a <- 
    Logtime('Calculate length of x') %<% {
        a <- length(x)
        cat('Length', a, '\n')
        cat('shitttttt', '\n')
        
        return(a)
    }

