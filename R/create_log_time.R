#' Create log_time function
#'
#' @param start A function to be executed on start
#' @param end A function to be executed on exit
#'
#' @return A function
create_log_time <- function (start = function () {},
                             end = function () {},
                             level = 'DEBUG',
                             ...
                             ) {
    logger_level = level

    function (expr, env = parent.frame(), message, level = logger_level) {
        check_if_level_valid(level)

        # execute a function on start
        start(message, level, ...)

        # Evaluate the expression
        output <-  # assign to dummy variable to avoid unnecessar output
            eval(expr, envir = env)

        end(message, level, ...)
    }
}
