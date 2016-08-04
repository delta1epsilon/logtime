#' Create a Context Manager
#'
#' @param start A function to be executed on start
#' @param end A function to be executed on exit
#' 
#' @return A function
ContextManager <- function (start = function () {}, 
                            end = function () {}
                            ) {
    function (expr, env = parent.frame(), ...) {
        # parent <- parent.frame()

        # print('Parent:')
        # print(parent)

        # print('Parent of parent:')
        # print(parent.env(parent))

        # execute a function on start
        start(...)

        # execute a function on exit
        on.exit(end(...))

        # Evaluate the expression
        eval(expr, envir = env)
    }
}

# TODO: think about execution of end method when there is ERROR in expr execution
# TODO: think about execution in .GlobalEnv
