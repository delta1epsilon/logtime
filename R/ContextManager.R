#' Check if return result
#'
#' Check if a result from expression execution has to be returned 
#'
#' @param expr An expression
#' @result TRUE if return / FALSE if dont 
#'
CheckIfReturnExpr <- function (expr) {
    expr <- as.character(expr)
    
    # split by lines
    expr <- unlist(strsplit(expr, split = '\n'))

    len <- length(expr)

    # TODO: add check for =

    if (expr[len] == '}') {
        is_assign <- grepl('<-', expr[len - 1])        
    } else {
        is_assign <- grepl('<-', expr[len])
    }
    
    return(!is_assign)
}


#' Create a Context Manager
#'
#' @param start A function to be executed on start
#' @param end A function to be executed on exit
#' 
#' @return A function
ContextManager <- function (start = function () {}, 
                            end = function () {}
                            ) {
    function (expr, ...) {
        # execute a function on start
        start(...)
        
        # execute a function on exit
        on.exit(end(...))
        
        return_result <- CheckIfReturnExpr(expr)

        # Evaluate the expression
        result <- eval(expr)

        if (return_result) {
            return(result)
        }
    }
}

# TODO: think about an output of Logtime when return is not specified
# TODO: think about execution of end method when there is ERROR in expr execution
