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

    # get left function name
    func <- as.character(func_call$lhs)[1]
    eval(parse(text = paste("func <-", func)))  # a fix for logger$logtime

    # get left function arguments
    message <- as.list(func_call$lhs)[[2]]

    if (is.name(message)) {  # check whether message is a variable
        message <- eval(message, envir = parent)
    }

    # run expression
    output <-  # assign to dummy variable to avoid unnecessar output
        eval(do.call(func, list(expr, parent, message)),
             envir = parent
             )
}
