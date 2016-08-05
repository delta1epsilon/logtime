#' Pipe operator for Context Manager
#'
#' @param lhs A function call which first argument is expression
#' @param rhs An expression
#'
#' @rdname pipe
#' @export
`%<%` <- function (lhs, rhs) {
    # get calling environment
    parent <- parent.frame()

    func_call <- match.call()
    
    # get expression
    expr <- as.expression(func_call$rhs)
    return_result <- CheckIfReturnExpr(expr)

    # get left function name
    func <- as.character(func_call$lhs)[1]    

    # get left function arguments
    message <- as.character(func_call$lhs)[2]  # A bug here with message as variable
    
    # run expression
    result <- eval(do.call(func, list(expr, parent, message)), 
                   envir = parent
                   )

    if (return_result) {
        return(result)
    }
}
