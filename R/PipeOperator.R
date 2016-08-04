#' Pipe operator for Context Manager
#'
#' @param lhs A function call which first argument is expression
#' @param rhs An expression
#'
#' @rdname pipe
#' @export
`%<%` <- function (lhs, rhs) {
    parent <- parent.frame()

    func_call <- match.call()
    
    # get expression
    expr <- as.expression(func_call$rhs)
    return_result <- CheckIfReturnExpr(expr)

    # get left function name
    func <- as.character(func_call$lhs)[1]    

    # get left function arguments
    args <- as.character(func_call$lhs)[2]
    
    # run expression
    result <- eval(do.call(func, list(expr, parent, args)), 
                    envir = parent
                    )

    if (return_result) {
        return(result)
    }
}
