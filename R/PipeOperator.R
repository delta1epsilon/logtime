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
    func_call <- as.list(func_call$lhs)
    # print('Arguments')
    # print(func_call)

    message <- func_call[[2]]
    # print('Message:')
    # print(message)

    if (is.name(message)) {  # check whether message is a variable
        message <- eval(message, envir = parent)
    }

    arguments <- list(expr, parent, message)

    # get level
    if (length(func_call) == 3) {
        arguments <- c(arguments, level = func_call[[3]])
    }

    # run expression
    output <-  # assign to dummy variable to avoid unnecessar output
        eval(do.call(func, arguments),
             envir = parent
             )
}
