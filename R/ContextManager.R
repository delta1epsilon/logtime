#' Create a Context Manager
#'
#' @param start A function to be executed on start
#' @param end A function to be executed on exit
#' 
#' @return A function
ContextManager <- function (start = function () {}, 
                            end = function () {}
                            ) {
    function (expr, env = parent.frame(), message) {
        # execute a function on start
        start(message)

        # execute a function on exit
        on.exit(end(message))

        # Evaluate the expression
        output <- eval(expr, envir = env)
    }
}

# TODO: think about execution of end method when there is ERROR in expr execution
# TODO: think about execution in .GlobalEnv
