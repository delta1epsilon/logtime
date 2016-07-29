#' Pipe operator for Context Manager
#'
#' @param lhs A function call which first argument is expression
#' @param rhs An expression
#'
#' @rdname pipe
#' @export
`%<%` <- function (lhs, rhs) {
    # the calling environment
    parent <- parent.frame()
    
    # the environment in which to evaluate pipeline
    env <- new.env(parent = parent)
    
    function_call <- match.call()
    
    # get expression
    expr <- function_call$rhs
    
    # get left function name
    func <- as.character(function_call$lhs)[1]
    
    # get left function arguments
    args <- as.character(function_call$lhs)[2]
    
    # run expression
    eval(do.call(func, list(expr, args)), envir = env)
}
