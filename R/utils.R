# create environment for the package use
.RTiming <- new.env()

#' Check if return result
#'
#' Check if a result from expression execution has to be returned
#'
#' @param expr An expression
#' @return TRUE if return / FALSE if dont
CheckIfReturnExpr <- function (expr) {
    expr <- as.character(expr)

    # split by lines
    expr <- unlist(strsplit(expr, split = '\n'))

    len <- length(expr)

    return_result <- TRUE
    if (expr[len] == '}') {
        if (grepl('(<-)|(=)', expr[len - 1])) {
            return_result <- FALSE

            if (grepl('(==)', expr[len - 1])) {
                return_result <- TRUE
            }
        }
    } else {
        if (grepl('(<-)|(=)', expr[len])) {
            return_result <- FALSE

            if (grepl('(==)', expr[len])) {
                return_result <- TRUE
            }
        }
    }

    return(return_result)
}
