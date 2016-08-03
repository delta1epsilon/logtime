#' Pipe operator for Context Manager
#'
#' @param lhs A function call which first argument is expression
#' @param rhs An expression
#'
#' @rdname pipe
#' @export
`%<%` <- function (lhs, rhs) {
    func_call <- match.call()
    
    # get expression
    .ExecutionEnv$expr <- as.expression(func_call$rhs)
    return_result <- CheckIfReturnExpr(.ExecutionEnv$expr)

    # get left function name
    .ExecutionEnv$func <- as.character(func_call$lhs)[1]    

    # get left function arguments
    .ExecutionEnv$args <- as.character(func_call$lhs)[2]
    
    # run expression
    result <- evalq(do.call(func, list(expr, args)), envir = .ExecutionEnv)

    if (return_result) {
        return(result)
    }
}
